<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ include file="/includes/import.jsp" %>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<%
	Connection conn = null;
	String id= (String)session.getAttribute("staffid");
	String action = request.getParameter("action");
	String ref =request.getParameter("id");
	String nama = request.getParameter("nama");
	String staff_approver = request.getParameter("staff_approver");
	boolean status=false;
 try
	{
    	Context initCtx = new InitialContext();
    	Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
    	DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
	conn = ds.getConnection();
	}
catch( Exception e )
	{ out.println (e.toString()); }
%>
<body>
<% if(conn !=null && action!=null && action.equals("approve"))
{

String sql_inst = "{ ? = call ANNOUNCE.ApproveAnnouncement(?, ?) }";
	try
	{
		CallableStatement pstmt = conn.prepareCall(sql_inst);
		System.out.println(staff_approver);
		pstmt.registerOutParameter (1, Types.NUMERIC );
		pstmt.setString (2,ref);
		pstmt.setString(3, id);
        pstmt.execute ();
		pstmt.close ();

	
%><p><font size="1" face="Arial">Announcement has 
  been approved</font></p>
<p><br>
<%
}
     	catch (SQLException e)
        	{			out.println (e.toString ());   }
}
	conn.close ();

%>

  <strong><font size="1" face="Arial"><a href="javascript:void(window.close('cms/kmsentry/view.jsp'))">[ 
  Close Window ]</a> </font></strong> </p>
</body>
</html>
