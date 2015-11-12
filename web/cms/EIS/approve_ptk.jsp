<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ include file="/includes/import.jsp" %>

<html>
<head>
<title>Approval by HOD</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
.style1 {
	font-size: smaller;
	font-weight: bold;
}
-->
</style>
</head>



<%	//Connection...
	Connection conn = null;
	String hod_dept="";

	String id= (String)session.getAttribute("staffid");
	String staff_id = "";
	String staff_name = "";
	String staff_dept = "";
	String staff_dept_desc = "";
	String director_id="";

	String action = request.getParameter("action");
%>

<% 
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
	// Get staff data...
	String sql_staff	= 	"SELECT SM_STAFF_ID, SM_STAFF_NAME, SM_DEPT_CODE, UPPER(DM_DEPT_DESC) "+
							"FROM STAFF_MAIN,DEPARTMENT_MAIN "+
							"WHERE SM_STAFF_ID 	= '"+ id +"' "+
							"AND SM_DEPT_CODE	= DM_DEPT_CODE ";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_staff);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			staff_id 		= rset.getString (1);
			staff_name 		= rset.getString (2);
			staff_dept 		= rset.getString (3);
			staff_dept_desc = rset.getString (4);
			}
		pstmt.close ();
		}
	catch (SQLException e)
		{ out.println ("Error Staff_main: " + e.toString ()); }
%>
<%
	// Get HOD.
	String sql_hod	= 	"SELECT SH_REPORT_TO, SH_STAFF_ID, SM_STAFF_ID, SM_STAFF_NAME "+
						"FROM STAFF_HIERARCHY, STAFF_MAIN "+
                        "WHERE SH_REPORT_TO	= '" +id+ "' "+
						"AND SH_STAFF_ID	= SM_STAFF_ID "+
						"AND SH_SYS_ID		= 'ADM_AL' ";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_hod);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			director_id 	= rset.getString (1);
			}
		pstmt.close ();
		}
	catch (SQLException e)
		{ out.println ("Error HOD data: " + e.toString ()); }
%>



<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="3">
 
   <tr>
       <td colspan="2" CLASS="contentBgColorAlternate"><b>Staff's Profile</b></td>
     </tr>
   <tr bgcolor="#FFFFFF" valign="top" class="smallfont">
  <td class="contentBgColor">Staff ID </span></td>
   <td class="contentBgColor"><%= staff_id %>&nbsp;</td>
  </tr>
   <tr bgcolor="#FFFFFF" valign="top" class="smallfont">
    <td class="contentBgColor">Staff Name </span></td>
    <td class="contentBgColor"><%= staff_name %>&nbsp;</td>
  </tr>
   <tr bgcolor="#FFFFFF" valign="top" class="smallfont">
    <td class="contentBgColor">Department</span></td>
   <td class="contentBgColor"><%= staff_dept %>&nbsp;<%=staff_dept_desc %></td>
  </tr>
</table>



<%if (conn!=null)
	{
	// Get record.....
	int ctr=0;
	String sql_data	= 	"SELECT DISTINCT PAM_STAFF_ID, SM_STAFF_NAME, TO_CHAR(PAM_COURSE_DATE_FROM,'DD-MON-YY'), "+
						"TO_CHAR(PAM_COURSE_DATE_TO,'DD-MON-YY'), PAM_PTK_LEVEL, PAM_REF_ID "+
						"FROM STAFF_MAIN, PTK_APPLICATION_MAIN, DEPARTMENT_MAIN "+
						"WHERE PAM_STAFF_ID	= SM_STAFF_ID "+
						"AND EXISTS ( SELECT 1 FROM STAFF_HIERARCHY WHERE SH_STAFF_ID = PAM_STAFF_ID AND SH_REPORT_TO='" + director_id + "' AND SH_SYS_ID='ADM_AL' ) "+
						"AND PAM_DECLARE_STATUS ='DECLARE' and PAM_APPROVE IS NULL ORDER BY PAM_STAFF_ID ";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_data);
		ResultSet rset 			= pstmt.executeQuery ();
		if (rset.isBeforeFirst ()){ ;
%>

<hr>
<form name="form1" action="../ptk/ptk.jsp?action=approvestaff" method="post">

  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#cccccc">
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="1" cellpadding="3">
        <tr valign="top" bgcolor="#EEEEEE" class="smallbold">
          <td class = "contentStrapColor">&nbsp;</td>
          <td class = "contentStrapColor"><b>Id & Nama</b></td>
		  <td class = "contentStrapColor"><div align="center"><b>Dari Tarikh</b></div></td>
          <td class = "contentStrapColor"><div align="center"><b>Hingga Tarikh 
                </b></div></td>
          <td class = "contentStrapColor"><div align="center"><b>Tahap PTK </b></div></td>
          <td class = "contentStrapColor"><div align="center"><b>Kelulusan</b></div></td>

         </tr>
  <%
		while (rset.next())
		{ctr++;
    %>

    <tr bgcolor="#FFFFC4" class="style4">
      <td class = "contentBgColor"><%= ctr %></td>
            <td class = "contentBgColor"><%= rset.getString(1)%> - <%= rset.getString(2) %></td>
      <td class = "contentBgColor"><div align="center"><%= rset.getString(3) %></div></td>
	  <td class = "contentBgColor"><div align="center"><%= rset.getString(4) %></div></td>
      <td class = "contentBgColor"><div align="center"><%= rset.getString(5) %></div></td>
	  <td class = "contentBgColor"><div align="center"><a href="../ptk/ptk.jsp?action=approvestaff%82%22_id=<%=rset.getString(1)%>&ref_id=<%=rset.getString(6)%>">Approve
<input type="hidden" name="tanda2" value="<%=rset.getString(1)%>">
		<input type="hidden" name="tanda3" value="<%=rset.getString(3)%>">
		<input type="hidden" name="tanda4" value="<%=rset.getString(4)%>">
		<input type="hidden" name="tanda5" value="<%=rset.getString(5)%>">


	  </a> 
              </div></td>

     </tr>
        <% 
		} 
		}
		else
		{
		%>
		<tr>
          	<td> No PTK application need to be approved</td>
		</tr>
		
      </table>
    </td>
  </tr>
</table>
          
         
</form>
   
        <% }

			rset.close ();
			pstmt.close ();
			}
	catch( Exception e )
		{ out.println (e.toString()); }
	}
%>




<p>&nbsp;</p>
<%
	conn.close ();
%>




</body>
</html>
