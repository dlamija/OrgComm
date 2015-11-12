package cms.admin.meeting.servlet;

import cms.admin.meeting.EMeetingQuery;
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

import tvo.TvoBean;
import tvo.TvoDBConnectionPoolFactory;

/**
 * @web.servlet name = "updmtg"
 * @web.servlet-mapping url-pattern = "/updmtg"
 */
public class UpdateMeeting extends HttpServlet
{
  String mtgCode = null;
  String mtgDesc = null;
  String mtgDate = null;
  String mtgStartTime = null;
  String mtgEndTime = null;
  String mtgType = null;
  String mtgStatus = null;
  String errorMssg = null;
  String mtgStartHour = null;
  String mtgStartMinutes = null;
  String mtgEndHour = null;
  String mtgEndMinutes = null;

  public void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws IOException, ServletException
  {
    int i = 1;
    HttpSession localHttpSession = paramHttpServletRequest.getSession(true);
    Connection localConnection = null;
    String str = (String)localHttpSession.getAttribute("AMW001");

    this.mtgCode = ((String)localHttpSession.getAttribute("meetingCode"));

    this.mtgDesc = paramHttpServletRequest.getParameter("mtgDesc");
    this.mtgDate = paramHttpServletRequest.getParameter("mtgDate");
    this.mtgStartHour = paramHttpServletRequest.getParameter("startHour");
    this.mtgStartMinutes = paramHttpServletRequest.getParameter("startMinutes");
    this.mtgEndHour = paramHttpServletRequest.getParameter("endHour");
    this.mtgEndMinutes = paramHttpServletRequest.getParameter("endMinutes");
    this.mtgType = paramHttpServletRequest.getParameter("mtgType");
    this.mtgStatus = paramHttpServletRequest.getParameter("mtgStatus");

    localHttpSession.removeAttribute("errmsg");

    if ((this.mtgCode == null) || (this.mtgCode.length() == 0)) {
      this.errorMssg = "The meeting unique id is not available.";
      i = 0;
    }

    if ((i != 0) && (((this.mtgDesc == null) || (this.mtgDesc.length() == 0)))) {
      this.errorMssg = "Description of the meeting is not given.";
      i = 0;
    }

    if ((i != 0) && (((this.mtgDate == null) || (this.mtgDate.length() == 0)))) {
      this.errorMssg = "Date of the meeting is not specified.";
      i = 0;
    }

    if ((i != 0) && (((this.mtgStartHour == null) || (this.mtgStartHour.length() == 0)))) {
      this.errorMssg = "Start hour of the meeting is not specified.";
      i = 0;
    }

    if ((i != 0) && (((this.mtgStartMinutes == null) || (this.mtgStartMinutes.length() == 0)))) {
      this.errorMssg = "Start minutes of the meeting is not specified.";
      i = 0;
    }

    if ((i != 0) && (((this.mtgEndHour == null) || (this.mtgEndHour.length() == 0)))) {
      this.errorMssg = "End hour of the meeting is not specified.";
      i = 0;
    }

    if ((i != 0) && (((this.mtgEndMinutes == null) || (this.mtgEndMinutes.length() == 0)))) {
      this.errorMssg = "End hour of the meeting is not specified.";
      i = 0;
    }

    if ((i != 0) && (((this.mtgStatus == null) || (this.mtgStatus.length() == 0)))) {
      this.errorMssg = "Status of the meeting is not specified.";
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

          if (localMeeting != null) {
            if ((this.mtgType != null) && (this.mtgType.length() == 0)) {
              this.mtgType = null;
            }

            this.mtgStartTime = this.mtgStartHour + ":" + this.mtgStartMinutes;
            this.mtgEndTime = this.mtgEndHour + ":" + this.mtgEndMinutes;

            localMeeting.setDBConnection(localConnection);
            localMeeting.setMtgDesc(this.mtgDesc.trim());
            localMeeting.setMtgDate(this.mtgDate.trim());
            localMeeting.setMtgStartTime(this.mtgStartTime.trim());
            localMeeting.setMtgEndTime(this.mtgEndTime.trim());
            localMeeting.setMtgType(this.mtgType);
            localMeeting.setMtgStatus(this.mtgStatus);
            localMeeting.setMtgOwner((String)localHttpSession.getAttribute("deptcode"));

            if (localMeeting.updMeetingInfo(this.mtgCode)) {
              i = 1;
            } else {
              i = 0;

              localHttpSession.setAttribute("errmsg", localMeeting.getErrorMessage());
            }
          } else {
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

    if (i != 0) {
      EMeetingQuery localEMeetingQuery = new EMeetingQuery();
      localEMeetingQuery.initTVO(paramHttpServletRequest);
      localEMeetingQuery.setMeetingApptDirty(this.mtgCode);
    }

    if (i != 0) {
      CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, "Update Successful", "eMeeting.jsp?action=edit");
    } else {
      if (this.errorMssg.equals("null"))
        this.errorMssg = "Error";
      CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, this.errorMssg, "");
    }
  }
}