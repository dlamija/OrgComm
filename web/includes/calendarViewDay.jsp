<%@ page import="java.net.URLEncoder, java.util.Iterator" %>
<%@ page import="cms.admin.meeting.EMeetingQuery, cms.admin.meeting.EMeetingTask" %>
<%
  String date=null, month=null, year=null,schedulerName="";
  String nextDate=null, prevDate=null, nextMonth=null, prevMonth=null, nextYear=null, prevYear=null;
  boolean dateIsInvalid = false;
  int i,j,k;
  java.util.Calendar cal;
      
  TvoContextManager.setSessionAttribute(request, "Calendar.lastView", "viewDay");
  if (request.getParameter("date") != null)
  {
    TvoContextManager.setSessionAttribute(request, "Calendar.date", request.getParameter("date"));
    date = request.getParameter("date");
  }
  else if (TvoContextManager.getSessionAttribute(request, "Calendar.date") != null)
  {
    date = (String)TvoContextManager.getSessionAttribute(request, "Calendar.date");
  }

  if (request.getParameter("month") != null)
  {
    TvoContextManager.setSessionAttribute(request, "Calendar.month", request.getParameter("month"));
    month = request.getParameter("month");
  }
  else if (TvoContextManager.getSessionAttribute(request, "Calendar.month") != null)
  {
    month = (String)TvoContextManager.getSessionAttribute(request, "Calendar.month");
  }

  if (request.getParameter("year") != null)
  {
    TvoContextManager.setSessionAttribute(request, "Calendar.year", request.getParameter("year"));
    year = request.getParameter("year");
  }
  else if (TvoContextManager.getSessionAttribute(request, "Calendar.year") != null)
  {
    year = (String)TvoContextManager.getSessionAttribute(request, "Calendar.year");
  }
  
  // Set to todays date if session not set
  if (date == null && month == null && year == null) {
    cal   = java.util.Calendar.getInstance();
    date  = String.valueOf(cal.get(Calendar.DATE));
    month = String.valueOf(cal.get(Calendar.MONTH));
    year  = String.valueOf(cal.get(Calendar.YEAR));
  }
  
  try
  {
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
  catch (NumberFormatException e)
  {
    dateIsInvalid = true;
  }
  catch (IllegalArgumentException e)
  {
    dateIsInvalid = true;
  }
  finally
  {
    if (!dateIsInvalid)
    {
      cal = java.util.Calendar.getInstance();
      cal.setLenient(false);
      cal.clear();
      cal.set(Integer.parseInt(year), Integer.parseInt(month), Integer.parseInt(date));
      cal.add(Calendar.DATE, 1);
      nextYear = String.valueOf(cal.get(Calendar.YEAR));
      nextMonth = String.valueOf(cal.get(Calendar.MONTH));
      nextDate = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));
      cal.add(Calendar.DATE, -2);
      prevYear = String.valueOf(cal.get(Calendar.YEAR));
      prevMonth = String.valueOf(cal.get(Calendar.MONTH));
      prevDate = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));
    }
  }
  
  if (date != null && month != null && year != null && !dateIsInvalid)
  {
    Vector vAppointments=null, vEvents=null, vToDo=null;		    
    Vector calEvents;
    Iterator it, it2;
    Vector vEventResources=null;

    boolean firstTime, assignedTo, isApprover;
		StringTokenizer stk = null,stk2 = null;

    String sDate=null, eDate=null, sTime=null, eTime=null, overDue="", today="";
    String realUserID=null,temp = "";


    Date dateTemp=null, dateNow=null, dateTimeNow=null;

    realUserID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
    if (TvoContextManager.getSessionAttribute(request, "Calendar.viewUserID") == null)
    {    
      vAppointments = (Vector)beanCalendar.getAppointments(userID,realUserID,date,month,year);
      vToDo = (Vector)beanCalendar.getToDo(userID,realUserID,date,month,year);
    }
    else
    {

      vAppointments = (Vector)beanCalendar.getAppointments
                      ((String)TvoContextManager.getSessionAttribute(request, "Calendar.viewUserID"),realUserID,date,month,year);
      vToDo = (Vector)beanCalendar.getToDo
              ((String)TvoContextManager.getSessionAttribute(request, "Calendar.viewUserID"),realUserID,date,month,year);
    }
    cal = java.util.Calendar.getInstance();
    if (cal.get(java.util.Calendar.DAY_OF_MONTH) == Integer.parseInt(date) &&
        cal.get(java.util.Calendar.MONTH) == Integer.parseInt(month) &&
        cal.get(java.util.Calendar.YEAR) == Integer.parseInt(year) )
      today = " ("+messages.getString("calendar.today") + ")";
    else
      today = "";
		

		month = String.valueOf((Integer.parseInt(month)+1));
		
		if (date.length() == 1)
		  date = "0"+date;		
			
		if (month.length() == 1)
		  month = "0"+month;

%>
<SCRIPT LANGUAGE="JavaScript">
function confirmDelete()
{
  var confirmFlag;
  return confirm("<%= messages.getString("click.OK.confirm") %>");
}
</SCRIPT>
<TR VALIGN="MIDDLE" >
  <TD BGCOLOR="#003366" CLASS="contentStrapColor" COLSPAN="2" ALIGN="CENTER"><b>Calendar </b></TD>
</TR>
<TR VALIGN="MIDDLE">
  <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" COLSPAN="2">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <A HREF="calendar.jsp?action=view&date=<%= prevDate %>&month=<%= prevMonth %>&year=<%= prevYear %>" onMouseOver="window.status='<%= messages.getString("calendar.go.back.one.day")  %>';return true;"><IMG SRC="images/system/previous.gif" BORDER="0" ALT="<%= messages.getString("calendar.go.back.one.day")  %>" style="vertical-align:middle;" /></A>
      <%= CommonFunction.parseDate(dateFormat,currentLocale,date+month+year,null,"ddMMyyyy") %><%= today %> 
      <A HREF="calendar.jsp?action=view&date=<%= nextDate %>&month=<%= nextMonth %>&year=<%= nextYear %>" onMouseOver="window.status='<%= messages.getString("calendar.go.forward.one.day")  %>';return true;"><IMG SRC="images/system/next.gif" BORDER="0" ALT="<%= messages.getString("calendar.go.forward.one.day")  %>" style="vertical-align:middle;" /></A>&nbsp;
	  <!-- <a href="calendar.jsp?action=printAppt"><img src="images/system/ic_print.gif" alt="" style="vertical-align:middle; border:0px;" /></a> -->
	  <a href="calendar.jsp?action=printAppt"><img src="images/printexport.png" alt="Print / Export" style="vertical-align:middle; border:0px;" /></a>
  </TD>
</TR>
<TR VALIGN="MIDDLE">
  <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" COLSPAN="2">
    <BLOCKQUOTE>
      <P><B><FONT COLOR="#003366"><%= messages.getString("calendar.viewday.appointments") %></FONT></B></P>
<!-- APPOINTMENTS START -->
<UL>
<%
		month = String.valueOf((Integer.parseInt(month)-1));
if (vAppointments != null && vAppointments.size() > 0)
{
  for (i=0; i < vAppointments.size(); i++)
  {
	  CalendarApptUser calendarAppt = (CalendarApptUser) vAppointments.get(i);
		schedulerName = beanCalendarDirectory.getUserName(calendarAppt.getUserID());
    if ( calendarAppt.getAgenda().length() > 0)
    {
    %>
      <FORM NAME="agenda<%= i %>" ACTION="calendar.jsp?action=viewAgenda" TARGET="calendarAgenda" METHOD="POST">
      <INPUT TYPE="HIDDEN" NAME="agenda" VALUE="<%= URLEncoder.encode(calendarAppt.getAgenda()) %>">
      </FORM>
    <%
    }
    else
    {
      %><BR><%
    }
    %><LI><%
    today = CommonFunction.getDate("yyyy-MM-dd", "yyyy-MM-dd", year+"-"+String.valueOf(Integer.parseInt(month)+1)+"-"+date);

    if ( calendarAppt.getReminderDate() != null && calendarAppt.getReminderDate().equals(today) )
    {
      %>
        <FONT COLOR="#FF0000"><%= messages.getString("calendar.reminder.for") %>:</FONT><BR>
      <%
    }
		
		if (!calendarAppt.getStartTime().equals("00:00") && !calendarAppt.getEndTime().equals("23:59"))    {
	    sTime = CommonFunction.getDate("HH:mm", "h:mm aa", calendarAppt.getStartTime());
	    eTime = CommonFunction.getDate("HH:mm", "h:mm aa", calendarAppt.getEndTime());


    %>
      <FONT COLOR="#FF0000"><%= sTime %> - <%= eTime %></FONT><BR>
    <%
		}
    
    sDate = CommonFunction.parseDate(dateFormat,currentLocale,calendarAppt.getStartDate(),null,TvoConstants.DATE_FOMRAT_SHORT);
    eDate = CommonFunction.parseDate(dateFormat,currentLocale,calendarAppt.getEndDate(),null,TvoConstants.DATE_FOMRAT_SHORT);
    
    if ( !(calendarAppt.getStartDate().equals(calendarAppt.getEndDate())) || 
          (calendarAppt.getReminderDate() != null && calendarAppt.getReminderDate().equals(today)) )
    {
      %>
        <FONT COLOR="#FF0000">(<%= sDate %> - <%= eDate %>)</FONT><BR>
      <%
    }
		else if (calendarAppt.getStartTime().equals("00:00") && calendarAppt.getEndTime().equals("23:59"))
		{
		  %>
				<FONT COLOR="#FF0000">(<%= messages.getString("calendar.appointment.all.day.event") %>)</FONT><BR>
			<%
		}
    
    if (  calendarAppt.getAgenda().length() > 0)
    {
    %>
      <A HREF="javascript:MM_openBrWindow('','calendarAgenda','scrollbars=yes,resizable=yes,width=450,height=200');document.agenda<%= i %>.submit();" onMouseOver="window.status='<%= messages.getString("calendar.addappt.agenda") %>';return (true);"><IMG SRC="images/system/note.gif" WIDTH="13" HEIGHT="16" BORDER="0" ALIGN="ABSMIDDLE" ALT="<%= messages.getString("calendar.addappt.agenda") %>"></A>
    <%
    }
    %>
    <SPAN CLASS="textFont"><FONT COLOR="#0065CE"><%= calendarAppt.getDescription() %></FONT></SPAN>
    <BR>
		<% 	 		
		if (calendarAppt.getCalendarApptUserID() > 0 )
		{
		  %><a href="Calendar?action=acceptAppt&userApptID=<%= calendarAppt.getCalendarApptUserID() %>" onMouseOver="window.status='<%= messages.getString("accept") %>';return (true);">
          <%= showIcon ? "<IMG SRC=\"images/system/ic_accept.gif\" WIDTH=\"45\" HEIGHT=\"18\" BORDER=\"0\" ALT=\"Click here to accept appointment\">" : messages.getString("accept") %></a>
          <a href="javascript:MM_openBrWindow('calendar.jsp?action=rejectAppt&userApptID=<%= calendarAppt.getCalendarApptUserID() %>','rejectAppt','resizable=yes,width=450,height=200')" onMouseOver="window.status='<%= messages.getString("reject") %>';return (true);">
          <%= showIcon ? "<IMG SRC=\"images/system/ic_reject.gif\" WIDTH=\"38\" HEIGHT=\"18\" BORDER=\"0\" ALT=\"Click here to reject appointment\">" : messages.getString("reject") %></a><BR><%
		}
		
    EMeetingQuery emQuery = new EMeetingQuery();
    emQuery.initTVO(request);
    String eMeetingCode = emQuery.getMeetingCode(calendarAppt.getCalendarApptID());
    if (calendarAppt.getUserID().equals(userID) && eMeetingCode == null)
    {
      %>
      <A HREF="calendar.jsp?action=editAppt&apptID=<%= calendarAppt.getCalendarApptID() %>" onMouseOver="window.status='<%= messages.getString("edit") %>';return true;">
      <%= showIcon ? "<IMG SRC=\"images/system/ic_edit.gif\" BORDER=\"0\" ALT=\"Edit\">" : messages.getString("edit") %></A>
      <A HREF="Calendar?action=deleteAppt&apptID=<%= calendarAppt.getCalendarApptID() %>" ONCLICK="return confirmDelete();" onMouseOver="window.status='<%= messages.getString("delete") %>';return true;">
      <%= showIcon ? "<IMG SRC=\"images/system/ic_cancel.gif\" BORDER=\"0\" ALT=\"Delete\">" : messages.getString("delete") %></A>
      <BR>
      <%
    }

		%>
		<B><FONT COLOR="#999999">. . . . . . . . . . . . . . . . . . . . . .</FONT></B>
    <BR>
    <FONT SIZE="2" CLASS="calendarContentFont"><B><%= messages.getString("calendar.addappt.location") %>:</B> <%= calendarAppt.getLocation() %> | <B><%= messages.getString("calendar.scheduler") %>:</B> <%= schedulerName %>
		<%
		  temp = "";
		  if (calendarAppt.getExcludeScheduler() == null)
			  temp = schedulerName + " (C), ";
				
		  if (temp.length() > 0 || calendarAppt.getAttendeesList().trim().length() > 0)
			{
				temp += calendarAppt.getAttendeesList() ;
				temp = temp.trim();
			  if (temp.endsWith(","))			
					temp = temp.substring(0,temp.length()-1);
    %><BR><B><%= messages.getString("calendar.addappt.attendees") %>:</B> <%= temp %><%					
			}
			
		  // Display appointment attachments
		  {
				
				Vector apptAttachVec = (Vector) beanCalendar.getAppointmentAttachments(calendarAppt.getCalendarApptID());
				String attachURL = TvoContextManager.generateFolderName(request) + "/appointment/" + calendarAppt.getUserID() + "/";
				if (apptAttachVec.size() != 0) {
					out.println("<BR><B>Attachments:</B>");
					for (int attachIndex=0; attachIndex<apptAttachVec.size(); attachIndex++) {
						Hashtable attachHT = (Hashtable) apptAttachVec.get(attachIndex);
						out.println("<a href='" + attachURL + attachHT.get("physicalFilename") 
									+ "' target='appointmentAttachment' onMouseOver=\"window.status='View';return true;\"> " 
									+ "<IMG SRC='images/system/note.gif' WIDTH='13' HEIGHT='16' ALIGN='ABSMIDDLE' BORDER='0' ALT='File Attachment'> "
									+ attachHT.get("originalFilename") + "</a>&nbsp;");
					}
				}
		  }
			
					// Module Manager - Resource
	    if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_RESOURCE) )
	    {
	      isApprover = false;
				
				if (calendarAppt.getResourceList().length() > 0 )
				{
				  temp = calendarAppt.getResourceList().trim();
					temp = temp.trim();
				  if (temp.endsWith(","))
						temp = temp.substring(0,temp.length()-1);			

					
					%><BR><B><%= messages.getString("calendar.addappt.resources") %>:</B> <%= temp %><%
				}
				
				stk = new StringTokenizer(calendarAppt.getResourceIDList(),",");
				stk2 = new StringTokenizer(calendarAppt.getConfirmedFlagList(),",");
				while (stk.hasMoreTokens())
				{
				  temp = stk.nextToken();

					if (stk2.nextToken().equals("2") )
					{
					  if (beanResource.isApprover(request, Integer.parseInt(temp), userID) == 1)
	              isApprover = true;
					}
				}
				
				// check if user is a resource approver
				if (isApprover)
	      {
		     %>
		        <BR>
            <a href="javascript:MM_openBrWindow('resource.jsp?action=approveRes&apptID=<%= calendarAppt.getCalendarApptID() %>','approveRes','scrollbars=yes,resizable=yes,width=350,height=186')" onMouseOver="window.status='<%= messages.getString("approve") %>';return (true);">
            <%= showIcon ? "<IMG SRC=\"images/system/ic_approve.gif\" HEIGHT=\"18\" BORDER=\"0\" ALT=\"Click here to approve selected resources\">" : messages.getString("approve") %></a>
            <a href="javascript:MM_openBrWindow('resource.jsp?action=rejectRes&apptID=<%= calendarAppt.getCalendarApptID() %>','rejectRes','scrollbars=yes,resizable=yes,width=350,height=261')" onMouseOver="window.status='<%= messages.getString("reject") %>';return (true);">
            <%= showIcon ? "<IMG SRC=\"images/system/ic_reject.gif\" WIDTH=\"38\" HEIGHT=\"18\" BORDER=\"0\" ALT=\"Click here to reject selected resources\">" : messages.getString("reject") %></a>
		     <%
	      } 
			}
		  // Module Manager - Resource

		%>
    <BR>
    </FONT>
		
		<hr size="1" width="70%" align="left">
    </LI>
    <%
  } //for loop
}
else
{
%>
  <%= messages.getString("calendar.viewday.no.appointments") %>
<%
}
%>
</UL>
<!-- APPOINTMENTS END -->
  </BLOCKQUOTE>
  </TD>
</TR>
<TR VALIGN="MIDDLE">
  <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" COLSPAN="2">
    <BLOCKQUOTE>
<!-- TO DO LIST START -->
<P><B><FONT COLOR="#003366"><%= messages.getString("calendar.viewday.todo.list") %></FONT></B></P>
<UL>
<%
if (vToDo != null && vToDo.size() > 0)
{

  dateNow = CommonFunction.getDate("d MMM yyyy", date+" "+monthNames[Integer.parseInt(month)]+" "+year, 0);

  dateTimeNow = CommonFunction.getDate("d MMM yyyy HH:mm", date+" "+monthNames[Integer.parseInt(month)]+" "+year+" "+
                                       String.valueOf(cal.get(java.util.Calendar.HOUR_OF_DAY)) +":"+
                                       String.valueOf(cal.get(java.util.Calendar.MINUTE)), 0);
  
  for(i=0; i < vToDo.size(); i++)
  {
	  CalendarToDoUser calendar = (CalendarToDoUser) vToDo.get(i);
    %>
    <LI>
    <%
    today = CommonFunction.getDate("yyyy-MM-dd", "yyyy-MM-dd", 
                                   year+"-"+String.valueOf(Integer.parseInt(month)+1)+"-"+date);
    
    if ( calendar.getReminderDate() != null && calendar.getReminderDate().equals(today) )
    {
      %>
        <FONT COLOR="#FF0000"><%= messages.getString("calendar.reminder.for") %>: </FONT><BR>
      <%
    }
  
    dateTemp = CommonFunction.getDate("yyyy-MM-dd", calendar.getDueDate(), 0);
    if (dateNow.equals(dateTemp))
      eDate = messages.getString("calendar.today");
    else
      eDate = null;

    dateTemp = CommonFunction.getDate("yyyy-MM-dd HH:mm", calendar.getDueDate()+" "+calendar.getDueTime(), 0);
    if (eDate == null || !eDate.equals("Today"))    		{
      eDate = CommonFunction.getDate(TvoConstants.DATE_FOMRAT_SHORT, dateTemp, 0);
			eDate = CommonFunction.parseDate(dateFormat,currentLocale,eDate,null,TvoConstants.DATE_FOMRAT_SHORT);

		}

    
    eTime = CommonFunction.getDate("h:mm aa", dateTemp, 0);
    
    if (dateTimeNow.after(dateTemp) && calendar.getStatus().equals("0") )
      overDue = "<U>"+messages.getString("calendar.todo.overdue")+"</U>";
    else if ( calendar.getStatus().equals("1") )
      overDue = "<U>"+messages.getString("calendar.todo.completed")+"</U>";
    else
      overDue = "";
      
    %>
    <SPAN CLASS="textFont"><FONT COLOR="#0065CE"><%= calendar.getDescription() %></FONT></SPAN><BR>
    <B><%= overDue %> <%= messages.getString("calendar.todo.deadline") %>:</B> <FONT COLOR="#FF0000"><%= eDate %> <%= eTime %></FONT><BR>

    <%
    EMeetingTask emTask = new EMeetingTask();
    emTask.initTVO(request);
    if (calendar.getParentUserID().equals(userID) && !emTask.taskLinked(calendar.getCalendarToDoID()))
    {
      %>
      <A HREF="calendar.jsp?action=editToDo&toDoID=<%= calendar.getCalendarToDoID() %>" onMouseOver="window.status='<%= messages.getString("edit") %>';return true;">
      <%= showIcon ? "<IMG SRC=\"images/system/ic_edit.gif\" BORDER=\"0\" ALT=\"Edit\">" : messages.getString("edit") %></A>
      <A HREF="Calendar?action=deleteToDo&toDoID=<%= calendar.getCalendarToDoID() %>" ONCLICK="return confirmDelete();" onMouseOver="window.status='<%= messages.getString("delete") %>';return true;">
      <%= showIcon ? "<IMG SRC=\"images/system/ic_cancel.gif\" BORDER=\"0\" ALT=\"Delete\">" : messages.getString("delete") %></A><BR>
      <%
    }
    %>
    <B><FONT COLOR="#9C9A9C">. . . . . . . . . . . . . . . . . . . . . .</FONT>
    <BR>
    </B>
		<FONT SIZE="2" CLASS="calendarContentFont">
    <B><%= messages.getString("calendar.todo.assigned.by") %>:</B>
    <%= beanCalendarDirectory.getUserName(calendar.getParentUserID()) %>
		<% if (calendar.getAssignedByList().length() > 0 )
    {
		  temp = calendar.getAssignedByList().trim() ;
		  if (temp.endsWith(","))
				temp = temp.substring(0,temp.length()-1);

      %> | <B><%= messages.getString("calendar.todo.assigned.to") %>:</B> <%= temp %><%    
    }
		if (calendar.getReassignedByList().length() > 0)
    {
		  temp = calendar.getReassignedByList().trim();
		  if (temp.endsWith(","))
				temp = temp.substring(0,temp.length()-1);			
      %> | <B><%= messages.getString("calendar.todo.reassigned.to") %>:</B> <%= temp %><%      
    }
		
		if ( calendar.getStatus().equals("1") )
    {
      dateTemp = CommonFunction.getDate("yyyy-MM-dd HH:mm", calendar.getCompleteDate() +" "+calendar.getCompleteTime(), 0);
      if (eDate == null || !eDate.equals("Today"))
      {
				eDate = CommonFunction.parseDate(dateFormat,currentLocale,calendar.getCompleteDate(),null,TvoConstants.DATE_FOMRAT_SHORT);
      }
      eTime = CommonFunction.getDate("h:mm aa", dateTemp, 0);
    
    %>
      | <B><%= messages.getString("calendar.complete.todo") %>:</B> <%= beanCalendarDirectory.getUserName(calendar.getCompletedBy()) %> |
      <B><%= messages.getString("calendar.completed.date") %>:</B> <%= eDate %> <%= eTime %>
    <%
    }
		if (calendar.getFileName() != null && calendar.getFileName().length() > 0 )
    {
    %>
    <BR>
    <B><%= messages.getString("calendar.todo.attachment") %>:</B>
    <A HREF="<%=TvoContextManager.generateFolderName(request)%>/todo/<%= calendar.getCalendarToDoID() %>/<%= calendar.getPhysicalFileName() %>" target="todoAttachment" onMouseOver="window.status='<%= messages.getString("view") %>';return true;">
    <IMG SRC="images/system/note.gif" WIDTH="13" HEIGHT="16" ALIGN="ABSMIDDLE" BORDER="0" ALT="File Attachment">
    <%= calendar.getFileName() %></A>
    <%
    }
		// Module Manager - Resource
    if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_RESOURCE) )
    {
      isApprover = false;
			
			if (calendar.getResourceList().length() > 0 )
			{
			  temp = calendar.getResourceList().trim();
			  if (temp.endsWith(","))
					temp = temp.substring(0,temp.length()-1);			

				
				%><BR><B><%= messages.getString("calendar.addappt.resources") %>:</B> <%= temp %><%
			}
			
			stk = new StringTokenizer(calendar.getResourceIDList(),",");
			stk2 = new StringTokenizer(calendar.getConfirmedFlagList(),",");
			while (stk.hasMoreTokens())
			{
			  temp = stk.nextToken();
				if (stk2.nextToken().equals("2") )
				{
				  if (beanResource.isApprover(request, Integer.parseInt(temp), userID) == 1)
              isApprover = true;
				}
			}

			
			// check if user is a resource approver
			if (isApprover)
      {
	     %>
	      <BR>
	      <a href="javascript:MM_openBrWindow('resource.jsp?action=approveRes&toDoID=<%= calendar.getCalendarToDoID() %>','approveRes','scrollbars=yes,resizable=yes,width=350,height=186')" onMouseOver="window.status='<%= messages.getString("approve") %>';return (true);">
	      <%= showIcon ? "<IMG SRC=\"images/system/ic_approve.gif\" HEIGHT=\"18\" BORDER=\"0\" ALT=\"Click here to approve selected resources\">" : messages.getString("approve") %></a>
	      <a href="javascript:MM_openBrWindow('resource.jsp?action=rejectRes&toDoID=<%= calendar.getCalendarToDoID() %>','rejectRes','scrollbars=yes,resizable=yes,width=350,height=261')" onMouseOver="window.status='<%= messages.getString("reject") %>';return (true);">
	      <%= showIcon ? "<IMG SRC=\"images/system/ic_reject.gif\" WIDTH=\"38\" HEIGHT=\"18\" BORDER=\"0\" ALT=\"Click here to reject selected resources\">" : messages.getString("reject") %></a>
	     <%
      } 
		}
	  // Module Manager - Resource
		
		
		
		assignedTo = false;
    if ( calendar.getStatus().equals("0") )
    {
		  temp = "";
      if ( calendar.getParentUserID().equals(userID) ) {
        assignedTo = true;
				temp = calendar.getParentUserID(); 
			}
				
			if (!assignedTo)
			{

			  stk = new StringTokenizer(calendar.getAssignedByIDList(),",");
				while (stk.hasMoreTokens())
				{
					if (stk.nextToken().equals(userID) )				   {
				  	assignedTo = true;					  
						temp = userID;
					}
				}
			}
			
			if (!assignedTo)
			{
			  stk = new StringTokenizer(calendar.getReassignedByIDList(),",");
				while (stk.hasMoreTokens())
				{								  
					if (stk.nextToken().equals(userID) )				   {
				  	assignedTo = true;					  
						temp = userID;
					}
				}
			}
			


			if (assignedTo &&  temp.equals(TvoContextManager.getSessionAttribute(request, "Calendar.viewUserID")))
      {
      %>
      <BR>
      <a href="Calendar?action=completeToDo&toDoID=<%= calendar.getCalendarToDoID() %>" onMouseOver="window.status='<%= messages.getString("calendar.todo.completed.button") %>';return (true);"><%= showIcon ? "<IMG SRC=\"images/system/ic_completed.gif\" WIDTH=\"57\" HEIGHT=\"18\" BORDER=\"0\" ALT=\"Click here to mark task as completed\">" : messages.getString("calendar.todo.completed.button") %></a>
      <%
      }
    }
		
		
		assignedTo =  false;
    if (calendar.getAllowReassign()!=null && calendar.getStatus()!=null && calendar.getAllowReassign().equals("1") && calendar.getStatus().equals("0") )
    {
		  temp = "";
      if ( calendar.getParentUserID().equals(userID) ) {
        assignedTo = true;
				temp = calendar.getParentUserID(); 
			}
				
			if (!assignedTo)
			{

			  stk = new StringTokenizer(calendar.getAssignedByIDList(),",");
				while (stk.hasMoreTokens())
				{
					if (stk.nextToken().equals(userID) )				   {
				  	assignedTo = true;					  
						temp = userID;
					}
				}
			}
			
			if (!assignedTo)
			{
			  stk = new StringTokenizer(calendar.getReassignedByIDList(),",");
				while (stk.hasMoreTokens())
				{								  
					if (stk.nextToken().equals(userID) )				   {
				  	assignedTo = true;					  
						temp = userID;
					}
				}
			}
			
			if (assignedTo &&  temp.equals(TvoContextManager.getSessionAttribute(request, "Calendar.viewUserID")))      
      {    
      %>
      <a href="javascript:MM_openBrWindow('calendar.jsp?action=reassignToDo&calendarToDoUserID=<%= calendar.getCalendarToDoUserID() %>&assignedBy=<%= calendar.getParentUserID() %>','toDoReassign','scrollbars=no,resizable=yes,width=350,height=160');" onMouseOver="window.status='<%= messages.getString("calendar.viewday.reassign") %>';return(true);"><%= showIcon ? "<IMG SRC=\"images/system/ic_reassign.gif\" WIDTH=\"50\" HEIGHT=\"18\" BORDER=\"0\" ALT=\"Click here to reassign task\">" : messages.getString("calendar.viewday.reassign") %></a>
      <%
      }
    }
		
		%>
    </FONT>
		<hr size="1" width="70%" align="left">
    </LI>
		
    <%
  } //for(i=0; i < vToDoID.size(); i++)
}
else
{
%>
 	<%= messages.getString("calendar.viewday.no.todo") %>
<%
}
%>
</UL>
<!-- TO DO LIST END -->
  </BLOCKQUOTE>
  </TD>
</TR>
<%
}
else
{
%>
  <TR VALIGN="MIDDLE">
    <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" COLSPAN="2">
      <BLOCKQUOTE>
      <FONT COLOR="#FF0000"><%= messages.getString("calendar.invalid.date") %><BR>
      date=<%= date %>, month=<%= month %>, year=<%= year %><BR><BR>
      <%= messages.getString("calendar.date.error") %>
      </FONT>
      </BLOCKQUOTE>
    </TD>
  </TR>
<%
}
%> 
