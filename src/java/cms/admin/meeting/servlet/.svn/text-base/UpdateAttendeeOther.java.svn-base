package cms.admin.meeting.servlet;

import cms.admin.meeting.EMeetingQuery;
import cms.admin.meeting.bean.MeetingAttendanceOther;
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
 * @web.servlet name = "updattendeeother"
 * @web.servlet-mapping url-pattern = "/updattendeeother"
 */
public class UpdateAttendeeOther extends HttpServlet
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

    String str1 = (String)localHttpSession.getAttribute("AMW001");

    this.attdSeqs = paramHttpServletRequest.getParameterValues("attdSeqOther");

    localHttpSession.removeAttribute("errmsg");

    String str2 = paramHttpServletRequest.getParameter("action");

    if (this.attdSeqs == null) {
      this.errorMssg = "Attendee reference number is not available.";
      i = 0;
    }

    String str3 = (String)localHttpSession.getAttribute("meetingCode");
    if (str3 == null) {
      this.errorMssg = "Meeting unique ID is not available.";
      i = 0;
    }
    Object localObject1;
    if (i != 0) {
      localObject1 = null;
      Connection localConnection = null;
      try
      {
        DBConnectionPool localDBConnectionPool = TvoDBConnectionPoolFactory.getConnectionPool(paramHttpServletRequest);
        localObject1 = localDBConnectionPool.getConnection();
        localConnection = localDBConnectionPool.getConnection();
        localConnection.setAutoCommit(false);

        if (localObject1 != null)
        {
          MeetingAttendanceOther localMeetingAttendanceOther = (MeetingAttendanceOther)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingAttendanceOther");

          if (localMeetingAttendanceOther != null)
          {
            localMeetingAttendanceOther.setDBConnection((Connection)localObject1);
            int j;
            int k;
            String str4;
            if (str2.compareTo("Update") == 0) {
              j = 0;

              for (k = 0; k < this.attdSeqs.length; ++k) {
                if ((this.attdSeqs[k] != null) && (this.attdSeqs[k].length() > 0)) {
                  str4 = paramHttpServletRequest.getParameter(this.attdSeqs[k] + "_attdPosition");
                  String str5 = paramHttpServletRequest.getParameter(this.attdSeqs[k] + "_attdStatus");
                  String str6 = paramHttpServletRequest.getParameter(this.attdSeqs[k] + "_attdRemark");

                  MeetingAttendanceOther.updateAttendeeOther(localConnection, str4, str5, str6, str3, this.attdSeqs[k]);

                  j = 1;
                }
              }

              if (j != 0) {
                str4 = MeetingAttendanceOther.updateAttendeeOtherNow(localConnection, str3);
                if (str4.equals("")) {
                  i = 1;
                } else {
                  i = 0;
                  this.errorMssg = str4;
                }
              }
            }
            else if (str2.compareTo("Remove") == 0) {
              j = 0;

              for (k = 0; k < this.attdSeqs.length; ++k) {
                if ((this.attdSeqs[k] != null) && (this.attdSeqs[k].length() > 0)) {
                  MeetingAttendanceOther.removeAttendeeOther(localConnection, this.attdSeqs[k], str3);

                  j = 1;
                }
              }

              if (j != 0) {
                str4 = MeetingAttendanceOther.updateAttendeeOtherNow(localConnection, str3);
                if (str4.equals("")) {
                  i = 1;
                } else {
                  i = 0;
                  this.errorMssg = str4;
                }
              }
            } else {
              i = 0;
              this.errorMssg = "Invalid Action.";
            }
          }
          else {
            i = 0;
            this.errorMssg = "Meeting Attendance object is not available.";
          }

          ((Connection)localObject1).close();
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
        if (localObject1 != null) {
          try {
            ((Connection)localObject1).close();
          } catch (Exception localException2) {
            localException2.printStackTrace();
          }

        }

      }

    }

    if ((i != 0) && (str2.compareTo("Remove") == 0)) {
      localObject1 = new EMeetingQuery();
      ((TvoBean)localObject1).initTVO(paramHttpServletRequest);
      ((EMeetingQuery)localObject1).setMeetingApptDirty(str3);
    }

    if (i != 0)
    {
      paramHttpServletResponse.sendRedirect(paramHttpServletRequest.getHeader("Referer"));
    }
    else CommonFunction.printAlert(paramHttpServletRequest, paramHttpServletResponse, this.errorMssg, paramHttpServletRequest.getHeader("Referer"));
  }
}