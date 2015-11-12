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

<form name="form1" method="post" action="">
  <table width="100%" border="0" cellspacing="1" bgcolor="#FFFFFF">
    <tr bgcolor="#FF9900" class='contentBgColor'> 
      <td height="1" colspan="4" valign="middle"><strong><font color="#FFFFFF" size="1" face="Arial"></font></strong></td>
    </tr>
    <tr> 
      <td colspan="3" bordercolor="#FF9900"> 
        <%
if (conn!=null)
	{
   String sqlchk2	= 	"SELECT AM.AM_REF,AM.AM_CATEGORY,AM.AM_TITLE,TO_CHAR(AM.AM_APPROVE_DATE,'DD MON YYYY'), "+
   					  	"INITCAP(SM.SM_STAFF_NAME),DM.DM_DEPT_DESC,AM.AM_ACCESS,AC.AC_CAT_DESC,AM.AM_APPROVE_DATE "+
        	          	"FROM CMSADMIN.ANNOUNCEMENT_MAIN AM,CMSADMIN.STAFF_MAIN SM, CMSADMIN.DEPARTMENT_MAIN DM,CMSADMIN.ANNOUNCEMENT_CATEGORY AC "+
						"WHERE AM.AM_POSTED_BY=SM.SM_STAFF_ID AND SM.SM_DEPT_CODE=DM.DM_DEPT_CODE AND AM.AM_CATEGORY = AC.AC_CAT_ID  "+
						"AND AM.AM_STATUS='APPROVE' "+
						"AND TO_CHAR(SYSDATE,'YYYY') = '2006' "+
						"ORDER BY AM.AM_APPROVE_DATE DESC";

   		try
			{
			PreparedStatement pstmtchk2 = conn.prepareStatement(sqlchk2);
			ResultSet rsetchk2 = pstmtchk2.executeQuery ();
			if (rsetchk2.isBeforeFirst ()) {  
				while (rsetchk2.next ()) 
				{ 
					String tarikh2= rsetchk2.getString(4);
					String access  = rsetchk2.getString(7);
%>
        <% 	if ((session.getAttribute("userType").equals(access)) || (access.equals("Public"))){%>
    <tr class='contentBgColor'> 
      <td width="1%"><div align="right"><b></b></div></td>
      <td width="1%">&nbsp;</td>
      <td width="95%" colspan="2"><strong><font size="1" face="Arial"> 
        </font></b><a href="javascript:void(window.open('entry/view.jsp?ref=<%=rsetchk2.getString(1)%>','view', 'height=500,width=600,menubar=no,toolbar=no,scrollbars=yes'))"><font size="1" color=blue face="Arial"><b><%=rsetchk2.getString(3)%></b></font></a></font> </font> 
        <% if (tarikh3.equals(tarikh2)) { %>
        <img src="images/new_baru.gif" width="31" height="12"> 
        <% }%>
        </strong></td>
    </tr>
    <tr class='contentBgColor'> 
      <td><div align="center"></div></td>
      <td>&nbsp;</td>
      <td colspan="4"> <strong><font size="1" face="Arial">Posted 
        by : </font></strong><font color=black size="1" face="Arial"><%=rsetchk2.getString(5)%>, 
        <%=rsetchk2.getString(6)%>; <strong><br>
        Date </strong>: <%=rsetchk2.getString(4)%><br>
        <strong>Category</strong> : <%=rsetchk2.getString(8)%> <br>
        <div align="center"> </div>
        </font> </td>
      <% } %>
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
  </table>
</form>
</body>
<%
	conn.close ();
%>

</html>
