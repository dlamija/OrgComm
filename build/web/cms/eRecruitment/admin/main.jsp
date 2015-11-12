<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="validator" scope="page" class="cms.staff.StaffValidator"/>
<jsp:useBean id="stream" scope="page" class="CommonFunction"/>
<!--script language="JavaScript" src="cms/eRecruitment/js/date-picker.js"></script -->

<%

	String msg ="";
	Connection conn=null;
	String current_date = "";
	String current_time = null;
	String current_day = null;
	String action = request.getParameter("action");
	String sid= (String)session.getAttribute("katanama");
	String staffid = request.getParameter("staffid");
	String type = request.getParameter("type");
	String content = request.getParameter("content");
	String jenis = request.getParameter("jenis");
	String closing = request.getParameter("closing");
	boolean flag = false ;
	ResultSet rset = null;
	PreparedStatement pstmt = null;

	if (request.getParameter("jenis") == null)
		{jenis = "akademik";}
%>
<%
try
	{
		Context initCtx = new InitialContext();
		Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
		DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
		conn = ds.getConnection();
		validator.setDBConnection(conn);
		staffid = validator.getStaffID(sid);
	}
	catch( Exception e )
	{ 
		out.println (e.toString());
	}
		boolean status = false;
	if (validator.isAuthorized(staffid,"ARW001","1.00"))
		status = true;
	else
		status = false;
%>	
<%
 if (status)
 {
%>

<% 
if(conn!=null)
{
String sql	=	"SELECT RA_TYPE,RA_CONTENT,TO_CHAR(RA_CLOSING_DATE,'DD-MM-YYYY') FROM RECRUITMENT_ADVERTISMENT "+
				"WHERE RA_TYPE = '"+ jenis + "' ";
				

	try
	{
		pstmt = conn.prepareStatement(sql);
		rset = pstmt.executeQuery ();
		if (rset.next())
		{
		type = rset.getString (1);
		content = stream.stream2String(rset.getAsciiStream("RA_CONTENT"));
		closing = rset.getString (3);
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
<script language="JavaScript" type="text/JavaScript" src="cms/eRecruitment/js/scw.js"></script>

<head>

<title>.: Admin :.</title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<style type="text/css">
<!--
body,td,th {
	font-size: 10px;
	text-align: right;
}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #666666;
}
#jenis {
	text-align: center;
}
a:link {
	color: #000;
	text-decoration: none;
}
a:visited {
	color: #000;
	text-decoration: none;
}
a:hover {
	color: #000;
	text-decoration: underline;
}
a:active {
	color: #000;
	text-decoration: none;
}
-->
</style></head>
<!-- TinyMCE -->
<script type="text/javascript" src="/umpapps/includes/tinymce/jscripts/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript">
	tinyMCE.init({
		// General options
		//mode : "specific_textareas",
		mode : "exact",
		elements : "freeRTE_content,elm2",
		theme : "advanced",
		plugins : "safari,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template",

		// Theme options
		theme_advanced_buttons1 : "newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect",
		theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,cleanup,code,|,preview,|,forecolor,backcolor",
		theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,print,|,ltr,rtl",
		//theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,pagebreak",
		theme_advanced_toolbar_location : "top",
		theme_advanced_toolbar_align : "left",
		theme_advanced_statusbar_location : "bottom",
		theme_advanced_resizing : true,

		// Example content CSS (should be your site CSS)
		content_css : "css/content.css",

		// Drop lists for link/image/media/template dialogs
		template_external_list_url : "lists/template_list.js",
		external_link_list_url : "lists/link_list.js",
		external_image_list_url : "lists/image_list.js",
		media_external_list_url : "lists/media_list.js",

		// Replace values for the template plugin
		template_replace_values : {
			username : "Some User",
			staffid : "991234"
		}
	});
</script>
<!-- /TinyMCE -->
<script>
function validateForm()
    {
      if (document.newsAdd.title.value == '') {
            alert("Please Insert Title");
            document.newsAdd.title.focus();
      }
	  else if (document.newsAdd.category.value == '') {
            alert("Please Select Category");
            document.newsAdd.category.focus();
	  }
	   else if (document.newsAdd.abstractDetl.value == '') {
            alert("Please Insert Your Abstract");
            document.newsAdd.abstractDetl.focus();
	  }
	  // else if (document.newsAdd.freeRTE_content.value == '') {
        //    alert("Please Insert Your Content Of Body");
         //   document.newsAdd.freeRTE_content.focus();
	  //}
	  else {
	  		//document.form1.action="eRecruitment.jsp?action=editpermohonan";
            document.newsAdd.submit();
      }
	}

function go()
	{
	document.form1.action="eRecruitment.jsp?action=main_admin";
	document.form1.submit();
	}
</script>


<body link="#CCCCCC" vlink="#CCCCCC" alink="#CCCCCC" LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0>
<form name="form1" method="post" action=<% if (flag) {%>"servlet/advServlet?action=edit"<%} else {%>"servlet/advServlet?action=add"<%}%>>
<table width="800" height="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="1" rowspan="2" bgcolor="#000000"><img src="cms/eRecruitment/images/spacer.gif" width="1" height="1"></td> 
    <td bgcolor="#FFFFFF" height="0"><table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 

          <td height="22" background="cms/eRecruitment/images/topbg.gif"><div align="left"><font color="#FFFFFF" size="1" face="Verdana, Arial, Helvetica, sans-serif"><strong>&nbsp;&nbsp;&nbsp;&nbsp;Welcome 
            to Admin Site </strong></font></div></td>

        </tr>

        <tr> 

          <td height="2" background="../images/subnavbg.gif" bgcolor="#FFCC00"><font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif">&nbsp;  <a href="eRecruitment.jsp?action=logout_admin">Logout</a> &nbsp;&nbsp;</font><font color="#FFCC33" size="1" face="Verdana, Arial, Helvetica, sans-serif">&nbsp;</font></td>

        </tr>

        <tr> 
          
          <td height="30" valign="middle"><% if (flag) {%><font style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;"><a href="javascript:void(window.open('/../umpapps/cms/eRecruitment/iklan.jsp?jenis=<%=jenis%>','statistics', 'height=600,width=800,menubar=no,toolbar=no,scrollbars=yes'))" onMouseOver="window.status='Preview';return true;">Preview</a> &nbsp;&nbsp;</strong></font><%}%></td>
          
        </tr>
        <tr>
          <td height="25" valign="top"><div align="center">
            <p><font style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">&nbsp;&nbsp;&nbsp;&nbsp;<strong>Advertisment Type : </strong></font>
              <select name="jenis" id="jenis" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" onChange="go()";>
                <option value="akademik" <% if (jenis.equals("akademik")){%>selected<%}%>>Iklan Jawatan Akademik</option>
                <option value="akademikBukanWarganegara" <% if (jenis.equals("akademikBukanWarganegara")){%>selected<%}%>>Iklan Jawatan Akademik Bukan Warganegara</option>
                <option value="NonAkademikTeknikal" <% if (jenis.equals("NonAkademikTeknikal")){%>selected<%}%>>Iklan Jawatan Bukan Akademik (Teknikal)</option>
                <option value="NonAkademikSokongan" <% if (jenis.equals("NonAkademikSokongan")){%>selected<%}%>>Iklan Jawatan Bukan Akademik (Pentadbiran &amp; Sokongan)</option>
              </select>
              &nbsp;&nbsp; </p>
          </div></td>
        </tr>
        <td height="25" valign="middle"><div align="center"> 
                <p><font style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">&nbsp;&nbsp;&nbsp;&nbsp;<strong>Closing 
                  Date : </strong></font>&nbsp;&nbsp;
                  <input name="closing" type="text" id="closing" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;"  value="<%if (flag && closing != null) { %><%=closing%><% }%>" size="12" maxlength="14" readonly>
                  <img src='cms/eRecruitment/images/calendar.jpg' title='Klik disini' alt='Klik disini' onClick="scwShow(scwID('closing'),event);" /> 
                </p>
          </div></td>
        </tr>
        <tr>
          <td valign="top">
          <table width="80%" border="0" align="center">
  <tr>
    <th scope="col"> <div>
		  <p>
		    <textarea id="freeRTE_content" name="freeRTE_content" rows="22" cols="30" style="width: 100%"><%if (flag && content != null) { %><%=content%><% }%>
			</textarea>
		  </p>
</div></th>
  </tr>
  <tr>
    <th height="25" scope="col"><input type="submit" name="Select2" id="Select2" value="Save" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;"></th>
  </tr>
          </table>
          </td>
        </tr>
        <tr> 

          <td height="2" background="../images/subnavbg.gif" bgcolor="#FFCC33"><font color="#FFCC33" size="1" face="Verdana, Arial, Helvetica, sans-serif">ss</font></td>

        </tr>

        <tr> 

          <td height="10" background="cms/eRecruitment/images/topbg.gif">&nbsp;</td>

        </tr>

    </table></td>
    <td width="1" height="100" rowspan="2" bgcolor="#000000"><img src="cms/eRecruitment/images/spacer.gif" width="1" height="1"></td>

  </tr>

  <tr> 

    <td bgcolor="#999999" height="15"><div align="center"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">&copy; 
        All rights reserved. Universiti Malaysia Pahang.
</font></div></td>
  </tr>
</table>
</form>
</body>
</html>
<%
}else
{ %>You are not authorized<% }
%>
<%
conn.close();
%>
