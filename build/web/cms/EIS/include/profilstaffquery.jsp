<%
	String staff_id = "";
	String staff_name = "";
	String staff_dept = "";
	String staff_dept_desc = "";
	String staff_jawatan = "";
	String staff_descjwtn = "";
    
	String sql_staff	= 	"SELECT SM_STAFF_ID,SM_STAFF_NAME,SM_DEPT_CODE,UPPER(DM_DEPT_DESC),SM_JOB_CODE,UPPER(SS_SERVICE_DESC) "+
	                        "FROM STAFF_MAIN,DEPARTMENT_MAIN,SERVICE_SCHEME "+
							"WHERE SM_STAFF_ID ='"+ idstaff +"' "+
							"AND SM_DEPT_CODE=DM_DEPT_CODE AND SM_JOB_CODE=SS_SERVICE_CODE ";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_staff);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			staff_id 		= rset.getString (1);
			staff_name 		= rset.getString (2);
			staff_dept 		= rset.getString (3);
			staff_dept_desc = rset.getString (4);
			staff_jawatan   = rset.getString (5);
			staff_descjwtn  = rset.getString (6);
			}
		pstmt.close ();
		rset.close();
		}
	finally {
  try {
      if (conn != null) 
	  conn.close();    // Close the connection no matter what
  }
  catch (Exception e) 
  { out.println ("Error Staff_main: " + e.toString ());}
 }

%>
