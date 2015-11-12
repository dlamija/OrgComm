package cms.admin.meeting.servlet;

import cms.admin.meeting.bean.MeetingDecisionAction;
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
 * @web.servlet name = "upddecisionaction"
 * @web.servlet-mapping url-pattern = "/upddecisionaction"
 */
public class UpdateDecisionAction extends HttpServlet
{
  String mtgCode = null;
  String errorMssg = null;
  String actionSeq = null;
  String decisionSeq = null;
  String actionDesc = null;
  String dueDate = null;
  String actionBy = null;

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

    this.actionSeq = paramHttpServletRequest.getParameter("actionSeq");
    this.decisionSeq = paramHttpServletRequest.getParameter("decisionSeq");
    this.actionDesc = paramHttpServletRequest.getParameter("actionDesc");
    this.mtgCode = paramHttpServletRequest.getParameter("meetingCode");
    this.dueDate = paramHttpServletRequest.getParameter("dueDate");
    this.actionBy = paramHttpServletRequest.getParameter("actionBy");

    localHttpSession.removeAttribute("errmsg");

    if ((this.actionDesc == null) || (this.actionDesc.length() == 0)) {
      this.errorMssg = "The action is not specified.";
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
          MeetingDecisionAction localMeetingDecisionAction = (MeetingDecisionAction)localHttpSession.getAttribute("decisionAction");
          if (localMeetingDecisionAction == null) {
            localMeetingDecisionAction = (MeetingDecisionAction)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingDecisionAction");

            localHttpSession.setAttribute("decisionAction", localMeetingDecisionAction);
          }

          if (localMeetingDecisionAction != null)
          {
            localMeetingDecisionAction.setDBConnection(localConnection);
            localMeetingDecisionAction.setDecisionSeq(this.decisionSeq);
            localMeetingDecisionAction.setActionDesc(this.actionDesc);
            localMeetingDecisionAction.setDueDate(this.dueDate);
            localMeetingDecisionAction.setActionBy(this.actionBy);
            String str3 = (String)localHttpSession.getAttribute("agendaMtgCode");

            String str4 = paramHttpServletRequest.getParameter("action");

            if (str4.equals("Update"))
            {
              if (localMeetingDecisionAction.updateMtgDecisionAction()) {
                i = 1;
              } else {
                i = 0;
                this.errorMssg = "Update Not Successful";
                localHttpSession.setAttribute("errmsg", localMeetingDecisionAction.getErrorMessage() + localMeetingDecisionAction.getSQL());
              }

            }
            else if (str4.equals("Remove"))
            {
              if (localMeetingDecisionAction.removeMtgDecisionAction(paramHttpServletRequest, super.getServletContext(), this.actionSeq))
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