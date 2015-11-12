package cms.admin.meeting.servlet;

import cms.admin.meeting.bean.MeetingFollowup;
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
 * @web.servlet name = "addfollowup"
 * @web.servlet-mapping url-pattern = "/addfollowup"
 */
public class NewFollowup extends HttpServlet
{
  String mtgCode = null;
  String errorMssg = null;
  String followupSeq = null;
  String decisionSeq = null;
  String followup = null;

  public void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws IOException, ServletException
  {
    int i = 1;
    HttpSession localHttpSession = paramHttpServletRequest.getSession(true);

    String str1 = (String)localHttpSession.getAttribute("AMW001");

    this.followupSeq = paramHttpServletRequest.getParameter("followupSeq");
    this.decisionSeq = paramHttpServletRequest.getParameter("decisionSeq");
    this.followup = paramHttpServletRequest.getParameter("followup");
    this.mtgCode = paramHttpServletRequest.getParameter("meetingCode");

    localHttpSession.removeAttribute("errmsg");

    if ((this.followup == null) || (this.followup.length() == 0)) {
      this.errorMssg = "The followup is not specified.";
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
          MeetingFollowup localMeetingFollowup = (MeetingFollowup)localHttpSession.getAttribute("mtgfollowup");
          if (localMeetingFollowup == null) {
            localMeetingFollowup = (MeetingFollowup)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingFollowup");

            localHttpSession.setAttribute("mtgfollowup", localMeetingFollowup);
          }

          if (localMeetingFollowup != null)
          {
            localMeetingFollowup.setDBConnection(localConnection);
            localMeetingFollowup.setDecisionSeq(this.decisionSeq);
            localMeetingFollowup.setFollowup(this.followup);

            String str2 = (String)localHttpSession.getAttribute("agendaMtgCode");

            if (localMeetingFollowup.addMtgFollowup(this.decisionSeq))
            {
              i = 1;
            } else {
              i = 0;
              this.errorMssg = localMeetingFollowup.getErrorMessage() + localMeetingFollowup.getSQL();
            }
          }
          else
          {
            i = 0;
            this.errorMssg = "Meeting Followup object is not available.";
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
      paramHttpServletResponse.sendRedirect(paramHttpServletRequest.getHeader("Referer"));
    else
      CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, this.errorMssg, paramHttpServletRequest.getHeader("Referer"));
  }
}