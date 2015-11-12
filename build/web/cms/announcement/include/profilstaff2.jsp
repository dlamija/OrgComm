
<%
String staff_idquery = "";
String staff_namequery  = "";
String staff_deptquery  = "";
String staff_dept_descquery  = "";

String infostaffname=request.getParameter("staffname");

%>
	
	
	
	
	
<%
	// Get staff data...

	String sql_staffquery 	= 	"SELECT SM_STAFF_ID,SM_STAFF_NAME,SM_DEPT_CODE,UPPER(DM_DEPT_DESC) FROM STAFF_MAIN,DEPARTMENT_MAIN "+
							"WHERE SM_STAFF_ID ='"+ infostaffname +"' "+
							"AND SM_DEPT_CODE=DM_DEPT_CODE ";
	try
		{
		PreparedStatement pstmtquery  = conn.prepareStatement(sql_staffquery );
		ResultSet rsetquery  = pstmtquery .executeQuery ();
		if (rsetquery.next())
			{
			staff_idquery  		= rsetquery.getString (1);
			staff_namequery  		= rsetquery.getString (2);
			staff_deptquery  		= rsetquery.getString (3);
			staff_dept_descquery  = rsetquery.getString (4);
			}
rsetquery.close();		
pstmtquery.close ();
		}
	catch (SQLException e)
		{ out.println ("Error staffquery : " + e.toString ()); }
%>
