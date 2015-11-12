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
                <%
if (conn!=null)
	{
	String sql ="SELECT TO_CHAR(SAH_DATE,'MM/YYYY') SAH_DATE, TO_CHAR(SAH_DATE,'MONTH YYYY'),SAH_REF_ID,SAH_STAFF_ID,SM_STAFF_NAME,  " +
				 "TO_CHAR(SAH_TIME_FROM,'HH24:MI'),TO_CHAR(SAH_TIME_TO,'HH24:MI'),SAH_REASON " +
				 "FROM STAFF_ATTENDANCE_HEAD,STAFF_MAIN " +
				 "WHERE SM_STAFF_ID = SAH_STAFF_ID " +
				// "AND SM_STAFF_ID = '"+rset.getString(8)+"' " +
				 "AND SAH_TYPE = 'TIMEOFF' " +
				 "AND SAH_STATUS = 'APPROVE' " +
				 "AND SAH_APPROVE_BY = '"+sid+"' " +
				 "ORDER BY SAH_DATE desc,SAH_STAFF_ID";
				%>
                <%//=sql%>
                <%
		   	try
		{
		PreparedStatement pstmt1=conn.prepareStatement(sql);
		ResultSet rset1=pstmt1.executeQuery();
%>
                <select name="month">
                  <%		while (rset1.next ())
			{
			//if (rset.isFirst())
			//month = rset.getString(1);
%>
                  <option value="timeoffApplication.jsp?action=query_surbodinate&month=<%=rset1.getString(1)%>"><%=rset1.getString(2)%></option>
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
