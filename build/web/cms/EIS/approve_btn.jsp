<jsp:useBean id="validator" class="cms.staff.StaffValidator" scope="request" />
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<!--import class file dlm folder WEB-INF/classes/btn-->

<%@ page import="cms.btn.dao.*" %>
<%@ page import="cms.btn.btnform" %>

<%
//yang neh utk query nama proposal yang telah diupload.
//aku hardcodekan std act utk testing (yang no 1 tu)
//so nanti ko pass parameter based pada activity ID tersebut
//kalo pass guna variable.. takyah quote ("")
//evProposal prop = stdReporting.queryProposal("1");
evBtn prop = btnform.queryProposal();
pageContext.setAttribute("prop", prop );
%>


<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>


<%
	Connection conn = null;

	String sid= (String)session.getAttribute("staffid");
	String action = request.getParameter("action");

	String sql = null;
	String staff_id = "";
	String staff_name = "";
	String job_code = "";
	String job_desc = "";
	String dept_code = "";
	String dept_desc = "";
	String join_date = "";
	String current_date = "";

try
	{
    	Context initCtx = new InitialContext();
    	Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
    	DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
		conn = ds.getConnection();
		validator.setDBConnection (conn);
	}
catch( Exception e )
	{ out.println (e.toString()); }
%>


<%
if (conn!=null)
	{
	String sql_staff	= "select SM_STAFF_ID, SM_STAFF_NAME, SM_JOB_CODE,SS_SERVICE_DESC, SM_DEPT_CODE,DM_DEPT_DESC, to_char(sm_join_date, 'DD-MON-YYYY') "+
			    "from staff_main, department_main, service_scheme "+
				"where SM_JOB_CODE=SS_SERVICE_CODE and SM_DEPT_CODE=DM_DEPT_CODE and sm_staff_id ='"+sid+"'";
	
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_staff);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			staff_id = rset.getString (1);
			staff_name = rset.getString (2);
			job_code = rset.getString (3);
			job_desc = rset.getString (4);
			dept_code = rset.getString (5);
			dept_desc = rset.getString (6);
			join_date = rset.getString (7);
			}
		pstmt.close ();
		rset.close ();
		}


	catch (SQLException e)
		{ out.println ("Error : " + e.toString () + "/n" + sql_staff); }
	}	
%>


<%
if (conn!=null)
	{
	// Get current date & time
	String sql_date	= "SELECT to_char(SYSDATE, 'DD-MON-YYYY') FROM DUAL";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_date);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			current_date = rset.getString (1);
			}
		rset.close();
		pstmt.close ();
		}
	catch (SQLException e)
		{ out.println ("Error : " + e.toString ()); }
	}
%>

<body>

<br>
<!--------------------------result display here------------------------>

<form name="form1" action="../btn/btn.jsp" method="get">
<input type="hidden" name="action" value="save_apply">

<TABLE WIDTH="100%" BORDER="0" CELLPADDING="3" CELLSPACING="1" bgcolor="#999999">
    <tr class="smallfont" bgcolor="#FFFFFF" valign="top"> 
     <td colspan="2" class = "contentStrapColor" align="center"><b>BTN COURSE APPLICATION</b></td>
      </tr>
                <tr class="smallfont" bgcolor="#FFFFFF" valign="top"> 
                  <td colspan="2" align="left" class = "contentStrapColor"><b>Staff 
                    Information</b></td>
                </tr>
	<tr valign="top" bordercolor="#CCCCCC" bgcolor="#FFFFFF" class="smallfont">
    <td  width = "20%" class="contentBgColorAlternate"><div align = "right"><strong>Staff ID & Name</strong> </div></td>
   <td width = "80%" class="contentBgColor"><%= staff_id %> - <%= staff_name %>
   <input type="hidden" name="staff_id" value="<%=staff_id%>"></td>
  </tr>
   <tr valign="top" bordercolor="#CCCCCC" bgcolor="#FFFFFF" class="smallfont">
    <td class="contentBgColorAlternate"><div align = "right"><strong>Job Position</strong> </div></td>
   <td class="contentBgColor"><%=job_code %> - <%=job_desc %> </td>
  </tr>
   <tr valign="top" bordercolor="#CCCCCC" bgcolor="#FFFFFF" class="smallfont">
    <td class="contentBgColorAlternate"><div align = "right"><strong>Department</strong> </div></td>
   <td class="contentBgColor"><%=dept_code %> - <%=dept_desc %> </td>
  </tr>
   <tr valign="top" bordercolor="#CCCCCC" bgcolor="#FFFFFF" class="smallfont">
    <td class="contentBgColorAlternate"><div align = "right"><strong>Joint Date</strong> </div></td>
   <td class="contentBgColor"><%=join_date %> </td>
  </tr>
</table><br>
  <br>

<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <table width="100%"  align="left" cellpadding="3" cellspacing="1" border="0" bgcolor="#999999">
                <tr class="smallfont" bgcolor="#FFFFFF" valign="top"> 
                  <td colspan="2" align="left" class = "contentStrapColor"><b>Head of Department/Unit/Dean of Faculty - Approver </b></td>
                </tr>
                <tr class="smallfont" bgcolor="#FFFFFF" valign="top"> 
                  <td width="20%" align="left" class = "contentBgColorAlternate"><b>Date Apply</b></td>
                  <td width="80%" align="left" class = "contentBgColor"><input type="hidden" name="date_apply" value="<%=current_date%>">
					<%=current_date%></td>
                </tr>
                <tr class="smallfont" bgcolor="#FFFFFF" valign="top"> 
                  <td align="left" class = "contentBgColorAlternate"><b>Approver 
                    By</b></td>
                  <td align="left" class = "contentBgColor"><select name="approver">
<%
	// Add recommender name (take from staff hierarchy)
	String superior = "";
	int a = 0;
	sql = "{ ? = call HIERARCHY.GetSuperior( ?, ?, ?) }";
	try
		{
		while (superior != null)
			{
			a++;
			CallableStatement cstmt = conn.prepareCall (sql);
	    	cstmt.registerOutParameter (1, Types.VARCHAR);
			cstmt.setString (2, session.getAttribute("staffid").toString());
			cstmt.setString (3, "ADM_AL");
			cstmt.setInt (4, a);
			cstmt.execute ();
			superior = cstmt.getString(1);
			if (cstmt.getString(1)!=null)
				{ %><option value="<%=superior%>"><%=superior%> - <%=validator.getStaffName(superior)%></option><% }
			cstmt.close ();
			}
		}
	catch (Exception e)
		{ out.println (e.toString()); }
%>
                    </select></td>
                </tr>
                <tr class="smallfont" bgcolor="#FFFFFF" valign="top"> 
                  <td colspan="2" align="center" class = "contentBgColorAlternate"><input type="submit" name="Submit" value="Submit"></td>
                </tr>
              </table>
 	                  </td>
                    </tr>
</table>

<!----------------------------------------------------------->

</form>
<% conn.close(); %>

</body>
</html>
