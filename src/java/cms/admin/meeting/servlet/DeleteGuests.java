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
 * @web.servlet name = "deleteguest"
 * @web.servlet-mapping url-pattern = "/deleteguest"
 */
public class DeleteGuests extends HttpServlet
{
  String[] guestIDs = null;
  String errorMssg = "ERROR";
  String meetingCode = null;

  public void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws IOException, ServletException
  {
    int i = 1;
    HttpSession localHttpSession = paramHttpServletRequest.getSession(true);

    String str = (String)localHttpSession.getAttribute("AMW001");

    this.guestIDs = paramHttpServletRequest.getParameterValues("guestIDs");
    this.meetingCode = ((String)localHttpSession.getAttribute("meetingCode"));

    localHttpSession.removeAttribute("errmsg");

    if (this.guestIDs == null) {
      this.errorMssg = "No Guests Are Selected For Delete.";
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

          localMeetingGuest.setDBConnection(localConnection);

          for (int j = 0; j < this.guestIDs.length; ++j)
          {
            if ((this.guestIDs[j] == null) || (this.guestIDs[j].length() <= 0)) {
              continue;
            }
            if (localMeetingGuest.removeGuest(this.guestIDs[j], this.meetingCode))
            {
              i = 1;
            }
            else {
              i = 0;
              this.errorMssg = "Meeting Guest Not Deleted Successfully";
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
      CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, "Delete Successful", "eMeeting.jsp?action=deleteGuest&meetingCode=" + this.meetingCode);
    else
      CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, this.errorMssg, "eMeeting.jsp?action=deleteGuest&meetingCode=" + this.meetingCode);
  }
}