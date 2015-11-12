<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ include file="/includes/import.jsp" %>

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

<%	//Connection...
	Connection conn = null;
	//String id= (String)session.getAttribute("staffid");
	String id = (String)TvoContextManager.getSessionAttribute(request, "Login.CMSID");
	String dept= (String)session.getAttribute("deptcode");
    String action=request.getParameter("action");
    String kategori = request.getParameter("kategori");
	String tajuk = request.getParameter("tajuk");
    String mesej = "";
	mesej = request.getParameter("mesej");
	//mesej = stream.removeln(mesej);
    //mesej = stream.nullToEmpty(mesej);
	String url = request.getParameter("url");
	String access = request.getParameter("access");
	String day = request.getParameter("day");
	String seq = request.getParameter("seq");

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

if(conn !=null && action!=null && action.equals("save"))
{
		
	String sql_date	= 	"SELECT AM_SEQ1.NEXTVAL FROM DUAL";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql_date);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{seq = rset.getString (1);}
			
rset.close();		
pstmt.close ();
		}
	catch (SQLException e)
		{ out.println ("Error sysdate: " + e.toString ()); }
		}
%>



<% if(conn !=null && action!=null && action.equals("save"))
{
	String sql_inst=null;
	if (session.getAttribute("userType").equals("STAFF"))
		sql_inst = "{ ? = call ANNOUNCE.AddAnnouncement(?, ?, ?, ?, ?, ?, ?, ?, ?) }";
	else
		sql_inst = "{ ? = call ANNOUNCE.AddAnnouncementStd(?, ?, ?, ?, ?, ?, ?, ?, ?) }";
	try
	{
		CallableStatement pstmt = conn.prepareCall(sql_inst);
		System.out.println("Data berjaya dimasukkan");
		pstmt.registerOutParameter (1, Types.NUMERIC );
		pstmt.setString (2,seq);
		pstmt.setString(3, id);
        pstmt.setString(4, tajuk);
		pstmt.setString(5, mesej);
		pstmt.setString(6, kategori);
		pstmt.setString(7, url);
		pstmt.setString(8, access);
		pstmt.setString(9, dept);
		pstmt.setString(10, day);
		pstmt.execute ();
		pstmt.close ();

	}
     	catch (SQLException e)
        	{			out.println (e.toString ());   }
}

	conn.close ();

%>

<meta http-equiv="refresh" content="0; URL=announcement.jsp">


<% conn.close(); %>









</body>
</html>




