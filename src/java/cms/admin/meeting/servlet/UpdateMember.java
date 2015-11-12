package cms.admin.meeting.servlet;

import cms.admin.meeting.bean.MeetingMember;
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
 * @web.servlet name = "updMember"
 * @web.servlet-mapping url-pattern = "/updMember"
 */
public class UpdateMember extends HttpServlet
{
  String[] staffIds = null;
  String meetingTypeCode = null;
  String errorMssg = "Error";

  public void doPost(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
  throws IOException, ServletException
{
  boolean flag = true;
  HttpSession httpsession = httpservletrequest.getSession(true);
  String s = (String)httpsession.getAttribute("AMW001");
  staffIds = httpservletrequest.getParameterValues("staffId");
  meetingTypeCode = httpservletrequest.getParameter("meetingTypeCode");
  httpsession.removeAttribute("errmsg");
  if(staffIds == null)
  {
      errorMssg = "No members selected.";
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
              MeetingMember meetingmember = (MeetingMember)Beans.instantiate(getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingMember");
              if(meetingmember != null)
              {
                  meetingmember.setDBConnection(connection);
                  String s1 = httpservletrequest.getParameter("action");
                  if(s1.compareTo("Remove") == 0)
                  {
                      for(int i = 0; i < staffIds.length; i++)
                      {
                          if (staffIds[i] == null || staffIds[i].length() <= 0)
                              continue;
                          if (meetingmember.removeMember(staffIds[i], meetingTypeCode)) {
                              flag = true;
                              continue;
                          }
                          flag = false;
                          httpsession.setAttribute("errmsg", meetingmember.getErrorMessage());
                          break;
                      }

                  } else
                  if (s1.compareTo("Update") == 0) {
                	  int cntChairman = 0, cntSecretary = 0;
                	  String post = null;
                      for (int j = 0; j < staffIds.length; j++) {
                          if (staffIds[j] != null && staffIds[j].length() > 0) {
                              post = httpservletrequest.getParameter(staffIds[j] + "_attdPosition");
                              if ("MR0001".equals(post)) cntChairman += 1;
                              if ("MR0002".equals(post)) cntSecretary += 1;
                          }
                      }
                      
                      boolean canProceed = true;
                      if (cntChairman > 1) {
                    	  canProceed = false;
                    	  flag = false;
                          errorMssg = "You cannot select more than one Chairman.";
                      }
                      if (cntSecretary > 1) {
                    	  canProceed = false;
                    	  flag = false;
                          errorMssg = "You cannot select more than one Secretary.";
                      }
                      
                      if (canProceed) {
	                      for (int j = 0; j < staffIds.length; j++) {
	                          if (staffIds[j] != null && staffIds[j].length() > 0) {
	                              String s2 = httpservletrequest.getParameter(staffIds[j] + "_attdPosition");
	                              MeetingMember.updateMember(connection, s2, meetingTypeCode, staffIds[j]);
	                          }
	                      }
                      }
                  }
                  else {
                      flag = false;
                      errorMssg = "Invalid Action.";
                  }
              } else
              {
                  flag = false;
                  errorMssg = "Meeting Attendance object is not available.";
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
      httpservletresponse.sendRedirect(httpservletrequest.getHeader("Referer"));
  else
      CommonFunction.printAlert(httpservletrequest, httpservletresponse, errorMssg, httpservletrequest.getHeader("Referer"));
}

}