<style>
body
{text-align:left;}
</style>
<%@ include file="/includes/memoModules_splitTop.jsp" %>
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

} // end of action handler
%>
<%@ include file="/includes/memoModules_splitBottom.jsp" %>