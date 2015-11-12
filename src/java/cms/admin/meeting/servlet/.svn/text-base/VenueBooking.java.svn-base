package cms.admin.meeting.servlet;

import cms.admin.meeting.EMeetingQuery;
import cms.admin.meeting.bean.MeetingVenue;
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

import tvo.TvoBean;
import tvo.TvoDBConnectionPoolFactory;
import utilities.ResourceUtil;

/**
 * @web.servlet name = "mtgvenuebkg"
 * @web.servlet-mapping url-pattern = "/mtgvenuebkg"
 */
public class VenueBooking extends HttpServlet
{
  String mtgCode = null;
  String roomCode = null;
  String mtgDate = null;
  String mtgStartTime = null;
  String mtgEndTime = null;
  String errorMssg = "ERROR";
  String staffID = null;
  String resourceSeq = null;

  public void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws IOException, ServletException
  {
    int i = 1;
    HttpSession localHttpSession = paramHttpServletRequest.getSession(true);

    String str1 = (String)localHttpSession.getAttribute("AMW001");

    this.mtgCode = ((String)localHttpSession.getAttribute("meetingCode"));

    this.roomCode = paramHttpServletRequest.getParameter("roomCode");
    this.mtgDate = paramHttpServletRequest.getParameter("mtgDate");
    this.mtgStartTime = paramHttpServletRequest.getParameter("mtgStartTime");
    this.mtgEndTime = paramHttpServletRequest.getParameter("mtgEndTime");
    this.staffID = paramHttpServletRequest.getParameter("staffID");

    localHttpSession.removeAttribute("errmsg");

    if ((this.mtgCode == null) || (this.mtgCode.length() == 0)) {
      this.errorMssg = "The meeting unique id is not available.";
      i = 0;
    }

    if ((i != 0) && (((this.roomCode == null) || (this.roomCode.length() == 0)))) {
      this.errorMssg = "Venue ID is not specified.";
      i = 0;
    }

    if ((i != 0) && (((this.mtgDate == null) || (this.mtgDate.length() == 0)))) {
      this.errorMssg = "Date of the meeting is not specified.";
      i = 0;
    }

    if ((i != 0) && (((this.mtgStartTime == null) || (this.mtgStartTime.length() == 0)))) {
      this.errorMssg = "Start time of the meeting is not specified.";
      i = 0;
    }

    if ((i != 0) && (((this.mtgEndTime == null) || (this.mtgEndTime.length() == 0)))) {
      this.errorMssg = "End time of the meeting is not specified.";
      i = 0;
    }

    if (i != 0)
    {
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
            localMeetingVenue.setDBConnection(localConnection);

            this.resourceSeq = localMeetingVenue.queryResourceSeq(this.roomCode);

            ResourceUtil localResourceUtil = new ResourceUtil();
            boolean bool = localResourceUtil.hasConflict(localConnection, this.roomCode, this.mtgStartTime, this.mtgEndTime);
            String str2 = null;

            if (!(bool))
            {
              String str3 = localResourceUtil.checkApproval(this.roomCode);
              String str4 = CommonFunction.getDate("dd-mm-yyyy", "yyyy-mm-dd", this.mtgStartTime);
              String str5 = CommonFunction.getDate("dd-mm-yyyy", "yyyy-mm-dd", this.mtgEndTime);
              if ((str3.equals("Y")) && (this.resourceSeq != null))
              {
                str2 = localResourceUtil.insertData1("STAFF", this.resourceSeq, str4, str5, this.staffID, "E-Meeting");
              }
              else
              {
                str2 = localResourceUtil.insertData2("STAFF", this.resourceSeq, str4, str5, this.staffID, "E-Meeting");
              }

              if (str2 != null)
              {
                localMeetingVenue.setMtgCode(this.mtgCode);
                localMeetingVenue.setRoomCode(this.roomCode);
                localMeetingVenue.setBkgDate(this.mtgDate);
                localMeetingVenue.setBkgStartTime(this.mtgStartTime);
                localMeetingVenue.setBkgEndTime(this.mtgEndTime);
                localMeetingVenue.setResourceRecordID(str2);

                if (localMeetingVenue.bookVenue()) {
                  i = 1;
                }
                else
                {
                  i = 0;
                  this.errorMssg = " Meeting Venue Not Added Succesfully";
                }

              }
              else
              {
                i = 0;
                this.errorMssg = " Meeting Venue Not Added Succesfully";
              }

            }
            else
            {
              i = 0;
              this.errorMssg = "Resource Conflict";
            }

          }
          else
          {
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