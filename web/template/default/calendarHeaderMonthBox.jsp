<%
  Vector calBoxUserList=null;
  String calViewUserID=null;
  
  if (request.getParameter("viewUserID") != null)
  {
    TvoContextManager.setSessionAttribute(request, "Calendar.viewUserID", request.getParameter("viewUserID"));
  }
  if (TvoContextManager.getSessionAttribute(request, "Calendar.viewUserID") == null)
  {
    calViewUserID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
    TvoContextManager.setSessionAttribute(request, "Calendar.viewUserID", calViewUserID);
  }
  else
  {
    calViewUserID = (String)TvoContextManager.getSessionAttribute(request, "Calendar.viewUserID");
  }

%>
	<script language = "javascript">
	function chooseView(){
  selection = document.calendarViewUser.viewPattern.value;
	if (selection == 'daily')
	  document.calendarViewUser.action = "calendar.jsp?action=viewDay";
	else if (selection == 'weekly')
	  document.calendarViewUser.action = "calendar.jsp?action=viewWeek";
	else 	if (selection == 'monthly')
	  document.calendarViewUser.action = "calendar.jsp?action=viewMonth";
	if (selection != '')	
	  document.calendarViewUser.submit();
	}
	</script>

<script>
<!--
	var recipientWin;
	
 	function recipientPopup() {
	 	var myFormField = eval("document.calendarViewUser.viewUserID");
	 	if (myFormField.options[myFormField.selectedIndex].value != "") {
		 	myFormField.form.submit();
	 	} else {
			if (recipientWin == null || recipientWin.closed) {
				recipientWin = window.open('calendarrecipient.jsp?popupType=viewuser', 'recipientPopup', 'width=600,height=450,resizable=yes,scrollbars=yes');
			}
			recipientWin.focus();
		}
	}
	
	function getRecipient(columnName) {
		var myFormField = eval("document.calendarViewUser." + columnName);
		if (myFormField != null) {
			myFormField.selectedIndex = 0;
			return(myFormField.options[0].value);
		} else {
			return("");
		}
	}
	
	function updateRecipient(columnName, newValue) {
		var myFormField = eval("document.calendarViewUser." + columnName);
		if (myFormField != null) {
			myFormField.options[0].value = newValue;
		}
	}
	
	function updateDisplay(columnType, newValue) {
		var myFormField = eval("document.calendarViewUser." + columnType);
		if (myFormField != null) {
			myFormField.options[0].text = newValue;
			myFormField.form.submit();
		}
	}
//-->
</script>

            <TABLE WIDTH="100%" BORDER="0" CELLSPACING="10" CELLPADDING="5">
              <TR VALIGN="TOP">
                <TD>
                  <TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="3">
                    <TR VALIGN="MIDDLE">
										<% if (showIcon) { %>
											<TD HEIGHT="16" <%= action.equals("viewDay") ? "BACKGROUND=\"images/system/dailystrap.gif\"" : "" %><%= action.equals("viewWeek") ? "BACKGROUND=\"images/system/weeklystrap.gif\"" : "" %><%= action.equals("viewMonth") ? "BACKGROUND=\"images/system/monthlystrap.gif\"" : "" %> COLSPAN="7"><A HREF="calendar.jsp?action=viewDay" onMouseOver="window.status='View Day';return true;"><IMG SRC="images/system/blank.gif" WIDTH="77" HEIGHT="16" BORDER="0"></A><A HREF="calendar.jsp?action=viewWeek" onMouseOver="window.status='View Week';return true;"><IMG SRC="images/system/blank.gif" WIDTH="86" HEIGHT="16" BORDER="0"></A><A HREF="calendar.jsp?action=viewMonth" onMouseOver="window.status='View Month';return true;"><IMG SRC="images/system/blank.gif" WIDTH="89" HEIGHT="16" BORDER="0"></A></TD>
										<% } else { %>
                      <TD HEIGHT="22" COLSPAN="7" BACKGROUND="images/system/strap.gif"><IMG SRC="images/system/blank.gif" WIDTH="20" HEIGHT="5"><FONT COLOR="#FFCC66" SIZE="2" CLASS="<%= contentTitleFont %>"><%= messages.getString("calendar") %></FONT></TD>
										<% } %>
                    </TR>
                    <FORM NAME="calendarViewUser" METHOD="POST" ACTION="calendar.jsp?action=view">
                    <TR VALIGN="MIDDLE">
                      <TD BGCOLOR="#003366" CLASS="contentStrapColor" COLSPAN="7">
											
										  <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">										
											
	                    <TR VALIGN="MIDDLE" >
											<% if (!showIcon) {	%>
												<TD BGCOLOR="#003366" CLASS="contentStrapColor"  ALIGN="left">
	                        <SELECT NAME="viewPattern" onChange="chooseView();">
												    <option value = ""><%= messages.getString("select") %> 
													  <option value="daily"><%= messages.getString("calendar.daily") %></option>
													  <option value="weekly"><%= messages.getString("calendar.weekly") %></option>
													  <option value="monthly"><%= messages.getString("calendar.monthly") %></option>
													</select>
												</td>
											<% } %>
											
                      <TD BGCOLOR="#003366" CLASS="contentStrapColor"  ALIGN="RIGHT">
                        <SELECT NAME="viewUserID" SIZE="1" onChange="recipientPopup();">
                        	<%
                        		RecipientUtil rUtil = new RecipientUtil();
                        		rUtil.initTVO(request);
                        		
                        		String currUserName = rUtil.getUserNames(ConvUtil.stringToStringArray(calViewUserID));
                        		if (currUserName.endsWith(",")) {
                        			currUserName = currUserName.substring(0, currUserName.length() - 1);
                        		}
                        		
                        		String myUserName = rUtil.getUserNames(ConvUtil.stringToStringArray(userID));
                        		if (myUserName.endsWith(",")) {
                        			myUserName = myUserName.substring(0, myUserName.length() - 1);
                        		}
                        	%>
                        	<option value="<%=calViewUserID%>"><%=currUserName%></option>
                        	<% if (!calViewUserID.equals(userID)) { %>
                        	<option value="<%=userID%>"><%=myUserName%></option>
                        	<% } %>
                        	<option value="">- Select User -</option>
                        </SELECT>
                      </TD>
											</tr>
											</td>
											</tr>
											</table>
                    </TR>
                    </FORM>
                    <script>
                    	function calDispatch(act) {
	                    	var newurl = "calendar.jsp?action=" + act;
	                    	if (act == "addAppt" || act == "addToDo") {
		                    	location = newurl;
	                    	} else {
		                    	MM_openBrWindow(newurl,'calendarAdd','scrollbars=yes,resizable=yes,width=480,height=420');
	                    	}
                    	}
                    </script>
                    <FORM NAME="calendarAdd" METHOD="POST">
                    <TR VALIGN="MIDDLE" ALIGN="RIGHT">
                      <TD  BGCOLOR="#003366" CLASS="contentStrapColor" COLSPAN="7">                          
                        <SELECT onChange="calDispatch(this.value);">
                          <OPTION value="addAppt"><%= messages.getString("select") %></OPTION>
                          <OPTION value="addAppt"><%= messages.getString("calendar.appointment") %></OPTION>
                          <OPTION value="addToDo"><%= messages.getString("calendar.todo.task") %></OPTION>
                          <OPTION value="getFreeTimeSlot">Free Time Slot</OPTION>
                        </SELECT>
                    </TR>
                    </FORM>
