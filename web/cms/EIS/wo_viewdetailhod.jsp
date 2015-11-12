<%@ page session="true" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="javax.sql.*" %>
<%@page import="javax.naming.*" %>


<jsp:useBean id="staff" class="cms.staff.StaffValidator" scope="request" />

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

String work_id	= request.getParameter("ref_id");

String description ="";
String woh_type    ="";
String date_from   ="";
String date_to     ="";
String category	   ="";
String flag	   ="";
String staff_dept_desc = "";

String travel_range ="";
String destination ="";
String trans ="";
String transdetl = "";
String reason ="";
String accompany ="";
String vehicle ="";

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
	

	String sql_wo	= "SELECT upper(WOH_DESC), NVL(TO_CHAR(WOH_DATE_FROM,'DD/MM/YYYY'),' '), "+
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
			description		= rset.getString (1);
			date_from 		= rset.getString (2);
			date_to 		= rset.getString (3);
			woh_type 		= rset.getString (4);
			category 		= rset.getString (5);
			flag 			= rset.getString (6);
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

<div>
  <a href="javascript:void(window.close())"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><strong>[ Close Screen ]</strong></font></a>
</div>

<font size="1"><br></font>

<TABLE WIDTH="100%" BORDER="1" CELLSPACING="1" CELLPADDING="3" bordercolor="#000000">
    <tr class='contentStrapColor' bordercolor="#000000"> 
      <!--td width="5%" align="center"><img src="../induction/images/logokecik1.gif" width="100" height="79"></td--->
      <td height="10"><div align ="center"><strong><font size="3" face="Geneva, Arial, Helvetica, sans-serif">UNIVERSITI MALAYSIA PAHANG </font></strong><br>
        <font size="1" face="Geneva, Arial, Helvetica, sans-serif">Karung Berkunci 
        12, 26300 Gambang, Kuantan, Pahang Darul Makmur <br>
		http://www.ump.edu.my</font> </div></td>
    </tr>
</table>

<font size="1"><br></font> 

<table width="100%" border="1" cellspacing="1" cellpadding="3" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;  8px;" bordercolor="#000000">
	<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
      <td colspan="4" align="center"><b>Workorder Information Details</b></td>
    </tr>
</table>

<table width="100%" border="1" cellpadding="3" cellspacing="1" bordercolor="#000000">
        <tr bgcolor="#006699" class="smallbold"> 
          <td width="8%"  align="center" >Ref ID</td>
          <td width="50%" align="center">Description</td>
          <td width="15%" align="center">Type</td>
          <td width="17%" align="center">Date From</td>
          <td width="15%" align="center">Date To</td>
          <td width="15%" align="center">Purposes</td>
        </tr>
        <tr class="smallfont"> 
          <td align="center"><%=work_id%></td>
          <td ><%=description%></td>
          <td align="center"><%=woh_type%></td>
          <td align="center"><%=date_from%></td>
          <td align="center"><%=date_to%></td>
          <td align="center"><%=( ( flag ==null)?"-":flag )%></td>
        </tr>
	
</table>

<% if (flag.equals("TRAVEL")) { %>

<font size="1"><br></font>

<table width="100%" border="1" cellspacing="1" cellpadding="1" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;">

	<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
      <td colspan="4" align="center"><b>Travelling and Transport Request Details</b></td>
    </tr>
	<tr COLSPAN="1" ALIGN="LEFT" class="smallfont2"> 
 	  <td ><b>Transport Choice</b></td> 
      <td COLSPAN="1" ALIGN="LEFT" width="72%">
	   <!--%=trans%--><%=transdetl%> <br>
      <% if (trans.equals("004")) { %>
      Person Accompany (if exist): <%=( ( accompany ==null)?"-":accompany )%> 
      <% } %>
    </td>
	</tr>
	<tr COLSPAN="1" ALIGN="LEFT" class="smallfont2"> 
 	  <td ><b>Transport Type</b></td> 
      <td COLSPAN="1" ALIGN="LEFT" width="72%">
	   <%=( ( vehicle ==null)?"-":vehicle )%>
	  </td>
	</tr> 	 
	<tr COLSPAN="1" ALIGN="LEFT" class="smallfont2"> 
 	  <td ><b>Destination </b></td> 
      <td COLSPAN="1" ALIGN="LEFT" width="72%">
      <%=destination%>
	  </td>
	</tr>


 </table>

<% } %>

<font size="1"><br></font> 
 
 <table width="100%" border="1" cellspacing="1" cellpadding="1" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;" bordercolor="#000000">
    <TR VALIGN="TOP" BGCOLOR="#DBDBDB">
	<TD CLASS="contentBgColorAlternate"  colspan=3 ALIGN="MIDDLE" ><B>Staff Assigned </B></td>
 	</tr>  
     
        <tr>
            <td  CLASS="contentBgColor" width="15%" align="center"><B>Staff ID</B></td>
            <td  CLASS="contentBgColor" width="75%" align="center"><b>Staff Name</b></td>
            <td  CLASS="contentBgColor" width="10%" align="center"><b>Position</b></td>
        </tr>
 
<!------------------staff query---------------------->

<%
	String staffid = "";
	String staffname = "";
	String staffpost = "";
	
	String sql_staff= "SELECT WOD_STAFF_ID,SM_STAFF_NAME,WOD_POSITION "+
	                  "FROM WORK_ORDER_DETL,STAFF_MAIN "+
			  		  "WHERE WOD_STAFF_ID = SM_STAFF_ID "+
			  		  "AND WOD_WORKORDER_ID = '"+work_id+"' ";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_staff);
		ResultSet rset = pstmt.executeQuery ();
		while (rset.next())
			{
			staffid 		= rset.getString (1);
			staffname 		= rset.getString (2);
			staffpost 		= rset.getString (3);
%>
 
  <tr>
   <td width="15%" ><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><%=staffid%></font></td>
   <td width="75%" ><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><%=staffname%></font></td>
   <td width="10%" ><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><%=staffpost%></font></td>
  </tr>

<%			
			}
		rset.close ();
		pstmt.close ();
		}
	catch (SQLException e)
		{ out.println ("Error Staff_main: " + e.toString ()); }
%>
  
 </table>

<hr>

</body>

<% conn.close(); %>

</html>