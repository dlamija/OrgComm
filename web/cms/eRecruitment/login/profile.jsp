<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%
	String nama = request.getParameter("nama");
	PreparedStatement pstmt = null;
	ResultSet rset = null;
%>

<body>
<%

	String sql	= "SELECT ER_NAMA FROM ERECRUITMENT_REGISTRATION "+
	              "WHERE ER_IC_NO = '" + kadpengenalan +"' ";
				 
	try {
		pstmt = conn.prepareStatement(sql);
		rset = pstmt.executeQuery ();
		
		if (rset.next()) {
			nama = rset.getString (1);
		}
		rset.close();
		pstmt.close ();
	}
	catch (SQLException e) {
		out.println ("Error SQL: " + e.toString ()); 
	}
	finally {
		try {
 			if (rset != null) rset.close();
	  		if (pstmt != null) pstmt.close();
	 		//if (conn != null) conn.close();		
			}
		catch (Exception e) {  }
	}
%>

