<%
    String date="";
	
	String sql_date	= "SELECT hp_parm_desc FROM hradmin_parms WHERE hp_parm_code = 'SKT_YEAR'";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_date);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next()) {
			date = rset.getString (1);
		}
		rset.close();		
		pstmt.close ();
	}	
  	catch (Exception e) {
  		out.println ("Error sql_date " + e.toString ());
 	}

%>
