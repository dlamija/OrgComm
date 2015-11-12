<%@ page import="java.util.StringTokenizer, java.util.Vector" %>
<%
Vector vEditFoldersList=null;
Vector vEditUserFoldersID=null, vEditUserFoldersName=null;
int i;
String editFolderName="";

if ( (userMemoACL.containsKey("view") && userMemoACL.get("view").equals("1") ) || 
    (groupMemoACL.containsKey("view") && groupMemoACL.get("view").equals("1")) )
{
  if (userID != null && moduleName != null && action != null)
  {
    vEditFoldersList = beanMemo.showModule(userID, moduleName, "folders");
    if (vEditFoldersList != null)
    {
      // User folders
      vEditUserFoldersID = (Vector)vEditFoldersList.get(4);
      vEditUserFoldersName = (Vector)vEditFoldersList.get(5);
    }
    
    for (i=0; i<vEditUserFoldersID.size(); i++)
    {
      if (vEditUserFoldersID.get(i).equals(request.getParameter("folderID")))
      {
        editFolderName = (String)vEditUserFoldersName.get(i);
        break;
      }
    }
  
%>
<!-- Form for Editing a Memo Folder -->
<SCRIPT LANGUAGE="JavaScript">
function checkEditFolder()
{
  if (document.editFolder.folderName.value.replace(/ /g,"") == '')
    alert("<%= messages.getString("memo.folder.name.required") %>");
  else
    document.editFolder.submit();
}
</SCRIPT>
<form name="editFolder" action="servlet/Memo?action=editfolder" method="post">
<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  <TD CLASS="contentBgColorAlternate" COLSPAN="7" ALIGN="MIDDLE">
    <B><%= messages.getString("memo.edit.folder") %></B>
  </td>
</tr>
<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  <TD CLASS="contentBgColorAlternate" COLSPAN="7" ALIGN="LEFT">
    <B><%= messages.getString("memo.folder.name") %></B><BR>
    <input type="text" name="folderName" value="<%= editFolderName %>" size="30">
    <input type="hidden" name="folderID" value="<%= request.getParameter("folderID") %>">
  </td>
</tr>
<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  <TD CLASS="contentBgColorAlternate" COLSPAN="7" ALIGN="LEFT">
	  <A HREF="javascript:checkEditFolder();" onMouseOver="window.status='<%= messages.getString("save") %>';return true;"><IMG SRC="images/system/<%= messages.getString("save.icon") %>.gif" BORDER="0" ALT="<%= messages.getString("save") %>"></A>
	  <A HREF="memo.jsp?action=folders&folderID=1" onMouseOver="window.status='<%= messages.getString("cancel") %>';return true;"><IMG SRC="images/system/<%= messages.getString("cancel.icon") %>.gif" BORDER="0" ALT="<%= messages.getString("cancel") %>"></A>
  </td>
</tr>
</form>
<!-- End Form for Editing a Memo Folder -->
<%
  }
}
%>