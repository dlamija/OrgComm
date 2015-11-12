<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ page import="common.Messages" %>
<% Messages messages = Messages.getMessages(request); %>
<%
response.setHeader( "Cache-Control", "no-store" );
response.setHeader( "Pragma", "no-cache" );
response.setDateHeader( "Expires", 0 );
%>

<% if ((String)session.getAttribute("kadpengenalan" ) != null ) { %>
<%
	Connection conn = null;
	String kadpengenalan= (String)session.getAttribute("kadpengenalan");
	String refid = request.getParameter("refid");
	String refid_cetak = request.getParameter("refid_cetak");
	PreparedStatement pstmt_cetak = null;

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
	pstmt_cetak = conn.prepareStatement(sql); 
	ResultSet rset 			= pstmt_cetak.executeQuery();
	if (rset.next())
	{
		refid_cetak = rset.getString(1);
	}
	rset.close();
	pstmt_cetak.close();
}
	catch (SQLException e)
		{ out.println ("Error : " + e.toString ()); }
	finally {
  try {
      if (pstmt_cetak != null) 
	  pstmt_cetak.close();  
  }
  catch (Exception e) { }
 }
 }
%>
<html>
<head>
<title>e-Recruitment</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
	.DropDownSubText{font-family:arial; font-size:10px; color:#000066;	font-weight:bold; text-decoration:none; cursor:hand; height:15px;}

-->
</style>
</head>
<BODY BGCOLOR=#FFFFFF LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0>
<TABLE WIDTH=775 height="100%" BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
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
              <%@include file="../../../cms/eRecruitment/login/profile.jsp" %><%=nama%>
            </td>
          </tr>
          <tr> 
            <td>No Rujukan : <%=( ( refid_cetak ==null)?"-":refid_cetak )%></td>
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
          <% if (refid_cetak == null){%>
          <tr valign="middle"> 
            <td><div align="right"><img src="cms/eRecruitment/images/mftico.gif" width="11" height="11"></div></td>
            <td><a href="eRecruitment.jsp?action=borangpermohonan">Borang Permohonan</a></td>
          </tr>
          <%} else {%>
          <tr valign="middle"> 
            <td><div align="right"><img src="cms/eRecruitment/images/mftico.gif" width="11" height="11"></div></td>
            <td><a href="eRecruitment.jsp?action=editborang&refid=<%=refid_cetak%>">Kemaskini 
              Borang Permohonan</a></td>
          </tr>
          <tr valign="middle"> 
            <td><div align="right"><img src="cms/eRecruitment/images/mftico.gif" width="11" height="11"></div></td>
            <td><a href="eRecruitment.jsp?action=upload&refid=<%=refid_cetak%>">Muat 
              Naik Dokumen</a></td>
          </tr>
          <tr valign="middle"> 
            <td><div align="right"><img src="cms/eRecruitment/images/mftico.gif" width="11" height="11"></div></td>
            <td><a href="eRecruitment.jsp?action=cetak&refid_cetak=<%=refid_cetak%>">Cetak Borang Permohonan</a></td>
          </tr>
          <br>
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
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <p><br>
          <br>
        </p>
      </div></TD>
    <TD width="554" valign="top" bgcolor="#FFFFFF" class='style2'><table width="90%" border="0" align="center">
        <tr>
          <td class="style2"><p>&nbsp;</p>
            <p><strong>Cetak perkara-perkara berikut :-</strong></p>
            <table width="90%" border="0" cellpadding="4" cellspacing="1" class="style2">
              <tr> 
                <td width="10%"><div align="center"><img src="cms/eRecruitment/images/printer_icon.gif" width="30" height="30" border="0"></div></td>
                <td width="90%"><a href="cms/eRecruitment/attachment/SENARAISEMAK.pdf" target="_blank">Senarai Semak</a></td>
              </tr>
              <tr> 
                <td><div align="center"><img src="cms/eRecruitment/images/printer_icon.gif" width="30" height="30" border="0"></div></td>
                <td><a href="cms/eRecruitment/attachment/kadJawapan.pdf" target="_blank">Kad Jawapan</a></td>
              </tr>
              <tr> 
                <td><div align="center"><img src="cms/eRecruitment/images/printer_icon.gif" width="30" height="30" border="0"></div></td>
                <td><a href="javascript:void(window.open('eRecruitment.jsp?action=print&refid=<%=refid_cetak%>','statistics', 'height=600,width=900,menubar=no,toolbar=no,scrollbars=yes'))" onMouseOver="window.status='Print Borang Permohonan';return true;">Borang Permohonan/Resume</a></td>
              </tr>
            </table>
            <p>Sila hantar permohonan yang lengkap ke alamat berikut :-</p>
            <p>Jabatan Pendaftar<br>
              Universiti Malaysia Pahang<br>
              Lebuhraya Tun Razak<br>
              26300 Gambang,Kuantan<br>
              Pahang Darul Makmur.<br>
              (U/P Unit Perjawatan &amp; Cuti Belajar) </p>
            <p>&nbsp;</p>
            <p>&nbsp;</p></td>
        </tr>
      </table> </TD>
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
<% conn.close();%>
<% } else {%>
<SCRIPT LANGUAGE="JavaScript">
			alert('<%= messages.getString("session.expired") %>');
			top.location.href="eRecruitment.jsp?action=logout";
</SCRIPT>
<% } %>
