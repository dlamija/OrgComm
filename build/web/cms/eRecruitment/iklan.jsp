<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="stream" scope="page" class="CommonFunction"/>

<%

	String msg ="";
	Connection conn=null;
	String action = request.getParameter("action");
	String type = request.getParameter("type");
	String content = request.getParameter("content");
	String jenis = request.getParameter("jenis");
	boolean flag = false ;
	ResultSet rset = null;
	PreparedStatement pstmt = null;

%>
<%
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
if(conn!=null)
{
String sql	=	"SELECT RA_TYPE,RA_CONTENT FROM RECRUITMENT_ADVERTISMENT "+
				"WHERE RA_TYPE = '"+ jenis + "' "+
				"AND SYSDATE <= RA_CLOSING_DATE";
				

	try
	{
		pstmt = conn.prepareStatement(sql);
		rset = pstmt.executeQuery ();
		if (rset.next())
		{
		type = rset.getString (1);
		content = stream.stream2String(rset.getAsciiStream("RA_CONTENT"));
		flag = true;
		}
		pstmt.close ();
	}
	catch (SQLException e)
	{ out.println ("Error select advertismentID: " + e.toString ());}
	finally {
		try {
			if (rset != null) rset.close();
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
		}
		catch (Exception e) { }
	}
}
%>
<html>
<head>
<title>.: eRecruitment :.</title>
<style type="text/css">
<!--
.style16 {font-size: 12px; font-style:normal}
.tengah {
	text-align: center;
}
-->
</style>
</head>

<body>
<table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td class="tengah"><img src="images/jawatankosong.jpg" alt="d" width="632"></td>
  </tr>
  <tr>
    <td height="121" align="center"><font size="2" face="Arial, Helvetica, sans-serif"><span class="style16">(<em>Dahulunya 
                                                  dikenali sebagai Kolej Universiti 
                                                  Kejuruteraan &amp; Teknologi 
                                                  Malaysia KUKTEM</em>)<br />
Kami adalah sebuah institusi 
                                                  pendidikan tinggi awam yang 
                                                  menjurus kepada bidang kejuruteraan 
                                                  dan teknikal berteknologi tinggi 
                                                  serta beriltizam menjadi salah 
                                                  satu universiti yang bertaraf 
                                                  dunia berasaskan teknikal mempelawa 
                                                  calon-calon intelektual dan 
                                                  cintakan ilmu untuk sama-sama 
                                                  menyumbang tenaga dan idea bagi 
                                                  melahirkan insan cemerlang dengan 
                                                  mengisi kekosongan jawatan di 
    UMP.</span></font></td>
  </tr>
  <tr>
    <td height="121" align="left" valign="top"><%=( ( content==null)?"<font size='2' face='Arial, Helvetica, sans-serif'><strong><center>Tiada permohonan dibuka buat masa sekarang. Harap maklum</center></strong></font>":content )%></td>
  </tr>
</table>
</body>
</html>
