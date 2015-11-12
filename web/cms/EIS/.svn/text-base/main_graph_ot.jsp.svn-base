<%--Coding by:
Wan Azlee Bin Hj. Wan Abdullah
Bahagian Aplikasi & Pembangunan Sistem
Pusat Teknologi Maklumat & Komunikasi
--%>


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
<div align="center">
  <p>&nbsp;</p>
  <p> STAFF OVERTIME BY MONTH - YEAR<br>
  </p>
</div>
<table width="98%" height="126" border="0" align="center" cellpadding="0" cellspacing="0">
  <tbody>
    <tr>
      <td height="16" width="16"><img src="cms/sktnew/line/search_curve_leftop.gif" height="16" width="16" /></td>
      <td background="cms/sktnew/line/search_line_top.gif" height="16" width="1173"></td>
      <td height="16" width="16"><img src="cms/sktnew/line/search_curve_rightop.gif" height="16" width="16" /></td>
    </tr>
    <tr>
      <td background="cms/sktnew/line/search_line_left.gif" height="94" width="16"></td>
      <td height="94" valign="top" width="1173"> 
        <form action="EIS.jsp" method=post>
          <p> 
            <input type=hidden name=action value=graph_ot>
            <input type=hidden name=dept value="<%=ref%>">
          </p>
          <p>&nbsp; </p>
          <table width="100%" border="0" cellpadding="3" cellspacing="0">
            <tr> 
              <td width="44%"><div align="right"><span class="contentTitleFont style30"><font size="2">MONTH 
                  - YEAR</font></span></div></td>
              <td width="1%"><span class="contentTitleFont"><font color="#000000">:</font></span></td>
              <td width="55%"><span class="style29" style="font-family: Verdana, Arial, Helvetica, sans-serif"> 
                <%
if (conn!=null)
	{
	String sql =  " SELECT DISTINCT TO_CHAR(SOD_DATE, 'MM/YYYY') SOD_DATE, TO_CHAR(SOD_DATE,'YYYY') SOD_DATE2, TO_CHAR(SOD_DATE,'MONTH YYYY') SOD_DATE3 "+
				 " FROM STAFF_OVERTIME_DETL,STAFF_MAIN,STAFF_OVERTIME_HEAD "+
				 " WHERE SOD_STAFF_ID=SM_STAFF_ID "+
				 " AND SOH_STAFF_ID= SOD_STAFF_ID "+
				 " and SOD_DATE is not null "+
				 " AND SOH_RECOMMEND_BY = '"+sid+"' "+
				 " AND SOH_STATUS = 'PAID' "+
				 " ORDER BY SOD_DATE2 desc,SOD_DATE desc";

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
                  <option value="<%=rset1.getString(3)%>"><%=rset1.getString(3)%></option>
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
      <td background="cms/sktnew/line/search_line_right.gif" height="94" width="16"></td>
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
