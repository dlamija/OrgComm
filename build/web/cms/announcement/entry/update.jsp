<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ include file="/includes/import.jsp" %>
<jsp:useBean id="stream" scope="page" class="common.CommonFunction"/>



<html>
<head>
<title>:: Message ::</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
body,td,th {
	font-family: Arial, Helvetica, sans-serif;
	font-size: x-small;
	color: #000000;
}
-->
</style></head>
<body>
<%	//Connection...
	Connection conn = null;

	String id= (String)session.getAttribute("staffid");
    String action=request.getParameter("action");
    String kategori = request.getParameter("kategori");
	String tajuk = request.getParameter("tajuk");
    String mesej = "";
	mesej = request.getParameter("mesej");
	mesej = stream.removeln(mesej);
    mesej = stream.nullToEmpty(mesej);
	String url = request.getParameter("url");
	String ref = request.getParameter("ref");
	String access = request.getParameter("access");
	String day = request.getParameter("day");
	
          
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


<%=kategori%>

<% if(conn !=null && action!=null && action.equals("update"))
{

String sql_inst ="UPDATE CMSADMIN.ANNOUNCEMENT_MAIN AM "+
                  "SET  AM.AM_TITLE  = ?, "+
				  "AM.AM_MESSAGE = ?, "+
				  "AM.AM_CATEGORY = ?, "+
				  "AM.AM_URL = ? ,"+
				  "AM.AM_ACCESS = ? ,"+
				  "AM.AM_TOTAL_DAY = ? "+
                  "WHERE AM.AM_REF = ? ";

	try
	{
		PreparedStatement pstmt = conn.prepareStatement(sql_inst);
		//System.out.println("Data berjaya diupdate");
		pstmt.setString(1, tajuk);
		pstmt.setString(2, mesej);
		pstmt.setString(3, kategori);
		pstmt.setString(4, url);
		pstmt.setString(5, access);
		pstmt.setString(6, day);
		pstmt.setString(7, ref);
		int rc= pstmt.executeUpdate();
		if(rc>0)
		{ out.println("Data have been successfully inserted !"); }
		else
		{ out.println("Data failed to insert !"); }
		
        pstmt.close ();

	}
     	catch (SQLException e)
        	{			out.println (e.toString ());   }
}
	conn.close ();

%>

<meta http-equiv="refresh" content="200; URL=announcement.jsp">


<% conn.close(); %>

</body>
</html>




