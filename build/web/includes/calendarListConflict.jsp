<%@ page import="java.net.URLEncoder" %>
<%
    int i,j;

    Vector vConflicts=null;
    Vector vUsers=null, vUserConflicts=null, 
           vAllApptConflicts=null, vAllToDoConflicts=null, vAllEventConflicts=null;
    
    Vector vAppointments=null, vToDo=null, vEvents=null;
		Vector vDescription = null;
    
    Vector vResources=null, vResourceConflicts=null;
    
    Vector vToDoID=null, vToDoUserID, vToDoPublicFlag=null, vToDo2ID=null, vDueDate=null, vDueTime=null;
    Vector vReassignees=null, vReassUserID=null, vAssigned=null, vAssignedTo=null;
    Vector vReminderDate=null, vRepeatDay=null, vStatus=null;
    Vector vCompletedBy, vCompleteDate=null, vCompleteTime=null;

    Vector vToDoResources=null;
    Vector vToDo3ID=null, vToDoResourceID=null, vToDoResourceConfirmFlag=null, vToDoResourceName=null;


    Vector calEvents;
    Iterator it, it2;
    Vector vEventResources=null;

    
    boolean firstTime;
    
    String sDate=null, eDate=null, sTime=null, eTime=null;
    String realUserID=null, overDue="",temp="";

    realUserID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
    vConflicts = (Vector)TvoContextManager.getSessionAttribute(request, "Calendar.vConflicts");
    
    vUsers = (Vector) vConflicts.get(1);
    vUserConflicts = (Vector) vConflicts.get(3);
    
    vAllApptConflicts = (Vector) vConflicts.get(6);

  // Module Manager - Resource
  if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_RESOURCE) )
  {
    vResources = (Vector) vConflicts.get(4);
    vResourceConflicts = (Vector) vConflicts.get(5);
    vAllToDoConflicts = (Vector) vConflicts.get(7);
    vAllEventConflicts = (Vector) vConflicts.get(8);
  }
      
    //get vector of appointments to display
    if (request.getParameter("conflictUserID") != null)
    {
      i = vUsers.indexOf(request.getParameter("conflictUserID"));
      vAppointments = (Vector)beanCalendar.getAppointments((Vector)vUserConflicts.get(i), realUserID, 1, 1);
    }
    else if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_RESOURCE) && request.getParameter("conflictResID") != null)
    {
      i = vResources.indexOf(new Integer(request.getParameter("conflictResID")));
      vAppointments = (Vector)beanCalendar.getAppointments((Vector)((Vector)vResourceConflicts.get(i)).get(0), realUserID, 1, 1);
      vToDo = (Vector)beanCalendar.getToDo((Vector)((Vector)vResourceConflicts.get(i)).get(1), realUserID, 1);
      vEvents = (Vector)beanCalendar.getCalendarEvents((Vector)((Vector)vResourceConflicts.get(i)).get(2), realUserID, 1);
    }
    else
    {
      vAppointments = (Vector)beanCalendar.getAppointments(vAllApptConflicts, realUserID, 1, 1);
      if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_RESOURCE) )
      {
        vToDo = (Vector)beanCalendar.getToDo(vAllToDoConflicts, realUserID, 1);
        vEvents = (Vector)beanCalendar.getCalendarEvents(vAllEventConflicts, realUserID, 1);
      }
    }
%>
<!-- APPOINTMENTS START -->
<TR>
  <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="25%" VALIGN="TOP">
    <P>&nbsp;</P>
  </TD>
  <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="75%" VALIGN="TOP">
    <A HREF="javascript:history.go(-1);" onMouseOver="window.status='<%= messages.getString("done") %>';return true;">
    <%= showIcon ? "<IMG SRC=\"images/system/ic_done.gif\" WIDTH=\"40\" HEIGHT=\"18\" BORDER=\"0\" ALT=\"Done\">" : messages.getString("done") %></A>
  </TD>
</TR>
<TR>
  <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="25%" VALIGN="TOP">
    <P>&nbsp;</P>
  </TD>
  <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="75%" VALIGN="TOP">
    <P>&nbsp;</P>     
  </TD>
</TR>
<TR VALIGN="MIDDLE">
  <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" COLSPAN="2">
    <BLOCKQUOTE>
      <B><FONT COLOR="#003366"><%= messages.getString("calendar.viewday.appointments") %></FONT></B><UL>
<%
//only run this part if there are appointments
if (vAppointments != null && vAppointments.size() > 0)
{
	String scheduler = "";
  //go thru each appointment and display the details
  for (i=0; i < vAppointments.size(); i++)
  {
	  CalendarApptUser calendar  = (CalendarApptUser) vAppointments.get(i);
    if ( calendar.getAgenda().length() > 0)
    {
    %>
      <FORM NAME="agenda<%= i %>" ACTION="calendar.jsp?action=viewAgenda" TARGET="calendarAgenda" METHOD="POST">
      <INPUT TYPE="HIDDEN" NAME="agenda" VALUE="<%= URLEncoder.encode(calendar.getAgenda()) %>">
      </FORM>
    <%
    }
    else
    {
      %><BR><%
    }
    %><LI><%
    if (! calendar.getStartTime().equals("00:00") && ! calendar.getEndTime().equals("23:59") ){
    //format the start and end dates and display them
    sTime = CommonFunction.getDate("HH:mm", "h:mm aa", calendar.getStartTime());
    eTime = CommonFunction.getDate("HH:mm", "h:mm aa", calendar.getEndTime());
    %><FONT COLOR="#FF0000"><%= sTime %> - <%= eTime %></FONT><BR><% }

    sDate = CommonFunction.parseDate(dateFormat,currentLocale, calendar.getStartDate(),null,TvoConstants.DATE_FOMRAT_SHORT);
		eDate = CommonFunction.parseDate(dateFormat,currentLocale, calendar.getEndDate(),null,TvoConstants.DATE_FOMRAT_SHORT);
    
    if ( calendar.getStartDate().equals(calendar.getEndDate()) )
    { %><FONT COLOR="#FF0000">(<%= sDate %>)</FONT><BR><% }
    else
    { %><FONT COLOR="#FF0000">(<%= sDate %> - <%= eDate %>)</FONT><BR><% }
    
    
    if (calendar.getPublicFlag().equals("1") || calendar.getUserID().equals(realUserID))
    {
      if ( calendar.getAgenda().length() > 0)
      {
      %>
        <A HREF="javascript:MM_openBrWindow('','calendarAgenda','scrollbars=yes,resizable=yes,width=450,height=200');document.agenda<%= i %>.submit();" onMouseOver="window.status='<%= messages.getString("calendar.addappt.agenda") %>';return (true);"><IMG SRC="images/system/note.gif" WIDTH="13" HEIGHT="16" BORDER="0" ALIGN="ABSMIDDLE" ALT="<%= messages.getString("calendar.addappt.agenda") %>"></A>
      <%
      }
      %>
        <SPAN CLASS="textFont"><FONT COLOR="#0065CE"><%= calendar.getDescription() %></FONT></SPAN>
        <BR>
      <%
    }
    else
    {
      %>
        <SPAN CLASS="textFont"><FONT COLOR="#0065CE"> * <%= messages.getString("calendar.conflict.private") %> * </FONT></SPAN>
        <BR>
      <%
    }
		scheduler = beanCalendarDirectory.getUserName(calendar.getUserID());
    if (calendar.getPublicFlag().equals("1") || calendar.getUserID().equals(realUserID))
    {
      %>
    <B><FONT COLOR="#999999">. . . . . . . . . . . . . . . . . . . . . .</FONT></B>
    <BR>
    <FONT SIZE="2" CLASS="calendarContentFont"><B><%= messages.getString("calendar.addappt.location") %>:</B> <%= calendar.getLocation() %> | <B><%= messages.getString("calendar.scheduler") %>:</B> <%= scheduler %>
		
      <%
      // display attendees
			temp = "";
			if (calendar.getExcludeScheduler() == null)
			  temp = 	scheduler + " (C), ";
			if (temp.trim().length() > 0){
			  temp += calendar.getAttendeesList().trim() ;
			  if (temp.endsWith(","))
					temp = temp.substring(0,temp.length()-1);

%>
				<BR><B><%= messages.getString("calendar.addappt.attendees") %>:</B> <%= temp %>
<%			
			}
      
      
    // Module Manager - Resource
    if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_RESOURCE) )
    {
		
				if (calendar.getResourceList().length() > 0 )
				{
				  temp = calendar.getResourceList().trim();
					temp = temp.trim();
				  if (temp.endsWith(","))
						temp = temp.substring(0,temp.length()-1);			

					
					%><BR><B><%= messages.getString("calendar.addappt.resources") %>:</B> <%= temp %><%
				}

    } // Module Manager - Resource

    } //(((String)vApptPublicFlag.get(i)).equals("1") || ((String)vApptUserID.get(i)).equals(realUserID))
    %>
    <BR>
    </FONT>
		
		<hr size="1" width="70%" align="left">
    </LI>
    <%
  } // for
}
else
{
%>
  <%= messages.getString("calendar.conflicts.appointment") %>
<%
}
%>
</UL>
  </BLOCKQUOTE>
  </TD>
</TR>
<!-- APPOINTMENTS END -->
<%
// Module Manager - Resource (for todo and events)
if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_RESOURCE) )
{
%>
<TR VALIGN="MIDDLE">
  <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" COLSPAN="2">
  <HR>
  </TD>
</TR>
<!-- TO DO LIST START -->
<TR VALIGN="MIDDLE">
  <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" COLSPAN="2">
    <BLOCKQUOTE>
<P><B><FONT COLOR="#003366"><%= messages.getString("calendar.viewday.todo.list") %></FONT></B></P>
<UL>
<%
if (vToDo != null && vToDo.size() > 0)
{
  vToDoID = (Vector)vToDo.get(0);
  vToDoUserID = (Vector)vToDo.get(1);
  vDueDate = (Vector)vToDo.get(2);
  vDueTime = (Vector)vToDo.get(3);
  vDescription = (Vector)vToDo.get(4);
  //6 filename
  vToDoPublicFlag = (Vector)vToDo.get(6);
  vReminderDate = (Vector)vToDo.get(7);
  vToDo2ID = (Vector)vToDo.get(8);
  //9 allow reassign
  vStatus = (Vector)vToDo.get(10);
  vCompletedBy = (Vector)vToDo.get(11);
  vCompleteDate = (Vector)vToDo.get(12);
  vCompleteTime = (Vector)vToDo.get(13);
  
  vAssigned = (Vector)vToDo.get(14);
  vReassignees = (Vector)vToDo.get(15);

  // Module Manager - Resource
  if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_RESOURCE) )
  {
    vToDoResources = (Vector)vToDo.get(16);

    //get all the resources for all the appointments
    if (vToDoResources != null && vToDoResources.size() > 0)
    {
      vToDo3ID= (Vector)vToDoResources.get(0);
      vToDoResourceID = (Vector)vToDoResources.get(1);
      vToDoResourceConfirmFlag = (Vector)vToDoResources.get(2);
      //3 Reason
      vToDoResourceName= (Vector)vToDoResources.get(4);
    }
  }

  for(i=0; i < vToDoID.size(); i++)
  {
    %>
    <LI>
    <%
    eDate = CommonFunction.parseDate( dateFormat,currentLocale,(String)vDueDate.get(i),null,TvoConstants.DATE_FOMRAT_SHORT);		
    eTime = CommonFunction.getDate("HH:mm", "h:mm aa", (String)vDueTime.get(i));
    
    if ((CommonFunction.getDate("yyyy-MM-ddHH:mm", CommonFunction.getDate("yyyy-MM-ddHH:mm"), 0)).after(
         (CommonFunction.getDate("yyyy-MM-ddHH:mm", ((String)vDueDate.get(i) + (String)vDueTime.get(i)), 0))) &&
        ((String)vStatus.get(i)).equals("0") )
      overDue = "<U>"+messages.getString("calendar.todo.overdue")+"</U>";
    else if ( ((String)vStatus.get(i)).equals("1") )
      overDue = "<U>"+messages.getString("calendar.todo.completed")+"</U>";
    else
      overDue = "";
      
    %>
    <B><%= overDue %> <%= messages.getString("calendar.todo.deadline") %>:</B> <FONT COLOR="#FF0000"><%= eDate %> <%= eTime %></FONT><BR>
    <%
    if ( ((String)vToDoPublicFlag.get(i)).equals("1") || ((String)vToDoUserID.get(i)).equals(realUserID) )
    {
      %>
    <SPAN CLASS="textFont"><FONT COLOR="#0065CE"><%= vDescription.get(i) %></FONT></SPAN><BR>
      <%
    }
    else
    {
    %>
    <SPAN CLASS="textFont"><FONT COLOR="#0065CE"> * <%= messages.getString("calendar.conflict.private") %> * </FONT></SPAN><BR>
    <%
    }
    %>
    <B><FONT COLOR="#9C9A9C">. . . . . . . . . . . . . . . . . . . . . .</FONT>
    <BR>
    </B>
    <FONT SIZE="2" CLASS="calendarContentFont">
    <B><%= messages.getString("calendar.todo.assigned.by") %>:</B>
    <%= beanCalendarDirectory.getUserName((String)vToDoUserID.get(i)) %>
    <%
    vAssignedTo = (Vector)vAssigned.get(i);
    vReassUserID = (Vector)vReassignees.get(i);
    firstTime = true;
    
    if (vAssignedTo != null && vAssignedTo.size() > 0)
    {
      %> | <B><%= messages.getString("calendar.todo.assigned.to") %>:</B><%
      for (j=0; j < vAssignedTo.size(); j++)
      {
        if (firstTime)
        {
          %> <%= beanCalendarDirectory.getUserName((String)vAssignedTo.get(j)) %><%
          firstTime = false;
        }
        else
        {
        %>, <%= beanCalendarDirectory.getUserName((String)vAssignedTo.get(j)) %><%
        }
      }
    }
    
    firstTime = true;
    if (vReassUserID != null && vReassUserID.size() > 0)
    {
      %> | <B>Reassigned to:</B><%
      for (j=0; j < vReassUserID.size(); j++)
      {
        if (firstTime)
        {
          %> <%= beanCalendarDirectory.getUserName((String)vReassUserID.get(j)) %><%
          firstTime = false;
        }
        else
        {
        %>, <%= beanCalendarDirectory.getUserName((String)vReassUserID.get(j)) %><%
        }
      }
    }

    if ( ((String)vStatus.get(i)).equals("1") )
    {
		  eDate = CommonFunction.parseDate(dateFormat,currentLocale,vCompleteDate.get(i)+ " " +vCompleteTime.get(i)  ,TvoConstants.TIME_FORMAT_SHORT,TvoConstants.DATE_FORMAT_MEDIUM);
		
    %>
      | <B><%= messages.getString("calendar.complete.todo") %>:</B> <%= beanCalendarDirectory.getUserName((String)vCompletedBy.get(i)) %> |
       <B><%= messages.getString("calendar.completed.date")%></B>: <%=  eDate %> 
    <%
    }

    //get resources
    if (vToDo3ID != null && vToDo3ID.size() > 0)
    {
      firstTime = true;
      for (j=0; j < vToDo3ID.size(); j++)
      {
        if (((Integer)vToDoID.get(i)).intValue() == ((Integer)vToDo3ID.get(j)).intValue())
        {
          if (firstTime)
          {
            firstTime = false;
            %><BR><B><%= messages.getString("calendar.addappt.resources") %>:</B> <%
          }
          else
          {
            %>, <%
          }
          %><%= vToDoResourceName.get(j) %><%

          if (((String)vToDoResourceConfirmFlag.get(j)).equals("2"))
            out.print(" (P)");
          if (((String)vToDoResourceConfirmFlag.get(j)).equals("1"))
            out.print(" (C)");
          if (((String)vToDoResourceConfirmFlag.get(j)).equals("0"))
            out.print(" (R)");
        }
      } //for (j=0; j < vToDo3ID.size(); j++)
    } //if (vToDo3ID != null && vToDo3ID.size() > 0)
    %>

    <BR>
    <BR>
    </FONT>
		<hr size="1" width="70%" align="left">
    </LI>
    <%
  } //for(i=0; i < vToDoID.size(); i++)
}
else
{
%>
  <%= messages.getString("calendar.conflicts.no.todo") %>
<%
}
%>
</UL>
  </BLOCKQUOTE>
  </TD>
</TR>
<!-- TO DO LIST END -->
<TR VALIGN="MIDDLE">
  <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" COLSPAN="2">
  <HR>
  </TD>
</TR>
<!-- EVENTS START -->
<TR VALIGN="MIDDLE">
  <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" COLSPAN="2">
    <BLOCKQUOTE>
<P>
<B><FONT COLOR="#003366"><%= messages.getString("calendar.viewday.events") %></FONT></B>
</P>
<UL>
<%

if (vEvents != null && vEvents.size() > 0) {
  for (it = vEvents.iterator(); it.hasNext();) {
    CalendarEvent event = (CalendarEvent)it.next();
	%>
      <LI>
      <FONT COLOR="#FF0000"><%= CommonFunction.getDate("HH:mm", "h:mm aa", event.getStartTime()) %> - <%= CommonFunction.getDate("HH:mm", "h:mm aa", event.getEndTime()) %></FONT><BR>
      <%
			sDate = CommonFunction.getDate(TvoConstants.DATE_FOMRAT_SHORT, event.getStartDate(), 0);
			sDate = CommonFunction.parseDate(dateFormat,currentLocale,sDate,null,TvoConstants.DATE_FOMRAT_SHORT);
			
			eDate = CommonFunction.getDate(TvoConstants.DATE_FOMRAT_SHORT, event.getEndDate(), 0);
			eDate = CommonFunction.parseDate(dateFormat,currentLocale,eDate,null,TvoConstants.DATE_FOMRAT_SHORT);

      if ( event.getStartDate().equals(event.getEndDate()) )
      { %><FONT COLOR="#FF0000">(<%= sDate %>)</FONT><BR><% }
      else
      { %><FONT COLOR="#FF0000">(<%= sDate %> - <%= eDate %>)</FONT><BR><% }
      
      if ( event.isPublic() || event.getUserID().equals(realUserID) ) 
      {
      %>
      <SPAN CLASS="textFont"><FONT COLOR="#0065CE"><%= (event.getDescription() == null) ? "" : event.getDescription() %></FONT></SPAN>
      <%
      }
      else
      {
      %>
      <SPAN CLASS="textFont"><FONT COLOR="#0065CE"> * <%= messages.getString("calendar.conflict.private") %> * </FONT></SPAN>
      <%
      }
      %>
      <BR>
      <B><FONT COLOR="#9C9A9C">. . . . . . . . . . . . . . . . . . . . . .</FONT></B><BR>
      <FONT SIZE="2" CLASS="calendarContentFont">
      <B><%= messages.getString("calendar.addappt.location") %>:</B> 
      <% if ( event.isPublic() || event.getUserID().equals(realUserID) ) 
      {
      %>
      <%= (event.getLocation() == null) ? "" : event.getLocation() %>
      <%
      }
      else
      {
      %> * <%= messages.getString("calendar.conflict.private") %> * <%
      }
      %>
      
    <%

    //get resources
    vEventResources = event.getResources();
    
    firstTime = true;
    
    if (vEventResources != null && vEventResources.size() > 0)
    {
      for (it2 = vEventResources.iterator(); it2.hasNext(); ) 
      {
        ResourceDB resourceEvent = (ResourceDB)it2.next();
      
        if (firstTime)
        {
          firstTime = false;
          %><BR><B><%= messages.getString("calendar.addappt.resources") %>:</B> <%
        }
        else
        {
          %>, <%
        }
        %><%= resourceEvent.getName() %> <%= resourceEvent.getConfirmedStatus() %><%

      } //for (it2 = vEventResources.iterator(); it2.hasNext(); )
    } //if (vEventResources != null && vEventResources.size() > 0)
    
      %>
      </FONT>
      </LI>
      <%
  } //for (it = vEvents.iterator(); it.hasNext();)

} //if (vEvents.size() > 0)
else
{
%>
<%= messages.getString("calendar.conflicts.event") %>
<%
}
%>
        </UL>
      </BLOCKQUOTE>
    </TD>
  </TR>
<!-- EVENTS END -->
<%
} // Module Manager - Resource (for todo and events)
%>

    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="25%" VALIGN="TOP">
        <P>&nbsp;</P>
      </TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="75%" VALIGN="TOP">
        <A HREF="javascript:history.go(-1);" onMouseOver="window.status='<%= messages.getString("done") %>';return true;">
        <%= showIcon ? "<IMG SRC=\"images/system/ic_done.gif\" WIDTH=\"40\" HEIGHT=\"18\" BORDER=\"0\" ALT=\"Done\">" : messages.getString("done") %></A>
      </TD>
    </TR>