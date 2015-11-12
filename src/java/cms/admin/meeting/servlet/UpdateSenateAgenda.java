package cms.admin.meeting.servlet;

import cms.admin.meeting.bean.MeetingAgenda;
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
 * @web.servlet name = "updsenateagenda"
 * @web.servlet-mapping url-pattern = "/updsenateagenda"
 */
public class UpdateSenateAgenda extends HttpServlet
{
  String meetingCode = null;
  String agendaDesc = null;
  String agendaLevel = null;
  String agendaSeqno = null;
  String parentAgenda = null;
  String sortSeq = null;
  String numbering = null;
  String errorMssg = "ERROR";
  String agendaSeq = null;
  String formName = null;

  String originalFileName = null;
  String physicalFileName = null;

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
    this.agendaDesc = paramHttpServletRequest.getParameter("agendaDesc");
    this.agendaLevel = paramHttpServletRequest.getParameter("agendaLevel");
    this.agendaSeqno = paramHttpServletRequest.getParameter("agendaSeqno");
    this.parentAgenda = paramHttpServletRequest.getParameter("parentAgenda");
    this.sortSeq = paramHttpServletRequest.getParameter("sortSeq");
    this.numbering = paramHttpServletRequest.getParameter("numbering");
    this.formName = paramHttpServletRequest.getParameter("formName");

    this.meetingCode = paramHttpServletRequest.getParameter("meetingCode");

    String str3 = paramHttpServletRequest.getParameter("action");

    localHttpSession.removeAttribute("errmsg");

    i = 1;
    if (i != 0) {
      Connection localConnection = null;
      DBConnectionPool localDBConnectionPool = null;
      try {
        localDBConnectionPool = TvoDBConnectionPoolFactory.getConnectionPool(paramHttpServletRequest);
        localConnection = localDBConnectionPool.getConnection();

        if (localConnection != null) {
          MeetingAgenda localMeetingAgenda = (MeetingAgenda)localHttpSession.getAttribute("mtgagenda");
          if (localMeetingAgenda == null) {
            localMeetingAgenda = (MeetingAgenda)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingAgenda");

            localHttpSession.setAttribute("mtgagenda", localMeetingAgenda);
          }

          if (localMeetingAgenda != null) {
            localMeetingAgenda.setDBConnection(localConnection);
            localMeetingAgenda.setAgendaDesc(this.agendaDesc);
            localMeetingAgenda.setAgendaLevel(this.agendaLevel);
            localMeetingAgenda.setAgendaSeqno(this.agendaSeqno);
            localMeetingAgenda.setParentAgenda(this.parentAgenda);
            localMeetingAgenda.setSortSeq(this.sortSeq);
            localMeetingAgenda.setNumbering(this.numbering);

            if (str3.equals("Update")) {
              if (localMeetingAgenda.updateMtgAgenda(this.agendaDesc.trim(), this.agendaSeq.trim(), this.meetingCode.trim())) {
                i = 1;
              }
              else {
                i = 0;
                this.errorMssg = "Update Not Successful";
                localHttpSession.setAttribute("errmsg", localMeetingAgenda.getErrorMessage() + localMeetingAgenda.getSQL());
              }
            }
            else if (str3.equals("Remove"))
              if (!(localMeetingAgenda.hasChild(this.meetingCode, this.agendaSeq)))
              {
                if (localMeetingAgenda.removeMtgAgenda(paramHttpServletRequest, super.getServletContext(), this.agendaSeq, this.meetingCode, this.sortSeq, this.parentAgenda, this.agendaSeqno)) {
                  i = 1;
                  localMeetingAgenda.updateAgendaNumbering(this.meetingCode);
                }
                else {
                  this.errorMssg = "Delete not Successful";
                  i = 0;
                }
              }
              else {
                this.errorMssg = "Please Delete SubAgenda First";
                i = 0;
              }
          }
          else
          {
            i = 0;
            this.errorMssg = "Meeting Agenda object is not available.";
          }
        }
      }
      catch (Exception localException) {
        localHttpSession.setAttribute("errmsg", localException.toString());
        i = 0;
      } finally {
        localDBConnectionPool.returnConnection(localConnection);
      }
    }

    if (i != 0)
      if (str3.equals("Remove"))
        CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, "Delete Successful", "senateMeeting.jsp?action=Agenda&meetingCode=" + this.meetingCode + "#" + this.formName);
      else
        CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, "Update Successful", "senateMeeting.jsp?action=Agenda&meetingCode=" + this.meetingCode + "#" + this.formName);
    else
      CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, this.errorMssg, "senateMeeting.jsp?action=Agenda&meetingCode=" + this.meetingCode + "#" + this.formName);
  }
}