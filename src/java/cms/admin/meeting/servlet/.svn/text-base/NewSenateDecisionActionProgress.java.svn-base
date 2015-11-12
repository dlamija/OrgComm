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
 * @web.servlet name = "addsenatedecisionactionprogress"
 * @web.servlet-mapping url-pattern = "/addsenatedecisionactionprogress"
 */
public class NewSenateDecisionActionProgress extends HttpServlet
{
  String mtgCode = null;
  String errorMssg = "ERROR";
  String actionSeq = null;
  String progressSeq = null;
  String progress = null;
  String progressDate = null;
  String actionBy = null;
  String dateKeyIn = null;
  String formName = null;

  public void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws IOException, ServletException
  {
    int i = 1;
    HttpSession localHttpSession = paramHttpServletRequest.getSession(true);

    String str = (String)localHttpSession.getAttribute("AMW001");

    this.actionSeq = paramHttpServletRequest.getParameter("actionSeq");
    this.progressSeq = paramHttpServletRequest.getParameter("progressSeq");
    this.progress = paramHttpServletRequest.getParameter("progress");

    this.progressDate = paramHttpServletRequest.getParameter("progressDate");
    this.actionBy = paramHttpServletRequest.getParameter("actionBy");
    this.dateKeyIn = paramHttpServletRequest.getParameter("dateKeyIn");
    this.formName = paramHttpServletRequest.getParameter("formName");

    this.mtgCode = ((String)localHttpSession.getAttribute("progressMtgCode"));

    localHttpSession.removeAttribute("errmsg");

    if ((this.progress == null) || (this.progress.length() == 0)) {
      this.errorMssg = "The progress is not specified.";
      i = 0;
    }

    if (i != 0) {
      Connection localConnection = null;
      DBConnectionPool localDBConnectionPool = null;
      try
      {
        localDBConnectionPool = TvoDBConnectionPoolFactory.getConnectionPool(paramHttpServletRequest);
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

        }
        else
        {
          i = 0;
          this.errorMssg = "Connection to database is not available.";
        }

      }
      catch (Exception localException)
      {
        localHttpSession.setAttribute("errmsg", localException.toString());
        i = 0;
      } finally {
        localDBConnectionPool.returnConnection(localConnection);
      }
    }

    if (i != 0)
      CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, "Progress Added Successfully", "senateMeeting.jsp?action=DecisionActionProgress&meetingCode=" + this.mtgCode + "#" + this.progressSeq + "_updateDecisionActionProgressForm");
    else
      CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, this.errorMssg, "senateMeeting.jsp?action=DecisionActionProgress&meetingCode='" + this.mtgCode);
  }
}