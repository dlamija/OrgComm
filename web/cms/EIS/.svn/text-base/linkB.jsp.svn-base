<%@ page session="true" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="javax.sql.*" %>
<%@page import="javax.naming.*" %>
<%@include file="validate.jsp" %>


<HTML>
<HEAD>

<style type="text/css">
<!--
.smallfont {  font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 7pt}
.smallfont2 {  font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 7.5pt}
.smallbold {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 7pt;
	font-weight: bold;
	color: #FFFFFF;
}
.largebold {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10pt;
	font-weight: bold;
}
-->
</style>

</head>
<%
Connection conn = null;
LinkedList staff_id = new  LinkedList ();
LinkedList staff_name = new  LinkedList ();

String id= (String)session.getAttribute("staffid");
String id_sub = request.getParameter("ls_sub");
String action = request.getParameter("action");


String bil         ="";
String staff_id    ="";
String staff_name  ="";
String position    ="";
String department  ="";
String link	       ="";

try
	{
    	Context initCtx = new InitialContext();
    	Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
    	DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
		conn = ds.getConnection();
	
		staff.setDBConnection (conn);
	}
catch( Exception e )
	{ out.println (e.toString()); }

%>

<%
	


	String sql_str	= "SELECT STR_TRAVEL_RANGE, STR_DESTINATION, STR_TRANSPORT_TYPE, STR_TRAVEL_REASON, STR_REMARK, STR_TRANSPORT_CHOICE "+
					  "FROM WORK_ORDER_HEAD, STAFF_TRAVEL_REQUEST " +
					  "WHERE STR_WORKORDER_ID = WOH_WORKORDER_ID " +
					  "AND STR_WORKORDER_ID = '"+work_id+"' ";
				
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_str);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			bil 		= rset.getString (1);
			staff_id 	= rset.getString (2);
			staff_name  = rset.getString (3);
			position	= rset.getString (4);
			department	= rset.getString (5);
			link		= rset.getString (6);
			}
			
			
		rset.close ();
		pstmt.close ();
		}
	catch (SQLException e)
		{ out.println ("Error Staff_Dept: " + e.toString ()); }
%>

<P>
<body>

<div> <font size="1"> </font> </div>

<font size="1"> <br>
</font> 
<table width="100%" border="1" cellspacing="1" cellpadding="3" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;  8px;" bordercolor="#000000">
	
  <TR VALIGN="TOP" BGCOLOR="#DBDBDB"> 
    <td colspan="4" align="center">&nbsp;</td>
    </tr>
</table>

<table width="100%" border="1" cellpadding="3" cellspacing="1" bordercolor="#000000">
  <tr bgcolor="#006699" class="smallbold"> 
    <td width="5%"  align="center" >Bil</td>
    <td width="35%" align="center">Staff ID</td>
    <td width="35%" align="center">Staff Name</td>
    <td width="24%" align="center">Position</td>
    <td width="18%" align="center">Department</td>
    <td width="10%" align="center">Link</td>
  </tr>
  <tr class="smallfont"> 
    <td align="center"><%=rset.getRow()%><%=a++%></td>
    <td >&nbsp;</td>
    <td ><a href="../../../../../../../../Documents%20and%20Settings/Administrator/Desktop/training_apply.jsp?action=status_staff_kj&staffid=<%=rset.getString(8)%>"><%=rset.getString(1)%></a> 
    </td>
    <td align="center"><%=( ( rset.getString(2) ==null)?"-":rset.getString(2) )%></td>
    <td align="center"><%=( ( rset.getString(3) ==null)?"-":rset.getString(3) )%></td>
    <td align="center">Link</td>
  </tr>
</table>

<p>&nbsp;</p>
<p>&nbsp;</p>
</body>

<% conn.close(); %>

</html>