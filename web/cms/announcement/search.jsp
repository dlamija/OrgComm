<%@ page session="true"%>
<%@	page import="java.sql.*"%>
<%@	page import="javax.sql.*"%>
<%@	page import="javax.naming.*"%>
<%@	page import="common.*" %>

<%
	Messages messages = Messages.getMessages(request);
	Connection conn = null;
	String id = (String)TvoContextManager.getSessionAttribute(request, "Login.CMSID");
	String userType = (String)TvoContextManager.getSessionAttribute(request, "Login.userType");
	String style = "font-family: Verdana, sans-serif; font-size: 11px;  8px";
	
	int searchDay = 0, searchYear = 0;
	String searchMonth = request.getParameter("searchMonth");
	String category = request.getParameter("category");
	String postedBy = request.getParameter("postedBy");
	
	if (request.getParameter("searchDay") != null) {
		searchDay = Integer.parseInt(request.getParameter("searchDay"));
	}
	if (request.getParameter("searchYear") != null) {
		searchYear = Integer.parseInt(request.getParameter("searchYear"));
	}
	
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
</script>

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

<body>
<form method="post">
<%@include file="header.jsp"%>
<table width="100%" border="0" cellpadding="3" cellspacing="1">
	<tr> 
    	<td CLASS="calendarMonthBgColor" height="25" colspan="2" bgcolor="#0000FF"><strong><font color="#FFFFFF">Search Criteria </font></strong></td>
  	</tr>
	<tr> 
		<td class="contentBgColor" width="20%" align="right">Date :</td>
		<td class="contentBgColorAlternate" width="80%">&nbsp;
			<select name="searchDay">
				<option value="0" selected>- Choose -</option>
			<%  for (int i=1;i<32;i++) {  %>
				  <option value="<%= ( i>0 && i<10 ? "0":"") +i %>"<% if (searchDay > -1 && searchDay == i ) { %> selected<% } %>><%= ( i>0 && i<10 ? "0":"")+i %> </option>
			<%	}  %>		
			</select>
			&nbsp;/&nbsp;
			<select name="searchMonth">
				<option value="0" selected>- Choose -</option>	
				<option value="01" <% if (searchMonth!=null && searchMonth.equals("01") ) { %> selected<% } %>><%= messages.getString("short.jan") %></option>
				<option value="02" <% if (searchMonth!=null && searchMonth.equals("02") ) { %> selected<% } %>><%= messages.getString("short.feb") %></option>
				<option value="03" <% if (searchMonth!=null && searchMonth.equals("03") ) { %> selected<% } %>><%= messages.getString("short.mar") %></option>
				<option value="04" <% if (searchMonth!=null && searchMonth.equals("04") ) { %> selected<% } %>><%= messages.getString("short.apr") %></option>
				<option value="05" <% if (searchMonth!=null && searchMonth.equals("05") ) { %> selected<% } %>><%= messages.getString("short.may") %></option>
				<option value="06" <% if (searchMonth!=null && searchMonth.equals("06") ) { %> selected<% } %>><%= messages.getString("short.jun") %></option>
				<option value="07" <% if (searchMonth!=null && searchMonth.equals("07") ) { %> selected<% } %>><%= messages.getString("short.jul") %></option>
				<option value="08" <% if (searchMonth!=null && searchMonth.equals("08") ) { %> selected<% } %>><%= messages.getString("short.aug") %></option>
				<option value="09" <% if (searchMonth!=null && searchMonth.equals("09") ) { %> selected<% } %>><%= messages.getString("short.sep") %></option>
				<option value="10" <% if (searchMonth!=null && searchMonth.equals("10") ) { %> selected<% } %>><%= messages.getString("short.oct") %></option>
				<option value="11" <% if (searchMonth!=null && searchMonth.equals("11") ) { %> selected<% } %>><%= messages.getString("short.nov") %></option>
				<option value="12" <% if (searchMonth!=null && searchMonth.equals("12") ) { %> selected<% } %>><%= messages.getString("short.dec") %></option>
			</select>
			&nbsp;/&nbsp;
        	<select name="searchYear">
				<option value="0" selected>- Choose -</option>	
        <% 		for (int i=Integer.parseInt((String)TvoContextManager.getAttribute(request, "System.startYear"));
             	i <= Integer.parseInt((String)TvoContextManager.getAttribute(request, "System.endYear")); i++) { %>
					<option value="<%= i %>" <% if (searchYear > -1 && searchYear == i ) { %> selected<% } %>><%= i %></option><% } %>
        	</select>
		
		
		</td>
	</tr>
	<tr> 
		<td class="contentBgColor" align="right">Category :</td>
		<td class="contentBgColorAlternate">&nbsp;
    <%
			String sqlq = "SELECT AC.AC_CAT_ID,AC.AC_CAT_DESC FROM CMSADMIN.ANNOUNCEMENT_CATEGORY AC ";			
			try {
				Statement stmt = conn.createStatement();
				ResultSet rset = stmt.executeQuery( sqlq );
				if (rset.isBeforeFirst()) { %>
        			<select name="category" style="<%=style%>">
          				<option value=""><b>-Select Category-</b></option>
          		<%	while (rset.next()) { %>
          				<option value="<%=rset.getString(1)%>" <%=rset.getString(1)!=null&rset.getString(1).equals(category)?"selected":""%>><%=rset.getString(2)%></option>
          		<%	} %>
        			</select>
        <%		}
				rset.close();
				stmt.close();
			}
			catch (SQLException sqle) { } %>		
		</td>
	</tr>
	<tr> 
		<td class="contentBgColor" align="right">Posted By :</td>
		<td class="contentBgColorAlternate">&nbsp;<input name="postedBy" type="text" id="tajuk" size="30" style="<%=style%>" value="<%=postedBy!=null?postedBy:""%>"></td>
	</tr>
	<tr><td class="contentBgColor" colspan="2" align="center">
		<input type="submit" value="Search" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;  font-weight: bold">
	</td></tr>
	<tr><td class="contentBgColor" colspan="2">&nbsp;</td></tr>
	<tr>
		<td class="contentBgColor" colspan="2">					
			<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#999999" >
				<tr>
					<td>
					<table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#999999" >									
						<tr>
							<td class="contentBgColorAlternate" align="center">#</td>		
							<td class="contentBgColorAlternate" width="20%" align="center"><b>Category</b></td>
							<td class="contentBgColorAlternate" width="50%"><b>Title</b></td>
							<td class="contentBgColorAlternate" width="20%" align="center"><b>Posted By</b></td>
							<td class="contentBgColorAlternate" width="10%" align="center"><b>Date</b></td>
						</tr>																			

	<%
				if (conn != null && (postedBy != null && !postedBy.equals("")) || (category != null && !category.equals("")) || (searchDay > 0) || (searchYear > 0)) {
					StringBuilder sbDaily = new StringBuilder("");
					
					sbDaily.append("SELECT AM.AM_REF,AC.AC_CAT_DESC,AM.AM_TITLE,TO_CHAR(AM.AM_APPROVE_DATE,'DD-MON-YYYY'),AM.AM_URL, ");
					sbDaily.append("SM.SM_STAFF_NAME,'STAFF',AM.AM_APPROVE_DATE ");
					sbDaily.append("FROM CMSADMIN.ANNOUNCEMENT_MAIN AM,CMSADMIN.ANNOUNCEMENT_CATEGORY AC,CMSADMIN.STAFF_MAIN SM ");
					sbDaily.append("WHERE AM.AM_CATEGORY = AC.AC_CAT_ID AND AM.AM_POSTED_BY = SM.SM_STAFF_ID ");
					sbDaily.append("AND AM.AM_ACCESS IN ('Public', ? ) AND AM.AM_STATUS = 'APPROVE' ");
					//sbDaily.append("AND SYSDATE <= AM.AM_DATE + AM.AM_TOTAL_DAY AND AM.AM_ACCESS IN ('Public', ? ) AND AM.AM_STATUS = 'APPROVE' ");
					
					if (postedBy != null && !postedBy.equals(""))
						sbDaily.append("AND UPPER(SM.SM_STAFF_NAME) LIKE UPPER('%" + postedBy + "%') "); 
					if (category != null && !category.equals(""))
						sbDaily.append("AND AM.AM_CATEGORY ='" + category + "' ");
					if (searchDay > 0)
						sbDaily.append("AND TO_CHAR(AM.AM_APPROVE_DATE,'DD') = '" + searchDay + "' ");
					if (searchMonth != null && !searchMonth.equals("0"))
						sbDaily.append("AND TO_CHAR(AM.AM_APPROVE_DATE,'MM')= '" + searchMonth + "' ");
					if (searchYear > 0)
						sbDaily.append("AND TO_CHAR(AM.AM_APPROVE_DATE,'YYYY') = '" + searchYear + "' ");

					sbDaily.append("UNION ");
					sbDaily.append("SELECT AM.AM_REF,AC.AC_CAT_DESC,AM.AM_TITLE,TO_CHAR(AM.AM_APPROVE_DATE,'DD-MON-YYYY'),AM.AM_URL, ");
					sbDaily.append("EU.EU_NAME,'EXTERNAL',AM.AM_APPROVE_DATE ");
					sbDaily.append("FROM CMSADMIN.ANNOUNCEMENT_MAIN AM,CMSADMIN.ANNOUNCEMENT_CATEGORY AC,CMSADMIN.EXTERNAL_USER EU ");
					sbDaily.append("WHERE AM.AM_CATEGORY = AC.AC_CAT_ID AND AM.AM_POSTED_BY = EU.EU_USER_ID ");
					sbDaily.append("AND AM.AM_ACCESS IN ('Public', ? ) AND AM.AM_STATUS = 'APPROVE' ");
					//sbDaily.append("AND SYSDATE <= AM.AM_DATE + AM.AM_TOTAL_DAY AND AM.AM_ACCESS IN ('Public', ? ) AND AM.AM_STATUS = 'APPROVE' ");
					
					if (postedBy != null && !postedBy.equals(""))
						sbDaily.append("AND UPPER(EU.EU_NAME) LIKE UPPER('%" + postedBy + "%') "); 
					if (category != null && !category.equals(""))
						sbDaily.append("AND AM.AM_CATEGORY ='" + category + "' ");
					if (searchDay > 0)
						sbDaily.append("AND TO_CHAR(AM.AM_APPROVE_DATE,'DD') = '" + searchDay + "' ");
					if (searchMonth != null && !searchMonth.equals("0"))
						sbDaily.append("AND TO_CHAR(AM.AM_APPROVE_DATE,'MM')= '" + searchMonth + "' ");
					if (searchYear > 0)
						sbDaily.append("AND TO_CHAR(AM.AM_APPROVE_DATE,'YYYY') = '" + searchYear + "' ");
				
					sbDaily.append("UNION ");
					sbDaily.append("SELECT AM.AM_REF,AC.AC_CAT_DESC,AM.AM_TITLE,TO_CHAR(AM.AM_APPROVE_DATE,'DD-MON-YYYY'),AM.AM_URL, ");
					sbDaily.append("SM.SM_STUDENT_NAME,'STUDENT',AM.AM_APPROVE_DATE ");
					sbDaily.append("FROM CMSADMIN.ANNOUNCEMENT_MAIN AM,CMSADMIN.ANNOUNCEMENT_CATEGORY AC,CMSADMIN.STUDENT_MAIN SM ");
					sbDaily.append("WHERE AM.AM_CATEGORY = AC.AC_CAT_ID AND AM.AM_POSTED_BY = SM.SM_STUDENT_ID ");
					sbDaily.append("AND AM.AM_ACCESS IN ('Public', ? ) AND AM.AM_STATUS = 'APPROVE' ");
					//sbDaily.append("AND SYSDATE <= AM.AM_DATE + AM.AM_TOTAL_DAY AND AM.AM_ACCESS IN ('Public', ? ) AND AM.AM_STATUS = 'APPROVE' ");
					
					if (postedBy != null && !postedBy.equals(""))
						sbDaily.append("AND UPPER(SM.SM_STUDENT_NAME) LIKE UPPER('%" + postedBy + "%') "); 
					if (category != null && !category.equals(""))
						sbDaily.append("AND AM.AM_CATEGORY ='" + category + "' ");
					if (searchDay > 0)
						sbDaily.append("AND TO_CHAR(AM.AM_APPROVE_DATE,'DD') = '" + searchDay + "' ");
					if (searchMonth != null && !searchMonth.equals("0"))
						sbDaily.append("AND TO_CHAR(AM.AM_APPROVE_DATE,'MM')= '" + searchMonth + "' ");
					if (searchYear > 0)
						sbDaily.append("AND TO_CHAR(AM.AM_APPROVE_DATE,'YYYY') = '" + searchYear + "' ");
					
					sbDaily.append("ORDER BY AM_APPROVE_DATE DESC");
					
					try {
						PreparedStatement pstmt = conn.prepareStatement(sbDaily.toString());
						pstmt.setString(1, userType);
						pstmt.setString(2, userType);
						pstmt.setString(3, userType);
						
						ResultSet rset = pstmt.executeQuery();
						if (rset.isBeforeFirst()) {
							while (rset.next()) { %>
								<tr valign="top" class="smallfont">
									<td width="3%" class="contentBgColor"><div align="center"><%=rset.getRow()%>.</div></td>
									<td class="contentBgColor">
										<a href="javascript:void(window.open('cms/announcement/entry/view.jsp?ref=<%=rset.getString(1)%>','view', 'height=600,width=800,menubar=no,toolbar=no,scrollbars=yes'))"><%=rset.getString(2)%></a>
									</td>
									<td class="contentBgColor">
										<a href="javascript:void(window.open('cms/announcement/entry/view.jsp?ref=<%=rset.getString(1)%>','view', 'height=600,width=800,menubar=no,toolbar=no,scrollbars=yes'))"><%=rset.getString(3)%></a>
									</td>
									<td class="contentBgColor" nowrap><div align="center"><%=((rset.getString(6)==null)?"-":rset.getString(6))%></div></td>
									<td class="contentBgColor"><div align="center"><%=rset.getString(4)%></div></td>
								</tr>
						<%	} %>
					<%	}
						else { %>
							<tr><td class="contentBgColor" colspan="5">No record found.</td></tr>
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
					</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
				
</TABLE>
</form>
</body>
