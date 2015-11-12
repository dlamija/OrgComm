<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.util.*, javax.mail.*, javax.mail.internet.*" %>
<style type="text/css">
<!--
.style1 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 13px;
	font-weight: bold;
	color: #707C8A;
}
.style2 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	color: #333333;
}
a {
	color: #333333;
	TEXT-DECORATION: none;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
}
	.DropDownSubBox{border:1px solid #006699; background-color:#ccccff;}
	.DropDownSubText{font-family:arial; font-size:10px; color:#000066;	font-weight:bold; text-decoration:none; cursor:hand; height:15px;}

-->
</style>
<%	//Connection...
	Connection conn = null;
    String kadpengenalan=request.getParameter("kadpengenalan");
	String namaibu = request.getParameter("namaibu");
	String action = request.getParameter("action");
	PreparedStatement pstmt = null;
    boolean status3 = true;
	String password = request.getParameter("password");
	String emel = request.getParameter("emel");
	String email = request.getParameter("email");
	String katalaluan = request.getParameter("katalaluan");
	String msg = request.getParameter("msg");
	String msg2 = request.getParameter("msg2");
	PreparedStatement pstmtstatus = null;
	ResultSet rsetstatus = null;
	   
	     
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
if (conn!=null)
	{
	//cek user jika dah apply
	String sqlstatus	= "SELECT ER_PASSWORD,lower(ER_EMEL) FROM ERECRUITMENT_REGISTRATION "+
						  "WHERE ER_IC_NO = '" + kadpengenalan + "' and upper(er_namaibu) like upper('%" + namaibu + "%') ";
	try
		{
		pstmtstatus = conn.prepareStatement(sqlstatus);
		rsetstatus = pstmtstatus.executeQuery ();
		if (rsetstatus.next())
			{
			status3 = true; //data dah ade kat db
			password = rsetstatus.getString(1);
			emel = rsetstatus.getString(2);
			}
		else
			status3 = false;
		pstmtstatus.close ();
		}
	catch (SQLException e)
		{ out.println ("Error : " + e.toString ()); }
	finally {
  try {
      if (rsetstatus != null) rsetstatus.close();
	  if (pstmtstatus != null) rsetstatus.close();
	  if (conn != null) conn.close();
  }
  catch (Exception e) { }
  }
}
%>
<body class='style2'>
<font color="#FF0000"><strong> </strong></font> 
<% if (request.getParameter("action").equals("sendkatalaluan") && status3) {
    
	boolean status = true;
	String mailServer = "172.16.30.45";
	String fromEmail    = "recruitment@ump.edu.my";
	String toEmail      = emel;
	String katalaluan2 = password;
	String messageEnter = request.getParameter("msg")+ "Kata Laluan :" +password + request.getParameter("msg2");

  if(toEmail.equals("") )
       toEmail = "recruitment@ump.edu.my";
 
  try
  {

    Properties props = new Properties();
    props.put("mail.smtp.host", mailServer);
    Session s = Session.getInstance(props,null);
    MimeMessage message = new MimeMessage(s);
    InternetAddress from = new InternetAddress(fromEmail);
    message.setFrom(from);
    InternetAddress to = new InternetAddress(toEmail);
    message.addRecipient(Message.RecipientType.TO, to);
    message.setSubject("UMP e-Recruitment - Kata Laluan");
    message.setText(messageEnter);
    Transport.send(message);
  }
  catch(NullPointerException n)
  {
     System.out.println(n.getMessage() );
     out.println("ERROR, you need to enter a message");
     status = false;

  }
  catch (Exception e)
  {
     System.out.println(e.getMessage() );
     out.println("ERROR, your message to " + toEmail + " failed, reason is: " + e);
     status = false;

  }

  if (status == true)
  {
%>
Permohonan kata laluan telah dihantar ke <%=toEmail%> dengan jayanya! 
<%
  }
}
else
{%>
<font color="#FF0000">Permohonan tidak dapat diproses kerana no kad pengenalan 
dan nama ibu tidak sepadan.Harap maaf.</font> 
<% }%>
<br>
<input type="submit" name="Submit" value="Close" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" onClick="javascript:window.close()">
<input type="submit" name="Submit2" value="Back" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" onClick="history.go(-1)"></p> 
</body>