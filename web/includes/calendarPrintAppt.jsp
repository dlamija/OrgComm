<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ include file="/includes/import.jsp" %>
<%
Connection conn = null;
PreparedStatement pstmt = null;

try
	{
    Context initCtx = new InitialContext();
    Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
    DataSource ds   = (DataSource)envCtx.lookup( "jdbc/tmsintranetdb" );
	conn = ds.getConnection();
}
catch( Exception e )
	{ 
	out.println (e.toString()); 
	}
%>

<%
	String[] monthList = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
	//String userId = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
	String userId = (String)TvoContextManager.getSessionAttribute(request, "Calendar.viewUserID");
	System.out.println("calendar userId : " + userId);

	String sfd = request.getParameter("fd");
	String sfm = request.getParameter("fm");
	String sfy = request.getParameter("fy");
	String std = request.getParameter("td");
	String stm = request.getParameter("tm");
	String sty = request.getParameter("ty");
	String date_From = sfy+"-"+sfm+"-"+sfd;
	String date_To = sty+"-"+stm+"-"+std;

	Calendar current = Calendar.getInstance();
	
	// resolve the dateFrom
	Calendar dateFrom = Calendar.getInstance();
	dateFrom.set(Calendar.HOUR_OF_DAY,0);
	dateFrom.set(Calendar.MINUTE,0);
	dateFrom.set(Calendar.SECOND,0);
	if (sfd != null && !sfd.isEmpty()) {
		dateFrom.set(Calendar.DAY_OF_MONTH, CommonFunction.getParamAsInt(sfd,current.get(Calendar.DAY_OF_MONTH)));
	}
	if (sfm != null && !sfm.isEmpty()) {
		dateFrom.set(Calendar.MONTH, CommonFunction.getParamAsInt(sfm,current.get(Calendar.MONTH)));
	}
	if (sfy != null && !sfy.isEmpty()) {
		dateFrom.set(Calendar.YEAR, CommonFunction.getParamAsInt(sfy,current.get(Calendar.YEAR)));
	}
	System.out.println("print dateFrom : " + dateFrom.getTime());

	// resolve the dateTo
	Calendar dateTo = Calendar.getInstance();
	dateTo.set(Calendar.HOUR_OF_DAY,0);
	dateTo.set(Calendar.MINUTE,0);
	dateTo.set(Calendar.SECOND,0);
	if (std != null && !std.isEmpty()) {
		dateTo.set(Calendar.DAY_OF_MONTH, CommonFunction.getParamAsInt(std,current.get(Calendar.DAY_OF_MONTH)));
	}
	if (stm != null && !stm.isEmpty()) {
		dateTo.set(Calendar.MONTH, CommonFunction.getParamAsInt(stm,current.get(Calendar.MONTH)));
	}
	if (sty != null && !sty.isEmpty()) {
		dateTo.set(Calendar.YEAR, CommonFunction.getParamAsInt(sty,current.get(Calendar.YEAR)));
	}
	System.out.println("print dateTo : " + dateTo.getTime());

	// get the appointment list
	List<CalendarAppt> appt = beanCalendar.getAppointmentList(userId, dateFrom.getTime(), dateTo.getTime());
%>
<script type="text/javascript">
<!--
	function go() {
		document.printappt.submit();
	}

	function printPdf() {
		var jfd = "fd=<%=sfd %>&fm=<%=sfm %>&fy=<%=sfy %>";
		var jtd = "td=<%=std %>&tm=<%=stm %>&ty=<%=sty %>";
//		alert(jtd);
		window.open("CalendarRep?" + jfd + "&" + jtd);
	}

	function exportIcs() {
		var jfd = "fd=<%=dateFrom.get(Calendar.DAY_OF_MONTH) %>&fm=<%=dateFrom.get(Calendar.MONTH) %>&fy=<%=dateFrom.get(Calendar.YEAR) %>";
		var jtd = "td=<%=dateTo.get(Calendar.DAY_OF_MONTH) %>&tm=<%=dateTo.get(Calendar.MONTH) %>&ty=<%=dateTo.get(Calendar.YEAR) %>";
//		alert(jtd);
		window.location = "ICalExporter/calendar.ics?" + jfd + "&" + jtd;
	}
//-->
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="40"><div style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">| <a href="javascript: history.go(-1)">Back</a> |</div></td>
  </tr>
</table>
<br />
<form method="get" id="printappt" name="printappt" action="calendar.jsp">
	<input type="hidden" id="action" name="action" value="printAppt" />
	<table width="95%" border="0" align="center" cellpadding="5" cellspacing="0">
		<tr>
			<td class="contentStrapColor" align="center" colspan="2"><b>Appointments Schedule</b></td>
		</tr>
		<tr>
			<td class="contentBgColor" align="right" width="42%">Date From&nbsp;</td>
			<td class="contentBgColor">
				<select id="fd" name="fd">
<%
	for (int i = dateFrom.getMinimum(Calendar.DAY_OF_MONTH); i <= dateFrom.getMaximum(Calendar.DAY_OF_MONTH); i++) {
%>
					<option value="<%=i %>" <%=(i==dateFrom.get(Calendar.DAY_OF_MONTH)) ? "selected='selected'" : "" %>><%=i %></option>
<%
	}	
%>
				</select>
			  <!--<select name="fm" id="fm">
				  <option value="01">Jan</option>
                  <option value="02">Feb</option>
                  <option value="03">Mar</option>
                  <option value="04">Apr</option>
                  <option value="05">May</option>
                  <option value="06">Jun</option>
                 <option value="07"> Jul</option>
                  <option value="08">Aug</option>
                  <option value="09">Sep</option>
                  <option value="10">Oct</option>
                  <option value="11">Nov</option>
                  <option value="12">Dec</option>-->
<!--%
	for (int i = 0; i < monthList.length; i++) {
% -->
<!--%
	}	
% -->
				<!--</select>
-->				<select name="fm">
          <% for (int a=1;a<=12;a++) { %>
          <option value="<% if (a<10) { %>0<% } %><%=a%>" <% if (dateFrom.get(Calendar.MONTH)==a) { %> selected<% } %>>
          <% if (a<10) { %>
          0
          <% } %>
          <%=a%></option>
          <% } %>
        </select>
				<select id="fy" name="fy">
  <% 
	for ( int i = Integer.parseInt((String)TvoContextManager.getAttribute(request, "System.startYear")); 
			i <= Integer.parseInt((String)TvoContextManager.getAttribute(request, "System.endYear")); i++) {
%>
				  <option value="<%= i %>" <%=(i==dateFrom.get(Calendar.YEAR)) ? "selected='selected'" : "" %>><%= i %></option>
  <% 
	} 
%>
			  </select>
			</td>
		</tr>
		<tr>
			<td class="contentBgColor" align="right">Date To&nbsp;</td>
			<td class="contentBgColor">
				<select id="td" name="td">
<%
	for (int i = dateTo.getMinimum(Calendar.DAY_OF_MONTH); i <= dateTo.getMaximum(Calendar.DAY_OF_MONTH); i++) {
%>
					<option value="<%=i %>" <%=(i==dateTo.get(Calendar.DAY_OF_MONTH)) ? "selected='selected'" : "" %>><%=i %></option>
<%
	}	
%>
				</select>
			
				<select name="tm">
          <% for (int a=1;a<=12;a++) { %>
          <option value="<% if (a<10) { %>0<% } %><%=a%>" <% if (dateTo.get(Calendar.MONTH)==a) { %> selected<% } %>>
          <% if (a<10) { %>
          0
          <% } %>
          <%=a%></option>
          <% } %>
        </select>
				<select id="ty" name="ty">
  <% 
	for ( int i = Integer.parseInt((String)TvoContextManager.getAttribute(request, "System.startYear")); 
			i <= Integer.parseInt((String)TvoContextManager.getAttribute(request, "System.endYear")); i++) {
%>
				  <option value="<%= i %>" <%=(i==dateTo.get(Calendar.YEAR)) ? "selected='selected'" : "" %>><%= i %></option>
  <% 
	} 
%>
				</select>
			</td>
		</tr>
		<tr>
			<td class="contentBgColor" colspan="2" align="center">
				<a href="javascript:go()"><img src="images/system/ic_submit.gif" alt="" /></a>
			<a href="calendar.jsp"><img src="images/system/ic_cancel.gif" alt="" /></a></td>
		</tr>
	</table>
</form>
 <%
if (conn!=null)
	{
	
	StringBuilder sql = new StringBuilder();
			sql.append("select startdate,endtime,description,location ")
			.append ("from ( ")
			.append (" SELECT CA.* FROM CALENDARAPPT CA ")
			.append (" where ca.userid = ? ")
			.append (" union ")
			.append (" select ca.* from calendarappt ca, ")
			.append (" calendarapptatt caa, calendarapptuser cau ")
			.append (" where ca.calendarapptid = caa.calendarapptid ")
			.append (" AND CAU.CALENDARAPPTATTID = CAA.CALENDARAPPTATTID ")
			.append (" and cau.userid = ? ")
			.append (" ) AA ")
			.append (" WHERE (TO_DATE(AA.STARTDATE,'yyyy-mm-dd') BETWEEN TO_DATE(?,'yyyy-mm-dd') ")
			.append (" AND to_date(?,'yyyy-mm-dd')) ")
			.append (" ORDER BY TO_CHAR(TO_DATE(STARTDATE,'yyyy-mm-dd'),'yyyy') DESC,TO_CHAR(TO_DATE(STARTDATE,'yyyy-mm-dd'),'mm') ")
			.append (" DESC,TO_CHAR(TO_DATE(STARTDATE,'yyyy-mm-dd'),'dd') ASC,STARTTIME ASC ");
		//System.out.println(sql);
	
	try
		{
		pstmt = conn.prepareStatement (sql.toString());
		pstmt.setString (1, userId);
		pstmt.setString (2, userId);
		pstmt.setString (3, date_From);
		pstmt.setString (4, date_To);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.isBeforeFirst ())
			{
%>

<table width="95%" border="0" align="center" cellpadding="2" cellspacing="2">
  <tr>
    <td colspan="4" class="contentStrapColor">&nbsp;</td>
  </tr>
  <tr>
    <td class="contentBgColor" align="center" width="15%"><b>Date</b></td>
    <td class="contentBgColor" align="center" width="15%"><b>Time</b></td>
    <td class="contentBgColor" align="center"><b>Description</b></td>
    <td class="contentBgColor" align="center"><b>Location</b></td>
  </tr>
 <%
			while (rset.next ())
				{
%>
  <tr>
    <td class="contentBgColor" align="center"><%=rset.getString(1)%></td>
   
    <td class="contentBgColor" align="center"><%=rset.getString(2)%></td>
    <td class="contentBgColor"><%=rset.getString(3)%></td>
    <td class="contentBgColor" align="center"><%=( ( rset.getString(4)==null)?"-":rset.getString(4) )%></td>
  </tr>
 <%
				}
%>
  
  <tr>
    <td colspan="4" align="center">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="4" align="center"><input type="button" value="  Print PDF  " onclick="printPdf()" style="color:#FFFFF" />
      <input type="button" value="  Export to Outlook (ICS)  " onclick="exportIcs()" style="color:#FFFFF" /></td>
  </tr>
  <tr>
    <td colspan="4" align="center">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="4" align="left" style="font-size:0.7em;"><b>Note</b> : To export calendar into Microsoft Outlook, click &quot;Export to Outlook (ICS)&quot; button, save the file to your PC, and import it from Microsoft Outlook.</td>
  </tr>
  <%
			}
		else
			{ %>
  <tr>
    <td class="contentBgColor" colspan="4" align="center">-- No Data Available --</td>
  </tr>
   <% }
		rset.close ();
		pstmt.close ();
		}
	catch(Exception e)
		{ System.out.println("kat sini ye : "+ e); }
	//finally
	//	{ conn.close (); }
	}
%>

 
</table>
<br />
<!--<table width="95%" border="0" align="center" cellpadding="2" cellspacing="2">
	<tr>
		<td colspan="4" class="contentStrapColor">&nbsp;</td>
	</tr>
	<tr>
		<td class="contentBgColor" align="center" width="15%"><b>Date</b></td>
		<td class="contentBgColor" align="center" width="15%"><b>Time</b></td>
		<td class="contentBgColor" align="center"><b>Description</b></td>
		<td class="contentBgColor" align="center"><b>Location</b></td>
	</tr>
<%
	if (appt != null && !appt.isEmpty()) {
		for (CalendarAppt ca : appt) {
%>
	<tr>
<%
			String sDate = ca.getStartDate();
			if (ca.getEndDate() != null && !ca.getEndDate().equals(ca.getStartDate())) {
				sDate += " to " + ca.getEndDate();
			}
%>
		<td class="contentBgColor" align="center"><%=sDate %></td>
<%
			String sTime = ca.getStartTime();
			if (ca.getEndTime() != null && !ca.getEndTime().equals(ca.getStartTime())) {
				sTime += " - " + ca.getEndTime();
			}
%>
		<td class="contentBgColor" align="center"><%=sTime %></td>
		<td class="contentBgColor"><%=(ca.getDescription() != null) ? ca.getDescription() : "&nbsp;" %></td>
		<td class="contentBgColor" align="center"><%=(ca.getLocation() != null) ? ca.getLocation() : "&nbsp;" %></td>
	</tr>
<%
		}
%>
	<tr>
		<td class="contentBgColorAlternate" colspan="4" align="center">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="4" align="center">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="4" align="center">
			<input type="button" value="  Print PDF  " onClick="printPdf()" style="color:#FFFFF">
			<input type="button" value="  Export to Outlook (ICS)  " onClick="exportIcs()" style="color:#FFFFF">
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="4" align="left" style="font-size:0.7em;"><b>Note</b> : To export calendar into Microsoft Outlook, click "Export to Outlook (ICS)" button, save the file to your PC, and import it from Microsoft Outlook.</td>
	</tr>
<%
	} else {
%>
	<tr>
		<td class="contentBgColor" colspan="4" align="center">-- No Data Available --</td>
	</tr>
	<tr>
		<td class="contentBgColorAlternate" colspan="4" align="center">&nbsp;</td>
	</tr>
<%
	}
%>
</table>
-->