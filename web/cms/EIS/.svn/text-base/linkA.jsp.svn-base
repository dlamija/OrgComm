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


String id= (String)session.getAttribute("staffid");
String id_sub = request.getParameter("ls_sub");
String action = request.getParameter("action");

String work_id	= request.getParameter("ref_id");

String bil ="";
String type_report ="";
String report   ="";
String graph     ="";


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
	

	String sql   	= "SELECT upper(WOH_DESC), NVL(TO_CHAR(WOH_DATE_FROM,'DD/MM/YYYY'),' '), "+
					  "NVL(TO_CHAR(WOH_DATE_TO,'DD/MM/YYYY'),' '), WOH_TYPE, WOD_CATEGORY, WOH_FLAG_STATUS " +
					  "FROM WORK_ORDER_HEAD, WORK_ORDER_DETL " +
					  "WHERE WOD_WORKORDER_ID = WOH_WORKORDER_ID " +
					  "AND WOH_WORKORDER_ID = '"+work_id+"' " +
					  "ORDER BY WOH_DATE_FROM, WOH_WORKORDER_ID";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_wo);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			bil 		= rset.getString (1);
			type report = rset.getString (2);
			report		= rset.getString (3);
			graph 		= rset.getString (4);
			
			}
		rset.close ();
		pstmt.close ();
		}
	catch (SQLException e)
		{ out.println ("Error Staff_Dept: " + e.toString ()); }
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
			travel_range		= rset.getString (1);
			destination 		= rset.getString (2);
			trans	    		= rset.getString (3);
			reason		 		= rset.getString (4);
			accompany	 		= rset.getString (5);
			vehicle				= rset.getString (6);
			}
			
			if (trans.equals("001"))
			transdetl = "OWN TRANSPORT";
			else if (trans.equals("002"))
			transdetl = "KUKTEM'S TRANSPORT";
			else if (trans.equals("003"))
			transdetl = "KUKTEM'S TRANSPORT WITH DRIVER";
			else if (trans.equals("004"))
			transdetl = "PASSENGER";
			else if (trans.equals("005"))
			transdetl = "FLIGHT";
			else if (trans.equals("006"))
			transdetl = "KUKTEM'S TRANSPORT WITH DRIVER (TO AND FROM AIRPORT)";
			else if (trans.equals("007"))
			transdetl = "PUBLIC TRANSPORT";
			
		rset.close ();
		pstmt.close ();
		}
	catch (SQLException e)
		{ out.println ("Error Staff_Dept: " + e.toString ()); }
%>

<P>
<body>

<div> </div>

<font size="1"><br>
</font> <font size="1"><br>
</font> 

<table width="100%" border="1" cellspacing="1" cellpadding="3" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;  8px;" bordercolor="#000000">
	<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
      
    <td colspan="4" align="center"><b>List of Type Report</b></td>
    </tr>
</table>

<table width="100%" border="1" cellpadding="3" cellspacing="1" bordercolor="#000000">
  <tr bgcolor="#006699" class="smallbold"> 
    <td width="8%"  align="center" >Bil</td>
    <td width="50%" align="center">Type Report</td>
    <td width="15%" align="center">Report</td>
    <td width="17%" align="center">Graph</td>
  </tr>
  <tr class="smallfont"> 
    <td align="center"><%=rset.getRow()%><%=a++%></td>
    <td ><%=description%>Staff Attendance</td>
    <td align="center"><a href="staffattendanceapproveReason.jsp">Link</a> <%=woh_type%></td>
    <td align="center"><%=date_from%></td>
  </tr>
</table>

<font size="1"><br>
</font> 
</body>

<% conn.close(); %>

</html>