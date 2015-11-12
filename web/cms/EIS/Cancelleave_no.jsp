<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%
	String cancelLeaveCnt = request.getParameter("cancelLeaveCnt");
%>

<body>
<%

	String sql_CancelOT		=	  "SELECT COUNT(1) FROM STAFF_LEAVE_DETL, STAFF_MAIN "+
					 		 	  "WHERE SLD_STAFF_ID=SM_STAFF_ID "+
					  			  "AND SLD_STATUS='CANCEL_APPLY' "+
								  "AND TO_CHAR(SLD_APPLY_DATE,'YYYY') = ? "+
								  "	AND SLD_APPROVE_BY = ? ";
				 
	try {
		PreparedStatement pstmt = conn.prepareStatement(sql_CancelOT);
		pstmt.setString (1, date_leave);
		pstmt.setString (2, sid);
		ResultSet rset = pstmt.executeQuery ();
		
		if (rset.next()) {
			cancelLeaveCnt = rset.getString (1);
		}
		rset.close();
		pstmt.close ();
	}
	catch (SQLException e) {
		out.println ("Error SQL: " + e.toString ()); 
	}
%>
<% if (cancelLeaveCnt != null && cancelLeaveCnt.equals("0")) {%>
-
<%}else{%>
(<%=cancelLeaveCnt%><img src="cms/EIS/images/new_baru.gif"  border="0">)
<%}%>
