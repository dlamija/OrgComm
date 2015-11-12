<%@ include file="/template/default/memoHeaderBox.jsp" %>
<script language = "JavaScript">
function directURL(obj)
{
  if (obj.memoMenu[1].selected == true)
    location.href ="memo.jsp?action=folders&folderID=1";
  else if (obj.memoMenu[2].selected == true) 
    location.href ="memo.jsp?action=compose";
  else if (obj.memoMenu[3].selected == true) 
		 confirmEmptyTrash();
  else if (obj.memoMenu[4].selected == true) 
    location.href ="memo.jsp?action=addfolder";
  else if (obj.memoMenu[5].selected == true) 
    location.href = "memo.jsp?action=settings&preferences=1";	
  else if (obj.memoMenu[6].selected == true) 
    location.href = "memo.jsp?action=search";
}

function confirmEmptyTrash()
{
  if (confirm("<%= messages.getString("click.OK.confirm") %>"))	{
	  document.memoModules.action = "Memo?action=emptytrash";
		document.memoModules.submit();
	}
}

</script>
<TR VALIGN="MIDDLE">
<form name="memoModules" method="post">
  <TD  BGCOLOR="#003366" CLASS="contentStrapColor" COLSPAN="7" ALIGN="RIGHT">&nbsp;                       
<%
moduleName = "Memo";
if (showIcon) {
if ( (userMemoACL.containsKey("view") && userMemoACL.get("view").equals("1") ) || 
   (groupMemoACL.containsKey("view") &&  groupMemoACL.get("view").equals("1")) )
{
  %><A HREF="memo.jsp?action=folders&folderID=1" onMouseOver="window.status='Inbox';return true;"><IMG SRC="images/system/ic_inbox.gif" BORDER="0" ALT="Inbox"></A> 
    <A HREF="memo.jsp?action=compose" onMouseOver="window.status='Compose';return true;"><IMG SRC="images/system/ic_compose.gif" BORDER="0" ALT="Compose"></A>
	<A HREF="javascript:confirmEmptyTrash()" onMouseOver="window.status='Empty Trash';return true;"><IMG SRC="images/system/ic_emptytrash.gif" BORDER="0" ALT="Empty Trash"></A>
    <A HREF="memo.jsp?action=addfolder" onMouseOver="window.status='Add Folder';return true;"><IMG SRC="images/system/ic_newfolder.gif" BORDER="0" ALT="Add Folder"></A>
	<a href="memo.jsp?action=settings&preferences=1"><IMG SRC="images/system/ic_settings.gif" BORDER="0" ALT="Settings"></a>
	<A HREF="memo.jsp?action=search" onMouseOver="window.status='Search';return true;"><IMG SRC="images/system/ic_searchpic.gif" BORDER="0" ALT="Search"></A> <%
}
} else { %>
    <select name ="memoMenu" onChange="directURL(document.memoModules)">
	  <option><%= messages.getString("select") %></option>
<%	  
if ( (userMemoACL.containsKey("view") && userMemoACL.get("view").equals("1") ) || 
   (groupMemoACL.containsKey("view") &&  groupMemoACL.get("view").equals("1")) )
{
%>  <option><%= messages.getString("inbox") %></option>
    <option><%= messages.getString("compose") %></option>
	<option><%= messages.getString("empty.trash") %></option>
	<option><%= messages.getString("new.folder") %></option>
	<option><%= messages.getString("settings") %></option>
	<option><%= messages.getString("search.email") %></option><%	
}
%>
</select>  
<% } %></TD>
</form>
</TR>
<%


// The following handles user module actions
if (action != null)
{
  if (action.equals("compose") || action.equals("reply") || action.equals("draft") || action.equals("sendagain") || action.equals("forward") || action.equals("replyAll"))
  {
    %><%@ include file="/includes/memoCompose.jsp" %><%
  }
  else if (action.equals("folders") )
  {
    %><%@ include file="/includes/memoFolders.jsp" %><%
	}
  else if (action.equals("addfolder") )
  {
%><%@ include file="/includes/memoAddFolder.jsp" %><%
	}
  else if (action.equals("editfolder") )
  {
%><%@ include file="/includes/memoEditFolder.jsp" %><%
	}
  else if (action.equals("settings") )
  {
%><%@ include file="/includes/memoSettings.jsp" %><%
	}
  else if (action.equals("search"))
  {
%><%@ include file="/includes/memoSearch.jsp" %><%
  }

       
} // end of action handler
%>
<TR VALIGN="MIDDLE">
  <form name="memoModules2" method="post">
  <TD  BGCOLOR="#003366" CLASS="contentStrapColor" COLSPAN="7" ALIGN="RIGHT">&nbsp;
<%
if (showIcon) {
	if ( (userMemoACL.containsKey("view") && userMemoACL.get("view").equals("1") ) || 
	   (groupMemoACL.containsKey("view") &&  groupMemoACL.get("view").equals("1")) )
	{
	  %><A HREF="memo.jsp?action=folders&folderID=1" onMouseOver="window.status='Inbox';return true;"><IMG SRC="images/system/ic_inbox.gif" BORDER="0" ALT="Inbox"></A> 
	    <A HREF="memo.jsp?action=compose" onMouseOver="window.status='Compose';return true;"><IMG SRC="images/system/ic_compose.gif" BORDER="0" ALT="Compose"> 
	    <A HREF="javascript:confirmEmptyTrash()" onMouseOver="window.status='Empty Trash';return true;"><IMG SRC="images/system/ic_emptytrash.gif" BORDER="0" ALT="Empty Trash"></A>
	    <A HREF="memo.jsp?action=addfolder" onMouseOver="window.status='Add Folder';return true;"><IMG SRC="images/system/ic_newfolder.gif" BORDER="0" ALT="Add Folder"></A>
		  <a href="memo.jsp?action=settings&preferences=1"><IMG SRC="images/system/ic_settings.gif" BORDER="0" ALT="Settings"></a>
		<A HREF="memo.jsp?action=search" onMouseOver="window.status='Search';return true;"><IMG SRC="images/system/ic_searchpic.gif" BORDER="0" ALT="Search"></A> <%

	}
}else {		 %>
   <select name ="memoMenu" onChange="directURL(document.memoModules2)">
	  <option><%= messages.getString("select") %></option>
<%	  
if ( (userMemoACL.containsKey("view") && userMemoACL.get("view").equals("1") ) || 
   (groupMemoACL.containsKey("view") &&  groupMemoACL.get("view").equals("1")) )
{
%>  <option><%= messages.getString("inbox") %></option>
    <option><%= messages.getString("compose") %></option>
	<option><%= messages.getString("empty.trash") %></option>
	<option><%= messages.getString("new.folder") %></option>
	<option><%= messages.getString("settings") %></option>
	<option><%= messages.getString("search.email") %></option><%

}
%>
</select>  
<%
}	
%>  
  </TD>
	</form>
</TR>
<%@ include file="/template/default/memoFooterBox.jsp" %>
