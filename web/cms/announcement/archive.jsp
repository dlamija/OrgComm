<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ include file="/includes/import.jsp" %>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<%
	Connection conn = null;
	ResultSet rs_all = null;
	String category = request.getParameter("category");
	
 try
	{
		Context initCtx = new InitialContext();
		Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
		DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
		conn = ds.getConnection();
		}
	catch( Exception e )
	{ 
		out.println (e.toString()); 
	}
%>
<%
    String tarikh="";
	String tarikh3="";
	
	String sql_date	= 	"SELECT TO_CHAR(SYSDATE,'MON-YYYY'),TO_CHAR(SYSDATE,'DD MON YYYY') FROM DUAL";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_date);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			tarikh = rset.getString (1);
			tarikh3 = rset.getString(2);
			}
rset.close();		
pstmt.close ();
		}
	catch (SQLException e)
		{ out.println ("Error sysdate: " + e.toString ()); }
%>
<body>
  <%@include file="header.jsp"%>
  
<table width="100%" border="0" cellpadding="0" cellspacing="1">
  <tr>
    <td class='contentStrapColor'>List Of Archive Announcement</td>
  </tr>
</table>
<%
PreparedStatement pstmtchk2 = null;
ResultSet rsetchk2 = null;

if (conn!=null)
	{
   String sqlchk2	=  		"SELECT AM.AM_REF,AM.AM_CATEGORY,AM.AM_TITLE,TO_CHAR(AM.AM_APPROVE_DATE,'DD MON YYYY'), "+
   							"SM.SM_STAFF_NAME,DM.DM_DEPT_DESC,AM.AM_ACCESS,AC.AC_CAT_DESC,AM.AM_APPROVE_DATE "+
        	               "FROM CMSADMIN.ANNOUNCEMENT_MAIN AM,CMSADMIN.STAFF_MAIN SM,CMSADMIN.DEPARTMENT_MAIN DM,CMSADMIN.ANNOUNCEMENT_CATEGORY AC "+
						   "WHERE AM.AM_POSTED_BY = SM.SM_STAFF_ID AND SM.SM_DEPT_CODE = DM.DM_DEPT_CODE AND AM.AM_CATEGORY = AC.AC_CAT_ID  "+
						   //"AND AM_ACCESS = '"+ACCESS+"' "+
						   "AND AM.AM_STATUS='APPROVE' "+
						   "AND SYSDATE - 14 < AM_APPROVE_DATE "+
						    "UNION "+
							"SELECT AM.AM_REF,AM.AM_CATEGORY,AM.AM_TITLE,TO_CHAR(AM.AM_APPROVE_DATE,'DD MON YYYY'), "+
							"SM.SM_STUDENT_NAME,DM.DM_DEPT_DESC,AM.AM_ACCESS,AC.AC_CAT_DESC,AM.AM_APPROVE_DATE "+
        	               "FROM CMSADMIN.ANNOUNCEMENT_MAIN AM,CMSADMIN.STUDENT_MAIN SM,CMSADMIN.DEPARTMENT_MAIN DM,CMSADMIN.ANNOUNCEMENT_CATEGORY AC "+
						   "WHERE AM.AM_POSTED_BY = SM.SM_STUDENT_ID AND SM.SM_FACULTY_CODE = DM.DM_DEPT_CODE AND AM.AM_CATEGORY = AC.AC_CAT_ID "+
						   //"AND AM_ACCESS = '"+ACCESS+"' "+
						   "AND AM.AM_STATUS='APPROVE' "+
						   "AND SYSDATE - 14 < AM_APPROVE_DATE "+
						   "ORDER BY AM_APPROVE_DATE DESC";

   
   /*"SELECT AM.AM_REF,AM.AM_CATEGORY,AM.AM_TITLE,TO_CHAR(AM.AM_APPROVE_DATE,'DD MON YYYY'), "+
   							"SM.SM_STAFF_NAME,DM.DM_DEPT_DESC,AM.AM_ACCESS,AC.AC_CAT_DESC,AM.AM_APPROVE_DATE "+
        	               "FROM CMSADMIN.ANNOUNCEMENT_MAIN AM,CMSADMIN.STAFF_MAIN SM,CMSADMIN.DEPARTMENT_MAIN DM,CMSADMIN.ANNOUNCEMENT_CATEGORY AC "+
						   "WHERE AM.AM_POSTED_BY = SM.SM_STAFF_ID AND SM.SM_DEPT_CODE = DM.DM_DEPT_CODE AND AM.AM_CATEGORY = AC.AC_CAT_ID  "+
						    "AND AM.AM_STATUS='APPROVE' "+
						   "AND SYSDATE - 14 < AM.AM_APPROVE_DATE "+
						    "UNION SELECT AM.AM_REF,AM.AM_CATEGORY,AM.AM_TITLE,TO_CHAR(AM.AM_APPROVE_DATE,'DD MON YYYY'),"+
							"SM.SM_STUDENT_NAME,DM.DM_DEPT_DESC,AM.AM_ACCESS,AC.AC_CAT_DESC,AM.AM_APPROVE_DATE "+
        	               "FROM CMSADMIN.ANNOUNCEMENT_MAIN AM,CMSADMIN.STUDENT_MAIN SM,CMSADMIN.DEPARTMENT_MAIN DM,CMSADMIN.ANNOUNCEMENT_CATEGORY AC "+
						   "WHERE AM.AM_POSTED_BY = SM.SM_STUDENT_ID AND SM.SM_FACULTY_CODE = DM.DM_DEPT_CODE AND AM.AM_CATEGORY = AC.AC_CAT_ID "+
						   "AND AM.AM_STATUS='APPROVE' "+
						   "AND SYSDATE - 14 < AM.AM_APPROVE_DATE "+
						   "ORDER BY AM.AM_APPROVE_DATE DESC";*/

   		try
			{
			pstmtchk2 = conn.prepareStatement(sqlchk2);
			rsetchk2 = pstmtchk2.executeQuery ();
			if (rsetchk2.isBeforeFirst ()) {  
				while (rsetchk2.next ()) 
				{ 
					String tarikh2= rsetchk2.getString(4);
					String access  = rsetchk2.getString(7);
%>
<% 	if ((session.getAttribute("userType").equals(access)) || (access.equals("Public"))){%>
<form name="form1" method="post" action="">
  <table width="100%" border="0" cellspacing="1" bgcolor="#FFFFFF">
    <tr class='contentBgColor'> 
      <td><strong><a href="javascript:void(window.open('cms/announcement/entry/view.jsp?ref=<%=rsetchk2.getString(1)%>','view', 'height=500,width=600,menubar=no,toolbar=no,scrollbars=yes'))"><font size="1" color=blue face="Arial"><b><%=rsetchk2.getString(3)%></a> 
        </strong></td>
    </tr>
    <tr class='contentBgColor'> 
      <td> <strong><font size="1" face="Arial">Posted 
        by : </font></strong><font color=black size="1" face="Arial"><%=rsetchk2.getString(5)%>, 
        <%=rsetchk2.getString(6)%>; <strong><br>
        Date </strong>: <%=rsetchk2.getString(4)%><br>
        <strong>Category</strong> : <%=rsetchk2.getString(8)%> <br>
        <div align="center"> </div>
        </font> </td>
    </tr>
    <% } %>
    <% 
					}
				}
			pstmtchk2.close ();
			rsetchk2.close ();
			}
	catch( Exception e )
		{ out.println (e.toString()); }
	//}
		finally {
				try {
					if (rsetchk2 != null) rsetchk2.close();
					if (pstmtchk2 != null) pstmtchk2.close();
					if (conn != null) conn.close();
				}
				catch (Exception e) { }
				}
			}
%>
  </table>
</form>
</body>
</html>
