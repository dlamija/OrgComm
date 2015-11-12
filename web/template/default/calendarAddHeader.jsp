<!-- CALENDAR ADD APPT HEADER START -->

<% String ignoreList = "addAppt,addApptAttach,addConflict,editConflict,listConflict,addToDo,getFreeTimeSlot,"; %>
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
// Calendar Conflict
function calConfirm(resType) {
  if (confirm("<%= messages.getString("click.OK.confirm") %>"))
    document.calendarConflict.submit();
}

//Appt
function setApptCalendarForm(obj) {
  currentDate = new Date();
  var currentDay, currentMonth, currentYear;
  var currentHour, currentMinute;
  var i;
  
<% if (request.getParameter("resourceID") != null && request.getParameter("sDay") != null &&
      request.getParameter("sMonth") != null &&  request.getParameter("sYear") != null) { %>
  currentDay = <%= request.getParameter("sDay") %>;
  currentMonth = <%= request.getParameter("sMonth") %>;
  currentYear = <%= request.getParameter("sYear") %>;
<%} else {%>
  currentDay = <%= TvoContextManager.getSessionAttribute(request, "Calendar.date") %>;
  currentMonth = <%= TvoContextManager.getSessionAttribute(request, "Calendar.month") %>;
  currentYear = <%= TvoContextManager.getSessionAttribute(request, "Calendar.year") %>;
<%}%>
  if (currentDay == null)
    currentDay = currentDate.getDate();
  if (currentMonth == null)
    currentMonth = currentDate.getMonth();
  if (currentYear == null)
    currentYear = currentDate.getFullYear();

  currentHour = currentDate.getHours();
  currentMinute = currentDate.getMinutes();
  if (currentMinute > 0 && currentMinute <= 15)
    currentMinute = 1;
  else if (currentMinute > 15 && currentMinute <= 30)
    currentMinute = 2;
  else if (currentMinute > 30 && currentMinute <= 45)
    currentMinute = 3;
  else {
    currentMinute = 0;
    if (currentHour < 23) 
      currentHour++;
  }
  
  obj.startDay.options[currentDay-1].selected = true;
  obj.startDay1.options[currentDay-1].selected = true;
  obj.endDay.options[currentDay-1].selected = true;
  obj.endDay1.options[currentDay-1].selected = true;
  obj.startMonth.options[currentMonth].selected = true;
  obj.startMonth1.options[currentMonth].selected = true;
  obj.endMonth.options[currentMonth].selected = true;
  obj.endMonth1.options[currentMonth].selected = true;
  
  obj.startHour.options[currentHour].selected = true;
  obj.endHour.options[currentHour].selected = true;
  obj.startMinute.options[currentMinute].selected = true;
  obj.endMinute.options[currentMinute].selected = true;
  
  for (i=0; i < obj.startYear.length; i++)
    if (currentYear == obj.startYear.options[i].text) {
      obj.startYear.options[i].selected = true;
      break;
    }
for (i=0; i < obj.startYear1.length; i++)
    if (currentYear == obj.startYear1.options[i].text) {
      obj.startYear1.options[i].selected = true;
      break;
    }
  
  for (i=0; i < obj.endYear.length; i++)
    if (currentYear == obj.endYear.options[i].text) {
      obj.endYear.options[i].selected = true;
      break;
    }
 for (i=0; i < obj.endYear1.length; i++)
    if (currentYear == obj.endYear1.options[i].text) {
      obj.endYear1.options[i].selected = true;
      break;
    }

  }

// Event
function setEventCalendarForm(obj) {
  currentDate = new Date();
  var currentDay, currentMonth, currentYear;
  var i;
  
<% if (request.getParameter("resourceID") != null && request.getParameter("sDay") != null &&
     request.getParameter("sMonth") != null &&  request.getParameter("sYear") != null) {%>
  currentDay = <%= request.getParameter("sDay") %>;
  currentMonth = <%= request.getParameter("sMonth") %>;
  currentYear = <%= request.getParameter("sYear") %>;
<%} else {%>
  currentDay = <%= TvoContextManager.getSessionAttribute(request, "Calendar.date") %>;
  currentMonth = <%= TvoContextManager.getSessionAttribute(request, "Calendar.month") %>;
  currentYear = <%= TvoContextManager.getSessionAttribute(request, "Calendar.year") %>;
<%}%>
  if (currentDay == null)
    currentDay = currentDate.getDate();
  if (currentMonth == null)
    currentMonth = currentDate.getMonth();
  if (currentYear == null)
    currentYear = currentDate.getFullYear();

  currentHour = currentDate.getHours();
  currentMinute = currentDate.getMinutes();
  if (currentMinute > 0 && currentMinute <= 15)
    currentMinute = 1;
  else if (currentMinute > 15 && currentMinute <= 30)
    currentMinute = 2;
  else if (currentMinute > 30 && currentMinute <= 45)
    currentMinute = 3;
  else {
    currentMinute = 0;
    if (currentHour < 23) 
      currentHour++;
  }
  
  obj.startDay.options[currentDay-1].selected = true;
  obj.startDay1.options[currentDay-1].selected = true;
  obj.startMonth.options[currentMonth].selected = true;
  obj.startMonth1.options[currentMonth].selected = true;
  obj.endDay.options[currentDay-1].selected = true;
  obj.endDay1.options[currentDay-1].selected = true;
  obj.endMonth.options[currentMonth].selected = true;
  obj.endMonth1.options[currentMonth].selected = true;

  obj.startHour.options[currentHour].selected = true;
  obj.endHour.options[currentHour].selected = true;
  obj.startMinute.options[currentMinute].selected = true;
  obj.endMinute.options[currentMinute].selected = true;

  for (i=0; i < obj.startYear.length; i++)
    if (currentYear == obj.startYear.options[i].text) {
      obj.startYear.options[i].selected = true;
      break;
    }
	 for (i=0; i < obj.startYear1.length; i++)
    if (currentYear == obj.startYear1.options[i].text) {
      obj.startYear1.options[i].selected = true;
      break;
    }

  for (i=0; i < obj.endYear.length; i++)
    if (currentYear == obj.endYear.options[i].text) {
      obj.endYear.options[i].selected = true;
      break;
    }
 for (i=0; i < obj.endYear1.length; i++)
    if (currentYear == obj.endYear1.options[i].text) {
      obj.endYear1.options[i].selected = true;
      break;
    }

  noItems(obj.allResources, '<%= messages.getString("none.with.line") %>', -1);
  noItems(obj.resources, '<%= messages.getString("none.with.line") %>', -1);
}

// ToDo
function setToDoCalendarForm(obj) {
  currentDate = new Date();
  var currentDay, currentMonth, currentYear;
  var i;
  
<% if (request.getParameter("resourceID") != null && request.getParameter("sDay") != null &&
      request.getParameter("sMonth") != null &&  request.getParameter("sYear") != null) { %>
  currentDay = <%= request.getParameter("sDay") %>;
  currentMonth = <%= request.getParameter("sMonth") %>;
  currentYear = <%= request.getParameter("sYear") %>;
<%} else {%>
  currentDay = <%= TvoContextManager.getSessionAttribute(request, "Calendar.date") %>;
  currentMonth = <%= TvoContextManager.getSessionAttribute(request, "Calendar.month") %>;
  currentYear = <%= TvoContextManager.getSessionAttribute(request, "Calendar.year") %>;
<%}%>
  if (currentDay == null)
    currentDay = currentDate.getDate();
  if (currentMonth == null)
    currentMonth = currentDate.getMonth();
  if (currentYear == null)
    currentYear = currentDate.getFullYear();

  currentHour = currentDate.getHours();
  currentMinute = currentDate.getMinutes();
  
  obj.dueDay.options[currentDay-1].selected = true;
  obj.dueMonth.options[currentMonth].selected = true;

  obj.dueHour.options[currentHour].selected = true;
  obj.dueMinute.options[currentMinute].selected = true;

  for (i=0; i < obj.dueYear.length; i++)
    if (currentYear == obj.dueYear.options[i].text) {
      obj.dueYear.options[i].selected = true;
      break;
    }
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
  duration = obj.endHour.selectedIndex - obj.startHour.selectedIndex
  if (duration >= 0)
    obj.durationHours.options[duration].selected = true;
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
  
  duration = obj.endHour.selectedIndex - obj.startHour.selectedIndex
  if (duration >=0 )
    obj.durationHours.options[duration].selected = true;
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
  if (obj.endHour.selectedIndex + duration > 23)   {
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
  duration = obj.endHour.selectedIndex - obj.startHour.selectedIndex
  if (duration >= 0)
    obj.durationHours.options[duration].selected = true;
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

function changeEndHourEventCalendarForm(obj) {
return; var duration;
  
  duration = obj.endHour.selectedIndex - obj.startHour.selectedIndex
  if (duration >= 0)
    obj.durationHours.options[duration].selected = true;
}

function changeEndMinEventCalendarForm(obj) {
return; var duration;
  
  duration = obj.durationMinutes.selectedIndex;
  duration *= 15;
  obj.startMinute.options[obj.endMinute.selectedIndex - duration].selected = true;
}

function changeStartDayEventCalendarForm(obj) {
  obj.endDay.options[obj.startDay.selectedIndex].selected = true;
  obj.endDay1.options[obj.startDay.selectedIndex].selected = true;
<%--//  obj.repeatStartDay.options[obj.startDay.selectedIndex].selected = true;
//  obj.repeatEndDay.options[obj.startDay.selectedIndex].selected = true;--%>
}
function changeStartMonthEventCalendarForm(obj) {
  obj.endMonth.options[obj.startMonth.selectedIndex].selected = true;
  obj.endMonth1.options[obj.startMonth.selectedIndex].selected = true;
<%--//  obj.repeatStartMonth.options[obj.startMonth.selectedIndex].selected = true;
//  obj.repeatEndMonth.options[obj.startMonth.selectedIndex].selected = true;--%>
}
function changeStartYearEventCalendarForm(obj) {
  obj.endYear.options[obj.startYear.selectedIndex].selected = true;
  obj.endYear1.options[obj.startYear.selectedIndex].selected = true;
<%--//  obj.repeatStartYear.options[obj.startYear.selectedIndex].selected = true;
//  obj.repeatEndYear.options[obj.startYear.selectedIndex].selected = true;--%>
}
function changeEndDayEventCalendarForm(obj) {
return; <%--//  obj.repeatEndDay.options[obj.endDay.selectedIndex].selected = true;--%>
}

function changeEndMonthEventCalendarForm(obj) {
return; <%--//  obj.repeatEndMonth.options[obj.endMonth.selectedIndex].selected = true;--%>
}

function changeEndYearEventCalendarForm(obj) {
return; <%--//  obj.repeatEndYear.options[obj.endYear.selectedIndex].selected = true;--%>
}

function changeRepeatStartDayEventCalendarForm(obj) {
    obj.startDay.options[obj.repeatStartDay.selectedIndex].selected = true;
	obj.startDay1.options[obj.repeatStartDay.selectedIndex].selected = true;
<%--//  obj.repeatEndDay.options[obj.repeatStartDay.selectedIndex].selected = true;--%>
}

function changeRepeatStartMonthEventCalendarForm(obj) {
  obj.startMonth.options[obj.repeatStartMonth.selectedIndex].selected = true;
  obj.startMonth1.options[obj.repeatStartMonth.selectedIndex].selected = true;
<%--//  obj.repeatEndMonth.options[obj.repeatStartMonth.selectedIndex].selected = true;--%>
}
function changeRepeatStartYearEventCalendarForm(obj) {
  obj.startYear.options[obj.repeatStartYear.selectedIndex].selected = true;
   obj.startYear1.options[obj.repeatStartYear.selectedIndex].selected = true;
<%--//  obj.repeatEndYear.options[obj.repeatStartYear.selectedIndex].selected = true;--%>
}
<%--
function changeRepeatEndDayEventCalendarForm(obj) {
  obj.endDay.options[obj.repeatEndDay.selectedIndex].selected = true;
  obj.endDay1.options[obj.repeatEndDay.selectedIndex].selected = true;
}
function changeRepeatEndMonthEventCalendarForm(obj) {
  obj.endMonth.options[obj.repeatEndMonth.selectedIndex].selected = true;
  obj.endMonth1.options[obj.repeatEndMonth.selectedIndex].selected = true;
}
function changeRepeatEndYearEventCalendarForm(obj) {
  obj.endYear.options[obj.repeatEndYear.selectedIndex].selected = true;
   obj.endYear1.options[obj.repeatEndYear.selectedIndex].selected = true;
}
--%>


function checkApptCalendarForm(obj) {
  var canSubmit = true;
  var sameDate = true;
  
<%// Module Manager - Resource
  if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_RESOURCE) ) {%>
  selectAllItems(obj.selectedResources);
<%}// Module Manager - Resource  %>

  if (obj.description.value.replace(/ /g, "") == '') {
    canSubmit = false;
    alert("<%= messages.getString("calendar.addappt.description.required") %>");
  }
  
  if (canSubmit && obj.startYear.selectedIndex > obj.endYear.selectedIndex)  {
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
  
<%// Module Manager - Resource
  if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_RESOURCE) ) {%>
  selectAllItems(obj.resources);
<%}// Module Manager - Resource  %>

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

  if (obj.description.value.replace(/ /g, "") == '') {
    canSubmit = false;
    alert("<%= messages.getString("calendar.addappt.description.required") %>");
  }

  if (canSubmit && obj.userIDassigned.value == "") {
    alert("<%= messages.getString("calendar.todo.select.user") %>");
    canSubmit = false;
  }

  if (canSubmit)
    obj.submit();
}

//-->
</SCRIPT>
<script language = "javascript" src ="template/default/moveItem.js"></script>
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
		<% if (action.equals("addToDo")) {%>
			To Do
		<% } else if (action.equals("getFreeTimeSlot")) { %>
			Free Time Slot
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
    <TD width="53%" VALIGN="MIDDLE"><FONT FACE="Arial" SIZE="2" COLOR="#FFFFFF"></FONT>&nbsp;<FONT FACE="Arial" SIZE="2" COLOR="#FFFFFF"></FONT>&nbsp;<FONT FACE="Arial" SIZE="2" COLOR="#FFFFFF"></FONT></TD>
    <TD width="47%" ALIGN="RIGHT" VALIGN="MIDDLE">&nbsp;</TD>
  </TR>
  </FORM>
 
  <TR>
    <TD ALIGN="CENTER" CLASS="sideTitleBgBorderColor" BGCOLOR="#003399"><div align="left"><FONT SIZE="2" FACE="Arial" COLOR="#FFFFFF"><B><%= calendarAddHeaderName %></B></FONT> </div></TD>
	<TD ALIGN="CENTER" CLASS="sideTitleBgBorderColor" BGCOLOR="#003399"><div align="right">
	  <select name="select" onChange="calDispatch(this.value);">
	    <option value="addAppt"><%= messages.getString("select") %></option>
	    <option value="addAppt"><%= messages.getString("calendar.appointment") %></option>
	    <option value="addToDo"><%= messages.getString("calendar.todo.task") %></option>
	    <option value="getFreeTimeSlot">Free Time Slot</option>
	    </select>
	  </div></TD>
  </TR>
</TABLE>

<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
  <TR>
    <TD BGCOLOR="#EFEFEF" VALIGN="TOP" CLASS="contentBgColor" COLSPAN="2"><IMG SRC="images/system/blank.gif" WIDTH="83" HEIGHT="10"></TD>
  </TR>
<!-- CALENDAR ADD APPT HEADER END -->
