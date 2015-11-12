package cms.admin.meeting.servlet;

import cms.admin.meeting.bean.MeetingDecision;
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
 * @web.servlet name = "addsenatedecision"
 * @web.servlet-mapping url-pattern = "/addsenatedecision"
 */
public class NewSenateDecision extends HttpServlet
{
  String mtgCode = null;
  String decisionLevel = null;
  String decisionSeqno = null;
  String parentDecision = null;
  String sortSeq = null;
  String numbering = null;
  String errorMssg = null;
  String decisionSeq = null;
  String decision = null;
  String agendaSeq = null;
  String dueDate = null;

  public void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws IOException, ServletException
  {
    int i = 1;
    HttpSession localHttpSession = paramHttpServletRequest.getSession(true);

    String str1 = (String)localHttpSession.getAttribute("AMW001");

    this.agendaSeq = paramHttpServletRequest.getParameter("agendaSeq");
    this.decision = paramHttpServletRequest.getParameter("decision");
    this.decisionLevel = paramHttpServletRequest.getParameter("decisionLevel");
    this.decisionSeqno = paramHttpServletRequest.getParameter("decisionSeqno");
    this.parentDecision = paramHttpServletRequest.getParameter("parentDecision");
    this.sortSeq = paramHttpServletRequest.getParameter("sortSeq");
    this.numbering = paramHttpServletRequest.getParameter("numbering");
    this.mtgCode = paramHttpServletRequest.getParameter("mtgCode");
    this.dueDate = paramHttpServletRequest.getParameter("dueDate");

    localHttpSession.removeAttribute("errmsg");

    if ((this.decision == null) || (this.decision.length() == 0)) {
      this.errorMssg = "The decision is not specified.";
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
          MeetingDecision localMeetingDecision = (MeetingDecision)localHttpSession.getAttribute("mtgdecision");
          if (localMeetingDecision == null) {
            localMeetingDecision = (MeetingDecision)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingDecision");

            localHttpSession.setAttribute("mtgdecision", localMeetingDecision);
          }

          if (localMeetingDecision != null)
          {
            localMeetingDecision.setDBConnection(localConnection);
            localMeetingDecision.setAgendaSeq(this.agendaSeq);
            localMeetingDecision.setDecision(this.decision);
            localMeetingDecision.setDecisionLevel(this.decisionLevel);
            localMeetingDecision.setDecisionSeqno(this.decisionSeqno);
            localMeetingDecision.setParentDecision(this.parentDecision);
            localMeetingDecision.setSortSeq(this.sortSeq);
            localMeetingDecision.setNumbering(this.numbering);
            localMeetingDecision.setMtgCode(this.mtgCode);
            localMeetingDecision.setDueDate(this.dueDate);

            String str2 = (String)localHttpSession.getAttribute("agendaMtgCode");

            if (localMeetingDecision.addMtgDecision(this.agendaSeq))
            {
              i = 1;
              this.decisionSeq = localMeetingDecision.getDecisionSeq();
            } else {
              i = 0;
              this.errorMssg = localMeetingDecision.getErrorMessage() + localMeetingDecision.getSQL();
            }
          }
          else
          {
            i = 0;
            this.errorMssg = "Meeting Decision object is not available.";
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
      } finally {
        localDBConnectionPool.returnConnection(localConnection);
      }
    }

    if (i != 0) {
      CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, "Decision Created Successfully", "senateMeeting.jsp?action=Decision&meetingCode=" + this.mtgCode + "#" + this.decisionSeq + "_updateDecisionForm");
    }
    else
      CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, this.errorMssg, "senateMeeting.jsp?action=Decision&meetingCode=" + this.mtgCode + "#" + this.decisionSeq + "_updateDecisionForm");
  }
}