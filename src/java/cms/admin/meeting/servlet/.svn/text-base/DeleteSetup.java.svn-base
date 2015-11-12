package cms.admin.meeting.servlet;

import cms.admin.meeting.bean.MeetingMember;
import cms.admin.meeting.bean.MeetingType;
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
 * @web.servlet name = "deleteMeetingType"
 * @web.servlet-mapping url-pattern = "/deleteMeetingType"
 */
public class DeleteSetup extends HttpServlet
{
  String[] eMeetingTypeIDs = null;
  String errorMssg = "ERROR";

  public void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws IOException, ServletException
  {
    int i = 1;
    HttpSession localHttpSession = paramHttpServletRequest.getSession(true);

    String str = (String)localHttpSession.getAttribute("AMW001");

    this.eMeetingTypeIDs = paramHttpServletRequest.getParameterValues("eMeetingTypeIDs");

    localHttpSession.removeAttribute("errmsg");

    if (this.eMeetingTypeIDs == null) {
      this.errorMssg = "No Meeting Setups Are Selected For Delete.";
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
          MeetingType localMeetingType = (MeetingType)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingType");

          MeetingMember localMeetingMember = (MeetingMember)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingMember");

          localMeetingType.setDBConnection(localConnection);
          localMeetingMember.setDBConnection(localConnection);

          for (int j = 0; j < this.eMeetingTypeIDs.length; ++j)
          {
            if ((this.eMeetingTypeIDs[j] == null) || (this.eMeetingTypeIDs[j].length() <= 0)) {
              continue;
            }
            if (localMeetingMember.removeMember(this.eMeetingTypeIDs[j]))
            {
              i = 1;
            }
            else {
              i = 0;
              this.errorMssg = "Meeting Member Not Deleted Successfully";
            }

            if (localMeetingType.removeMtgType(this.eMeetingTypeIDs[j]))
            {
              i = 1;
            }
            else
            {
              i = 0;
              this.errorMssg = "Meeting Setup Not Deleted Successfully";
            }

          }

          localConnection.close();
        } else {
          i = 0;
          this.errorMssg = "Connection to database is not available.";
        }
      }
      catch (Exception localException1) {
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
    {
      paramHttpServletResponse.sendRedirect(paramHttpServletRequest.getHeader("Referer"));
    }
    else CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, this.errorMssg, paramHttpServletRequest.getHeader("Referer"));
  }
}