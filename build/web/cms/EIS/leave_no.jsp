<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%
	String nama3 = request.getParameter("nama3");
%>

<%
    String date_leave="";
	
	String sql_dateleave	= 	"SELECT (TO_CHAR(SYSDATE,'YYYY')) FROM DUAL";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_dateleave);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			date_leave= rset.getString (1);
		}
		rset.close();		
		pstmt.close ();
	}
	catch (Exception e) 
  	{ out.println ("Error sql_dateleave " + e.toString ());}

%>

<body>
<%

	String sql_3	= " SELECT COUNT(1) FROM STAFF_LEAVE_DETL, STAFF_MAIN "+
					  " WHERE SLD_STAFF_ID=SM_STAFF_ID "+
					  " AND SLD_STATUS='APPLY' "+
					  "AND TO_CHAR(SLD_APPLY_DATE,'YYYY')='"+date_leave+"' "+
					  "	AND SLD_APPROVE_BY='"+sid+"' ";
				 
	try {
		PreparedStatement pstmt = conn.prepareStatement(sql_3);
		ResultSet rset = pstmt.executeQuery ();
		
		if (rset.next()) {
			nama3 = rset.getString (1);
		}
		rset.close();
		pstmt.close ();
	}
	catch (SQLException e) {
		out.println ("Error SQL: " + e.toString ()); 
	}
%>
<% if (nama3 != null && nama3.equals("0")) {%>
-
<%}else{%>
(<%=nama3%><img src="cms/EIS/images/new_baru.gif"  border="0">)
<%}%>
