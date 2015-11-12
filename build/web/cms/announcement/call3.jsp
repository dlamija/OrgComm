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
	
	String sql_date	= 	"SELECT TO_CHAR(SYSDATE,'MON-YYYY'),TO_CHAR(SYSDATE,'DD-MON-YY') FROM DUAL";
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

<body bgcolor="#FFE7C1" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="form1" method="post" action="">


  <table width="100%" border="0" cellspacing="1" bgcolor="#FFE7C1">
    <tr class='contentBgColor'> 
      <td width="3%" rowspan="2" valign="middle"><strong><font color="#FFFFFF" size="1" face="Arial"><img src="images/pen.gif" width="50" height="33"></font></strong><strong><font color="#FFFFFF" size="1" face="Arial"><font color="#FF6600"> 
        </font> </font></strong></td>
      <td height="15" valign="baseline"><strong><font color="#FFFFFF" size="1" face="Arial"><font color="#FF6600">Announcement 
        </font></font></strong></td>
    </tr>
    <tr class='contentBgColor'> 
      <td height="15" valign="baseline">
        <hr></td>
    </tr>
    <%
if (conn!=null)
	{
   String sql_daily2	=  "SELECT DISTINCT(AM_ACCESS) FROM ANNOUNCEMENT_MAIN ORDER BY AM_ACCESS";
   		try
			{
			PreparedStatement pstmt3 = conn.prepareStatement(sql_daily2);
			ResultSet rset2 = pstmt3.executeQuery ();
			if (rset2.isBeforeFirst ()) {  
				while (rset2.next ()) 
				{ 
					String access  = rset2.getString(1);
%>
    <% 	if ((session.getAttribute("userType").equals(access)) || (access.equals("Public"))){%>
    <tr> 
      <td bordercolor="#FF9900"> 
        <%
if (access!=null)
	{
   String sqlchk2	=  "SELECT am_ref,am_category,am_title,to_char(AM_APPROVE_DATE,'dd MON yyyy'),initcap(sm_staff_name),DM_DEPT_DESC,am_access,ac_cat_desc,am_approve_date "+
        	               "FROM announcement_main,staff_main,DEPARTMENT_MAIN,announcement_category "+
						   "where am_posted_by=sm_staff_id and SM_DEPT_CODE=DM_DEPT_CODE and am_category = ac_cat_id  "+
						   "and am_access = '"+access+"' "+
						   "and am_status='APPROVE' "+
						   "and sysdate <= am_approve_date + am_total_day "+
						    "union SELECT am_ref,am_category,am_title,to_char(AM_APPROVE_DATE,'dd MON yyyy'),initcap(sm_student_name),DM_DEPT_DESC,am_access,ac_cat_desc,am_approve_date "+
        	               "FROM announcement_main,student_main,DEPARTMENT_MAIN,announcement_category "+
						   "where am_posted_by=sm_student_id and SM_faculty_CODE=DM_DEPT_CODE and am_category = ac_cat_id "+
						   "and am_access = '"+access+"' "+
						   "and am_status='APPROVE' "+
						   "and sysdate <= am_approve_date + am_total_day "+
						   "order by AM_APPROVE_DATE DESC";
   		try
			{
			PreparedStatement pstmtchk2 = conn.prepareStatement(sqlchk2);
			ResultSet rsetchk2 = pstmtchk2.executeQuery ();
			if (rsetchk2.isBeforeFirst ()) {  
				while (rsetchk2.next ()) 
				{ 
					String tarikh2= rsetchk2.getString(5);
%>
    <tr class='contentBgColor'> 
      <td colspan="2"><div align="right"><b></b></div>
        <strong><font size="1" face="Arial"> </font></b><a href="javascript:void(window.open('entry/view.jsp?ref=<%=rsetchk2.getString(1)%>','view', 'height=500,width=600,menubar=no,toolbar=no,scrollbars=yes'))"><font size="1" color=blue face="Arial"><b><%=rsetchk2.getString(3)%></b></font></a></font> </font> 
        <% if (tarikh3.equals(tarikh2)) { %>
        <img src="images/new_baru.gif" width="31" height="12"> 
        <% }%>
        </strong></td>
    </tr>
    <tr class='contentBgColor'> 
      <td colspan="4"> <div align="center"></div>
        <strong><font size="1" face="Arial">Posted 
        by : </font></strong><font color=black size="1" face="Arial"><%=rsetchk2.getString(5)%>, 
        <%=rsetchk2.getString(6)%>; <strong><br>
        Date</strong> : <%=rsetchk2.getString(4)%><br>
        <strong>Category</strong> : <%=rsetchk2.getString(8)%><br>
        <div align="center"> </div>
        </font> </td>
      <% 
					}
				}
			rsetchk2.close ();
			pstmtchk2.close ();
			}
	catch( Exception e )
		{ out.println (e.toString()); }
	}
conn.close ();
%>
      <% } %>
    </tr>
    <% 
					}
				}
			rset2.close ();
			pstmt3.close ();
			}
	catch( Exception e )
		{ out.println (e.toString()); }
	}
conn.close ();
%>
  </table>
</form>
</body>
<%
	conn.close ();
%>

</html>
