<%@ page session="true"%>
<%@	page import="java.sql.*"%>
<%@	page import="javax.sql.*"%>
<%@	page import="javax.naming.*"%>
<%@	page import="common.*" %>

<%
	Connection conn = null;
	float total;
	boolean data = false;

	String action = "";
	//String id = (String) session.getAttribute("staffid");
	String id = (String)TvoContextManager.getSessionAttribute(request, "Login.CMSID");
	String userType = (String)TvoContextManager.getSessionAttribute(request, "Login.userType");
	String id_sub = request.getParameter("ls_sub");

	try {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/cmsdb");
		conn = ds.getConnection();
	} 
	catch (Exception e) {
		out.println(e.toString());
	}
%>

<script>
	function ValidateFields() {	      
		if (document.form1.tarikh.value=='') {		   
		  	alert("Please Select Date First");
			return false;
	  	}		  
 	}

	function gotopage (selSelectObject) {
		if (selSelectObject.options[selSelectObject.selectedIndex].value != "") {
	   		location.href=selSelectObject.options[selSelectObject.selectedIndex].value
	  	}
	}
</script>
<script language="JavaScript" src="cms/ProgressReport/calendar.js"></script>

<style type="text/css">
<!--
.style1 {
	font-family: Arial;
	font-size: 10px;
	color: #FFFFFF;
}

.style2 {
	font-family: Arial;
	font-size: 10px;
	font-weight: bold;
}
-->
</style>


<%@include file="header.jsp"%>
<%@include file="include/userProfile.jsp"%>

<body>
<form action="announcement.jsp" method="GET">
<input type="hidden" name="action" value="delete"> <br />

<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0" bgcolor="#ADC5EF">
	<tr valign="bottom">
		<td CLASS="calendarMonthBgColor" height="30" colspan="9">
			<img	src="images/hyperlink/announcement.png"><font color="#FFFFFF"><b>List Of  Announcement</b></font></td>
	</tr>
	<tr>
		<td class="contentBgColor" height="20" colspan="9">Today's Date : <%=CommonFunction.getDate("dd-MMM-yyyy")%></td>
	</tr>
	<%
	if (conn != null) {
		String sql_daily = null;
		StringBuilder sbDaily = new StringBuilder("");
		
		if (userType != null && (userType.equals("STAFF") || userType.equals("EXTERNAL"))) {
			sbDaily.append("SELECT AM.AM_REF,AC.AC_CAT_DESC,AM.AM_TITLE,AM.AM_MESSAGE,TO_CHAR(AM.AM_APPROVE_DATE,'DD-MON-YY'),AM.AM_URL,AM.AM_STATUS ");
			sbDaily.append("FROM CMSADMIN.ANNOUNCEMENT_MAIN AM,CMSADMIN.ANNOUNCEMENT_CATEGORY AC ");
			sbDaily.append("WHERE AM.AM_POSTED_BY = ? AND AC.AC_CAT_ID = AM.AM_CATEGORY ");
			//sbDaily.append("AND SYSDATE <= AM.AM_APPROVE_DATE + AM.AM_TOTAL_DAY ");
			sbDaily.append("ORDER BY AM_APPROVE_DATE DESC ");
		}
		else if (session.getAttribute("userType").equals("STUDENT")) {
			sbDaily.append("SELECT AM.AM_REF,AC.AC_CAT_DESC,AM.AM_TITLE,AM.AM_MESSAGE,TO_CHAR(AM.AM_DATE,'DD-MON-YY'),AM.AM_URL,AM.AM_STATUS ");
			sbDaily.append("FROM CMSADMIN.ANNOUNCEMENT_MAIN AM,CMSADMIN.ANNOUNCEMENT_CATEGORY AC ");
			sbDaily.append("WHERE AM.AM_POSTED_BY = ? AND AC.AC_CAT_ID = AM.AM_CATEGORY ");
			sbDaily.append("AND SYSDATE <= AM.AM_APPROVE_DATE + AM.AM_TOTAL_DAY ");
			sbDaily.append("ORDER BY AM_APPROVE_DATE DESC ");
		}

		try {
			PreparedStatement pstmt = conn.prepareStatement(sbDaily.toString());
			pstmt.setString(1, id);
			ResultSet rset = pstmt.executeQuery();
			if (rset.isBeforeFirst()) { %>
				<tr valign="middle" class="smallbold">
					<td width="10%" height="20" CLASS="contentBgColorAlternate">&nbsp;</td>
					<td width="20%" height="20" CLASS="contentBgColorAlternate"><div align="center"><b>Category</b></div></td>
					<td width="32%" height="20" CLASS="contentBgColorAlternate"><div align="center"><b>Title</b></div></td>
					<td width="10%" height="20" CLASS="contentBgColorAlternate"><div align="center"><strong>Url</strong></div></td>
					<td width="12%" height="20" CLASS="contentBgColorAlternate"><div align="center"><b>Date</b></div></td>
					<td width="7%" height="20" CLASS="contentBgColorAlternate"><div align="center"><b>Edit</b></div></td>
					<td width="9%" height="20" CLASS="contentBgColorAlternate"><div align="center"><b>Delete</b></div></td>
				</tr>
<%
				while (rset.next()) { %>
					<tr valign="top" class="smallfont">
						<td width="3%" class="contentBgColor"><div align="center"><%=rset.getRow()%>.</div></td>
						<td class="contentBgColor">
							<a href="javascript:void(window.open('cms/announcement/entry/view.jsp?ref=<%=rset.getString(1)%>','view', 'height=600,width=800,menubar=no,toolbar=no,scrollbars=yes'))"><%=rset.getString(2)%></a>
						</td>
						<td class="contentBgColor">
							<a href="javascript:void(window.open('cms/announcement/entry/view.jsp?ref=<%=rset.getString(1)%>','view', 'height=600,width=800,menubar=no,toolbar=no,scrollbars=yes'))"><%=rset.getString(3)%></a>
						</td>
						<td class="contentBgColor"><div align="center"><%=((rset.getString(6)==null)?"-":rset.getString(6))%></div></td>
						<td class="contentBgColor"><div align="center"><%=rset.getString(5)%></div></td>
						<td class="contentBgColor"><div align="center">
				<%			if (rset.getString(7).equals("APPLY") || userType.equals("STAFF")) { %>
								<a href="announcement.jsp?action=edit&ref=<%=rset.getString(1)%>">
									<IMG SRC="cms/announcement/images/edit.gif" BORDER="0" ALT="Edit"></a>
					<%		} %>
						</div></td>
						<td class="contentBgColor"><div align="center">
							<input type="checkbox" name="code" value="<%=rset.getString(1)%>"></div>
						</td>
					</tr>
			<%	} %>
			<tr>
				  <td class="contentBgColor" colspan="7"><div align="right">
					<input type="submit" name="hantar2" value="Delete" 
						style="font-family: Verdana, sans-serif; font-size: 11px; 8 px; font-weight: bold">
				</div></td>	
		<%	}
			else { %>
				
    </tr>
				<tr><td class="contentBgColor" colspan="7">No activities available</td></tr>
		<%	}	

			rset.close();
			pstmt.close();
		}
		catch (Exception e) {
			out.println(e.toString());
		}
		finally {
			if (conn != null) conn.close();				
		}
	} %>
</TABLE>


</form>
</body>
