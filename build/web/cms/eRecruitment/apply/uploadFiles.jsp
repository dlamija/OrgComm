<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<%
	Connection conn=null;
	String refid=request.getParameter("refid");
	String file = (String)session.getAttribute("file");
	String ref_id = (String)session.getAttribute("ref_id");
	try
	{
		Context initCtx = new InitialContext();
	    Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
    	DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
    	conn = ds.getConnection();
	}
	catch(Exception e)
	{
		System.out.println("Error : "+e);
	}
%>
<%
// Allow maximum of 5 files to be uploaded
// Trace balance of files using session attribute
int recruitment_attachment_balance = -1;
if (conn!=null)
	{
	String sql = "SELECT 5 - COUNT(1) FROM STAFF_CANDIDATE_ATTACHMENT WHERE SCA_CANDIDATE_REFID = ?";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString (1, request.getParameter("refid"));
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			recruitment_attachment_balance = rset.getInt (1);
		pstmt.close ();
		}
	catch (SQLException e)
		{ recruitment_attachment_balance = 5; }
	if (recruitment_attachment_balance==-1)
		recruitment_attachment_balance = 5;	
	}
else
	recruitment_attachment_balance = 5;
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
	color: #0000FF;
	TEXT-DECORATION: none;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
}

-->
</style>
<script>
function go (action)
	{
	if (document.formdelete.fileIDs == null)
        {
          return;
        }
        
        var ok = 0;
        if (document.formdelete.fileIDs[1] != null)
        {
          for(var c=0; c < document.formdelete.fileIDs.length; c++)
          {
            if(document.formdelete.fileIDs[c].checked)
            {
				ok = 1;
              	break;
			  }
          }
		   }
        else if (document.formdelete.fileIDs.checked)
        {
          ok = 1;
        }
        if(ok == 0)
        {
          alert("Sila buat pilihan sekurang-kurangnya satu...!");
          return;
        }
		if (action == 'delete')
          {
		 	document.formdelete.action = "recruitmentbean?action=deleteFile";
 			document.formdelete.submit();
          }
	}


extArray = new Array(".jsp",".php",".cfm",".java");
		
		function checkAddFolderFileLibrary(form, file) {
		
		//if (allowSubmit) form.submit();
		if (document.fileUpload.docID.value == '')
		  {
			alert("Please Choose Document to Upload!");
			submit = false;
		  }
		else 
	  {
		allowSubmit = true;
		if (!file) return;
		while (file.indexOf("\\") != -1)
		file = file.slice(file.indexOf("\\") + 1);
		ext = file.slice(file.indexOf(".")).toLowerCase();
		for (var i = 0; i < extArray.length; i++) {
		if (extArray[i] == ext) { allowSubmit = false; break; }
		}
		
		if (allowSubmit){
		document.fileUpload.submit();	
		}
		else
		//alert("Please only upload files that end in types:  "
		//+ (extArray.join("  ")) + "\nPlease select a new "
		//+ "file to upload and submit again.");
		alert("Cannot upload this type of documents"
		+ (extArray.join("  ")) + "\nPlease select a new "
		+ "file to upload and submit again.");
		//return false;
	  }
	}
		
</script>
<body bgcolor="#F3F3F3">
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" class='style2'>
  <tr> 
    <td><div align="center"><img src="cms/eRecruitment/images/permohonan.gif" width="509" height="41"></div></td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td height="40" valign="top"> 
      <div align="center"><strong><font size="2">Muat Naik Dokumen</font></strong></div></td>
  </tr>
  <tr>
   <%
if(!refid.equals("null")){

	if (recruitment_attachment_balance>0)
		{
		%>
 		 <TR> 
    <TD COLSPAN="5" ALIGN="left" valign="bottom" CLASS="contentBgColorAlternate">Anda 
      dibenarkan muat naik sebanyak <%=recruitment_attachment_balance%> dokumen 
      sahaja. 
      <form name="fileUpload" enctype="multipart/form-data" method="post" action="recruitmentbean?action=addFile&candidate_refid=<%=request.getParameter("refid").toString()%>&refid=<%=request.getParameter("refid").toString()%>&type=candidate">
        <b>Pilih Dokumen</b> 
        <input type="file" name="docID" size="50" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
        <input name="Button" type="button" class="normaltext" value="Upload" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" onClick="javascript:checkAddFolderFileLibrary(this.form,document.fileUpload.docID.value);">
      </form>		  
      <%	}else{	%>
  <TR> 
    <TD COLSPAN="5" ALIGN="left" CLASS="contentBgColorAlternate">Tiada sebarang 
      dokumen untuk dimuat naik .
    </td>
  </tr>
	<%	}	%>
	<%}else{%>
  		<TR> 
    <TD COLSPAN="5" ALIGN="left" CLASS="contentBgColorAlternate">Maaf, Dokumen 
      Tidak Berjaya dimuat naik.
    </td>
  </tr>
	<%}%>	
  </tr>
</table>
<%
if (conn!=null)
	{
		 String sql = null;
   			sql 	=  "SELECT SCA_FILENAME,SCA_REF_ID FROM STAFF_CANDIDATE_ATTACHMENT WHERE SCA_CANDIDATE_REFID = '" + refid + "'";
		try
			{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rset = pstmt.executeQuery ();
			if (rset.isBeforeFirst ()) { %>
<form action="recruitmentbean?action=deleteFile" method="post" name="formdelete" id="formdelete">
  <table width="80%" border="0" align="center" cellpadding="0" cellspacing="1" class='style2'>
    <tr> 
      <td height="20" colspan="4"><strong>Senarai Dokumen </strong></td>
    </tr>
    <%   while (rset.next ()) { %>
    <tr> 
      <td width="7%"><div align="center"><%=rset.getRow()%>.</div></td>
      <td width="58%">&nbsp;<a href="sites/default/recruitment/applicant/<%=refid%>/<%=rset.getString(1)%>" target="_blank"><%=rset.getString(1)%></a>
        <input name="filename" type="hidden" id="filename" value="<%=rset.getString(1)%>">
        <input name="ref_id" type="hidden" id="ref_id2" value="<%=refid%>"></td>
      <td width="2%"> <div align="right">
          <input name="fileIDs" type="checkbox" id="fileIDs" value="<%=rset.getString(2)%>">
        </div></td>
      <td width="33%">&nbsp;</td>
    </tr>
    <%}%>
    <tr> 
      <td>&nbsp;</td>
      <td height="30" colspan="2"> 
        <div align="right"> <A HREF="javascript:go('delete');" onMouseOver="window.status='Delete Files';return true;"><IMG SRC="cms/eRecruitment/images/ic_deletefile.gif" BORDER="0" ALT="Delete Files"></A> 
        </div></td>
      <td>&nbsp;</td>
    </tr>
  </table>
</form>
<% }

			rset.close ();
			pstmt.close ();
			}
	catch( Exception e )
		{ out.println (e.toString()); }
	}
conn.close ();
%>
<%
try
	{ conn.close (); }
catch (Exception e)
	{ conn = null; }
%>
</body>
</html>
