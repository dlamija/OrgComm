<%@ include file="/includes/import.jsp" %>
<%@ include file="/includes/loginCheck.jsp" %>
<%
    Messages messages = Messages.getMessages(request);
    String userID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
    String moduleName = "announcement";
    boolean showIcon = false;    
    String language = (String)TvoContextManager.getAttribute(request, "System.language");

    String contentTitleFont = "contentTitleFont";
    if (language.equals("zh") || language.equals("ja"))
        contentTitleFont = "contentTitleGlyphFont";

    if ( language.equals("en"))		
        showIcon = true;
%>
<HTML>
<HEAD>
<TITLE><%= Constants.PRODUCT_NAME %> Announcement Board</TITLE>
<%@ include file="/includes/no-cache.jsp" %>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=<%= TvoContextManager.getAttribute(request, "System.charset") %>">
<LINK REL="stylesheet" HREF="css/<%= (String)TvoContextManager.getSessionAttribute(request, "Login.CSSFile") %>">
<SCRIPT LANGUAGE="JavaScript">
<%@ include file="/template/default/general.js" %>
<%
boolean expandMiddle = false;
// Module Manager - Personal 
if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_PERSONAL) )  {
  expandMiddle = PersonalPersonal.isRightEmpty(request, userID); 
%><%@ include file="/template/default/personalGeneral.js" %><%}%>
</SCRIPT>
</HEAD>

<BODY LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" BGCOLOR="#FFFFFF" onLoad="loadBoxes();">
<%@ include file="/template/default/topMenuBar.jsp" %>
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
  <TR>
   <TD WIDTH="14%" VALIGN="TOP" ALIGN="CENTER" BGCOLOR="#003063" CLASS="menuBgColor">
   <%@ include file="/template/default/leftBox.jsp" %>
    </TD>
    <TD COLSPAN="2" VALIGN="TOP" WIDTH="86%">
    <%@ include file="/template/default/searchEngineBox.jsp" %>
      <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
        <TR>
          <TD WIDTH="100%" VALIGN="TOP">
		   <%@ include file="/cms/announcement/announcementHeaderBox.jsp" %>
		   <%@ include file="/cms/announcement/announcementModules.jsp" %>
		   <%@ include file="/cms/announcement/announcementFooterBox.jsp" %>
          </TD>
        </TR>
      </TABLE>
      
    </TD>
  </TR>
</TABLE>
</BODY>
<%@ include file="/template/default/footerMenuBar.jsp" %>

</HTML>
