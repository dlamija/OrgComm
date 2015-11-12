package cms.admin.meeting.servlet;

import cms.admin.meeting.EMeetingQuery;
import cms.admin.meeting.bean.Meeting;
import cms.admin.meeting.bean.MeetingAgenda;
import cms.admin.meeting.bean.MeetingAttendance;
import cms.admin.meeting.bean.MeetingDecision;
import cms.admin.meeting.bean.MeetingGuest;
import cms.admin.meeting.bean.MeetingVenue;
import java.beans.Beans;
import java.io.IOException;
import java.sql.Connection;
import javax.servlet.GenericServlet;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.CommonFunction;
import common.DBConnectionPool;
import common.TvoContextManager;

import tvo.TvoBean;
import tvo.TvoDBConnectionPoolFactory;

/**
 * @web.servlet name = "deleteMeeting"
 * @web.servlet-mapping url-pattern = "/deleteMeeting"
 */
public class DeleteMeeting extends HttpServlet
{
  String[] eMeetingIDs = null;
  String errorMssg = "ERROR";
  String cmsID = null;

  public void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws IOException, ServletException
  {
    int i = 1;
    HttpSession localHttpSession = paramHttpServletRequest.getSession(true);

    String str1 = (String)localHttpSession.getAttribute("AMW001");

    this.eMeetingIDs = paramHttpServletRequest.getParameterValues("eMeetingIDs");
    this.cmsID = paramHttpServletRequest.getParameter("cmsID");

    localHttpSession.removeAttribute("errmsg");

    if (this.eMeetingIDs == null) {
      this.errorMssg = "No Meetings Are Selected For Delete.";
      i = 0;
    }

    if (i != 0) {
      Connection localConnection = null;
      try
      {
        DBConnectionPool localDBConnectionPool = TvoDBConnectionPoolFactory.getConnectionPool(paramHttpServletRequest);
        localConnection = localDBConnectionPool.getConnection();

        String str2 = (String)TvoContextManager.getSessionAttribute(paramHttpServletRequest, "Login.userID");
        ServletContext localServletContext = super.getServletContext();
        EMeetingQuery localEMeetingQuery = new EMeetingQuery();
        localEMeetingQuery.initTVO(paramHttpServletRequest);

        if (localConnection != null)
        {
          MeetingAttendance localMeetingAttendance1 = (MeetingAttendance)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingAttendance");

          MeetingVenue localMeetingVenue = (MeetingVenue)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingVenue");

          MeetingAttendance localMeetingAttendance2 = (MeetingAttendance)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingAttendance");

          MeetingGuest localMeetingGuest = (MeetingGuest)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingGuest");

          MeetingAgenda localMeetingAgenda = (MeetingAgenda)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingAgenda");

          MeetingDecision localMeetingDecision = (MeetingDecision)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingDecision");

          Meeting localMeeting = (Meeting)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.Meeting");

          localMeetingAttendance1.setDBConnection(localConnection);
          localMeetingVenue.setDBConnection(localConnection);
          localMeetingAttendance2.setDBConnection(localConnection);
          localMeetingGuest.setDBConnection(localConnection);
          localMeetingAgenda.setDBConnection(localConnection);
          localMeetingDecision.setDBConnection(localConnection);
          localMeeting.setDBConnection(localConnection);

          for (int j = 0; j < this.eMeetingIDs.length; ++j)
          {
            if ((this.eMeetingIDs[j] == null) || (this.eMeetingIDs[j].length() <= 0)) {
              continue;
            }
            localEMeetingQuery.deleteMeetingAppt(localServletContext, str2, this.eMeetingIDs[j]);

            if (localMeetingVenue.cancelBooking(this.eMeetingIDs[j], this.cmsID))
            {
              i = 1;
            }
            else {
              i = 0;
              this.errorMssg = "Venue Not Deleted Successfully";
              break;
            }

            if (localMeetingAttendance1.removeAttendee(this.eMeetingIDs[j]))
            {
              i = 1;
            }
            else
            {
              i = 0;
              this.errorMssg = "Attendees Not Deleted Successfully";
              break;
            }

            if (localMeetingGuest.removeGuest(this.eMeetingIDs[j]))
            {
              i = 1;
            }
            else
            {
              i = 0;
              this.errorMssg = "Guests Not Deleted Successfully";
              break;
            }

            if (!(localMeetingAgenda.queryMtgAgenda(this.eMeetingIDs[j])))
              continue;
            while (localMeetingAgenda.nextMtgAgenda())
            {
              String str3 = localMeetingAgenda.getAgendaSeq();

              if (localMeetingDecision.removeMtgDecision(paramHttpServletRequest, super.getServletContext(), str3.trim()))
              {
                i = 1;
              }
              else
              {
                i = 0;
                this.errorMssg = "Decision Not Deleted Successfully";
                break;
              }

              if (i != 1)
                continue;
              if (localMeetingAgenda.removeMtgAgenda(this.eMeetingIDs[j]))
              {
                i = 1;

                String str4 = TvoContextManager.getRealPath(localServletContext, paramHttpServletRequest, "/eMeeting/" + this.eMeetingIDs[j]);

                CommonFunction.delFileTree(str4);
              }
              else
              {
                i = 0;
                this.errorMssg = " Agenda Not Deleted Successfully";
                break;
              }

            }

            if (localMeeting.removeMeeting(this.eMeetingIDs[j]))
            {
              i = 1;
            }
            else
            {
              i = 0;

              break;
            }

          }

          localConnection.close();
        } else {
          i = 0;
          this.errorMssg = "Connection to database is not available.";
        }
      }
      catch (Exception localException1) {
        localException1.printStackTrace();
        localHttpSession.setAttribute("errmsg", localException1.toString());
        i = 0;
      } finally {
        if (localConnection != null) {
          try {
            localConnection.close();
          } catch (Exception localException2) {
            localException2.printStackTrace();
          }
        }

      }

    }

    if (i != 0)
    {
      paramHttpServletResponse.sendRedirect(paramHttpServletRequest.getHeader("Referer"));
    }
    else CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, this.errorMssg, paramHttpServletRequest.getHeader("Referer"));
  }
}