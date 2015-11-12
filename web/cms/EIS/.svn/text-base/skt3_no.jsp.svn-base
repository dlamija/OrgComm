<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%
	String namaskt3 = request.getParameter("namaskt3");
%>

<body>
<%

	String sql_skt3	=    "SELECT COUNT(DISTINCT A.SM_STAFF_ID) "+ 
	                     "from sktnew_main a,staff_main b "+
						 "where a.sm_staff_id=b.sm_staff_id AND a.SM_APPROVER='"+sid+"'  and a.sm_part='3' and a.sm_TYPE='CONFIRM' "+
						 "AND a.SM_STATUS ='APPLY' AND SM_CURRENT_YEAR='"+date+"' ";
						// "group by a.sm_staff_id,b.sm_staff_name,A.SM_STATUS,a.sm_approver ";
				 
				 
				 
	try {
		PreparedStatement pstmt = conn.prepareStatement(sql_skt3);
		ResultSet rset = pstmt.executeQuery ();
		
		if (rset.next()) {
			namaskt3 = rset.getString (1);
		}
		rset.close();
		pstmt.close ();
	}
	catch (SQLException e) {
		out.println ("Error SQL: " + e.toString ()); 
	}
%>


<%  if (namaskt3 != null && namaskt3.equals("0")) {%>
-
<%}else{%>
(<%=namaskt3%><img src="cms/EIS/images/new_baru.gif"  border="0">)
<%}%>

