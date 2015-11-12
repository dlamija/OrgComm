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
 * @web.servlet name = "updattendee"
 * @web.servlet-mapping url-pattern = "/updattendee"
 */
public class UpdateAttendee extends HttpServlet
{
  String[] attdSeqs = null;
  String attdPosition = null;
  String attdRemark = null;
  String attdStatus = null;
  String errorMssg = null;

  public void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws IOException, ServletException
  {
    int i = 1;
    HttpSession localHttpSession = paramHttpServletRequest.getSession(true);

    this.attdSeqs = paramHttpServletRequest.getParameterValues("attdSeq");
    localHttpSession.removeAttribute("errmsg");

    String str1 = paramHttpServletRequest.getParameter("action");

    if (this.attdSeqs == null) {
      this.errorMssg = "Attendee reference number is not available.";
      i = 0;
    }

    String str2 = (String)localHttpSession.getAttribute("meetingCode");

    if (str2 == null) {
      this.errorMssg = "Meeting unique ID is not available.";
      i = 0;
    }
    Object localObject1;
    if (i != 0) {
      localObject1 = null;
      Connection localConnection = null;
      DBConnectionPool localDBConnectionPool = null;
      try
      {
        localDBConnectionPool = TvoDBConnectionPoolFactory.getConnectionPool(paramHttpServletRequest);
        localObject1 = localDBConnectionPool.getConnection();
        localConnection = localDBConnectionPool.getConnection();
        localConnection.setAutoCommit(false);

        if (localObject1 != null) {
          MeetingAttendance localMeetingAttendance = (MeetingAttendance)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingAttendance");

          if (localMeetingAttendance != null)
          {
            localMeetingAttendance.setDBConnection((Connection)localObject1);
            int j;
            int k;
            String str3;
            if (str1.compareTo("Update") == 0) {
              j = 0;

              for (k = 0; k < this.attdSeqs.length; ++k) {
                if ((this.attdSeqs[k] != null) && (this.attdSeqs[k].length() > 0)) {
                  str3 = paramHttpServletRequest.getParameter(this.attdSeqs[k] + "_attdPosition");
                  String str4 = paramHttpServletRequest.getParameter(this.attdSeqs[k] + "_attdStatus");
                  String str5 = paramHttpServletRequest.getParameter(this.attdSeqs[k] + "_attdRemark");

                  MeetingAttendance.updateAttendee(localConnection, str3, str4, str5, str2, this.attdSeqs[k]);

                  j = 1;
                }
              }

              if (j != 0) {
                str3 = MeetingAttendance.updateAttendeeNow(localConnection, str2);
                if (str3.equals("")) {
                  i = 1;
                } else {
                  i = 0;
                  this.errorMssg = str3;
                }
              }
            }
            else if (str1.compareTo("Remove") == 0) {
              j = 0;

              for (k = 0; k < this.attdSeqs.length; ++k) {
                if ((this.attdSeqs[k] != null) && (this.attdSeqs[k].length() > 0)) {
                  MeetingAttendance.removeAttendee(localConnection, this.attdSeqs[k], str2);

                  j = 1;
                }
              }

              if (j != 0) {
                str3 = MeetingAttendance.updateAttendeeNow(localConnection, str2);
                if (str3.equals("")) {
                  i = 1;
                } else {
                  i = 0;
                  this.errorMssg = str3;
                }
              }
            }
            else {
              i = 0;
              this.errorMssg = "Invalid Action.";
            }
          }
          else {
            i = 0;
            this.errorMssg = "Meeting Attendance object is not available.";
          }

        }
        else
        {
          i = 0;
          this.errorMssg = "Connection to database is not available.";
        }
      }
      catch (Exception localException) {
        localException.printStackTrace();
        localHttpSession.setAttribute("errmsg", localException.toString());
        i = 0;
      } finally {
        localDBConnectionPool.returnConnection((Connection)localObject1);
        localDBConnectionPool.returnConnection(localConnection);
      }

    }

    if ((i != 0) && (str1.compareTo("Remove") == 0)) {
      localObject1 = new EMeetingQuery();
      ((TvoBean)localObject1).initTVO(paramHttpServletRequest);
      ((EMeetingQuery)localObject1).setMeetingApptDirty(str2);
    }

    if (i != 0)
    {
      paramHttpServletResponse.sendRedirect(paramHttpServletRequest.getHeader("Referer"));
    }
    else CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, this.errorMssg, paramHttpServletRequest.getHeader("Referer"));
  }
}