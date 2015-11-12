<TR VALIGN="MIDDLE">
  <form name="memoModules2" method="post">
  <TD  BGCOLOR="#003366" CLASS="contentStrapColor" COLSPAN="7" ALIGN="RIGHT">&nbsp;
<%
if (showIcon) {
	if ( (userMemoACL.containsKey("view") && userMemoACL.get("view").equals("1") ) || 
	   (groupMemoACL.containsKey("view") &&  groupMemoACL.get("view").equals("1")) )
	{
	  %><A HREF="memo.jsp?action=folders&type=<%=request.getParameter("type")%>&folderID=1" onMouseOver="window.status='Inbox';return true;"><IMG SRC="images/system/ic_inbox.gif" BORDER="0" ALT="Inbox"></A> 
	    <A HREF="memo.jsp?action=compose" onMouseOver="window.status='Compose';return true;"><IMG SRC="images/system/ic_compose.gif" BORDER="0" ALT="Compose"> 
	    <A HREF="javascript:confirmEmptyTrash()" onMouseOver="window.status='Empty Trash';return true;"><IMG SRC="images/system/ic_emptytrash.gif" BORDER="0" ALT="Empty Trash"></A>
	    <A HREF="memo.jsp?action=addfolder&type=<%=request.getParameter("type")%>" onMouseOver="window.status='Add Folder';return true;"><IMG SRC="images/system/ic_newfolder.gif" BORDER="0" ALT="Add Folder"></A>
	    <a href="memo.jsp?action=settings&preferences=1&type=<%=request.getParameter("type")%>"><IMG SRC="images/system/ic_settings.gif" BORDER="0" ALT="Settings"></a>
		<!--a href="memo2.jsp?action=archive"><IMG SRC="images/system/ic_archive.gif" BORDER="0" ALT="Archive"></a -->
	    <A HREF="memo.jsp?action=search&type=<%=request.getParameter("type")%>" onMouseOver="window.status='Search';return true;"><IMG SRC="images/system/ic_searchpic.gif" BORDER="0" ALT="Search"></A> 
            <A HREF="memo.jsp?action=diskSpace&type=<%=request.getParameter("type")%>" onMouseOver="window.status='Check Disk Space';return true;"><IMG SRC="images/system/ic_diskspace.gif" BORDER="0" ALT="Check Disk Space"></A> <%

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
