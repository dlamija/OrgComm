<link rel="stylesheet" type="text/css" media="all" href="js/calendar/jsDatePick_ltr.min.css" />
<script language="javascript"> 
function toggle2(showHideDiv, switchTextDiv) {
	var ele = document.getElementById(showHideDiv);
	var text = document.getElementById(switchTextDiv);
	if(ele.style.display == "block") {
    		ele.style.display = "none";
		text.innerHTML = "View Calendar";
  	}
	else {
		ele.style.display = "block";
		text.innerHTML = "Close Calendar";
	}
}</script>

<script type="text/javascript" src="js/calendar/jquery.1.4.2.js"></script>
<script type="text/javascript" src="js/calendar/jsDatePick.jquery.min.1.3.js"></script>
<script type="text/javascript">
	window.onload = function(){		
		
		g_globalObject = new JsDatePick({
			useMode:1,
			isStripped:true,
			target:"startDate"
			
		});
		
		g_globalObject.setOnSelectedDelegate(function(){
			var obj = g_globalObject.getSelectedDay();
			//alert("a date was just selected and the date is : " + obj.day + "/" + obj.month + "/" + obj.year);
			//document.getElementById("div3_example_result").innerHTML = obj.day + "/" + obj.month + "/" + obj.year;
			document.calendarAppt.startTarikh.value =  obj.day + "-" + obj.month + "-" + obj.year;;
			document.calendarAppt.startDay.value = obj.day;
			document.calendarAppt.startMonth.value = obj.month;
			document.calendarAppt.startYear.value = obj.year;
		});	
		
		
		g_globalObject2 = new JsDatePick({
			useMode:1,
			isStripped:true,
			target:"endDate"
			
		});
		
		g_globalObject2.setOnSelectedDelegate(function(){
			var obj = g_globalObject2.getSelectedDay();
			//alert("a date was just selected and the date is : " + obj.day + "/" + obj.month + "/" + obj.year);
			//document.getElemenndtById("div3_example_result").innerHTML = obj.day + "/" + obj.month + "/" + obj.year;
			document.calendarAppt.endDay.value = obj.day;
			document.calendarAppt.endMonth.value = obj.month;
			document.calendarAppt.endYear.value = obj.year;
			
		});		
		
	};
</script>

<jsp:useBean id="staffStudent" scope="request" class="common.StaffStudent"/>
<%@ page import="ecomm.bean.ResourceDBNew, paulUtil.ConvUtil, utilities.RecipientUtil,common.*" %>
<%
  String userType = staffStudent.getUserType(request,response, userID);

  int i,parameterInt=-1;
  Vector resourceIDs=null, resourceName=null, resourceApproval=null, resourceList=null,vParameter=null;
  String resourceID="",parameterStr="";
  TvoContextManager.removeSessionAttribute(request, "Calendar.vConflicts");
  String[] compulsoryAttendeesArr = request.getParameterValues("compulsoryAttendees");
  String[] attendeesArr = request.getParameterValues("attendees");
  String[] resources = request.getParameterValues("resources");

  // Module Manager - Resource
 /* if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_RESOURCE) ) {
    resourceList = beanResource.showModule(request, userID, "Resource", "calView", "resourceName", "asc", 0, 0);
    if (request.getParameter("resourceID") != null)
      resourceID = request.getParameter("resourceID");

    if (resourceList != null && resourceList.size() > 0) {
      resourceIDs = (Vector) resourceList.get(0);
      resourceName = (Vector) resourceList.get(1);
      resourceApproval = (Vector) resourceList.get(5);
    }
  }  // Module Manager - Resource   */
%>
 
 <%
 	ResourceDBNew dbResource = null;
 	Vector vList = (Vector) beanResource.showModuleResources(userType);

	for(int w=0; w<vList.size(); w++) {
		dbResource = (ResourceDBNew) vList.get(w);
		dbResource.getReferenceID();
	}
	
	StringBuffer resID = new StringBuffer();
	StringBuffer resName = new StringBuffer();
	StringBuffer resType = new StringBuffer();
	
	for (int w=0; w<vList.size(); w++) {
		ResourceDBNew resourceDB = (ResourceDBNew) vList.get(w);
		resID.append("'" + resourceDB.getResourceID() + "',");
		resName.append("'" + CommonFunction.escapeQuote(CommonFunction.restrictNameLength(resourceDB.getResourceDesc(), 50)) + "',");
		resType.append("\"'" + resourceDB.getReferenceID() + "'\",");
	}
	if (!resID.toString().equals("")) {
		resID   = new StringBuffer().append(resID.substring(0, resID.length()-1));
		resName = new StringBuffer().append(resName.substring(0, resName.length()-1));
		resType = new StringBuffer().append(resType.substring(0, resType.length()-1));
	}
 %>
 <SCRIPT LANGUAGE="JavaScript">
   resID   = new Array(<%= resID %>)
   resName = new Array(<%= resName %>)
   resType = new Array(<%= resType %>)	 
 </SCRIPT>

<script>
<!--
	var recipientWin;
	
 	function recipientPopup() {
		if (recipientWin == null || recipientWin.closed) {
			recipientWin = window.open('calendarrecipient.jsp', 'recipientPopup', 'width=600,height=450,resizable=yes,scrollbars=yes');
		}
		recipientWin.focus();
	}
	
	function getRecipient(columnName) {
		var myFormField = eval("document.calendarAppt." + columnName);
		if (myFormField != null) {
			return(myFormField.value);
		} else {
			return("");
		}
	}
	
	function updateRecipient(columnName, newValue) {
		var myFormField = eval("document.calendarAppt." + columnName);
		if (myFormField != null) {
			myFormField.value = newValue;
		}
	}
	
	function updateDisplay(columnType, newValue) {
		var myFormField = eval("document.calendarAppt.dispRecipient" + columnType);
		if (myFormField != null) {
			myFormField.value = newValue;
		}
	}
//-->
</script>

 <FORM NAME="calendarAppt" METHOD="POST" ACTION="Calendar?action=addCheckAppt">

    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" WIDTH="32%" ALIGN="RIGHT" VALIGN="MIDDLE"><%= messages.getString("calendar.addappt.start.date") %>&nbsp; </TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" WIDTH="68%" VALIGN="TOP">
       <input name="startTarikh" type="text" id="startTarikh" size="10" readonly>
       <input name="startDay" type="hidden" id="startDay" size="2">
    <input name="startMonth" type="hidden" id="startMonth" size="2">
        <input name="startYear" type="hidden" id="startYear" size="2"> 
       <a id="myHeader1" href="javascript:toggle2('myContent1','myHeader1');" >View Calendar</a>
       <!--a id="displayText" href="javascript:toggle();">show</a -->
      <div id="myContent1" style="position:absolute; width: 205px; height: 230px; left: 520px; top: 340px; display:none">
       <div id="startDate" style="margin:10px 0 30px 0; border: solid 2px black; width:205px; height:210px; background-color:#FFF">
    	
    </div>
</div>
        
      </TD>
    </TR>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" WIDTH="32%" ALIGN="RIGHT" VALIGN="MIDDLE"><%= messages.getString("calendar.addappt.end.date") %>&nbsp; </TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" WIDTH="68%" VALIGN="TOP">                              
	   
        <select name="endDay" onChange="changeEndDayEventCalendarForm(document.calendarAppt);">
		<%  for (i=1;i<32;i++) {  %>
			  <option value="<%= ( i>0 && i<10 ? "0":"")+i %>" <% if (parameterInt > -1 && parameterInt == i ) { %> SELECTED<% } %>><%= ( i>0 && i<10 ? "0":"")+i %> </option>
		<%	} %>		
        </select>
		
		<% 
		    if (request.getParameter("endMonth") != null) {
			  parameterStr = request.getParameter("endMonth");
			}
		%>
		
        <SELECT NAME="endMonth" onChange="changeEndMonthEventCalendarForm(document.calendarAppt);">
          <OPTION VALUE="01" <% if (!parameterStr.equals("") && parameterStr.equals("01") ) { %> SELECTED<% } %>><%= messages.getString("short.jan") %></option>
          <OPTION VALUE="02" <% if (!parameterStr.equals("") && parameterStr.equals("02") ) { %> SELECTED<% } %>><%= messages.getString("short.feb") %></OPTION>
          <OPTION VALUE="03" <% if (!parameterStr.equals("") && parameterStr.equals("03") ) { %> SELECTED<% } %>><%= messages.getString("short.mar") %></OPTION>
          <OPTION VALUE="04" <% if (!parameterStr.equals("") && parameterStr.equals("04") ) { %> SELECTED<% } %>><%= messages.getString("short.apr") %></OPTION>
          <OPTION VALUE="05" <% if (!parameterStr.equals("") && parameterStr.equals("05") ) { %> SELECTED<% } %>><%= messages.getString("short.may") %></OPTION>
          <OPTION VALUE="06" <% if (!parameterStr.equals("") && parameterStr.equals("06") ) { %> SELECTED<% } %>><%= messages.getString("short.jun") %></OPTION>
          <OPTION VALUE="07" <% if (!parameterStr.equals("") && parameterStr.equals("07") ) { %> SELECTED<% } %>><%= messages.getString("short.jul") %></OPTION>
          <OPTION VALUE="08" <% if (!parameterStr.equals("") && parameterStr.equals("08") ) { %> SELECTED<% } %>><%= messages.getString("short.aug") %></OPTION>
          <OPTION VALUE="09" <% if (!parameterStr.equals("") && parameterStr.equals("09") ) { %> SELECTED<% } %>><%= messages.getString("short.sep") %></OPTION>
          <OPTION VALUE="10" <% if (!parameterStr.equals("") && parameterStr.equals("10") ) { %> SELECTED<% } %>><%= messages.getString("short.oct") %></OPTION>
          <OPTION VALUE="11" <% if (!parameterStr.equals("") && parameterStr.equals("11") ) { %> SELECTED<% } %>><%= messages.getString("short.nov") %></OPTION>
          <OPTION VALUE="12" <% if (!parameterStr.equals("") && parameterStr.equals("12") ) { %> SELECTED<% } %>><%= messages.getString("short.dec") %></OPTION>
        </SELECT>
		
		<%
   		    if (request.getParameter("endYear") != null) {
		     parameterInt = Integer.parseInt(request.getParameter("endYear"));		
		    }
	    %>

        <SELECT NAME="endYear" onChange="changeEndYearEventCalendarForm(document.calendarAppt);">
        <%
        for (i=Integer.parseInt((String)TvoContextManager.getAttribute(request, "System.startYear"));
             i <= Integer.parseInt((String)TvoContextManager.getAttribute(request, "System.endYear"));
             i++)
        {
          %><OPTION VALUE="<%= i %>" <% if (parameterInt > -1 && parameterInt == i ) { %> SELECTED<% } %>><%= i %></OPTION><%
        }
        %>
        </SELECT>
      </TD>
    </TR>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" COLSPAN="2" VALIGN="MIDDLE">&nbsp;&nbsp;</TD>
    </TR>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" WIDTH="32%" ALIGN="RIGHT" VALIGN="MIDDLE"><%= messages.getString("calendar.addappt.start.time") %>&nbsp;  </TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" WIDTH="68%" VALIGN="TOP">
	  <% 
	      if (request.getParameter("startHour") != null) {
             parameterInt = Integer.parseInt(request.getParameter("startHour"));		
		  }
	   %>

        <SELECT NAME="startHour" onChange="changeStartHourApptCalendarForm(document.calendarAppt);">
		<%
		    for (i=0;i<24;i++) {
		%>
		    <option value="<%= ( i>=0 && i<10 ? "0":"")+i %>" <% if (parameterInt > -1 && parameterInt == i ) { %> SELECTED<% } %>> <%= ( i>=0 && i<10 ? "0":"")+i %> </option>
		<%
			}
		%>
        </SELECT> :
   	    <% 
            if (request.getParameter("startMinute") != null) {
             parameterInt = Integer.parseInt(request.getParameter("startMinute"));		
		    }
	    %>

        <SELECT NAME="startMinute" onChange="changeStartMinApptCalendarForm(document.calendarAppt);">
		<%
		    for (i=0;i<46;i+=15) {
		%>
		    <option value="<%= ( i==0 ? "0":"")+i %>" <% if (parameterInt > -1 && parameterInt == i ) { %> SELECTED<% } %>> <%= ( i==0 ? "0":"")+i %> </option>
		<%
			}			
		%>
        </SELECT>
      </TD>
    </TR>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" WIDTH="32%" ALIGN="RIGHT" VALIGN="MIDDLE"><%= messages.getString("calendar.addappt.end.time") %>&nbsp; </TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" WIDTH="68%" VALIGN="TOP">
	   <% 
	      if (request.getParameter("endHour") != null) {
             parameterInt = Integer.parseInt(request.getParameter("endHour"));		
		  }
	   %>
        <select name="endHour" onChange="changeEndHourApptCalendarForm(document.calendarAppt);">
		<% for (i=0;i<24;i++) { %>
		     <option value="<%= ( i>=0 && i<10 ? "0":"")+i %>" <% if (parameterInt > -1 && parameterInt == i ) { %> SELECTED<% } %>> <%= ( i>=0 && i<10 ? "0":"")+i %> </option>
		<% } %>

        </select> :
		<% 
	      if (request.getParameter("endMinute") != null) {
             parameterInt = Integer.parseInt(request.getParameter("endMinute"));		
		  }
	    %>
        <select name="endMinute" onChange="changeEndMinApptCalendarForm(document.calendarAppt);">
		<% for (i=0;i<46;i+=15) { %>
		     <option value="<%= ( i==0 ? "0":"")+i %>" <% if (parameterInt > -1 && parameterInt == i ) { %> SELECTED<% } %>> <%= ( i==0 ? "0":"")+i %> </option>
		<% } %>
        </select> <input type="checkbox" name="allDayEvent" value="1" <%= request.getParameter("allDayEvent") != null && !request.getParameter("allDayEvent").equals("null") ? " CHECKED" : ""  %>><%= messages.getString("calendar.appointment.all.day.event") %>
      </TD>
    </TR>
		
		
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT" VALIGN="MIDDLE">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="MIDDLE">&nbsp;</TD>
    </TR>
    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT" VALIGN="MIDDLE"><%= messages.getString("calendar.addappt.set.reminder") %>&nbsp;&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="MIDDLE">
	  <% 
	      if (request.getParameter("reminderSetting") != null) {
             parameterStr = request.getParameter("reminderSetting");		
		  }
	  %>

        <SELECT NAME="reminderSetting">
          <OPTION value="0" <% if (!parameterStr.equals("") && parameterStr.equals("0") ) { %> SELECTED<% } %>><%= messages.getString("none") %></OPTION>
          <OPTION value="1" <% if (!parameterStr.equals("") && parameterStr.equals("1") ) { %> SELECTED<% } %>><%= messages.getString("calendar.addappt.reminder.one.day") %></OPTION>
          <OPTION value="3" <% if (!parameterStr.equals("") && parameterStr.equals("3") ) { %> SELECTED<% } %>><%= messages.getString("calendar.addappt.reminder.three.day") %></OPTION>
          <OPTION value="5" <% if (!parameterStr.equals("") && parameterStr.equals("5") ) { %> SELECTED<% } %>><%= messages.getString("calendar.addappt.reminder.five.day") %></OPTION>
          <OPTION value="7" <% if (!parameterStr.equals("") && parameterStr.equals("7") ) { %> SELECTED<% } %>><%= messages.getString("calendar.addappt.reminder.one.week") %></OPTION>
          <OPTION value="14" <% if (!parameterStr.equals("") && parameterStr.equals("14") ) { %> SELECTED<% } %>><%= messages.getString("calendar.addappt.reminder.two.week") %></OPTION>
        </SELECT>
      </TD>
    </TR>
	<!-- Start: added by Osman for apppintment status -->
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT" VALIGN="MIDDLE">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="MIDDLE">&nbsp;</TD>
    </TR>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT" VALIGN="TOP">Status &nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="TOP">
		<select id="official" name="official">
			<option value="1" selected="selected">Official</option>
			<option value="0">Unofficial</option>
		</select>
      </TD>
    </TR>
	<!-- End: added by Osman -->
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT" VALIGN="MIDDLE">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="MIDDLE">&nbsp;</TD>
    </TR>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT" VALIGN="TOP"><%= messages.getString("calendar.addappt.description") %> &nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="TOP">
	  <% 
	      if (request.getParameter("description") != null) {		     
             parameterStr = request.getParameter("description");		
		  }
	  %>

        <TEXTAREA NAME="description" COLS="23" ROWS="4" wrap><%= parameterStr %></TEXTAREA>
      </TD>
    </TR>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT" VALIGN="TOP">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="TOP">&nbsp;</TD>
    </TR>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT" VALIGN="TOP"><%= messages.getString("calendar.addappt.agenda") %> &nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="TOP">
  	  <% 
	      if (request.getParameter("agenda") != null) {		     
             parameterStr = request.getParameter("agenda");		
		  }
	  %>

        <TEXTAREA NAME="agenda" COLS="23" ROWS="4" wrap><%= parameterStr %></TEXTAREA>
      </TD>
    </TR>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" ALIGN="RIGHT" VALIGN="TOP">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" VALIGN="TOP">&nbsp;</TD>
    </TR>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT" VALIGN="TOP"><%= messages.getString("calendar.addappt.location") %> &nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="TOP">
   	  <% 
	      if (request.getParameter("location") != null)
             parameterStr = request.getParameter("location");		
	  %>

      <INPUT NAME="location" VALUE="<%= parameterStr %>" SIZE="24">
      </TD>
    </TR>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" VALIGN="TOP">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="TOP">&nbsp;</TD>
    </TR>
		
		<TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" VALIGN="TOP">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="TOP"><input type ="checkbox" name="excludeScheduler" value="1" <%= request.getParameter("excludeScheduler") != null && !request.getParameter("excludeScheduler").equals("null") ? " CHECKED" : ""  %>><%= messages.getString("calendar.appointment.exclude.scheduler") %></TD>
    </TR>
	
		<TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" VALIGN="TOP">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="TOP">&nbsp;</TD>
    </TR>
  
<% if (!userType.equals("STUDENT")) { %>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2">
      <TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0">
      <TR><TD CLASS="contentBgColor" COLSPAN="3">
      <%
      	String compulsoryAttendees = "";
     	if (compulsoryAttendeesArr != null) {
	      	compulsoryAttendees = ConvUtil.stringArrayToString(compulsoryAttendeesArr);
      	}
      	
      	String dispRecipientComp = "";
      	if (!compulsoryAttendees.equals("")) {
	      	RecipientUtil rUtil = new RecipientUtil();
	      	rUtil.initTVO(request);
	      	dispRecipientComp = rUtil.getUserNames(ConvUtil.stringToStringArray(compulsoryAttendees));
	      	
	      	if (dispRecipientComp.endsWith(",")) {
		      	dispRecipientComp = dispRecipientComp.substring(0, dispRecipientComp.length() - 1);
	      	}
	      	dispRecipientComp = CommonFunction.restrictNameLength(dispRecipientComp, 200);
      	}
      %>
      <a href="javascript: recipientPopup();"><%= messages.getString("calendar.addappt.compulsory.attendees") %></a><BR>
      <input type="hidden" name="compulsoryAttendees" value="<%=compulsoryAttendees%>">
      <textarea name="dispRecipientComp" rows="3" cols="40" readonly><%=dispRecipientComp%></textarea>
      </TD></TR>
      </TABLE>
      </TD>
    </TR>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" ALIGN="RIGHT" VALIGN="TOP">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" VALIGN="TOP">&nbsp;</TD>
    </TR>
<%  }
%>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2">
      <TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0">
      <TR><TD CLASS="contentBgColor" COLSPAN="3">
      <%
      	String attendees = "";
      	if (attendeesArr != null) {
      		attendees = ConvUtil.stringArrayToString(attendeesArr);
      	}
      	
      	String dispRecipientOpt = "";
      	if (!attendees.equals("")) {
	      	RecipientUtil rUtil = new RecipientUtil();
	      	rUtil.initTVO(request);
	      	dispRecipientOpt = rUtil.getUserNames(ConvUtil.stringToStringArray(attendees));
	      	
	      	if (dispRecipientOpt.endsWith(",")) {
		      	dispRecipientOpt = dispRecipientOpt.substring(0, dispRecipientOpt.length() - 1);
	      	}
	      	dispRecipientOpt = CommonFunction.restrictNameLength(dispRecipientOpt, 200);
      	}
      %>
      <a href="javascript: recipientPopup();"><%= messages.getString("calendar.addappt.attendees") %></a><BR>
      <input type="hidden" name="attendees" value="<%=attendees%>">
      <textarea name="dispRecipientOpt" rows="3" cols="40" readonly><%=dispRecipientOpt%></textarea>
      </TD></TR>
      </TABLE>
      </TD>
    </TR>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" VALIGN="TOP">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="TOP">&nbsp;</TD>
    </TR>
<% // Module Manager - Resource
  if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_RESOURCE) ) { %>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2">
      <TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0">
      <TR><TD CLASS="contentBgColor" COLSPAN="3">
      <%= messages.getString("calendar.addappt.resources") %>
      </TD></TR>
      <TR><TD CLASS="contentBgColor" VALIGN="TOP" colspan="3">
        <select name="typeID" SIZE="1" onChange="loadGroupItems(this.options[this.selectedIndex].value, resType, resName, resID, document.calendarAppt.allResources, '<%= messages.getString("none.with.line") %>', -1, document.calendarAppt.selectedResources);">
          <option value="0" SELECTED><%= messages.getString("select") %></option>
          <option value="-1">All resources</option>
          <option value="FA">Asset</option>
          <option value="RM">Room</option>
        </select><br>
      </TD></TR>
      <TR><TD CLASS="contentBgColor" VALIGN="TOP">
        <select name="allResources" size="5" multiple>
        </select>
      </TD>
      <TD CLASS="contentBgColor" ALIGN="CENTER" VALIGN="MIDDLE" >
      <A HREF="javascript:moveItems(document.calendarAppt.allResources, document.calendarAppt.selectedResources, '<%= messages.getString("none.with.line") %>', -1);" onMouseOver="window.status='<%= messages.getString("add") %>';return true;"><IMG SRC="images/system/ic_rightarrow.gif" BORDER="0" ALT="<%= messages.getString("add") %>"></A><BR><BR>
      <A HREF="javascript:moveItems(document.calendarAppt.selectedResources, document.calendarAppt.allResources, '<%= messages.getString("none.with.line") %>', -1);" onMouseOver="window.status='<%= messages.getString("email.remove") %>';return true;"><IMG SRC="images/system/ic_leftarrow.gif" BORDER="0" ALT="<%= messages.getString("email.remove") %>"></A>
      </TD>
      <TD CLASS="contentBgColor" VALIGN="TOP">
        <select name="selectedResources" size="5" multiple>		
        </select>
      </TD>     
      </TR>
	  
	  
      <TR><TD CLASS="contentBgColor" ALIGN="LEFT" VALIGN="TOP">
      <A HREF="javascript:selectAllItems(document.calendarAppt.allResources);" onMouseOver="window.status='<%= messages.getString("select.all") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_selectall.gif\" BORDER=\"0\" ALT=\"Select All\">" : messages.getString("select.all") %></A> 
      <A HREF="javascript:clearAllItems(document.calendarAppt.allResources);" onMouseOver="window.status='<%= messages.getString("clear.all") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_clear.gif\" BORDER=\"0\" ALT=\"Clear All Selected\">" : messages.getString("clear.all") %></A>
      </TD>
      <TD CLASS="contentBgColor">&nbsp;</TD>
      <TD CLASS="contentBgColor" ALIGN="LEFT" VALIGN="TOP">
      <A HREF="javascript:selectAllItems(document.calendarAppt.selectedResources);" onMouseOver="window.status='<%= messages.getString("select.all") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_selectall.gif\" BORDER=\"0\" ALT=\"Select All\">" : messages.getString("select.all") %></A> 
      <A HREF="javascript:clearAllItems(document.calendarAppt.selectedResources);" onMouseOver="window.status='<%= messages.getString("clear.all") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_clear.gif\" BORDER=\"0\" ALT=\"Clear All Selected\">" : messages.getString("clear.all") %></A>
      </TD></TR>
      </TABLE>
      </TD>
    </TR>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" VALIGN="TOP">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="TOP">&nbsp;</TD>
    </TR>
<% }// Module Manager - Resource %>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT" VALIGN="TOP"><%= messages.getString("calendar.addappt.notify.method") %>: &nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="TOP">
	  <% 
	   
       parameterStr = "1,";
	     if (request.getParameter("notifyMethod") != null) {
				  parameterStr = request.getParameter("notifyMethod");
	     }
			 StringTokenizer stk = new StringTokenizer(parameterStr,",");
			 String memoCheck = "",emailCheck="";
			 while (stk.hasMoreTokens()) {
			   parameterStr = stk.nextToken();
				 if (parameterStr.equals("1")) {
				   memoCheck = " CHECKED";
				 }
				 else if (parameterStr.equals("2")) {
 				   emailCheck = " CHECKED";
				 }
			 }
			 
	  %>
	     <INPUT TYPE="checkbox" NAME="notifyMemo" <%= memoCheck %>><%= messages.getString("memo") %> &nbsp;				 
	     <INPUT TYPE="checkbox" NAME="notifyEmail" <%= emailCheck %>><%= messages.getString("email") %> &nbsp;

	  
      </TD>
    </TR>
    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT" VALIGN="MIDDLE">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="MIDDLE">&nbsp;</TD>
    </TR>
    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT"><%= messages.getString("calendar.addappt.notify.note") %> &nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%">
  	  <% 
	     parameterStr = "";
	     if (request.getParameter("notifyInfo") != null) {
           parameterStr = request.getParameter("notifyInfo");		
	     }
	  %>

        <TEXTAREA NAME="notifyInfo" COLS="23" ROWS="4" wrap><%= parameterStr %></TEXTAREA>
      </TD>
    </TR>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" VALIGN="TOP">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="TOP">&nbsp;</TD>
    </TR>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT" VALIGN="TOP"><%= messages.getString("calendar.addappt.viewing.status") %> &nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="TOP">
   	  <% 
	     parameterStr = "1";
	     if (request.getParameter("publicFlag") != null) {
           parameterStr = request.getParameter("publicFlag");		
	     }
	  %>

        <INPUT TYPE="radio" NAME="publicFlag" VALUE="1" <% if (parameterStr.equals("1") ) { %> CHECKED<% } %>> <%= messages.getString("calendar.addappt.public") %> 
        <INPUT TYPE="radio" NAME="publicFlag" VALUE="0" <% if (parameterStr.equals("0") ) { %> CHECKED<% } %>> <%= messages.getString("calendar.addappt.private") %>
        </FONT>
      </TD>
    </TR>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" VALIGN="TOP">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="TOP">&nbsp;</TD>
    </TR>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" VALIGN="TOP">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="TOP">
	  	<INPUT TYPE="checkbox" NAME="addAttachments" VALUE="1"> Add Attachments
	  </TD>
    </TR>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" VALIGN="TOP">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="TOP">&nbsp;</TD>
    </TR>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" VALIGN="TOP">
        <P>&nbsp;</P>
      </TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="TOP">
      <A HREF="javascript:checkApptCalendarForm(document.calendarAppt);" onMouseOver="window.status='<%= messages.getString("save") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_save.gif\" WIDTH=\"34\" HEIGHT=\"18\" BORDER=\"0\" ALT=\"Save\">" : messages.getString("save") %></A> <A HREF="javascript:location='calendar.jsp';" onMouseOver="window.status='<%= messages.getString("cancel") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_cancel.gif\" WIDTH=\"40\" HEIGHT=\"18\" BORDER=\"0\" ALT=\"Cancel\">" : messages.getString("cancel") %></A></TD>
    </TR>
  </FORM>

<SCRIPT LANGUAGE="JavaScript">
<%
  if (parameterInt == -1) { %>  
  setApptCalendarForm(document.calendarAppt);
<% } %>  
  obj = document.calendarAppt;
  noItems(obj.allResources, '<%= messages.getString("none.with.line") %>', -1);
  noItems(obj.selectedResources, '<%= messages.getString("none.with.line") %>', -1);
</SCRIPT>


