<%

	String staff_dept_desc = "";

    
	String sql_staff	= 	"SELECT dm_dept_desc "+
	                        "FROM DEPARTMENT_MAIN "+
							"WHERE dM_dept_code ='"+ dept+"' ";
							
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_staff);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
		
			
			staff_dept_desc = rset.getString (1);

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
