<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<html>
<head>
<title>Cetakan Maklumat Pengguna</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<%
	Connection conn = null;
	String kadpengenalan= request.getParameter("kadpengenalan");
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
<style type="text/css">
<!--
.style1 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 13px;
	font-weight: bold;
	color: #000000;
}
.style2 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	color: #000000;
}
a {
	color: #333333;
	TEXT-DECORATION: none;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
}
-->
</style>
<body onLoad="window.print()">
<table width="70%" border="0" align="center" class='style1'>
  <tr> 
    <td valign="top"><p><font size="4"><br>
        <font size="3">PERMOHONAN JAWATAN SECARA ONLINE<br>
        UNIVERSITI MALAYSIA PAHANG</font></font><br>
        <em>http://www.ump.edu.my</em></p>
      <p><em><font size="2">(Cetakan Borang Pendaftaran Perjawatan Atas Talian)</font></em></p></td>
    <td width="30%"><div align="right"><img src="cms/eRecruitment/images/logo.gif" width="250" height="126"></div></td>
  </tr>
</table>
<table width="70%" border="0" align="center">
  <tr> 
    <td width="100%"> <hr> </td>
  </tr>
  <tr> 
    <td height="70"><font color='#000000' size='2' face='Arial, Helvetica, sans-serif' class="style2">Terima 
      kasih kerana memilih Universiti Malaysia Pahang sebagai pilihan permohonan 
      pekerjaan anda. Berikut ini adalah maklumat pendaftaran yang telah anda 
      daftar untuk rujukan:</font></td>
  </tr>
  <tr> 
    <td><table width="90%" border="0" align="center" cellspacing="1" class='style2'>
        <tr> 
          <td width="35%"><font size="2" face="Arial, Helvetica, sans-serif"><strong>No 
            Kad Pengenalan </strong></font></td>
          <td width="2%">:</td>
          <td width="63%"> <font size="2" face="Arial, Helvetica, sans-serif"> 
            <%=request.getParameter("kadpengenalan")%> </font></td>
        </tr>
        <tr> 
          <td><font size="2" face="Arial, Helvetica, sans-serif"><strong>Nama 
            Penuh </strong></font></td>
          <td>:</td>
          <td> <font size="2" face="Arial, Helvetica, sans-serif"> <%=nama%> </font></td>
        </tr>
        <tr> 
          <td><font size="2" face="Arial, Helvetica, sans-serif"><strong>Kata 
            Laluan </strong></font></td>
          <td>:</td>
          <td> <font size="2" face="Arial, Helvetica, sans-serif"> <%=password%> 
            </font></td>
        </tr>
        <tr> 
          <td><font size="2" face="Arial, Helvetica, sans-serif"><strong>Emel 
            </strong></font></td>
          <td>:</td>
          <td> <font size="2" face="Arial, Helvetica, sans-serif"> <%=email.toLowerCase()%> 
            </font></td>
        </tr>
        <tr> 
          <td><p><font size="2" face="Arial, Helvetica, sans-serif"><strong>Nama 
              Ibu Kandung</strong> <br>
              <span class="style2">(<em>Jika terlupa kata laluan</em>)</span></font></p></td>
          <td>:</td>
          <td> <font size="2" face="Arial, Helvetica, sans-serif"> <%=namaibu%> 
            </font></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td height="60" class="style2"><br>
        Sebarang pertanyaan, sila hubungi kami :-</p>
      <p>Unit Perjawatan, Bahagian Sumber Manusia<br>
        Jabatan Pendaftar <br>
        Universiti Malaysia Pahang, <br>
        Lebuhraya Tun Razak,<br>
        26300 Gambang,Kuantan<br>
        Pahang Darul Makmur<br>
        Tel : 09-5492522/ 2521/ 2504 <br>
        Faks : 09-5492544/ 9181<br>
        Email : <em>recruitmenthr@ump.edu.my<br>
        </em> </p></td>
  </tr>
</table>
</body>
</html>
