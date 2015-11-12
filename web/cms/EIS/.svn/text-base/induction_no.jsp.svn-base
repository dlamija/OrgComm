<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%
	String nama5 = request.getParameter("nama5");
%>

<%
    String date_induction="";
	
	String sql_dateinduction	= 	"SELECT (TO_CHAR(SYSDATE,'YYYY')) FROM DUAL";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_dateinduction);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			date_induction= rset.getString (1);
		}
		rset.close();		
		pstmt.close ();
	}
  	catch (Exception e) 
  	{ out.println ("Error sql_date " + e.toString ());}
%>

<body>
<%

	String sql_5	= "SELECT COUNT(1) FROM STAFF_INDUKSI_HEAD,STAFF_MAIN,INDUKSI_TRAINING_HEAD " +
						"WHERE SIH_STAFF_ID = SM_STAFF_ID "+
						"AND SIH_INDUKSI_REF_ID = ITH_REF_ID "+
                        "AND to_char(SIH_APPLY_DATE,'YYYY')='"+date_induction+"' "+
						"AND SIH_STAFF_ID IN " +
						"(SELECT SH_STAFF_ID FROM STAFF_HIERARCHY WHERE SH_SYS_ID = 'ADM_AL' " +
						"AND SH_REPORT_TO = '"+sid+"') " +
						"AND SIH_STATUS= 'APPLY' ";
				 
	try {
		PreparedStatement pstmt = conn.prepareStatement(sql_5);
		ResultSet rset = pstmt.executeQuery ();
		
		if (rset.next()) {
			nama5 = rset.getString (1);
		}
		rset.close();
		pstmt.close ();
	}
	catch (SQLException e) {
		out.println ("Error SQL: " + e.toString ()); 
	}
%>
<% if (nama5 != null && nama5.equals("0")) {%>
-
<%}else{%>
(<%=nama5%><img src="cms/EIS/images/new_baru.gif"  border="0">)
<%}%>
