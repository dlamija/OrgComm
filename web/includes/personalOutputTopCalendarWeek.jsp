<jsp:useBean id="beanTopCalendarWeek" scope="request" class="ecomm.bean.CalendarCalendar" />
<jsp:useBean id="beanTopCalendarWeekACL" scope="request" class="ecomm.bean.ACL" />

<%@ page session="true" %>
<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="javax.naming.*" %>

<%
	Connection conn = null;
	String current_date = "";
	String current_time = null;
	String current_day = null;
	try
	{
    	Context initCtx = new InitialContext();
    	Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
    	DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
		conn = ds.getConnection();
	}
	catch( Exception e )
	{ 
		System.out.println (e.toString()); 
	}
%>

<%
if (conn!=null)
{
	// Get current date & time
	String sql	= "SELECT TO_CHAR(SYSDATE,'HH24:MI'),TO_CHAR(SYSDATE,'DD/MM/YYYY'),TO_CHAR(SYSDATE,'DAY') FROM DUAL";
	PreparedStatement pstmt = null;
	ResultSet rset = null;

	try {
		pstmt = conn.prepareStatement(sql);
		rset = pstmt.executeQuery ();
		if (rset.next()) {
			current_time = rset.getString (1);
			current_date = rset.getString (2);
			current_day = rset.getString (3);
		}
	}
	catch (SQLException e) { 
		out.println ("Error : " + e.toString ()); 
	}
	finally {
		try {
			if (rset != null) rset.close();
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
		}
		catch (Exception e) { }
	}
}
%>



<%
beanTopCalendarWeekACL.initTVO(request);
Hashtable userCalendarACL, groupCalendarACL;
userCalendarACL = beanTopCalendarWeekACL.getRights(userID, "Calendar", "User");
groupCalendarACL = beanTopCalendarWeekACL.getRights(userID, "Calendar", "Group");
if ( (userCalendarACL.containsKey("view") && userCalendarACL.get("view").equals("1") ) ||
   (groupCalendarACL.containsKey("view") &&  groupCalendarACL.get("view").equals("1")) ) {
%>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.util.Calendar, java.util.Date,java.util.Hashtable" %>
<%
// Module Manager - Personal
if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_PERSONAL) ) {
%>

<%
  String date=null, month=null, year=null,
         prevDate=null, prevMonth=null, prevYear=null,
         nextDate=null, nextMonth=null, nextYear=null,
         currDate=null, currMonth=null, currYear=null;
  java.util.Calendar cal;
  boolean dateIsInvalid = false;
  int weekOfMonth=0, dayOfWeek=0, firstDayOfWeek=0, compensate=0;

  cal = java.util.Calendar.getInstance();
  date = String.valueOf(cal.get(java.util.Calendar.DAY_OF_MONTH));
  month = String.valueOf(cal.get(java.util.Calendar.MONTH));
  year = String.valueOf(cal.get(java.util.Calendar.YEAR));
  currDate = date;
  currMonth = month;
  currYear = year;
	
	String calendarMonthFont = "calendarMonthFont";
	String titleMenuFont = "titleMenuFont";
  if (language.equals("zh") || language.equals("ja"))	{
    calendarMonthFont = "calendarMonthGlyphFont";
		titleMenuFont = "titleMenuGlyphFont";
	}


  if (request.getParameter("calendarWeekDate") != null) {
    TvoContextManager.setSessionAttribute(request, "CalendarWeek.date", request.getParameter("calendarWeekDate"));
    date = request.getParameter("calendarWeekDate");
  }
  else if (TvoContextManager.getSessionAttribute(request, "CalendarWeek.date") != null)
    date = (String)TvoContextManager.getSessionAttribute(request, "CalendarWeek.date");

  if (request.getParameter("calendarWeekMonth") != null) {
    TvoContextManager.setSessionAttribute(request, "CalendarWeek.month", request.getParameter("calendarWeekMonth"));
    month = request.getParameter("calendarWeekMonth");
  }
  else if (TvoContextManager.getSessionAttribute(request, "CalendarWeek.month") != null)
    month = (String)TvoContextManager.getSessionAttribute(request, "CalendarWeek.month");

  if (request.getParameter("calendarWeekYear") != null) {
    TvoContextManager.setSessionAttribute(request, "CalendarWeek.year", request.getParameter("calendarWeekYear"));
    year = request.getParameter("calendarWeekYear");
  }
  else if (TvoContextManager.getSessionAttribute(request, "CalendarWeek.year") != null)
    year = (String)TvoContextManager.getSessionAttribute(request, "CalendarWeek.year");

  try {
    cal = java.util.Calendar.getInstance();
    cal.setLenient(false);
    cal.clear();
    cal.set(Integer.parseInt(year), Integer.parseInt(month), 1);
    
    if (Integer.parseInt(year) > cal.getActualMaximum(java.util.Calendar.YEAR) ||
        Integer.parseInt(year) < cal.getActualMinimum(java.util.Calendar.YEAR) )
      dateIsInvalid = true;

    if (Integer.parseInt(month) > cal.getActualMaximum(java.util.Calendar.MONTH) ||
        Integer.parseInt(month) < cal.getActualMinimum(java.util.Calendar.MONTH) )
      dateIsInvalid = true;

    if (Integer.parseInt(date) > cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH) ||
        Integer.parseInt(date) < cal.getActualMinimum(java.util.Calendar.DAY_OF_MONTH) )
    {
      if (Integer.parseInt(date) > cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH))
      {
        TvoContextManager.setSessionAttribute(request, "Calendar.date", String.valueOf(cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH)));
        date = String.valueOf(cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH));
      }
      else
        dateIsInvalid = true;
    }

  }
  catch (NumberFormatException e) {
    dateIsInvalid = true;
  }
  catch (IllegalArgumentException e) {
    dateIsInvalid = true;
  }
  finally {
    if (!dateIsInvalid) {
      cal.set(Integer.parseInt(year), Integer.parseInt(month), Integer.parseInt(date));

      cal.add(Calendar.DATE, 7);
      nextYear = String.valueOf(cal.get(Calendar.YEAR));
      nextMonth = String.valueOf(cal.get(Calendar.MONTH));
      nextDate = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));

      cal.add(Calendar.DATE, -14);
      prevYear = String.valueOf(cal.get(Calendar.YEAR));
      prevMonth = String.valueOf(cal.get(Calendar.MONTH));
      prevDate = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));

      cal.clear();
      cal.set(Integer.parseInt(year), Integer.parseInt(month), Integer.parseInt(date));

      firstDayOfWeek = 1;
      cal.setFirstDayOfWeek(1);
      dayOfWeek = cal.get(java.util.Calendar.DAY_OF_WEEK);
      weekOfMonth = cal.get(java.util.Calendar.WEEK_OF_MONTH);
    }
  }

  if (date != null && month != null && year != null && !dateIsInvalid) {
    Vector vAppointments=null;
    Vector vDate, vMonth, vYear, vDay;

    String sTime=null, eTime=null, sDate=null, eDate=null, 
           monthName=null, today=null, openTag=null, closeTag=null,
           urlQuery=null;
    int j, k;

    beanTopCalendarWeek.initTVO(request);

    vDay = new Vector();
    vDate = new Vector();
    vMonth = new Vector();
    vYear = new Vector();

    compensate = 0;
    for (k=1; k < 8; k++) {
      if ( k==1 && (k + firstDayOfWeek - 1 - dayOfWeek) > 0 )
        compensate = -7;
      today = CommonFunction.getDate("d/M/yyyy", cal.getTime(), (k + (firstDayOfWeek - 1) - dayOfWeek + compensate));
      vYear.add((String) today.substring(today.lastIndexOf('/') + 1));
      vMonth.add((String) today.substring(today.indexOf('/') + 1, today.lastIndexOf('/')));
      vDate.add((String) today.substring(0, today.indexOf('/')));
      if ( (k + firstDayOfWeek - 1) == 1 || (k + firstDayOfWeek - 1) == 8 )
        vDay.add(messages.getString("short.sun"));
      else if ( (k + firstDayOfWeek - 1) == 2 || (k + firstDayOfWeek - 1) == 9 )
        vDay.add(messages.getString("short.mon")); 
      else if ( (k + firstDayOfWeek - 1) == 3 || (k + firstDayOfWeek - 1) == 10 )
        vDay.add(messages.getString("short.tue")); 
      else if ( (k + firstDayOfWeek - 1) == 4 || (k + firstDayOfWeek - 1) == 11 )
        vDay.add(messages.getString("short.wed"));
      else if ( (k + firstDayOfWeek - 1) == 5 || (k + firstDayOfWeek - 1) == 12 )
        vDay.add(messages.getString("short.thu")); 
      else if ( (k + firstDayOfWeek - 1) == 6 || (k + firstDayOfWeek - 1) == 13 )
        vDay.add(messages.getString("short.fri")); 
      else if ( (k + firstDayOfWeek - 1) == 7 )
        vDay.add(messages.getString("short.sat"));
    }

    if (month.equals("0"))
      monthName = messages.getString("january");
    else if (month.equals("1"))
      monthName = messages.getString("february");
    else if (month.equals("2"))
      monthName = messages.getString("march");
    else if (month.equals("3"))
      monthName = messages.getString("april");
    else if (month.equals("4"))
      monthName = messages.getString("may");
		else if (month.equals("5"))
      monthName = messages.getString("june");
    else if (month.equals("6"))
      monthName = messages.getString("july");
    else if (month.equals("7"))
      monthName = messages.getString("august");
    else if (month.equals("8"))
      monthName = messages.getString("september");
    else if (month.equals("9"))
      monthName = messages.getString("october");
    else if (month.equals("10"))
      monthName = messages.getString("november");
    else if (month.equals("11"))
      monthName = messages.getString("december");

  if (request.getParameter("url_en") != null) { 
    urlQuery = URLDecoder.decode(request.getParameter("url_en"));
  } else {
    urlQuery = request.getQueryString();
  }
  if ( urlQuery == null || urlQuery.equals("") || urlQuery.indexOf("calendarWeekDate") == 0)
    urlQuery = "";
  else if ( urlQuery.indexOf("&calendarWeekDate") != -1 )
    urlQuery = urlQuery.substring(0, urlQuery.indexOf("&calendarWeekDate")) + "&";
  else
    urlQuery += "&";
		
	 Object variable[] = {new Integer(weekOfMonth),monthName,year};

%>
<style type="text/css">
<!--
.style2 {
	color: #FFFF00;
	font-family: Arial;
	font-size: 11px;
}
-->
</style>


<TABLE cellSpacing=1 cellPadding=5 width="100%" border=0 BGCOLOR="BLACK"><TBODY>
  <TR BGCOLOR="#666666" CLASS="calendarMonthBgColor">
    <TD bgcolor="#000000">
      <TABLE cellSpacing=0 cellPadding=0 align=right border=0><TBODY>
        <TR BGCOLOR="#666666" CLASS="calendarMonthBgColor">
          <TD bgcolor="#000000"><FONT COLOR="FFFFFF" CLASS="<%= titleMenuFont %>">
          <A HREF="calendar.jsp?action=addAppt"><img src="images/quicklinks/addappointment.png" alt="Add Appointment" width="129" height="23" /></A>
          <A HREF="?<%= urlQuery %>calendarWeekDate=<%= prevDate %>&calendarWeekMonth=<%= prevMonth %>&calendarWeekYear=<%= prevYear %>" 
          onMouseOver="window.status='<%= messages.getString("calendar.go.back.one.week") %>';return true;">
          <img src="images/quicklinks/previous.png" alt="Previous Date" width="27" height="23" />
          </A>
          <A HREF="?<%= urlQuery %>calendarWeekDate=<%= currDate %>&calendarWeekMonth=<%= currMonth %>&calendarWeekYear=<%= currYear %>" 
          onMouseOver="window.status='<%= messages.getString("current.week") %>';return true;">
          <img src="images/quicklinks/now.png" alt="Now Date" width="27" height="23" /></A>
          <A HREF="?<%= urlQuery %>calendarWeekDate=<%= nextDate %>&calendarWeekMonth=<%= nextMonth %>&calendarWeekYear=<%= nextYear %>" 
          onMouseOver="window.status='<%= messages.getString("calendar.go.forward.one.week") %>';return true;">
          <img src="images/quicklinks/next.png" alt="Next Date" width="27" height="23" /></A></FONT>
          </TD>
        </TR>
      </TBODY></TABLE>
    <img height="8" src="images/system/blank.gif" width="15" /><FONT COLOR="FFFFFF" CLASS="<%= titleMenuFont %>">Today is <%=current_date%>,<%=current_day%>,<%=current_time%> (<%= messages.getString("no.of.week",variable) %>)</FONT> 
    
	</TD>
  </TR>
</TABLE>






<DIV id="topcalendarweek">
<TABLE cellSpacing=0 cellPadding=1 width="100%" border=1 bordercolor="#f4ebea"><TBODY>
  <TR align="center" bgColor=#cccccc class=contentFont>
<% for (k=0; k < 7; k++) {
     openTag  = "<FONT COLOR=ffffff>";
     closeTag = "</FONT>";
     if (currDate.equals((String)vDate.get(k)) &&
         currMonth.equals(String.valueOf(Integer.parseInt((String)vMonth.get(k)) - 1)) &&
         currYear.equals((String)vYear.get(k)) ) {
       openTag  = "<FONT COLOR=yellow><B>";
       closeTag = "</B></FONT>";
     }
     if ( k==0 || k==6 ) {
  %><TD width="10%" bgColor=#FF8055><% 
     } else { 
  %><TD width="16%" bgcolor="#cc3300" ><% 
     }%><b><A HREF="calendar.jsp?action=viewDay&date=<%= vDate.get(k) %>&month=<%= String.valueOf(Integer.parseInt((String)vMonth.get(k)) - 1) %>&year=<%= vYear.get(k) %>" 
     onMouseOver="window.status='<%= messages.getString("view") %>';return true;"><%= openTag %><%= vDay.get(k) %> <%= vDate.get(k) %><%= closeTag %></A></b>
    </TD><%
   }%>
  </TR>
  <TR class=contentBgColor vAlign=top bgColor=#e8e8e8>
<% for (k=0; k < 7; k++) {
     if ( k==0 || k==6 ) {
  %><TD width="10%" bgcolor="#e8e8e8"><% 
     } else { 
  %><TD width="16%" bgcolor="#e8e8e8"><% 
     }%><FONT face="Arial" SIZE=1>
		<DIV id="cal-box<%=k %>" style="OVERFLOW: auto; WIDTH: 100%; HEIGHT: 100px">
<%
     vAppointments = (Vector)beanTopCalendarWeek.getAppointments(userID, userID, (String)vDate.get(k), String.valueOf(Integer.parseInt((String)vMonth.get(k)) - 1), (String)vYear.get(k));

     if (vAppointments != null && vAppointments.size() > 0)
     {

       for (j=0; j < vAppointments.size(); j++) {
			   CalendarApptUser calendar = (CalendarApptUser)	vAppointments.get(j);
         today = CommonFunction.getDate("d/M/yyyy", "yyyy-MM-dd", vDate.get(k) + "/" + vMonth.get(k) + "/" + vYear.get(k));

         if (  calendar.getReminderDate() != null && calendar.getReminderDate().equals(today) ) {
         %><FONT COLOR="#FF0000"><%= messages.getString("calendar.reminder.for") %>:</FONT><BR><%}
				 if (!calendar.getStartTime().equals("00:00") && !calendar.getEndTime().equals("23:59")){
         sTime = CommonFunction.getDate("HH:mm", "h:mm aa", calendar.getStartTime());
         eTime = CommonFunction.getDate("HH:mm", "h:mm aa", calendar.getEndTime());
         if ( sTime.equals(eTime) ) {
         %><FONT COLOR="#FF0000"><%= sTime %></FONT><BR><%
         } else {
         %><FONT COLOR="#FF0000"><%= sTime %> - <%= eTime %></FONT><BR><%}}

         sDate = CommonFunction.parseDate(dateFormat, currentLocale,calendar.getStartDate(),null,TvoConstants.DATE_FOMRAT_SHORT);
         eDate = CommonFunction.parseDate(dateFormat, currentLocale,calendar.getEndDate(),null,TvoConstants.DATE_FOMRAT_SHORT);
         if ( !calendar.getStartDate().equals(calendar.getEndDate()) || 
              ( calendar.getReminderDate() != null &&  calendar.getReminderDate().equals(today)) ) {
           if ( sDate.equals(eDate) ) {
           %><FONT COLOR="#FF0000">(<%= sDate %>)</FONT><BR><%
           } else {
           %><FONT COLOR="#FF0000">(<%= sDate %> - <%= eDate %>)</FONT><BR><%}
         }
			else if (calendar.getStartTime().equals("00:00") && calendar.getEndTime().equals("23:59")){
				 %>
					 <FONT COLOR="#FF0000">(<%= messages.getString("calendar.appointment.all.day.event") %>)</FONT><BR>
				 <%
				 }

         %><FONT COLOR="#0065CE" CLASS="textFont"><%= calendar.getDescription() %></FONT><BR><%
       }
     } else {%>&nbsp;<%}
      %>
		</DIV>
	  </FONT>
	</TD><% }%>
  </TR>
</TBODY></TABLE>

</DIV>
<% } else { 
%><TABLE cellSpacing=1 cellPadding=5 width="100%" border=0><TBODY>
  <TR BGCOLOR="#666666" CLASS="calendarMonthBgColor">
    <TD>
      <IMG height=8 src="images/system/blank.gif" width=15><A 
      href="" onclick="toggleBlock('topcalendarweek'); return false"><FONT 
      COLOR="FFFFFF" CLASS="calendarMonthFont"><B>Appointments For The Week</A>
    </TD>
  </TR>
</TABLE>
<DIV id="topcalendarweek">
<TABLE cellSpacing=1 cellPadding=5 width="100%" border=0><TBODY>
  <TR class=contentBgColor vAlign=top bgColor=#e8e8e8>
    <TD><FONT COLOR="#FF0000" face="Arial" SIZE=1>
      ERROR: Invalid Date<BR>
      date=<%= date %>, month=<%= month %>, year=<%= year %><BR><BR>
      Possible causes: parameters not provided when calling this page or parameters are out of range
    </FONT>
    </TD>
  </TR>
</TABLE></DIV>
<%
  }
} else { 
%>
<!--<TABLE cellSpacing=1 cellPadding=5 width="100%" border=0><TBODY>
  <TR BGCOLOR="#666666" CLASS="calendarMonthBgColor">
    <TD>
      <IMG height=8 src="images/system/blank.gif" width=15><A
      href="" onclick="toggleBlock('topcalendarweek'); return false"><FONT
      COLOR="FFFFFF" CLASS="calendarMonthFont"><B><%= messages.getString ("calendar.viewday.appointments") %></A>
    </TD>
  </TR>
</TABLE>
<DIV id="topcalendarweek">
<TABLE cellSpacing=1 cellPadding=5 width="100%" border=0><TBODY>
  <TR class=contentBgColor vAlign=top bgColor=#e8e8e8>
    <TD><FONT face="Arial" SIZE=1>
			<%= messages.getString("calendar.user.no.access") %>
    </FONT>
    </TD>
  </TR>
</TABLE></DIV>--><%
}
} // Module Manager - Personal %>
