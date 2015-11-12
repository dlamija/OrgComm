<%
    String date2="";
	
	String sql_date2	= 	"SELECT TO_CHAR(SYSDATE,'DD-MON-YYYY') FROM DUAL";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_date2);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			date2 = rset.getString (1);
			}
rset.close();		
pstmt.close ();
		}
	catch (SQLException e)
		{ out.println ("Error sysdate: " + e.toString ()); }
%>
