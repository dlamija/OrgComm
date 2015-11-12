<%@ page buffer="1024kb" autoFlush="true" %>
<%@ include file="/includes/import.jsp" %>
<%@ include file="/includes/no-cache.jsp" %>
<%@ include file="/includes/loginCheck.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>UMP eCommunity Portal :: Change Password</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="template/default/css/main.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {	font-family: Arial;
	font-size: 12px;
}
-->
</style>
</head>
<%
	Connection conn = null;
	String flag = request.getParameter("flag");
	String username = (String)TvoContextManager.getSessionAttribute(request, "Login.userName");
	PreparedStatement pstmt_staff = null;
	ResultSet rset_staff = null;

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
<%
if (conn!=null)
	{
	// Get current staff info
	String sql_staff  = "SELECT PASSWORDCHARFLAG FROM USERS "+
						"WHERE USERNAME = UPPER(?) ";
	try
		{
		pstmt_staff = conn.prepareStatement(sql_staff);
		pstmt_staff.setString(1, username);
		rset_staff = pstmt_staff.executeQuery ();
		if (rset_staff.next())
			{
			flag = rset_staff.getString (1);
			}
		}
	catch (SQLException e)
		{ out.println ("Error : " + e.toString ()); }

	 }
%>
<script type="text/javascript">

		function validateFields() {
		 var re;
		 re= /[0-9]/;
		 var re2;
		 re2 = /[a-z]/;
		 var re3;
		 re3 = /[A-Z]/;
		 var re4;
		 re4 = /[@!#\$\^%&*()+=\-\[\]\\\';,\.\/\{\}\|\":<>\?_ ]/;
	  
	  	var rad_val;
	
			if (document.form1.current.value == '') {
				alert("Please enter existing password");
				document.form1.current.focus();
				return false;
			}
			else if (document.form1.newpassword.value == '') {
				alert("Please enter new password");
				document.form1.newpassword.focus();
				return false;
			}
			else if (document.form1.newpassword.value.length < 12 || document.form1.newpassword.value.length > 20) {
				alert("Min Valid Password is 12 characters.\nPlease verify your input and submit again");
				document.form1.newpassword.focus();
				return false;			
			}
			else if(!re.test(document.form1.newpassword.value)) {
				alert("Valid Password must contain at least one number (0-9)!");
				document.form1.newpassword.focus();
				return false;	
			  }
			 
			 else if(!re2.test(document.form1.newpassword.value)) {
				alert("Valid Password must contain at least one lowercase letter (a-z)!");
				document.form1.newpassword.focus();
				return false;	
			 }
			  else if(!re4.test(document.form1.newpassword.value)) {
				alert("Valid Password must contain at least one speacial character (etc: *, % , $)!");
				document.form1.newpassword.focus();
				return false;	
			 }
			else if (document.form1.verify.value == '') {
				alert("Please verify new password");
				document.form1.verify.focus();
				return false;
			}
			 else if (document.form1.newpassword.value != document.form1.verify.value) {
				alert("New password do not match with verify password");
				document.form1.verify.focus();
				return false;
     		 }
			else if (document.form1.current.value == document.form1.newpassword.value) {
				alert("New password cannot same as current password");
				document.form1.newpassword.focus();
				return false;
			}
			else {
				document.form1.action = "Password";
				document.form1.trans.value = "Y";
				document.form1.submit();
			}	
	
	}


	function validateFieldsChar() {
		 re = /[0-9]/;
		 re2 = /[a-z]/;
		 re3 = /[A-Z]/;
		 re4 = /[@!#\$\^%&*()+=\-\[\]\\\';,\.\/\{\}\|\":<>\?_ ]/;
	  
		var rad_val;
		for (var i=0; i < document.form1.optPwd.length; i++) {
		 	if (document.form1.optPwd[i].checked) {
				rad_val = document.form1.optPwd[i].value;
			}
		}
	
		if (rad_val == 'Y') {
			if (document.form1.current.value == '') {
				alert("Please enter existing password");
				document.form1.current.focus();
				return false;
			}
			else if (document.form1.newpassword.value == '') {
				alert("Please enter new password");
				document.form1.newpassword.focus();
				return false;
			}
			else if (document.form1.newpassword.value.length < 12 || document.form1.newpassword.value.length > 20) {
				alert("Min Valid Password is 12 characters.\nPlease verify your input and submit again");
				document.form1.newpassword.focus();
				return false;			
			}
			else if(!re.test(document.form1.newpassword.value)) {
				alert("Valid Password must contain at least one number (0-9)!");
				document.form1.newpassword.focus();
				return false;	
			  }
			 
			 else if(!re2.test(document.form1.newpassword.value)) {
				alert("Valid Password must contain at least one lowercase letter (a-z)!");
				document.form1.newpassword.focus();
				return false;	
			 }
			  else if(!re4.test(document.form1.newpassword.value)) {
				alert("Valid Password must contain at least one speacial character (etc: *, % , $)!");
				document.form1.newpassword.focus();
				return false;	
			 }
			else if (document.form1.verify.value == '') {
				alert("Please verify new password");
				document.form1.verify.focus();
				return false;
			}
			 else if (document.form1.newpassword.value != document.form1.verify.value) {
            alert("New password do not match with verify password");
            document.form1.verify.focus();
			return false;
     		 }
			else if (document.form1.current.value == document.form1.newpassword.value) {
				alert("New password cannot same as current password");
				document.form1.newpassword.focus();
				return false;
			}
			else {
				document.form1.action = "Password";
				document.form1.trans.value = "Y";
				document.form1.submit();
			}	
		}
		else if (rad_val == 'N') {
			document.form1.action = "Password";
			document.form1.trans.value = "N";
			document.form1.submit();
		}
		else {
			alert("Please choose option to proceed.");
			return false;
		}
	}
</script>


<body>
<form name="form1" method="post">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="0">
	<tr>
    	<td colspan="3" background="images/hyperlink/background_red.gif" align="center" class="white" height="50"><FONT SIZE="2" FACE="Arial" COLOR="#FFFFFF"><B>E-COMMUNITY STAFF</B></FONT></td>
  	</tr>
	<tr bgcolor="#FFFFFF"><td colspan="3">&nbsp;</td></tr>
	<tr bgcolor="#FFFFFF">
		<td width="9%" align="right"><img src="images/security.jpg"></td>
		<td colspan="2" valign="top" class="normal"><br>
			<div align="left"><strong>PASSWORD ADMINISTRATION</strong></div>
			<hr color="#000000" size="1">
			<font color="#996600">Your password has expired. For security reason, you are required to change your password immediately.</font>
			<br><br><strong>Username : <%=username%> </strong></td>
	</tr>
   
    <% if (flag != null && flag.equals("8")) {%>
	<tr>
		<td>&nbsp;</td>
		<td colspan="2" class="normal">
			<!--input name="optPwd" type="radio" id="optPwd" value="Y" checked--><font color="#3366FF">&nbsp;<strong>Yes, i will change my password :</strong></font>
		  	<table width="100%" border="0" cellpadding="2">
				<tr class="normal">
					<td width="11%" align="right">Existing Password :</td>
					<td width="89%"><input type="password" name="current" size="20"></td>
				</tr>
				<tr class="normal">
					<td width="10%" align="right">New Password :</td>
					<td width="90%"><input type="password" name="newpassword" size="20" maxlength="20">
					  <font color="#FF0000" size="1" face="Arial, Helvetica, sans-serif">* Min Password 
                is 12 characters ; Max Password 
              is 20 characters</font></td>
				</tr>
				<tr class="normal">
					<td align="right">Verify New Password :</td>
					<td><input type="password" name="verify" size="20" maxlength="20">
					  <font color="#FF0000" size="1" face="Arial, Helvetica, sans-serif">* Min Password 
                is 12 characters ; Max Password 
              is 20 characters</font></td>
				</tr>
				<tr class="normal">
				  <td align="right">&nbsp;</td>
				  <td>&nbsp;</td>
			  </tr>
				<tr class="normal">
				  <td align="right">&nbsp;</td>
				  <td><input name="Button" type="button" onClick="return validateFields()" value="Submit"></td>
			  </tr>
             
			</table>
		
		</td>
	</tr> 
	<%} else {%>
    <tr>
		<td>&nbsp;</td>
		<td colspan="2" class="normal">
			<input name="optPwd" type="radio" id="optPwd" value="Y" checked><font color="#3366FF">&nbsp;<strong>Yes, i will change my password :</strong></font>
		  	<table width="100%" border="0" cellpadding="2">
				<tr class="normal">
					<td width="10%" align="right">Existing Password :</td>
					<td width="90%"><input type="password" name="current" size="20"></td>
				</tr>
				<tr class="normal">
					<td align="right">New Password :</td>
					<td><input type="password" name="newpassword" size="20" maxlength="20">
					  <font color="#FF0000" size="1" face="Arial, Helvetica, sans-serif">* Min Password 
                is 12 characters ; Max Password 
              is 20 characters</font></td>
				</tr>
				<tr class="normal">
					<td align="right">Verify New Password :</td>
					<td><input type="password" name="verify" size="20" maxlength="20">
					  <font color="#FF0000" size="1" face="Arial, Helvetica, sans-serif">* Min Password 
                is 12 characters ; Max Password 
              is 20 characters</font></td>
				</tr>
			</table>
		
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td colspan="2" class="normal">
			<input name="optPwd" type="radio" id="optPwd" value="N"><font color="#3366FF">&nbsp;<strong>No, i will not change my password.</strong></font>
		</td>
	</tr>
	<tr bgcolor="#FFFFFF"><td colspan="3">&nbsp;</td></tr>
	<tr>
		<td>&nbsp;</td>
		<td width="9%" align="center">&nbsp;</td>
		<td width="82%" align="left"><input type="submit" value="Submit" onClick="return validateFieldsChar()"></td>
	</tr>
    <%}%>
	<tr>
		<td>&nbsp;</td>
		<td colspan="2" class="normal">
			<!--input name="optPwd" type="radio" id="optPwd" value="N"><font color="#3366FF">&nbsp;<strong>No, i will not change my password.</strong></font -->
		</td>
	</tr>
	<tr>
    	<td height="38" colspan="3" align="center" valign="middle" bgcolor="#192227">
			<span class="white">Copyright &copy; Pusat Teknologi Maklumat &amp; Komunikasi, Universiti Malaysia Pahang</span></td>
  	</tr>
</table>
	<input type="hidden" name="trans">
</form>
<table width="95%" border="0" align="center">
  <tr>
    <td><br>
      <font color="#996600" size="2"><span class="style1"><em>Note:<br>
        Managing your password. Change your password regularly<strong>.<br>
          </strong> Always logout, after using </em> <em>E-Community Staff </em> <br>
        <br>
        Policy: <a href="http://www.ump.edu.my/pekeliling/doc/Prosedur_Penggunaan_Kata_Nama.pdf" target="_blank">Prosedur Peggunaan Kata Nama &amp; Kata Laluan</a></span></font></td>
  </tr>
</table>
</body>
</html>
<%
try
	{ conn.close (); }
catch (Exception e)
	{ conn = null; }
%>	