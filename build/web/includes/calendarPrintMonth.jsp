<%@ page import="java.util.Calendar" %>
<HTML>
<style type="text/css">
	.apptfont {
		font-size:9px;
		font-family:Arial, Helvetica, sans-serif;
		color:#CC0066;
	}
	.todofont {
		font-size:9px;
		font-family:Arial, Helvetica, sans-serif;
		color:#3130FF;
	}
	.titlefont {
		font-size:11px;
		font-family:Arial, Helvetica, sans-serif;
		color:#000000;
	}
	.bigfont {
		font-size:30px;
		font-family:Georgia, "Times New Roman", Times, serif;
		color:#000000;
	}
	.notefont {
		font-size:11px;
		font-family:Arial, Helvetica, sans-serif;
		color:#000000;
	}
	.tborder {
		border-right: #e3e6e8 1px solid; 
		border-top: #e3e6e8 1px solid; 
		background: #ffffff; 
		border-left: #e3e6e8 1px solid; 
		color: #363636; 
		border-bottom: #e3e6e8 1px solid;
	}
	.calMon { background-color: #000000; color:#FFFFFF; font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 8.5pt }
	.calDay { 
		background-color: #CDCAC9; font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 8.5pt;
	}
</style>
<%
	String[] monthNames = {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
	String[] dayNames = {"Sun","Mon","Tue","Wed","Thu","Fri","Sat"};
	
  	String date=null, month=null, year=null;
	String nextDate=null, prevDate=null, nextMonth=null, prevMonth=null, nextYear=null, prevYear=null;
	boolean dateIsInvalid = false;
	int i,j,k,lastDateOfMonth=0,lastDayOfMonth=0;
	java.util.Calendar cal, cal2;
	
	TvoContextManager.setSessionAttribute(request, "Calendar.lastView", "viewMonth");
  	if (request.getParameter("date") != null) {
    	TvoContextManager.setSessionAttribute(request, "Calendar.date", request.getParameter("date"));
    	date = request.getParameter("date");
  	}
  	else if (TvoContextManager.getSessionAttribute(request, "Calendar.date") != null) {
    	date = (String)TvoContextManager.getSessionAttribute(request, "Calendar.date");
  	}

  	if (request.getParameter("month") != null) {
    	TvoContextManager.setSessionAttribute(request, "Calendar.month", request.getParameter("month"));
    	month = request.getParameter("month");
  	}
  	else if (TvoContextManager.getSessionAttribute(request, "Calendar.month") != null) {
    	month = (String)TvoContextManager.getSessionAttribute(request, "Calendar.month");
  	}

  	if (request.getParameter("year") != null) {
    	TvoContextManager.setSessionAttribute(request, "Calendar.year", request.getParameter("year"));
    	year = request.getParameter("year");
  	}
  	else if (TvoContextManager.getSessionAttribute(request, "Calendar.year") != null) {
    	year = (String)TvoContextManager.getSessionAttribute(request, "Calendar.year");
  	}

  	try {
    	cal = java.util.Calendar.getInstance();
    	cal.setLenient(false);
    	cal.clear();
    	cal.set(Integer.parseInt(year), Integer.parseInt(month), 1);
    
    	if (Integer.parseInt(year) > cal.getActualMaximum(java.util.Calendar.YEAR) || Integer.parseInt(year) < cal.getActualMinimum(java.util.Calendar.YEAR) )
      		dateIsInvalid = true;

    	if (Integer.parseInt(month) > cal.getActualMaximum(java.util.Calendar.MONTH) || Integer.parseInt(month) < cal.getActualMinimum(java.util.Calendar.MONTH) )
      		dateIsInvalid = true;

    	if (Integer.parseInt(date) > cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH) || Integer.parseInt(date) < cal.getActualMinimum(java.util.Calendar.DAY_OF_MONTH) )
    	{
      		if (Integer.parseInt(month) == 1) {
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
			cal = java.util.Calendar.getInstance();
			cal.setLenient(false);
			cal.clear();
			cal.set(Integer.parseInt(year), Integer.parseInt(month), Integer.parseInt(date));
			cal.add(Calendar.MONTH, 1);
			nextYear = String.valueOf(cal.get(Calendar.YEAR));
			nextMonth = String.valueOf(cal.get(Calendar.MONTH));
			nextDate = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));
			cal.add(Calendar.MONTH, -2);
			prevYear = String.valueOf(cal.get(Calendar.YEAR));
			prevMonth = String.valueOf(cal.get(Calendar.MONTH));
			prevDate = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));
    	}
 	}
  
  	if (date != null && month != null && year != null && !dateIsInvalid) {
		Vector vAppointments=null, vEvents=null, vToDo=null;
		Vector vToDoID=null;
		Vector vEventID=null, vDueDate=null;
		Vector vStartDate=null, vEndDate=null, vRepeatDay=null, vDesc=null;
		Vector vStartTime=null, vEndTime=null;
		
		SimpleDateFormat sdfDate=null;
		ParsePosition pos;
		Date dateStart=null, dateEnd=null, dateNow=null, dateTemp=null;
		
		String appDesc="", todoDesc=""; //cikgu
		String currentDate=null;
		String realUserID=null;
		int apptCount, todoCount, eventCount;
		
		String month2 = monthNames[Integer.parseInt(month)];
		month2 = messages.getString("short."+month2.toLowerCase());
		
//		String firstName, lastName;
		firstName = (String)TvoContextManager.getSessionAttribute(request, "Login.firstName");
		lastName = (String)TvoContextManager.getSessionAttribute(request, "Login.lastName");

%>

<HEAD>
<TITLE><%= Constants.PRODUCT_NAME %> - <%= messages.getString("calendar") %></TITLE>
<%@ include file="/includes/no-cache.jsp" %>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=<%= TvoContextManager.getAttribute(request, "System.charset") %>">
<LINK REL="stylesheet" HREF="css/<%= (String)TvoContextManager.getSessionAttribute(request, "Login.CSSFile") %>">
<link href="printcss/PrintStyle.css" rel="stylesheet" type="text/css" media="print">
<link href="printcss/NoPrintStyle.css" rel="stylesheet" type="text/css" media="screen">
<SCRIPT LANGUAGE="JavaScript">
function WinPrint(form) {
	
	if (!msgReminder())
		return;
	netscape_version = navigator.appVersion.split(" ");
	microsoft_version = navigator.appVersion.split(" ");
	microsoft_version = microsoft_version[0].split(",");
	if (navigator.appName == 'Netscape' && netscape_version[0] > 4.0) {
		print();
	}
	else if (navigator.appName == 'Microsoft Internet Explorer' && microsoft_version >= 4) {
		//WebBrowser1.ExecWB(6,1);
		window.print();
	}
	else {
		try {
			window.print();
		}
		catch(e) {	
			alert("<%= messages.getString("library.browser.not.support") %>");
		}	
	}
}

function msgReminder()
{
	var msg = "Please make sure that the printing will follow your browser page setup setting.\n"+
			  "If you want to remove Header and Footer, click File | Page Setup.\n"+
			  "Delete the value in Header and Footer box.\n"+
			  "Continue with printing?"; 
	var proceed = confirm(msg);
	
	return proceed;
}
</script>
</HEAD>
<body>
	<table width="99%" align="center" class="tborder">
    <TR>
      	<TD COLSPAN="3" align="right" valign="middle"><img src="../images/front/calendar.jpg" height="90" width="110"></TD>
		<TD COLSPAN="4" valign="middle" align="left"><font class="bigfont"><b><%= month2 %>&nbsp;<%= year %></b></font></td>
  	</TR>    

	<tr><td colspan="7" class="titlefont"><strong>Name :</strong>&nbsp;<%=firstName%>&nbsp;<%=lastName%></td></tr>
	<tr><td colspan="7">
		<table width="100%" align="center" cellspacing="0" cellpadding="0" bgcolor="#000000">
		<tr><td colspan="7">
			<table width="100%" align="center" cellpadding="4" cellspacing="1">
			<TR VALIGN="MIDDLE" BGCOLOR="#DBDBDB">
				<TD width="15%" CLASS="calMon" VALIGN="TOP" align="center"><B><%= messages.getString("short.sun") %></B></TD>
				<TD width="15%" CLASS="calMon" VALIGN="TOP" align="center"><B><%= messages.getString("short.mon") %></B></TD>
				<TD width="15%" CLASS="calMon" VALIGN="TOP" align="center"><B><%= messages.getString("short.tue") %></B></TD>
				<TD width="15%" CLASS="calMon" VALIGN="TOP" align="center"><B><%= messages.getString("short.wed") %></B></TD>
				<TD width="15%" CLASS="calMon" VALIGN="TOP" align="center"><B><%= messages.getString("short.thu") %></B></TD>
				<TD width="11%" CLASS="calMon" VALIGN="TOP" align="center"><B><%= messages.getString("short.fri") %></B></TD>
				<TD width="11%" CLASS="calMon" VALIGN="TOP" align="center"><B><%= messages.getString("short.sat") %></B></TD>
			</TR>
<%
	cal = java.util.Calendar.getInstance();
	cal.setLenient(true);
	cal.clear();
	cal.set(Integer.parseInt(year), Integer.parseInt(month), 1);
	cal.get(java.util.Calendar.DATE);
	lastDateOfMonth = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
	cal.clear();
	cal.set(Integer.parseInt(year), Integer.parseInt(month), lastDateOfMonth);
	cal.get(java.util.Calendar.DATE);
	lastDayOfMonth = cal.get(java.util.Calendar.DAY_OF_WEEK);
  
	cal.clear();
	cal.set(Integer.parseInt(year), Integer.parseInt(month), 1);
	cal.get(java.util.Calendar.DATE);
	
	realUserID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
	if (TvoContextManager.getSessionAttribute(request, "Calendar.viewUserID") == null) {    
    	vAppointments = (Vector)beanCalendar.getAppointmentsMonth(userID,realUserID,String.valueOf(lastDateOfMonth),month,year);
    	vEvents = (Vector)beanCalendar.getEventsMonth(userID,realUserID,String.valueOf(lastDateOfMonth),month,year);
    	vToDo = (Vector)beanCalendar.getToDoMonth(userID,realUserID,String.valueOf(lastDateOfMonth),month,year);
  	}
  	else {
    	vAppointments = (Vector)beanCalendar.getAppointmentsMonth((String)TvoContextManager.getSessionAttribute(request, "Calendar.viewUserID"),realUserID,String.valueOf(lastDateOfMonth),month,year);
   	 	vEvents = (Vector)beanCalendar.getEventsMonth((String)TvoContextManager.getSessionAttribute(request, "Calendar.viewUserID"),realUserID,String.valueOf(lastDateOfMonth),month,year);
    	vToDo = (Vector)beanCalendar.getToDoMonth((String)TvoContextManager.getSessionAttribute(request, "Calendar.viewUserID"),realUserID,String.valueOf(lastDateOfMonth),month,year);
  	}
	
  	for (i=1; Integer.parseInt(month) == cal.get(java.util.Calendar.MONTH) && Integer.parseInt(year) == cal.get(java.util.Calendar.YEAR) ; i++) 
  	{
		cal.set(Integer.parseInt(year), Integer.parseInt(month), i);
		cal.get(java.util.Calendar.DATE);
		
		if (i == 1 && cal.get(java.util.Calendar.DAY_OF_WEEK) != 1 && Integer.parseInt(month) == cal.get(java.util.Calendar.MONTH) && Integer.parseInt(year) == cal.get(java.util.Calendar.YEAR))
    	{  %>
			<TR>
	<%		for (j=1; j < cal.get(java.util.Calendar.DAY_OF_WEEK); j++) { %>
				<TD VALIGN="TOP" CLASS="calDay">&nbsp;</TD>
		<%	}  %>
      		<TD VALIGN="TOP" CLASS="calDay">
      <%
      		if (Integer.parseInt(date) == cal.get(java.util.Calendar.DATE)) { %>
				<B CLASS="textFont">
		<%	} %>
			<%= i%>
		<%
      		if (Integer.parseInt(date) == cal.get(java.util.Calendar.DATE)) { %>
				</B>
		<%	}  %>
			</TD>
	<%
    	}
    	else if (Integer.parseInt(month) == cal.get(java.util.Calendar.MONTH) && Integer.parseInt(year) == cal.get(java.util.Calendar.YEAR)) {
      		if (cal.get(java.util.Calendar.DAY_OF_WEEK) == 1 &&  Integer.parseInt(month) == cal.get(java.util.Calendar.MONTH) && Integer.parseInt(year) == cal.get(java.util.Calendar.YEAR) )
      		{ %>
				<TR>
		<%	} %>
      		<TD VALIGN="TOP" CLASS="calDay">
      <%
      		if (Integer.parseInt(date) == cal.get(java.util.Calendar.DATE)) { %>
				<B CLASS="textFont">
		<% 	} %>
			<%= i%>
		<%
      		if (Integer.parseInt(date) == cal.get(java.util.Calendar.DATE)) { %>
				</B>
		<%	} %>
			</TD>
	<%
    	}
    	if (cal.get(java.util.Calendar.DAY_OF_WEEK) == 7 &&  Integer.parseInt(month) == cal.get(java.util.Calendar.MONTH) && Integer.parseInt(year) == cal.get(java.util.Calendar.YEAR) )
    	{ %>
      		</TR>
     <%	}
    	else if ( cal.get(java.util.Calendar.DATE) == cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH)) {
      		for (j = cal.get(java.util.Calendar.DAY_OF_WEEK)+1; j < 8; j++) { %>
				<TD VALIGN="TOP" CLASS="calDay" BGCOLOR="#DBDBDB">&nbsp;</TD>
	<%		} %>
      		</TR>
    <%	}
	
    	if (cal.get(java.util.Calendar.DAY_OF_WEEK) == 7 && Integer.parseInt(month) == cal.get(java.util.Calendar.MONTH) && Integer.parseInt(year) == cal.get(java.util.Calendar.YEAR))
    	{ %>
      		<TR BGCOLOR="#DBDBDB" height="30">
      <%	for (k=6; k >= 0 ; k--) {
        		if (k == 1 || k == 0) { %>        
        			<TD BGCOLOR="#ffffff" VALIGN="TOP">
        <%    	}
        		else { %>
        			<TD BGCOLOR="#ffffff" VALIGN="TOP">
        	<%	}
			
        		if (i - k > 0) {
          			currentDate = String.valueOf(i-k);
          			if (Integer.parseInt(currentDate) < 10)
            			currentDate = "0" + String.valueOf(Integer.parseInt(currentDate));

						pos = new ParsePosition(0);
						sdfDate = new SimpleDateFormat("d MMM yyyy");
						dateNow = sdfDate.parse(currentDate+" "+monthNames[Integer.parseInt(month)]+" "+year ,pos);
						sdfDate = new SimpleDateFormat("yyyy-MM-dd");
						
						apptCount = 0;
						appDesc = "";
						todoDesc = "";
						if (vAppointments != null && vAppointments.size() > 0) {            
							vStartDate = (Vector)vAppointments.get(0);
							vEndDate = (Vector)vAppointments.get(1);
							vDesc = (Vector)vAppointments.get(2); //cikgu
							vStartTime = (Vector)vAppointments.get(3); //cikgu
																					
							if (vStartDate != null) {
              					for (j=0; j < vStartDate.size(); j++) {									
									pos = new ParsePosition(0);
									dateStart = sdfDate.parse((String)vStartDate.get(j),pos);
									pos = new ParsePosition(0);									
									dateEnd = sdfDate.parse((String)vEndDate.get(j),pos);
																		
									if (dateNow.equals(dateStart) || dateNow.equals(dateEnd)) {
                  						apptCount++;
										appDesc += "<b>" + (String)vStartTime.get(j) + "</b>: " + (String)vDesc.get(j) + "<br>";
                					}
                					if (dateNow.after(dateStart) && dateNow.before(dateEnd)) {
                  						apptCount++;
										appDesc += "<b>" + (String)vStartTime.get(j) + "</b>: " + (String)vDesc.get(j) + "<br>";
                					}
              					}
            				}
          				}
                    
          				todoCount=0;
         				if (vToDo != null && vToDo.size() > 0) {
            				vStartDate = (Vector)vToDo.get(0);
							vDesc = (Vector)vToDo.get(1);
							
            				if (vStartDate != null) {
             					for(j=0; j < vStartDate.size(); j++) {
									pos = new ParsePosition(0);
									sdfDate = new SimpleDateFormat("yyyy-MM-dd");
									dateStart = sdfDate.parse((String)vStartDate.get(j),pos);
									if (dateNow.equals(dateStart)) {
										todoCount++;
										todoDesc += (String)vDesc.get(j) + "<br>";
									}
              					}
            				}
         				}
                    
						//eventCount = beanCalendar.getEventCount((String)TvoContextManager.getSessionAttribute(request, "Calendar.viewUserID"), realUserID, currentDate, month, year);
                    
          				if (apptCount > 0 || todoCount > 0) { %>
							<font class="apptFont"><%= appDesc %></font>
							<font class="todofont"><%= todoDesc %></FONT>          					          
          		<%		}          				
        			}
        			else { %>
          				<IMG SRC="images/system/blank.gif" WIDTH="30" HEIGHT="60" BORDER="0">
          		<%	} %>
        			</TD>
      		<%	}  %>
      			</TR>
    	<%	} // end for
  		}  //end if
		
	if (lastDayOfMonth != 7) { %>
		<TR ALIGN="CENTER" BGCOLOR="#DBDBDB" height="30">
<%	}

	for (k=0; k < lastDayOfMonth && lastDayOfMonth != 7; k++) {
  		if (k == 0) { %>        
  			<TD BGCOLOR="#ffffff" VALIGN="TOP">
  <%	}
  		else { %>
  			<TD BGCOLOR="#ffffff" VALIGN="TOP">
  <%	}
  
    	if (lastDateOfMonth - lastDayOfMonth + k + 1 > 0) {
			currentDate = String.valueOf(lastDateOfMonth - lastDayOfMonth + k + 1);
			
			pos = new ParsePosition(0);
			sdfDate = new SimpleDateFormat("d MMM yyyy");
			dateNow = sdfDate.parse(currentDate+" "+monthNames[Integer.parseInt(month)]+" "+year ,pos);
			sdfDate = new SimpleDateFormat("yyyy-MM-dd");
			
			apptCount = 0;
			appDesc = "";
			todoDesc = "";
			if (vAppointments != null && vAppointments.size() > 0) {            
				vStartDate = (Vector)vAppointments.get(0);
				vEndDate = (Vector)vAppointments.get(1);
				vDesc = (Vector)vAppointments.get(2); //cikgu
				vStartTime = (Vector)vAppointments.get(3); //cikgu

				if (vStartDate != null) {
          			for (j=0; j < vStartDate.size(); j++) {
						pos = new ParsePosition(0);
						dateStart = sdfDate.parse((String)vStartDate.get(j),pos);
						pos = new ParsePosition(0);
						dateEnd = sdfDate.parse((String)vEndDate.get(j),pos);
						
						if (dateNow.equals(dateStart) || dateNow.equals(dateEnd)) {
              				apptCount++;
							appDesc += "<b>" + (String)vStartTime.get(j) + "</b>: " + (String)vDesc.get(j) + "<br>";
            			}
            			if (dateNow.after(dateStart) && dateNow.before(dateEnd)) {
              				apptCount++;
							appDesc += "<b>" + (String)vStartTime.get(j) + "</b>: " + (String)vDesc.get(j) + "<br>";
            			}
          			}
        		}
      		}
            
      		todoCount=0;
      		if (vToDo != null && vToDo.size() > 0) {
				vStartDate = (Vector)vToDo.get(0);
				vDesc = (Vector)vToDo.get(1);
				
				if (vStartDate != null) {
					for (j=0; j < vStartDate.size(); j++) {
						pos = new ParsePosition(0);
						sdfDate = new SimpleDateFormat("yyyy-MM-dd");
						dateStart = sdfDate.parse((String)vStartDate.get(j),pos);
						if (dateNow.equals(dateStart)) {
							todoCount++;
							todoDesc += (String)vDesc.get(j) + "<br>";
						}
					}
				}
      		}

			//eventCount = beanCalendar.getEventCount((String)TvoContextManager.getSessionAttribute(request, "Calendar.viewUserID"),
					//realUserID, currentDate, month, year);
                    
      		if (apptCount > 0 || todoCount > 0) { %>
				<font class="apptFont"><%= appDesc %></font>
				<font class="todofont"><%= todoDesc %></FONT>&nbsp;&nbsp;	
      			
      <%	}      		
    	}
    	else { %>
    		<IMG SRC="images/system/blank.gif" WIDTH="30" HEIGHT="60" BORDER="0">
   <%	} %>
  		</TD>
<%
	}
	
	if (lastDayOfMonth != 6) {
  		for (k=lastDayOfMonth+1; k < 8; k++) {
    		if (k == 7) { %>        
    			<TD BGCOLOR="#ffffff" VALIGN="TOP">
    <%		}
    		else { %>
    			<TD BGCOLOR="#ffffff" VALIGN="TOP">
    <%		}  %>
    		<IMG SRC="images/system/blank.gif" WIDTH="30" HEIGHT="60" BORDER="0">
    		</TD>
  <%	}
	}
	else { %>
    	<TD BGCOLOR="#DBDBDB" CLASS="contentBgColorAlternate" VALIGN="TOP">&nbsp;</TD>
<%	}

	if (lastDayOfMonth != 7) { %>
 		</TR>
<%	} %>

    <TR BGCOLOR="#EFEFEF">
      	<TD VALIGN="TOP" CLASS="contentBgColor" COLSPAN="7"><IMG SRC="images/system/blank.gif" WIDTH="8" HEIGHT="1"><FONT COLOR="#CC0066">&#149;</FONT>
			<%= messages.getString("calendar.addappt.appointment") %>&nbsp;&nbsp;&nbsp;<FONT COLOR="#3130FF">&#149;</FONT> <%= messages.getString("calendar.viewday.todo.list") %>
			 <!-- <FONT COLOR="#31CF00">&#149;</FONT> <%= messages.getString("calendar.viewday.events") %>--></TD>
    </TR>
<%
	}
	else { %>
    	<TR VALIGN="MIDDLE">
      		<TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" COLSPAN="7">
        		<BLOCKQUOTE>
					<FONT COLOR="#FF0000">ERROR: Invalid Date<BR>
					date=<%= date %>, month=<%= month %>, year=<%= year %><BR><BR>
					<%= messages.getString("calendar.date.error") %>
					</FONT>
        		</BLOCKQUOTE>
     		 </TD>
    	</TR>
<%	} %>
</table></td></tr></table></td></tr></table>
<br>
<div align="center" class="NonPrintable">
	<input type="button" value="  Print  " onClick="javascript:WinPrint();" style="color:#FFFFF">
</div>
<div align="left" class="NonPrintable">
	<font class="notefont"><b>Instruction to enable background color printing:</b><br>
	<b>Internet Explorer</b>:&nbsp;Under Internet Options, select the "Advanced" tab. In the window of options, locate the "Printing" section.
	Check the box entitled "Print background colors and images".<br>
	<b>Mozilla Firefox</b>:&nbsp;Select File -> Page Setup. In the "Options" window, check the box marked "Print Background (colours & images).
	</font>
</div>
</body>
</html>