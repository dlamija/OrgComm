package cms.admin.meeting.servlet;

import cms.admin.meeting.bean.Meeting;
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
 * @web.servlet name = "archiveMeeting"
 * @web.servlet-mapping url-pattern = "/archiveMeeting"
 */
public class ArchiveMeeting extends HttpServlet
{
  String mtgCode = null;
  String errorMssg = "ERROR";

  public void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws IOException, ServletException
  {
    int i = 1;
    HttpSession localHttpSession = paramHttpServletRequest.getSession(true);
    Connection localConnection = null;
    String str = (String)localHttpSession.getAttribute("AMW001");

    this.mtgCode = paramHttpServletRequest.getParameter("meetingCode");

    localHttpSession.removeAttribute("errmsg");

    if ((this.mtgCode == null) || (this.mtgCode.length() == 0)) {
      this.errorMssg = "The meeting unique id is not available.";
      i = 0;
    }

    if (i != 0)
    {
      try
      {
        DBConnectionPool localDBConnectionPool = TvoDBConnectionPoolFactory.getConnectionPool(paramHttpServletRequest);
        localConnection = localDBConnectionPool.getConnection();

        if (localConnection != null)
        {
          Meeting localMeeting = (Meeting)localHttpSession.getAttribute("mtg");
          if (localMeeting == null) {
            localMeeting = (Meeting)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.Meeting");

            localHttpSession.setAttribute("mtg", localMeeting);
          }

          if (localMeeting != null)
          {
            localMeeting.setDBConnection(localConnection);

            if (localMeeting.archiveMeeting(this.mtgCode)) {
              i = 1;
            } else {
              i = 0;

              localHttpSession.setAttribute("errmsg", localMeeting.getErrorMessage());
            }

          }
          else
          {
            i = 0;
            this.errorMssg = "Meeting object is not available.";
          }

          localConnection.close();
        } else {
          i = 0;
          this.errorMssg = "Connection to database is not available.";
        }
      }
      catch (Exception localException1)
      {
        localException1.printStackTrace();
        localHttpSession.setAttribute("errmsg", localException1.toString());
        i = 0;
      }
      finally
      {
        try {
          localConnection.close();
        }
        catch (Exception localException2) {
          localException2.printStackTrace();
        }
      }

    }

    if (i != 0)
      CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, "Meeting Has Been Archive", "eMeeting.jsp?action=meetingInfo&meetingCode=" + this.mtgCode);
    else
      CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, this.errorMssg, "");
  }
}