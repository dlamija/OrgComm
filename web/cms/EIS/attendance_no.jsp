<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%
	String nama1 = request.getParameter("nama1");
%>


<!--%
    String date2="";
	
	String sql_date2	= 	"SELECT (TO_CHAR(SYSDATE,'YYYY')) FROM DUAL";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_date2);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			date2= rset.getString (1);
		}
		rset.close();		
		pstmt.close ();
	}
  	catch (Exception e) 
  	{ out.println ("Error sql_date2 " + e.toString ());}

% -->



<body>
<%

	String sql_1	= "SELECT count(SA.SAH_STAFF_ID) "+
					   "FROM CMSADMIN.STAFF_ATTENDANCE_HEAD SA,CMSADMIN.STAFF_MAIN SM "+
                       "WHERE SA.SAH_STAFF_ID = SM.SM_STAFF_ID AND SA.SAH_reason_STATUS='APPLY' "+
					  // "and SA.SAH_time_from_bdated is null and SA.SAH_time_to_bdated is null "+
					   "AND TO_CHAR(SA.SAH_DATE,'yyyy') = ?  AND SA.SAH_STAFF_ID IN " +
					   "(SELECT SH.SH_STAFF_ID FROM CMSADMIN.STAFF_HIERARCHY SH WHERE SH.SH_SYS_ID = 'ADM_AL' " +
				 		"AND SH.SH_REPORT_TO = ?) ";
	
	/*"SELECT count(SA.SAH_STAFF_ID) "+
					   "FROM CMSADMIN.STAFF_ATTENDANCE_HEAD SA,CMSADMIN.STAFF_MAIN SM "+
                       "WHERE SA.SAH_STAFF_ID = SM.SM_STAFF_ID AND SA.SAH_reason_STATUS='APPLY' "+
					   "AND TO_CHAR(SA.SAH_DATE,'yyyy')='"+date2+"'  AND SA.SAH_STAFF_ID IN " +
					   "(SELECT SH.SH_STAFF_ID FROM CMSADMIN.STAFF_HIERARCHY SH WHERE SH.SH_SYS_ID = 'ADM_AL' " +
				 		"AND SH.SH_REPORT_TO = '"+sid+"') ";*/
			
	/* hasniy	
	"SELECT count(SAH_REF_ID) "+
						"FROM STAFF_ATTENDANCE_HEAD,STAFF_MAIN "+
						"WHERE SAH_STAFF_ID = SM_STAFF_ID AND SAH_STATUS='APPLY' "+
						"AND SAH_STAFF_ID IN "+
						"(SELECT SH_STAFF_ID FROM STAFF_HIERARCHY WHERE SH_SYS_ID = 'ADM_AL' "+
						"AND SH_REPORT_TO = '"+sid+"') "; */
	try {
		PreparedStatement pstmt = conn.prepareStatement(sql_1);
		pstmt.setString(1, current_year);
		pstmt.setString(2, sid);
		ResultSet rset = pstmt.executeQuery ();
		
		if (rset.next()) {
			nama1 = rset.getString (1);
		}
		rset.close();
		pstmt.close ();
	}
	catch (SQLException e) {
		out.println ("Error SQL attendance reason: " + e.toString ()); 
	}
%>
<% if (nama1 != null  && nama1.equals("0")) {%>
-
<%}else{%>
(<%=nama1%><img src="cms/EIS/images/new_baru.gif"  border="0">)
<%}%>
