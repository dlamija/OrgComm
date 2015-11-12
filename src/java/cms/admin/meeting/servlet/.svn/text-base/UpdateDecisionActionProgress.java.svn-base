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
 * @web.servlet name = "upddecisionactionprogress"
 * @web.servlet-mapping url-pattern = "/upddecisionactionprogress"
 */
public class UpdateDecisionActionProgress extends HttpServlet
{
  String mtgCode = null;
  String errorMssg = "ERROR";
  String actionSeq = null;
  String progressSeq = null;
  String progress = null;
  String progressDate = null;
  String actionBy = null;
  String dateKeyIn = null;

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
            localMeetingDecisionActionProgress.setProgressSeq(this.progressSeq);

            String str3 = (String)localHttpSession.getAttribute("agendaMtgCode");

            String str4 = paramHttpServletRequest.getParameter("action");

            if (str4.equals("Update"))
            {
              if (localMeetingDecisionActionProgress.updateMtgDecisionActionProgress()) {
                i = 1;
              } else {
                i = 0;
                this.errorMssg = "Update Not Successful";
                localHttpSession.setAttribute("errmsg", localMeetingDecisionActionProgress.getErrorMessage() + localMeetingDecisionActionProgress.getSQL());
              }

            }
            else if (str4.equals("Remove"))
            {
              if (localMeetingDecisionActionProgress.removeMtgDecisionActionProgress(this.progressSeq))
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