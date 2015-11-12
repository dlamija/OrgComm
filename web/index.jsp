<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>


<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>eCommunity Portal</title>
</head>

<%
String msg ="";

Connection conn=null;
String current_date = "";
	String current_time = null;
	String current_day = null;

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
<%
	if (request.getParameter("username") != null && request.getParameter("password") != null )
	{
		boolean sts = false;
		String username = request.getParameter("username");
		session.setAttribute( "theName", username );
		String password = request.getParameter("password");
		String action = request.getParameter("action");
		String sql_validate = "{ ? = call cms.ValidateUser(?, ?,?) }";
	    try
		{
			CallableStatement cstmt = conn.prepareCall (sql_validate);
		    cstmt.registerOutParameter (1, Types.NUMERIC );
		    cstmt.setString (2, username );				
			cstmt.setString (3, password );
			cstmt.registerOutParameter (4, Types.VARCHAR);
			cstmt.execute ();
			
			if (cstmt.getInt(1)==1) 
				sts = true;
			//else 
			//	sts = false;
				cstmt.close ();
		}
	   catch (SQLException e)
	   {System.out.println("Error at calling Stored Procedure:"+e);}
		
	if (action.equals("login") ){
		if (sts)
			//response.sendRedirect("checkatt.jsp?action=checkin");
			response.sendRedirect("home.jsp");	
			//msg = "Berjaya login";
		else
			msg ="Check in failed!";
		}
	}
%>
<body>
<p>&nbsp;</p>
<form action="Login" method="post" name="loginForm" id="loginForm" >
                <table cellspacing="0" cellpadding="0" width="100%" align="center" border="0">
                  <tbody>
                    <tr>
                      <td align="center" bgcolor="#FFFFFF">                        <div align="center">
                        <label for="mod_login_username"><span class="style2">Username</span></label>
                            <br />
<input  name="userName" style="font-family: Verdana, sans-serif; font-size: 11px;  8px; font-weight: bold; background-color: #FF9900;"  id="mod_login_username" size="20" alt="username" />
                            <!--class="sectiontableentry2"-->
                            <label 
            for="mod_login_password">&nbsp;&nbsp;<br />
                            <span class="style2">Password</span> </label>
                            <br />
                            <input name="password" type="password" style="font-family: Verdana, sans-serif; font-size: 11px;  8px; font-weight: bold; background-color: #FF9900;"
             id="mod_login_password"   size="20" maxlength="16" alt="password" />
&nbsp;
                    <br />
                    <br />
                    <input name="Submit" type="submit" class="text3" value="Community Login">
                    <br>
                      </div></td></tr>
                  </tbody>
                </table></form>
<p>&nbsp;</p>
</body>
</html>