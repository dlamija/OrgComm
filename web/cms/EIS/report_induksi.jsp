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
	String staff = request.getParameter("staff");
	String staff_id = "";
	String staff_name = "";
	String dept_code = "";
	String dept_desc = "";
	String total_to ="";
	String sysdate_year ="";

//	int hr = 0;
//	int min = 0;
//	int total =0;

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
<form name="form1" method="post" action="">
  <TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="3" bgcolor="#CCCCCC">
    <tr bgcolor="#666666" valign="top" class="smallfont"> 
      <td colspan="2" CLASS="contentStrapColor"><span class="style2 style1"><b>Query 
        Subordinate </b></span></td>
    </tr>
    <tr bgcolor="#FFFFFF" valign="top" class="smallfont"> 
      <td  width = "17%" class="contentBgColor"><div align = "right">Staff Name 
          : </div></td>
      <td width = "83%" class="contentBgColor"><select name="staff" id="staff" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;" onChange = 'document.form1.action="EIS.jsp?action=report_induksi";document.form1.submit();'>
          <option value="">...</option>
          <%
	if (conn!=null)
	{
		String sql	= "SELECT SH_STAFF_ID,SM_STAFF_NAME FROM STAFF_HIERARCHY,STAFF_MAIN " +
                      " WHERE SM_STAFF_ID = SH_STAFF_ID " +
				      "AND SM_STAFF_STATUS='ACTIVE' " +
				      "AND SH_SYS_ID = 'ADM_AL'  " +
			 	      "AND SH_REPORT_TO = ? ";

		try
		{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString (1, session.getAttribute("staffid").toString());
			ResultSet rset = pstmt.executeQuery ();
			while (rset.next ())
			{
				if (request.getParameter("staff")!=null && request.getParameter("staff").compareTo(rset.getString(1))==0)
				{ 
%>
          <option value="<%=rset.getString(1)%>" selected><%=rset.getString(2)%></option>
          <% 
				}
				else
				{
%>
          <option value="<%=rset.getString(1)%>"><%=rset.getString(2)%></option>
          <% 
				}
			}
			rset.close ();
			pstmt.close ();
		}
		catch( Exception e )
		{ out.println ("Error during retrieving staff : " + e.toString()); }
	}
%>
        </select></td>
    </tr>
  </table>
  <% if (request.getParameter("staff")!= null){%>
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
	
	String sql=" SELECT SM_STAFF_NAME,TO_CHAR(SIH_APPLY_DATE, 'DD-MM-YYYY'), SIH_STATUS "+
			" FROM STAFF_MAIN, STAFF_INDUKSI_HEAD "+
			" WHERE SM_STAFF_ID=SIH_STAFF_ID "+
			" AND SIH_APPROVE_BY= '"+sid+"' "+
			" AND SIH_STAFF_ID='"+staff+"' "+
			" ORDER BY SIH_APPLY_DATE ";

				%><%//=sql%><%
	try
		{
		PreparedStatement pstmt=conn.prepareStatement(sql);
		ResultSet rset=pstmt.executeQuery();
		//if(rset.isBeforeFirst()){
		
		%>
  <TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="3" bgcolor="#CCCCCC">
    <tr bgcolor="#666666" valign="top" class="smallfont"> 
      <td colspan="3" CLASS="contentStrapColor" align="center"><span class="style2 style1"><b>Staff 
        Induction </b></span></td>
    </tr>
    <tr CELLSPACING="1" valign="top" bgcolor="#EEEEEE" class="smallbold"> 
      <td width="16%" class="contentBgColorAlternate"><div align="center"><b>Name</b></div></td>
      <td width="14%" class="contentBgColorAlternate"><div align="center"><b>Date 
          Apply </b></div></td>
      <td width="15%" class="contentBgColorAlternate"><div align="center"><b>Status</b></div></td>
    </tr>
    <%
		if(rset.isBeforeFirst())
		{
		
		while(rset.next()){

	  // hr += rset.getInt( 7 );
		//min += rset.getInt( 8 );

//	hr = hr + (min / 60);	min = min % 60;
	//total_to =((hr<10)?("0" + hr):("" + hr))+ ':' +((min<10)?("0" + min):("" + min));

		  %>
    <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
      <td class="contentBgColor"><div align="center"><%=rset.getString(1)%></div></td>
      <td class="contentBgColor"><div align="center"><%=rset.getString(2)%></div></td>
      <td class="contentBgColor"><div align="center"><%=rset.getString(3)%></div></td>
    </tr>
    <%}%>
    <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
      <td colspan="3" CLASS="contentBgColorAlternate" align="center"><b> </b> 
      </td>
    </tr>
  </table>
  <br>
  <%}else{%>
  <p> 
  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF">
    <tr> 
      <td colspan="11" class="contentBgColor">No Record Available </td>
    </tr>
  </table>
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
</body>
</html>
