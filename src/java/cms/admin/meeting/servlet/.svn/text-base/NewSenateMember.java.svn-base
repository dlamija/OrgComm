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
 * @web.servlet name = "addSenateMember"
 * @web.servlet-mapping url-pattern = "/addSenateMember"
 */
public class NewSenateMember extends HttpServlet
{
  String[] staffIds = null;
  String errorMssg = null;
  String positionCode = "MR0003";

  public void doPost(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
  throws IOException, ServletException
{
  boolean flag = true;
  HttpSession httpsession = httpservletrequest.getSession(true);
  staffIds = httpservletrequest.getParameterValues("staffId");
  httpsession.removeAttribute("errmsg");
  if(staffIds == null)
  {
      errorMssg = "No members need to be added.";
      flag = false;
  }
  if((String)httpsession.getAttribute("mtgTypeCode") == null)
  {
      errorMssg = "Meeting Type unique ID is not available.";
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
                  for(int i = 0; i < staffIds.length; i++)
                  {
                      if(staffIds[i] == null || staffIds[i].length() <= 0)
                          continue;
                      meetingmember.setPosition(positionCode);
                      meetingmember.setMemberID(staffIds[i]);
                      if(meetingmember.addMember((String)httpsession.getAttribute("mtgTypeCode")))
                      {
                          flag = true;
                          continue;
                      }
                      flag = false;
                      errorMssg = meetingmember.getErrorMessage();
                      break;
                  }

              } else
              {
                  flag = false;
                  errorMssg = "Meeting Member object is not available.";
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
      CommonFunction.printAlert(httpservletrequest, httpservletresponse, "New member successfully added.", httpservletrequest.getHeader("Referer"));
  else
      CommonFunction.printAlert(httpservletrequest, httpservletresponse, errorMssg, httpservletrequest.getHeader("Referer"));
}

}