<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%
	String OTCount = request.getParameter("OTCount");
%>

<body>
<%

	String sql_OTCount	= 	" SELECT COUNT(1) FROM STAFF_LEAVE_OVERTIME, STAFF_MAIN "+
					  		" WHERE SLO_STAFF_ID=SM_STAFF_ID "+
					 		 "AND SLO_STATUS='APPLY' "+
					 		// "AND TO_CHAR(SLD_APPLY_DATE,'YYYY')='"+date_leave+"' "+
					 		 "AND SLO_APPROVE_BY = ? ";
				 
	try {
		PreparedStatement pstmt = conn.prepareStatement(sql_OTCount);
		pstmt.setString (1, sid);
		ResultSet rset = pstmt.executeQuery ();
		
		if (rset.next()) {
			OTCount = rset.getString (1);
		}
		rset.close();
		pstmt.close ();
	}
	catch (SQLException e) {
		out.println ("Error SQL OT Leave: " + e.toString ()); 
	}
%>
<% if (OTCount != null && OTCount.equals("0")) {%>
-
<%}else{%>
(<%=OTCount%><img src="cms/EIS/images/new_baru.gif"  border="0">)
<%}%>
