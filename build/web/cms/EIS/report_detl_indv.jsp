<%@ page session="true" %>
<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="javax.naming.*" %>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>



<%	//Connection...
	Connection conn = null;
	String sid	= (String)session.getAttribute("staffid");
	String action		= request.getParameter("action");

	String staff_id = "";
	String staff_name = "";
	String dept_code = "";
	String dept_desc = "";
	String total_to ="";
	String sysdate_year ="";

	int hr = 0;
	int min = 0;
	int total =0;

 try
	{
		Context initCtx = new InitialContext();
		Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
		DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
		conn = ds.getConnection();
		
	}
	catch( Exception e )
	{ 
		out.println (e.toString()); 
	}
%>



<body>
<%
if ( conn!=null )
	{
	
	String sql="select TO_CHAR (SAH_DATE,'MON YYYY'),SAH_REF_ID, sah_status, to_char(SAH_DATE, 'DD-MON-YYYY'), to_char(SAH_TIME_FROM, 'HH24:MI'), to_char(SAH_TIME_TO, 'HH24:MI'), "+
			   " LPAD(TRUNC( (SAH_TIME_TO - SAH_TIME_FROM) * 24),2,'0') || ':' || LPAD(TRUNC(MOD( ((SAH_TIME_TO - SAH_TIME_FROM) * 24 * 60), 60 )),2,'0'), "+
			   " LPAD(TRUNC( (SAH_TIME_TO - SAH_TIME_FROM) * 24),'2','0'), "+
			   "TRUNC(MOD( ((SAH_TIME_TO - SAH_TIME_FROM) * 24 * 60), 60 )) TOT_MIN ,"+
			   " to_char(SAH_DATE_APPLY, 'DD-MON-YYYY') "+
			   "from staff_attendance_head "+
	           " where SAH_STAFF_ID='"+sid+"' and SAH_TYPE='TIMEOFF' and to_char(sah_date, 'YYYY') = '"+sysdate_year+"' "+
			   " and sah_status in ('APPLY','APPROVE') "+
				"ORDER BY SAH_DATE ";
	try
		{
		PreparedStatement pstmt=conn.prepareStatement(sql);
		ResultSet rset=pstmt.executeQuery();
		//if(rset.isBeforeFirst()){
		
		%>
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="3" bgcolor="#CCCCCC">
  <tr bgcolor="#FFFFFF" valign="top" class="smallfont"> 
    <td class="contentBgColor"><div align="right"><B>Month</B> &nbsp; 
        <select name="bulan" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;">
          <!---<option value="">...</option>--->
          <%
	if (conn!=null)
	{
/*		String sql	= "SELECT DISTINCT TO_CHAR (WOH_DATE_FROM,'MON YYYY'),TO_CHAR (WOH_DATE_FROM,'YYYY') "+
                      "FROM WORK_ORDER_HEAD,WORK_ORDER_DETL "+
				  	  "WHERE WOD_WORKORDER_ID = WOH_WORKORDER_ID "+
				      "AND WOD_STAFF_ID = ?  " +
				    //"AND WOH_STATUS = '"+status+"' "+
			 	      "ORDER BY TO_DATE (WOH_DATE_FROM,'MM/YYYY') DESC ";
*/
	/*	String sql	= "SELECT DISTINCT TO_CHAR (WOH_DATE_FROM,'MON YYYY') WOH_DATE_FROM, TO_CHAR (WOH_DATE_FROM,'MONTH YYYY') " +
                      "FROM WORK_ORDER_HEAD,WORK_ORDER_DETL " +
				      "WHERE WOD_WORKORDER_ID = WOH_WORKORDER_ID " +
				      "AND WOD_STAFF_ID = ?  " +
				    //"AND WOH_STATUS = '"+status+"' " +
			 	      "ORDER BY TO_DATE (WOH_DATE_FROM,'MON YYYY') DESC ";*/
					  
	     String sql="select TO_CHAR (SAH_DATE,'MON YYYY'),SAH_REF_ID, sah_status, to_char(SAH_DATE, 'MONTH YYYY'), "+
		            "to_char(SAH_TIME_FROM, 'HH24:MI'), to_char(SAH_TIME_TO, 'HH24:MI'), "+
       			    " LPAD(TRUNC( (SAH_TIME_TO - SAH_TIME_FROM) * 24),2,'0') || ':' || LPAD(TRUNC(MOD( ((SAH_TIME_TO - SAH_TIME_FROM) * 24 * 60), 60 )),2,'0'), "+
			        " LPAD(TRUNC( (SAH_TIME_TO - SAH_TIME_FROM) * 24),'2','0'), "+
			        "TRUNC(MOD( ((SAH_TIME_TO - SAH_TIME_FROM) * 24 * 60), 60 )) TOT_MIN ,"+
			        " to_char(SAH_DATE_APPLY, 'DD-MON-YYYY') "+
			        "from staff_attendance_head "+
	                " where SAH_STAFF_ID='"+sid+"' and SAH_TYPE='TIMEOFF' and to_char(sah_date, 'YYYY') = '"+sysdate_year+"' "+
			        " and sah_status in ('APPLY','APPROVE') "+
		            "ORDER BY TO_DATE (SAH_DATE,'MON YYYY') DESC";			 

		try
		{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString (1, session.getAttribute("staffid").toString());
			ResultSet rset = pstmt.executeQuery ();
			while (rset.next ())
			{
				if (request.getParameter("bulan")!=null && request.getParameter("bulan").compareTo(rset.getString(1))==0)
				{ 
%>
          <option value="<%=rset.getString(1)%>" selected><%=rset.getString(4)%></option>
          <% 
				}
				else
				{
%>
          <option value="<%=rset.getString(1)%>"><%=rset.getString(4)%></option>
          <% 
				}
			}
			rset.close ();
			pstmt.close ();
		}
		catch( Exception e )
		{ out.println ("Error during retrieving month : " + e.toString()); }
	}
%>
        </select>
        &nbsp; 
        <!---        
		<B>Status</B> : 
		<select name="status" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;">
			<option value="" selected>...</option>
			<option value="APPROVE">APPROVED</option>
			<option value="ENTRY">APPLY</option>
        </select>&nbsp;
---->
        <input name="Go" type="submit" id="Go" value="Go">
      </div></td>
  </tr>
</table>
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
<%
if (conn!=null)
	{
	String sql	= "SELECT SM_STAFF_ID, SM_STAFF_NAME, SM_DEPT_CODE, DM_DEPT_DESC " +
			"FROM STAFF_MAIN, DEPARTMENT_MAIN " +
			"WHERE SM_STAFF_ID = '" +sid+ "' AND SM_DEPT_CODE = DM_DEPT_CODE ";
	
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			staff_id = rset.getString (1);
			staff_name = rset.getString (2);
			dept_code = rset.getString (3);
			dept_desc = rset.getString (4);
			}
		pstmt.close ();
		rset.close ();
		}


	catch (SQLException e)
		{ out.println ("Error : " + e.toString () + "/n" + sql); }
	}	
%>
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="3" bgcolor="#CCCCCC">
  <tr bgcolor="#666666" valign="top" class="smallfont">
    <td colspan="2" CLASS="contentStrapColor"><span class="style2 style1"><b>Staff's Profile</b></span></td>
  </tr>
	<tr bgcolor="#FFFFFF" valign="top" class="smallfont">
    <td  width = "27%" class="contentBgColor"><div align = "right">Staff ID & Name : </div></td>
   <td width = "75%" class="contentBgColor"><%= staff_id %> - <%= staff_name %></td>
  </tr>
   <tr bgcolor="#FFFFFF" valign="top" class="smallfont">
    <td class="contentBgColor"><div align = "right">Department : </div></td>
   <td class="contentBgColor"><%= dept_code %> - <%=dept_desc %>
 </td>
  </tr>

</table><br>


<%
if ( conn!=null )
	{
	
	String sql="select SAH_REF_ID, sah_status, to_char(SAH_DATE, 'DD-MON-YYYY'), to_char(SAH_TIME_FROM, 'HH24:MI'),"+
	           " to_char(SAH_TIME_TO, 'HH24:MI'), "+
			   "LPAD(TRUNC( (SAH_TIME_TO - SAH_TIME_FROM) * 24),2,'0') || ':' || LPAD(TRUNC(MOD( ((SAH_TIME_TO - SAH_TIME_FROM) * 24 * 60), 60 )),2,'0'), "+
			   " LPAD(TRUNC( (SAH_TIME_TO - SAH_TIME_FROM) * 24),'2','0'), "+
			   "TRUNC(MOD( ((SAH_TIME_TO - SAH_TIME_FROM) * 24 * 60), 60 )) TOT_MIN ,"+
			   " to_char(SAH_DATE_APPLY, 'DD-MON-YYYY') "+
			   "from staff_attendance_head "+
	           " where SAH_STAFF_ID='"+sid+"' and SAH_TYPE='TIMEOFF' and to_char(sah_date, 'YYYY') = '"+sysdate_year+"' "+
			   " and sah_status in ('APPLY','APPROVE') "+
				"ORDER BY SAH_DATE ";
	try
		{
		PreparedStatement pstmt=conn.prepareStatement(sql);
		ResultSet rset=pstmt.executeQuery();
		//if(rset.isBeforeFirst()){
		
		%>
		

	<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="3" bgcolor="#CCCCCC">
  <tr bgcolor="#666666" valign="top" class="smallfont">
    <td colspan="7" CLASS="contentStrapColor" align="center"><span class="style2 style1"><b>Time Off Application</b></span></td>
  </tr>
		<tr CELLSPACING="1" valign="top" bgcolor="#EEEEEE" class="smallbold">
			<td width="10%" class="contentBgColorAlternate"><div align="center"><b>ID</b></div></td>
			<td width="10%" class="contentBgColorAlternate"><div align="center"><b>Status</b></div></td>
			<td width="20%" class="contentBgColorAlternate"><div align="center"><b>Date
			      Apply</b></div></td>
			<td width="20%" class="contentBgColorAlternate"><div align="center"><b>Date
			      Time Off</b></div></td>
			<td width="20%" class="contentBgColorAlternate"><div align="center"><b>Time From</b></div></td>
			<td width="20%" class="contentBgColorAlternate"><div align="center"><b>Time To</b></div></td>
			<td width="20%" class="contentBgColorAlternate"><div align="center"><b>Duration</b></div></td>
		</tr>
		
    <%
		if(rset.isBeforeFirst())
		{
		
		 while(rset.next()){

	    hr += rset.getInt( 7 );
		min += rset.getInt( 8 );

		hr = hr + (min / 60);	min = min % 60;
		total_to =((hr<10)?("0" + hr):("" + hr))+ ':' +((min<10)?("0" + min):("" + min));

		  %>

		<tr valign="top" bgcolor="#FFFFFF" class="smallfont">
			<td class="contentBgColor" align="center"><%=rset.getString(1)%></td>
			<td class="contentBgColor"><div align="center"><%=rset.getString(2)%></div></td>
			<td class="contentBgColor"><div align="center"><%=rset.getString(9)%></div></td>
			<td class="contentBgColor"><div align="center"><%=rset.getString(3)%></div></td>
			<td class="contentBgColor"><div align="center"><%=rset.getString(4)%></div></td>
			<td class="contentBgColor"><div align="center"><%=rset.getString(5)%></div></td>
			<td class="contentBgColor"><div align="center"><%=rset.getString(6)%></div></td>
		</tr>
			
		<%}%>
		<tr valign="top" bgcolor="#FFFFFF" class="smallfont">
    <td colspan="6" CLASS="contentBgColorAlternate" align="center"><b>Total Hours</b>
	</td>
    <td colspan="1" CLASS="contentBgColorAlternate" align="center"><b><%= total_to %></b>
	</td>
  </tr>
	
	</table>
	
	<br>
	<%}else{%><p>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF">
	 <tr>
	 	<td colspan="11" class="contentBgColor">No Record Available </td>
	 </tr>
	</table>


	</p>
	
		<%}
			rset.close();
			pstmt.close();
			}
		catch( Exception e )
			{ out.println(e.toString());}
		}


conn.close();
%>

<% conn.close(); %>

</body>
</html>
