<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%
	String nama4 = request.getParameter("nama4");
%>

<%
    String date_workorder="";
	
	String sql_date_workorder	= 	"SELECT (TO_CHAR(SYSDATE,'YYYY')) FROM DUAL";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_date_workorder);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			date_workorder= rset.getString (1);
		}
		rset.close();		
		pstmt.close ();
	}
  	catch (Exception e) 
  	{ out.println ("Error sql_dateleave " + e.toString ());}
%>


<body>
<%

	String sql_4	= "SELECT COUNT(distinct WOH_WORKORDER_ID) FROM WORK_ORDER_HEAD,WORK_ORDER_DETL, STAFF_MAIN "+
                       "WHERE SM_STAFF_ID=WOD_STAFF_ID  "+
                       "AND  WOD_WORKORDER_ID=WOH_WORKORDER_ID "+
                       "AND TO_CHAR(WOH_ENTER_DATE,'YYYY')='"+date_workorder+"' "+
                       "AND WOH_STATUS  = 'ENTRY' "+
                       "AND WOH_APPROVE_BY = '"+sid+"' ";
					   
					   %><%//=sql_4%><%
				 
	try {
		PreparedStatement pstmt = conn.prepareStatement(sql_4);
		ResultSet rset = pstmt.executeQuery ();
		
		if (rset.next()) {
			nama4 = rset.getString (1);
		}
		rset.close();
		pstmt.close ();
	}
	catch (SQLException e) {
		out.println ("Error SQL: " + e.toString ()); 
	}
%>
<% if (nama4 != null && nama4.equals("0")) {%>
-
<%}else{%>
(<%=nama4%><img src="cms/EIS/images/new_baru.gif"  border="0">)
<%}%>
