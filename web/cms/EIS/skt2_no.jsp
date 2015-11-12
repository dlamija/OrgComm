<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%
	String namaskt2 = request.getParameter("namaskt2");
%>

<body>
<%

	String sql_skt2	=    "SELECT COUNT(DISTINCT A.SM_STAFF_ID) "+ 
	                     "from sktnew_main a,staff_main b "+
						 "where a.sm_staff_id=b.sm_staff_id AND a.SM_APPROVER='"+sid+"'  and a.sm_part='2' and a.sm_activity is not null "+  
						 "AND a.SM_STATUS='APPLY'  AND SM_CURRENT_YEAR='"+date+"' ";
				 
				 
				 
	try {
		PreparedStatement pstmt = conn.prepareStatement(sql_skt2);
		ResultSet rset = pstmt.executeQuery ();
		
		if (rset.next()) {
			namaskt2 = rset.getString (1);
		}
		rset.close();
		pstmt.close ();
	}
	catch (SQLException e) {
		out.println ("Error SQL: " + e.toString ()); 
	}
%>
<%  if (namaskt2 != null && namaskt2.equals("0")) {%>
-
<%}else{%>
(<%=namaskt2%><img src="cms/EIS/images/new_baru.gif"  border="0">)
<%}%>