package cms.admin.meeting.servlet;

import cms.admin.meeting.bean.MeetingDecisionActionProgress;
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
 * @web.servlet name = "adddecisionactionprogress"
 * @web.servlet-mapping url-pattern = "/adddecisionactionprogress"
 */
public class NewDecisionActionProgress extends HttpServlet
{
  String mtgCode = null;
  String errorMssg = "ERROR";
  String actionSeq = null;
  String progressSeq = null;
  String progress = null;
  String progressDate = null;
  String actionBy = null;
  String dateKeyIn = null;

  public void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws IOException, ServletException
  {
    int i = 1;
    HttpSession localHttpSession = paramHttpServletRequest.getSession(true);

    String str = (String)localHttpSession.getAttribute("AMW001");

    this.actionSeq = paramHttpServletRequest.getParameter("actionSeq");
    this.progressSeq = paramHttpServletRequest.getParameter("progressSeq");
    this.progress = paramHttpServletRequest.getParameter("progress");
    this.mtgCode = paramHttpServletRequest.getParameter("meetingCode");
    this.progressDate = paramHttpServletRequest.getParameter("progressDate");
    this.actionBy = paramHttpServletRequest.getParameter("actionBy");
    this.dateKeyIn = paramHttpServletRequest.getParameter("dateKeyIn");

    localHttpSession.removeAttribute("errmsg");

    if ((this.progress == null) || (this.progress.length() == 0)) {
      this.errorMssg = "The progress is not specified.";
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
          MeetingDecisionActionProgress localMeetingDecisionActionProgress = (MeetingDecisionActionProgress)localHttpSession.getAttribute("decProgress");
          if (localMeetingDecisionActionProgress == null) {
            localMeetingDecisionActionProgress = (MeetingDecisionActionProgress)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingDecisionActionProgress");

            localHttpSession.setAttribute("decProgress", localMeetingDecisionActionProgress);
          }

          if (localMeetingDecisionActionProgress != null)
          {
            localMeetingDecisionActionProgress.setDBConnection(localConnection);
            localMeetingDecisionActionProgress.setActionSeq(this.actionSeq);
            localMeetingDecisionActionProgress.setActionBy(this.actionBy);
            localMeetingDecisionActionProgress.setDateKeyIn(this.dateKeyIn);
            localMeetingDecisionActionProgress.setProgressDate(this.progressDate);
            localMeetingDecisionActionProgress.setProgress(this.progress);

            if (localMeetingDecisionActionProgress.addMtgDecisionActionProgress(this.actionSeq))
            {
              i = 1;
              this.progressSeq = localMeetingDecisionActionProgress.getProgressSeq();
            } else {
              i = 0;
              this.errorMssg = localMeetingDecisionActionProgress.getErrorMessage() + localMeetingDecisionActionProgress.getSQL();
            }
          }
          else
          {
            i = 0;
            this.errorMssg = "Meeting Decision Action Progress object is not available.";
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
      CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, this.errorMssg, "");
  }
}