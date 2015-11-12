<%@ include file="/includes/memoModules_splitTop.jsp" %>
<%
// The following handles user module actions
if (action != null)  {
  if (action.equals("addfolder") )  {
    %><%@ include file="/includes/memoAddFolder.jsp" %><%
  }
  else if (action.equals("editfolder") )  {
    %><%@ include file="/includes/memoEditFolder.jsp" %><%
  }
  else if (action.equals("settings") )  {
    %><%@ include file="/includes/memoSettings.jsp" %><%
  }
  else if (action.equals("addGroup") || action.trim().equals("editGroup") )  {
	    %><%@ include file="/includes/memoPersonalGroups.jsp" %><%
	}
  else if (action.equals("listGroup") )  {
	    %><%@ include file="/includes/memoPersonalGroupsList.jsp" %><%
	}
  else if (action.equals("search"))  {
    %><%@ include file="/includes/memoSearch.jsp" %><%
  }
  else if (action.equals("diskSpace"))  {
    %><%@ include file="/includes/memoDiskSpace.jsp" %><%
  }
} // end of action handler
%>
<%@ include file="/includes/memoModules_splitBottom.jsp" %>