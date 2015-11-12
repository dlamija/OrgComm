<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ include file="/includes/import.jsp" %>
<jsp:useBean id="validator" class="cms.staff.StaffValidator" scope="request" />


<%	//Connection...
	Connection conn = null, con_tms= null;
	String sid= (String)session.getAttribute("staffid");
	DBConnectionPool dbPool = null;
	String action = request.getParameter("action");
	
	String referid	  = request.getParameter("ref_id");	
	String [] stat = { "...", "APPROVE", "REJECT" };
	String reason = request.getParameter("reason");
	
	String refid2 = request.getParameter("refid2");
	String refid = "";
	String staff_id = request.getParameter("staff_id");
	String staff_name = "";
	String nama_kursus = "";
	String kursus_desc="";
	String tarikh_mula = "";
	String tarikh_akhir = "";
	String tarikh_apply = "";
	String status = "";
	String refidd = "";
	String staff_idd = "";
	String staff_named = "";
	String nama_kursusd = "";
	String kursus_descd="";
	String tarikh_mulad = "";
	String tarikh_akhird = "";
	String tarikh_applyd = "";
	String statusd = "";
	int bil=0;
	
	 try
	{
		Context initCtx = new InitialContext();
		Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
		DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
		conn = ds.getConnection();
		validator.setDBConnection (conn);
		dbPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
		con_tms = dbPool.getConnection();
		
	}
	catch( Exception e )
	{ 
		out.println (e.toString()); 
	}
%>

<%
if (conn!=null)
	{
	String sql = "SELECT ITH_REF_ID from induksi_training_head "+
				" where ITH_CLOSING_APPLY_DATE >= sysdate ";

	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			refid2 = rset.getString (1);
			}
		pstmt.close ();
		rset.close ();
		}
	catch (SQLException e)
		{ out.println ("Error count: " + e.toString ()); }
	finally {
  try {
      if (conn != null) 
	  conn.close();    // Close the connection no matter what
  }
  catch (Exception e) { }
	}
	}
%>

<html>
<head>
<title>Induction Course System - Approval</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../css/default.css" rel="stylesheet" type="text/css">
</head>

<script type="text/javascript">
function ValidateFields()
{
   if (document.frm2.staff_id.checked == false )
   {
	 alert("Please tick the checkboxes");
   	return false;	
   }    				 		 
	if (document.frm2.status.value == '')
	{
	alert("Please Select Status");
	return false;
	}
  //if (document.frm2.reason.value=='')
   //{
	// alert("Please Insert Your Reason For Reject the Application");
   	// return false;	
   //}
   //for (counter = 0; counter < document.frm2.staff_id.length; counter++)
	//{
 		//if (document.frm2.staff_id[counter].checked)
		//{ checkbox_choices = checkbox_choices + 1; }

		//}

		
		//if (checkbox_choices < 1 )
		//{
		//alert("Please make your selections. No checkboxes entered so far.")
		//return (false);
		//}
	//}
}
</script>

<script type="text/javascript">

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

<body>
<form action="../induction/induction.jsp" method="get" name="frm2">
<input type="hidden" name="action" value="approvesave">

<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="3" class="contentBgColorAlternate">

  <TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  
  <TD CLASS="contentStrapColor" COLSPAN="8" ALIGN="MIDDLE" VALIGN="TOP">
    
	<b>Induction Course Application Status </b>
</td>

  </tr>
  
  <TR VALIGN="TOP" BGCOLOR="#FFFFFF">
  
  <TD CLASS="contentBgColor" COLSPAN="8" ALIGN="MIDDLE" VALIGN="TOP">
    
	<br>
	
  </td>

  </tr>
  
<%
// View apply
if (conn!=null)
	{
			 
	String sql = "SELECT SIH_INDUKSI_REF_ID,SIH_STAFF_ID,SM_STAFF_NAME,ITH_TRAINING_TITLE,ITH_TRAINING_DESC,TO_CHAR(ITH_DATE_FROM, 'DD/MM/YY'),TO_CHAR(ITH_DATE_TO, 'DD/MM/YY'),TO_CHAR(SIH_APPLY_DATE, 'DD/MM/YY'),SIH_STATUS "+
				 "FROM STAFF_INDUKSI_HEAD,STAFF_MAIN,INDUKSI_TRAINING_HEAD " +
				 "WHERE SIH_STAFF_ID = SM_STAFF_ID "+
				 "AND SIH_INDUKSI_REF_ID = ITH_REF_ID "+
				 //"AND SIH_STAFF_ID= '"+sid+"' "+
				  "AND SIH_STAFF_ID IN " +
				 "(SELECT SH_STAFF_ID FROM STAFF_HIERARCHY WHERE SH_SYS_ID = 'ADM_AL' " +
				 "AND SH_REPORT_TO = ?) " +
				 "AND SIH_STATUS= 'APPLY' "+
				 "ORDER BY SIH_INDUKSI_REF_ID ";
				 
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString (1, session.getAttribute("staffid").toString());
		ResultSet rset = pstmt.executeQuery ();
		if (rset.isBeforeFirst())
			{
%>	

  <tr bgcolor="#FFFFFF" valign="top" class="smallfont">
  
      <td class="contentBgColor" align="center" >&nbsp;</td>
	  
	  <td class="contentBgColor" align="center" width="25%"><b>ID & Name</b>&nbsp;</td>	
      
	  <td class="contentBgColor" align="center" width="25%"><b>Induction Name</b>&nbsp;</td>
   
  	  <td class="contentBgColor" align="center"><b>From Date</b>&nbsp;</td>
      
      <td class="contentBgColor" align="center"><b>To Date</b>&nbsp;</td>
      
	  <td class="contentBgColor" align="center"><b>Apply Date</b>&nbsp;</td>
	 	   
	  <td class="contentBgColor" align="center">&nbsp;</td>
      
  </tr>

 <%
			while (rset.next())
				{
					bil = rset.getRow();
					refid 			= rset.getString(1);
					staff_id		= rset.getString(2);
					staff_name		= rset.getString(3);
					nama_kursus 	= rset.getString(4);
					kursus_desc		= rset.getString(5);
					tarikh_mula 	= rset.getString(6);
					tarikh_akhir 	= rset.getString(7);
					tarikh_apply 	= rset.getString(8);
					status 			= rset.getString(9);
					
%> 

  <tr bgcolor="#FFFFFF" valign="top" class="smallfont">
    
      <td class="contentBgColor"><%=bil%></td>
	  
	  <td class="contentBgColor"><%=staff_id%>-<%=staff_name%></td>
	  
	  <td class="contentBgColor" width="25%"><%=nama_kursus%></td>
   
  	  <td class="contentBgColor" align="center"><%=tarikh_mula%></td>
      
      <td class="contentBgColor" align="center"><%=tarikh_akhir%></td>
      
	  <td class="contentBgColor" align="center"><%=tarikh_apply%></td>
	  	  	  
<%if (status.equals("APPLY")) {%>
	  
	  <td class="contentBgColor" align="center"><input type="checkbox" name="staff_id" id="staff_id" value="<%=staff_id%>"></td>
	  <!--<td class="contentBgColor" align="center"><a href="induction.jsp?action=approve&ref_id=<--%=refid%>&staff_id=<--%=staff_id%>">Approval</a></td>-->

<%}%>     
	  
  </tr>

<%			   
 			   }
%>
<tr> 
      <td colspan="8" class="contentBgColor" align="right">
	  Please select status : <strong><select name="status">
		          <option value="">...</option>
		          <option value="APPROVE">Approve</option>
		          <option value="REJECT">Reject</option>
	            </select></strong><br>
			    if reject(kindly, please state your reason): 
			<!--<input type="submit" name="Submit" value="Approve">-->
			
			<Textarea name="reason" cols="30" rows="2"></Textarea>
			      </strong></p>
			  <p align="right">
		<input name="Check All" type="button" value="Check All Staff" onClick="javascript:checkAll(document.frm2.staff_id)" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;  font-weight: bold">
    	<input name="Uncheck All" type="button" value="Uncheck all Staff" onClick="javascript:uncheckAll(document.frm2.staff_id)" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;  font-weight: bold">
		<input type="submit" value="Submit" onClick="return ValidateFields()" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;  font-weight: bold">&nbsp;
		    </p>
	  <!--input type="submit" name="Submit" value="Approve">
	  <input type="submit" name="Submit" value="Reject"-->
	  </td>
 </tr> 

<%}	else{ %>  
  
  <TR VALIGN="TOP" BGCOLOR="#FFFFFF">
  
  <TD CLASS="contentBgColor" COLSPAN="8" ALIGN="MIDDLE" VALIGN="TOP">
    
	<b>No Induction course application need to be approved</b>
	
  </td>

  </tr>
  
  <TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  
  <TD CLASS="contentBgColor" COLSPAN="8" ALIGN="MIDDLE" VALIGN="TOP">
    
	<br>
	
  </td>

  </tr>
 
 <% }
		rset.close ();
		pstmt.close ();
	}
	catch (SQLException e)
		{ out.println ("Error count: " + e.toString ()); }
	finally {
  try {
      if (conn != null) 
	  conn.close();    // Close the connection no matter what
  }
  catch (Exception e) { }
	}
	}
	//catch( Exception e )
	//{ out.println ("Error Syntax :" + e.toString() + "/n" + sql ); }
//	}

%>  
 
</TABLE>

</form>
<% conn.close ();%>
<% con_tms.close ();%>
</body>
</html>
