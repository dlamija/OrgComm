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



<div align="center" class="style6">
			
			<%
if (conn!=null)   //AND TO_CHAR(SM_JOIN_DATE,'MM/YYYY')='"+tarikh+"'   and sm_staff_id='0227'
	{
  		 String sqlchk2	=  "SELECT SM_STAFF_ID,SM_STAFF_NAME,SM_DEPT_CODE,DM_DEPT_DESC,TO_CHAR(SM_JOIN_DATE,'DD/MM/YYYY'),UPPER(ss_service_desc) "+
							"FROM STAFF_MAIN,DEPARTMENT_MAIN,SERVICE_SCHEME "+
							"WHERE SM_DEPT_CODE=DM_DEPT_CODE AND SM_JOB_CODE=SS_SERVICE_CODE   "+   
							"AND SM_STAFF_STATUS='ACTIVE' AND SM_STAFF_TYPE='STAFF' and SM_DEPT_CODE='COM1000' "+
							"ORDER BY SM_JOIN_DATE DESC ";
   		try
			{
			PreparedStatement pstmtchk2 = conn.prepareStatement(sqlchk2);
			ResultSet rsetchk2 = pstmtchk2.executeQuery ();
			if (rsetchk2.isBeforeFirst ()) {  %>
</div>
<div align="center" class="style6">
  <div align="left"></div>
</div>
<table width="98%" border="1" align="center" cellpadding="3" cellspacing="0" bordercolor="#CCCCCC" bgcolor="#FFFFFF">
            <tr bgcolor="#999999" CLASS="sideTitleBgBorderColor">
              <td colspan="6"  bgcolor="#000000" CLASS="sideTitleBgBorderColor"><span class="style9 style10 style11">Query Month-Year:<%=tarikh%></span></TD>
            </TR>
            <tr bgcolor="#999999" CLASS="sideTitleBgBorderColor"> 
			<td bgcolor="#99CCFF" CLASS="sideTitleBgBorderColor"> <span class="style8 style10">No.</span></TD>
			<td bgcolor="#99CCFF" CLASS="sideTitleBgBorderColor"><span class="style8 style10">Name</span></TD>
			<td bgcolor="#99CCFF" CLASS="sideTitleBgBorderColor"><span class="style8 style10">Position</span></TD>
			<td bgcolor="#99CCFF" CLASS="sideTitleBgBorderColor"><span class="style8 style10">Department</span></TD>
			<td bgcolor="#99CCFF" CLASS="sideTitleBgBorderColor"><span class="style8 style10">Join Date</span></TD>
			<td bgcolor="#99CCFF" CLASS="sideTitleBgBorderColor"><span class="style8 style10">Photo</span></TD>
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
			<TD valign="top" CLASS="sideBodyFontAndBgColor"><span class="style9 style10"><font color="#000000"><%=rsetchk2.getString(2)%></font></span></TD>
			<TD valign="top" CLASS="sideBodyFontAndBgColor"><span class="style9 style10"><font color="#000000"><%=rsetchk2.getString(6)%></font></span></TD>
			<TD valign="top" CLASS="sideBodyFontAndBgColor"><span class="style9 style10"><font color="#000000"><%=rsetchk2.getString(4)%></font></span></TD>
			<TD valign="top" CLASS="sideBodyFontAndBgColor"><span class="style9 style10"><font color="#000000"><%=rsetchk2.getString(5)%></font></span></TD>
			<TD valign="top" CLASS="sideBodyFontAndBgColor"><div align="center"><span class="style9 style10"><font color="#000000"><img src="../../servlet/GetPhoto?id=<%=rsetchk2.getString(1)%>" width="114" height="135"></font></span></div></TD>
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
<%
	conn.close ();
%>

</html>
