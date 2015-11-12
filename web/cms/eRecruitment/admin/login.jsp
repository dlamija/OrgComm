<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>

<%
String msg ="";

	Connection conn=null;
	String current_date = "";
	String current_time = null;
	String current_day = null;
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
<%
	if (request.getParameter("katanama") != null && request.getParameter("password") != null )
	{
		boolean sts = false;
		String katanama = request.getParameter("katanama");
		session.setAttribute( "katanama", katanama );
		String password = request.getParameter("password");
		String sql_validate = "{ ? = call cms.ValidateUser(?, ?,?) }";
	    try
		{
			CallableStatement cstmt = conn.prepareCall (sql_validate);
		    cstmt.registerOutParameter (1, Types.NUMERIC );
		    cstmt.setString (2, katanama );				
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
		
	if (action.equals("login_admin") ){
		if (sts)
			//msg = "Berjaya";
			response.sendRedirect("../../eRecruitment.jsp?action=main_admin");
		else
			msg ="Login failed!";
	}
	}
%>
<script language="JavaScript" type="text/JavaScript">
function ValidateFieldIn()
	{
if (form1.katanama.value=='')
{
		  	alert("Please insert your username");
			return false;
}
else if (form1.password.value=='')
{
		  	alert("Please insert your password");
			return false;
}
else 
{
	document.form1.action="eRecruitment.jsp?action=login_admin";
}
}


</script>
<script language="JavaScript">
function setFocus()
{
	document.form1.username.focus();
	return;
}
</script>
<html>

<head>

<title>.: Admin :.</title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<style type="text/css">
<!--
body,td,th {
	font-size: 5px;
	text-align: right;
}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #666666;
}
-->
</style></head>



<body link="#CCCCCC" vlink="#CCCCCC" alink="#CCCCCC">

<table width="800" height="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
  <td width="80" rowspan="4" bgcolor="#666666">&nbsp;</td>
  <td width="1" rowspan="4" bgcolor="#000000"><img src="cms/eRecruitment/images/spacer.gif" width="1" height="1"></td>
    <td bgcolor="#FFFFFF">&nbsp;</td>
    <td width="1" height="100" rowspan="4" bgcolor="#000000"><img src="cms/eRecruitment/images/spacer.gif" width="1" height="1"></td>
    <td width="100" rowspan="4" bgcolor="#666666">&nbsp;</td>
  </tr>
  <tr> 
    <td bgcolor="#FFFFFF" height="100"><table border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 

          <td height="22" colspan="2" background="cms/eRecruitment/images/topbg.gif"><div align="left"><font color="#FFFFFF" size="1" face="Verdana, Arial, Helvetica, sans-serif"><strong>&nbsp;&nbsp;&nbsp;&nbsp;Welcome 
            to Admin Site</strong></font></div></td>

        </tr>

        <tr> 

          <td height="2" colspan="2" background="../images/subnavbg.gif" bgcolor="#FFCC00"><font color="#FFCC33" size="1" face="Verdana, Arial, Helvetica, sans-serif">ss</font></td>

        </tr>

        <tr> 

          <td width="300" height="200" rowspan="3" valign="top"><img src="cms/eRecruitment/images/GlobalRecruitment.gif" width="300" height="225"></td>

          <td width="321" height="155" valign="bottom" bgcolor="#E2E2E2"> <form name="form1" method="post" action="eRecruitment.jsp?action=login_admin">

              <div align="center">
                <p><strong><font style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">Username</font></strong><br>
                  
                  <input name="katanama" type="text" id="katanama" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                  
                  <br>
                  
                  <strong><font style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">Password</font></strong> <br>
                  
                  <input name="password" type="password" id="password" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                  
                  <br>
                  
                  <br>
  <INPUT name="image" type=image class=img src="cms/eRecruitment/images/login.gif" width="29" height="29" onClick='return ValidateFieldIn()'>
  <br>
                  <font style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">Login</font>              </p>
              </div>

            </form></td>

        </tr>
        <tr>
          <td height="25" bgcolor="#E2E2E2"><div align="center">
            <p><font style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px;" color="#FF0000"><%=msg%></font></p>
          </div></td>
        </tr>
        <tr>
          <td height="40" bgcolor="#E2E2E2"><div align="center">
            <p><font style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">&nbsp;&nbsp;Untuk login ke ruangan admin, sila gunakan kata &nbsp;&nbsp;nama dan kata laluan eCommunity</font></p>
          </div></td>
        </tr>

        <tr> 

          <td height="2" colspan="2" background="../images/subnavbg.gif" bgcolor="#FFCC33"><font color="#FFCC33" size="1" face="Verdana, Arial, Helvetica, sans-serif">ss</font></td>

        </tr>

        <tr> 

          <td height="10" colspan="2" background="../images/topbg.gif">&nbsp;</td>

        </tr>

    </table></td>

  </tr>

  <tr>

    <td height="200" bgcolor="#FFFFFF"><img src="cms/eRecruitment/images/kaki.gif" width="500" height="200"></td>

  </tr>

  <tr> 

    <td bgcolor="#999999" height="20"><div align="center"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">&copy; 

        All rights reserved. Universiti Malaysia Pahang.
</font></div></td>

  </tr>

</table>

</body>

</html>
<%
conn.close();
%>
