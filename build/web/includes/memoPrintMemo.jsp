<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.text.*" %>
<%@ page import="javax.sql.*" %>
<%@ include file="/includes/import.jsp" %>

<%@ page import="java.util.Hashtable,java.util.Locale" %>

<jsp:useBean id="beanMemo" scope="request" class="ecomm.bean.MemoMemo" />
<jsp:useBean id="beanMemoACL" scope="request" class="ecomm.bean.ACL" />
<%
	Connection conn = null;
	boolean status = true;
	String memoID = request.getParameter("memoID");
	String userIDs = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");

//to
    String name = null;
	String department = "";
	String position = "";
	String phone = "";
	String ext = "";
    String type = "";
	String matric = "";
    String faculty = "";

//cc
    String departmentcc = "";
	String positioncc = "";
    String typecc = "";
	PreparedStatement pstmt = null;
	ResultSet rset = null;
			
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
if (conn!=null)
	{
	String sqlstatus = "SELECT M.userID FROM tmsintranet3.Memo M "+
	                   "WHERE M.memoID = ? AND M.touserid = ? ";

	try
		{
		PreparedStatement pstmtstatus = conn.prepareStatement(sqlstatus);
		pstmtstatus.setString (1, memoID);
		pstmtstatus.setString (2, userIDs);
		ResultSet rsetstatus = pstmtstatus.executeQuery ();
		if (rsetstatus.next())
			status = true;
		else
			status = false;
		pstmtstatus.close ();
		rsetstatus.close ();
		}
	catch (SQLException e)
		{ out.println ("Error : " + e.toString ()); }
}
%>
<%
	try { // added try block - cikgu
		if (status) { %>
<html>
	<head>
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=<%= TvoContextManager.getAttribute(request, "System.charset") %>">
	<%@ include file="/includes/loginCheck.jsp" %>
	<%	Messages messages = Messages.getMessages(request);
		
		beanMemo.initTVO(request,application);
		beanMemoACL.initTVO(request);
	
		Hashtable userMemoACL, groupMemoACL;
		String userID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
		String moduleName = "Memo";
		
		String css = (String)TvoContextManager.getSessionAttribute(request, "Login.CSSFile");
		String language = (String)TvoContextManager.getAttribute(request, "System.language");
		String country = (String)TvoContextManager.getAttribute(request, "System.country");
		String dateFormat = (String)TvoContextManager.getAttribute(request,"System.dateFormat");
		Locale currentLocale = new Locale(language,country);
		
		userMemoACL = beanMemoACL.getRights(userID, moduleName, "User");
		groupMemoACL = beanMemoACL.getRights(userID, moduleName, "Group");
	%>
<style type="text/css">
<!--
.style6 {font-family: Arial; font-size: 12px; }
.style9 {font-family: Arial; font-size: 10px; font-style: italic; }
.style8 {font-family: Arial; font-size: 12px; font-weight: bold; }
.style10 {
	font-size: 14px;
	font-weight: bold;
	font-family: Arial;
	color: #FFFFFF;
}
.style11 {
	font-family: "Times New Roman", Times, serif;
	font-style: italic;
}
.style17 {
	font-family: Arial;
	font-weight: bold;
}
.style18 {
	font-family: "Times New Roman", Times, serif;
	font-weight: bold;
	font-size: 12px;
	font-style: italic;
}
.style23 {font-size: 10; font-family: Arial;}
.style27 {font-style: italic; font-weight: bold; font-family: "Times New Roman", Times, serif;}
.style28 {
	font-size: 12px;
	font-weight: bold;
}
.style31 {font-family: Arial; font-size: 18px; }
.style33 {font-family: Arial; font-size: 10px; }
-->
</style>
<OBJECT ID="WebBrowser1" WIDTH=0 HEIGHT=0
    CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2">
</OBJECT>
<SCRIPT LANGUAGE="JavaScript">
function WinPrint(form) {
	netscape_version = navigator.appVersion.split(" ");
	microsoft_version = navigator.appVersion.split(" ");
	microsoft_version = microsoft_version[0].split(",");
	if (navigator.appName == 'Netscape' && netscape_version[0] > 4.0) {
		print();
	}
	else if (navigator.appName == 'Microsoft Internet Explorer' && microsoft_version >= 4) {
		WebBrowser1.ExecWB(6,1);
	}
	else {
		alert("<%= messages.getString("library.browser.not.support") %>");
	}
}
</SCRIPT>
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" VALUE="no-cache">
<title><%= Constants.PRODUCT_NAME %> - <%= messages.getString("memo") %></title>

<script language="javascript">
function WriteToFile()
{
var fso = new ActiveXObject("Scripting.FileSystemObject");
var s = fso.CreateTextFile(document.inputform.Drive.value+document.inputform.NameFile.value+".doc", true);
var text=document.getElementById("TextArea1").innerText;
s.WriteLine(text);
s.WriteLine('Save date '+document.inputform.Tarikh.value);
s.Close();
alert('Document has been saved into your drive C:\\Memo');
}

</script>

<script language="javascript">
function SubmitForm()
{
alert('Document has been saved into your drive C:\\Memo');
}

</script>
</head>
<body>
<p>
  <% if ( (userMemoACL.containsKey("view") && userMemoACL.get("view").equals("1") ) || (groupMemoACL.containsKey("view") &&  groupMemoACL.get("view").equals("1")) )	 {
		
		MemoDB memo = beanMemo.getMemoContents(request.getParameter("memoID"),request);
	    String memoDatePosted = CommonFunction.parseDate(dateFormat,currentLocale,memo.getMemoDatePosted(),TvoConstants.TIME_FORMAT_LONG);
		String toName =  memo.getToName();
		
		//added by cikgu
	 	String toGroupName = memo.getToGroupName();
	  	if (toName.length() != 0 && toGroupName.length() != 0) {
		  	toName = ", " + toName;
	  	}
	  	toName = toGroupName + toName;
			  
		String ccName = memo.getCcName();
		if (toName.length() > 0 && toName.endsWith(","))	
		  toName = toName.substring(0,toName.length()-1);
		
		if (ccName.length() > 0 && ccName.endsWith(","))
			  ccName = ccName.substring(0,ccName.length()-1);	

%>
</p>




<form action="save.jsp" name="inputform" method=post>



 <table width="100%"  border="0" cellspacing="0" cellpadding="0">
   <tr>
     <th scope="col"><div align="right">
       <!--input name="button" type="button" id="button" onClick="return SubmitForm()" value="Test"/-->
    <!--   <input type=text name=FileName>
	  <input type=submit value="Save File">-->
	  <!-- <input id="Button1" type="button" value="Save File" onClick="return WriteToFile()"/> -->
   <input type="button" name="button2" value="   <%= messages.getString("library.print") %>  " onClick="window.print()">
   <input type="button" name="button2" value="  <%= messages.getString("close") %>  " onClick="window.close();">
     </div></th>
   </tr>
 </table>
 <br>
 <table width="100%"  border="0" cellspacing="0" cellpadding="0">
   <tr>
     <td><div align="center">
	
	 </div>
      </td>
   </tr>
 </table>
 <table width="100%"  border="0" cellpadding="3" cellspacing="0" bordercolor="#000000">
      <tr>
        <th scope="col"><span class="style10">  
          <% if (request.getParameter("type").equals("Y")){%>
    <img src="images/hyperlink/letter_head.GIF"  width=800 height="113" /> 
    <%} else if(request.getParameter("type").equals("N")) {%>
   <img src="images/hyperlink/letter_head2.GIF"  width=800 height="113" /> 
    <%}else{%>
    <img src="images/hyperlink/letter_head3.GIF"  width=800 height="113" /> 
      <%}%></span></th>
      </tr>
</table>
 <table width="100%"  border="1" cellpadding="3" cellspacing="0" bordercolor="#000000">
   <tr>
     <th colspan="2" scope="col"><div align="left"><span class="style6">Rujukan Fail: </span></div>       </th>
     <th ><span class="style6">Tarikh</span>:<span class="style6"> <%= memoDatePosted %><input type=hidden name=DatePost value="<%= memoDatePosted %>"></span></th>
   </tr>
<!--
   <tr>
     <th width="22%" scope="col"><span class="style6"><b><%= messages.getString("memo.respond.to") %></b>: <span class="style11">Subject </span><br>
       </span></th>
     <th colspan="2" scope="col"><div align="left"><span class="style6"><%= memo.getMemoFrom() %></span></div></th>
   </tr>-->
   <tr valign="top">
     <td width="15%"><span class="style6"><b>Daripada:<span class="style11"> <%= messages.getString("memo.from") %></span></b></span></td>
     <td width="48%"><span class="style6"><%= memo.getFromName() %><input type=hidden name=FromName value="<%= memo.getFromName() %>"> </span></td>
     <td width="37%">&nbsp;</td>
   </tr>
   <tr valign="top">
     <td><span class="style6"><strong>Kepada:<br>
     <strong><span class="style27"><%= messages.getString("memo.to") %></span></strong></strong></span></td>
     <td><span class="style6"><%= toName %> <input type="hidden" name="To" value="<%= toName %>"></span></td>
     <td><p align="center" class="style6"><span class="style17">Salinan kepada: <span class="style18"><%= messages.getString("memo.cc") %></span></span></p>
       <p align="center" class="style6"><br>
         <%= ccName %> <input type="hidden" name="CC" value="<%= ccName %>">    </p></td>
   </tr>
   <tr valign="top">
     <td class="style6"><b>Tajuk</b><span class="style23">: <br>
     </span><span class="style28"><span class="style11"><%= messages.getString("memo.subject") %></span></span></td>
     <td><span class="style8"><%= memo.getMemoFax() %><input type=hidden name="Subject" value="<%= memo.getMemoFax() %>"></span></td>
     <td>&nbsp;</td>
   </tr>
   <tr valign="top">
     <td><span class="style6"><b>Status:<span class="style11"><br> 
     <%= messages.getString("memo.status") %></span></b></span></td>
     <td><span class="style8">
       <%
        StringTokenizer stMemoFlags = new StringTokenizer(memo.getMemoStatus(),",");		  
				String memoFlag = "";
			  while (stMemoFlags.hasMoreTokens())  	    {
					memoDatePosted = stMemoFlags.nextToken();
					if (memoDatePosted.equals("Please Call Back"))
					  memoDatePosted = messages.getString("memo.please.call.back");
					else if	(memoDatePosted.equals("Returning Your Call"))
					  memoDatePosted = messages.getString("memo.return.call");
					else if	(memoDatePosted.equals("FYI"))
					  memoDatePosted = messages.getString("memo.fyi");
					else  if (memoDatePosted.equals("Urgent"))
					  memoDatePosted = messages.getString("memo.urgent");

					memoFlag += memoDatePosted + ", ";
        }
			  if (memoFlag.length() > 0)
			    memoFlag = memoFlag.substring(0,memoFlag.length()-2);
        %>
     <%= memoFlag %> &nbsp;</span></td>
     <td>&nbsp;</td>
   </tr>
   <tr valign="top">
     <td colspan="3"><span class="style6"><b>Mesej: <span class="style11"><!--%= messages.getString("memo.message") % --></span></b><span class="style11"><br>
             </span>                    <br>
      <span class="style6"><%=  CommonFunction.ln2br(memo.getMemoMessage()) %><!--input type=hidden name=content value="<!--%=  CommonFunction.ln2br(memo.getMemoMessage()) %>" --></span></span>     </td>
   </tr>
 </table>
 <br>
 <table width="100%"  border="1" cellpadding="0" cellspacing="0" bordercolor="#000000">
      <tr>
        <th scope="col"><table width="100%" border="0" cellpadding="3" cellspacing="0">

			
<% if (memo.getMemoFrom().trim().length() > 0) { %>
<% } %>
			
      <TR VALIGN="TOP"  BGCOLOR="#FFFFFF">
        <TD width="13%">&nbsp;          </td>
				<td width="87%">

                  <span class="style6">
        &nbsp;</span></TD>
      </TR>
			
		  <!-- TR VALIGN="TOP"  BGCOLOR="#FFFFFF">			
        <TD width="13%">
          <span class="style6"><B>Kepilan: <br>
          <span class="style11"><!--%--= messages.getString("memo.attachments") --%></span></B></span></td>
				<td>

                  <span class="style6">
                  <!%--		  if ( memo.getMemoTel().trim().length() < 1 || !memo.getMemoTel().startsWith(","))  {  --%>
			      <!%--= messages.getString("email.none") --%>&nbsp;
                  <!%--		  }
		    else		  {
			   stMemoFlags = new StringTokenizer(memo.getMemoTel(),",");
			   while (stMemoFlags.hasMoreTokens())
		  	 {
--%>
		          <!%--= stMemoFlags.nextToken() --%><BR>
                  <!%--
		     }
		    }
--%>
                  </span></TD>
      </TR -->
			
		  <TR VALIGN="TOP" BGCOLOR="#FFFFFF">			
			  <TD COLSPAN="4"><span class="style33">Dokumen ini merupakan cetakan daripada komputer dan tidak memerlukan tandatangan. </span><br>
            <span class="style9">This is a computer generated document and no signature is required.<br>
            </span></td>
	  </tr>

			<!--
		  <TR VALIGN="TOP" BGCOLOR="#FFFFFF">			
			  <TD COLSPAN="4" ALIGN="MIDDLE">			
					<input type="button" name="button" value="   <!%-- = messages.getString("library.print") --%>  " OnClick="window.print()">&nbsp;&nbsp;&nbsp; 
					<input type="button" name="button" value="  <!%-- = messages.getString("close") --%>  " OnClick="window.close();">			
			</td>
	  </tr>-->



    ----------------</table>
         </th>
      </tr>
</table>
   
 <!-- <input id="Button1" type="button" value="Save File" onClick="return WriteToFile()"/> -->
</form>

    <%				
	 }
	 else	 {
%>
  <tr>
    <TD BGCOLOR="#FFFFFF" COLSPAN="4" ALIGN="LEFT" VALIGN="MIDDLE">
	 	 <%= messages.getString("memo.user.no.access") %>
	</td>
<tr>
<% }  %>


</body>
</html>
<% } else { %>
		<font color="#990000" size="2" face="Arial">Please 
		do not try to access other person's memo....</font> 
<% }
}
catch (Exception e) { }
finally {
	try {
		if (conn != null) conn.close();
	}
	catch (Exception e) {  }
}
%>