<%
if ( (userMemoACL.containsKey("view") && userMemoACL.get("view").equals("1") ) || 
	   (groupMemoACL.containsKey("view") &&  groupMemoACL.get("view").equals("1")) )
{
		if (request.getParameter("preferences") != null) {
		 %><%@ include file="/includes/memoPreferences.jsp" %><%		 
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
