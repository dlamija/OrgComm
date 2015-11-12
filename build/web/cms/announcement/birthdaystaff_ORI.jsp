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
<style type="text/css">
<!--
.style6 {
	font-family: Arial;
	font-size: 12px;
	font-weight: bold;
}
.style10 {font-size: 10px}
.style13 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	font-weight: bold;
}
-->
</style>
</head>

<style type="text/css">
<!--
@import url("template/default/style2.css");
.style8 {color: #000000; font-weight: bold; font-family: Arial; }
.style9 {font-family: Arial}
.style11 {color: #FFFF00}
.style12 {
	color: #FF0000;
	font-weight: bold;
}
.style14 {color: #000000}
.style16 {font-family: Arial; font-size: 12px; }
.style17 {color: #FF0000}
-->
</style>
<%
//pageContext.include("/cms/announcement/announceHeader.jsp");
response.setHeader( "Cache-Control", "no-store" );
response.setHeader( "Pragma", "no-cache" );
response.setDateHeader( "Expires", 0 );

	Connection conn = null;
	ResultSet rs_all = null;
	String category = request.getParameter("category");
	String action = request.getParameter("action");
	String staffid = session.getAttribute("staffid").toString();
	
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
    String hari="";
	
	String sql_hari	= 	"SELECT TO_CHAR(SYSDATE,'dd/MM') FROM DUAL ";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_hari);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			hari = rset.getString (1);
			}
		rset.close();		
		pstmt.close ();
		}
		catch (SQLException e)
		{ out.println ("Error sysdate: " + e.toString ()); }
%>

<%
    String tarikh="";
	
	String sql_date	= 	"SELECT TO_CHAR(SYSDATE,'MM') FROM DUAL ";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_date);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			tarikh = rset.getString (1);
			}
		rset.close();		
		pstmt.close ();
		}
		catch (SQLException e)
		{ out.println ("Error sysdate: " + e.toString ()); }
%>

<body>



<div align="center" class="style6">
			
			
</div>
<div align="center" class="style6">
  <div align="left"></div>
</div>
<div align="center">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="5%"><% if (staffid.equals("0031") || staffid.equals("0966")|| staffid.equals("0900") || staffid.equals("0227")) {%>
    <a href="print_newstaff.jsp" target = "_blank" onMouseOver="window.status='Print';return true;"><IMG SRC = "../../images/system/ic_printer.gif" ALT = "Print" border = "0"></a>
    <%}%> 
    </td>
      <td width="95%"><div align="center"><span class="style16"><strong>    Jabatan Pendaftar mengucapkan Selamat Hari Lahir kepada semua penama di bawah<br> 
        yang lahir pada <span class="style17">hari ini </span></strong> <span class="style12"><%=hari%> <span class="style14">dan bagi</span> bulan 
          <%=tarikh%>. <span class="style14"> <br>
      Semoga kalian dipanjangkan umur dan dimurahkan rezeki. </span></span></span></div></td>
    </tr>
  </table>
  <br>
</div>

<!-------------------------------------------hari---------------------------------->
<%
if (conn!=null)   //AND TO_CHAR(SM_JOIN_DATE,'MM/YYYY')='"+tarikh+"'   and sm_staff_id='0227'
	{
  		 String sqlchk_hari	=  "SELECT SM_STAFF_ID,SM_STAFF_NAME,SM_DEPT_CODE,DM_DEPT_DESC,TO_CHAR(SM_BIRTH_DATE,'DD/MM'),UPPER(ss_service_desc) "+
							"FROM STAFF_MAIN,DEPARTMENT_MAIN,SERVICE_SCHEME "+
							"WHERE SM_DEPT_CODE=DM_DEPT_CODE AND SM_JOB_CODE=SS_SERVICE_CODE AND TO_CHAR(SM_BIRTH_DATE,'DD/MM')='"+hari+"'  "+   
							"AND SM_STAFF_STATUS='ACTIVE' AND SM_STAFF_TYPE='STAFF' "+
							"ORDER BY TO_CHAR(SM_BIRTH_DATE,'DD/MON') DESC ";
   		try
			{
			PreparedStatement pstmtchk3 = conn.prepareStatement(sqlchk_hari);
			ResultSet rsetchk3 = pstmtchk3.executeQuery ();
			if (rsetchk3.isBeforeFirst ()) {  %>
<table width="98%" border="1" align="center" cellpadding="3" cellspacing="0" bordercolor="#CCCCCC" bgcolor="#FFFFFF">
            <tr bgcolor="#999999" CLASS="sideTitleBgBorderColor">
              <td colspan="7"  bgcolor="#000000" CLASS="sideTitleBgBorderColor"><span class="style11 style10 style9"><strong>Birthday Today:<%=hari%></strong></span></TD>
            </TR>
            <tr bgcolor="#999999" CLASS="sideTitleBgBorderColor"> 
			<td bgcolor="#99CCFF" CLASS="sideTitleBgBorderColor"> <span class="style8 style10">No.</span></TD>
			<td width="8%" bgcolor="#99CCFF" CLASS="sideTitleBgBorderColor"><span class="style8 style10">Staf ID</span></TD>
			<td width="28%" bgcolor="#99CCFF" CLASS="sideTitleBgBorderColor"><span class="style8 style10">Name</span></TD>
			<td width="22%" bgcolor="#99CCFF" CLASS="sideTitleBgBorderColor"><span class="style8 style10">Position</span></TD>
			<td width="29%" bgcolor="#99CCFF" CLASS="sideTitleBgBorderColor"><span class="style8 style10">Department</span></TD>
			<td width="10%" align="center" bgcolor="#99CCFF" CLASS="sideTitleBgBorderColor"><span class="style8 style10">Birthday Date </span></TD>
  </TR>
			
			<%
				while (rsetchk3.next ()) 
				{ 
					String nama2= rsetchk3.getString(1);
					String jabatan2  = rsetchk3.getString(3);
					String tarikhlapor2  = rsetchk3.getString(4);
%>
			<TR>
			<TD width="3%" valign="top" CLASS="sideBodyFontAndBgColor"><span class="style9 style10"><font color="#000000"><%=rsetchk3.getRow()%>.</font></span></TD>
			<TD align="center" valign="top" CLASS="sideBodyFontAndBgColor"><span class="style9 style10"><font color="#000000"><%=rsetchk3.getString(1)%></font></span></TD>
			<TD valign="top" CLASS="sideBodyFontAndBgColor"><span class="style9 style10"><font color="#000000"><%=rsetchk3.getString(2)%></font></span></TD>
			<TD valign="top" CLASS="sideBodyFontAndBgColor"><span class="style9 style10"><font color="#000000"><%=rsetchk3.getString(6)%></font></span></TD>
			<TD valign="top" CLASS="sideBodyFontAndBgColor"><span class="style9 style10"><font color="#000000"><%=rsetchk3.getString(4)%></font></span></TD>
			<TD align="center" valign="top" CLASS="sideBodyFontAndBgColor"><span class="style9 style10"><font color="#000000"><%=rsetchk3.getString(5)%></font></span></TD>
			</TR>
			
        
      <% } %>
</table> 
  <% 
					
				}
			rsetchk3.close ();
			pstmtchk3.close ();
			}
	catch( Exception e )
		{ out.println (e.toString()); }
	}
//conn.close ();
%>

<!------------------------------bulan--------------------------------------------->
<%
if (conn!=null)   //AND TO_CHAR(SM_JOIN_DATE,'MM/YYYY')='"+tarikh+"'   and sm_staff_id='0227'
	{
  		 String sqlchk2	=  "SELECT SM_STAFF_ID,SM_STAFF_NAME,SM_DEPT_CODE,DM_DEPT_DESC,TO_CHAR(SM_BIRTH_DATE,'DD/MM'),UPPER(ss_service_desc) "+
							"FROM STAFF_MAIN,DEPARTMENT_MAIN,SERVICE_SCHEME "+
							"WHERE SM_DEPT_CODE=DM_DEPT_CODE AND SM_JOB_CODE=SS_SERVICE_CODE AND TO_CHAR(SM_BIRTH_DATE,'MM')='"+tarikh+"'  "+   
							"AND SM_STAFF_STATUS='ACTIVE' AND SM_STAFF_TYPE='STAFF' "+
							"ORDER BY TO_CHAR(SM_BIRTH_DATE,'DD/MON') DESC ";
   		try
			{
			PreparedStatement pstmtchk2 = conn.prepareStatement(sqlchk2);
			ResultSet rsetchk2 = pstmtchk2.executeQuery ();
			if (rsetchk2.isBeforeFirst ()) {  %>
<table width="98%" border="1" align="center" cellpadding="3" cellspacing="0" bordercolor="#CCCCCC" bgcolor="#FFFFFF">
            <tr bgcolor="#999999" CLASS="sideTitleBgBorderColor">
              <td colspan="7"  bgcolor="#000000" CLASS="sideTitleBgBorderColor"><span class="style11 style10 style9"><strong>Group of Month:<%=tarikh%></strong></span></TD>
  </TR>
            <tr bgcolor="#999999" CLASS="sideTitleBgBorderColor"> 
			<td bgcolor="#99CCFF" CLASS="sideTitleBgBorderColor"> <span class="style8 style10">No.</span></TD>
			<td width="8%" bgcolor="#99CCFF" CLASS="sideTitleBgBorderColor"><span class="style8 style10">Staf ID</span></TD>
			<td width="28%" bgcolor="#99CCFF" CLASS="sideTitleBgBorderColor"><span class="style8 style10">Name</span></TD>
			<td width="22%" bgcolor="#99CCFF" CLASS="sideTitleBgBorderColor"><span class="style8 style10">Position</span></TD>
			<td width="29%" bgcolor="#99CCFF" CLASS="sideTitleBgBorderColor"><span class="style8 style10">Department</span></TD>
			<td width="10%" align="center" bgcolor="#99CCFF" CLASS="sideTitleBgBorderColor"><span class="style8 style10">Birthday Date </span></TD>
  </TR>
			
			<%
				while (rsetchk2.next ()) 
				{ 
					String nama= rsetchk2.getString(1);
					String jabatan  = rsetchk2.getString(3);
					String tarikhlapor  = rsetchk2.getString(4);
%>
			<TR>
			<TD width="3%" valign="top" CLASS="sideBodyFontAndBgColor"><span class="style9 style10"><font color="#000000"><%=rsetchk2.getRow()%>.</font></span></TD>
			<TD align="center" valign="top" CLASS="sideBodyFontAndBgColor"><span class="style9 style10"><font color="#000000"><%=rsetchk2.getString(1)%></font></span></TD>
			<TD valign="top" CLASS="sideBodyFontAndBgColor"><span class="style9 style10"><font color="#000000"><%=rsetchk2.getString(2)%></font></span></TD>
			<TD valign="top" CLASS="sideBodyFontAndBgColor"><span class="style9 style10"><font color="#000000"><%=rsetchk2.getString(6)%></font></span></TD>
			<TD valign="top" CLASS="sideBodyFontAndBgColor"><span class="style9 style10"><font color="#000000"><%=rsetchk2.getString(4)%></font></span></TD>
			<TD align="center" valign="top" CLASS="sideBodyFontAndBgColor"><span class="style9 style10"><font color="#000000"><%=rsetchk2.getString(5)%></font></span></TD>
			</TR>
			
        
      <% } %>
</table> 
  <% 
					
				}
			rsetchk2.close ();
			pstmtchk2.close ();
			}
	catch( Exception e )
		{ out.println (e.toString()); }
	}
conn.close ();
%>

<p align="center" class="style13">Ikhlas;<br>
Jabatan Pendaftar<br>
  Universiti Malaysia Pahang</p>
<p>

  
</p>
</body>
</html>
