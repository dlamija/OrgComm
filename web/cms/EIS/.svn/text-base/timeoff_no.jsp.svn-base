<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%
	String nama = request.getParameter("nama");
%>

<%
    String date_timeoff="";
	
	String sql_datetimeoff	= 	"SELECT (TO_CHAR(SYSDATE,'YYYY')) FROM DUAL";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_datetimeoff);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			date_timeoff= rset.getString (1);
		}
		rset.close();		
		pstmt.close ();
	}
	catch (Exception e) 
  	{ out.println ("Error sql_date " + e.toString ());}

%>

<body>
<%

	String sql	= "SELECT COUNT(1) FROM STAFF_ATTENDANCE_HEAD,STAFF_MAIN "+
	              "WHERE SM_STAFF_ID = SAH_STAFF_ID AND "+
                  "SAH_TYPE = 'TIMEOFF' AND SAH_STATUS = 'APPLY' "+
                  "AND SAH_APPROVE_BY='"+ sid +"' "+
				  "AND to_char(SAH_DATE,'yyyy')='"+date_timeoff+"' "+
				  "ORDER BY SAH_STAFF_ID,SAH_DATE ";
				 
				 
	try {
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rset = pstmt.executeQuery ();
		
		if (rset.next()) {
			nama = rset.getString (1);
		}
		rset.close();
		pstmt.close ();
	}
	catch (SQLException e) {
		out.println ("Error SQL: " + e.toString ()); 
	}
%>
<% if (nama != null && nama.equals("0")) {%>
-
<%}else{%>
(<%=nama%><img src="cms/EIS/images/new_baru.gif"  border="0">)
<%}%>
