<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.util.*" %>
<%@ include file="/includes/import.jsp" %>
<% 
String ip="";
Connection conn = null;

String sid 		= (String) TvoContextManager.getSessionAttribute(request,"Login.CMSID");
String assessment_grouping="";
String year_sah="";
String staff = request.getParameter("staff");
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

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../css/default.css" rel="stylesheet" type="text/css">
</head>


 
 
 <%
if (conn!=null)
	{
	String sqlq	= " SELECT SS_ASSESSMENT_CATEGORY "+
				" FROM service_scheme, staff_main "+
				" WHERE SS_SERVICE_CODE=sm_job_code "+
				" AND SM_STAFF_ID='"+sid+"' ";
	
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sqlq);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			assessment_grouping = rset.getString (1);
			}
		pstmt.close ();
		rset.close ();
		}


	catch (SQLException e)
		{ out.println ("Error : " + e.toString () + "/n" + sqlq); }
	}	
%>

<body>
<p>&nbsp;</p><form name="form1" method="post" action="">
  <p>&nbsp;</p>
  <TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="3" bgcolor="#CCCCCC">
    <tr bgcolor="#666666" valign="top" class="smallfont"> 
      <td colspan="2" CLASS="contentStrapColor"><span class="style2 style1"><b>Query 
        Subordinate </b></span></td>
    </tr>
    <tr bgcolor="#FFFFFF" valign="top" class="smallfont"> 
      <td  width = "24%" class="contentBgColor"><div align = "right">Staff Name 
      : </div></td>
      <td width = "76%" class="contentBgColor"><select name="staff" id="staff" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;" onChange = 'document.form1.action="EIS.jsp?action=result_assessment2";document.form1.submit();'>
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
  <p>&nbsp;</p><table width="100%" border="0" align="center" bgcolor="#FFFFFF">
    <tr class="contentStrapColor"> 
      <td colspan="6"><strong>&nbsp;Staff Assessment Result</strong></td>
    </tr>
    <tr class="contentStrapColor"> 
      <td width="10%"> <div align="center"><strong>&nbsp;Year</strong></div></td>
      <td width="70%"><strong>Classification</strong></td>
      <td width="10%"> <div align="center"><strong>&nbsp;Mark</strong></div></td>
      <!-- <td width="52%"> 
      <div align="center"><strong>&nbsp;View</strong></div></td>-->
    </tr>
    <%
 String sql_mark	=	"SELECT SM_STAFF_NAME,SAH_YEAR, SAH_CLASSIFICATION, SAH_FINAL_MARK "+
 						"FROM 	STAFF_ASSESSMENT_HEAD, STAFF_MAIN "+
						"WHERE SM_STAFF_ID = SAH_STAFF_ID "+
						//"AND 	SAH_STAFF_ID = '" + sid + "' "+
						"AND 	SAH_STATUS IN ('APPROVE','RECOMMEND','RECOMMEND1') "+
						"AND 	SAH_FINAL_MARK IS NOT NULL "+
						" AND Sah_STAFF_ID='"+staff+"' "+
						"ORDER 	BY SAH_YEAR desc";
%><%//=sql_mark%><%
try
{
	PreparedStatement pstmt = conn.prepareStatement(sql_mark);
	ResultSet rset			= pstmt.executeQuery();
	int cnt = 0;
	while(rset.next()) 
		{
		year_sah = rset.getString(1);
		cnt++;
		
 %>
    <tr class="contentBgColor"> 
      <td align="center"><%= rset.getString(2) %>&nbsp;</td>
      <td><%= rset.getString(3) %>&nbsp;</td>
      <td align="center"> 
        <%if (rset.getString(4) == null) 
{ 
	out.println(" - ");
}else{
	out.println(rset.getString(4));
}
%>
        &nbsp;</td>
      <!--<td align="center">  <--%@ include file="class.jsp" %>
      &nbsp;</td>-->
    </tr>
    <% 
	}
pstmt.close();
rset.close();
	}
catch(SQLException e)
	{
		out.println("Error result :" + e.toString());
	}
 %>
  </table>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
</form>
<br>
</body>
</html>
<%conn.close();%>