<%@ page import="java.util.StringTokenizer, java.util.Vector" %>
<%
int i;

if ( (userMemoACL.containsKey("view") && userMemoACL.get("view").equals("1") ) || 
     (groupMemoACL.containsKey("view")&& groupMemoACL.get("view").equals("1")) )
{
  if (userID != null && moduleName != null && action != null)
  {
%>

<!-- Form for Adding a Memo Folder -->
<SCRIPT LANGUAGE="JavaScript">
function checkAddFolder()
{
  if (document.addFolder.folderName.value.replace(/ /g,"") == '')
    alert("<%= messages.getString("memo.folder.name.required") %>");
  else
    document.addFolder.submit();
}
</SCRIPT>
<form name="addFolder" action="servlet/Memo?action=addfolder" method="post">
<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  <TD CLASS="contentBgColorAlternate" COLSPAN="7" ALIGN="MIDDLE">
    <B><%= messages.getString("memo.add.folder") %></B>
  </td>
</tr>
<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  <TD CLASS="contentBgColorAlternate" COLSPAN="7" ALIGN="LEFT">
    <B><%= messages.getString("memo.folder.name") %></B><BR>
    <input type="text" name="folderName" value="" size="30">
  </td>
</tr>
<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  <TD CLASS="contentBgColorAlternate" COLSPAN="7" ALIGN="LEFT">
	  <A HREF="javascript:checkAddFolder();" onMouseOver="window.status='<%= messages.getString("add") %>';return true;"><IMG SRC="images/system/<%= messages.getString("add.icon") %>.gif" BORDER="0" ALT="<%= messages.getString("add") %>"></A>
	  <A HREF="memo.jsp?action=folders&folderID=1" onMouseOver="window.status='<%= messages.getString("cancel") %>';return true;"><IMG SRC="images/system/<%= messages.getString("cancel.icon") %>.gif" BORDER="0" ALT="<%= messages.getString("cancel") %>"></A>
  </td>
</tr>
</form>
<!-- End Form for Adding a Memo Folder -->
<%
  }
}
%>