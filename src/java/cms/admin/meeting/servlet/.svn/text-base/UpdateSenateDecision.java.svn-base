package cms.admin.meeting.servlet;

import cms.admin.meeting.bean.MeetingDecision;
import java.beans.Beans;
import java.io.IOException;
import java.sql.Connection;
import javax.servlet.GenericServlet;
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
 * @web.servlet name = "updsenatedecision"
 * @web.servlet-mapping url-pattern = "/updsenatedecision"
 */
public class UpdateSenateDecision extends HttpServlet
{
  String mtgCode = null;
  String decisionLevel = null;
  String decisionSeqno = null;
  String parentDecision = null;
  String sortSeq = null;
  String numbering = null;
  String errorMssg = "ERROR";
  String decisionSeq = null;
  String decision = null;
  String agendaSeq = null;
  String formName = null;
  String dueDate = null;

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

    this.agendaSeq = paramHttpServletRequest.getParameter("agendaSeq");
    this.decision = paramHttpServletRequest.getParameter("decision");
    this.decisionLevel = paramHttpServletRequest.getParameter("decisionLevel");
    this.decisionSeqno = paramHttpServletRequest.getParameter("decisionSeqno");
    this.parentDecision = paramHttpServletRequest.getParameter("parentDecision");
    this.sortSeq = paramHttpServletRequest.getParameter("sortSeq");
    this.numbering = paramHttpServletRequest.getParameter("numbering");
    this.formName = paramHttpServletRequest.getParameter("formName");
    this.dueDate = paramHttpServletRequest.getParameter("dueDate");
    this.decisionSeq = paramHttpServletRequest.getParameter("decisionSeq");

    String str3 = (String)localHttpSession.getAttribute("decisionMtgCode");

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
            localMeetingDecision.setDecisionSeq(this.decisionSeq);
            localMeetingDecision.setAgendaSeq(this.agendaSeq.trim());
            localMeetingDecision.setDecision(this.decision);
            localMeetingDecision.setDecisionLevel(this.decisionLevel);
            localMeetingDecision.setDecisionSeqno(this.decisionSeqno.trim());
            localMeetingDecision.setParentDecision(this.parentDecision);
            localMeetingDecision.setSortSeq(this.sortSeq);
            localMeetingDecision.setNumbering(this.numbering);
            localMeetingDecision.setDueDate(this.dueDate);

            String str4 = (String)localHttpSession.getAttribute("agendaMtgCode");

            String str5 = paramHttpServletRequest.getParameter("action");

            if (str5.equals("Update"))
            {
              if (localMeetingDecision.updateMtgDecision()) {
                i = 1;
              } else {
                i = 0;
                this.errorMssg = "Update Not Successful";
                localHttpSession.setAttribute("errmsg", localMeetingDecision.getErrorMessage() + localMeetingDecision.getSQL());
              }

            }
            else if (str5.equals("Remove"))
            {
              if (localMeetingDecision.removeMtgDecision(paramHttpServletRequest, super.getServletContext(), this.agendaSeq)) {
                i = 1;
              } else {
                this.errorMssg = "Delete not Successful";
                i = 0;
              }
            }
          }
          else {
            i = 0;
            this.errorMssg = "Meeting Decision object is not available.";
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
        this.errorMssg = "Error";
        localException.printStackTrace();
        localHttpSession.setAttribute("errmsg", localException.toString());
        i = 0;
      } finally {
        localDBConnectionPool.returnConnection(localConnection);
      }
    }

    if (i != 0)
      CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, "Update Successful", "senateMeeting.jsp?action=Decision&meetingCode=" + str3 + "#" + this.formName);
    else
      CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, this.errorMssg, "senateMeeting.jsp?action=Decision&meetingCode=" + str3 + "#" + this.formName);
  }
}