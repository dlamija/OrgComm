<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>

<html>
<head>
<title>:: Message ::</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<%	//Connection...
	Connection con = null;
    String kadpengenalan2=(String)session.getAttribute("kadpengenalan" );
    String nama2 = request.getParameter("nama");
	String password2 = request.getParameter("password");
	String repassword2 = request.getParameter("repassword");
	String emel2 = request.getParameter("email");
	String namaibu2 = request.getParameter("namaibu");
	String action = request.getParameter("action");
	PreparedStatement pstmt2 = null;
         
 try
	{
		Context initCtx = new InitialContext();
		Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
		DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
		con = ds.getConnection();
	}
	catch( Exception e )
	{
		out.println (e.toString());
	}
%>

<% if(con !=null && action!=null && action.equals("editpermohonan"))
{

String sql_inst = "update erecruitment_registration "+
                   "set er_nama = ?, "+
				   "er_password = ?, "+
				   "er_verifypassword = ?, "+
				   "er_emel = ?, "+
				   "er_namaibu = ? "+
                   "where er_ic_no = '" + kadpengenalan2 +"' ";
	try
	{
		pstmt2 = con.prepareStatement(sql_inst);
		pstmt2.setString(1, nama2);
		pstmt2.setString(2, password2);
		pstmt2.setString(3, repassword2);
		pstmt2.setString(4, emel2);
		pstmt2.setString(5, namaibu2);
		int rc= pstmt2.executeUpdate();
		if(rc>0)
		{ out.println("<font color='#FF0000' size='2' face='Arial, Helvetica, sans-serif'>Maklumat permohonan telah dikemaskini!</font>"); }
		else
		{ out.println("<font color='#FF0000' size='2' face='Arial, Helvetica, sans-serif'>Maklumat permohonan tidak dikemaskini!</font>"); }
		
        pstmt2.close ();

	}
     	catch (SQLException e)
        	{out.println (e.toString ());   }
		finally {
  try {
      //if (con != null) con.close();    
	  if (pstmt2 != null) pstmt2.close ();
  }
  catch (Exception e) { }
  }
		}
%>
<% if (con != null) con.close();  %>









</body>
</html>




