package cms.admin.meeting.servlet;

import cms.admin.meeting.bean.MeetingAgenda;
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
 * @web.servlet name = "addagenda"
 * @web.servlet-mapping url-pattern = "/addagenda"
 */
public class NewAgenda extends HttpServlet
{
  String mtgCode = null;
  String agendaDesc = null;
  String agendaLevel = null;
  String agendaSeqno = null;
  String parentAgenda = null;
  String sortSeq = null;
  String numbering = null;
  String errorMssg = null;
  String meetingCode = null;
  String beforeSeqNo = null;
  String agendaSeq = null;

  public void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws IOException, ServletException
  {
    int i = 1;
    HttpSession localHttpSession = paramHttpServletRequest.getSession(true);

    String str = (String)localHttpSession.getAttribute("AMW001");

    this.agendaDesc = paramHttpServletRequest.getParameter("agendaDesc");
    this.agendaLevel = paramHttpServletRequest.getParameter("agendaLevel");
    this.agendaSeqno = paramHttpServletRequest.getParameter("agendaSeqno");
    this.parentAgenda = paramHttpServletRequest.getParameter("parentAgenda");
    this.sortSeq = paramHttpServletRequest.getParameter("sortSeq");
    this.numbering = paramHttpServletRequest.getParameter("numbering");
    this.beforeSeqNo = paramHttpServletRequest.getParameter("beforeSeqNo");

    localHttpSession.removeAttribute("errmsg");

    if ((this.agendaDesc == null) || (this.agendaDesc.length() == 0)) {
      this.errorMssg = "The agenda is not specified.";
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
          MeetingAgenda localMeetingAgenda = (MeetingAgenda)localHttpSession.getAttribute("mtgagenda");
          if (localMeetingAgenda == null) {
            localMeetingAgenda = (MeetingAgenda)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingAgenda");

            localHttpSession.setAttribute("mtgagenda", localMeetingAgenda);
          }

          if (localMeetingAgenda != null)
          {
            localMeetingAgenda.setDBConnection(localConnection);
            localMeetingAgenda.setAgendaDesc(this.agendaDesc);
            localMeetingAgenda.setAgendaLevel(this.agendaLevel);
            localMeetingAgenda.setAgendaSeqno(this.agendaSeqno);
            localMeetingAgenda.setParentAgenda(this.parentAgenda);

            localMeetingAgenda.setNumbering(this.numbering);

            this.meetingCode = ((String)localHttpSession.getAttribute("agendaMtgCode"));

            int j = localMeetingAgenda.getSortSeq(this.parentAgenda, this.beforeSeqNo, this.meetingCode);

            localMeetingAgenda.setSortSeq("" + j);

            if (localMeetingAgenda.addMtgAgenda(this.meetingCode))
            {
              i = 1;
              this.agendaSeq = localMeetingAgenda.getAgendaSeq();
              localMeetingAgenda.updateAgendaNumbering(this.meetingCode);
            }
            else
            {
              i = 0;
              this.errorMssg = localMeetingAgenda.getErrorMessage() + localMeetingAgenda.getSQL();
            }
          }
          else
          {
            i = 0;
            this.errorMssg = "Meeting Agenda object is not available.";
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
    if (i != 0) {
      CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, "Agenda Created Successfully", "eMeeting.jsp?action=Agenda&meetingCode=" + this.meetingCode + "#" + this.agendaSeq + "_updateForm");
    }
    else
    {
      CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, this.errorMssg, "eMeeting.jsp?action=Agenda&meetingCode=" + this.meetingCode + "#" + this.agendaSeq + "_updateForm");
    }
  }
}