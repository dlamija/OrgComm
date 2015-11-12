package cms.admin.meeting.servlet;

import cms.admin.meeting.bean.MeetingGuest;
import java.beans.Beans;
import java.io.IOException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.CommonFunction;
import common.DBConnectionPool;

import tvo.TvoDBConnectionPoolFactory;

/**
 * @web.servlet name = "updguest"
 * @web.servlet-mapping url-pattern = "/updguest"
 */
public class UpdateGuest extends HttpServlet
{
  String guestName = null;
  String guestTitle = null;
  String guestFrom = null;
  String guestRemark = null;
  String guestPasswd = null;
  String errorMssg = null;
  String guestEmail = null;
  String guestID = null;
  String meetingCode = null;

  public void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws IOException, ServletException
  {
    int i = 1;
    HttpSession localHttpSession = paramHttpServletRequest.getSession(true);

    String str = (String)localHttpSession.getAttribute("AMW001");

    this.guestName = paramHttpServletRequest.getParameter("guestName");
    this.guestTitle = paramHttpServletRequest.getParameter("guestTitle");
    this.guestFrom = paramHttpServletRequest.getParameter("guestFrom");
    this.guestRemark = paramHttpServletRequest.getParameter("guestRemark");
    this.guestPasswd = paramHttpServletRequest.getParameter("guestPasswd");
    this.guestEmail = paramHttpServletRequest.getParameter("guestEmail");
    this.guestID = paramHttpServletRequest.getParameter("guestID");
    this.meetingCode = paramHttpServletRequest.getParameter("meetingCode");

    localHttpSession.removeAttribute("errmsg");

    if (this.guestName == null) {
      this.errorMssg = "The guest name is not specified";
      i = 0;
    }

    if (i != 0) {
      Connection localConnection = null;
      try
      {
        DBConnectionPool localDBConnectionPool = TvoDBConnectionPoolFactory.getConnectionPool(paramHttpServletRequest);
        localConnection = localDBConnectionPool.getConnection();

        if (localConnection != null)
        {
          MeetingGuest localMeetingGuest = (MeetingGuest)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingGuest");

          if (localMeetingGuest != null)
          {
            localMeetingGuest.setDBConnection(localConnection);
            localMeetingGuest.setGuestName(this.guestName);
            localMeetingGuest.setGuestTitle(this.guestTitle);
            localMeetingGuest.setGuestFrom(this.guestFrom);
            localMeetingGuest.setGuestRemark(this.guestRemark);
            localMeetingGuest.setPasswd(this.guestPasswd);
            localMeetingGuest.setGuestEmail(this.guestEmail);
            localMeetingGuest.setGuestId(this.guestID);

            if (localMeetingGuest.updateGuest(this.guestID, (String)localHttpSession.getAttribute("meetingCode"))) {
              i = 1;
            } else {
              i = 0;
              this.errorMssg = localMeetingGuest.getErrorMessage();
            }
          }
          else
          {
            i = 0;
            this.errorMssg = "Meeting Guest object is not available.";
          }

          localConnection.close();
        } else {
          i = 0;
          this.errorMssg = "Connection to database is not available.";
        }
      }
      catch (Exception localException1)
      {
        localHttpSession.setAttribute("errmsg", localException1.toString());
        i = 0;
      } finally {
        if (localConnection != null)
          try {
            localConnection.close();
          }
          catch (Exception localException2) {
          }
      }
    }
    if (i != 0)
      CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, "Update Successful", "eMeeting.jsp?action=editGuest&meetingCode=" + this.meetingCode);
    else
      CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, this.errorMssg, paramHttpServletRequest.getHeader("Referer"));
  }
}