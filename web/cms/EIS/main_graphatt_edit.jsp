

<%@ page session="true" %>
<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="javax.naming.*" %>
<%@include file="validate.jsp" %>
<%@page import="java.util.LinkedList" %>

<jsp:useBean id="validator" class="cms.staff.StaffValidator" scope="request" />


<%
Connection conn = null;



String sid= (String)session.getAttribute("staffid");
String id_sub = request.getParameter("ls_sub");

String ref=request.getParameter("ref");
String ref2=request.getParameter("ref2");
String para=request.getParameter("para");

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


<SCRIPT LANGUAGE="JavaScript">
	function checkAll(field)
	{
	for (i = 0; i < field.length; i++)
		field[i].checked = true ;
	}

	function uncheckAll(field)
	{
	for (i = 0; i < field.length; i++)
		field[i].checked = false ;
	}

</script>

<html>
<head>

	<script>
	function ValidateFields()
	{
	      
	  if(document.form1.tarikh.value=='')
		  {		   
		  	alert("Please Select Date First");
			return false;
		  }	
		  
 	}
  	</script>

	

    <style type="text/css">
<!--
.style1 {	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-weight: bold;
	font-size: 12px;
}
.style29 {font-size: 12px}
.style30 {color: #000000}
-->
    </style>
</head>
<body>
<form name="form1" method="post" action="">
  <p align="center">STAFF ATTENDANCE REPORT (LATE) BY MONTH - YEAR</p>
  <table width="98%" height="73" border="0" align="center" cellpadding="0" cellspacing="0">
    <tbody>
      <tr>
        <td height="16" width="16"><img src="cms/sktnew/line/search_curve_leftop.gif" height="16" width="16" /></td>
        <td background="cms/sktnew/line/search_line_top.gif" height="16" width="1173"></td>
        <td height="16" width="16"><img src="cms/sktnew/line/search_curve_rightop.gif" height="16" width="16" /></td>
      </tr>
      <tr>
        <td background="cms/sktnew/line/search_line_left.gif" height="65" width="16"></td>
        <td height="65" valign="top" width="911"><p>
            <input type=hidden name=action value=graphatt>
            <input type=hidden name=dept value="<%=ref%>">
          </p>
            <p>&nbsp; </p>
          <table width="100%" border="0" cellpadding="3" cellspacing="0">
              <tr>
                <td width="44%"><div align="right"><span CLASS="contentTitleFont style30"><font size="2">Month-Year</font></span></div></td>
                <td width="1%"><span CLASS="contentTitleFont"><font color="#000000">:</font></span></td>
                <td width="55%"><span class="style29" style="font-family: Verdana, Arial, Helvetica, sans-serif">
                  <%
if (conn!=null)
	{
	
	
	/*String sql = "SELECT DISTINCT TO_CHAR(SAH_DATE,'MONTH YYYY') SAH_DATE, TO_CHAR(SAH_DATE,'MONTH YYYY') "+
	              " FROM STAFF_ATTENDANCE_HEAD,STAFF_MAIN "+
				  " WHERE SM_STAFF_ID = SAH_STAFF_ID  "+
				  " and SAH_DATE is not null "+
				   "AND SAH_TYPE = 'ATTENDANCE' " +
				  " and sah_status = 'APPROVE' "+
				  " and sah_approve_by = '"+sid+"' "+
				  " order by sah_date "; */
				  
	
	
	String sql =  "SELECT DISTINCT TO_CHAR(SAH_DATE, 'MM/YYYY') SAH_DATE, TO_CHAR(SAH_DATE, 'YYYY') SAH_DATE2, to_char(sah_date, 'MONTH YYYY') sah_date3 "+
				  "FROM STAFF_ATTENDANCE_HEAD,STAFF_MAIN "+
				  "WHERE sah_staff_id = sm_staff_id" +
	        //	  " AND TO_CHAR(SAH_TIME_FROM,'HH24:MI:SS') >='08:01:00'"+
			//	  " and sah_type='ATTENDANCE' "+
				  " and sah_date is not null "+
				  " AND exists " +
				  "(select 1 from staff_hierarchy,staff_attendance_head " +
				  " where sah_staff_id = sh_staff_id " +
				  " and sh_report_to='"+sid+"' "+
				  " and sh_sys_id = 'ADM_AL') "+
				  " ORDER BY SAH_DATE2 desc,SAH_DATE desc " ; 
				  
				  
				%>
                  <%//=sql%>
                  <%
		   	try
		{
		PreparedStatement pstmt1=conn.prepareStatement(sql);
		ResultSet rset1=pstmt1.executeQuery();
%>
                  <select name="month" >
                    <%		while (rset1.next ())
			{
			//if (rset.isFirst())
			//month = rset.getString(1);
%>
                    <option value="EIS.jsp?action=main_graphatt&month=<%=rset1.getString(3)%>"><%=rset1.getString(3)%></option>
                    <%
			}
%>
                  </select>
                  <%
		rset1.close ();
		pstmt1.close ();
		}
	catch (SQLException e)
		{ out.println ("Error! : " + e.toString ()); }
	}
%>
                </span></td>
              </tr>
          </table></td>
        <td background="cms/sktnew/line/search_line_right.gif" height="65" width="16"></td>
      </tr>
      <tr>
        <td height="16" width="16"><img src="cms/sktnew/line/search_curve_leftdown.gif" height="16" width="16" /></td>
        <td background="cms/sktnew/line/search_line_down.gif" height="16" width="1173"></td>
        <td height="16" width="16"><img src="cms/sktnew/line/search_curve_rightdown.gif" height="16" width="16" /></td>
      </tr>
    </tbody>
  </table>
  <% if (request.getParameter("month")!= null){%>
  <%
if (conn!=null)
	{
	String sql_year	= "SELECT to_char(sysdate, 'YYYY') from dual ";
	
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_year);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			sysdate_year = rset.getString (1);
			}
		pstmt.close ();
		rset.close ();
		}


	catch (SQLException e)
		{ out.println ("Error : " + e.toString () + "/n" + sql_year); }
	}	
%>
  <br>
  <%
if ( conn!=null )
	{
	
/*	String sql= " select to_char(sod_date, 'DD-MM-YYYY') sod_date,soh_status, sod_remark,SOD_TOTAL_DAILY_HOURS "+
                " from staff_overtime_detl, staff_overtime_head "+
                " where soh_staff_id= sod_staff_id "+
                " and soh_verify_by='"+sid+"' "+
                " and soh_staff_id= '"+staff+"' "+
				" order by sod_date "; 
				
				*/
				
	String sql= " SELECT DISTINCT TO_CHAR(SOD_DATE, 'DD-MM-YYYY') SOH_DATE, TO_CHAR(SOD_DATE, 'MM/YYYY') SOD_DATE3, TO_CHAR(SOD_DATE,'YYYY') SOD_DATE2, TO_CHAR(SOD_DATE,'DD') SOD_DATE4, "+
				" SOD_REMARK,SOD_TOTAL_DAILY_HOURS,SM_STAFF_NAME "+
				" FROM STAFF_OVERTIME_DETL,STAFF_OVERTIME_HEAD,STAFF_MAIN "+
				" WHERE SOD_STAFF_ID=SM_STAFF_ID "+
				" AND SOD_STAFF_ID= SOH_STAFF_ID "+
				" AND SOH_RECOMMEND_BY='"+sid+"' "+
				" AND SOD_STAFF_ID='"+staff+"' "+
				" AND SOH_STATUS='PAID' "+
				" ORDER BY SOD_DATE2 desc,SOD_DATE3 desc,SOD_DATE4 desc";	
	
	
	
	
	
/*	" SELECT DISTINCT SOD_WORKORDER_ID,TO_CHAR(SOD_DATE, 'DD-MM-YYYY') SOH_DATE, SOH_STATUS,SOD_REMARK,SOD_TOTAL_DAILY_HOURS,SM_STAFF_NAME "+
				" FROM STAFF_OVERTIME_DETL,STAFF_OVERTIME_HEAD,STAFF_MAIN "+
				" WHERE SOD_STAFF_ID=SM_STAFF_ID "+
				" AND SOD_STAFF_ID= SOH_STAFF_ID "+
				" AND SOH_RECOMMEND_BY='"+sid+"' "+
				" AND SOD_STAFF_ID='"+staff+"' "+
				" AND SOH_STATUS='PAID' ";
			//	" ORDER BY SOD_WORKORDER_ID, SOD_DATE desc"; */
				
				%><%//=sql%><%
	try
		{
		PreparedStatement pstmt=conn.prepareStatement(sql);
		ResultSet rset=pstmt.executeQuery();
		//if(rset.isBeforeFirst()){
		
		%>
  <p> 
  <p></p>
  <%}
			rset.close();
			pstmt.close();
			}
		catch( Exception e )
			{ out.println(e.toString());}
		}


conn.close();
%>
  <%}%>
  <% conn.close(); %>
</form>








<p>

  <%@include file="include/date.jsp"%>
</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p>
  <% if (request.getParameter("month")!= null){%>
  <%
if (conn!=null)
	{
	String sql_year	= "SELECT to_char(sysdate, 'YYYY') from dual ";
	
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_year);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			sysdate_year = rset.getString (1);
			}
		pstmt.close ();
		rset.close ();
		}


	catch (SQLException e)
		{ out.println ("Error : " + e.toString () + "/n" + sql_year); }
	}	
%>
</p>
<p>
<p>
</body>
</html>
<% conn.close(); %>
