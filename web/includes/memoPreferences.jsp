<%
if ( (userMemoACL.containsKey("view") && userMemoACL.get("view").equals("1") ) || 
	   (groupMemoACL.containsKey("view") &&  groupMemoACL.get("view").equals("1")) ) {
		MemoPreferences memo = beanMemo.getMemoPreferences(userID);
		 
  if ( request.getParameter("preferences") != null )	{
%>
    <TR VALIGN="TOP" BGCOLOR="#DBDBDB">
		<form name = "memoPreferences" action="Memo?action=preferences" method="post">
      <TD CLASS="contentBgColorAlternate" colspan="7" ALIGN="LEFT">
			  <input type = "checkbox" name = "saveOutGoing" <%= memo.getSaveOutGoing().equals("1") ? " CHECKED" : "" %>> <%= messages.getString("memo.save.copy.outbox") %>
			</td>
		</tr>
		
    <TR VALIGN="TOP" BGCOLOR="#DBDBDB">
      <TD CLASS="contentBgColorAlternate" colspan="7" ALIGN="LEFT">
			  <input type = "checkbox" name = "useSignature" <%= memo.getSignatureFlag().equals("1") ? " CHECKED" : "" %>> <%= messages.getString("email.use.signature") %>
			</td>
		</tr>
		
		
    <TR VALIGN="TOP" BGCOLOR="#DBDBDB">
      <TD CLASS="contentBgColorAlternate" colspan="7" ALIGN="middle">
			  <b><%= messages.getString("email.signature") %></b>
			</td>
		</tr>
		
    <TR VALIGN="TOP" BGCOLOR="#DBDBDB">
      <TD CLASS="contentBgColorAlternate" colspan="7" ALIGN="middle">
			  <textarea cols="45" rows="7" wrap name = "signature"><%= memo.getSignature() %></textarea>
			</td>
		</tr>
	
    <TR VALIGN="TOP" BGCOLOR="#DBDBDB">
        <TD CLASS="contentBgColorAlternate" ALIGN="MIDDLE" colspan="7">
        <A HREF="javascript:document.memoPreferences.submit()" onMouseOver="window.status='<%= messages.getString("save") %>';return true;"><IMG SRC="images/system/<%= messages.getString("save.icon") %>.gif" BORDER="0" ALT="<%= messages.getString("save") %>"></A>
        <A HREF="memo.jsp?action=settings&preferences=1" onMouseOver="window.status='<%= messages.getString("cancel") %>';return true;"><IMG SRC="images/system/<%= messages.getString("cancel.icon") %>.gif" BORDER="0" ALT="<%= messages.getString("cancel") %>"></A>
        </TD>
		</form>
   </TR>      




		

<%	  
	
	}
   
}
else
{
%>
    <TR VALIGN="TOP" BGCOLOR="#DBDBDB">
      <TD CLASS="contentBgColorAlternate" colspan="7" ALIGN="LEFT">
			  <%= messages.getString("no.access.view.page") %>
			</td>
		</tr>
<%
}
%>
