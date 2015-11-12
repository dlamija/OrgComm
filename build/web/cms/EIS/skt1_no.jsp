<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%
	String namaskt1 = request.getParameter("namaskt1");
%>

<body>
<%

	String sql_skt1	=   "SELECT COUNT(DISTINCT A.SM_STAFF_ID) "+
						"FROM SKTNEW_MAIN A,STAFF_MAIN B "+
						"WHERE A.SM_STAFF_ID=B.SM_STAFF_ID AND A.SM_APPROVER='"+sid+"'  AND A.SM_PART='1' AND A.SM_TYPE='CONFIRM' "+
						"AND A.SM_STATUS ='APPLY' AND A.SM_ACTIVITY IS NOT NULL AND SM_CURRENT_YEAR='"+date+"' ";
						//"GROUP BY A.SM_STAFF_ID "; 
				 
				 
	try {
		PreparedStatement pstmt = conn.prepareStatement(sql_skt1);
		ResultSet rset = pstmt.executeQuery ();
		
		if (rset.next()) {
			namaskt1 = rset.getString (1);
		}
		rset.close();
		pstmt.close ();
	}
	catch (SQLException e) {
		out.println ("Error SQL: " + e.toString ()); 
	}
%>

<%  if (namaskt1 != null && namaskt1.equals("0")) {%>
-
<%}else{%>
(<%=namaskt1%><img src="cms/EIS/images/new_baru.gif"  border="0">)
<%}%>
