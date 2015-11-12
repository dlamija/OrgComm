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
String ref=request.getParameter("ref");

//String month = request.getParameter("month");
String tahun=request.getParameter("month");
%><%//=tahun%><%
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
	{ out.println ("Error 1 : " + e.toString ()); }


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

	var ReportWin;
	function printReport(tahun) 
	{
		if (ReportWin && !ReportWin.closed) ReportWin.close();			
			ReportWin = window.open('printReport.jsp?action=print_attendance&Month='+tahun, 'printReport', 'width=800,height=600,resizable=yes,scrollbars=1');
		
		if (ReportWin && !ReportWin.closed) ReportWin.focus();
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
.style2 {color: #000000}
-->
    </style>
</head>
<body>









<p>

  <%@include file="include/date.jsp"%>
  <%@include file="include/sem.jsp"%>
  
</p>

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
      <td height="65" valign="top" width="911"><form action="EIS.jsp" method=post>
          <p>
            <input type=hidden name=action value=graphatt>
            <input type=hidden name=dept value="<%=ref%>">
          </p>
          <p>&nbsp; </p>
          <table width="100%" border="0" cellpadding="3" cellspacing="0">
            <tr> 
              <td width="44%"><div align="right"><span CLASS="contentTitleFont style30 style2"><font size="2">Month-Year</font></span></div></td>
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
              
                <input name="submit" type=submit style="font-family: Verdana, sans-serif; font-size: 11px;  8px;" value="Go"> <a href="javascript:printReport('<%=tahun%>')" onMouseOver="window.status='Print';return true;">
		<IMG SRC="images/system/ic_printer.gif" ALT="Print" border="0"><span class="style2">Printable</span></a>
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
<p>&nbsp;</p>

<table width="98%" height="73" border="0" align="center" cellpadding="0" cellspacing="0">
  <tbody> 
  <!---  <tr>
      <td height="16" width="16"><img src="cms/sktnew/line/search_curve_leftop.gif" height="16" width="16" /></td>
      <td background="cms/sktnew/line/search_line_top.gif" height="16" width="1173"></td>
      <td height="16" width="16"><img src="cms/sktnew/line/search_curve_rightop.gif" height="16" width="16" /></td>
    </tr>
    <tr>
      <td background="cms/sktnew/line/search_line_left.gif" height="65" width="16"></td> --->
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
	
			
		String sql_graph= "SELECT SM_STAFF_ID, COUNT(*) FROM "+
		" STAFF_MAIN,STAFF_ATTENDANCE_HEAD,STAFF_ATTENDANCE_SETUP,staff_hierarchy"+
		" WHERE SM_STAFF_ID = sah_staff_id"+
		" AND SM_STAFF_ID=SAS_STAFF_ID"+
		" and SM_STAFF_STATUS='ACTIVE'"+
		" AND SM_JOB_STATUS IN ('TETAP','TPENCEN','TPERCUBAAN','SEMENTARA','KONTRAK','PINJAMAN','SAMBILAN')"+
		" AND SAS_FLEXI_HOUR='N'"+
		" AND TO_CHAR(SAH_DATE,'MONTH YYYY')= '"+tahun+"'"+
		" and sm_join_date <= last_day(to_date('"+tahun+"', 'mmyyyy'))"+
		" AND TO_CHAR(SAH_TIME_FROM,'HH24:MI:SS') >='08:01:00'"+
		" and sah_type IN ('ATTENDANCE','SHIFT')"+
		" and sh_staff_id=sm_staff_id and sh_report_to='"+sid+"'"+
		"and sah_date is not null "+
		" and not exists"+
   			" ( "+
  			" select 1"+
  			" from staff_leave_detl"+
  			" where SAH_DATE between sld_date_from and SLD_date_to"+
  			" and sld_staff_id=SAH_STAFF_ID"+
  			" ) "+
			" and not exists"+
			" ( "+
			" select 1 from calendar_main"+
			" where sah_date=cm_date"+
 			" ) "+
			" GROUP BY SM_STAFF_ID"+
			" ORDER BY COUNT (*) DESC";

	
						%><%
						try{
							Statement stmt = conn.createStatement();
							ResultSet rset = stmt.executeQuery( sql_graph);
							if (rset.isBeforeFirst()) { 

	
	strXML = "<graph caption='TITLE: STAFF ATTENDANCE - "+tahun+"' xAxisName='Staff ID' yAxisName='Day(s)' showValues='1' decimalPrecision='0' formatNumberScale='0' showBorder='1'>";
	
   while( rset.next() ){ 
   
  strXML = strXML + "<set  name='" + rset.getString( 1 ) + "' value='" + rset.getString( 2 ) + "'   color='F6BD0F' />  ";  //name='" + rset.getString( 4 ) + "'

  	}
	strXML = strXML + "</graph>";
	 	}
							rset.close();
							stmt.close();
						}catch( SQLException sqle )
						{
							out.println ("Error sql : " + sqle.toString ());
						}
						
	//Create the chart - Pie 3D Chart with data from strXML
	String chartCode= createChart("cms/EIS/picchart/FCF_Column2D.swf", "", strXML, "EIS", 700, 350, false, false);
	
%>
        <%=chartCode%></p>
        
      <p>
        <%
if (conn!=null)
	{
    String sql_query  = "SELECT sm_staff_name, COUNT(*),SM_STAFF_ID "+ 
		" FROM STAFF_MAIN,STAFF_ATTENDANCE_HEAD,STAFF_ATTENDANCE_SETUP,staff_hierarchy"+
		" WHERE SM_STAFF_ID = sah_staff_id"+
		" AND SM_STAFF_ID=SAS_STAFF_ID"+
		" and SM_STAFF_STATUS='ACTIVE'"+
		" AND SM_JOB_STATUS IN ('TETAP','TPENCEN','TPERCUBAAN','SEMENTARA','KONTRAK','PINJAMAN','SAMBILAN')"+
		" AND SAS_FLEXI_HOUR='N'"+
		" AND TO_CHAR(SAH_DATE,'MONTH YYYY')= '"+tahun+"'"+
		" and sm_join_date <= last_day(to_date('"+tahun+"' , 'mmyyyy'))"+
		" AND TO_CHAR(SAH_TIME_FROM,'HH24:MI:SS') >='08:01:00'"+
		" and sah_type IN ('ATTENDANCE','SHIFT')"+
		" and sh_staff_id=sm_staff_id and sh_report_to='"+sid+"'"+
		" and sah_date is not null "+
		" and not exists"+
   			" ( "+
  			" select 1"+
  			" from staff_leave_detl"+
  			" where SAH_DATE between sld_date_from and SLD_date_to"+
  			" and sld_staff_id=SAH_STAFF_ID"+
  			" ) "+
			" and not exists"+
			" ( "+
			" select 1 from calendar_main"+
			" where sah_date=cm_date"+
 			" ) "+
			" GROUP BY SM_STAFF_NAME,SM_STAFF_ID "+
			" ORDER BY COUNT (*) DESC";
		

		try
			{
			PreparedStatement pstmt = conn.prepareStatement(sql_query);
			//pstmt.setString (1, session.getAttribute("staffid").toString());

			ResultSet rset = pstmt.executeQuery ();
			if (rset.isBeforeFirst ()) { %>
      <TABLE WIDTH="100%" BORDER="1" CELLPADDING="3" CELLSPACING="0" bordercolor="#EAEAEA">
          <tr valign="top" bgcolor="#EEEEEE" class="smallbold">
            <td width="4%" CLASS="contentBgColorAlternate"><strong>No.</strong></td>
            
          <td width="68%" CLASS="contentBgColorAlternate"><strong>Staff's ID
              - Staff's Name </strong></td>
            <td width="16%" CLASS="contentBgColorAlternate"><div align="center"><strong>Day(s)</strong></div></td>
          </tr>
          <%   
		  int jum= 0;
		  while (rset.next ()) {
		   jum += rset.getInt( 2 );
		   %>
          <tr valign="top" bgcolor="#FFFFFF" class="smallfont">
            <td class = "contentBgColor"><%=rset.getRow()%></td>
            <td class = "contentBgColor"><p class="style17"><%=rset.getString(3)%> - <%=rset.getString(1)%></p></td>
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
  { out.println ("Error : " + e.toString ());}
 }
}
%>
</p>
       
</body>
</html>

