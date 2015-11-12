
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<%
String kadpengenalan= (String)session.getAttribute("kadpengenalan");
%>
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

-->
</style>

<body>
<table width="95%" border="0" align="center" class='style2'>
  <tr> 
    <td><p><strong><br>
        No Kad Pengenalan : </strong><%=kadpengenalan%> </p>
      <p>Tahniah! Permohonan anda telah diterima dan akan diproses. Jika anda 
        tidak menerima sebarang maklumbalas dalam masa 6 bulan dari tarikh permohonan 
        ini, permohonan anda adalah dianggap tidak berjaya.</p>
      <p>Pemohon dikehendaki mencetak borang permohonan yang telah diisi melalui 
        bahagian cetak borang/resume. Borang permohonan tersebut hendaklah dihantar 
        bersama-sama dengan resume lengkap dan salinan sijil-sijil ke alamat seperti 
        mana yang dinyatakan seperti di bawah :</p>
      <p>- Sijil SRP/SPM/STPM <br>
        - Diploma<br>
        - Ijazah Sarjana Muda <br>
        - Resume<br>
        - Laporan Penilaian Prestasi Terkini jika anda sedang berkhidmat dengan 
        agensi kerajaan.</p>
      <p>Terima Kasih atas Permohonan Anda.<br>
        <br>
        <strong><br>
        Jabatan Pendaftar<br>
        Universiti Malaysia Pahang<br>
        Lebuhraya Tun Razak<br>
        26300 Gambang,Kuantan<br>
        Pahang Darul Makmur.</strong><br>
        <strong>(U/P Unit Perjawatan &amp; Cuti Belajar) </strong></p>
      </td>
  </tr>
</table>
</body>
</html>
