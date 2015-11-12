<jsp:useBean id="beanEventACL" scope="request" class="ecomm.bean.ACL" />
<%
  int i, j,parameterInt=-1;
  boolean accessLevel = false;
  Hashtable userEventACL, groupEventGroupACL;
  beanEventACL.initTVO(request);

  userEventACL = beanEventACL.getRights(userID, "Event", "User");
  groupEventGroupACL = beanEventACL.getRights(userID, "Event", "Group");

  if ( (userEventACL.containsKey("add") && userEventACL.get("add").equals("1") ) ||
       (groupEventGroupACL.containsKey("add") &&  groupEventGroupACL.get("add").equals("1")) )
    accessLevel = true;

  
  Vector vResources=null,vParameter=null;
  Vector vEvent2ID=null, vResourceID=null;
  Vector resourceList=null, resourceIDs=null, resourceName=null, resourceApproval=null;

  // Module Manager - Resource
  if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_RESOURCE) ) {
    resourceList = beanResource.showModule(request, userID, "Resource", "calView", "resourceName", "asc", 0, 0);

    if (resourceList != null && resourceList.size() > 0) {
      resourceIDs = (Vector) resourceList.get(0);
      resourceName = (Vector) resourceList.get(1);
      resourceApproval = (Vector) resourceList.get(5);
    }
  }

  Vector vEvents=null;
  Vector vEventID=null,vStartDate=null,vStartTime=null,vEndDate=null,vEndTime=null,
         vDescription=null, vLocation=null, vReminderDate=null, vRepeatDay=null,
         vRepeatStartDate=null, vRepeatEndDate=null, vPublicFlag=null, vPublicEvent=null;
  String eventID=null,parameterStr="",tPublicEvent="";
  String editDate=null, editMonth=null, editYear=null, editHour=null, editMinute=null;
  String reminderDate=null,prevReminderDate="", selected="", repeatDay=null;
  StringTokenizer st;

  eventID = request.getParameter("eventID");
  vEvents = (Vector)beanCalendar.getEventByID(userID,eventID);
  if (vEvents != null && vEvents.size() > 0) {
    vEventID = (Vector)vEvents.get(0);
    vStartDate = (Vector)vEvents.get(1);
    vStartTime = (Vector)vEvents.get(2);
    vEndDate = (Vector)vEvents.get(3);
    vEndTime = (Vector)vEvents.get(4);
    vDescription = (Vector)vEvents.get(5);
    vLocation = (Vector)vEvents.get(6);
    vReminderDate = (Vector)vEvents.get(7);
    vRepeatDay = (Vector)vEvents.get(8);
    vRepeatStartDate = (Vector)vEvents.get(9);
    vRepeatEndDate = (Vector)vEvents.get(10);
    vPublicFlag = (Vector)vEvents.get(11);
    vPublicEvent = (Vector)vEvents.get(12);


    // Module Manager - Resource
    if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_RESOURCE) ) {
      vResources= (Vector)vEvents.get(13);
 
      if (vResources !=null && vResources.size() > 0) {
        vEvent2ID= (Vector)vResources.get(0);
        vResourceID= (Vector)vResources.get(1);
      }
    }
  }

  
   if (vReminderDate != null && vReminderDate.size() > 0)
    if ((String)vReminderDate.get(0) != null) {
      prevReminderDate = (String)vReminderDate.get(0);
			reminderDate = CommonFunction.parseDate(dateFormat,currentLocale,(String)vReminderDate.get(0),null,TvoConstants.DATE_FOMRAT_SHORT);
//      reminderDate = CommonFunction.getDate("yyyy-MM-dd", dateFormat, (String)vReminderDate.get(0));
    }
    else
      reminderDate = messages.getString("none");
  else
    reminderDate = messages.getString("none");

	
  if (request.getParameter("startDay") != null) 
    parameterInt = Integer.parseInt(request.getParameter("startDay"));
%>
<FORM NAME="calendarEvent" METHOD="POST" ACTION="servlet/Calendar?action=editCheckEvent">
<INPUT TYPE="HIDDEN" NAME="eventID" VALUE="<%= eventID %>">
<INPUT TYPE="HIDDEN" NAME="prevReminderDate" VALUE="<%= prevReminderDate %>">
  
    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" WIDTH="32%" ALIGN="RIGHT" VALIGN="MIDDLE"><%= messages.getString("calendar.addappt.start.date") %>&nbsp; </TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" WIDTH="68%">
        <SELECT NAME="startDay" onChange="changeStartDayEventCalendarForm(document.calendarEvent);">
		<%  for (i=1;i<32;i++) {  %>
			  <option value="<%= ( i>0 && i<10 ? "0":"")+i %>"<% if (parameterInt > -1 && parameterInt == i ) { %> SELECTED<% } %>><%= ( i>0 && i<10 ? "0":"")+i %> </option>
		<%	}  %>		
        </SELECT>
		<%  if (request.getParameter("startMonth") != null) 
		      parameterStr = request.getParameter("startMonth");
		%>
        <SELECT NAME="startMonth" onChange="changeStartMonthEventCalendarForm(document.calendarEvent);">
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
		 <%  if (request.getParameter("startYear") != null) 
		      parameterInt = Integer.parseInt(request.getParameter("startYear"));
		 %>		 
        <SELECT NAME="startYear" onChange="changeStartYearEventCalendarForm(document.calendarEvent);">
        <%
            for (i=Integer.parseInt((String)TvoContextManager.getAttribute(request, "System.startYear"));
                 i <= Integer.parseInt((String)TvoContextManager.getAttribute(request, "System.endYear"));
                 i++)
			{
        %>
		     <OPTION VALUE="<%= i %>" <% if (parameterInt > -1 && parameterInt == i ) { %> SELECTED<% } %>><%= i %></OPTION>
	    <%  }  %>
        </SELECT>
      </TD>
    </TR>
    <%  if (request.getParameter("endDay") != null) 
 	      parameterInt = Integer.parseInt(request.getParameter("endDay"));	
	%>
    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" WIDTH="32%" ALIGN="RIGHT" VALIGN="MIDDLE"><%= messages.getString("calendar.addappt.end.date") %>&nbsp; </TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" WIDTH="68%">
        <SELECT NAME="endDay" onChange="changeEndDayEventCalendarForm(document.calendarEvent);">
        <%  for (i=1;i<32;i++) {  %>
			  <option value="<%= ( i>0 && i<10 ? "0":"")+i %>"<% if (parameterInt > -1 && parameterInt == i ) { %> SELECTED<% } %>><%= ( i>0 && i<10 ? "0":"")+i %> </option>
		<%	}  %>		
        </SELECT>
		<%  if (request.getParameter("endMonth") != null) 
		      parameterStr = request.getParameter("endMonth");
		%>
        <SELECT NAME="endMonth" onChange="changeEndMonthEventCalendarForm(document.calendarEvent);">
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
	    <%  if (request.getParameter("endYear") != null) 
		      parameterInt = Integer.parseInt(request.getParameter("endYear"));
		 %>		 

        <SELECT NAME="endYear" onChange="changeEndYearEventCalendarForm(document.calendarEvent);">
        <%
            for (i=Integer.parseInt((String)TvoContextManager.getAttribute(request, "System.startYear"));
                 i <= Integer.parseInt((String)TvoContextManager.getAttribute(request, "System.endYear"));
                 i++)
			{
        %>
		     <OPTION VALUE="<%= i %>" <% if (parameterInt > -1 && parameterInt == i ) { %> SELECTED<% } %>><%= i %></OPTION>
	    <%  }  %>
        </SELECT>
      </TD>
    </TR>
    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" COLSPAN="2" VALIGN="MIDDLE">&nbsp;&nbsp;</TD>
    </TR>
    <%  if (request.getParameter("startHour") != null) 
		     parameterInt = Integer.parseInt(request.getParameter("startHour"));		
    %>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" WIDTH="32%" ALIGN="RIGHT" VALIGN="MIDDLE"><%= messages.getString("calendar.addappt.start.time") %>&nbsp;  </TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" WIDTH="68%" VALIGN="TOP">
        <SELECT NAME="startHour" onChange="changeStartHourEventCalendarForm(document.calendarEvent);">
      		<%  for (i=0;i<24;i++) {  %>
		      <option value="<%= ( i>=0 && i<10 ? "0":"")+i %>" <% if (parameterInt > -1 && parameterInt == i ) { %> SELECTED<% } %>> <%= ( i>=0 && i<10 ? "0":"")+i %> </option>
		<%	}  %>
        </SELECT> :
   	    <%  if (request.getParameter("startMinute") != null) 
		      parameterInt = Integer.parseInt(request.getParameter("startMinute"));		
        %>

        <SELECT NAME="startMinute" onChange="changeStartMinEventCalendarForm(document.calendarEvent);">
		<%  for (i=0;i<46;i+=15) {  %>
		      <option value="<%= ( i==0 ? "0":"")+i %>" <% if (parameterInt > -1 && parameterInt == i ) { %> SELECTED<% } %>> <%= ( i==0 ? "0":"")+i %> </option>
		<%  }  %>
        </SELECT>
      </TD>
    </TR>
    <%  if (request.getParameter("endHour") != null) 
		      parameterInt = Integer.parseInt(request.getParameter("endHour"));		
    %>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" WIDTH="32%" ALIGN="RIGHT" VALIGN="MIDDLE"><%= messages.getString("calendar.addappt.end.time") %>&nbsp; </TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" WIDTH="68%" VALIGN="TOP">
        <SELECT NAME="endHour" onChange="changeEndHourEventCalendarForm(document.calendarEvent);">
		<% for (i=0;i<24;i++) { %>
		     <option value="<%= ( i>=0 && i<10 ? "0":"")+i %>" <% if (parameterInt > -1 && parameterInt == i ) { %> SELECTED<% } %>> <%= ( i>=0 && i<10 ? "0":"")+i %> </option>
		<% } %>
        </SELECT> :
        <%  if (request.getParameter("endMinute") != null) 
		      parameterInt = Integer.parseInt(request.getParameter("endMinute"));		
        %>
        <SELECT NAME="endMinute" onChange="changeEndMinEventCalendarForm(document.calendarEvent);">
		<% for (i=0;i<46;i+=15) { %>
		     <option value="<%= ( i==0 ? "0":"")+i %>" <% if (parameterInt > -1 && parameterInt == i ) { %> SELECTED<% } %>> <%= ( i==0 ? "0":"")+i %> </option>
		<% } %>

        </SELECT>
      </TD>
    </TR>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT" VALIGN="MIDDLE">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="MIDDLE">&nbsp;</TD>
    </TR>
  <TR VALIGN="TOP">
    <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT" VALIGN="MIDDLE">
    <%= messages.getString("calendar.editappt.reminder.set.to") %>:</TD>
    <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="MIDDLE">
      <%= reminderDate %></TD>
  </TR>
  <%  
	    parameterStr = "0";
	    if (request.getParameter("reminderSetting") != null) 
          parameterStr = request.getParameter("reminderSetting");		
    %>

    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT" VALIGN="MIDDLE"><%= messages.getString("calendar.addappt.set.reminder") %>&nbsp;&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="MIDDLE">
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
	<%  
	    parameterStr = "-2";
	    if (request.getParameter("repeatDay") != null) 
          parameterStr = request.getParameter("repeatDay");		
    %>
    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%">&nbsp;</TD>
    </TR>
    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" VALIGN="MIDDLE" ALIGN="RIGHT"><%= messages.getString("calendar.add.event.repeat.event") %>&nbsp;&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="MIDDLE">
        <SELECT NAME="repeatDay">
          <OPTION VALUE="-2"<% if (!parameterStr.equals("") && parameterStr.equals("-2") ) { %> SELECTED<% } %>><%= messages.getString("none") %></OPTION>
          <OPTION VALUE="1"<% if (!parameterStr.equals("") && parameterStr.equals("1") ) { %> SELECTED<% } %>><%= messages.getString("calendar.add.event.every.week") %></OPTION>
          <OPTION VALUE="2"<% if (!parameterStr.equals("") && parameterStr.equals("2") ) { %> SELECTED<% } %>><%= messages.getString("calendar.add.event.every.two.week") %></OPTION>
          <OPTION VALUE="3"<% if (!parameterStr.equals("") && parameterStr.equals("3") ) { %> SELECTED<% } %>><%= messages.getString("calendar.add.event.every.month") %></OPTION>
          <OPTION VALUE="4"<% if (!parameterStr.equals("") && parameterStr.equals("4") ) { %> SELECTED<% } %>><%= messages.getString("calendar.add.event.every.two.month") %></OPTION>
          <OPTION VALUE="5"<% if (!parameterStr.equals("") && parameterStr.equals("5") ) { %> SELECTED<% } %>><%= messages.getString("calendar.add.event.every.three.month") %></OPTION>
          <OPTION VALUE="6"<% if (!parameterStr.equals("") && parameterStr.equals("6") ) { %> SELECTED<% } %>><%= messages.getString("calendar.add.event.every.six.month") %></OPTION>
          <OPTION VALUE="7"<% if (!parameterStr.equals("") && parameterStr.equals("7") ) { %> SELECTED<% } %>><%= messages.getString("calendar.add.event.every.year") %></OPTION>
        </SELECT>
      </TD>
    </TR>
    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT" VALIGN="MIDDLE">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="MIDDLE">&nbsp;</TD>
    </TR>
	<% 
	   parameterStr=""; 
	   if (request.getParameter("description") != null) 
          parameterStr = request.getParameter("description");
	   else
	      parameterStr = (String)vDescription.get(0);
    %>

    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT"><%= messages.getString("calendar.addappt.description") %> &nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%">
        <TEXTAREA NAME="description" COLS="23" ROWS="4" wrap><%= parameterStr %></TEXTAREA></TD>
    </TR>
    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%">&nbsp;</TD>
    </TR>
	<%  if (request.getParameter("location") != null) 
          parameterStr = request.getParameter("location");
		else
		  parameterStr = (String)vLocation.get(0);
    %>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT" VALIGN="TOP"><%= messages.getString("calendar.addappt.location") %> &nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="TOP">
      <INPUT NAME="location" VALUE="<%= parameterStr %>" SIZE="24">
      </TD>
    </TR>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" VALIGN="TOP">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="TOP">&nbsp;</TD>
    </TR>
<%-- // Not in use
<% // Module Manager - Resource
  if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_RESOURCE) ) { %>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2">
      <TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0">
      <TR><TD CLASS="contentBgColor" COLSPAN="3">
      <%= messages.getString("calendar.addappt.resources") %>
      </TD></TR>
      <TR><TD CLASS="contentBgColor" VALIGN="TOP">
  		<select name="allResources" size="5" multiple>
 		<%
		    if (request.getParameterValues("resources") != null)
			  vParameter = CommonFunction.arrayToVector(request.getParameterValues("resources"));

		    for (i=0; resourceIDs != null && i < resourceIDs.size(); i++) {
              if ( (parameterInt == -1 && vResourceID != null && vResourceID.indexOf(resourceIDs.get(i)) != -1) ||
			       (vParameter != null && vParameter.indexOf( ((Integer)resourceIDs.get(i)).toString()) != -1)
			  )
                continue;
         %>
		      <option value="<%= resourceIDs.get(i) %>"><%= CommonFunction.restrictNameLength((String)resourceName.get(i), 20) %><%= (resourceApproval.get(i).equals("1")) ? "(A)" : "" %></option>
        <%  }  %>
  		</select>
      </TD>
      <TD CLASS="contentBgColor" ALIGN="CENTER" VALIGN="MIDDLE" >
      <A HREF="javascript:moveItems(document.calendarEvent.allResources, document.calendarEvent.resources, '<%= messages.getString("none.with.line") %>', -1);" onMouseOver="window.status='<%= messages.getString("add") %>';return true;"><IMG SRC="images/system/ic_rightarrow.gif" BORDER="0" ALT="<%= messages.getString("add") %>"></A><BR><BR>
      <A HREF="javascript:moveItems(document.calendarEvent.resources, document.calendarEvent.allResources, '<%= messages.getString("none.with.line") %>', -1);" onMouseOver="window.status='<%= messages.getString("email.remove") %>';return true;"><IMG SRC="images/system/ic_leftarrow.gif" BORDER="0" ALT="<%= messages.getString("email.remove") %>"></A>
      </TD>
      <TD CLASS="contentBgColor" VALIGN="TOP">
  		<select name="resources" size="5" multiple>
 	    <%
            if ( (parameterInt ==  -1 && vResourceID != null) || vParameter != null)
              for (i=0; resourceIDs != null && i < resourceIDs.size(); i++){
                if ( (parameterInt == -1 && vResourceID.indexOf(resourceIDs.get(i)) == -1) ||
		            (vParameter != null && vParameter.indexOf( ((Integer)resourceIDs.get(i)).toString()) == -1)
				)
                  continue;
        %>
		        <option value="<%= resourceIDs.get(i) %>"><%= CommonFunction.restrictNameLength((String)resourceName.get(i), 20) %><%= (resourceApproval.get(i).equals("1")) ? "(A)" : "" %></option>
        <%    }  %>
  		</select>
      </TD>
      </TR>
      <TR><TD CLASS="contentBgColor" ALIGN="LEFT" VALIGN="TOP">
      <A HREF="javascript:selectAllItems(document.calendarEvent.allResources);" onMouseOver="window.status='<%= messages.getString("select.all") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_selectall.gif\" BORDER=\"0\" ALT=\"Select All\">" : messages.getString("select.all") %></A> 
      <A HREF="javascript:clearAllItems(document.calendarEvent.allResources);" onMouseOver="window.status='<%= messages.getString("clear.all") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_clear.gif\" BORDER=\"0\" ALT=\"Clear All Selected\">" : messages.getString("clear.all") %></A>
      </TD>
      <TD CLASS="contentBgColor">&nbsp;</TD>
      <TD CLASS="contentBgColor" ALIGN="LEFT" VALIGN="TOP">
      <A HREF="javascript:selectAllItems(document.calendarEvent.resources);" onMouseOver="window.status='<%= messages.getString("select.all") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_selectall.gif\" BORDER=\"0\" ALT=\"Select All\">" : messages.getString("select.all") %></A> 
      <A HREF="javascript:clearAllItems(document.calendarEvent.resources);" onMouseOver="window.status='<%= messages.getString("clear.all") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_clear.gif\" BORDER=\"0\" ALT=\"Clear All Selected\">" : messages.getString("clear.all") %></A>
      </TD></TR>
      </TABLE>
      </TD>
    </TR>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" VALIGN="TOP">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="TOP">&nbsp;</TD>
    </TR>
<% } // Module Manager - Resource %>
--%>
<%
   if (request.getParameter("publicFlag") != null) 
     parameterStr = request.getParameter("publicFlag");		
   else
     parameterStr = (String)vPublicFlag.get(0);
%>
    <TR VALIGN="MIDDLE">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT"><%= messages.getString("calendar.addappt.viewing.status") %> &nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%">
        <INPUT TYPE="radio" NAME="publicFlag" VALUE="1"<% if (parameterStr.equals("1") ) { %> CHECKED<% } %>><%= messages.getString("calendar.addappt.public") %> 
        <INPUT TYPE="radio" NAME="publicFlag" VALUE="0"<% if (parameterStr.equals("0") ) { %> CHECKED<% } %>><%= messages.getString("calendar.addappt.private") %>
        </FONT></TD>
    </TR>
    <TR VALIGN="MIDDLE">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%">&nbsp;</TD>
    </TR>
<% 
   if (accessLevel) {
       if (request.getParameter("publicEvent") != null)        
         tPublicEvent = request.getParameter("publicEvent");
       else       
         tPublicEvent = (String)vPublicEvent.get(0);          
%>
    <TR VALIGN="MIDDLE">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT">Public Event? &nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%">
           <input type="checkbox" name="publicEvent" value="1" <%if (tPublicEvent.equals("1")) { %> CHECKED <% } %>>
      </TD>
    </TR>
<% }  %>
    <TR VALIGN="MIDDLE">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%">&nbsp;</TD>
    </TR>
    <TR VALIGN="MIDDLE">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%">
        <P>&nbsp;</P>
      </TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%">
      <A HREF="javascript:checkEventCalendarForm(document.calendarEvent);" onMouseOver="window.status='<%= messages.getString("save") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_save.gif\" WIDTH=\"34\" HEIGHT=\"18\" BORDER=\"0\" ALT=\"Save\">" : messages.getString("save") %></A> <A HREF="javascript:window.close();" onMouseOver="window.status='<%= messages.getString("cancel") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_cancel.gif\" WIDTH=\"40\" HEIGHT=\"18\" BORDER=\"0\" ALT=\"Cancel\">" : messages.getString("cancel") %></A></TD>
    </TR>
  </FORM>
<SCRIPT LANGUAGE="JavaScript">
  obj = document.calendarEvent;
  noItems(obj.allResources, '<%= messages.getString("none.with.line") %>', -1);
  noItems(obj.resources, '<%= messages.getString("none.with.line") %>', -1);
</SCRIPT>
<%
  if (parameterInt == -1) {
  st = new StringTokenizer((String)vStartDate.get(0), "-");
  if (st.hasMoreTokens())
    editYear = st.nextToken();

  if (st.hasMoreTokens())
    editMonth = st.nextToken();

  if (st.hasMoreTokens())
    editDate = st.nextToken();

  if (editYear != null && editMonth != null && editDate != null) { %>
  <SCRIPT LANGUAGE="JavaScript">
  for (var i=0; i < document.calendarEvent.startDay.length; i++)
    if (document.calendarEvent.startDay.options[i].text == "<%= editDate %>") {
      document.calendarEvent.startDay.options[i].selected = true;
      break;
    }

  for (var i=0; i < document.calendarEvent.startMonth.length; i++)
    if (document.calendarEvent.startMonth.options[i].value == "<%= editMonth %>") {
      document.calendarEvent.startMonth.options[i].selected = true;
      break;
    }

  for (var i=0; i < document.calendarEvent.startYear.length; i++)
    if (document.calendarEvent.startYear.options[i].text == "<%= editYear %>") {
      document.calendarEvent.startYear.options[i].selected = true;
      break;
    }
  </SCRIPT>
<% }

  st = new StringTokenizer((String)vStartTime.get(0), ":");
  if (st.hasMoreTokens())
    editHour = st.nextToken();

  if (st.hasMoreTokens())
    editMinute = st.nextToken();

  if (editHour != null && editMinute != null) { %>
  <SCRIPT LANGUAGE="JavaScript">
  for (var i=0; i < document.calendarEvent.startHour.length; i++)
    if (document.calendarEvent.startHour.options[i].text == "<%= editHour %>") {
      document.calendarEvent.startHour.options[i].selected = true;
      break;
    }

  for (var i=0; i < document.calendarEvent.startMinute.length; i++)
    if (document.calendarEvent.startMinute.options[i].text == "<%= editMinute %>") {
      document.calendarEvent.startMinute.options[i].selected = true;
      break;
    }
  </SCRIPT>
<% }

  st = new StringTokenizer((String)vEndDate.get(0), "-");
  if (st.hasMoreTokens())
    editYear = st.nextToken();

  if (st.hasMoreTokens())
    editMonth = st.nextToken();

  if (st.hasMoreTokens())
    editDate = st.nextToken();

  if (editYear != null && editMonth != null && editDate != null) { %>
  <SCRIPT LANGUAGE="JavaScript">
  for (var i=0; i < document.calendarEvent.endDay.length; i++)
    if (document.calendarEvent.endDay.options[i].text == "<%= editDate %>") {
      document.calendarEvent.endDay.options[i].selected = true;
      break;
    }

  for (var i=0; i < document.calendarEvent.endMonth.length; i++)
    if (document.calendarEvent.endMonth.options[i].value == "<%= editMonth %>") {
      document.calendarEvent.endMonth.options[i].selected = true;
      break;
    }

  for (var i=0; i < document.calendarEvent.endYear.length; i++)
    if (document.calendarEvent.endYear.options[i].text == "<%= editYear %>") {
      document.calendarEvent.endYear.options[i].selected = true;
      break;
    }
  </SCRIPT>
<% }

  st = new StringTokenizer((String)vEndTime.get(0), ":");
  if (st.hasMoreTokens())
    editHour = st.nextToken();

  if (st.hasMoreTokens())
    editMinute = st.nextToken();

  if (editHour != null && editMinute != null) { %>
  <SCRIPT LANGUAGE="JavaScript">
  for (var i=0; i < document.calendarEvent.endHour.length; i++)
    if (document.calendarEvent.endHour.options[i].text == "<%= editHour %>") {
      document.calendarEvent.endHour.options[i].selected = true;
      break;
    }

  for (var i=0; i < document.calendarEvent.endMinute.length; i++)
    if (document.calendarEvent.endMinute.options[i].text == "<%= editMinute %>") {
      document.calendarEvent.endMinute.options[i].selected = true;
      break;
    }
  </SCRIPT>
<% } %>

<% repeatDay = String.valueOf((Integer)vRepeatDay.get(0)); %>
  <SCRIPT LANGUAGE="JavaScript">
  for (var i=0; i < document.calendarEvent.repeatDay.length; i++)
    if (document.calendarEvent.repeatDay.options[i].value == "<%= repeatDay %>") {
      document.calendarEvent.repeatDay.options[i].selected = true;
      break;
    }
  </SCRIPT>
<%
  }
%>  

<%--
  if (vRepeatStartDate.get(0) != null)
  {
    st = new StringTokenizer((String)vRepeatStartDate.get(0), "-");
  }
  else
  {
    st = new StringTokenizer((String)vStartDate.get(0), "-");
  }
  
  if (st.hasMoreTokens())
  {
    editYear = st.nextToken();
  }
  if (st.hasMoreTokens())
  {
    editMonth = st.nextToken();
  }
  if (st.hasMoreTokens())
  {
    editDate = st.nextToken();
  }
  if (editYear != null && editMonth != null && editDate != null)
  {
  %>
  <SCRIPT LANGUAGE="JavaScript">
  for (var i=0; i < document.calendarEvent.repeatStartDay.length; i++)
  {
    if (document.calendarEvent.repeatStartDay.options[i].text == "<%= editDate %>")
    {
      document.calendarEvent.repeatStartDay.options[i].selected = true;
      break;
    }
  }
  for (var i=0; i < document.calendarEvent.repeatStartMonth.length; i++)
  {
    if (document.calendarEvent.repeatStartMonth.options[i].value == "<%= editMonth %>")
    {
      document.calendarEvent.repeatStartMonth.options[i].selected = true;
      break;
    }
  }
  for (var i=0; i < document.calendarEvent.repeatStartYear.length; i++)
  {
    if (document.calendarEvent.repeatStartYear.options[i].text == "<%= editYear %>")
    {
      document.calendarEvent.repeatStartYear.options[i].selected = true;
      break;
    }
  }
  </SCRIPT>
  <%
  }
  
  if (vRepeatEndDate.get(0) != null)
  {
    st = new StringTokenizer((String)vRepeatEndDate.get(0), "-");
  }
  else
  {
    st = new StringTokenizer((String)vEndDate.get(0), "-");
  }
  if (st.hasMoreTokens())
  {
    editYear = st.nextToken();
  }
  if (st.hasMoreTokens())
  {
    editMonth = st.nextToken();
  }
  if (st.hasMoreTokens())
  {
    editDate = st.nextToken();
  }
  if (editYear != null && editMonth != null && editDate != null)
  {
  %>
  <SCRIPT LANGUAGE="JavaScript">
  for (var i=0; i < document.calendarEvent.repeatEndDay.length; i++)
  {
    if (document.calendarEvent.repeatEndDay.options[i].text == "<%= editDate %>")
    {
      document.calendarEvent.repeatEndDay.options[i].selected = true;
      break;
    }
  }
  for (var i=0; i < document.calendarEvent.repeatEndMonth.length; i++)
  {
    if (document.calendarEvent.repeatEndMonth.options[i].value == "<%= editMonth %>")
    {
      document.calendarEvent.repeatEndMonth.options[i].selected = true;
      break;
    }
  }
  for (var i=0; i < document.calendarEvent.repeatEndYear.length; i++)
  {
    if (document.calendarEvent.repeatEndYear.options[i].text == "<%= editYear %>")
    {
      document.calendarEvent.repeatEndYear.options[i].selected = true;
      break;
    }
  }
  </SCRIPT>
  <%
  }
%>
--%>