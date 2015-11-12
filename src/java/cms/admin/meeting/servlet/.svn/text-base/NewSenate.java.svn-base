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
 * @web.servlet name = "addsenate"
 * @web.servlet-mapping url-pattern = "/addsenate"
 */
public class NewSenate extends HttpServlet
{
  String mtgDesc = null;
  String mtgDate = null;
  String mtgStartTime = null;
  String mtgEndTime = null;
  String mtgType = null;
  String mtgStatus = null;
  String errorMssg = "ERROR";
  String mtgRef = null;
  String mtgStartHour = null;
  String mtgStartMinutes = null;
  String mtgEndHour = null;
  String mtgEndMinutes = null;
  private DBConnectionPool dbPool;

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
    Connection localConnection = null;

    this.mtgDesc = paramHttpServletRequest.getParameter("mtgDesc");
    this.mtgDate = paramHttpServletRequest.getParameter("mtgDate");
    this.mtgStartHour = paramHttpServletRequest.getParameter("startHour");
    this.mtgStartMinutes = paramHttpServletRequest.getParameter("startMinutes");
    this.mtgEndHour = paramHttpServletRequest.getParameter("endHour");
    this.mtgEndMinutes = paramHttpServletRequest.getParameter("endMinutes");
    this.mtgType = paramHttpServletRequest.getParameter("mtgType");
    this.mtgStatus = paramHttpServletRequest.getParameter("mtgStatus");
    this.mtgRef = paramHttpServletRequest.getParameter("mtgRef");

    localHttpSession.removeAttribute("errmsg");

    if ((this.mtgDesc == null) || (this.mtgDesc.length() == 0)) {
      this.errorMssg = "Description of the meeting is not given";
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
        this.dbPool = TvoDBConnectionPoolFactory.getConnectionPool(paramHttpServletRequest);
        localConnection = this.dbPool.getConnection();
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
            localMeeting.setMtgKeyInBy((String)localHttpSession.getAttribute("staffid"));
            localMeeting.setMtgRef(this.mtgRef);

            if (localMeeting.addMeeting()) {
              i = 1;
              localHttpSession.setAttribute("mtgcode", localMeeting.getMtgCode());
            }
            else {
              i = 0;
              this.errorMssg = localMeeting.getErrorMessage();
            }
          }
          else {
            i = 0;
            this.errorMssg = " Meeting object is not available";
          }

        }
        else
        {
          i = 0;
          this.errorMssg = "Connection to database is not available";
        }
      }
      catch (Exception localException)
      {
        localException.printStackTrace();
        localHttpSession.setAttribute("errmsg", localException.toString());
        i = 0;
      }
      finally {
        this.dbPool.returnConnection(localConnection);
      }
    }

    if (i != 0)
      paramHttpServletResponse.sendRedirect("senateMeeting.jsp");
    else
      CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, this.errorMssg, "");
  }
}