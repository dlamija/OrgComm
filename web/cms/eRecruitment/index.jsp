<html>
<head>
<title>e-Recruitment</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!--meta name="keywords" content="Keywords here">
<meta name="description" content="Description here">
<meta name="Author" content="MyFreeTemplates.com">
<META NAME="robots" CONTENT="index, follow"> <!-- (Robot commands: All, None, Index, No Index, Follow, No Follow) -->
<!--META NAME="revisit-after" CONTENT="30 days">
<META NAME="distribution" CONTENT="global">
<META NAME="rating" CONTENT="general">
<META NAME="Content-Language" CONTENT="english" -->
<script language="JavaScript" type="text/JavaScript" src="images/myfreetemplates.js"></script>
<script language="JavaScript" type="text/JavaScript" src="cms/eRecruitment/js/menus.js"></script>
<script language="JavaScript" type="text/JavaScript" src="cms/eRecruitment/js/dropdown.js"></script>

<script language="JavaScript">

function go()
{
		 if (document.form1.kadpengenalan.value == '') {
            alert("Sila Masukkan No Kad Pengenalan");
            document.form1.kadpengenalan.focus();
    	  }
      	else if (document.form1.password.value == '') {
            alert("Sila Masukkan Kata Laluan");
            document.form1.password.focus();
		 }
		 else {
		document.form1.action="eRecruitment.jsp?action=login";
        document.form1.submit();
		}
}
//-->
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
<TABLE WIDTH=775 height="568" BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
	        <TR>
	          <TD height="196" colspan="3"><TABLE WIDTH=775 BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
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
                <TD><a href="eRecruitment.jsp"><IMG NAME="btn_home" SRC="cms/eRecruitment/images/lamanutamaputih.gif" BORDER=0 ALT=""></a></TD>
                <TD><a href="eRecruitment.jsp?action=contact"><IMG SRC="cms/eRecruitment/images/contactusputih.gif" ALT="" NAME="btn_contactus1" BORDER=0 id="btn_contactus1"></a></TD>
        <TD><a href="eRecruitment.jsp?action=admin" target="_blank"><IMG SRC="cms/eRecruitment/images/admin.gif" ALT="" NAME="btn_contactus1" BORDER=0 id="btn_contactus1"></a></TD>
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
      
    <TD width="221" valign="top" bgcolor="#F3F3F3" class='style2'><form name="form1" method="post" action="">
        <table width="90%" border="0" align="center" class='style2'>
          <tr> 
            <td height="40"> <div align="left"><strong>Pemohon Berdaftar</strong></div></td>
          </tr>
          <tr> 
            <td><div align="center">No Kad Pengenalan</div></td>
          </tr>
          <tr> 
            <td><div align="center"> 
                <input name="kadpengenalan" type="text" id="kadpengenalan" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" maxlength="12">
              </div></td>
          </tr>
          <tr> 
            <td><div align="center">Kata Laluan</div></td>
          </tr>
          <tr> 
            <td><div align="center"> 
                <input name="password" type="password" id="password" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
              </div></td>
          </tr>
          <tr> 
            <td><div align="center"> <INPUT name="image" type=image class=img src="cms/eRecruitment/images/btn.login.gif" width="65" height="19" onClick="javascript:go();"><!--A HREF="javascript:go();" onMouseOver="window.status='Login';return true;"><img src="cms/eRecruitment/images/btn.login.gif" width="65" height="19" BORDER="0"></a --></div></td>
          </tr>
          <tr> 
            <td height="30" valign="bottom"> <div align="center"><a href="javascript:void(window.open('eRecruitment.jsp?action=lupakatalaluan','statistics', 'height=300,width=700,menubar=no,toolbar=no,scrollbars=yes'))" onMouseOver="window.status='Lupa Kata Laluan';return true;">Lupa 
                Kata Laluan?</a></div></td>
          </tr>
        </table>
      </form> 
      <br>
      <br>
      <table width="95%" border="0" align="center" class='style2'>
        <tr>
          <td><strong>Pemohon BARU?</strong><br>
            Anda dikehendaki mendaftarkan maklumat mengenai diri anda bagi memasuki 
            laman e-Recruitment. <br>
            <br>
            Sila <a href="eRecruitment.jsp?action=daftar"><font color="#0000FF">DAFTAR</font></a> 
            di sini.</td>
        </tr>
      </table>
      <p>&nbsp;</p></TD>
		<TD width="537" valign="top"><TABLE height="354" BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
        <TR> 
          <TD width="343" height="270" valign="top" style="padding-left:0; "><br>
            <table width="99%" border="0" align="right" cellspacing="0">
              <tr> 
                <td style="padding-left:0;"><img src="cms/eRecruitment/images/pengumuman.gif" width="153" height="22"> 
                <br>
                <span class="style2"><STRONG><font color="#FF0000">**</font> For Non-citizen, please click  
                <a href="http://pendaftar.ump.edu.my/index.php?option=com_content&view=article&id=70%3Aemployment-type&catid=35&Itemid=100" target="_blank"><font color="#0000FF">here.</font></a></STRONG></span></td>
              </tr>
              <tr>
                <td height="100" bgcolor="#E0E0E0"> 
                  <table width="100%" border="0" cellspacing="0" bgcolor="#FFFFFF">
                    <tr> 
                      <td height="180"> 
                        &nbsp;&nbsp;<iframe ID=IFrame1 FRAMEBORDER=0 SCROLLING=NO height="180" width="320" src="cms/eRecruitment/info.jsp" hspace="" vspace="" ></iframe></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <table width="99%" border="0" align="right" cellspacing="0">
              <tr> 
                <td  style="padding-left:0;"><img src="cms/eRecruitment/images/temuduga.gif" width="153" height="22"> 
                </td>
              </tr>
              <tr> 
                <td height="70" bgcolor="#E0E0E0"> <table width="100%" height="100%" border="0" cellspacing="0" bgcolor="#FFFFFF">
                    <tr> 
                      <td height="70">&nbsp;&nbsp;<iframe ID=IFrame1 FRAMEBORDER=0 SCROLLING=NO height="60" width="320" src="cms/eRecruitment/temuduga.jsp" hspace="" vspace="" ></iframe></td>
                    </tr>
                  </table></td>
              </tr>
            </table> 
            <p><br>
          </p></TD>
          <TD width="194" valign="top"><TABLE BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
              <TR> 
                <TD colspan="-11"> <div align="right"><br>
                    <img src="cms/eRecruitment/images/academic.gif" width="170" height="102"><br>
                    <br>
                  </div>
                  <table width="100%" border="0" cellspacing="0" class='style2'>
                    <tr>
                      <td> &nbsp;&nbsp;&nbsp;&nbsp;<strong>Jawatan Akademik<br>
                        </strong>&nbsp;&nbsp;&nbsp;&nbsp;<img src="cms/eRecruitment/images/26.gif" width="10" height="7"> 
                       <%-- Tiada Sebarang Perjawatan--%>
                        <!--a href="javascript:void(window.open('cms/eRecruitment/attachment/JAWATAN_AKADEMIK_TAHUN_2011.pdf','statistics', 'height=600,width=800,menubar=no,toolbar=no,scrollbars=yes'))" onMouseOver="window.status='Jawatan Akademik';return true;">Maklumat 
                        Lanjut</a -->
                        <a href="javascript:void(window.open('cms/eRecruitment/attachment/PENGIKLANAN JAWATAN_AKADEMIK_TAHUN_2012_docx.pdf','statistics', 'height=600,width=800,menubar=no,toolbar=no,scrollbars=yes'))" onMouseOver="window.status='Jawatan Akademik';return true;">Maklumat 
                        Lanjut</a><br>
                       <%-- <em>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(WargaNegara)</em><br>
                        <br>
                        &nbsp;&nbsp;&nbsp;&nbsp;<img src="cms/eRecruitment/images/26.gif" width="10" height="7"><a href="http://pendaftar.ump.edu.my/index.php?option=com_content&view=article&id=56&Itemid=20" onMouseOver="window.status='Jawatan Akademik';return true;" target="_blank"> Maklumat 
                      Lanjut<br>
                      <em>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(Bukan WargaNegara)</em>                        </a>--%></td>
                    </tr>
                  </table>
                </TD>
              </TR>
              <TR> 
                <TD colspan="-11"> <div align="right"><IMG SRC="cms/eRecruitment/images/spacer.gif" WIDTH=130 HEIGHT=18 ALT=""></div></TD>
              </TR>
              <TR> 
                <TD colspan="-11"><div align="right"><img src="cms/eRecruitment/images/xacademic.gif" width="170" height="102"><br>
                    <br>
                  </div>
                  <table width="100%" border="0" cellspacing="0" class='style2'>
                    <tr>
                      <td>&nbsp;&nbsp;&nbsp;&nbsp;<strong>Jawatan Bukan Akademik</strong> 
                        <div id="OptionListDiv" style="position:absolute; top:0; left:-500; z-index:65535; visibility:visible;"></div>
                        <br>
                        
                                                       
                        <!--a href="javascript:void(window.open('cms/eRecruitment/jawatannonakademik.jsp','statistics', 'height=700,width=900,menubar=no,toolbar=no,scrollbars=yes'))" onMouseOver="window.status='Jawatan Non Akademik';return true;">Maklumat 
                        Lanjut</a> <br-->
                        &nbsp;&nbsp;&nbsp;&nbsp;<img src="cms/eRecruitment/images/26.gif" width="10" height="7">                                
                        <a href="javascript:void(window.open('cms/eRecruitment/attachment/Iklan jawatan kosong UMP Siri 13-2012 e-Recruit_doc.pdf','statistics', 'height=700,width=900,menubar=no,toolbar=no,scrollbars=yes'))" onMouseOver="window.status='Jawatan Non Akademik';return true;">Maklumat 
                        Iklan</a> &nbsp;&nbsp;<IMG SRC="cms/eRecruitment/images/baru.gif" width="25" height="10" ALT=""><br>
                        &nbsp;&nbsp;&nbsp;&nbsp; <br>
                        
                        <!--a href="#" onMouseOver="ShowMenu(this,'LinkArray1')" onMouseOut="timer=setTimeout('HideDiv()',500);">Maklumat 
                        Lanjut</a--> </td>
                    </tr>
                  </table>
                </TD>
              </TR>
              <TR> 
                <TD colspan="-11"> <div align="right"><IMG SRC="cms/eRecruitment/images/spacer.gif" WIDTH=130 HEIGHT=18 ALT=""></div></TD>
              </TR>
            </TABLE></TD>
        </TR>
      </TABLE></TD>
        <TD width="17" valign="top"><IMG SRC="cms/eRecruitment/images/x3a_25.gif" WIDTH=17 HEIGHT=254 ALT=""></TD>
    </TR>
	<TR>
	  
    <TD colspan="3">
<TABLE WIDTH=775 BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
        <TR bgcolor="#666666"> 
          <TD height="30" class='style2'><div align="center"><font color="#FFFFFF" size="1">&copy; 
              2008 Hakcipta Terpelihara Pejabat Pendaftar, Universiti Malaysia 
              Pahang <br>
              Sesuai dipapar menggunakan IE versi 6.0 dan ke atas dengan resolusi 
              1024 x 768 </font></div></TD>
        </TR>
      </TABLE></TD>
  </TR>
</TABLE>
<p align="center"><!-- Histats.com  START  -->
<a href="http://www.histats.com" target="_blank" title="page hit counter" ><script  type="text/javascript" language="javascript">
var s_sid = 492965;var st_dominio = 4;
var cimg = 241;var cwi =241;var che =20;
</script></a>
<script  type="text/javascript" language="javascript" src="http://s10.histats.com/js9.js"></script><div align="center"><noscript>
  <a href="http://www.histats.com" target="_blank">
  <img  src="http://s4.histats.com/stats/0.gif?492965&1" alt="page hit counter" border="0"></a>
  </noscript>
  <!-- Histats.com  END  -->
  </p>
</div>
</BODY>
</HTML>