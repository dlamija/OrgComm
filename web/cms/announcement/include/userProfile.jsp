<%
	String staff_id = "";
	String staff_name = "";
	String staff_dept = "";
	String staff_dept_desc = "";
	String staff_jawatan = "";
	String staff_descjwtn = "";
	//String sql_staff = null;
	
	StringBuilder sb = new StringBuilder("");
    
	if (userType != null && userType.equals("STAFF")) {
		sb.append("SELECT SM.SM_STAFF_ID,SM.SM_STAFF_NAME,SM.SM_DEPT_CODE,DM.DM_DEPT_DESC,SM.SM_JOB_CODE,SS.SS_SERVICE_DESC ");
		sb.append("FROM CMSADMIN.STAFF_MAIN SM,CMSADMIN.DEPARTMENT_MAIN DM,CMSADMIN.SERVICE_SCHEME SS ");
		sb.append("WHERE SM.SM_STAFF_ID = ? ");
		sb.append("AND SM.SM_DEPT_CODE = DM.DM_DEPT_CODE AND SM.SM_JOB_CODE = SS.SS_SERVICE_CODE ");
	}
	else if (userType.equals("STUDENT")) {
		sb.append("SELECT SM.SM_STUDENT_ID,SM.SM_STUDENT_NAME,SM.SM_FACULTY_CODE,DM.DM_DEPT_DESC,SM.SM_PROGRAM,PM.PM_PROGRAM_DESC ");
		sb.append("FROM CMSADMIN.STUDENT_MAIN SM,CMSADMIN.DEPARTMENT_MAIN DM,CMSADMIN.PROGRAM_MAIN PM ");
		sb.append("WHERE SM.SM_STUDENT_ID = ? ");
		sb.append("AND SM.SM_FACULTY_CODE = DM.DM_DEPT_CODE AND SM.SM_PROGRAM = PM.PM_PROGRAM_CODE ");
	}
	else if (userType.equals("EXTERNAL")) {
		sb.append("SELECT EU.EU_USER_ID,EU.EU_NAME,EU.EU_ORGANIZATION ");
		sb.append("FROM CMSADMIN.EXTERNAL_USER EU WHERE EU.EU_USER_ID = ?");
	}
	
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sb.toString());
		pstmt.setString(1, id);
		ResultSet rset = pstmt.executeQuery();
		if (rset.isBeforeFirst()) {
			if (rset.next()) {
				staff_id = rset.getString(1);
				staff_name = rset.getString(2);
				
				if (userType != null && userType.equals("EXTERNAL"))
					staff_dept_desc = rset.getString(3);
				else {
					staff_dept = rset.getString(3);
					staff_dept_desc = rset.getString(4);
					staff_jawatan = rset.getString(5);
					staff_descjwtn = rset.getString(6);
				}
			}
		}
		rset.close();
		pstmt.close();
	}
	catch (SQLException e) {
		out.println ("Error Staff_main: " + e.toString());
	}
%>

<table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#ADC5EF">
	<tr> 
    	<td CLASS="calendarMonthBgColor" height="25" colspan="2" bgcolor="#0000FF"><strong>
    		<font color="#FFFFFF"><%=userType!=null && !userType.equals("EXTERNAL")?"Staff Information":"External User Information"%> </font></strong></td>
  	</tr>
  	
<%	if (userType != null && userType.equals("EXTERNAL")) { %>
	  	<tr> 
	    	<td class="contentBgColor" width="20%" height="25"> <div align="right">Name :</div></td>
	    	<td class="contentBgColor"width="80%" height="25">&nbsp;<%= staff_name %>&nbsp;</td>
	  	</tr>
	  	<tr> 
	    	<td class="contentBgColor" height="25"> <div align="right">Organization :</div></td>
	    	<td class="contentBgColor" height="25">&nbsp;<%=staff_dept_desc!=null?staff_dept_desc:"-"%></td>
	  	</tr>
<%	}
	else { %>
	  	<tr> 
	    	<td class="contentBgColor" width="20%" height="25"> <div align="right">Staff ID & Name :</div></td>
	    	<td class="contentBgColor"width="80%" height="25">&nbsp;<%= staff_id %>-<%= staff_name %>&nbsp;</td>
	  	</tr>
	  	<tr> 
	    	<td class="contentBgColor" height="25"> <div align="right">Department :</div></td>
	    	<td class="contentBgColor" height="25">&nbsp;<%= staff_dept %>-<%=staff_dept_desc %></td>
	  	</tr>
<%	}
		
 	if (userType != null && userType.equals("STAFF")) { %>
  		<tr> 
    		<td class = "contentBgColor" height="25"> <div align="right">Position :</div></td>
    		<td class = "contentBgColor" height="25">&nbsp;<%= staff_jawatan %>-<%=staff_descjwtn %></td>
  		</tr>
<%	}
	else if (userType != null && userType.equals("STUDENT")) { %>
  		<tr> 
    		<td class = "contentBgColor" height="25"> <div align="right">Program :</div></td>
    		<td class = "contentBgColor" height="25">&nbsp;<%= staff_jawatan %>-<%=staff_descjwtn %></td>
  		</tr>
<%	} %>
</table>
