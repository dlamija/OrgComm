package cms.admin.meeting.servlet;

import java.io.IOException;
import java.io.PrintStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Locale;
import java.util.StringTokenizer;
import java.util.Vector;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.CommonFunction;
import common.Constants;
import common.DBConnectionPool;
import common.Messages;
import common.ModuleManager;
import common.TvoContextManager;

import tvo.TvoDBConnectionPoolFactory;
import tvo.TvoDebug;

/**
 * @web.servlet name = "attendeeCalendar"
 * @web.servlet-mapping url-pattern = "/attendeeCalendar"
 */
public class AttendeeCalendar extends HttpServlet
{
  private DBConnectionPool dbPool;
  private Messages messages;
  private String charSet;
  private String language;
  private String country;
  private String dateFormat;
  private Locale currentLocale;

  public void doGet(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws ServletException, IOException
  {
    doPost(paramHttpServletRequest, paramHttpServletResponse);
  }

  public void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws IOException, ServletException
  {
  }

  public synchronized String addAppt(HttpServletRequest request, HttpServletResponse response)
  {
      Connection con = null;
      Connection con2 = null;
      PreparedStatement pstmt = null;
      PreparedStatement pstmt2 = null;
      PreparedStatement pstmt3 = null;
      PreparedStatement pstmt4 = null;
      PreparedStatement pstmtLock = null;
      String creatorUserID = null;
      String errorMsg = "";
      String reminderDate = null;
      String datePosted = "";
      String apptDate = "";
      String creatorFullName = "";
      String attendeeMessage = "";
      String attendeeURL = "";
      String compulsoryMessage = "";
      String approverMessage = "";
      String approverURL = "";
      String resQuery = "";
      String apptEndDate = "";
      int insertStatus = 0;
      int newCalendarApptID = 0;
      int newCalendarApptAttID = 0;
      int newCalendarApptUserID = 0;
      int newResourceApptID = 0;
      int conOK = 1;
      int conOK2 = 1;
      int i = 0;
      boolean bActiveResource = true;
      boolean notifyMemo = false;
      boolean notifyEmail = false;
      Vector vResource = null;
      Vector vResourceAccess = null;
      Vector vCombinedArrays = null;
      ResultSet rs = null;
      ResultSet rs2 = null;
      Statement stmt = null;
      String smtpServer = null;
      String emailTo = null;
      String emailFrom = null;
      creatorUserID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
      creatorFullName = (String)TvoContextManager.getSessionAttribute(request, "Login.firstName") + " " + (String)TvoContextManager.getSessionAttribute(request, "Login.lastName");
      if(request.getParameter("description").trim().equals(""))
          return messages.getString("calendar.addappt.description.required");
      if(errorMsg.equals(""))
          try
          {
              dbPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
              con = dbPool.getConnection();
              con2 = dbPool.getConnection();
              datePosted = CommonFunction.getDate("yyyy-MM-dd HH:mm");
              con.setAutoCommit(false);
              con2.setAutoCommit(false);
              stmt = con2.createStatement();
              pstmt = con.prepareStatement("INSERT INTO CalendarAppt (calendarApptID, userID, startDate, startTime, endDate, endTime, reminderDate, description, agenda, location, publicFlag,excludeScheduler) VALUES (?,?,to_date(?,'HH24:MI),?,to_date(?,'HH24:MI),?,?,?,?,?,?,?)");
              pstmt2 = con.prepareStatement("INSERT INTO CalendarApptAtt (calendarApptAttID, calendarApptID) VALUES (?,?)");
              pstmt3 = con.prepareStatement("INSERT INTO CalendarApptUser (calendarApptUserID, calendarApptAttID, userID, confirmedFlag, reason) VALUES (?,?,?,?,?)");
              newCalendarApptID = newCalendarApptID(con);
              int created_newCalendarApptID = newCalendarApptID;
              pstmt.clearParameters();
              pstmt.setInt(1, newCalendarApptID);
              pstmt.setString(2, creatorUserID);
              pstmt.setString(3, request.getParameter("mtgStartDate"));
              if(request.getParameter("allDayEvent") == null || request.getParameter("allDayEvent").equals("null"))
                  pstmt.setString(4, request.getParameter("startHour") + ":" + request.getParameter("startMinute"));
              else
                  pstmt.setString(4, "00:00");
              pstmt.setString(5, request.getParameter("mtgEndDate"));
              if(request.getParameter("allDayEvent") == null || request.getParameter("allDayEvent").equals("null"))
                  pstmt.setString(6, request.getParameter("endHour") + ":" + request.getParameter("endMinute"));
              else
                  pstmt.setString(6, "23:59");
              pstmt.setNull(7, 12);
              pstmt.setString(8, request.getParameter("description"));
              pstmt.setString(9, request.getParameter("agenda"));
              pstmt.setString(10, request.getParameter("location"));
              pstmt.setString(11, request.getParameter("publicFlag"));
              if(request.getParameter("excludeScheduler") != null && !request.getParameter("excludeScheduler").equals("null"))
                  pstmt.setString(12, "1");
              else
                  pstmt.setNull(12, 12);
              insertStatus = pstmt.executeUpdate();
              if(insertStatus == 0)
              {
                  errorMsg = errorMsg + messages.getString("calendar.error.insert.calendarappt") + "<BR><BR>";
                  conOK = 0;
              }
              vCombinedArrays = CommonFunction.combineStringArray(request.getParameterValues("attendees"), request.getParameterValues("compulsoryAttendees"));
              String aCUserIDs[] = (String[])vCombinedArrays.get(1);
              String aSUserIDs[] = (String[])vCombinedArrays.get(2);
              if(errorMsg.equals("") && (aCUserIDs != null && aCUserIDs.length > 0 || aSUserIDs != null && aSUserIDs.length > 0))
              {
                  newCalendarApptAttID = newCalendarApptAttID(con);
                  pstmt2.clearParameters();
                  pstmt2.setInt(1, newCalendarApptAttID);
                  pstmt2.setInt(2, newCalendarApptID);
                  insertStatus = pstmt2.executeUpdate();
                  if(insertStatus == 0)
                  {
                      errorMsg = errorMsg + messages.getString("calendar.error.insert.calendarapptatt") + "<BR><BR>";
                      conOK = 0;
                  }
                  if(errorMsg.equals("") && aCUserIDs != null && aCUserIDs.length > 0)
                      for(i = 0; i < aCUserIDs.length; i++)
                      {
                          newCalendarApptUserID = newCalendarApptUserID(con);
                          pstmt3.clearParameters();
                          pstmt3.setInt(1, newCalendarApptUserID);
                          pstmt3.setInt(2, newCalendarApptAttID);
                          pstmt3.setString(3, aCUserIDs[i]);
                          pstmt3.setString(4, "1");
                          pstmt3.setString(5, "Compulsory");
                          insertStatus = pstmt3.executeUpdate();
                          if(insertStatus != 0)
                              continue;
                          errorMsg = errorMsg + messages.getString("calendar.error.insert.calendarapptuser") + "<BR><BR>";
                          conOK = 0;
                          break;
                      }

                  if(errorMsg.equals("") && aSUserIDs != null && aSUserIDs.length > 0)
                      for(i = 0; i < aSUserIDs.length; i++)
                      {
                          newCalendarApptUserID = newCalendarApptUserID(con);
                          pstmt3.clearParameters();
                          pstmt3.setInt(1, newCalendarApptUserID);
                          pstmt3.setInt(2, newCalendarApptAttID);
                          pstmt3.setString(3, aSUserIDs[i]);
                          pstmt3.setString(4, "2");
                          pstmt3.setString(5, "");
                          insertStatus = pstmt3.executeUpdate();
                          if(insertStatus != 0)
                              continue;
                          errorMsg = errorMsg + messages.getString("calendar.error.insert.calendarapptuser") + "<BR><BR>";
                          conOK = 0;
                          break;
                      }

              }
              if(ModuleManager.isEnabled(request, "resource"))
              {
                  String resourceIDs[] = request.getParameterValues("resources");
                  if(errorMsg.equals("") && resourceIDs != null && resourceIDs.length > 0)
                  {
                      pstmt = con2.prepareStatement("SELECT approvalFlag, isPending, isActive FROM \"RESOURCE\" WHERE resourceID = ?");
                      pstmt2 = con2.prepareStatement("SELECT userID FROM ResourceAccess WHERE userID = ? AND resourceID = ?");
                      vResource = new Vector();
                      for(i = 0; i < resourceIDs.length; i++)
                      {
                          pstmt4.clearParameters();
                          pstmt4.setInt(1, newResourceApptID);
                          pstmt4.setInt(2, newCalendarApptID);
                          pstmt4.setInt(3, Integer.parseInt(resourceIDs[i]));
                          pstmt.clearParameters();
                          pstmt.setInt(1, Integer.parseInt(resourceIDs[i]));
                          if(rs != null)
                              rs.close();
                          rs = pstmt.executeQuery();
                          if(rs != null)
                          {
                              if(rs.next())
                              {
                                  bActiveResource = true;
                                  if(rs.getString("isActive").equals("0") || rs.getString("isPending").equals("1"))
                                      bActiveResource = false;
                                  else
                                  if(rs.getString("approvalFlag").equals("1"))
                                  {
                                      pstmt2.clearParameters();
                                      pstmt2.setString(1, creatorUserID);
                                      pstmt2.setInt(2, Integer.parseInt(resourceIDs[i]));
                                      if(rs2 != null)
                                          rs2.close();
                                      rs2 = pstmt2.executeQuery();
                                      if(rs2 != null)
                                      {
                                          if(rs2.next())
                                          {
                                              pstmt4.setString(4, "1");
                                          } else
                                          {
                                              pstmt4.setString(4, "2");
                                              vResource.add(resourceIDs[i]);
                                          }
                                          rs2.close();
                                      } else
                                      {
                                          errorMsg = errorMsg + messages.getString("calendar.error.addappt.no.resource.access") + "<BR><BR>";
                                          conOK = 0;
                                          break;
                                      }
                                  } else
                                  {
                                      pstmt4.setString(4, "1");
                                  }
                                  rs.close();
                              } else
                              {
                                  errorMsg = errorMsg + messages.getString("calendar.error.addappt.no.resource") + "<BR><BR>";
                                  System.out.println("Calendar.addAppt():no such resourceID:" + resourceIDs[i] + "\n \n");
                                  conOK = 0;
                                  break;
                              }
                          } else
                          {
                              errorMsg = errorMsg + messages.getString("calendar.error.addappt.no.resource") + "<BR><BR>";
                              conOK = 0;
                              break;
                          }
                          if(!errorMsg.equals("") || !bActiveResource)
                              continue;
                          insertStatus = pstmt4.executeUpdate();
                          if(insertStatus != 0)
                              continue;
                          errorMsg = errorMsg + messages.getString("calendar.error.insert.resourceappt") + "<BR><BR>";
                          conOK = 0;
                          break;
                      }

                  }
              }
              if(request.getParameter("notifyMemo") != null)
                  notifyMemo = true;
              if(request.getParameter("notifyEmail") != null)
                  notifyEmail = true;
              if(request.getParameter("notifyMethod") != null)
              {
                  StringTokenizer stk = new StringTokenizer(request.getParameter("notifyMethod"), ",");
                  String temp = "";
                  while(stk.hasMoreTokens()) 
                  {
                      temp = stk.nextToken();
                      if(temp.equals("1"))
                          notifyMemo = true;
                      if(temp.equals("2"))
                          notifyEmail = true;
                  }
              }
              if(errorMsg.equals("") && vResource != null && vResource.size() > 0)
              {
                  resQuery = CommonFunction.arrayToQuotedList(vResource.toArray());
                  if(rs != null)
                      rs.close();
                  rs = stmt.executeQuery("SELECT DISTINCT(userID) FROM ResourceAccess WHERE resourceID IN (" + resQuery + ")");
                  if(rs != null)
                  {
                      vResourceAccess = new Vector();
                      for(; rs.next(); vResourceAccess.add(rs.getString("userID")));
                      rs.close();
                  }
                  if(vResourceAccess != null && vResourceAccess.size() > 0)
                  {
                      approverMessage = messages.getString("calendar.addappt.appointment.approve.resources") + "\n\n" + messages.getString("calendar.addappt.appointment.scheduler") + ": " + creatorFullName + "\n\n";
                      if(!request.getParameter("notifyInfo").equals(""))
                          approverMessage = approverMessage + messages.getString("calendar.addappt.note") + ":\n" + request.getParameter("notifyInfo") + "\n\n";
                      apptDate = request.getParameter("startYear") + "-" + request.getParameter("startMonth") + "-" + request.getParameter("startDay") + " " + request.getParameter("startHour") + ":" + request.getParameter("startMinute");
                      apptDate = CommonFunction.parseDate(dateFormat, currentLocale, apptDate, "hh:mm aa", "yyyy-MM-dd hh:mm");
                      approverMessage = approverMessage + messages.getString("calendar.addappt.start.date") + ": " + apptDate + "\n";
                      apptEndDate = request.getParameter("endYear") + "-" + request.getParameter("endMonth") + "-" + request.getParameter("endDay") + " " + request.getParameter("endHour") + ":" + request.getParameter("endMinute");
                      apptEndDate = CommonFunction.parseDate(dateFormat, currentLocale, apptEndDate, "hh:mm aa", "yyyy-MM-dd hh:mm");
                      approverMessage = approverMessage + messages.getString("calendar.addappt.end.date") + ": " + apptEndDate + "\n";
                      approverMessage = approverMessage + messages.getString("calendar.addappt.description") + ": " + request.getParameter("description") + "\n";
                      approverMessage = approverMessage + messages.getString("calendar.addappt.agenda") + ": " + request.getParameter("agenda") + "\n";
                      approverMessage = approverMessage + messages.getString("calendar.addappt.location") + ": " + request.getParameter("location") + "\n";
                      approverURL = "\n<a href=\"javascript:MM_openBrWindow('resource.jsp?action=approveRes&memo=1&apptID=" + newCalendarApptID + "','approveRes'," + "'scrollbars=yes,resizable=yes,width=350,height=186')\" " + "onMouseOver=\"window.status='" + messages.getString("approve") + "';return (true);\">" + messages.getString("click.here.to.approve") + "</a> " + "<a href=\"javascript:MM_openBrWindow('resource.jsp?action=rejectRes&" + "memo=1&apptID=" + newCalendarApptID + "','rejectRes'," + "'scrollbars=yes,resizable=yes,width=350,height=261')\" " + "onMouseOver=\"window.status='" + messages.getString("reject") + "';return (true);\">" + messages.getString("click.here.to.reject") + "</a>";
                      if(CommonFunction.writeToMemo(con2, vResourceAccess.toArray(), creatorUserID, approverMessage + approverURL, datePosted, "FYI,", messages.getString("calendar.addappt.appointment.approve.resources")) == 0)
                      {
                          conOK2 = 0;
                          errorMsg = errorMsg + messages.getString("calendar.addappt.error.send.resource") + "<BR><BR>";
                      }
                  }
              }
              if(errorMsg.equals("") && (notifyMemo || notifyEmail))
              {
                  if(!request.getParameter("notifyInfo").equals(""))
                      attendeeMessage = messages.getString("calendar.addappt.note") + ":\n" + request.getParameter("notifyInfo") + "\n\n";
                  apptDate = request.getParameter("startYear") + "-" + request.getParameter("startMonth") + "-" + request.getParameter("startDay") + " " + request.getParameter("startHour") + ":" + request.getParameter("startMinute");
                  apptDate = CommonFunction.parseDate(dateFormat, currentLocale, apptDate, "hh:mm aa", "yyyy-MM-dd hh:mm");
                  attendeeMessage = attendeeMessage + messages.getString("calendar.addappt.start.date") + ": " + apptDate + "\n";
                  apptEndDate = request.getParameter("endYear") + "-" + request.getParameter("endMonth") + "-" + request.getParameter("endDay") + " " + request.getParameter("endHour") + ":" + request.getParameter("endMinute");
                  apptEndDate = CommonFunction.parseDate(dateFormat, currentLocale, apptEndDate, "hh:mm aa", "yyyy-MM-dd hh:mm");
                  attendeeMessage = attendeeMessage + messages.getString("calendar.addappt.end.date") + ": " + apptEndDate + "\n";
                  attendeeMessage = attendeeMessage + messages.getString("calendar.addappt.description") + ": " + request.getParameter("description") + "\n";
                  attendeeMessage = attendeeMessage + messages.getString("calendar.addappt.agenda") + ": " + request.getParameter("agenda") + "\n";
                  attendeeMessage = attendeeMessage + messages.getString("calendar.addappt.location") + ": " + request.getParameter("location") + "\n";
                  compulsoryMessage = messages.getString("calendar.addappt.compulsory.appointment") + "\n" + messages.getString("calendar.addappt.appointment.scheduler") + ": " + creatorFullName + "\n\n" + attendeeMessage;
                  attendeeMessage = messages.getString("calendar.addappt.appointment") + "\n" + messages.getString("calendar.addappt.appointment.scheduler") + ": " + creatorFullName + "\n\n" + attendeeMessage;
                  attendeeURL = "\n<a href=\"calendar.jsp?action=view&date=" + String.valueOf(Integer.parseInt(request.getParameter("startDay"))) + "&month=" + String.valueOf(Integer.parseInt(request.getParameter("startMonth")) - 1) + "&year=" + request.getParameter("startYear") + "\" onMouseOver=\"window.status='" + messages.getString("view") + "';return true;\">" + messages.getString("click.here.to.view") + "</a>";
              }
              if(errorMsg.equals("") && notifyMemo)
              {
                  if(errorMsg.equals("") && aCUserIDs != null && aCUserIDs.length > 0 && CommonFunction.writeToMemo(con2, aCUserIDs, creatorUserID, compulsoryMessage + attendeeURL, datePosted, "FYI,", messages.getString("calendar.addappt.new.compulsory.appointment")) == 0)
                  {
                      conOK2 = 0;
                      errorMsg = errorMsg + messages.getString("calendar.addappt.error.send.memo.compulsory") + "<BR><BR>";
                  }
                  if(errorMsg.equals("") && aSUserIDs != null && aSUserIDs.length > 0 && CommonFunction.writeToMemo(con2, aSUserIDs, creatorUserID, attendeeMessage + attendeeURL, datePosted, "FYI,", messages.getString("calendar.addappt.new.appointment")) == 0)
                  {
                      conOK2 = 0;
                      errorMsg = errorMsg + messages.getString("calendar.addappt.error.send.memo.attendees") + "<BR><BR>";
                  }
              }
              if(errorMsg.equals("") && notifyEmail)
              {
                  String aToUser[] = new String[1];
                  aToUser[0] = creatorUserID;
                  emailFrom = CommonFunction.getEmailFrom(creatorUserID, con2);
                  smtpServer = CommonFunction.getEmailSMTPServer(creatorUserID, con2);
                  if(smtpServer == null || smtpServer.equals(""))
                      smtpServer = CommonFunction.getPublicSmtpServer(request);
                  if((smtpServer == null || smtpServer.equals("")) && CommonFunction.writeToMemo(con2, aToUser, "DF0182B722-3CAEB5D9202A913A", messages.getString("calendar.addappt.smtp.not.found"), CommonFunction.getDate("yyyy-MM-dd HH:mm"), "Urgent,", messages.getString("calendar.addappt.email.setting.error")) == 0)
                  {
                      conOK2 = 0;
                      errorMsg = errorMsg + messages.getString("calendar.addappt.error.send.memo.appointment.creator") + "<BR><BR>";
                  }
                  if(errorMsg.equals("") && aCUserIDs != null && aCUserIDs.length > 0)
                  {
                      emailTo = CommonFunction.getEmailTo(aCUserIDs, con2);
                      if(emailTo != null && emailFrom != null && smtpServer != null)
                          CommonFunction.sendEmail(request, smtpServer, emailFrom, emailTo, Constants.PRODUCT_NAME + " - " + messages.getString("calendar.addappt.new.compulsory.appointment"), compulsoryMessage);
                  }
                  if(errorMsg.equals("") && aSUserIDs != null && aSUserIDs.length > 0)
                  {
                      emailTo = CommonFunction.getEmailTo(aSUserIDs, con2);
                      if(emailTo != null && emailFrom != null && smtpServer != null)
                          CommonFunction.sendEmail(request, smtpServer, emailFrom, emailTo, Constants.PRODUCT_NAME + " - " + messages.getString("calendar.addappt.new.appointment"), attendeeMessage);
                  }
              }
          }
          catch(Exception e)
          {
              errorMsg = errorMsg + messages.getString("error.console.window");
              System.out.println("Calendar.addAppt():Exception:" + e.getMessage());
              TvoDebug.printStackTrace(e);
              conOK = 0;
          }
          finally
          {
              try
              {
                  if(con != null)
                  {
                      if(conOK == 1 && conOK2 == 1)
                          con.commit();
                      if(rs != null)
                          rs.close();
                      if(ModuleManager.isEnabled(request, "resource") && pstmt4 != null)
                          pstmt4.close();
                      if(pstmt3 != null)
                          pstmt3.close();
                      if(pstmt2 != null)
                          pstmt2.close();
                      if(pstmt != null)
                          pstmt.close();
                      if(stmt != null)
                          stmt.close();
                      if(pstmtLock != null && "oracle.jdbc.driver.OracleDriver".equals("org.gjt.mm.mysql.Driver"))
                      {
                          pstmtLock = con.prepareStatement("UNLOCK TABLES");
                          pstmtLock.execute();
                      }
                      if(pstmtLock != null && "oracle.jdbc.driver.OracleDriver".equals("org.gjt.mm.mysql.Driver"))
                          pstmtLock.close();
                      dbPool.returnConnection(con);
                  }
                  if(con2 != null)
                  {
                      if(conOK == 1 && conOK2 == 1)
                          con2.commit();
                      dbPool.returnConnection(con2);
                  }
              }
              catch(SQLException e)
              {
                  TvoDebug.printStackTrace(e);
              }
          }
      return errorMsg;
  }

  public synchronized int newCalendarApptID(Connection con)
  {
      Statement stmt = null;
      ResultSet rs = null;
      int newCalendarApptID = 0;
      try
      {
          stmt = con.createStatement();
          rs = stmt.executeQuery("SELECT Max(calendarApptID) as caID FROM CalendarAppt");
          if(rs != null)
          {
              if(rs.next())
                  newCalendarApptID = rs.getInt("caID") + 1;
              rs.close();
          } else
          {
              System.out.println("Error getting max calendarApptID");
          }
          stmt.close();
      }
      catch(SQLException e)
      {
          System.out.println("Calendar.newCalendarApptID():SQLException: " + e.getMessage());
      }
      finally
      {
          try
          {
              if(rs != null)
                  rs.close();
              if(stmt != null)
                  stmt.close();
          }
          catch(SQLException sqlexception) { }
      }
      return newCalendarApptID;
  }

  public synchronized int newCalendarApptAttID(Connection con)
  {
      Statement stmt = null;
      ResultSet rs = null;
      int newCalendarApptAttID = 0;
      try
      {
          stmt = con.createStatement();
          rs = stmt.executeQuery("SELECT Max(calendarApptAttID) as caaID FROM CalendarApptAtt");
          if(rs != null)
          {
              if(rs.next())
                  newCalendarApptAttID = rs.getInt("caaID") + 1;
              rs.close();
          } else
          {
              System.out.println("Error getting max calendarApptAttID");
          }
          stmt.close();
      }
      catch(SQLException e)
      {
          System.out.println("Calendar.newCalendarApptAttID():SQLException: " + e.getMessage());
      }
      finally
      {
          try
          {
              if(rs != null)
                  rs.close();
              if(stmt != null)
                  stmt.close();
          }
          catch(SQLException sqlexception) { }
      }
      return newCalendarApptAttID;
  }

  public synchronized int newCalendarApptUserID(Connection con)
  {
      Statement stmt = null;
      ResultSet rs = null;
      int newCalendarApptUserID = 0;
      try
      {
          stmt = con.createStatement();
          rs = stmt.executeQuery("SELECT Max(calendarApptUserID) as cauID FROM CalendarApptUser");
          if(rs != null)
          {
              if(rs.next())
                  newCalendarApptUserID = rs.getInt("cauID") + 1;
              rs.close();
          } else
          {
              System.out.println("Error getting max calendarApptUserID");
          }
          stmt.close();
      }
      catch(SQLException e)
      {
          System.out.println("Calendar.newCalendarApptUserID():SQLException: " + e.getMessage());
      }
      finally
      {
          try
          {
              if(rs != null)
                  rs.close();
              if(stmt != null)
                  stmt.close();
          }
          catch(SQLException sqlexception) { }
      }
      return newCalendarApptUserID;
  }

}