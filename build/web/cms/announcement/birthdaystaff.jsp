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

 <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css_framework/tables/JFTable.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css_framework/tables/JFTableStyle-1.css" />
     <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css_framework/tables/JFTableStyle-5.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/css_framework/tables/JFTableStyle-6.css" />

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
	
	String sql_hari	= 	"SELECT TO_CHAR(SYSDATE,'dd MON') FROM DUAL ";
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




  <table width="98%" align="center" cellpadding="3" cellspacing="0" class="table style-5">
  <thead>
    <tr>
     
      <th width="95%"><center><h3> Jabatan Pendaftar mengucapkan Selamat Hari Lahir kepada semua penama di bawah <BR>yang lahir pada hari ini <font color=red><%=hari%></font> dan bagi bulan 
          <%=tarikh%>.<br>  Semoga kalian dipanjangkan umur dan dimurahkan rezeki. </h3></center></th>
      
       
       <% if (staffid.equals("0031") || staffid.equals("0966")|| staffid.equals("0900") || staffid.equals("0227")) {%>
       <th width="5%">
    <a href="print_newstaff.jsp" target = "_blank" onMouseOver="window.status='Print';return true;"><IMG SRC = "../../images/system/ic_printer.gif" ALT = "Print" border = "0"></a>
        </th>
    <%}%> 
    </tr>
    </thead>
  </table>
  <br>


<!-------------------------------------------hari---------------------------------->
<%
if (conn!=null)   
	{
  		 String sqlchk_hari	=  "SELECT SM_STAFF_ID,SM_STAFF_NAME,SM_DEPT_CODE,upper(DM_DEPT_DESC),TO_CHAR(SM_BIRTH_DATE,'DD/MM'),UPPER(ss_service_desc) "+
							"FROM STAFF_MAIN,DEPARTMENT_MAIN,SERVICE_SCHEME "+
							"WHERE SM_DEPT_CODE=DM_DEPT_CODE AND SM_JOB_CODE=SS_SERVICE_CODE AND TO_CHAR(SM_BIRTH_DATE,'DD MON')=?  "+   
							"AND SM_STAFF_STATUS='ACTIVE' AND SM_STAFF_TYPE='STAFF' "+
							"ORDER BY TO_CHAR(SM_BIRTH_DATE,'DD/MON') DESC ";
   		try
			{
			PreparedStatement pstmtchk3 = conn.prepareStatement(sqlchk_hari);
			pstmtchk3.setString (1, hari);
			ResultSet rsetchk3 = pstmtchk3.executeQuery ();
			if (rsetchk3.isBeforeFirst ()) {  %>

<table width="98%" align="center" cellpadding="3" cellspacing="0" class="table style-5">
  <thead>
            <tr bgcolor="#999999">
              <th colspan="7"><h3><div aling=left><font color=BLUE><strong>Birthday Today:<%=hari%></strong></font></div></h3></th>
            </TR>
            <tr bgcolor="#999999" > 
			<th > No.</th>
			<th width="8%" >Staf ID</th>
			<th width="28%" >Name</th>
			<th width="22%" >Position</th>
			<th width="29%" >Department</th>
			<th width="10%" align="center" >Birthday Date </th>
  </TR>
  </thead>
			
			<%
				while (rsetchk3.next ()) 
				{ 
					String nama2= rsetchk3.getString(1);
					String jabatan2  = rsetchk3.getString(3);
					String tarikhlapor2  = rsetchk3.getString(4);
%>
			<TR>
			<TD width="3%" valign="top" ><%=rsetchk3.getRow()%>.</TD>
			<TD align="center" valign="top" ><CENTER><%=rsetchk3.getString(1)%></CENTER></TD>
			<TD valign="top" ><%=rsetchk3.getString(2)%></TD>
			<TD valign="top" ><%=rsetchk3.getString(6)%></TD>
			<TD valign="top" ><%=rsetchk3.getString(4)%></TD>
			<TD align="center" valign="top" ><center><%=rsetchk3.getString(5)%></center></TD>
			</TR>
			
        
      <% } %>
</table> 
<br>
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
  		 String sqlchk2	=  "SELECT SM_STAFF_ID,SM_STAFF_NAME,SM_DEPT_CODE,upper(DM_DEPT_DESC),TO_CHAR(SM_BIRTH_DATE,'DD/MM'),UPPER(ss_service_desc) "+
							"FROM STAFF_MAIN,DEPARTMENT_MAIN,SERVICE_SCHEME "+
							"WHERE SM_DEPT_CODE=DM_DEPT_CODE AND SM_JOB_CODE=SS_SERVICE_CODE AND TO_CHAR(SM_BIRTH_DATE,'MM')=?  "+   
							"AND SM_STAFF_STATUS='ACTIVE' AND SM_STAFF_TYPE='STAFF' "+
							"ORDER BY TO_CHAR(SM_BIRTH_DATE,'DD/MON') DESC ";
   		try
			{
			PreparedStatement pstmtchk2 = conn.prepareStatement(sqlchk2);
			pstmtchk2.setString (1, tarikh);
			ResultSet rsetchk2 = pstmtchk2.executeQuery ();
			if (rsetchk2.isBeforeFirst ()) {  %>
            
<table width="98%" align="center" cellpadding="3" cellspacing="0" class="table style-5">
  <thead>
            <tr bgcolor="#999999" >
              <th colspan="7"  bgcolor="#000000" ><h3><strong><font color=blue>Group of Month:<%=tarikh%></font></strong></h3></th>
  </TR>
            <tr bgcolor="#999999" > 
			<th > No.</th>
			<th width="8%" >Staf ID</th>
			<th width="28%" >Name</th>
			<th width="22%" >Position</th>
			<th width="29%" >Department</th>
			<th width="10%" align="center" >Birthday Date </th>
  </TR>
</thead>			
			<%
				while (rsetchk2.next ()) 
				{ 
					String nama= rsetchk2.getString(1);
					String jabatan  = rsetchk2.getString(3);
					String tarikhlapor  = rsetchk2.getString(4);
%>
			<TR>
			<TD width="3%" valign="top" ><%=rsetchk2.getRow()%>.</TD>
			<TD align="center" valign="top" ><CENTER><%=rsetchk2.getString(1)%></CENTER></TD>
			<TD valign="top" ><%=rsetchk2.getString(2)%></TD>
			<TD valign="top" ><%=rsetchk2.getString(6)%></TD>
			<TD valign="top" ><%=rsetchk2.getString(4)%></TD>
			<TD align="center" valign="top" ><center><%=rsetchk2.getString(5)%></center></TD>
			</TR>
			
        
      <% } %>
</table> 
  <% 
					
				}
			rsetchk2.close ();
			pstmtchk2.close ();
			}
	catch( Exception e ) {
		out.println (e.toString());
	}
	finally {
		if (conn != null) conn.close();
	}
}
%>

<p align="center" class="style13">Ikhlas;<br>
Jabatan Pendaftar<br>
  Universiti Malaysia Pahang</p>

</body>
</html>
