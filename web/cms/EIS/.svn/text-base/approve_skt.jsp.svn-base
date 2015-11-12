<%@ page import="java.util.*,java.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.text.*"%>
<%@ page import="javax.sql.*"%>
<%@ page session="true" %>
<jsp:useBean id="validator" scope="page" class="cms.staff.StaffValidator"/>
<jsp:useBean id="skt" class="cms.staff.SKTBean" scope="request" />
<html>
<head>
<title>Untitled Document</title>
<SCRIPT LANGUAGE="Javascript">
<!---
function confirm_submit(url){
if(confirm("Press OK to confirm"))
	document.form1.submit();
}
function confirm_submit2(url){
if(confirm("Press OK to confirm"))
	document.form2.submit();
}function confirm_submit3(url){
if(confirm("Press OK to confirm"))
	document.form3.submit();
}
// --->
</SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
<td width="100%">
<%
	Connection conn=null;
	int count=0;
	String year="";
	try
	{
		Context initCtx = new InitialContext();
	    Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
    	DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
    	conn = ds.getConnection();
    	validator.setDBConnection(conn);
		validator.setStaffId (session.getAttribute("staffid").toString());
		skt.setDbConnection (conn);
	}
	catch(Exception e)
	{
		System.out.println("Error : "+e);
	}
%>
<%
// Approve SKT
if (conn!=null&&request.getParameter("skt_type")!=null&&request.getParameterValues("subordinate")!=null)
	{
	String [] subordinate = request.getParameterValues("subordinate");
	for (int a=0;a<subordinate.length;a++)
		{
		if (skt.ApproveSKT(subordinate[a],skt.getSKTYear(),Integer.parseInt(request.getParameter("skt_type").toString())))
			{ %>Approving SKT Bahagian <%=request.getParameter("skt_type").toString()%> for Staff ID <%=subordinate[a]%> ... Done.<br><% }
		else
			{ %>Approving SKT Bahagian <%=request.getParameter("skt_type").toString()%> for Staff ID <%=subordinate[a]%> ... Failed. <%=skt.getErrorMsg()%><br><% }
		}
	%><br><%
	}
%>
<%
// Approve Bahagian 1
// Display list of subordinates
if (conn!=null&&skt.IsValidSKTTime("SKT1_DATE_FROM","SKT1_DATE_TO"))
	{
	String sql = "SELECT SSH_STAFF_ID,SM_STAFF_NAME " +
				 "FROM STAFF_SKT_HEAD,STAFF_MAIN " +
				 "WHERE SM_STAFF_ID = SSH_STAFF_ID " +
				 "AND SSH_YEAR = " +
				 "(SELECT HP_PARM_DESC FROM HRADMIN_PARMS WHERE HP_PARM_CODE = 'SKT_YEAR') " +
				 "AND SSH_PPP = ? " +
				 "AND SSH_PART1_STATUS = 'APPLY' " +
				 "ORDER BY SSH_STAFF_ID";
			
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString (1,session.getAttribute("staffid").toString());
		ResultSet rset = pstmt.executeQuery ();
		if (rset.isBeforeFirst())
			{
%>
<form action="../skt/ppp/skt.jsp?action=approve_subordinate_skt&skt_type=1" method="POST" name="form1">
<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0" bgcolor="#999999" >
<tr>
                    <td>
                        <table width="100%"  align="center" cellpadding="3" cellspacing="1" border="0" bgcolor="#999999">
              <tr bgcolor="#EEEEEE">
                <td width="100%" class="contentStrapColor" colspan="4"><b>Approve
                  Subordinate SKT For Year <%=skt.getSKTYear()%><br>
				  BAHAGIAN 1 - Penetapan Sasaran Kerja Tahunan</b>
				  </td>
              </tr>
              <tr bgcolor="#EEEEEE" class="contentBgColorAlternate">
                <td width="15%"><b>Staff ID</b></td>
                <td width="45%"><b>Name</b></td>
                <td width="15%" align="center"></td>
                <td width="15%" align="center"></td>
              </tr>
              <%
			while (rset.next())
				{
%>
              <tr class="contentBgColor">
                <td><%=rset.getString(1)%></td>
                <td><%=rset.getString(2)%></td>
                <td align="center"><A HREF="../skt/ppp/skt.jsp?action=edit_subordinate_skt&subordinate=<%=rset.getString(1)%>">Edit</a></td>
                <td align="center"><input name="subordinate" type="checkbox" value="<%=rset.getString(1)%>"></td>
              </tr>
              <%
				}
%>
              <tr bgcolor="#EEEEEE">
                <td width="100%" class="contentBgColor" colspan="4">
		<a href="javascript:confirm_submit('skt.jsp?action=approve_subordinate_skt&skt_type=1');" onMouseOver = "window.status = 'Approve';return true;"><img src= "../skt/ppp/images/system/ic_approve.gif" border = "0" alt = "Approve"></a>
		</td></tr>
            </table>
</td></tr></table>
</form>
<%
			}
		else
			{ %>Bahagian 1 - No SKT from subordinate available<% }
		rset.close ();
		pstmt.close ();
		}
	catch (SQLException e)
		{ out.println ("Error : " + e.toString ()); }
	}
else if (conn!=null&&!skt.IsValidSKTTime("SKT1_DATE_FROM","SKT1_DATE_TO"))
	{ %>Bahagian 1 is currently closed by HR.<br><% }
%>
</td></tr>
<tr><td><br></td></tr>
<tr><td>
<%
// Approve Bahagian 2
// Display list of subordinates
if (conn!=null&&skt.IsValidSKTTime("SKT2_DATE_FROM","SKT2_DATE_TO"))
	{
	String sql = "SELECT SSH_STAFF_ID,SM_STAFF_NAME " +
				 "FROM STAFF_SKT_HEAD,STAFF_MAIN " +
				 "WHERE SM_STAFF_ID = SSH_STAFF_ID " +
				 "AND SSH_YEAR = " +
				 "(SELECT HP_PARM_DESC FROM HRADMIN_PARMS WHERE HP_PARM_CODE = 'SKT_YEAR') " +
				 "AND SSH_PPP = ? " +
				 "AND SSH_PART2_STATUS = 'APPLY' " +
				 "ORDER BY SSH_STAFF_ID";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString (1,session.getAttribute("staffid").toString());
		ResultSet rset = pstmt.executeQuery ();
		if (rset.isBeforeFirst())
			{
%>
<form action="../skt/ppp/skt.jsp?action=approve_subordinate_skt&skt_type=2" method="POST" name="form2">
<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0" bgcolor="#999999" >
<tr>
                    <td>
                        <table width="100%"  align="center" cellpadding="3" cellspacing="1" border="0" bgcolor="#999999">
              <tr bgcolor="#EEEEEE">
                <td width="100%" class="contentStrapColor" colspan="4"><b>Approve
                  Subordinate SKT For Year <%=skt.getSKTYear()%><br>
				  BAHAGIAN 2 - Kajian Semula Sasaran Kerja Tahunan Pertengahan Tahun</b>
				  </td>
              </tr>
              <tr bgcolor="#EEEEEE" class="contentBgColorAlternate">
                <td width="15%"><b>Staff ID</b></td>
                <td width="45%"><b>Name</b></td>
                <td width="15%" align="center"></td>
                <td width="15%" align="center"></td>
              </tr>
              <%
			while (rset.next())
				{
%>
              <tr class="contentBgColor">
                <td><%=rset.getString(1)%></td>
                <td><%=rset.getString(2)%></td>
                <td align="center"><A HREF="../skt/ppp/skt.jsp?action=edit_subordinate_skt&subordinate=<%=rset.getString(1)%>">Edit</a></td>
                <td align="center"><input name="subordinate" type="checkbox" value="<%=rset.getString(1)%>"></td>
              </tr>
              <%
				}
%>
              <tr bgcolor="#EEEEEE">
                <td width="100%" class="contentBgColor" colspan="4">
		<a href="javascript:confirm_submit2('skt.jsp?action=approve_subordinate_skt&skt_type=2');" onMouseOver = "window.status = 'Approve';return true;"><img src= "../skt/ppp/images/system/ic_approve.gif" border = "0" alt = "Approve"></a>
		</td></tr>
            </table>
</td></tr></table>
</form>
<%
			}
		else
			{ %>Bahagian 2 - No SKT from subordinate available<% }
		rset.close ();
		pstmt.close ();
		}
	catch (SQLException e)
		{ out.println ("Error : " + e.toString ()); }
	}
else if (conn!=null&&!skt.IsValidSKTTime("SKT2_DATE_FROM","SKT2_DATE_TO"))
	{ %>Bahagian 2 is currently closed by HR.<br><% }
%>
</td></tr>
<tr><td><br></td></tr>
<tr><td>
<%
// Approve Bahagian 3
// Display list of subordinates
if (conn!=null&&skt.IsValidSKTTime("SKT3_DATE_FROM","SKT3_DATE_TO"))
	{
	String sql = "SELECT SSH_STAFF_ID,SM_STAFF_NAME " +
				 "FROM STAFF_SKT_HEAD,STAFF_MAIN " +
				 "WHERE SM_STAFF_ID = SSH_STAFF_ID " +
				 "AND SSH_YEAR = " +
				 "(SELECT HP_PARM_DESC FROM HRADMIN_PARMS WHERE HP_PARM_CODE = 'SKT_YEAR') " +
				 "AND SSH_PPP = ? " +
				 "AND SSH_PART3_STATUS = 'APPLY' " +
				 "ORDER BY SSH_STAFF_ID";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString (1,session.getAttribute("staffid").toString());
		ResultSet rset = pstmt.executeQuery ();
		if (rset.isBeforeFirst())
			{
%>
<form action="../skt/ppp/skt.jsp?action=approve_subordinate_skt&skt_type=3" method="POST" name="form3">
<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0" bgcolor="#999999" >
<tr>
                    <td>
                        <table width="100%"  align="center" cellpadding="3" cellspacing="1" border="0" bgcolor="#999999">
              <tr bgcolor="#EEEEEE">
                <td width="100%" class="contentStrapColor" colspan="4"><b>Approve
                  Subordinate SKT For Year <%=skt.getSKTYear()%><br>
				  BAHAGIAN 3 - Laporan dan Ulasan Keseluruhan Pencapaian Sasaran Kerja Tahunan Pada Akhir Tahun Oleh PYD dan PPP</b>
				  </td>
              </tr>
              <tr bgcolor="#EEEEEE" class="contentBgColorAlternate">
                <td width="15%"><b>Staff ID</b></td>
                <td width="45%"><b>Name</b></td>
                <td width="15%" align="center"></td>
                <td width="15%" align="center"></td>
              </tr>
              <%
			while (rset.next())
				{
%>
              <tr class="contentBgColor">
                <td><%=rset.getString(1)%></td>
                <td><%=rset.getString(2)%></td>
                <td align="center"><A HREF="../skt/ppp/skt.jsp?action=edit_subordinate_skt&subordinate=<%=rset.getString(1)%>">Edit</a></td>
                <td align="center"><input name="subordinate" type="checkbox" value="<%=rset.getString(1)%>"></td>
              </tr>
              <%
				}
%>
              <tr bgcolor="#EEEEEE">
                <td width="100%" class="contentBgColor" colspan="4">
		<a href="javascript:confirm_submit3('skt.jsp?action=approve_subordinate_skt&skt_type=3');" onMouseOver = "window.status = 'Approve';return true;"><img src= "../skt/ppp/images/system/ic_approve.gif" border = "0" alt = "Approve"></a>
		</td></tr>
            </table>
</td></tr></table>
</form>
<%
			}
		else
			{ %>Bahagian 3 - No SKT from subordinate available<% }
		rset.close ();
		pstmt.close ();
		}
	catch (SQLException e)
		{ out.println ("Error : " + e.toString ()); }
	}
else if (conn!=null&&!skt.IsValidSKTTime("SKT3_DATE_FROM","SKT3_DATE_TO"))
	{ %>Bahagian 3 is currently closed by HR.<br><% }
%>


<br>
</td>
</tr>
<%
try
	{ conn.close (); }
catch (Exception e)
	{ conn = null; }
%>
</table>
</body>
</html>