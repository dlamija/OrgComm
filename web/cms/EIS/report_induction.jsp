<%@ page session="true"%>
<%@ page import="java.sql.*" errorPage="" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ include file="/includes/import.jsp" %>

<html>

<head>
<link href="../induction/default.css" rel="stylesheet" type="text/css">
</head>

<%
	Connection conn = null;

	String sid = (String)session.getAttribute("staffid");
	String act = request.getParameter("action");

	String refid = request.getParameter("refid");
	String stat = request.getParameter("stat");

	int type = 0, noofAppl = 0, noofAppr = 0, noofRejc = 0;

	String staffid = "";
	String nama = "";
	String tarikh_mula = "";
	String tarikh_akhir = "";
	String tarikh_apply = "";
	String result = "";
	String title = "";
	String nama_kursus = "";
	String staff_dept = "";
	String staff_dept_desc = "";
	String job_code = "";
	String ic_no = "";
	String post="";
	String joindate="";
	int bil=0;

	try
	{
	Context initCtx = new InitialContext();
	Context envCtx = (Context) initCtx.lookup("java:comp/env");
	DataSource ds = (DataSource) envCtx.lookup("jdbc/cmsdb");
	conn = ds.getConnection();
	}
	
	catch (Exception e)
	{out.println("Database Error :" + e.toString());}

%>

<body>

<br>

<table width="100%" cellpadding="3" cellspacing="1" border="0">
  <tr>
      <td colspan="9" CLASS="contentStrapColor"><b>Induction Course Application Report</b></td>
    </tr>
</table>

<hr color="#000000">

<% if (conn != null && act!=null && act.equals("report") 
	&& request.getParameter("Submit") != null && refid != null && stat != null)
	{
%>


<table width="100%" cellpadding="3" cellspacing="1" border="0" >
	<tr>
	  <td class=contentBgColorAlternate>Ref No. : <b><%=refid%></b></td>
	</tr>
</table>


<%
	String curAppl	= 	"SELECT COUNT(*) FROM STAFF_INDUKSI_HEAD "+
						"WHERE SIH_INDUKSI_REF_ID = '"+refid+"' ";
%><%=curAppl%><%
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(curAppl);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			noofAppl = rset.getInt(1);
			}
		pstmt.close ();
		rset.close();
		}
	catch (SQLException e)
		{ out.println ("Error Staff_main: " + e.toString ()); }
%>

<%
	String curAppr	= 	"SELECT COUNT(*) FROM STAFF_INDUKSI_HEAD "+
						"WHERE SIH_INDUKSI_REF_ID = '"+refid+"' "+
						"AND SIH_STATUS = 'APPROVED' ";
						

	try
		{
		PreparedStatement pstmt = conn.prepareStatement(curAppr);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			noofAppr = rset.getInt(1);
			}
		pstmt.close ();
		rset.close();
		}
	catch (SQLException e)
		{ out.println ("Error Staff_main: " + e.toString ()); }
%>

<%
	String curRejc	= 	"SELECT COUNT(*) FROM STAFF_INDUKSI_HEAD "+
						"WHERE SIH_INDUKSI_REF_ID = '"+refid+"' "+
						"AND SIH_STATUS = 'REJECTED' ";

	try
		{
		PreparedStatement pstmt = conn.prepareStatement(curRejc);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			noofRejc = rset.getInt(1);
			}
		pstmt.close ();
		rset.close();
		}
	catch (SQLException e)
		{ out.println ("Error Staff_main: " + e.toString ()); }
%>
<br>


<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="3">

     <tr bgcolor="#EEEEEE" class="smallbold">
       <td colspan="9" class = "contentStrapColor"><b>Induction Application Statistic</b></td>
     </tr>


     <tr valign="top" bgcolor="#EEEEEE" class="smallbold">
       <td class = "contentStrapColor" rowspan="2" align="center"><b>No of Application</b></td>
	   <td class = "contentStrapColor" colspan="3" align="center"><b>Application Status</b></td>
	</tr>

     <tr valign="top" bgcolor="#EEEEEE" class="smallbold">
	   <td class = "contentStrapColor" align="center"><b>Approved</b></td>
	   <td class = "contentStrapColor" align="center"><b>Rejected</b></td>
	   <td class = "contentStrapColor" align="center"><b>Apply</b></td>
	</tr>

	<tr valign="top" bgcolor="#FFFFFF" class="smallfont">
	   <td class = "contentBgColor" align=center><b><font color=black><%=noofAppl%></font></b></td>
	   <td class = "contentBgColor" align=center><b><font color=blue><%=noofAppr%></font></b></td>
	   <td class = "contentBgColor" align=center><b><font color=red><%=noofRejc%></font></b></td>
	   <td class = "contentBgColor" align=center><b><font color=blue><%=noofAppl - (noofAppr + noofRejc)%></font></b></td>
	</tr>

</table>


<br>

<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000" bgcolor="#FFFFFF" class="smallfont">

<%
if (conn!=null) 
{
	String sql_ith	=  "SELECT DISTINCT SIH_STAFF_ID,SM_STAFF_NAME,SIH_RESULT,SIH_INDUKSI_REF_ID, "+
					   "ITH_TRAINING_TITLE, SS_SERVICE_DESC,SM_JOB_CODE,SM_DEPT_CODE,UPPER(DM_DEPT_DESC), "+
					   "SM_IC_NO,TO_CHAR(SM_JOIN_DATE,'DD-MM-YYYY') "+
				 	   "FROM STAFF_INDUKSI_HEAD,STAFF_MAIN,INDUKSI_TRAINING_HEAD,DEPARTMENT_MAIN,SERVICE_SCHEME "+
				       "WHERE SIH_STAFF_ID = SM_STAFF_ID "+
				       "AND SIH_INDUKSI_REF_ID = ITH_REF_ID "+
					   "AND SIH_INDUKSI_REF_ID = '"+refid+"' "+
					   "AND SIH_STATUS = '"+stat+"' "+
					   "AND SS_SERVICE_CODE = SM_JOB_CODE "+
					   "AND SM_DEPT_CODE=DM_DEPT_CODE "+				 
				       "ORDER BY SM_DEPT_CODE,SIH_STAFF_ID";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_ith);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.isBeforeFirst())
		  {

%>	
	<tr>
      <td class=contentBgColorAlternate colspan="6">Application Status :: <font color="#FF3333"><b><%=stat%></b></font></td>
	</tr>
  
  <tr valign="top"> 
	<td align="left" class=contentStrapColor><b>&nbsp;</b></td>
    <td align="center" class=contentStrapColor><b>Staff ID & Name</b></td>
	<td align="center" class=contentStrapColor><b>IC No.</b></td>
	<td align="center" class=contentStrapColor><b>Department/Faculty</b></td>
	<td align="center" class=contentStrapColor><b>Position</b></td>
	<td align="center" class=contentStrapColor><b>Join Date</b></td>
  </tr>
 <%
 
   while(rset.next())
			{
			        bil         		= rset.getRow();
			        staffid				= rset.getString(1);
					nama 				= rset.getString(2);
					result 				= rset.getString(3);
					refid      			= rset.getString(4);
					title       		= rset.getString(5);
					post 				= rset.getString (6);
			        job_code 			= rset.getString (7);
			        staff_dept 			= rset.getString (8);
			        staff_dept_desc     = rset.getString (9);
			        ic_no 	 			= rset.getString (10);
					joindate	 		= rset.getString (11);
			
 %> 
  <tr valign="top"> 
	<td align="left" class=contentBgColor><%=bil%></td>
    <td align="left" class=contentBgColor><%=staffid%> - <%=nama%></td>
    <td align="left" class=contentBgColor><%=ic_no%></td>
	<td align="left" class=contentBgColor><%=staff_dept_desc%></td>
    <td align="left" class=contentBgColor><%=post%></td>
	<td align="left" class=contentBgColor><%=joindate%></td>
  </tr>
<%
			}
		  }	
		  else
		  {
%>
	<tr>
      <td class=contentBgColorAlternate colspan="6"><b>No Record Available</b></font></td>
	</tr>
<%
		  }
		rset.close ();
		pstmt.close ();
		}

	catch (SQLException e)
		{ out.println ("Error : " + e.toString () + "/n" + sql_ith); }
	}	
%>
</table>

<%
	}
	else
	{
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFF">
  <tr>
    <td colspan="11">
	  <font color="red" size="1" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;">No Record Available</font>
	</td>
  </tr>
</table>
<% } %>

<%
conn.close();
%>
</p>
</body>
</html>
