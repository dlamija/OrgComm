package cms.admin.meeting.servlet;

import cms.admin.meeting.EMeetingQuery;
import cms.admin.meeting.bean.MeetingAttendance;
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

import tvo.TvoBean;
import tvo.TvoDBConnectionPoolFactory;

/**
 * @web.servlet name = "addattendee"
 * @web.servlet-mapping url-pattern = "/addattendee"
 */
public class NewAttendee extends HttpServlet
{
  String[] staffIds = null;
  String errorMssg = null;

  public void doPost(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
  throws IOException, ServletException
{
  boolean flag = true;
  HttpSession httpsession = httpservletrequest.getSession(true);
  String s = (String)httpsession.getAttribute("AMW001");
  staffIds = httpservletrequest.getParameterValues("staffId");
  httpsession.removeAttribute("errmsg");
  if(staffIds == null)
  {
      errorMssg = "No staffs need to be added.";
      flag = false;
  }
  String s1 = (String)httpsession.getAttribute("meetingCode");
  if(s1 == null)
  {
      errorMssg = "Meeting unique ID is not available.";
      flag = false;
  }
  if(flag)
  {
      Connection connection = null;
      try
      {
          DBConnectionPool dbconnectionpool = TvoDBConnectionPoolFactory.getConnectionPool(httpservletrequest);
          connection = dbconnectionpool.getConnection();
          if(connection != null)
          {
              MeetingAttendance meetingattendance = (MeetingAttendance)Beans.instantiate(getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingAttendance");
              if(meetingattendance != null)
              {
                  meetingattendance.setDBConnection(connection);
                  for(int i = 0; i < staffIds.length; i++)
                  {
                      if(staffIds[i] == null || staffIds[i].length() <= 0)
                          continue;
                      meetingattendance.setStaffId(staffIds[i]);
                      if(meetingattendance.addAttendee(s1))
                      {
                          flag = true;
                          continue;
                      }
                      flag = false;
                      errorMssg = meetingattendance.getErrorMessage();
                      break;
                  }

              } else
              {
                  flag = false;
                  errorMssg = "Meeting Attendance object is not available.";
              }
              connection.close();
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
          if(connection != null)
              try
              {
                  connection.close();
              }
              catch(Exception exception2) { }
      }
  }
  if(flag)
  {
      EMeetingQuery emeetingquery = new EMeetingQuery();
      emeetingquery.initTVO(httpservletrequest);
      emeetingquery.setMeetingApptDirty(s1);
  }
  if(flag)
      httpservletresponse.sendRedirect(httpservletrequest.getHeader("Referer"));
  else
      CommonFunction.printAlert(httpservletrequest, httpservletresponse, errorMssg, httpservletrequest.getHeader("Referer"));
}

}