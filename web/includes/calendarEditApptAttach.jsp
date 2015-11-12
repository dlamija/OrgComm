<%
	int calendarApptID = Integer.parseInt(request.getParameter("calendarApptID"));
	
	Vector apptVec       = (Vector) beanCalendar.getAppointmentByID(userID, String.valueOf(calendarApptID));
	Vector apptAttachVec = (Vector) beanCalendar.getAppointmentAttachments(calendarApptID);
	String attachURL     = TvoContextManager.generateFolderName(request) + "/appointment/" + ((Vector) apptVec.get(0)).get(0) + "/";
%>
<form name="calendarApptAttach" enctype="multipart/form-data" method="post" action="servlet/Calendar?action=editApptAttach">
	<input type="hidden" name="calendarApptID" value="<%=calendarApptID%>">
	<tr>
		<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="32%" align="right" valign="middle">&nbsp;</td>
		<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="68%" valign="top">&nbsp;</td>
	</tr>
	<tr>
		<td bgcolor="#EFEFEF" class="contentBgColorAlternate" colspan="2">
			<img src="images/system/blank.gif" border="0" width="50" height="1">
			<font size="2" face="Arial"><b>Current Attachments</b></font>
		</td>
	</tr>
	<% if (apptAttachVec.size() != 0) { %>
		<% for (int attachIndex=0; attachIndex<apptAttachVec.size(); attachIndex++) { %>
			<% Hashtable attachHT = (Hashtable) apptAttachVec.get(attachIndex); %>
			<tr>
				<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="32%" align="right" valign="middle"><a href="servlet/Calendar?action=deleteApptAttach&calendarApptID=<%=calendarApptID%>&attachID=<%=attachHT.get("attachID")%>"><img src="images/system/ic_delete.gif" border="0"></a>&nbsp;</td>
				<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="68%" valign="top"><font SIZE="2" class="calendarContentFont"><%=attachHT.get("originalFilename")%></font></td>
			</tr>
		<% } %>
	<% } else { %>
		<tr>
			<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="32%" align="right" valign="middle">&nbsp;</td>
			<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="68%" valign="top">No attachments.</td>
		</tr>
	<% } %>
	<tr>
		<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="32%" align="right" valign="middle">&nbsp;</td>
		<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="68%" valign="top">&nbsp;</td>
	</tr>
	<tr>
		<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="32%" align="right" valign="middle">&nbsp;</td>
		<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="68%" valign="top">&nbsp;</td>
	</tr>
	<tr>
		<td bgcolor="#EFEFEF" class="contentBgColorAlternate" colspan="2">
			<img src="images/system/blank.gif" border="0" width="50" height="1">
			<font size="2" face="Arial"><b>New Attachments</b></font>
		</td>
	</tr>
	<% for(int i=1; i<=5; i++) { %>
	<tr>
		<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="32%" align="right" valign="middle">File <%=i%>: &nbsp;</td>
		<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="68%" valign="top">
			<input type="file" name="attach<%=i%>">
		</td>
	</tr>
	<% } %>
	<tr>
		<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="32%" align="right" valign="middle">&nbsp;</td>
		<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="68%" valign="top">&nbsp;</td>
	</tr>
	<tr>
		<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="32%" align="right" valign="middle">&nbsp;</td>
		<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="68%" valign="top">&nbsp;</td>
	</tr>
	<tr>
		<td bgcolor="#EFEFEF" class="contentBgColorAlternate" colspan="2" align="center">
			<a href="javascript: document.forms.calendarApptAttach.submit();"><img src="images/system/ic_update.gif" border="0"></a>
			<a href="javascript: location='calendar.jsp';"><img src="images/system/ic_cancel.gif" border="0"></a>
		</td>
	</tr>
</form>