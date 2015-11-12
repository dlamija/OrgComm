<% String password = request.getParameter("password");%>
<html>
<head>
<title>Lupa Kata Laluan</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<script>
function checkForm()
    {
      if (document.form1.kadpengenalan.value == '') {
            alert("Sila Masukkan No Kad Pengenalan");
            document.form1.kadpengenalan.focus();
      }
   	  else if (document.form1.namaibu.value == '') {
            alert("Sila Masukkan Nama Ibu");
            document.form1.namaibu.focus();
      }
      else {
	  		document.form1.action="eRecruitment.jsp?action=sendkatalaluan";
            document.form1.submit();
			//../../../eRecruitment.jsp?action=sendkatalaluan
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
<body onload="setTextFieldToUpper();">
<form name="form1" method="post" action="">
  <table width="80%" border="0" align="center">
    <tr> 
      <td><div align="center"><img src="cms/eRecruitment/images/permohonanonline.jpg" width="632" height="41"><br>
          <table width="80%" border="0" align="center" cellspacing="1" class='style2'>
            <tr> 
              <td width="100%" height="30"> 
                <div align="center"><strong>Terlupa Kata Laluan?</strong></div></td>
            </tr>
            <tr bordercolor="#C1E0FF" bgcolor="#C1E0FF"> 
              <td height="50" bgcolor="#C1E0FF"> 
                <table width="100%" border="0" align="center" cellspacing="0" class='style2'>
                  <tr bordercolor="#C1E0FF" bgcolor="#EAF4FF"> 
                    <td height="50" colspan="2"><strong>&nbsp;&nbsp;Sila masukkan 
                      maklumat berikut :-</strong></td>
                  </tr>
                  <tr bordercolor="#C1E0FF" bgcolor="#EAF4FF"> 
                    <td width="30%"> 
                      <div align="right">No Kad 
                        Pengenalan :</div></td>
                    <td width="70%"> 
                      <input name="kadpengenalan" type="text" id="kadpengenalan2" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" maxlength="12"></td>
                  </tr>
                  <tr bordercolor="#C1E0FF" bgcolor="#EAF4FF"> 
                    <td> 
                      <div align="right">Nama Ibu :</div></td>
                    <td> 
                      <input name="namaibu" type="text" id="namaibu" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" size="50" maxlength="100"></td>
                  </tr>
                  <tr valign="middle" bordercolor="#DDEEFF" bgcolor="#EAF4FF"> 
                    <td height="50" colspan="2"> 
                      <div align="center"> 
					  <A HREF="javascript:checkForm();" onMouseOver="window.status='Submit';return true;"><IMG SRC="cms/eRecruitment/images/ic_submit.gif" BORDER="0" ALT="Submit"></A> 
                      </div></td>
                  </tr>
                </table></td>
            </tr>
            <tr valign="bottom"> 
              <td height="40"><font color="#FF0000"><strong> 
                <textarea style="display:none" name="msg" id="msg">PERMOHONAN KATA LALUAN

Adalah dimaklumkan bahawa tuan/puan/cik telah memohon kata laluan untuk aplikasi eRecruitment Universiti Malaysia Pahang. Berikut adalah maklumat seperti yang dimohon :-


</textarea>
                <textarea style="display:none" name="msg2" id="textarea2">


Sila simpan  kata laluan ini untuk semakan di masa akan datang.

Terima kasih.



Unit Perjawatan, 
Bahagian Sumber Manusia
Jabatan Pendaftar
Universiti Malaysia Pahang,
Karung Berkunci 12,
25000 Kuantan, Pahang Darul Makmur.
Tel : 09-5492522/ 2521/ 2504 
Faks : 09-5492544/ 9181 
</textarea>
                <br>
                PERHATIAN</strong> : Kata laluan akan dihantar ke email yang telah 
                didaftarkan dalam permohonan anda.</font></td>
            </tr>
          </table>
        </div></td>
    </tr>
  </table>
</form>
</body>
</html>
