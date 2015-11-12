
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ include file="/includes/import.jsp" %>



<%
	Connection conn = null;
	String id= (String)session.getAttribute("staffid");	
    String staff_id = "";
	
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


<%
	// Get staff data...

	String sql_staff	= 	"SELECT SM_STAFF_ID from staff_main "+
							"WHERE SM_STAFF_ID ='"+ id +"' ";

	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_staff);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			staff_id 		= rset.getString (1);
			}
		rset.close();
		pstmt.close ();
		}
	catch (SQLException e)
		{ out.println ("Error Staff_main: " + e.toString ()); }
%>


<TABLE WIDTH="100%" BORDER="0" CELLPADDING="3" CELLSPACING="0">
  <tr>
    <td class="contentStrapColor" align = "right">
     <div align="right">
	
<a href="votesurvey.jsp" onMouseOver="window.status='Main';return true;">
<IMG SRC="images/system/cms_main.gif" ALT="Progress Report" width="38" height="18" BORDER="0"></a>
<% if (staff_id.equals("0227") || staff_id.equals("0108") || staff_id.equals("0189") || staff_id.equals("0414")) { %>
<a href="votesurvey.jsp?action=statistic" onMouseOver="window.status='Statistics';return true;">
<img src="cms/votesurvey/images/setup.gif" alt="Progress Report" width="50" height="18" border="0"></a>
 <%}%>
    </td>
  </tr>
</table>

<% conn.close(); %>