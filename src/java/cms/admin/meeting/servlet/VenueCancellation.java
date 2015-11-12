package cms.admin.meeting.servlet;

import cms.admin.meeting.EMeetingQuery;
import cms.admin.meeting.bean.MeetingVenue;
import java.beans.Beans;
import java.io.IOException;
import java.io.PrintStream;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.CommonFunction;
import common.DBConnectionPool;

import tvo.TvoBean;
import tvo.TvoDBConnectionPoolFactory;
import utilities.ResourceUtil;

/**
 * @web.servlet name = "mtgvenuecancel"
 * @web.servlet-mapping url-pattern = "/mtgvenuecancel"
 */
public class VenueCancellation extends HttpServlet
{
  String mtgCode = null;
  String roomBkgSeq = null;
  String roomCode = null;
  String errorMssg = null;
  String resourceRecordID = null;
  String staffID = null;

  public void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws IOException, ServletException
  {
    int i = 1;
    HttpSession localHttpSession = paramHttpServletRequest.getSession(true);

    String str1 = (String)localHttpSession.getAttribute("AMW001");

    this.mtgCode = ((String)localHttpSession.getAttribute("meetingCode"));
    this.roomCode = paramHttpServletRequest.getParameter("roomCode");
    this.resourceRecordID = paramHttpServletRequest.getParameter("resourceRecordID");
    this.staffID = paramHttpServletRequest.getParameter("staffID");

    localHttpSession.removeAttribute("errmsg");

    if ((this.mtgCode == null) || (this.mtgCode.length() == 0)) {
      this.errorMssg = "The meeting unique id is not available.";
      i = 0;
    }

    if (i != 0) {
      try
      {
        DBConnectionPool localDBConnectionPool = TvoDBConnectionPoolFactory.getConnectionPool(paramHttpServletRequest);
        Connection localConnection = localDBConnectionPool.getConnection();

        if (localConnection != null)
        {
          MeetingVenue localMeetingVenue = (MeetingVenue)paramHttpServletRequest.getAttribute("mtgvenue");
          if (localMeetingVenue == null) {
            localMeetingVenue = (MeetingVenue)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingVenue");

            paramHttpServletRequest.setAttribute("mtgvenue", localMeetingVenue);
          }

          if (localMeetingVenue != null)
          {
            ResourceUtil localResourceUtil = new ResourceUtil();
            String str2 = localResourceUtil.cancelResource(this.staffID, this.resourceRecordID);
            System.out.println("message" + str2);
            if (str2.equals(""))
            {
              localMeetingVenue.setDBConnection(localConnection);
              localMeetingVenue.setMtgCode(this.mtgCode);

              if (localMeetingVenue.cancelBooking(this.mtgCode, this.roomCode)) {
                i = 1;
              } else {
                i = 0;
                this.errorMssg = "Meeting Venue Cannot Be Cancel";
              }

            }
            else
            {
              i = 0;
              this.errorMssg = "Meeting Venue Cannot Be Cancel";
            }
          }
          else {
            i = 0;
            this.errorMssg = "Meeting Venue object is not available.";
          }

          localConnection.close();
        } else {
          i = 0;
          this.errorMssg = "Connection to database is not available.";
        }
      }
      catch (Exception localException)
      {
        localException.printStackTrace();
        localHttpSession.setAttribute("errmsg", localException.toString());
        i = 0;
      }

    }

    if (i != 0) {
      EMeetingQuery localEMeetingQuery = new EMeetingQuery();
      localEMeetingQuery.initTVO(paramHttpServletRequest);
      localEMeetingQuery.setMeetingApptDirty(this.mtgCode);
    }

    if (i != 0)
      paramHttpServletResponse.sendRedirect(paramHttpServletRequest.getHeader("Referer"));
    else
      CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, this.errorMssg, paramHttpServletRequest.getHeader("Referer"));
  }
}