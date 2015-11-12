package cms.admin.meeting.servlet;

import cms.admin.meeting.bean.MeetingNotes;
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
 * @web.servlet name = "addnotes"
 * @web.servlet-mapping url-pattern = "/addnotes"
 */
public class NewNotes extends HttpServlet
{
  String noteSeq = null;
  String agendaSeq = null;
  String mtgCode = null;
  String notes = null;
  String attendeeID = null;
  String attendeeOtherID = null;
  String errorMssg = "ERROR";
  String columnName = null;
  String columnValue = null;

  public void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws IOException, ServletException
  {
    int i = 1;
    HttpSession localHttpSession = paramHttpServletRequest.getSession(true);

    String str = (String)localHttpSession.getAttribute("AMW001");

    this.agendaSeq = paramHttpServletRequest.getParameter("agendaSeq");
    this.notes = paramHttpServletRequest.getParameter("notes");
    this.attendeeID = paramHttpServletRequest.getParameter("attendeeID");
    this.attendeeOtherID = paramHttpServletRequest.getParameter("attendeeOther");
    this.mtgCode = paramHttpServletRequest.getParameter("meetingCode");
    this.columnValue = paramHttpServletRequest.getParameter("columnValue");
    this.columnName = paramHttpServletRequest.getParameter("columnName");

    localHttpSession.removeAttribute("errmsg");

    if ((this.notes == null) || (this.notes.length() == 0)) {
      this.errorMssg = "The notes is not specified.";
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
          MeetingNotes localMeetingNotes = (MeetingNotes)localHttpSession.getAttribute("mtgnotes");
          if (localMeetingNotes == null) {
            localMeetingNotes = (MeetingNotes)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingNotes");

            localHttpSession.setAttribute("mtgnotes", localMeetingNotes);
          }

          if (localMeetingNotes != null)
          {
            localMeetingNotes.setDBConnection(localConnection);
            localMeetingNotes.setAgendaSeq(this.agendaSeq);
            localMeetingNotes.setAttendeeID(this.attendeeID);
            localMeetingNotes.setAttendeeOtherID(this.attendeeID);
            localMeetingNotes.setNotes(this.notes);

            this.mtgCode = ((String)localHttpSession.getAttribute("notesMtgCode"));

            if (localMeetingNotes.addMtgNotes(this.agendaSeq, this.columnName, this.columnValue)) {
              this.noteSeq = localMeetingNotes.getNotesSeq();

              i = 1;
            } else {
              i = 0;
            }

          }
          else
          {
            i = 0;
            this.errorMssg = "Meeting Notes object is not available.";
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
      CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, "Notes Created Successfully", "eMeeting.jsp?action=Notes&meetingCode=" + this.mtgCode + "#" + this.noteSeq + "_updateForm");
    else
      CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, this.errorMssg, "eMeeting.jsp?action=Notes&meetingCode=" + this.mtgCode + "#" + this.noteSeq + "_updateForm");
  }
}