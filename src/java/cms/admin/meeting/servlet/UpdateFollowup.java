package cms.admin.meeting.servlet;

import cms.admin.meeting.bean.MeetingFollowup;
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

import tvo.TvoDBConnectionPoolFactory;

/**
 * @web.servlet name = "updfollowup"
 * @web.servlet-mapping url-pattern = "/updfollowup"
 */
public class UpdateFollowup extends HttpServlet
{
  String mtgCode = null;
  String errorMssg = null;
  String followupSeq = null;
  String decisionSeq = null;
  String followup = null;

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

    String str1 = (String)localHttpSession.getAttribute("AMW001");

    String str2 = paramHttpServletRequest.getParameter("action");

    System.out.println("actionType" + str2);

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
          MeetingFollowup localMeetingFollowup = (MeetingFollowup)localHttpSession.getAttribute("mtgnotes");
          if (localMeetingFollowup == null) {
            localMeetingFollowup = (MeetingFollowup)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingFollowup");

            localHttpSession.setAttribute("mtgfollowup", localMeetingFollowup);
          }

          if (localMeetingFollowup != null)
          {
            localMeetingFollowup.setDBConnection(localConnection);
            localMeetingFollowup.setDecisionSeq(this.decisionSeq);
            localMeetingFollowup.setFollowupSeq(this.followupSeq);
            localMeetingFollowup.setFollowup(this.followup);

            String str3 = (String)localHttpSession.getAttribute("agendaMtgCode");

            String str4 = paramHttpServletRequest.getParameter("action");

            if (str4.equals("Update"))
            {
              if (localMeetingFollowup.updateMtgFollowup()) {
                i = 1;
              } else {
                i = 0;
                this.errorMssg = "Update Not Successful";
                localHttpSession.setAttribute("errmsg", localMeetingFollowup.getErrorMessage() + localMeetingFollowup.getSQL());
              }

            }
            else if (str4.equals("Remove"))
            {
              if (localMeetingFollowup.removeMtgFollowup(this.followupSeq))
              {
                i = 1;
              } else {
                this.errorMssg = "Delete not Successful";
                i = 0;
              }
            }
          }
          else {
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
        this.errorMssg = "Error";
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

    if (i != 0) {
      paramHttpServletResponse.sendRedirect(paramHttpServletRequest.getHeader("Referer"));
    } else {
      if ((this.errorMssg.equals(null)) || (this.errorMssg.length() == 0))
        this.errorMssg = "Error!";
      CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, this.errorMssg, paramHttpServletRequest.getHeader("Referer"));
    }
  }
}