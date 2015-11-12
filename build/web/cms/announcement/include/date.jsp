<%
    String date="";
	
	String sql_date	= 	"SELECT TO_CHAR(SYSDATE,'DD-MON-YYYY') FROM DUAL";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_date);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			date = rset.getString (1);
			}
rset.close();		
pstmt.close ();
		}
	catch (SQLException e)
		{ out.println ("Error sysdate: " + e.toString ()); }
%>
