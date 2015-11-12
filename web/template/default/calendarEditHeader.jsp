<!-- CALENDAR ADD APPT HEADER START -->

<% String ignoreList = "editAppt,editApptAttach,editConflict,listConflict,editToDo,"; %>
<% if (ignoreList.indexOf(action + ",") == -1) { %>
<HTML>
<HEAD>
<TITLE><%= Constants.PRODUCT_NAME %> <%= messages.getString("calendar") %></TITLE>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", -1);
%>
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" VALUE="no-cache">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=<%= TvoContextManager.getAttribute(request, "System.charset") %>">
<% } %>
<SCRIPT LANGUAGE="JavaScript">
<!--
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}

// Appt
function changeDurationHourApptCalendarForm(obj) {
return; var duration;
  
  obj.endHour.options[obj.startHour.selectedIndex].selected = true;
  duration = obj.durationHours.selectedIndex;
  if (obj.endHour.selectedIndex + duration > 23) {
    duration = 23 - obj.startHour.selectedIndex;
    obj.durationHours.options[duration].selected=true;
  }
  obj.endHour.options[obj.endHour.selectedIndex + duration].selected = true;
}

function changeDurationMinApptCalendarForm(obj) {
return; var duration;
  
  obj.endMinute.options[obj.startMinute.selectedIndex].selected = true;
  duration = obj.durationMinutes.selectedIndex;
  duration *= 15;
  if (obj.endMinute.selectedIndex + duration <= 59)
    obj.endMinute.options[obj.endMinute.selectedIndex + duration].selected = true;
  else
    obj.durationMinutes.options[0].selected=true;
}

function changeStartHourApptCalendarForm(obj) {
return; var duration;
  
  duration = obj.durationHours.selectedIndex;
  if (obj.endHour.selectedIndex + duration > 23) {
    duration = 23 - obj.startHour.selectedIndex;
    obj.durationHours.options[duration].selected=true;
  }
  obj.endHour.options[obj.startHour.selectedIndex + duration].selected = true;
}

function changeStartMinApptCalendarForm(obj) {
return; var duration;
  
  duration = obj.durationMinutes.selectedIndex;
  duration *= 15;
  if (obj.endMinute.selectedIndex + duration <= 59)
    obj.endMinute.options[obj.startMinute.selectedIndex + duration].selected = true;
  else
    obj.durationMinutes.options[0].selected=true;
}

function changeEndHourApptCalendarForm(obj) {
return; var duration;
  
  duration = obj.durationHours.selectedIndex;
  obj.startHour.options[obj.endHour.selectedIndex - duration].selected = true;
}

function changeEndMinApptCalendarForm(obj) {
return; var duration;
  
  duration = obj.durationMinutes.selectedIndex;
  duration *= 15;
  obj.startMinute.options[obj.endMinute.selectedIndex - duration].selected = true;
}

// Event
function changeDurationHourEventCalendarForm(obj) {
return; var duration;
  
  obj.endHour.options[obj.startHour.selectedIndex].selected = true;
  duration = obj.durationHours.selectedIndex;
  if (obj.endHour.selectedIndex + duration > 23) {
    duration = 23 - obj.startHour.selectedIndex;
    obj.durationHours.options[duration].selected=true;
  }
  obj.endHour.options[obj.endHour.selectedIndex + duration].selected = true;
}

function changeDurationMinEventCalendarForm(obj) {
return; var duration;
  
  obj.endMinute.options[obj.startMinute.selectedIndex].selected = true;
  duration = obj.durationMinutes.selectedIndex;
  duration *= 15;
  if (obj.endMinute.selectedIndex + duration <= 59)
    obj.endMinute.options[obj.endMinute.selectedIndex + duration].selected = true;
  else
    obj.durationMinutes.options[0].selected=true;
}

function changeStartHourEventCalendarForm(obj) {
return; var duration;
  
  duration = obj.durationHours.selectedIndex;
  if (obj.endHour.selectedIndex + duration > 23) {
    duration = 23 - obj.startHour.selectedIndex;
    obj.durationHours.options[duration].selected=true;
  }
  obj.endHour.options[obj.startHour.selectedIndex + duration].selected = true;
}

function changeStartMinEventCalendarForm(obj) {
return; var duration;
  
  duration = obj.durationMinutes.selectedIndex;
  duration *= 15;
  if (obj.endMinute.selectedIndex + duration <= 59)
    obj.endMinute.options[obj.startMinute.selectedIndex + duration].selected = true;
  else
    obj.durationMinutes.options[0].selected=true;
}

function changeEndHourEventCalendarForm(obj){
return; var duration;
  
  duration = obj.durationHours.selectedIndex;
  obj.startHour.options[obj.endHour.selectedIndex - duration].selected = true;
}

function changeEndMinEventCalendarForm() {
return; var duration;
  
  duration = obj.durationMinutes.selectedIndex;
  duration *= 15;
  obj.startMinute.options[obj.endMinute.selectedIndex - duration].selected = true;
}

function changeStartDayEventCalendarForm(obj) {
  obj.endDay.options[obj.startDay.selectedIndex].selected = true;
}

function changeStartMonthEventCalendarForm(obj) {
  obj.endMonth.options[obj.startMonth.selectedIndex].selected = true;
}

function changeStartYearEventCalendarForm(obj) {
  obj.endYear.options[obj.startYear.selectedIndex].selected = true;
}

function changeEndDayEventCalendarForm(obj) {
return;
}

function changeEndMonthEventCalendarForm(obj) {
return;
}

function changeEndYearEventCalendarForm(obj) {
return;
}


// Appt
function checkApptCalendarForm(obj) {
  var canSubmit = true;
  var sameDate = true;
  
  <%// Module Manager - Resource
  if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_RESOURCE) ) {%>
  selectAllItems(obj.selectedResources);
  <% } %>

  if (obj.description.value.replace(/ /g, "") == '') {
    canSubmit = false;
    alert("<%= messages.getString("calendar.addappt.description.required") %>");
  }
  
  if (canSubmit && obj.startYear.selectedIndex > obj.endYear.selectedIndex) {
    canSubmit = false;
    alert("<%= messages.getString("calendar.addappt.start.year.great.end.year") %>");
  }
  else if (obj.startYear.selectedIndex < obj.endYear.selectedIndex)
    sameDate = false;

  if (canSubmit && obj.startMonth.selectedIndex > obj.endMonth.selectedIndex && sameDate) {
    canSubmit = false;
    alert("<%= messages.getString("calendar.addappt.start.month.great.end.month") %>");
  }
  else if (obj.startMonth.selectedIndex < obj.endMonth.selectedIndex)
    sameDate = false; 

  if (canSubmit && obj.startDay.selectedIndex > obj.endDay.selectedIndex && sameDate) {
    canSubmit = false;
    alert("<%= messages.getString("calendar.addappt.start.day.great.end.day") %>");
  }
  else if (obj.startDay.selectedIndex < obj.endDay.selectedIndex)
    sameDate = false;

  if (canSubmit && obj.startHour.selectedIndex > obj.endHour.selectedIndex && sameDate) {
    canSubmit = false;
    alert("<%= messages.getString("calendar.addappt.start.hour.great.end.hour") %>");
  }
  else if (obj.startHour.selectedIndex < obj.endHour.selectedIndex)
    sameDate = false;
  
  if (canSubmit && obj.startMinute.selectedIndex > obj.endMinute.selectedIndex && sameDate) {
    canSubmit = false;
    alert("<%= messages.getString("calendar.addappt.start.minute.great.end.minute") %>");
  }
  
  if (canSubmit && obj.excludeScheduler.checked && obj.attendees.value == '' && (obj.compulsoryAttendees == null || obj.compulsoryAttendees.value == '')) {
    canSubmit = false;
    alert("Attendees are required");
  }
  
  if (canSubmit)
    obj.submit();
}

// Event
function checkEventCalendarForm(obj) {
  var canSubmit = true;
  var sameDate = true;
  
  <% // Module Manager - Resource
  if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_RESOURCE) ) {%>
  selectAllItems(obj.resources);
  <% } %>

  if (obj.description.value.replace(/ /g, "") == '') {
    canSubmit = false;
    alert("<%= messages.getString("calendar.addappt.description.required") %>");
  }
  
  if (canSubmit && obj.startYear.selectedIndex > obj.endYear.selectedIndex) {
    canSubmit = false;
    alert("<%= messages.getString("calendar.addappt.start.year.great.end.year") %>");
  }
  else if (obj.startYear.selectedIndex < obj.endYear.selectedIndex)
    sameDate = false;

  if (canSubmit && obj.startMonth.selectedIndex > obj.endMonth.selectedIndex && sameDate) {
    canSubmit = false;
    alert("<%= messages.getString("calendar.addappt.start.month.great.end.month") %>");
  }
  else if (obj.startMonth.selectedIndex < obj.endMonth.selectedIndex)
    sameDate = false; 

  if (canSubmit && obj.startDay.selectedIndex > obj.endDay.selectedIndex && sameDate) {
    canSubmit = false;
    alert("<%= messages.getString("calendar.addappt.start.day.great.end.day") %>");
  }
  else if (obj.startDay.selectedIndex < obj.endDay.selectedIndex)
    sameDate = false;

  if (canSubmit && obj.startHour.selectedIndex > obj.endHour.selectedIndex && sameDate) {
    canSubmit = false;
    alert("<%= messages.getString("calendar.addappt.start.hour.great.end.hour") %>");
  }
  else if (obj.startHour.selectedIndex < obj.endHour.selectedIndex)
    sameDate = false;
  
  if (canSubmit && obj.startMinute.selectedIndex > obj.endMinute.selectedIndex && sameDate) {
    canSubmit = false;
    alert("<%= messages.getString("calendar.addappt.start.minute.great.end.minute") %>");
  }

  if (canSubmit)
    obj.submit();
}

// ToDo
function checkToDoCalendarForm(obj) {
  var canSubmit = true;

  <%// Module Manager - Resource
  if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_RESOURCE) ) {%>
  selectAllItems(obj.resources);
  <% } %>
  
  if (obj.description.value == '') {
    canSubmit = false;
    alert('Description is required');
  }
  
  if (canSubmit && obj.userIDassigned.value == "") {
    canSubmit = false;
    alert('ERROR: Please select a user to assign this task to');
  }

  if (canSubmit)
    obj.submit();
}

function deleteCalendarToDo(obj) {
  obj.action='servlet/Calendar?action=deleteToDo&popup=yes';
  obj.submit();
}

//-->
</SCRIPT>
<script language = "javascript" src="template/default/moveItem.js"></script>
<% if (ignoreList.indexOf(action + ",") == -1) { %>
</HEAD>

<BODY BGCOLOR="#C0C0C0" LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" onLoad="window.focus();">
<% } else { %>
	<TABLE WIDTH="100%" BORDER="0" CELLSPACING="10" CELLPADDING="5">
		<tr><td>
<% } %>
<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0">
  <% if (ignoreList.indexOf(action + ",") == -1) { %>
  <TR>
    <TD ALIGN="LEFT" VALIGN="MIDDLE" BGCOLOR="#003399" COLSPAN="2"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
  </TR>
  <% } else { %>
  <TR VALIGN="MIDDLE" >
	<TD HEIGHT="22" BACKGROUND="images/system/strap.gif" COLSPAN="2"><IMG SRC="images/system/blank.gif" WIDTH="20" HEIGHT="8"><FONT COLOR="#FFCC66" SIZE="2" CLASS="contentTitleFont">
		<% if (action.equals("editToDo")) {%>
			To Do
		<% } else { %>
			Appointment
		<% } %>
	</FONT></TD>
  </TR>
  <% } %>
  
  <script>
    	function calDispatch(act) {
        	var newurl = "calendar.jsp?action=" + act;
        	if (act == "addAppt" || act == "addToDo" || act == "getFreeTimeSlot") {
            	location = newurl;
        	} else {
            	MM_openBrWindow(newurl,'calendarAdd','scrollbars=yes,resizable=yes,width=480,height=420');
        	}
    	}
  </script>
  <FORM NAME="calendarAdd" METHOD="POST">
  <TR>
    <TD VALIGN="MIDDLE"><FONT FACE="Arial" SIZE="2" COLOR="#FFFFFF"></FONT>&nbsp;<FONT FACE="Arial" SIZE="2" COLOR="#FFFFFF"></FONT>&nbsp;<FONT FACE="Arial" SIZE="2" COLOR="#FFFFFF"></FONT></TD>
    <TD VALIGN="MIDDLE" ALIGN="RIGHT">
      <SELECT onChange="calDispatch(this.value);">
        <OPTION value="addAppt"><%= messages.getString("select") %></OPTION>
        <OPTION value="addAppt"><%= messages.getString("calendar.appointment") %></OPTION>
        <OPTION value="addToDo"><%= messages.getString("calendar.todo.task") %></OPTION>
        <OPTION value="getFreeTimeSlot">Free Time Slot</OPTION>
      </SELECT>
    </TD>
  </TR>
  </FORM>
  <TR>
    <TD COLSPAN="2" BGCOLOR="#0066CC"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
  </TR>
  <TR>
    <TD COLSPAN="2" ALIGN="CENTER" BGCOLOR="#003399"><FONT SIZE="2" FACE="Arial" COLOR="#FFFFFF"><B><%= calendarEditHeaderName %></B></FONT>
    </TD>
  </TR>
  <TR>
    <TD COLSPAN="2" BGCOLOR="#000037"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="3"></TD>
  </TR>
</TABLE>

<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
  <TR>
    <TD BGCOLOR="#EFEFEF" VALIGN="TOP" CLASS="contentBgColor" COLSPAN="2"><IMG SRC="images/system/blank.gif" WIDTH="83" HEIGHT="10"></TD>
  </TR>
<!-- CALENDAR ADD APPT HEADER END -->
