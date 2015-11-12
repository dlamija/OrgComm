<html>
<head>
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
</head>
<body>
<% if ( (userMemoACL.containsKey("view") && userMemoACL.get("view").equals("1") ) || 
	    (groupMemoACL.containsKey("view") &&  groupMemoACL.get("view").equals("1")) )	 {
		    MemoDB memo = beanMemo.getMemoContents(request.getParameter("memoID"),request);
	      String memoDatePosted = CommonFunction.parseDate(dateFormat,currentLocale,memo.getMemoDatePosted(),TvoConstants.TIME_FORMAT_LONG);
			  String toName =  memo.getToName();
				String ccName = memo.getCcName();
				if (toName.length() > 0 && toName.endsWith(","))	
				  toName = toName.substring(0,toName.length()-1);
				
				if (ccName.length() > 0 && ccName.endsWith(","))
					  ccName = ccName.substring(0,ccName.length()-1);	

%>
    <table border="0" width="100%">    
      <TR VALIGN="TOP"  BGCOLOR="#FFFFFF">
        <TD width="25%">
        <B><%= messages.getString("memo.date") %></B>:
				</td>
				<td>
				<%= memoDatePosted %>
        &nbsp;</TD>
      </TR>
			
     <TR VALIGN="TOP"  BGCOLOR="#FFFFFF">
        <TD width="25%">
        <B><%= messages.getString("memo.from") %></B>:
				</td>
				<td>

        <%= memo.getFromName() %>
        &nbsp;</TD>
      </TR>
			
      <TR VALIGN="TOP"  BGCOLOR="#FFFFFF">
        <TD width="25%">
        <B><%= messages.getString("memo.to") %></B>:
				</td>
				<td>

				<%= toName %>
        &nbsp;</TD>
      </TR>
			
			
      <TR VALIGN="TOP"  BGCOLOR="#FFFFFF">
        <TD width="25%">
        <B><%= messages.getString("memo.cc") %></B>:
				</td>
				
				<td>
				<%= ccName %>
				&nbsp;</td>
			</tr>

			
<% if (memo.getMemoFrom().trim().length() > 0) { %>
      <TR VALIGN="TOP"  BGCOLOR="#FFFFFF">
        <TD width="25%">
        <B><%= messages.getString("memo.respond.to") %></B>:
				</td>
				<td>

        <%= memo.getMemoFrom() %>
        &nbsp;</TD>
      </TR>
<% } %>    
      <TR VALIGN="TOP"  BGCOLOR="#FFFFFF">
        <TD width="25%">
        <B><%= messages.getString("memo.subject") %></B>:
				</td>
				<td>

        <%= memo.getMemoFax() %>
        &nbsp;</TD>
      </TR>



      <TR VALIGN="TOP"  BGCOLOR="#FFFFFF">
        <TD width="25%">
        <B><%= messages.getString("memo.status") %></B>:
				</td>
				<td>


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
				<%= memoFlag %>
        &nbsp;</TD>
      </TR>
			
      <TR VALIGN="TOP"  BGCOLOR="#FFFFFF">
        <TD width="25%">
        <B><%= messages.getString("memo.message") %></B>:
			  </td>
				<td>

        <%=  CommonFunction.ln2br(memo.getMemoMessage()) %>
        &nbsp;</TD>
      </TR>
			
		  <TR VALIGN="TOP"  BGCOLOR="#FFFFFF">			
        <TD width="25%">
        <B><%= messages.getString("memo.attachments") %></B>:
				</td>
				<td>

<%		  if ( memo.getMemoTel().trim().length() < 1 || !memo.getMemoTel().startsWith(","))  {  %>
			   <%= messages.getString("email.none") %>&nbsp;
<%		  }
		    else		  {
			   stMemoFlags = new StringTokenizer(memo.getMemoTel(),",");
			   while (stMemoFlags.hasMoreTokens())
		  	 {
%>
		     <%= stMemoFlags.nextToken() %><BR>
<%
		     }
		    }
%>
        </TD>
      </TR>
			
		  <TR VALIGN="TOP" BGCOLOR="#FFFFFF">			
			  <TD COLSPAN="4">&nbsp;</td>
			</tr>

			
		  <TR VALIGN="TOP" BGCOLOR="#FFFFFF">			
			  
    <TD COLSPAN="4" ALIGN="MIDDLE"> &nbsp;&nbsp;&nbsp; 
<input type="button" name="button" value="  <%= messages.getString("close") %>  " OnClick="window.close();">			
				</td>
			</tr>



    </table>
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