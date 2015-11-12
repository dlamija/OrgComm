<%
	int calendarApptID = Integer.parseInt(request.getParameter("calendarApptID"));
%>
<form name="calendarApptAttach" enctype="multipart/form-data" method="post" action="servlet/Calendar?action=addApptAttach">
	<input type="hidden" name="calendarApptID" value="<%=calendarApptID%>">
	<tr>
		<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="32%" align="right" valign="middle">&nbsp;</td>
		<td bgcolor="#EFEFEF" class="contentBgColorAlternate" width="68%" valign="top">&nbsp;</td>
	</tr>
	<% for(int i=1; i<=10; i++) { %>
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
			<a href="javascript: document.forms.calendarApptAttach.submit();"><img src="images/system/ic_add.gif" border="0"></a>
			<a href="javascript: location='calendar.jsp';"><img src="images/system/ic_cancel.gif" border="0"></a>
		</td>
	</tr>
</form>