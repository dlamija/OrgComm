
<%@ page session="true" %>
<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="javax.naming.*" %>

<%@page import="java.util.LinkedList" %>

<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>
A:hover {
	TEXT-DECORATION: underline
}
A.m {
	COLOR: #0090de
}
TD {
	FONT-SIZE: xx-small
}
BODY {
	FONT: xx-small verdana,sans-serif;
	COLOR: #6d6c75;
	background-image: url(/kuktem/cms/ProgressReport/images/bg.gif);
	background-color: #0099FF;
}
DIV {
	PADDING-TOP: 10px
}
A {
	COLOR: #6d6c75; TEXT-DECORATION: none
}
.style1 {color: #000000}
.style2 {
	color: #FFFFFF;
	font-weight: bold;
}
.style3 {color: #FF0000}
</STYLE>

</head>
<%
Connection conn = null;

String action="";
String id= (String)session.getAttribute("staffid");
String id_sub = request.getParameter("ls_sub");



String kategori=request.getParameter("kategori");
//String type=request.getParameter("type");
String kod=request.getParameter("kod");



try
	{
    	Context initCtx = new InitialContext();
    	Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
    	DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
	conn = ds.getConnection();
	}
catch( Exception e )
	{ out.println (e.toString()); }
%>

<%
	int rnd = 0,ss = 0,teach=0; 
	int jum = 0;  
	String types="";
	
	String sql	=  "SELECT SM_RDP,SM_SS,SM_TEACH,SM_CLASS FROM SKTSTAFF_MAIN "+
				   "WHERE SM_STAFF_ID ='"+ id +"' and sm_year=2005 ";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			rnd 		= rset.getInt (1);
			ss 		= rset.getInt (2);
			teach 		= rset.getInt (3);
			types 		= rset.getString (4);
			}
		pstmt.close ();
		rset.close();
		}
	catch (SQLException e)
		{ out.println ("Error sql: " + e.toString ()); }
%>

<%----------------------Staff's Profile------------------------------------------%>
<%
	String staff_id = "";
	String staff_name = "";
	String staff_dept = "";
	String staff_dept_desc = "";
	String staff_jawatan = "";
	String staff_descjwtn = "";
    
	String sql_staff	= 	"SELECT SM_STAFF_ID,SM_STAFF_NAME,SM_DEPT_CODE,UPPER(DM_DEPT_DESC),SM_JOB_CODE,UPPER(SS_SERVICE_DESC) "+
	                        "FROM STAFF_MAIN,DEPARTMENT_MAIN,SERVICE_SCHEME "+
							"WHERE SM_STAFF_ID ='"+ id +"' "+
							"AND SM_DEPT_CODE=DM_DEPT_CODE AND SM_JOB_CODE=SS_SERVICE_CODE ";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_staff);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			staff_id 		= rset.getString (1);
			staff_name 		= rset.getString (2);
			staff_dept 		= rset.getString (3);
			staff_dept_desc = rset.getString (4);
			staff_jawatan   = rset.getString (5);
			staff_descjwtn  = rset.getString (6);
			}
		pstmt.close ();
		rset.close();
		}
	catch (SQLException e)
		{ out.println ("Error Staff_main: " + e.toString ()); }
%>
<table width="100%" border="0" bgcolor="#CCCCCC">
  <tr>
    <td height="26" background="/kuktem/cms/ProgressReport/images/t_nav_bg.jpg"><a href="javascript:void(window.close('cms/ProgressReport/bscskt/viewresearch.jsp'))">[ Close Window ]</a> </td>
   
  </tr>
</table>
<%-----------------------------------------------------------------------%>
<table width="100%" border="1" cellpadding="3" cellspacing="0" bordercolor="#000000" bgcolor="#99CCFF">
  <tr> 
    <td><TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="3">
        <tr bgcolor="#000000"> 
          <td colspan="2" CLASS="contentBgColorAlternate"><span class="style2">Staff's Profile</span></td>
        </tr>
        <tr bgcolor="#FFFFFF" valign="top" class="smallfont"> 
          <td width="21%" class="contentBgColor style1">Staff ID & Name </td>
          <td width="79%" class="contentBgColor"><%= staff_id %>-<%= staff_name %>&nbsp;</td>
        </tr>
        <tr bgcolor="#FFFFFF" valign="top" class="smallfont"> 
          <td class="contentBgColor style1">Position</td>
          <td class="contentBgColor"><%= staff_jawatan %>-<%=staff_descjwtn %></td>
        </tr>
        <tr bgcolor="#FFFFFF" valign="top" class="smallfont"> 
          <td class="contentBgColor style1">Department</td>
          <td class="contentBgColor"><%= staff_dept %>-<%=staff_dept_desc %></td>
        </tr>
      </table></td>
  </tr>
</table>

<%
if (conn!=null)
	{
	// Display lists of waiting applications
	String sqldata	=  "SELECT distinct  SIM_STAFF_ID,BSC_DESC,SIM_WEIGHTAGE,SIM_HOUR,SIM_INITIATIVE, "+
	                "SIM_MEASUREMENT,SIM_STATUS,SIM_REMARK,SIM_REF "+
					"FROM SKT_INDIVIDU_MAIN,BSC_SUB_CLASS "+
					"WHERE SIM_STAFF_ID = '"+ id +"' AND SIM_BSC_CODE=BSC_CODE and SIM_BSC_CODE IS NOT NULL "+
					"and SIM_BSC_CODE ='"+kod+"' AND BSC_CATEGORY='"+kategori+"' ";





		try
			{
			PreparedStatement pstmt = conn.prepareStatement(sqldata);
			

			ResultSet rset = pstmt.executeQuery ();
			if (rset.isBeforeFirst ()) { %>
<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC" bgcolor="#99CCFF">
  <tr bgcolor="#FFFFFF" valign="top" class="smallfont"> 
    <td bgcolor="#ACB0EA" ><div align="center" class="style1"><strong>Activities</strong></div></td>
    <td bgcolor="#ACB0EA" ><div align="center" class="style1"><strong>Detailed Weightage</strong></div></td>
    <td bgcolor="#ACB0EA" ><div align="center" class="style1"><strong>Hours / year</strong></div></td>
    <td bgcolor="#ACB0EA" class="contentBgColor"><div align="center" class="style1"><strong>Initiatives<br>
    (Summary of activities/projects/<br>
    action plan) </strong></div></td>
    <td bgcolor="#ACB0EA" class="contentBgColor"><div align="center" class="style1"><strong>Measurement<br>
    (Quantity, Quality, Cost)</strong></div></td>
    <td bgcolor="#ACB0EA" class="contentBgColor"><div align="center" class="style1"><strong>Remarks</strong></div></td>
  </tr>
 <%  
  float totalweightage=0;
  float totalyear=0;
  while (rset.next () ) 
  {  
  totalweightage+=rset.getFloat(3);
  totalyear+=rset.getFloat(4);
  %>
  <tr bgcolor="#FFFFFF" valign="top" class="smallfont"> 
    <td width="38%"><%=rset.getString(2)%></td>
    <td width="7%" align="center"><%=rset.getFloat(3)%></td>
    <td width="4%"align="center"><%=rset.getFloat(4)%></td>
    <td width="18%"align="center"><div align="left"><%=( ( rset.getString(5) ==null)?"-":rset.getString(5) )%></div></td>
    <td width="18%"align="center"><div align="left"><%=( ( rset.getString(6) ==null)?"-":rset.getString(6) )%></div></td>
    <td width="17%"align="center"><div align="left"><%=( ( rset.getString(8) ==null)?"-":rset.getString(8) )%></div></td>
  </tr>
  <% } %>
   <tr bgcolor="black" valign="top" class="smallfont">
    <td width="38%"><font color="white"><b>Total</b></font></td>
    <td width="7%" align="center"><font color="white"><b><%=totalweightage%></b></font></td>
    <td width="4%"align="center"><font color="white"><b><%=totalyear%></b></font></td>
    <td width="18%"align="center"></td>
    <td width="18%"align="center"></td>
    <td width="17%"align="center"></td>
  </tr>
</table>
    </td>
  </tr>
</table>
<%  } else { %>
<br>
<span class="style3">Activity is not available ! </span>
<p>

        <% }

			rset.close ();
			pstmt.close ();
			}
	catch( Exception e )
		{ out.println (e.toString()); }
	}
conn.close ();
%>





<%conn.close(); %>
