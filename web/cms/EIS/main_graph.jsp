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



String id= (String)session.getAttribute("staffid");
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
<br>
<p>&nbsp;</p>
<table width="98%" height="73" border="0" align="center" cellpadding="0" cellspacing="0">
  <tbody>
    <tr>
      <td height="16" width="16"><img src="cms/sktnew/line/search_curve_leftop.gif" height="16" width="16" /></td>
      <td background="cms/sktnew/line/search_line_top.gif" height="16" width="1173"></td>
      <td height="16" width="16"><img src="cms/sktnew/line/search_curve_rightop.gif" height="16" width="16" /></td>
    </tr>
    <tr>
      <td background="cms/sktnew/line/search_line_left.gif" height="65" width="16"></td>
      <td height="65" valign="top" width="1173"><form action="EIS.jsp" method=get>
      <input type=hidden name=action value=graph>
      <input type=hidden name=dept value="<%=ref%>">
          <table width="100%" border="0" cellpadding="3" cellspacing="0">
            <tr> 
              <td width="15%"><span CLASS="contentTitleFont style30"><font size="3">Tahun</font></span></td>
              <td width="1%"><span CLASS="contentTitleFont"><font color="#000000">:</font></span></td>
              <td width="84%"><span class="style29" style="font-family: Verdana, Arial, Helvetica, sans-serif"> 
                <select name=year size="1" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;" >
                  <option value="EIS.jsp?action=main_graph&year=2001" selected>2001</option>
                  <option value="EIS.jsp?action=main_graph&year=2002" selected>2002</option>
                  <option value="EIS.jsp?action=main_graph&year=2003" selected>2003</option>
                  <option value="EIS.jsp?action=main_graph&year=2004" selected>2004</option>
                  <option value="EIS.jsp?action=main_graph&year=2005" selected>2005</option>
                  <option value="EIS.jsp?action=main_graph&year=2006" selected>2006</option>
                  <option value="EIS.jsp?action=main_graph&year=2007" selected>2007</option>
                  <option value="EIS.jsp?action=main_graph&year=2008" selected>2008</option>
                  <option value="EIS.jsp?action=main_graph&year=2009" selected>2009</option>
                  <option value="EIS.jsp?action=main_graph&year=2010" selected>2010</option>
                  <option value="EIS.jsp?action=main_graph&year=2011" selected>2011</option>
                  <option value="EIS.jsp?action=main_graph&year=2012" selected>2012</option>
                  <option value="EIS.jsp?action=main_graph&year=2013" selected>2013</option>
                  <option value="EIS.jsp?action=main_graph&year=2014" selected>2014</option>
                  <option value="EIS.jsp?action=main_graph&year=2015" selected>2015</option>
                </select>
                <input name="submit" type=submit style="font-family: Verdana, sans-serif; font-size: 11px;  8px;" value=Search>
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
