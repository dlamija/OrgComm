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

<%@ include file="Includes/Charts.jsp"%>


<%
Connection conn = null;



String sid= (String)session.getAttribute("staffid");
String id_sub = request.getParameter("ls_sub");

String month = request.getParameter("month");
String tahun=month.substring(35);
%><%=tahun%><%
String sem = request.getParameter("sem");
String level = request.getParameter("level");


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

<SCRIPT LANGUAGE="JavaScript" SRC="cms/EIS/picchart/Charts.js"></SCRIPT>
    <style type="text/css">
<!--
.style1 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-weight: bold;
	font-size: 12px;
}
-->
    </style>
</head>
<body>









<p> 
  <%@include file="include/date.jsp"%>
  <%@include file="include/sem.jsp"%>
</p>
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
      <td height="65" valign="top" width="1173"><table width="100%" border="0" cellpadding="3" cellspacing="0">
          <tr>
            <td colspan="3" bgcolor="#FFCC00"><span class="style1">General Information</span></td>
          </tr>
          <tr>
            
          <td width="43%"><strong>Year</strong></td>
            <td width="5%">:</td>
            <td width="52%"><span class="style1"><%=tahun%></span></td>
          </tr>
    
           
        </table>
        <p class="style1">&nbsp;</p>
        <p>
          <% 
	
	
	String strXML="";
	
	
				
			String sql_graph= " SELECT SM_STAFF_NAME,COUNT (*) "+
					" FROM WORK_ORDER_DETL,STAFF_MAIN,WORK_ORDER_HEAD "+
					" WHERE WOD_STAFF_ID = SM_STAFF_ID "+
					" AND WOD_WORKORDER_ID = WOH_WORKORDER_ID "+
					" AND TO_CHAR(WOd_DATE_FROM,'MONTH YYYY')='"+tahun+"' "+
					" and WOH_APPROVE_BY = '"+sid+"' "+
					" group by sm_staff_name ";
								%><%//=sql_graph%><%
						
						try{
							Statement stmt = conn.createStatement();
							ResultSet rset = stmt.executeQuery( sql_graph);
							if (rset.isBeforeFirst()) { 

	
	//strXML = "<chart caption='Assessment' xAxisName='Year' yAxisName='Mark' showValues='1' decimals='2' formatNumberScale='0' chartRightMargin='30' showBorder='1'>";
	strXML = "<graph caption='Title: List of Staff Workorder on "+tahun+"' xAxisName='Status' yAxisName='Count' showValues='1' decimalPrecision='0' formatNumberScale='0' showBorder='1'>";
	
  // int cnt = 0;
   while( rset.next() ){ 
   
  // cnt++;
  strXML = strXML + "<set  value='" + rset.getString( 2 ) + "'   color='F6BD0F'/>  ";  //name='" + rset.getString( 4 ) + "'

  //strXML = strXML + "<set   color='8BBA00'/> ";
  	}
//	strXML = strXML + "<set   color='8BBA00'/> ";
	strXML = strXML + "</graph>";
	 	}
							rset.close();
							stmt.close();
						}catch( SQLException sqle ){
						}
						
	//Create the chart - Pie 3D Chart with data from strXML
	String chartCode= createChart("cms/EIS/picchart/FCF_Column3D.swf", "", strXML, "EIS", 700, 350, false, false);
	
	//String chartCode2= createChart("cms/StaffAssessment/FusionCharts/FCF_Pie3D.swf", "", strXML, "Assessment", 600, 350, false, false);
	//var chart = new FusionCharts("../Charts/Bar2D.swf", "ChartId", "300", "350", "0", "0");
%>
        <%=chartCode%></p>
        <p><%
if (conn!=null)
	{
   //String sql_query	=  	"select COUNT (distinct sr_subject_code),sr_subject_code,SM_DESC "+
     //                   "from cmsadmin.subject_registration a, cmsadmin.subject_main b, semester_main c "+
       //                 "where a.sr_subject_code=b.sm_code and a.sr_semester_code like '"+sem+"%' and b.sm_faculty='"+dept+"' "+
        //                "and a.sr_semester_code=c.sm_semester_code "+
           //             "GROUP BY sr_subject_code,SM_DESC "+
			//			 "order by COUNT(sr_subject_code) desc ";


      String sql_query  = " SELECT SM_STAFF_NAME,COUNT (*) "+
					" FROM WORK_ORDER_DETL,STAFF_MAIN,WORK_ORDER_HEAD "+
					" WHERE WOD_STAFF_ID = SM_STAFF_ID "+
					" AND WOD_WORKORDER_ID = WOH_WORKORDER_ID "+
					" AND TO_CHAR(WOd_DATE_FROM,'MONTH YYYY')='"+tahun+"' "+
					" and WOH_APPROVE_BY = '"+sid+"' "+
					" group by sm_staff_name ";
					
%><%//=sql_query%><%
		try
			{
			PreparedStatement pstmt = conn.prepareStatement(sql_query);
			//pstmt.setString (1, session.getAttribute("staffid").toString());

			ResultSet rset = pstmt.executeQuery ();
			if (rset.isBeforeFirst ()) { %>
        <TABLE WIDTH="100%" BORDER="1" CELLPADDING="3" CELLSPACING="0" bordercolor="#EAEAEA">
          <tr valign="top" bgcolor="#EEEEEE" class="smallbold">
            <td width="4%" CLASS="contentBgColorAlternate"><strong>No.</strong></td>
            
          <td width="68%" CLASS="contentBgColorAlternate"><strong>List of Staff 
            Workorder</strong></td>
            <td width="16%" CLASS="contentBgColorAlternate"><div align="center"><strong>Count</strong></div></td>
          </tr>
          <%   
		  int jum= 0;
		  while (rset.next ()) {
		   jum += rset.getInt( 2 );
		   %>
          <tr valign="top" bgcolor="#FFFFFF" class="smallfont">
            <td class = "contentBgColor"><%=rset.getRow()%></td>
            <td class = "contentBgColor"><p class="style17"><%=rset.getString(1)%></p></td>
            <td class = "contentBgColor"><div align="center"><span class="style17"><%=rset.getString(2)%></span></div></td>
            <% } %>
          <tr valign="top" bgcolor="#FFFFFF" class="smallfont">
            <td class = "contentBgColor">&nbsp;</td>
            <td class = "contentBgColor">&nbsp;</td>
            <td class = "contentBgColor"><div align="center"><strong><%=jum%>&nbsp;</strong></div></td>
          </table>
<table width="100%"  border="0" cellpadding="3" cellspacing="0" bordercolor="#CCCCCC">
            <tr class="smallfont">
              <td class = "contentBgColor">              </td>
            </tr>
        </table>

          <%  } else { %>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFF">
          <tr>
            <td colspan="11"><font color="red" size="1" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;">No record found!</font></td>
          </tr>
        </table>
        <p>
  <% }

			rset.close ();
			pstmt.close ();
			}
	catch( Exception e )
		{ out.println (e.toString()); }
finally {
  try {
      if (conn != null) 
	  conn.close();    // Close the connection no matter what
  }
  catch (Exception e) 
  { out.println ("Error 1: " + e.toString ());}
 }
}

conn.close ();
%>
</p>
       
</body>
</html>
<% conn.close(); %>
