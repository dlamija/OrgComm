package cms.admin.meeting.servlet;

import cms.admin.meeting.bean.MeetingMinutes;
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
 * @web.servlet name = "addMinutes"
 * @web.servlet-mapping url-pattern = "/addMinutes"
 */
public class NewMinutes extends HttpServlet
{
  String mtgMinutes = null;
  String meetingCode = null;
  String errorMssg = null;
  private DBConnectionPool dbPool;

  public void doGet(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws ServletException, IOException
  {
    doPost(paramHttpServletRequest, paramHttpServletResponse);
  }

  public void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws IOException, ServletException
  {
    int i = 1;
    HttpSession localHttpSession = paramHttpServletRequest.getSession(true);

    this.meetingCode = paramHttpServletRequest.getParameter("meetingCode");
    this.mtgMinutes = paramHttpServletRequest.getParameter("mtgMinutes");

    localHttpSession.removeAttribute("errmsg");

    if ((this.meetingCode == null) || (this.meetingCode.length() == 0)) {
      this.errorMssg = "No Meeting Code";
      i = 0;
    }

    if ((this.mtgMinutes == null) || (this.mtgMinutes.length() == 0)) {
      this.errorMssg = "No Meeting Minutes given";
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
          MeetingMinutes localMeetingMinutes = (MeetingMinutes)localHttpSession.getAttribute("minutes");
          if (localMeetingMinutes == null) {
            localMeetingMinutes = (MeetingMinutes)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingMinutes");

            localHttpSession.setAttribute("minutes", localMeetingMinutes);
          }

          if (localMeetingMinutes != null)
          {
            localMeetingMinutes.setDBConnection(localConnection);
            localMeetingMinutes.setMeetingCode(this.meetingCode);
            localMeetingMinutes.setMinutes(this.mtgMinutes);
            localMeetingMinutes.setCreatedBy((String)localHttpSession.getAttribute("staffid"));

            if (localMeetingMinutes.addMinutes()) {
              i = 1;
            }
            else {
              i = 0;
              this.errorMssg = localMeetingMinutes.getErrorMessage();
            }
          }
          else {
            i = 0;
            this.errorMssg = "Meeting minute object is not available.";
          }

          localConnection.close();
        } else {
          i = 0;
          this.errorMssg = "Connection to database is not available";
        }
      }
      catch (Exception localException)
      {
        localException.printStackTrace();
        localHttpSession.setAttribute("errmsg", localException.toString());
        i = 0;
      }
    }

    if (i != 0)
      paramHttpServletResponse.sendRedirect(paramHttpServletRequest.getHeader("Referer"));
    else
      CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, this.errorMssg, paramHttpServletRequest.getHeader("Referer"));
  }
}