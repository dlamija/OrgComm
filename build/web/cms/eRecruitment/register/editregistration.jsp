<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ page import="common.Messages" %>
<% Messages messages = Messages.getMessages(request); %>

<% if ((String)session.getAttribute("kadpengenalan" ) != null ) { %>
<%
	Connection conn = null;
	String kadpengenalan= (String)session.getAttribute("kadpengenalan");
	String nama = request.getParameter("nama");
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	String repassword = request.getParameter("repassword");
	String namaibu = request.getParameter("namaibu");
	PreparedStatement pstmt = null;
	ResultSet rset = null;

 	try {
		Context initCtx = new InitialContext();
		Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
		DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
		conn = ds.getConnection();
	}
	catch( Exception e )
	{ out.println (e.toString()); }
%>
<%

	String sql	= "SELECT ER_NAMA,ER_EMEL,ER_NAMAIBU,ER_PASSWORD,ER_VERIFYPASSWORD FROM ERECRUITMENT_REGISTRATION "+
	              "WHERE ER_IC_NO = '" + kadpengenalan +"' ";
				 
	try {
		pstmt = conn.prepareStatement(sql);
		rset = pstmt.executeQuery ();
		
		if (rset.next()) {
			nama = rset.getString (1);
			email = rset.getString (2);
			namaibu = rset.getString (3);
			password = rset.getString (4);
			repassword = rset.getString (5);
		}
		rset.close();
		pstmt.close ();
	}
	catch (SQLException e) {
		out.println ("Error SQL: " + e.toString ()); 
	}
	finally {
		try {
		    if (rset != null) rset.close();
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
		}
		catch (Exception e) {  }
	}
%>
<html>
<head>
<title>e-Recruitment</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="/cms/eRecruitment/nocache/no-cache.jsp" %>
<script language="JavaScript" type="text/JavaScript" src="images/myfreetemplates.js"></script>
<script language="JavaScript">
	function back()
	{
			document.form1.action="eRecruitment.jsp?action=mainpage";
            document.form1.submit();
	}
	function echeck(str) {

		var at="@"
		var dot="."
		var lat=str.indexOf(at)
		var lstr=str.length
		var ldot=str.indexOf(dot)
		if (str.indexOf(at)==-1){
		   alert("Invalid E-mail Address")
		   return false
		}

		if (str.indexOf(at)==-1 || str.indexOf(at)==0 || str.indexOf(at)==lstr){
		   alert("Invalid E-mail Address")
		   return false
		}

		if (str.indexOf(dot)==-1 || str.indexOf(dot)==0 || str.indexOf(dot)==lstr){
		    alert("Invalid E-mail Address")
		    return false
		}

		 if (str.indexOf(at,(lat+1))!=-1){
		    alert("Invalid E-mail Address")
		    return false
		 }

		 if (str.substring(lat-1,lat)==dot || str.substring(lat+1,lat+2)==dot){
		    alert("Invalid E-mail Address")
		    return false
		 }

		 if (str.indexOf(dot,(lat+2))==-1){
		    alert("Invalid E-mail Address")
		    return false
		 }
		
		 if (str.indexOf(" ")!=-1){
		    alert("Invalid E-mail Address")
		    return false
		 }

 		 return true					
	}

    function setFocus()
    {
      window.focus();
      document.form1.nama.focus();
      return;
    }
    function checkForm()
    {
      if (document.form1.nama.value == '') {
            alert("Sila Masukkan Nama Penuh");
            document.form1.nama.focus();
      }
	  else if (document.form1.password.value == '') {
            alert("Sila Masukkan Kata laluan");
            document.form1.password.focus();
      }
      else if (document.form1.password.value != document.form1.repassword.value) {
            alert("Kata laluan tidak sepadan");
            document.form1.repassword.focus();
      }
	  else if (document.form1.password.value.length > 8) {
	  		alert("Panjang kata laluan hendaklah sekurang-kurangnya 8 aksara");
			document.form1.password.focus();
	  }
	  else if (document.form1.email.value == '') {
            alert("Sila Masukkan Alamat Emel");
            document.form1.email.focus();
      }
	  else if (echeck(document.form1.email.value)==false){
		document.form1.email.value="";
		document.form1.email.focus();
		//return false
	}
	  else if (document.form1.namaibu.value == '') {
            alert("Sila Masukkan Nama Ibu");
            document.form1.namaibu.focus();
      }
      else {
	  		document.form1.action="eRecruitment.jsp?action=editpermohonan";
            document.form1.submit();
      }
    }
	
	function toUpperCase(field)
  {
    field.value = field.value.toUpperCase();
  }

 function setTextFieldToUpper()
  {
    var input =  document.getElementsByTagName("input");
    for (i=0;i<input.length;i++)
    {

        input[i].onblur = new Function("toUpperCase(this)");

    }
  }

    </script>
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
</head>
<BODY BGCOLOR=#FFFFFF LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0 onLoad="setTextFieldToUpper();">
<TABLE WIDTH=775 height="568" BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
  <TR> 
    <TD height="196"><TABLE WIDTH=775 BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
        <TR> 
          <TD rowspan="3" valign="top"><TABLE BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
              <TR> 
                <TD><IMG SRC="cms/eRecruitment/images/x3_01.gif" WIDTH=221 HEIGHT=16 ALT=""></TD>
              </TR>
              <TR> 
                <TD ROWSPAN=2> <IMG SRC="cms/eRecruitment/images/x3_05.gif" WIDTH=221 HEIGHT=84 ALT=""></TD>
              </TR>
              <TR> </TR>
              <TR> 
                <TD> <IMG SRC="cms/eRecruitment/images/x3_22.gif" WIDTH=220 HEIGHT=88 ALT=""></TD>
              </TR>
            </TABLE></TD>
          <TD><IMG SRC="cms/eRecruitment/images/x3_02.gif" WIDTH=364 HEIGHT=16 ALT=""></TD>
          <TD> <IMG SRC="cms/eRecruitment/images/x3_03.gif" WIDTH=173 HEIGHT=16 ALT=""></TD>
          <TD ROWSPAN=2 valign="top"> <IMG SRC="cms/eRecruitment/images/x3_04.gif" WIDTH=17 HEIGHT=70 ALT=""></TD>
        </TR>
        <TR> 
          <TD background="cms/eRecruitment/images/navbg.gif"><TABLE BORDER=0 align="left" CELLPADDING=0 CELLSPACING=0>
              <TR> 
                <TD><a href="eRecruitment.jsp?action=mainpage"><IMG NAME="btn_home" SRC="cms/eRecruitment/images/menu.gif" BORDER=0 ALT=""></a></TD>
                <TD><a href="eRecruitment.jsp?action=logout"><IMG NAME="btn_home" SRC="cms/eRecruitment/images/logout2.gif" BORDER=0 ALT=""></a></TD>
                <TD>&nbsp;</TD>
              </TR>
            </TABLE></TD>
          <TD> <IMG SRC="cms/eRecruitment/images/x3_18.gif" WIDTH=173 HEIGHT=54 ALT=""></TD>
        </TR>
        <TR> 
          <TD colspan="2"><IMG SRC="cms/eRecruitment/images/x3_19.gif" WIDTH=537 HEIGHT=118 ALT=""> 
          </TD>
          <TD valign="top"> <IMG SRC="cms/eRecruitment/images/x3_21.gif" WIDTH=17 HEIGHT=118 ALT=""></TD>
        </TR>
        <TR> 
          <TD> <IMG SRC="cms/eRecruitment/images/x3_23.gif" WIDTH=221 HEIGHT=8 ALT=""></TD>
          <TD COLSPAN=3><img src="cms/eRecruitment/images/line.gif" width="554" height="8" ALT=""></TD>
        </TR>
      </TABLE></TD>
  </TR>
  <TR> 
    <TD height="355" valign="top" bgcolor="#F3F3F3" class='style2'><br>
      <table width="80%" border="0" align="center">
        <tr>
          <td><p class="style1"><br>
              Kemaskini Maklumat Pendaftaran</p>
			   <% if (request.getParameter("action").equals("editpermohonan")) {%>
			  <%@include file="editpermohonan.jsp" %>
			  <%}%>
 			   <form name="form1" method="post" action="">
              <table width="100%" border="0" cellspacing="1" class='style2'>
                <tr> 
                  <td width="35%"><strong>No Kad Pengenalan <font color="#FF0000">*</font></strong></td>
                  <td width="65%"><%=(String)session.getAttribute("kadpengenalan" )%>&nbsp;</td>
                </tr>
                <tr>
                  <td><strong>Nama Penuh <font color="#FF0000">*</font></strong></td>
                  <td><% if (request.getParameter("action").equals("editpermohonan")) {%><%=request.getParameter("nama")%><%}else {%><input name="nama" type="text" id="emel" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" value="<%=nama%>" size="50" maxlength="100"><%}%></td>
                </tr>
                <tr> 
                  <td><strong>Kata Laluan <font color="#FF0000">*</font></strong></td>
                  <td><% if (request.getParameter("action").equals("editpermohonan")) {%><%=request.getParameter("password")%><%}else {%><input name="password" type="password" id="studentID42" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" value="<%=password%>" maxlength="8"><%}%> 
                    <em> <font size="1">(maksimum : 8 aksara)</font></em></td>
                </tr>
                <tr> 
                  <td><strong>Ulang Kata Laluan <font color="#FF0000">*</font></strong></td>
                  <td><% if (request.getParameter("action").equals("editpermohonan")) {%><%=request.getParameter("repassword")%><%}else {%><input name="repassword" type="password" id="repassword" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" value="<%=repassword%>" maxlength="8"> <%}%>
                    <font size="1"><em>(maksimum : 8 aksara)</em></font></td>
                </tr>
                <tr> 
                  <td><strong>Emel <font color="#FF0000">*</font></strong></td>
                  <td><% if (request.getParameter("action").equals("editpermohonan")) {%><%=request.getParameter("email")%><%}else {%>
                    <input name="email" type="text" id="email" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" value="<%=email%>" size="35" maxlength="50"><em> <font size="1">(cth : shauqah@yahoo.com)</font></em>
                    <%}%></td>
                </tr>
                <tr> 
                  <td><p><strong>Nama Ibu Kandung</strong> <font color="#FF0000">*</font><br>
                      (Jika terlupa kata laluan)</p></td>
                  <td><% if (request.getParameter("action").equals("editpermohonan")) {%><%=request.getParameter("namaibu")%><%}else {%><input name="namaibu" type="text" id="namaibu" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" value="<%=namaibu%>" size="50" maxlength="100"><%}%></td>
                </tr>
                <tr> 
                  <td height="40" colspan="2"> <div align="center"> 
                      <% if (!request.getParameter("action").equals("editpermohonan")) {%>
                      <A HREF="javascript:checkForm();" onMouseOver="window.status='Update';return true;"><IMG SRC="cms/eRecruitment/images/ic_update.gif" BORDER="0" ALT="Update"></A> 
                      <A HREF="javascript:back();" onMouseOver="window.status='Cancel';return true;"><IMG SRC="cms/eRecruitment/images/ic_cancel.gif" BORDER="0" ALT="Cancel"></A> 
                      <%}%>
                    </div></td>
                </tr>
              </table>
            </form>
            <p class="style2"><strong><font color="#FF0000">PERHATIAN</font></strong><font color="#FF0000"> 
              : Sila berikan alamat emel yang betul untuk memudahkan urusan di 
              masa hadapan (terlupa kata laluan atau hal-hal yang berkaitan).<br>
              </font></p>
            </td>
        </tr>
      </table>
      <br> 
      <p>&nbsp;</p>
      
    </TD>
  </TR>
  <TR> 
    <TD> <TABLE WIDTH=775 BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
        <TR bgcolor="#666666"> 
          <TD height="30" class='style2'><div align="center"><font color="#FFFFFF" size="1">&copy; 
              2008 Hakcipta Terpelihara Pejabat Pendaftar, Universiti Malaysia 
              Pahang </font></div></TD>
        </TR>
      </TABLE></TD>
  </TR>
</TABLE>
</BODY>
</HTML>
<% } else { session.invalidate(); %>
<SCRIPT LANGUAGE="JavaScript">
			alert('<%= messages.getString("session.expired") %>');
			top.location.href="eRecruitment.jsp?action=logout";
</SCRIPT>
<% } %>
