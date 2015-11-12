<%
  if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_TAMS) )
  {

   String toDoID = request.getParameter("toDoID");
   Vector vToDo = (Vector)beanCalendar.getToDoByID(userID,toDoID,action);
   CalendarToDo calendar = (CalendarToDo) vToDo.get(0);
   Vector vCC = (Vector)vToDo.get(1);
   CalendarToDoUser toDoUser = (CalendarToDoUser) vToDo.get(2);
   Vector vAssignees = (Vector)vToDo.get(3);
   int i=0;
   
   String reminderDate = calendar.getReminderDate();
   if (reminderDate == null)
    reminderDate = messages.getString("none");
   else
    reminderDate = CommonFunction.getDate("yyyy-MM-dd", "dd-MMM-yyyy", reminderDate);
    
   Vector vResources = (Vector) vToDo.get(4);
%>
   <form>
    <TR VALIGN="TOP">
     <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" colspan="2">
	  <table border="0" cellspacing="0" cellpadding="0" width="100%">
	   <tr>
	    <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" align="right" width="50%">
		 <b><%= messages.getString("calendar.todo.due.date") %>:</b>&nbsp;&nbsp;&nbsp;
		</td>
		


	    <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate"  width="50%">
		 <%= CommonFunction.parseDate(dateFormat,currentLocale,calendar.getDueDate(),null,TvoConstants.DATE_FOMRAT_SHORT) %>
		</td>
	   </tr>
	   
	   <tr>
	    <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" align="right">
		 <b><%= messages.getString("calendar.todo.due.time") %>:</b>&nbsp;&nbsp;&nbsp;
		</td>

	    <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate">
		 <%= calendar.getDueTime() %>
		</td>
	   </tr>
	   
	   <tr>
	    <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" align="right">
		 <b><%= messages.getString("calendar.addappt.set.reminder") %>:</b>&nbsp;&nbsp;&nbsp;
		</td>

	    <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate">
		 <%= reminderDate %>
		</td>
	   </tr>
	   
	   <tr>
	    <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" align="right">
		 <b><%= messages.getString("calendar.category") %>:</b>&nbsp;&nbsp;&nbsp;
		</td>

	    <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate">
		 <%= beanTams.getTamsGroupID(request,userID,Integer.parseInt(toDoID),"viewToDo") %>
		</td>
	   </tr>
	   
	   <tr>
	    <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" align="right" valign="top">
		 <b><%= messages.getString("calendar.addappt.description") %>:</b>&nbsp;&nbsp;&nbsp;
		</td>

	    <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate">
		 <%= calendar.getDescription() %>
		</td>
	   </tr>

	   <tr>
	    <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" align="right" valign="top">
		 <b><%= messages.getString("calendar.todo.assigned.to") %>:</b>&nbsp;&nbsp;&nbsp;
		</td>

	    <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate">
		 <%= beanCalendarDirectory.getUserName( toDoUser.getUserID() ) %>
		</td>
	   </tr>

    <%
    // display reassignees if necessary
    	//if (vAssignees != null && vAssignees.size() > 0) {
    
    %>
	   <tr>
	    <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" align="right" valign="top">
		 <b><%= messages.getString("calendar.todo.reassigned.to") %>:</b>&nbsp;&nbsp;&nbsp;
		</td>

	    <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate">
		<% boolean first = true;
		   for (int k = 0; k < vAssignees.size(); k++) {
				CalendarToDoUser user = (CalendarToDoUser)vAssignees.get(k);
				if (first) 
					first = false;
				else
					out.println(", ");
		%>				
	        <%= beanCalendarDirectory.getUserName( user.getUserID() ) %>
	    <% } %>
    
		</td>
	   </tr>

    <%// } %>
   

	   
	   <tr>
	    <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" align="right" valign="top">
		 <b><%= messages.getString("calendar.todo.cc.to") %>:</b>&nbsp;&nbsp;&nbsp;
		</td>

	    <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate">
<%
        if (vCC != null && vCC.size() > 0)
		{
		 for (i=0;i<vCC.size();i++)
		 {
		  CalendarToDoCC calendar2 = (CalendarToDoCC) vCC.get(i);
%>
		  <%= calendar2.getCCName() %><br>
<%		
		 }
		}
		else
		{
%>
		 <%= messages.getString("none") %>
<%		
		}
%>		
		</td>
	   </tr>
	   
	   <tr>
	    <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" align="right" valign="top">
		 <b><%= messages.getString("calendar.edit.todo.current.file") %>:</b>&nbsp;&nbsp;&nbsp;
		</td>

	    <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate">
<%		
        if (calendar.getFileName().equals(""))
		{
%>
		 <%= messages.getString("none") %>
<%
		}	
		else
		{	  
%>
         <a href="<%=TvoContextManager.generateFolderName(request)%>/todo/<%= toDoID %>/<%= calendar.getPhysicalFileName() %>" target="calendarViewToDo" onMouseOver="window.status='View File';return true;"><%= calendar.getFileName() %></a>
<%
        }
%>		
		</td>
	   </tr>
	    <tr>
	    <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" align="right" valign="top">
		 <b><%= messages.getString("calendar.addappt.resources") %>:</b>&nbsp;&nbsp;&nbsp;
		</td>

	    <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate">
<%		
		if (vResources == null || vResources.size() < 1)
		{
%>
		 <%= messages.getString("none") %>
<%		
		}
		else
		{
		 int resourceID = 0;
		 for (i=0;i<vResources.size();i++)
		 {
		  resourceID = ((Integer)vResources.get(i)).intValue();
		  reminderDate = beanResource.getResourceConfirmedFlag(request,resourceID,Integer.parseInt(toDoID));
		  if (reminderDate.equals("2"))
		   reminderDate = "P";
		  else if (reminderDate.equals("1"))
		   reminderDate = "C";
		  else 
		   reminderDate = "R";
%>
		  <%= beanResource.getResourceName(request,resourceID) %> (<%= reminderDate %>)<br>
<%		 
		 }
		}
%>		

		</td>
	   </tr>
	   </table>
	 </td>
    </TR>	
   </form>
   <TR VALIGN="TOP">
    <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" colspan="2">&nbsp;</td>
    </td>
   </tr>
   <TR VALIGN="TOP">
    <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" colspan="2" align="center">
	 <A HREF="javascript:window.close();" onMouseOver="window.status='<%= messages.getString("close") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_close.gif\" BORDER=\"0\" ALT=\"Close\">" : messages.getString("close") %></A>
	</td>
    </td>
   </tr>
<%  
  }
%>  

