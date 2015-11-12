<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%
	String nama62 = request.getParameter("nama62");
%>

<%
//for verify (KETUA BAHAGIAN)
    String date_overtime2="";
	
	//String sql_overtime2	= 	"SELECT (TO_CHAR(SYSDATE,'YYYY')) FROM DUAL";
	
	
	 //  String sql_overtime1	=   "SELECT HP_PARM_DESC FROM HRADMIN_PARMS "+
	    //                        "where HP_PARM_CODE ='OT_CLAIM_DUE_DATE ' ";
//...........


	   String sql_overtime2	=   "SELECT HP_PARM_DESC FROM HRADMIN_PARMS "+
	                            "where HP_PARM_CODE ='OT_CLAIM_DUE_DATE' ";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_overtime2);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			date_overtime2= rset.getString (1);
		}
		rset.close();		
		pstmt.close ();
	}
  	catch (Exception e) 
  	{ out.println ("Error sql_dateleave " + e.toString ());}
%>
<body>
<%
	String sql_62	= 	"SELECT COUNT (SOH.SOH_STAFF_ID) " +
						"FROM CMSADMIN.STAFF_OVERTIME_HEAD SOH, CMSADMIN.STAFF_MAIN SM " +
						"WHERE SM.SM_STAFF_ID = SOH.SOH_STAFF_ID " +
						"AND SOH.SOH_VERIFY_BY = ? " +
						"AND TO_CHAR(SOH.SOH_CLAIM_MONTH,'MM/YYYY') = ? " +
						"AND SOH.SOH_STATUS = 'APPLY' " +
						"ORDER BY SOH.SOH_STAFF_ID";

/*	String sql_62	=  "SELECT COUNT( SOH_STAFF_ID) "+
                       "FROM CMSADMIN.STAFF_OVERTIME_HEAD, CMSADMIN.STAFF_MAIN "+
                       "WHERE STAFF_MAIN.SM_STAFF_ID = STAFF_OVERTIME_HEAD.SOH_STAFF_ID "+
                       "AND STAFF_OVERTIME_HEAD.SOH_VERIFY_BY = '"+sid+"' "+
                       "AND (TO_CHAR(SOH_APPLY_DATE,'DD/MM/YYYY')<'"+date_overtime2+"' OR "+
                       "TO_CHAR(SOH_APPLY_DATE,'DD/MM/YYYY')='"+date_overtime2+"') "+
                      // "AND TO_CHAR(SOH_CLAIM_MONTH,'MM/YYYY') = '08/2008' "+
                       "AND TO_CHAR(STAFF_OVERTIME_HEAD.SOH_CLAIM_MONTH,'MM/YYYY') = (SELECT HRADMIN_PARMS.HP_PARM_DESC "+
                       "FROM CMSADMIN.HRADMIN_PARMS "+
                       "WHERE HRADMIN_PARMS.HP_PARM_CODE = 'OT_CLAIM_MONTH') "+
                       "AND STAFF_OVERTIME_HEAD.SOH_STATUS = 'APPLY' ";
                       //"AND SYSDATE <= '"+date_overtime2+"' "+
*/	
	
	%><%//=sql_62%><%
	// " select count(1) from staff_overtime_head, staff_main "+
					//	" where sm_staff_id=soh_staff_id "+
					//	" and soh_status='APPLY' "+
					//	" and  SOH_RECOMMEND_BY='"+sid+"' ";
						
					
			/*			
						 "SELECT COUNT( SOH_STAFF_ID) "+
                         "FROM CMSADMIN.STAFF_OVERTIME_HEAD, CMSADMIN.STAFF_MAIN "+
                         "WHERE STAFF_MAIN.SM_STAFF_ID = STAFF_OVERTIME_HEAD.SOH_STAFF_ID "+
                         "AND STAFF_OVERTIME_HEAD.SOH_VERIFY_BY = '"+sid+"' "+
                      //   "AND TO_CHAR(SOH_APPLY_DATE,'YYYY')='"+date_overtime2+"' "+
                         "AND TO_CHAR(STAFF_OVERTIME_HEAD.SOH_CLAIM_MONTH,'MM/YYYY') = (SELECT HRADMIN_PARMS.HP_PARM_DESC "+
                         "FROM CMSADMIN.HRADMIN_PARMS "+
                         "WHERE HRADMIN_PARMS.HP_PARM_CODE = 'OT_CLAIM_MONTH') "+
                         "AND STAFF_OVERTIME_HEAD.SOH_STATUS = 'APPLY' "+
						 "AND SYSDATE <= '"+date_overtime2+"' "+
                         "ORDER BY STAFF_OVERTIME_HEAD.SOH_STAFF_ID ";*/
						 
						 
						
								 
	try {
		PreparedStatement pstmt = conn.prepareStatement(sql_62);
		pstmt.setString(1, sid);
		pstmt.setString(2, claim_month);
		ResultSet rset = pstmt.executeQuery ();
		
		if (rset.next()) {
			nama62 = rset.getString (1);
		}
		rset.close();
		pstmt.close ();
	}
	catch (SQLException e) {
		out.println ("Error SQL: " + e.toString ()); 
	}
%>


<% if (nama62 != null && nama62.equals("0")) {%>
-
<%}else{%>
(<%=nama62%><img src="cms/EIS/images/new_baru.gif"  border="0">)
<%}%>
