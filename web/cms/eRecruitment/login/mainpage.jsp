<!--%@ page session="true" % -->
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
	String refid = request.getParameter("refid");
	String refid_mainpage = request.getParameter("refid_mainpage");
	PreparedStatement pstmt2 = null;
	ResultSet rset2 = null;

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
if (conn != null)
{
String sql	= "SELECT SCH_REF_ID,SCH_APPLY_DATE,SUBSTR(SCH_REF_ID, 0,4) REFID FROM STAFF_CANDIDATE_HEAD "+
			  "WHERE SCH_IC_NUM='" + kadpengenalan +"' AND SCH_ARCHIVE='N' "+
			  "AND SUBSTR(SCH_REF_ID, 0,4) = TO_CHAR(SYSDATE,'YYYY') ";
try
{
	pstmt2 = conn.prepareStatement(sql); 
	rset2 			= pstmt2.executeQuery();
	if (rset2.next())
	{
		refid_mainpage = rset2.getString(1);
	}
	rset2.close();
	pstmt2.close();
}
	catch (SQLException e)
		{ out.println ("Error : " + e.toString ()); }
	finally {
  try {
      if (rset2 != null) rset2.close();
	  if (pstmt2 != null) pstmt2.close();
	 //if (conn != null) conn.close();
  }
  catch (Exception e) { }
 }
 }
%>
<html>
<head>
<title>e-Recruitment</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="/cms/eRecruitment/nocache/no-cache.jsp" %>
<script language="JavaScript" type="text/JavaScript" src="../register/images/myfreetemplates.js"></script>
<script language="JavaScript">
    function setFocus()
    {
      window.focus();
      document.form1.kadpengenalan.focus();
      return;
    }
    function checkForm()
    {
      if (document.form1.kadpengenalan.value == '') {
            alert("Sila Masukkan No Kad Pengenalan");
            document.form1.kadpengenalan.focus();
      }
      else if (document.form1.nama.value == '') {
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
	  else if (document.form1.emel.value == '') {
            alert("Sila Masukkan Alamat Emel");
            document.form1.emel.focus();
      }
	  else if (document.form1.namaibu.value == '') {
            alert("Sila Masukkan Nama Ibu");
            document.form1.namaibu.focus();
      }
      else {
	  		document.form1.action="eRecruitment.jsp?action=register";
            document.form1.submit();
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
	.DropDownSubText{font-family:arial; font-size:10px; color:#000066;	font-weight:bold; text-decoration:none; height:15px;}

-->
</style>
</head>
<BODY BGCOLOR=#FFFFFF LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0>
<TABLE WIDTH=775 height="568" BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
  <TR> 
    <TD height="196" colspan="2"><TABLE WIDTH=775 BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
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
    <TD width="221" height="355" valign="top" bgcolor="#F3F3F3" class='style2'><div align="center"><br>
        <table width="97%" border="0" align="right" class="style2">
          <tr> 
            <td> 
              <%@include file="profile.jsp" %><%=nama%>
            </td>
          </tr>
          <tr> 
            <td>No Rujukan : <%=( ( refid_mainpage ==null)?"-":refid_mainpage )%></td>
          </tr>
        </table>
        <p>&nbsp;</p>
		<br>
       <table width="97%" border="0" align="right" class="style2">
          <tr> 
            <td colspan="2"> <strong>Maklumat Pemohon</strong></td>
          </tr>
          <tr valign="middle"> 
            <td width="12%"> <div align="right"><img src="cms/eRecruitment/images/mftico.gif" width="11" height="11"></div></td>
            <td width="88%"><a href="eRecruitment.jsp?action=editregistration">Kemaskini 
              Profil</a></td>
          </tr>
          <tr valign="middle"> 
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr valign="middle"> 
            <td colspan="2"><strong>Permohonan Jawatan Online</strong></td>
          </tr>
		  <% if (refid_mainpage == null){%>
          <tr valign="middle"> 
            <td><div align="right"><img src="cms/eRecruitment/images/mftico.gif" width="11" height="11"></div></td>
            <td><a href="eRecruitment.jsp?action=borangpermohonan&kadPengenalan=<%=kadpengenalan%>">Borang Permohonan</a></td>
          </tr>
		  <%} else {%>
          <tr valign="middle"> 
            <td><div align="right"><img src="cms/eRecruitment/images/mftico.gif" width="11" height="11"></div></td>
            <td><a href="eRecruitment.jsp?action=editborang&refid=<%=refid_mainpage%>">Kemaskini 
              Borang Permohonan</a></td>
          </tr>
		 
          <tr valign="middle"> 
            <td><div align="right"><img src="cms/eRecruitment/images/mftico.gif" width="11" height="11"></div></td>
            <td><a href="eRecruitment.jsp?action=upload&refid=<%=refid_mainpage%>">Muat Naik Dokumen</a></td>
          </tr>
          <tr valign="middle"> 
            <td><div align="right"><img src="cms/eRecruitment/images/mftico.gif" width="11" height="11"></div></td>
            <td><a href="eRecruitment.jsp?action=cetak&refid=<%=refid_mainpage%>">Cetak Borang Permohonan</a></td>
          </tr> <br>
		<%}%>
          <tr valign="middle"> 
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr valign="middle"> 
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr valign="middle"> 
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
        </table>
 
      </div></TD>
    <TD width="554" height="355" valign="top" bgcolor="#FFFFFF" class='style2'><iframe height="355" width="100%" bgcolor="#FF9900" scrolling="Auto" src="cms/eRecruitment/login/caramemohon.jsp" hspace="0" vspace="0" frameborder="0"></iframe>
    </TD>
  </TR>
  <TR> 
    <TD colspan="2"> <TABLE WIDTH=775 BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
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
<% if (conn != null) conn.close();%>
<!--%} else {
response.sendRedirect("../../eRecruitment.jsp?action=logout");}
% -->
<% } else { session.invalidate(); %>
<SCRIPT LANGUAGE="JavaScript">
			alert('<%= messages.getString("session.expired") %>');
			top.location.href="eRecruitment.jsp?action=logout";
</SCRIPT>
<% } %>

