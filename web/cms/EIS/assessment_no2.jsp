<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%
	String ass1 = request.getParameter("ass1");
%>

<%
    String date_assessment1="";
	
	//String sql_dateassessment	= 	"SELECT (TO_CHAR(SYSDATE,'YYYY')) FROM DUAL";
	String sql_dateassessment1	= 	"SELECT HP_PARM_DESC   FROM HRADMIN_PARMS "+
	                                "where HP_PARM_CODE ='ASSESSMENT_YEAR' ";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_dateassessment1);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
		{
			date_assessment1= rset.getString (1);
		}
		rset.close();		
		pstmt.close ();
	}
  	catch (Exception e) 
  	{ out.println ("Error sql_date " + e.toString ());}
%>
<body>
<%

	String sql_ass1	= 	"SELECT COUNT(distinct SAH_STAFF_ID) "+
						"FROM STAFF_MAIN, staff_assessment_head, DEPARTMENT_MAIN  "+
						"WHERE SAH_STAFF_ID	= SM_STAFF_ID "+
						"AND EXISTS ( SELECT 1 FROM STAFF_HIERARCHY WHERE SH_STAFF_ID = SAH_STAFF_ID AND SH_REPORT_TO='"+sid+"' AND SH_SYS_ID='ADM_AL' ) "+
						"AND SAH_STATUS ='APPLY'   "+
						"AND SAH_YEAR='"+date_assessment1+"' "+
						"ORDER BY SAH_STAFF_ID ";
				 
	try {
		PreparedStatement pstmt = conn.prepareStatement(sql_ass1);
		ResultSet rset = pstmt.executeQuery ();
		
		if (rset.next()) {
			ass1 = rset.getString (1);
		}
		rset.close();
		pstmt.close ();
	}
	catch (SQLException e) {
		out.println ("Error SQL: " + e.toString ()); 
	}
%>
<% if (ass1 != null && ass1.equals("0")) {%>
-
<%}else{%>
(<b ><%=ass1%></b><img src="cms/EIS/images/new_baru.gif"  border="0">)
<%}%>
