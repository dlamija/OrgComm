<% response.setContentType("text/html;charSet="+TvoContextManager.getAttribute(request,"System.charset")); %>
<%@ include file="/includes/import.jsp" %>

<%@ page buffer="1024kb" autoFlush="true" %> 
<%@ include file="/includes/loginCheck.jsp" %>
<jsp:useBean id="beanMemo" scope="request" class="ecomm.bean.MemoAppointment" />
<jsp:useBean id="beanMemoACL" scope="request" class="ecomm.bean.ACL" />
<%@ page import="java.util.Hashtable,java.util.Locale" %>
<%
Hashtable userMemoACL, groupMemoACL;
String userID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
String moduleName = "Memo";

beanMemo.initTVO(request,application);
beanMemoACL.initTVO(request);

userMemoACL = beanMemoACL.getRights(userID, moduleName, "User");
groupMemoACL = beanMemoACL.getRights(userID, moduleName, "Group");
Messages messages = Messages.getMessages(request);

String css = (String)TvoContextManager.getSessionAttribute(request, "Login.CSSFile");
String language = (String)TvoContextManager.getAttribute(request, "System.language");
String country = (String)TvoContextManager.getAttribute(request, "System.country");
String dateFormat = (String)TvoContextManager.getAttribute(request,"System.dateFormat");
Locale currentLocale = new Locale(language,country);


boolean showIcon = false;    



if ( language.equals("en"))		
  showIcon = true;
	
String contentTitleFont = "contentTitleFont";
if (language.equals("zh") || language.equals("ja"))
  contentTitleFont = "contentTitleGlyphFont";
	
	
String action = request.getParameter("action");
if (!action.equals("print"))
{
%>

<HTML>
<HEAD>
<TITLE><%= Constants.PRODUCT_NAME %> - <%= messages.getString("memo") %></TITLE>
<%@ include file="/includes/no-cache.jsp" %>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=<%= TvoContextManager.getAttribute(request, "System.charset") %>">
<LINK REL="stylesheet" HREF="css/<%= css %>">
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
          <TD WIDTH="<%= (expandMiddle) ? "100%" : "76%" %>" VALIGN="TOP">