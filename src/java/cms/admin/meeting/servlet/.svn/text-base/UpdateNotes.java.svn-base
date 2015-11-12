package cms.admin.meeting.servlet;

import cms.admin.meeting.bean.MeetingNotes;
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
 * @web.servlet name = "updnotes"
 * @web.servlet-mapping url-pattern = "/updnotes"
 */
public class UpdateNotes extends HttpServlet
{
  String noteSeq = null;
  String agendaSeq = null;
  String mtgCode = null;
  String notes = null;
  String attendeeID = null;
  String attendeeOtherID = null;
  String errorMssg = "ERROR";
  String meetingCode = null;
  String formName = null;

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

    this.agendaSeq = paramHttpServletRequest.getParameter("agendaSeq");
    this.notes = paramHttpServletRequest.getParameter("notes");
    this.attendeeID = paramHttpServletRequest.getParameter("attendeeID");
    this.attendeeOtherID = paramHttpServletRequest.getParameter("attendeeOtherID");
    this.mtgCode = paramHttpServletRequest.getParameter("meetingCode");
    this.noteSeq = paramHttpServletRequest.getParameter("noteSeq");
    this.formName = paramHttpServletRequest.getParameter("formName");

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
            localMeetingNotes.setNotesSeq(this.noteSeq);
            localMeetingNotes.setAgendaSeq(this.agendaSeq);
            localMeetingNotes.setAttendeeID(this.attendeeID);
            localMeetingNotes.setAttendeeOtherID(this.attendeeOtherID);
            localMeetingNotes.setNotes(this.notes);

            this.meetingCode = ((String)localHttpSession.getAttribute("notesMtgCode"));

            String str3 = paramHttpServletRequest.getParameter("action");

            if (str3.equals("Update"))
            {
              if (localMeetingNotes.updateMtgNotes()) {
                i = 1;
              } else {
                i = 0;
                this.errorMssg = "Update Not Successful";
                localHttpSession.setAttribute("errmsg", localMeetingNotes.getErrorMessage() + localMeetingNotes.getSQL());
              }

            }
            else if (str3.equals("Remove"))
            {
              if (localMeetingNotes.removeMtgNotes(this.noteSeq))
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

    if (i != 0)
      CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, "Update Successful", "eMeeting.jsp?action=Notes&meetingCode=" + this.meetingCode + "#" + this.formName);
    else
      CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, this.errorMssg, "eMeeting.jsp?action=Notes&meetingCode=" + this.meetingCode + "#" + this.formName);
  }
}