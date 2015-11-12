<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>

<html>
<head>
<title>:: Message ::</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<%	//Connection...
	Connection conn = null;
    String kadpengenalan=request.getParameter("kadpengenalan");
    String nama = request.getParameter("nama");
	String password = request.getParameter("password");
	String repassword = request.getParameter("repassword");
	String email = request.getParameter("email");
	String namaibu = request.getParameter("namaibu");
	String action = request.getParameter("action");
	PreparedStatement pstmt = null;
         
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

<% if(conn !=null && action!=null && action.equals("register") && request.getParameter("kadpengenalan") != null && request.getParameter("nama") != null && request.getParameter("password") != null && request.getParameter("repassword") !=null && request.getParameter("email") != null && request.getParameter("namaibu") != null)
{

String sql_inst = "insert into erecruitment_registration (er_ic_no,er_nama,er_password,er_verifypassword,er_emel,er_namaibu,er_date_register)"+
                  "values (?, ?, ?, ?, ?, ?, sysdate) ";
	try
	{
		pstmt = conn.prepareStatement(sql_inst);
		pstmt.setString(1, kadpengenalan);
		pstmt.setString(2, nama);
		pstmt.setString(3, password);
		pstmt.setString(4, repassword);
		pstmt.setString(5, email);
		pstmt.setString(6, namaibu);
		int rc= pstmt.executeUpdate();
		if(rc>0)
		{ 
%>
<table width="80%" border="0">
  <tr> 
    <td width="74%" align="left" valign="middle"><font color='#FF0000' size='2' face='Arial, Helvetica, sans-serif'>Pendaftaran 
      anda telah berjaya! Sila Cetak Untuk Rujukan.</font></td>
    <td width="26%" align="left" valign="middle"><font color='#FF0000' size='2' face='Arial, Helvetica, sans-serif'>.<a href='eRecruitment.jsp?action=print_detail&kadpengenalan=<%=kadpengenalan%>' target='_blank'><img src="cms/eRecruitment/images/ic_printer.gif" border="0"></a></font></td>
  </tr>
</table>
<br>
<%	}	else
		{ 
%><font color='#FF0000' size='2' face='Arial, Helvetica, sans-serif'>Pendaftaran anda tidak berjaya!</font><br><br>
<%	}	
        pstmt.close ();

	}
     	catch (SQLException e)
        	{out.println ("<font color='#FF0000' size='2' face='Arial, Helvetica, sans-serif'>Permohonan anda tidak berjaya atau anda telah membuat permohonan.Sila login jika permohonan telah dibuat.</font>");   }
		finally {
  try {
  	  if (pstmt !=null) pstmt.close ();
      if (conn != null) conn.close();    
  }
  catch (Exception e) { }
  }
		}
%>









</body>
</html>




