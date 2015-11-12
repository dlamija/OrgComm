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
 * @web.servlet name = "updatesenatedecisionactionby"
 * @web.servlet-mapping url-pattern = "/updatesenatedecisionactionby"
 */
public class SenateActionBy extends HttpServlet
{
  String[] actionByIDs = null;
  String errorMssg = null;
  String actionSeq = null;
  String action = null;
  String meetingCode = null;

  public void doPost(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
  throws IOException, ServletException
{
  boolean flag = true;
  HttpSession httpsession = httpservletrequest.getSession(true);
  String s = (String)httpsession.getAttribute("AMW001");
  actionByIDs = httpservletrequest.getParameterValues("selectedActionBy");
  actionSeq = httpservletrequest.getParameter("actionSeq");
  action = httpservletrequest.getParameter("action");
  meetingCode = httpservletrequest.getParameter("meetingCode");
  if(action.equals("adddecisionactionby"))
      actionByIDs = httpservletrequest.getParameterValues("selectedActionBy");
  else
      actionByIDs = httpservletrequest.getParameterValues("selectedActionBy2");
  httpsession.removeAttribute("errmsg");
  if(actionByIDs == null)
  {
      errorMssg = "No users are selected.";
      flag = false;
  }
  if(actionSeq == null)
  {
      errorMssg = "Meeting action ID is not available.";
      flag = false;
  }
  if(flag)
  {
      java.sql.Connection connection = null;
      DBConnectionPool dbconnectionpool = null;
      try
      {
          dbconnectionpool = TvoDBConnectionPoolFactory.getConnectionPool(httpservletrequest);
          connection = dbconnectionpool.getConnection();
          if(connection != null)
          {
              Object obj = httpservletrequest.getParameter("dueDate");
              if(obj != null)
                  obj = ((String) (obj)).trim();
              if(obj != null && !((String) (obj)).equals(""))
              {
                  String s1 = actionSeq;
                  MeetingDecision.updateMtgDecisionDueDate(connection, s1, ((String) (obj)));
              }
              obj = (MeetingActionBy)Beans.instantiate(getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingActionBy");
              EMeetingTask emeetingtask = new EMeetingTask();
              emeetingtask.initTVO(httpservletrequest);
              if(obj != null)
              {
                  ((MeetingActionBy) (obj)).setDBConnection(connection);
                  if(action.equals("updatedecisionactionby"))
                  {
                      emeetingtask.deleteTask(getServletContext(), meetingCode, actionSeq);
                      ((MeetingActionBy) (obj)).removeActionBy(actionSeq);
                  }
                  for(int i = 0; i < actionByIDs.length; i++)
                  {
                      if(actionByIDs[i] == null || actionByIDs[i].length() <= 0)
                          continue;
                      ((MeetingActionBy) (obj)).setActionBy(actionByIDs[i]);
                      ((MeetingActionBy) (obj)).setActionSeq(actionSeq);
                      String s2 = ((MeetingActionBy) (obj)).queryDueDate(actionSeq);
                      if(s2 == null)
                      {
                          flag = false;
                          errorMssg = "Please key in due date first";
                          break;
                      }
                      if(((MeetingActionBy) (obj)).addActionBy())
                      {
                          flag = true;
                          continue;
                      }
                      flag = false;
                      if(action.equals("updatedecisionactionby"))
                          errorMssg = "Update is not successful";
                      else
                          errorMssg = "Add is not successful";
                      break;
                  }

                  if(flag)
                      emeetingtask.createTask(meetingCode, actionSeq);
              } else
              {
                  flag = false;
                  errorMssg = "Meeting Action By subbject is not available.";
              }
          } else
          {
              flag = false;
              errorMssg = "Connection to database is not available.";
          }
      }
      catch(Exception exception)
      {
          exception.printStackTrace();
          httpsession.setAttribute("errmsg", exception.toString());
          flag = false;
      }
      finally
      {
          dbconnectionpool.returnConnection(connection);
      }
  }
  if(flag)
  {
      if(action.equals("updatedecisionactionby"))
          CommonFunction.printAlert(httpservletrequest, httpservletresponse, "Update Successful", "senateMeeting.jsp?action=Decision&meetingCode=" + meetingCode + "#" + "updateDecisionActionByForm_" + actionSeq.trim());
      else
          CommonFunction.printAlert(httpservletrequest, httpservletresponse, "Add Successful", "senateMeeting.jsp?action=Decision&meetingCode=" + meetingCode + "#" + "addDecisionActionByForm_" + actionSeq.trim());
  } else
  {
      CommonFunction.printAlert(httpservletrequest, httpservletresponse, errorMssg, "senateMeeting.jsp?action=Decision&meetingCode=" + meetingCode);
  }
}

}