package cms.admin.meeting.servlet;

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
 * @web.servlet name = "addMtgType"
 * @web.servlet-mapping url-pattern = "/addMtgType"
 */
public class NewMeetingType extends HttpServlet
{
  String mtgTypeDesc = null;
  String mtgTypeDept = null;
  String mtgTypeTitle = null;
  String mtgTypeParent = null;
  String mtgTypeLevel = null;

  String errorMssg = null;

  public void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws IOException, ServletException
  {
    int i = 1;
    HttpSession localHttpSession = paramHttpServletRequest.getSession(true);
    DBConnectionPool localDBConnectionPool = null;
    Connection localConnection = null;
    String str = (String)localHttpSession.getAttribute("AMW001");

    this.mtgTypeDesc = paramHttpServletRequest.getParameter("mtgTypeDesc");
    this.mtgTypeDept = paramHttpServletRequest.getParameter("mtgTypeDept");
    this.mtgTypeTitle = paramHttpServletRequest.getParameter("mtgTypeTitle");
    this.mtgTypeParent = paramHttpServletRequest.getParameter("mtgTypeParent");
    this.mtgTypeLevel = paramHttpServletRequest.getParameter("mtgTypeLevel");

    localHttpSession.removeAttribute("errmsg");

    if ((this.mtgTypeDesc == null) || (this.mtgTypeDesc.length() == 0)) {
      this.errorMssg = "Description of the meeting type is not given.";
      i = 0;
    }

    if ((i != 0) && (((this.mtgTypeDept == null) || (this.mtgTypeDept.length() == 0)))) {
      this.errorMssg = "Department of the meeting is not specified.";
      i = 0;
    }

    if ((i != 0) && (((this.mtgTypeTitle == null) || (this.mtgTypeTitle.length() == 0)))) {
      this.errorMssg = "Meeting Type is not specified.";
      i = 0;
    }

    if (i != 0)
    {
      try
      {
        localDBConnectionPool = TvoDBConnectionPoolFactory.getConnectionPool(paramHttpServletRequest);
        localConnection = localDBConnectionPool.getConnection();
        if (localConnection != null)
        {
          MeetingType localMeetingType = (MeetingType)localHttpSession.getAttribute("mtgType");
          if (localMeetingType == null) {
            localMeetingType = (MeetingType)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingType");

            localHttpSession.setAttribute("mtgType", localMeetingType);
          }

          if (localMeetingType != null)
          {
            localMeetingType.setDBConnection(localConnection);
            localMeetingType.setMtgTypeDesc(this.mtgTypeDesc.trim());
            localMeetingType.setMtgTypeDept(this.mtgTypeDept.trim());
            localMeetingType.setMtgTypeTitle(this.mtgTypeTitle.trim());
            localMeetingType.setMtgTypeParent(this.mtgTypeParent);
            localMeetingType.setMtgTypeLevel(this.mtgTypeLevel.trim());

            if (localMeetingType.addMeetingType()) {
              i = 1;
              localHttpSession.setAttribute("mtgTypecode", localMeetingType.getMtgTypeCode());
            } else {
              i = 0;
              this.errorMssg = localMeetingType.getErrorMessage();
            }
          }
          else {
            i = 0;
            this.errorMssg = "Meeting Type object is not available.";
          }
        }
        else
        {
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
      finally {
        localDBConnectionPool.returnConnection(localConnection);
      }

    }

    if (i != 0)
      paramHttpServletResponse.sendRedirect("eMeeting.jsp?action=addMembers");
    else
      CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, this.errorMssg, paramHttpServletRequest.getHeader("Referer"));
  }
}