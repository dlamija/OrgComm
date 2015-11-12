

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









<p>

  <%@include file="include/date.jsp"%>
</p>
<p align="center">&nbsp;</p>
<p align="center"> STAFF ATTENDANCE REPORT (LATE) BY MONTH - YEAR</p>
<table width="98%" height="73" border="0" align="center" cellpadding="0" cellspacing="0">
  <tbody>
   <tr>
      <td height="16" width="16"><img src="cms/sktnew/line/search_curve_leftop.gif" height="16" width="16" /></td>
      <td background="cms/sktnew/line/search_line_top.gif" height="16" width="1173"></td>
      <td height="16" width="16"><img src="cms/sktnew/line/search_curve_rightop.gif" height="16" width="16" /></td>
    </tr>
    <tr>
      <td background="cms/sktnew/line/search_line_left.gif" height="65" width="16"></td>
      <td height="65" valign="top" width="911"><form action="EIS.jsp" method=get>
          <p>
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
				  
	
	
	String sql =  "SELECT DISTINCT TO_CHAR(SAH_DATE, 'MONTH YYYY') SAH_DATE, TO_CHAR(SAH_DATE, 'YYYY') SAH_DATE2 "+
				  "FROM STAFF_ATTENDANCE_HEAD,STAFF_MAIN "+
				  "WHERE sah_staff_id = sm_staff_id" +
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
                  <option value="EIS.jsp?action=main_graphatt&month=<%=rset1.getString(1)%>"><%=rset1.getString(1)%></option>
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
              
                <input name="submit" type=submit style="font-family: Verdana, sans-serif; font-size: 11px;  8px;" value="Go">
                </span></td>
            </tr>
          </table>
      </form>
     </td>
      <td background="cms/sktnew/line/search_line_right.gif" height="65" width="16"></td>
    </tr>
    <tr>
      <td height="16" width="16"><img src="cms/sktnew/line/search_curve_leftdown.gif" height="16" width="16" /></td>
      <td background="cms/sktnew/line/search_line_down.gif" height="16" width="1173"></td>
      <td height="16" width="16"><img src="cms/sktnew/line/search_curve_rightdown.gif" height="16" width="16" /></td>
    </tr>
  </tbody>
</table>
<p>
<p>
</body>
</html>
<% conn.close(); %>
