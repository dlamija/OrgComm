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



<html>
<head>
<title>Induction Course System - Approval</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../css/default.css" rel="stylesheet" type="text/css">
</head>

<script type="text/javascript">
function ValidateFields()
{
  if (document.frm2.reason.value=='')
   {
	 alert("Please Insert Your Reason For Reject the Application");
   	 return false;	
   } 
   if (document.frm2.stat.value==0)
   {
	 alert("Please Select Approve or Reject the Application");
   	 return false;	
   }    				 		 
}
</script>

<body>
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="3" class="contentBgColorAlternate">

  <TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  
  <TD CLASS="contentStrapColor" COLSPAN="8" ALIGN="MIDDLE" VALIGN="TOP">
    
	<b>Induction Course Application Status</b>
	
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
	  
	  <td class="contentBgColor" align="center"><a href="../induction/induction.jsp?action=approve&ref_id=<%=refid%>&staff_id=<%=staff_id%>">Approval</a></td>

<%}%>     
	  
  </tr>

<%			   
 			   }
%>
<tr> 
      <!--td colspan="8" class="contentBgColor" align="right">
	  <input type="submit" name="Submit" value="Approve">
	  <input type="submit" name="Submit" value="Reject">
	  </td-->
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
	catch( Exception e )
	{ out.println ("Error Syntax :" + e.toString() + "/n" + sql ); }
	}

%>  
 
</TABLE>

<%if (conn!=null&& referid != null){%>
  

<form name="frm2" action="../induction/induction.jsp?action=approvesave" method="post">

<input type="hidden" name="refid" value="<%=refid%>">
<%
// View apply
String staff_id2 = request.getParameter("staff_id");
if (conn!=null)
	
	{
			 
	String sqld = "SELECT SIH_INDUKSI_REF_ID,SIH_STAFF_ID,SM_STAFF_NAME,ITH_TRAINING_TITLE,ITH_TRAINING_DESC,TO_CHAR(ITH_DATE_FROM, 'DD/MM/YY'),TO_CHAR(ITH_DATE_TO, 'DD/MM/YY'),TO_CHAR(SIH_APPLY_DATE, 'DD/MM/YY'),SIH_STATUS "+
				 "FROM STAFF_INDUKSI_HEAD,STAFF_MAIN,INDUKSI_TRAINING_HEAD " +
				 "WHERE SIH_STAFF_ID = SM_STAFF_ID "+
				 "AND SIH_INDUKSI_REF_ID = ITH_REF_ID "+
				 "AND SIH_STAFF_ID= '"+staff_id2+"' "+
				  "AND SIH_STAFF_ID IN " +
				 "(SELECT SH_STAFF_ID FROM STAFF_HIERARCHY WHERE SH_SYS_ID = 'ADM_AL' " +
				 "AND SH_REPORT_TO = ?) " +
				 "AND SIH_STATUS= 'APPLY' "+
				 "ORDER BY SIH_INDUKSI_REF_ID ";
				 
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sqld);
		pstmt.setString (1, session.getAttribute("staffid").toString());
		ResultSet rset = pstmt.executeQuery ();
		if (rset.isBeforeFirst())
			{
%>	
  

 <%
			while (rset.next())
				{
					bil = rset.getRow();
					refidd			= rset.getString(1);
					staff_idd		= rset.getString(2);
					staff_named		= rset.getString(3);
					nama_kursusd 	= rset.getString(4);
					kursus_descd	= rset.getString(5);
					tarikh_mulad	= rset.getString(6);
					tarikh_akhird 	= rset.getString(7);
					tarikh_applyd 	= rset.getString(8);
					statusd 		= rset.getString(9);
					
%> 

<%			   
 			   }
%>
 


 <% }
		rset.close ();
		pstmt.close ();
	}
	catch( Exception e )
	{ out.println ("Error Syntax :" + e.toString() + "/n" + sqld ); }
	}

%>
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="3">

  <TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  
  <TD CLASS="contentStrapColor" COLSPAN="4" align="left" VALIGN="TOP">
    
	<b>A. Staff Information</b>
	
  </td>

  </tr>
	
	<tr bgcolor="#FFFFFF" valign="top" class="smallfont">
      
	  <td class="contentBgColor" width="30%" align="right">Staff ID :&nbsp;</td>
   
   <td class="contentBgColor"><%= staff_idd %>&nbsp;</td>
   
   <input type="hidden" name="staff_id" value="<%=staff_idd%>">
  
  </tr>
   
   <tr bgcolor="#FFFFFF" valign="top" class="smallfont">
    
	<td class="contentBgColor" align="right">Name :&nbsp;</td>
    
	<td class="contentBgColor"><%= staff_named %>&nbsp;</td>
	 
	 <input type="hidden" name="staff_name" value="<%=staff_named%>">
  
  </tr>
            
  </table>
    
  <TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="3">

  <TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  
  <TD CLASS="contentStrapColor" COLSPAN="4" ALIGN="LEFT" VALIGN="TOP">
    
	<b>B. Induction Course Information </b>
	
  </td>

  </tr>
	   
   <tr bgcolor="#FFFFFF" valign="top" class="smallfont">
    
	<td class="contentBgColor" width="30%" align="right">Course Name :&nbsp;</td>
    
	<td class="contentBgColor"><%=nama_kursusd%></td>
	 	 
  </tr>
  
  <tr bgcolor="#FFFFFF" valign="top" class="smallfont">
    
	<td class="contentBgColor" align="right">Course Description :&nbsp;</td>
    
	<td class="contentBgColor"><%=kursus_descd%></td>
		  
  </tr>
    
  <tr bgcolor="#FFFFFF" valign="top" class="smallfont">
    
	<td class="contentBgColor" align="right">Apply Date :&nbsp;</td>
    
	<td class="contentBgColor"><%=tarikh_applyd%>
	
	</td>
	
  </tr>  
  
  <tr bgcolor="#FFFFFF" valign="top" class="smallfont">
    
	<td class="contentBgColor" align="right">From Date :&nbsp;</td>
    
	<td class="contentBgColor"><%=tarikh_mulad%>
	
	</td>
	
  </tr>
      
  <tr bgcolor="#FFFFFF" valign="top" class="smallfont">
    
	<td class="contentBgColor" align="right">To Date :&nbsp;</td>
    
	<td class="contentBgColor"><%=tarikh_akhird%>
			
	</td>
		  
  </tr>
    
  </table>
  
  <TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="3">

  <TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  
  <TD CLASS="contentStrapColor" COLSPAN="4" ALIGN="LEFT" VALIGN="TOP">
    
	<b>C. Head Of Department / Approver </b>
	
  </td>

  </tr>
  
  <tr bgcolor="#FFFFFF" valign="top" class="smallfont">
    
	<td height="25" class="contentBgColor" width="30%" align="right">Approval :&nbsp;</td>
    
	<td class="contentBgColor"><select name="stat" onChange='document.frm2.action="induction.jsp?action=approve&ref_id=<%=refid%>";document.frm2.submit();'>
	<% for (int a=0;a<stat.length;a++)
		{
		if (request.getParameter("stat")!=null && request.getParameter("stat").toString().compareTo(stat[a])==0)
			{ %><option value="<%=stat[a]%>" selected><%=stat[a]%></option><% }
		else
			{ %><option value="<%=stat[a]%>"><%=stat[a]%></option><% }
		} %>
		
         </select>	
	</td>
		   
  </tr>
  <%if(request.getParameter("stat")!=null && request.getParameter("stat").equals("REJECT")){%>
  <tr bgcolor="#FFFFFF" valign="top" class="smallfont">
    
	<td class="contentBgColor" align="right">Reason For Reject :&nbsp;</td>
    
	<td class="contentBgColor"><textarea name="reason" rows="6" cols="35"></textarea></td>
		  
  </tr>
  <%}%>    
  
  <TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  
  <TD CLASS="contentBgColor" COLSPAN="4" ALIGN="CENTER" VALIGN="TOP">
    
	<input type="submit" value="Save" onClick="return ValidateFields()">
	
	&nbsp;<input type="reset" value="Reset">
	
  </td>

  </tr>
    
</table>

<%}%>

</form>

<p>&nbsp;</p>
<% conn.close ();%>
<% con_tms.close ();%>
</body>
</html>
