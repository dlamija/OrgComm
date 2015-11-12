<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ include file="/includes/import.jsp" %>
<jsp:useBean id="validator" scope="page" class="cms.staff.StaffValidator"/>


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
-->
</style>
</head>

<style type="text/css">
<!--
@import url("template/default/style2.css");
.style8 {color: #000000; font-weight: bold; font-family: Arial; }
.style9 {font-family: Arial}
.style11 {color: #FFFF00}
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
		validator.setDBConnection(conn);
		}
	catch( Exception e )
	{ 
		out.println (e.toString()); 
	}
	boolean status = false;
	if (validator.isAuthorized(staffid,"ASW001","1.00"))
		status = true;
	else
		status = false;
%>
<%
    String tarikh="";
	
	String sql_date	= 	"SELECT TO_CHAR(SYSDATE,'MM/YYYY') FROM DUAL";
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

<div align="left"> <%if (status) {%>	
<a href="print_newstaff.jsp" target = "_blank" onMouseOver="window.status='Print';return true;"><IMG SRC = "../../images/system/ic_printer.gif" ALT = "Print" border = "0"></a>
<%}%></div>

<div align="center" class="style6">
			
			<%
if (conn!=null)   //AND TO_CHAR(SM_JOIN_DATE,'MM/YYYY')='"+tarikh+"'   and sm_staff_id='0227'
	{
  		 String sqlchk2	=  "SELECT SM.SM_STAFF_ID,SM.SM_STAFF_NAME,SM.SM_DEPT_CODE,DM.DM_DEPT_DESC,TO_CHAR(SM.SM_JOIN_DATE,'DD/MM/YYYY'), "+
		 					"UPPER(SC.SS_SERVICE_DESC),SM_JOB_CODE,DM2.DM_DEPT_DESC "+
							"FROM CMSADMIN.STAFF_MAIN SM,CMSADMIN.DEPARTMENT_MAIN DM,CMSADMIN.SERVICE_SCHEME SC,CMSADMIN.DEPARTMENT_MAIN DM2 "+
							"WHERE SM.SM_DEPT_CODE = DM.DM_DEPT_CODE AND SM.SM_JOB_CODE = SC.SS_SERVICE_CODE AND TO_CHAR(SM.SM_JOIN_DATE,'MM/YYYY') = ? "+   
							"AND SM.SM_STAFF_STATUS = 'ACTIVE' AND SM.SM_STAFF_TYPE='STAFF' "+
							"AND SM.SM_UNIT_CODE = DM2.DM_DEPT_CODE(+) "+
							"ORDER BY SM.SM_JOIN_DATE DESC ";
   		try
			{
			PreparedStatement pstmtchk2 = conn.prepareStatement(sqlchk2);
			pstmtchk2.setString(1, tarikh);
			ResultSet rsetchk2 = pstmtchk2.executeQuery ();
			if (rsetchk2.isBeforeFirst ()) {  %>
</div>
<div align="center" class="style6">
  <div align="left"></div>
</div>

<table width="98%" border="1" align="center" cellpadding="3" cellspacing="0" bordercolor="#CCCCCC" bgcolor="#FFFFFF">
            <tr bgcolor="#999999" CLASS="sideTitleBgBorderColor">
              <td colspan="9"  bgcolor="#000000" CLASS="sideTitleBgBorderColor"><span class="style9 style10 style11">Query Month-Year:<%=tarikh%></span></TD>
            </TR>
            <tr bgcolor="#999999" CLASS="sideTitleBgBorderColor"> 
			<td align="center" bgcolor="#99CCFF" CLASS="sideTitleBgBorderColor"> <span class="style8 style10">No.</span></TD>
			<td width="6%" align="center" bgcolor="#99CCFF" CLASS="sideTitleBgBorderColor"><span class="style8 style10">ID Staff / <em>Staf ID </em></span></TD>
			<td width="22%" align="center" bgcolor="#99CCFF" CLASS="sideTitleBgBorderColor"><span class="style8 style10">Nama / <em>Name</em></span></TD>
			<td width="18%" align="center" bgcolor="#99CCFF" CLASS="sideTitleBgBorderColor"><span class="style8 style10">Jawatan / <em>Position</em></span></TD>
			<td width="6%" align="center" bgcolor="#99CCFF" CLASS="sideTitleBgBorderColor"><span class="style8 style10">Gred / <em>Grade</em></span></TD>
			<td width="20%" align="center" bgcolor="#99CCFF" CLASS="sideTitleBgBorderColor"><span class="style8 style10">Jabatan / <em>Department</em></span></TD>
			<td width="16%" align="center" bgcolor="#99CCFF" CLASS="sideTitleBgBorderColor"><span class="style8 style10">Sub Jabatan / Sub <em>Department</em></span></TD>
			<td width="10%" align="center" bgcolor="#99CCFF" CLASS="sideTitleBgBorderColor"><span class="style8 style10">Tarikh Lapor Diri / <em>Join Date </em></span></TD>
						</TR>
			
			<%
				while (rsetchk2.next ()) 
				{ 
					String nama= rsetchk2.getString(1);
					String jabatan  = rsetchk2.getString(3);
					String tarikhlapor  = rsetchk2.getString(4);
%>
			<TR>
			<TD width="2%" align="center" valign="top" CLASS="sideBodyFontAndBgColor"><span class="style9 style10"><font color="#000000"><%=rsetchk2.getRow()%>.</font></span></TD>
			<TD align="center" valign="top" CLASS="sideBodyFontAndBgColor"><span class="style9 style10"><font color="#000000"><%=rsetchk2.getString(1)%></font></span></TD>
			<TD valign="top" CLASS="sideBodyFontAndBgColor"><span class="style9 style10"><font color="#000000"><%=rsetchk2.getString(2)%></font></span></TD>
			<TD valign="top" CLASS="sideBodyFontAndBgColor"><span class="style9 style10"><font color="#000000"><%=rsetchk2.getString(6)%></font></span></TD>
			<TD align="center" valign="top" CLASS="sideBodyFontAndBgColor"><span class="style9 style10"><font color="#000000"><%=rsetchk2.getString(7)%></font></span></TD>
			<TD valign="top" CLASS="sideBodyFontAndBgColor"><span class="style9 style10"><font color="#000000"><%=rsetchk2.getString(4)%></font></span></TD>
			<TD align="left" valign="top" CLASS="sideBodyFontAndBgColor"><span class="style9 style10"><font color="#000000"><%=( ( rsetchk2.getString(8)==null)?"-":rsetchk2.getString(8) )%></font></span></TD>
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

</body>

</html>
