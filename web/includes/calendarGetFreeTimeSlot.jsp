<%@ page import="ecomm.bean.FreeTime, paulUtil.ConvUtil, paulUtil.DateUtil, utilities.UserUtil" %>

<%!
	String displayConfictDateTime(Date start, Date end) {
		String retString = DateUtil.formatDate("d MMM yyyy h:mm a", start);
		if ((DateUtil.getDateOnly(start)).compareTo(DateUtil.getDateOnly(end)) == 0) {
			retString = retString + " - " + DateUtil.formatDate("h:mm a", end);				// Same day
		} else {
			retString = retString + " - " + DateUtil.formatDate("d MMM yyyy h:mm a", end);	// Different day
		}
		
		return(retString);
	}
%>
<%
	int startYear, startMonth, startDay;
	int startHour, startMinute, endHour, endMinute;
	int minFreeTime = 0;
	
	if (request.getParameter("startYear") != null) {
		startYear   = Integer.parseInt(request.getParameter("startYear"));
		startMonth  = Integer.parseInt(request.getParameter("startMonth"));
		startDay    = Integer.parseInt(request.getParameter("startDay"));
		
		if (request.getParameter("allDay") != null) {
			startHour   = 0;
			startMinute = 0;
			endHour     = 23;
			endMinute   = 59;
		} else {
			startHour   = Integer.parseInt(request.getParameter("startHour"));
			startMinute = Integer.parseInt(request.getParameter("startMinute"));
			endHour     = Integer.parseInt(request.getParameter("endHour"));
			endMinute   = Integer.parseInt(request.getParameter("endMinute"));
		}
		minFreeTime = Integer.parseInt(request.getParameter("minFreeTime"));
		
	} else {
		java.util.Date currDate = new java.util.Date();
		startYear   = DateUtil.getDatePart(currDate, java.util.Calendar.YEAR);
		startMonth  = DateUtil.getDatePart(currDate, java.util.Calendar.MONTH);
		startDay    = DateUtil.getDatePart(currDate, java.util.Calendar.DATE);
		
		startHour   = DateUtil.getDatePart(currDate, java.util.Calendar.HOUR_OF_DAY);
		startMinute = DateUtil.getDatePart(currDate, java.util.Calendar.MINUTE);
		endHour     = startHour;
		endMinute   = startMinute;
	}
%>

<style>
	.freeTimeTable {
		font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
		font-size : xx-small;
	}
	.userConflictTable {
		font-family : Verdana, Geneva, Arial, Helvetica, sans-serif;
		font-size : xx-small;
	}
</style>

<% if (request.getParameter("people") != null) { %>
	<%
		Date startDT = null;
		Date endDT   = null;
		try {
			startDT = DateUtil.getDate(startYear, startMonth, startDay, startHour, startMinute, 0);
			endDT   = DateUtil.getDate(startYear, startMonth, startDay, endHour, endMinute, 0);
			
			// Minus one minute if not "All Day" and not same time
			if (request.getParameter("allDay") == null && startDT.compareTo(endDT) != 0) {
				endDT = DateUtil.dateAdd(endDT, java.util.Calendar.MINUTE, -1);
			}
		} catch (Exception e) { }
		
		String peopleList = ConvUtil.stringArrayToEnclosedString(request.getParameterValues("people"), "'");
		if (request.getParameter("excludeYourself") == null) {
			peopleList = "'" + userID + "', " + peopleList;
		}
		
		FreeTime ft = new FreeTime();
		ft.initTVO(request);
		Vector dateTimeVector = ft.getFreeTime(startDT, endDT, peopleList);
		
		Vector userConflictsVec = ft.getUserConflict(startDT, endDT, peopleList);
	%>
	<tr>
		<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="32%" align="right" valign="middle">From:&nbsp; </td>
		<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="68%" valign="top">
			<%=DateUtil.formatDate("d MMM yyyy h:mm a", startDT)%>
		</td>
	</tr>
	<tr>
		<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="32%" align="right" valign="middle">To:&nbsp; </td>
		<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="68%" valign="top">
			<%=DateUtil.formatDate("d MMM yyyy h:mm a", endDT)%>
		</td>
	</tr>
	<tr>
		<td bgcolor="#EFEFEF" class="contentBgColor" colspan="2" valign="middle">&nbsp;&nbsp;</td>
	</tr>
	<tr>
		<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="32%" align="right" valign="top">Users:&nbsp; </td>
		<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="68%" valign="top">
			<%
				UserUtil uu = new UserUtil();
				uu.initTVO(request);
				out.println(uu.getPersonNameList(peopleList, "<br>"));
			%>
		</td>
	</tr>
	<tr>
		<td bgcolor="#EFEFEF" class="contentBgColor" colspan="2" valign="middle">&nbsp;&nbsp;</td>
	</tr>
	<tr>
		<td bgcolor="#EFEFEF" class="contentBgColorAlternate" colspan="2" align="center">
			<table border="1" cellpadding="2" cellspacing="0" width="280">
				<tr>
					<td class="freeTimeTable" colspan="3"><b>FREE TIME SLOTS</b> 
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
				<tr>
					<td class="freeTimeTable"><b>From&nbsp;</b></td>
					<td class="freeTimeTable"><b>To&nbsp;</b></td>
					<td class="freeTimeTable"><b>Duration&nbsp;</b></td>
				</tr>
				<% if (dateTimeVector.size() != 0) { %>
					<%
						for (int i=0; i<dateTimeVector.size(); i++) {
							Hashtable ht = (Hashtable) dateTimeVector.get(i);
							java.util.Date pStart = (java.util.Date) ht.get("pStart");
							java.util.Date pEnd   = (java.util.Date) ht.get("pEnd");
							int duration = (int) ft.differenceInMinutes(pEnd, pStart) + 1;
							if (minFreeTime != 0 && duration < minFreeTime) {
								continue;
							}
							
					%>
					<tr>
						<td class="freeTimeTable"><%=DateUtil.formatDate("h:mm a", pStart)%>&nbsp;</td>
						<td class="freeTimeTable"><%=DateUtil.formatDate("h:mm a", pEnd)%>&nbsp;</td>
						<td class="freeTimeTable"><%=ft.displayHourMinutes(duration)%>&nbsp;</td>
					</tr>
					<%
						}
					%>
				<% } else { %>
					<tr>
						<td class="freeTimeTable" colspan="3">No free time slots</td>
					</tr>
				<% } %>
			</table>
		</td>
	</tr>
	<tr>
		<td bgcolor="#EFEFEF" class="contentBgColor" colspan="2" valign="middle">&nbsp;&nbsp;</td>
	</tr>
	<tr>
		<td bgcolor="#EFEFEF" class="contentBgColorAlternate" colspan="2" align="center">
			<table border="1" cellpadding="2" cellspacing="0" width="280">
				<tr>
					<td class="userConflictTable"><b>CONFLICTS</b></td>
				</tr>
				<% 
					for (int i=0; i<userConflictsVec.size(); i++) {
						Hashtable htUser = (Hashtable) userConflictsVec.get(i);
						Vector conflictVec = (Vector) htUser.get("conflicts");
				%>
				<tr>
					<td class="userConflictTable">
						<b><%=htUser.get("personName")%></b><br>
						<% 
							for (int conflictIndex=0; conflictIndex<conflictVec.size(); conflictIndex++) {
								Hashtable htConflict = (Hashtable) conflictVec.get(conflictIndex);
						%>
							&nbsp;&nbsp; <%=displayConfictDateTime((Date) htConflict.get("StartDateTime"), (Date) htConflict.get("EndDateTime"))%><br>
							&nbsp;&nbsp;&nbsp; - (<%=htConflict.get("Description")%>)<br>
						<%
							}
						%>
					</td>
				</tr>
				<%
					}
				%>
				<% if (userConflictsVec.size() == 0) { %>
				<tr>
					<td class="userConflictTable">None</td>
				</tr>
				<% } %>
			</table>
		</td>
	</tr>
	<tr>
		<td bgcolor="#EFEFEF" class="contentBgColor" colspan="2" valign="middle">&nbsp;&nbsp;</td>
	</tr>
	<tr>
		<td bgcolor="#EFEFEF" class="contentBgColor" colspan="2" align="center">
			<a href="calendar.jsp?action=getFreeTimeSlot"><img src="images/system/ic_back.gif" border="0"></a>
			<a href="calendar.jsp"><img src="images/system/ic_cancel.gif" border="0"></a>
		</td>
	</tr>
<% } else {%>
<jsp:useBean id="staffStudent" scope="request" class="common.StaffStudent"/>
<%
	String userType = staffStudent.getUserType(request, response, userID);

	Vector vGroups;
	if (userType.equals("STUDENT")) {
		vGroups = (Vector) beanCalendarDirectory.showModuleStudent(userID, "Groups", "view");
	} else {
		vGroups = (Vector) beanCalendarDirectory.showModule(userID, "Groups", "view");
	}
	
	Vector vGroupID = null, vGroupName = null;
	if (vGroups != null && vGroups.size() > 0) {
		vGroupID   = (Vector) vGroups.get(0);
		vGroupName = (Vector) vGroups.get(1);
	}
	
	Vector vParameter = null;
	
	StringBuffer stringUserID=null, stringName=null, stringGroupID=null;
	stringUserID  = new StringBuffer().append("");
	stringName    = new StringBuffer().append("");
	stringGroupID = new StringBuffer().append("");
	
	Vector vUsers = (Vector) beanCalendarDirectory.showModule(userID, "Users", "view");
	if (vUsers != null) {  
		for (int i = 0; i < vUsers.size()-1; i++) {
			UsersDB users = (UsersDB) vUsers.get(i);
			if ( !userID.equals(users.getUserID()) ) {
				stringUserID.append("'" + users.getUserID() + "',");
				stringName.append("'" + CommonFunction.escapeQuote(CommonFunction.restrictNameLength(users.getName(), 20)) + "',");
				stringGroupID.append("\"" + users.getGroupID() + "\",");
			}
		}
		if ( !stringUserID.toString().equals("") ) {
			stringUserID  = new StringBuffer().append(stringUserID.substring(0, stringUserID.length()-1));
			stringName    = new StringBuffer().append(stringName.substring(0, stringName.length()-1));
			stringGroupID = new StringBuffer().append(stringGroupID.substring(0, stringGroupID.length()-1));
		}
	}
%>

<SCRIPT LANGUAGE="JavaScript">
	myUserID  = new Array(<%= stringUserID %>)
	myNames   = new Array(<%= stringName %>)
	myGroupID = new Array(<%= stringGroupID %>)	  
</SCRIPT>

<form name="freeTime" method="post">
<input type="hidden" name="action" value="<%=action%>">
<tr>
	<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="32%" align="right" valign="middle">Date&nbsp; </td>
	<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="68%" valign="top">
		<select name="startDay">
		<%  for (int i=1;i<32;i++) {  %>
			<option value="<%= ( i>0 && i<10 ? "0":"")+i %>"<% if (startDay == i) { %> SELECTED<% } %>><%= ( i>0 && i<10 ? "0":"")+i %> </option>
		<%	}  %>		
		</select>
		
		<select name="startMonth">
			<option value="0" <% if (startMonth == 0) { %> SELECTED<% } %>><%= messages.getString("short.jan") %></option>
			<option value="1" <% if (startMonth == 1) { %> SELECTED<% } %>><%= messages.getString("short.feb") %></option>
			<option value="2" <% if (startMonth == 2) { %> SELECTED<% } %>><%= messages.getString("short.mar") %></option>
			<option value="3" <% if (startMonth == 3) { %> SELECTED<% } %>><%= messages.getString("short.apr") %></option>
			<option value="4" <% if (startMonth == 4) { %> SELECTED<% } %>><%= messages.getString("short.may") %></option>
			<option value="5" <% if (startMonth == 5) { %> SELECTED<% } %>><%= messages.getString("short.jun") %></option>
			<option value="6" <% if (startMonth == 6) { %> SELECTED<% } %>><%= messages.getString("short.jul") %></option>
			<option value="7" <% if (startMonth == 7) { %> SELECTED<% } %>><%= messages.getString("short.aug") %></option>
			<option value="8" <% if (startMonth == 8) { %> SELECTED<% } %>><%= messages.getString("short.sep") %></option>
			<option value="9" <% if (startMonth == 9) { %> SELECTED<% } %>><%= messages.getString("short.oct") %></option>
			<option value="10" <% if (startMonth == 10) { %> SELECTED<% } %>><%= messages.getString("short.nov") %></option>
			<option value="11" <% if (startMonth == 11) { %> SELECTED<% } %>><%= messages.getString("short.dec") %></option>
		</select>
		
		<select name="startYear">
		<% for (int i=Integer.parseInt((String)TvoContextManager.getAttribute(request, "System.startYear")); i <= Integer.parseInt((String)TvoContextManager.getAttribute(request, "System.endYear")); i++) { %>
			<option value="<%= i %>" <% if (startYear == i) { %> SELECTED<% } %>><%= i %></option>
		<% } %>
		</select>
	</td>
</tr>
<tr>
	<td bgcolor="#EFEFEF" class="contentBgColor" colspan="2" valign="middle">&nbsp;&nbsp;</td>
</tr>
<tr>
	<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="32%" align="right" valign="middle">Start Time&nbsp; </td>
	<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="68%" valign="top">
		<select name="startHour">
		<% for (int i=0;i<24;i++) { %>
			<option value="<%= (i>=0 && i<10 ? "0":"")+i %>" <% if (startHour == i) { %> SELECTED<% } %>> <%= ( i>=0 && i<10 ? "0":"")+i %> </option>
		<% } %>
		</select> :
		
		<select name="startMinute">
		<% for (int i=0;i<46;i+=15) { %>
			<option value="<%= (i==0 ? "0":"")+i %>" <% if (startMinute == i) { %> SELECTED<% } %>> <%= ( i==0 ? "0":"")+i %> </option>
		<% } %>
		</select>
	</td>
</tr>
<tr>
	<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="32%" align="right" valign="middle">End Time&nbsp; </td>
	<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="68%" valign="top">
		<select name="endHour">
		<% for (int i=0;i<24;i++) { %>
			<option value="<%= (i>=0 && i<10 ? "0":"")+i %>" <% if (endHour == i) { %> SELECTED<% } %>> <%= ( i>=0 && i<10 ? "0":"")+i %> </option>
		<% } %>
		</select> :
		
		<select name="endMinute">
		<% for (int i=0;i<46;i+=15) { %>
			<option value="<%= (i==0 ? "0":"")+i %>" <% if (endMinute == i) { %> SELECTED<% } %>> <%= ( i==0 ? "0":"")+i %> </option>
		<% } %>
		</select>
		<input type="checkbox" name="allDay" value="1">All Day
	</td>
</tr>
<tr>
	<td bgcolor="#EFEFEF" class="contentBgColor" colspan="2" valign="middle">&nbsp;&nbsp;</td>
</tr>
<tr>
	<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="32%" align="right" valign="middle">&nbsp; </td>
	<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="68%" valign="top">
		<select name="minFreeTime">
			<option value="0">- None -</option>
			<option value="60">1 Hour</option>
			<option value="120">2 Hours</option>
			<option value="180">3 Hours</option>
			<option value="240">4 Hours</option>
		</select>
		Mininum time slot
	</td>
</tr>
<tr>
	<td bgcolor="#EFEFEF" class="contentBgColor" colspan="2" valign="middle">&nbsp;&nbsp;</td>
</tr>
<tr>
	<td bgcolor="#EFEFEF" class="contentBgColor" align="CENTER" valign="TOP" colspan="2">
		<table border="0" cellspacing="0" cellpadding="0">
			<tr><td class="contentBgColor" colspan="3">
				Users<br>
				<select name="groupID" size="1" onChange="loadGroupItems(this.options[this.selectedIndex].value, myGroupID, myNames, myUserID, document.freeTime.allPeople, '<%= messages.getString("none.with.line") %>', -1, document.freeTime.people);">
					<option value="0" selected><%= messages.getString("select") %></option>
					<option value="-1"><%= messages.getString("all.users") %></option>
					<%if (vGroupID != null && vGroupName != null)
					for (int i=0; i < vGroupID.size(); i++) {
					%><option value="<%= vGroupID.get(i) %>"><%= CommonFunction.restrictNameLength((String)vGroupName.get(i), 20) %></option>
					<%}%>
				</select>
			</td></tr>

			<tr><td class="contentBgColor" valign="TOP">
				<select name="allPeople" size="5" multiple>
				</select>
				</td>
				<td class="contentBgColor" align="CENTER" valign="MIDDLE" >
				<a href="javascript:moveItems(document.freeTime.allPeople, document.freeTime.people, '<%= messages.getString("none.with.line") %>', -1);" onMouseOver="window.status='<%= messages.getString("add") %>';return true;"><img src="images/system/ic_rightarrow.gif" border="0" alt="<%= messages.getString("add") %>"></a><br><br>
				<a href="javascript:moveItems(document.freeTime.people, document.freeTime.allPeople, '<%= messages.getString("none.with.line") %>', -1);" onMouseOver="window.status='<%= messages.getString("email.remove") %>';return true;"><img src="images/system/ic_leftarrow.gif" border="0" alt="<%= messages.getString("email.remove") %>"></a>
				</td>
				<td class="contentBgColor" valign="TOP">
				<select name="people" size="5" multiple>		
				<%
					for (int i=0; vParameter != null && i < vUsers.size()-1; i++) {
						UsersDB users = (UsersDB)vUsers.get(i);
						if ( userID.equals(users.getUserID()) )
							continue;
						if ( vParameter.indexOf(users.getUserID()) != -1 ) {
				%>
				<option value="<%= users.getUserID() %>"><%= CommonFunction.restrictNameLength(users.getName(), 20) %></option>
				<%
						}
					}
				%>
				</select>
			</td></tr>
			<tr><td class="contentBgColor" align="LEFT" valign="TOP">
					<a href="javascript:selectAllItems(document.freeTime.allPeople);" onMouseOver="window.status='<%= messages.getString("select.all") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_selectall.gif\" BORDER=\"0\" ALT=\"Select All\">" : messages.getString("select.all") %></a> 
					<a href="javascript:clearAllItems(document.freeTime.allPeople);" onMouseOver="window.status='<%= messages.getString("clear.all") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_clear.gif\" BORDER=\"0\" ALT=\"Clear All Selected\">" : messages.getString("clear.all") %></a>
				</td>
				<td class="contentBgColor">&nbsp;</td>
				<td class="contentBgColor" align="LEFT" valign="TOP">
					<a href="javascript:selectAllItems(document.freeTime.people);" onMouseOver="window.status='<%= messages.getString("select.all") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_selectall.gif\" BORDER=\"0\" ALT=\"Select All\">" : messages.getString("select.all") %></a> 
					<a href="javascript:clearAllItems(document.freeTime.people);" onMouseOver="window.status='<%= messages.getString("clear.all") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_clear.gif\" BORDER=\"0\" ALT=\"Clear All Selected\">" : messages.getString("clear.all") %></a>
				</td>
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td bgcolor="#EFEFEF" class="contentBgColor" colspan="2" valign="middle">&nbsp;&nbsp;</td>
</tr>
<tr>
	<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="32%" align="right" valign="middle">&nbsp; </td>
	<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="68%" valign="top">
		<input type ="checkbox" name="excludeYourself" value="1" > Exclude Yourself
	</td>
</tr>
<tr>
	<td bgcolor="#EFEFEF" class="contentBgColor" colspan="2" valign="middle">&nbsp;&nbsp;</td>
</tr>
<tr>
	<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="32%" align="right" valign="middle">&nbsp; </td>
	<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="68%" valign="top">
		<a href="javascript: document.freeTime.submit();"><img src="images/system/ic_search.gif" border="0"></a>
		<a href="calendar.jsp"><img src="images/system/ic_cancel.gif" border="0"></a>
	</td>
</tr>
</form>

<SCRIPT LANGUAGE="JavaScript">
	myForm = document.freeTime;
	noItems(myForm.allPeople, '<%= messages.getString("none.with.line") %>', -1);
	noItems(myForm.people, '<%= messages.getString("none.with.line") %>', -1);
</SCRIPT>
<% } %>
