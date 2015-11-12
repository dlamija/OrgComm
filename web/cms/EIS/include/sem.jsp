<%
    String semcode="";
	 String semdesc="";
	 
	String sql_sem	= 	"SELECT sm_semester_code,sm_semester_desc FROM semester_main "+
	                    "where sm_semester_code like '"+sem+"%' ";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_sem);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			semcode = rset.getString (1);
			semdesc = rset.getString (2);
			}
rset.close();		
pstmt.close ();
		}
	catch (Exception e) {
		e.printStackTrace();  
 	}

%>
