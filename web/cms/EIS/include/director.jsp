<%
	
    String director_id ="";
	String sql_hod	= 	"SELECT SH_REPORT_TO,SH_STAFF_ID,SM_STAFF_ID,SM_STAFF_NAME "+
						"FROM STAFF_HIERARCHY,STAFF_MAIN "+
                        "WHERE SH_REPORT_TO='" +id+ "' and SH_STAFF_ID=SM_STAFF_ID "+
						"AND SH_SYS_ID='ADM_AL' ";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_hod);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			director_id 	= rset.getString (1);
			}
		rset.close();
		pstmt.close ();
		}
	catch (SQLException e)
		{ out.println ("Error HOD data: " + e.toString ()); }
%>
