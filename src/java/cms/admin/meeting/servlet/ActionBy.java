package cms.admin.meeting.servlet;

import cms.admin.meeting.EMeetingTask;
import cms.admin.meeting.bean.MeetingActionBy;
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

import tvo.TvoBean;
import tvo.TvoDBConnectionPoolFactory;

/**
 * @web.servlet name = "adddecisionactionby"
 * @web.servlet-mapping url-pattern = "/adddecisionactionby"
 */
public class ActionBy extends HttpServlet
{
  String[] actionByIDs;
  String errorMssg;
  String actionSeq;
  String action;
  String meetingCode;

  public ActionBy()
  {
    this.actionByIDs = null;
    this.errorMssg = null;
    this.actionSeq = null;
    this.action = null;
    this.meetingCode = null;
  }

  public void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws IOException, ServletException
  {
    int i = 1;
    HttpSession localHttpSession = paramHttpServletRequest.getSession(true);
    String str1 = (String)localHttpSession.getAttribute("AMW001");
    this.actionByIDs = paramHttpServletRequest.getParameterValues("selectedActionBy");
    this.actionSeq = paramHttpServletRequest.getParameter("actionSeq");
    this.action = paramHttpServletRequest.getParameter("action");
    this.meetingCode = paramHttpServletRequest.getParameter("meetingCode");
    if (this.action.equals("adddecisionactionby"))
      this.actionByIDs = paramHttpServletRequest.getParameterValues("selectedActionBy");
    else
      this.actionByIDs = paramHttpServletRequest.getParameterValues("selectedActionBy2");
    localHttpSession.removeAttribute("errmsg");
    if (this.actionByIDs == null)
    {
      this.errorMssg = "No users are selected.";
      i = 0;
    }
    if (this.actionSeq == null)
    {
      this.errorMssg = "Meeting action ID is not available.";
      i = 0;
    }
    if (i != 0)
    {
      Connection localConnection = null;
      DBConnectionPool localDBConnectionPool = null;
      try
      {
        localDBConnectionPool = TvoDBConnectionPoolFactory.getConnectionPool(paramHttpServletRequest);
        localConnection = localDBConnectionPool.getConnection();
        if (localConnection != null)
        {
          Object localObject1 = paramHttpServletRequest.getParameter("dueDate");
          if (localObject1 != null)
            localObject1 = ((String)localObject1).trim();
          if ((localObject1 != null) && (!(((String)localObject1).equals(""))))
          {
        	  String s1 = this.actionSeq;
            MeetingDecision.updateMtgDecisionDueDate(localConnection, s1, (String)localObject1);
          }
          localObject1 = (MeetingActionBy)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingActionBy");
          Object localObject2 = new EMeetingTask();
          ((TvoBean)localObject2).initTVO(paramHttpServletRequest);
          if (localObject1 != null)
          {
            ((MeetingActionBy)localObject1).setDBConnection(localConnection);
            if (this.action.equals("updatedecisionactionby"))
            {
              ((EMeetingTask)localObject2).deleteTask(super.getServletContext(), this.meetingCode, this.actionSeq);
              ((MeetingActionBy)localObject1).removeActionBy(this.actionSeq);
            }
            for (int j = 0; j < this.actionByIDs.length; ++j)
            {
              if (this.actionByIDs[j] == null) continue; if (this.actionByIDs[j].length() <= 0)
                continue;
              ((MeetingActionBy)localObject1).setActionBy(this.actionByIDs[j]);
              ((MeetingActionBy)localObject1).setActionSeq(this.actionSeq);
              String str2 = ((MeetingActionBy)localObject1).queryDueDate(this.actionSeq);
              if (str2 == null)
              {
                i = 0;
                this.errorMssg = "Please key in due date first";
                break;
              }
              if (((MeetingActionBy)localObject1).addActionBy())
              {
                i = 1;
              }
              else {
                i = 0;
                if (this.action.equals("updatedecisionactionby")) {
                  this.errorMssg = "Update is not successful"; break;
                }
                this.errorMssg = "Add is not successful";
                break;
              }
            }
            if (i != 0)
              ((EMeetingTask)localObject2).createTask(this.meetingCode, this.actionSeq);
          }
          else {
            i = 0;
            this.errorMssg = "Meeting Action By subbject is not available.";
          }
        }
        else {
          i = 0;
          this.errorMssg = "Connection to database is not available.";
        }
      }
      catch (Exception localException)
      {
        localException.printStackTrace();
        localHttpSession.setAttribute("errmsg", localException.toString());
        i = 0;
      }
      finally
      {
        localDBConnectionPool.returnConnection(localConnection);
      }
    }
    if (i != 0)
    {
      if (this.action.equals("updatedecisionactionby"))
        CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, "Update Successful", "eMeeting.jsp?action=Decision&meetingCode=" + this.meetingCode + "#" + "updateDecisionActionByForm_" + this.actionSeq.trim());
      else
        CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, "Add Successful", "eMeeting.jsp?action=Decision&meetingCode=" + this.meetingCode + "#" + "addDecisionActionByForm_" + this.actionSeq.trim());
    }
    else
      CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, this.errorMssg, "eMeeting.jsp?action=Decision&meetingCode=" + this.meetingCode);
  }
}