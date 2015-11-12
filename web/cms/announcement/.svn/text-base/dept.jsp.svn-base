
<%
	PreparedStatement pstmt = null;
	ResultSet rset = null;
	String department = request.getParameter("department");
	String id = request.getParameter("id");

if (conn!=null)
	{
	String sql = null;
	
	if (rsetchk2.getString(9).equals("STAFF"))
	sql	=		  " SELECT DM_DEPT_DESC "+
	              " FROM STAFF_MAIN,DEPARTMENT_MAIN "+
				  " WHERE SM_STAFF_ID = '" + rsetchk2.getString(10) + "' AND SM_DEPT_CODE=DM_DEPT_CODE ";
	else if (rsetchk2.getString(9).equals("STUDENT"))
	sql	=		  " SELECT DM_DEPT_DESC "+
	              " FROM STUDENT_MAIN,DEPARTMENT_MAIN "+
				  " WHERE SM_STUDENT_ID = '" + rsetchk2.getString(10) +"' AND SM_FACULTY_CODE = DM_DEPT_CODE ";
	
	try
		{
		pstmt = conn.prepareStatement(sql);
		rset = pstmt.executeQuery ();
		if (rset.next())
			{
			department = rset.getString (1);
			}
		//pstmt.close ();
		}
	catch (SQLException e)
		{ out.println ("Error : " + e.toString ()); }
		finally {
		try {
			if (rset != null) rset.close();
			if (pstmt != null) pstmt.close();
			//if (conn != null) conn.close();
		}
		catch (Exception e) { }
	}
}
%>
<%=department%>
