<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ page import="common.Messages" %>

<%
	Connection conn = null;
	String kadpengenalan= (String)session.getAttribute("kadpengenalan");
	String refid2 = request.getParameter("refid2");
	String refid = request.getParameter("refid");
	String ic_no =  request.getParameter("ic_no");
	String feedbackmsg = request.getParameter("feedbackmsg");
	String email = request.getParameter("email");
	PreparedStatement pstmt = null; 
	ResultSet rset = null;
	PreparedStatement pstmt_refid2 = null; 
	ResultSet rset_refid2 = null;
	boolean flag = false; 
	
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
String sql	= "SELECT SCH_REF_ID REFID,LOWER(SCH_EMAIL_ADDR) FROM STAFF_CANDIDATE_HEAD "+
			  "WHERE SCH_IC_NUM='" + ic_no +"' AND SCH_ARCHIVE='N' "+
			  "AND SUBSTR(SCH_REF_ID, 0,4) = TO_CHAR(SYSDATE,'YYYY') ";
//System.out.println(sql);
try
{
	pstmt = conn.prepareStatement(sql); 
	rset 			= pstmt.executeQuery();
	if (rset.next())
	{
		refid2 = rset.getString (1);
		email = rset.getString (2);

	}
	rset.close();
	pstmt.close();
}
	catch (SQLException e)
		{ out.println ("Error : " + e.toString ()); }
	finally {
  try {
      if (rset != null) rset.close();
	  if (pstmt != null) pstmt.close();
  }
  catch (Exception e) { }
 }
 }
%>
<% if (refid2 != null){%>
      <%@include file="/cms/eRecruitment/apply/feedBackEmail.jsp" %>
<%}%>
<%
if (refid2 != null)
{
String sql	= "SELECT 1 FROM ERECRUITMENT_SURVEY "+
			  "WHERE ES_CANDIDATE_REF_ID='" + refid2 +"' ";

//System.out.println(sql);
try
{
	pstmt_refid2 = conn.prepareStatement(sql); 
	rset_refid2 			= pstmt_refid2.executeQuery();
	if (rset_refid2.next())
	{
		flag = true;
	}
	rset_refid2.close();
	pstmt_refid2.close();
}
	catch (SQLException e)
		{ out.println ("Error : " + e.toString ()); }
	finally {
  try {
       if (rset_refid2 != null) rset_refid2.close();
	  if (pstmt_refid2 != null) pstmt_refid2.close();
  }
  catch (Exception e) { }
 }
 }
%>

<% if (refid2!=null || !flag ) {%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
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
	color: #0000FF;
	TEXT-DECORATION: none;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
}
	.DropDownSubBox{border:1px solid #006699; background-color:#ccccff;}
	.DropDownSubText{font-family:arial; font-size:10px; color:#000066;	font-weight:bold; text-decoration:none; cursor:hand; height:15px;}

-->
</style>
<SCRIPT LaNGUAGE="JavaScript"> 

function checkRadio (frmName, rbGroupName) { 
 var radios = document[frmName].elements[rbGroupName]; 
 for (var i=0; i <radios.length; i++) { 
  if (radios[i].checked) { 
   return true; 
  } 
 } 
 return false; 
} 

function valFrm() { 
 if (!checkRadio("form1","ANS_01")) 
  alert("Sila Pilih Jawapan Bagi Soalan No 1 Bahagian A"); 
 else if (!checkRadio("form1","ANS_02")) 
  alert("Sila Pilih Jawapan Bagi Soalan No 2 Bahagian A"); 
 else if (!checkRadio("form1","ANS_03")) 
  alert("Sila Pilih Jawapan Bagi Soalan No 3 Bahagian A");
 else if (!checkRadio("form1","ANS_04")) 
  alert("Sila Pilih Jawapan Bagi Soalan No 4 Bahagian A"); 
 else if (!checkRadio("form1","ANS_01A")) 
  alert("Sila Pilih Jawapan Bagi Soalan No 1A Bahagian B"); 
 else if (!checkRadio("form1","ANS_01B")) 
  alert("Sila Pilih Jawapan Bagi Soalan No 1B Bahagian B");
 else if (!checkRadio("form1","ANS_01C")) 
  alert("Sila Pilih Jawapan Bagi Soalan No 1C Bahagian B");
 else if (!checkRadio("form1","ANS_02A")) 
  alert("Sila Pilih Jawapan Bagi Soalan No 2A Bahagian B");
 else if (!checkRadio("form1","ANS_02B")) 
  alert("Sila Pilih Jawapan Bagi Soalan No 2B Bahagian B");
   else if (!checkRadio("form1","ANS_02C")) 
  alert("Sila Pilih Jawapan Bagi Soalan No 2C Bahagian B");
  //else if (document.form1.ANS_02D.value=='')
   //alert("Sila Masukkan Cadangan Anda");
 else if (checkRadio("form1","ANS_01")||checkRadio("form1","ANS_02") ||checkRadio("form1","ANS_03")||checkRadio("form1","ANS_04")||checkRadio("form1","ANS_01A")
||checkRadio("form1","ANS_01B")||checkRadio("form1","ANS_01C")||checkRadio("form1","ANS_02A")||checkRadio("form1","ANS_02B")
||checkRadio("form1","ANS_02C")||document.form1.ANS_02D.value!=''){
 		document.form1.action="eRecruitment.jsp?action=sendSurvey&refid=<%=refid%>&ic_no=<%=ic_no%>";
    	document.form1.submit();}
} 
function taLimit() {
	var taObj=event.srcElement;
	if (taObj.value.length==taObj.maxLength*1) return false;
}

function taCount(visCnt) { 
	var taObj=event.srcElement;
	if (taObj.value.length>taObj.maxLength*1) taObj.value=taObj.value.substring(0,taObj.maxLength*1);
	if (visCnt) visCnt.innerText=taObj.maxLength-taObj.value.length;
}

</SCRIPT> 


<body>
<table width="90%" border="0" align="center" class="style2">
  <tr> 
    <td><div align="right"></div>
      <div align="center"><strong><font size="2">BORANG SOAL SELIDIK SISTEM PERMOHONAN 
        JAWATAN SECARA ONLINE<br>
        ( eRecruitment )</font></strong></div></td>
  </tr>
</table>
<form name="form1" method="post" action="">
  <table width="90%" border="0" align="center" cellspacing="0" bgcolor="#666666">
    <tr>
      <td><table width="100%" border="0" align="center" cellspacing="0" bgcolor="#EAF4FF" class="style2">
          <tr cellspacing="0"> 
            <td width="15%" colspan="6">
              <table width="100%" border="0" cellpadding="0" cellspacing="0" class="style2">
                <tr>
                  <td width="7%"><strong><img src="cms/eRecruitment/images/surveyIcon.gif" width="60" height="45"></strong></td>
                  <td width="93%"><strong>Berikan penilaian anda terhadap kenyataan 
                    berikut :</strong></td>
                </tr>
              </table> 
              <table width="85%" border="0" align="center" cellspacing="0" bgcolor="#EAF4FF" class="style2">
                <tr> 
                  <td height="30" colspan="6"><strong>BAHAGIAN A</strong></td>
                </tr>
                <tr> 
                  <td width="5%"><div align="center">1.</div></td>
                  <td height="50" colspan="5">Laman eRecruitment UMP ini mudah 
                    diakses </td>
                </tr>
                <tr> 
                  <td colspan="6"> <div align="center"> 
                      <table width="95%" border="0" align="right" cellpadding="4" cellspacing="0">
                        <tr bgcolor="#E5E5E5"> 
                          <td colspan="2" bgcolor="#E5E5E5" class="style2"> <div align="center">Tidak 
                              Memuaskan</div></td>
                          <td width="22%" class="style2"> <div align="center">Kurang 
                              Memuaskan</div></td>
                          <td width="16%" class="style2"> <div align="center">Memuaskan</div></td>
                          <td width="23%" class="style2"> <div align="center">Sangat 
                              Memuaskan</div></td>
                          <td width="15%" class="style2"> <div align="center">Cemerlang</div></td>
                        </tr>
                        <tr bgcolor="#E5E5E5"> 
                          <td colspan="2" class="style2"> <div align="center"> 
                              <input type="radio" name="ANS_01" value="1">
                            </div></td>
                          <td class="style2"> <div align="center"> 
                              <input type="radio" name="ANS_01" value="2">
                            </div></td>
                          <td class="style2"> <div align="center"> 
                              <input type="radio" name="ANS_01" value="3">
                            </div></td>
                          <td class="style2"> <div align="center"> 
                              <input type="radio" name="ANS_01" value="4">
                            </div></td>
                          <td class="style2"> <div align="center"> 
                              <input type="radio" name="ANS_01" value="5">
                            </div></td>
                        </tr>
                      </table>
                    </div></td>
                </tr>
                <tr> 
                  <td><div align="center">2.</div></td>
                  <td height="50" colspan="5">Paparan di laman ini menarik dan 
                    mesra pengguna </td>
                </tr>
                <tr> 
                  <td colspan="6"> <div align="center"> 
                      <table width="95%" border="0" align="right" cellpadding="4" cellspacing="0">
                        <tr bgcolor="#E5E5E5"> 
                          <td class="style2"> <div align="center">Tidak Memuaskan</div></td>
                          <td width="22%" class="style2"> <div align="center">Kurang 
                              Memuaskan</div></td>
                          <td width="16%" class="style2"> <div align="center">Memuaskan</div></td>
                          <td width="23%" class="style2"> <div align="center">Sangat 
                              Memuaskan</div></td>
                          <td width="15%" class="style2"> <div align="center">Cemerlang</div></td>
                        </tr>
                        <tr bgcolor="#E5E5E5"> 
                          <td class="style2"> <div align="center"> 
                              <input type="radio" name="ANS_02" value="1">
                            </div></td>
                          <td class="style2"> <div align="center"> 
                              <input type="radio" name="ANS_02" value="2">
                            </div></td>
                          <td class="style2"> <div align="center"> 
                              <input type="radio" name="ANS_02" value="3">
                            </div></td>
                          <td class="style2"> <div align="center"> 
                              <input type="radio" name="ANS_02" value="4">
                            </div></td>
                          <td class="style2"> <div align="center"> 
                              <input type="radio" name="ANS_02" value="5">
                            </div></td>
                        </tr>
                      </table>
                    </div></td>
                </tr>
                <tr> 
                  <td><div align="center">3.</div></td>
                  <td height="50" colspan="5">Maklumat yang dipaparkan mempunyai 
                    informasi yang lengkap dan sangat membantu </td>
                </tr>
                <tr> 
                  <td height="50" colspan="6"><table width="95%" border="0" align="right" cellpadding="4" cellspacing="0">
                      <tr bgcolor="#E5E5E5"> 
                        <td colspan="2" class="style2"> <div align="center">Tidak 
                            Memuaskan</div></td>
                        <td width="22%" class="style2"> <div align="center">Kurang 
                            Memuaskan</div></td>
                        <td width="16%" class="style2"> <div align="center">Memuaskan</div></td>
                        <td width="23%" class="style2"> <div align="center">Sangat 
                            Memuaskan</div></td>
                        <td width="15%" class="style2"> <div align="center">Cemerlang</div></td>
                      </tr>
                      <tr bgcolor="#E5E5E5"> 
                        <td colspan="2" class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_03" value="1">
                          </div></td>
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_03" value="2">
                          </div></td>
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_03" value="3">
                          </div></td>
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_03" value="4">
                          </div></td>
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_03" value="5">
                          </div></td>
                      </tr>
                    </table></td>
                </tr>
                <tr> 
                  <td><div align="center">4.</div></td>
                  <td height="50" colspan="5">Dari sumber manakah anda mendapat 
                    maklumat Iklan Perjawatan di UMP ? </td>
                </tr>
                <tr> 
                  <td colspan="6"><table width="95%" border="0" align="right" cellpadding="4" cellspacing="0">
                      <tr bgcolor="#E5E5E5" class="style2"> 
                        <td width="24%"> <div align="center">Surat Khabar</div></td>
                        <td> <div align="center">Carian di Internet</div></td>
                        <td> <div align="center">Keluarga</div></td>
                        <td> <div align="center">Kawan-kawan</div></td>
                        <td> <div align="center">Lain-lain sumber</div></td>
                      </tr>
                      <tr bgcolor="#E5E5E5"> 
                        <td bgcolor="#E5E5E5" class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_04" value="Surat Khabar">
                          </div></td>
                        <td width="22%" class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_04" value="Carian di Internet">
                          </div></td>
                        <td width="16%" class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_04" value="Keluarga">
                          </div></td>
                        <td width="17%" class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_04" value="Kawan-kawan">
                          </div></td>
                        <td width="21%" class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_04" value="Lain-lain sumber">
                          </div></td>
                      </tr>
                    </table></td>
                </tr>
                <tr> 
                  <td colspan="2">&nbsp;</td>
                  <td width="29%">&nbsp;</td>
                  <td width="12%">&nbsp;</td>
                  <td width="20%">&nbsp;</td>
                  <td width="22%">&nbsp;</td>
                </tr>
                <tr>
                  <td height="30" colspan="6"><strong>BAHAGIAN B</strong></td>
                </tr>
                <tr> 
                  <td height="20" colspan="6"><strong>&nbsp;&nbsp;Bantuan Khidmat Pelanggan 
                    :</strong></td>
                </tr>
                <tr> 
                  <td><div align="center">1.</div></td>
                  <td height="50" colspan="5">Sejauh manakah bantuan Khidmat Pelanggan 
                    kami dapat memberikan kepuasan kepada anda ?</td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                  <td height="30" colspan="5"><strong>a. Melalui Panggilan Telefon 
                    </strong></td>
                </tr>
                <tr> 
                  <td height="30" colspan="6"><table width="95%" border="0" align="right" cellpadding="4" cellspacing="0">
                      <tr bgcolor="#E5E5E5"> 
                        <td class="style2"> <div align="center">Tidak Memuaskan</div></td>
                        <td width="22%" class="style2"> <div align="center">Kurang 
                            Memuaskan</div></td>
                        <td width="16%" class="style2"> <div align="center">Memuaskan</div></td>
                        <td width="23%" class="style2"> <div align="center">Sangat 
                            Memuaskan</div></td>
                        <td width="15%" class="style2"> <div align="center">Cemerlang</div></td>
                      </tr>
                      <tr bgcolor="#E5E5E5"> 
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_01A" value="1">
                          </div></td>
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_01A" value="2">
                          </div></td>
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_01A" value="3">
                          </div></td>
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_01A" value="4">
                          </div></td>
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_01A" value="5">
                          </div></td>
                      </tr>
                    </table></td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                  <td height="30" colspan="5"><strong>b. Melalui Jaringan Emel 
                    </strong></td>
                </tr>
                <tr> 
                  <td height="30" colspan="6"><table width="95%" border="0" align="right" cellpadding="4" cellspacing="0">
                      <tr bgcolor="#E5E5E5"> 
                        <td class="style2"> <div align="center">Tidak Memuaskan</div></td>
                        <td width="22%" class="style2"> <div align="center">Kurang 
                            Memuaskan</div></td>
                        <td width="16%" class="style2"> <div align="center">Memuaskan</div></td>
                        <td width="23%" class="style2"> <div align="center">Sangat 
                            Memuaskan</div></td>
                        <td width="15%" class="style2"> <div align="center">Cemerlang</div></td>
                      </tr>
                      <tr bgcolor="#E5E5E5"> 
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_01B" value="1">
                          </div></td>
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_01B" value="2">
                          </div></td>
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_01B" value="3">
                          </div></td>
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_01B" value="4">
                          </div></td>
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_01B" value="5">
                          </div></td>
                      </tr>
                    </table></td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                  <td height="30" colspan="5"><strong>c. Walk In (Datang ke Pejabat) 
                    </strong></td>
                </tr>
                <tr> 
                  <td height="50" colspan="6"><table width="95%" border="0" align="right" cellpadding="4" cellspacing="0">
                      <tr bgcolor="#E5E5E5"> 
                        <td class="style2"> <div align="center">Tidak Memuaskan</div></td>
                        <td width="22%" class="style2"> <div align="center">Kurang 
                            Memuaskan</div></td>
                        <td width="16%" class="style2"> <div align="center">Memuaskan</div></td>
                        <td width="23%" class="style2"> <div align="center">Sangat 
                            Memuaskan</div></td>
                        <td width="15%" class="style2"> <div align="center">Cemerlang</div></td>
                      </tr>
                      <tr bgcolor="#E5E5E5"> 
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_01C" value="1">
                          </div></td>
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_01C" value="2">
                          </div></td>
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_01C" value="3">
                          </div></td>
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_01C" value="4">
                          </div></td>
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_01C" value="5">
                          </div></td>
                      </tr>
                    </table></td>
                </tr>
                <tr> 
                  <td><div align="center">2.</div></td>
                  <td height="50" colspan="5">Anda berasa mudah dan berpuas hati 
                    ketika mengisi maklumat di bahagian-bahagian berikut :</td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                  <td height="30" colspan="5"><strong>a. Maklumat Peribadi </strong></td>
                </tr>
                <tr> 
                  <td colspan="6"><table width="95%" border="0" align="right" cellpadding="4" cellspacing="0">
                      <tr bgcolor="#E5E5E5"> 
                        <td class="style2"> <div align="center">Tidak Memuaskan</div></td>
                        <td width="22%" class="style2"> <div align="center">Kurang 
                            Memuaskan</div></td>
                        <td width="16%" class="style2"> <div align="center">Memuaskan</div></td>
                        <td width="23%" class="style2"> <div align="center">Sangat 
                            Memuaskan</div></td>
                        <td width="15%" class="style2"> <div align="center">Cemerlang</div></td>
                      </tr>
                      <tr bgcolor="#E5E5E5"> 
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_02A" value="1">
                          </div></td>
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_02A" value="2">
                          </div></td>
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_02A" value="3">
                          </div></td>
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_02A" value="4">
                          </div></td>
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_02A" value="5">
                          </div></td>
                      </tr>
                    </table></td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                  <td height="30" colspan="5"><strong>b. Maklumat Akademik </strong></td>
                </tr>
                <tr> 
                  <td colspan="6"><table width="95%" border="0" align="right" cellpadding="4" cellspacing="0">
                      <tr bgcolor="#E5E5E5"> 
                        <td class="style2"> <div align="center">Tidak Memuaskan</div></td>
                        <td width="22%" class="style2"> <div align="center">Kurang 
                            Memuaskan</div></td>
                        <td width="16%" class="style2"> <div align="center">Memuaskan</div></td>
                        <td width="23%" class="style2"> <div align="center">Sangat 
                            Memuaskan</div></td>
                        <td width="15%" class="style2"> <div align="center">Cemerlang</div></td>
                      </tr>
                      <tr bgcolor="#E5E5E5"> 
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_02B" value="1">
                          </div></td>
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_02B" value="2">
                          </div></td>
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_02B" value="3">
                          </div></td>
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_02B" value="4">
                          </div></td>
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_02B" value="5">
                          </div></td>
                      </tr>
                    </table></td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                  <td height="30" colspan="5"> <strong>c. Maklumat Pengalaman 
                    </strong></td>
                </tr>
                <tr> 
                  <td colspan="6"><table width="95%" border="0" align="right" cellpadding="4" cellspacing="0">
                      <tr bgcolor="#E5E5E5"> 
                        <td class="style2"> <div align="center">Tidak Memuaskan</div></td>
                        <td width="22%" class="style2"> <div align="center">Kurang 
                            Memuaskan</div></td>
                        <td width="16%" class="style2"> <div align="center">Memuaskan</div></td>
                        <td width="23%" class="style2"> <div align="center">Sangat 
                            Memuaskan</div></td>
                        <td width="15%" class="style2"> <div align="center">Cemerlang</div></td>
                      </tr>
                      <tr bgcolor="#E5E5E5"> 
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_02C" value="1">
                          </div></td>
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_02C" value="2">
                          </div></td>
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_02C" value="3">
                          </div></td>
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_02C" value="4">
                          </div></td>
                        <td class="style2"> <div align="center"> 
                            <input type="radio" name="ANS_02C" value="5">
                          </div></td>
                      </tr>
                    </table></td>
                </tr>
                <tr> 
                  <td colspan="2">&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                  <td colspan="5"><br>
                    Jika Penilaian anda adalah TIDAK MEMUASKAN dan KURANG MEMUASKAN, 
                    sila nyatakan cadangan dan saranan di sini :<br> <br> <textarea onKeyPress="return taLimit()" onKeyUp="return taCount(myCounter)"  name="ANS_02D" cols="60" rows="5" id="ANS_02D" maxLength="100"></textarea>
                    <br> &nbsp; <font size="1"><em>You have</em> <SPAN id=myCounter><strong>100</strong></SPAN> 
                    <em>characters remaining for your description<br>
                    </em></font><font size="1"><em><br>
                    </em></font></p></td>
                </tr>
                <tr> 
                  <td height="40" colspan="6"> <div align="right"><A HREF="javascript:valFrm();" onMouseOver="window.status='Kemaskini';return true;"><IMG SRC="cms/eRecruitment/images/ic_hantar.gif" BORDER="0" ALT="Kemaskini"></A></div></td>
                </tr>
              </table>
              <br>
            </td>
          </tr>
        </table></td>
    </tr>
  </table>
  </form>
<p>&nbsp;</p>
</body>
</html>
<% if (conn != null) conn.close();%>

<% } else {
response.sendRedirect("../../eRecruitment.jsp?action=finish&ic_no="+ic_no+"&refid="+refid);
}%>
