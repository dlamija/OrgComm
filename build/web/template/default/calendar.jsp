<%@ page buffer="2048kb" autoFlush="true" %> 
<%@ include file="/includes/loginCheck.jsp" %>

<jsp:useBean id="beanResource" scope="request" class="ecomm.bean.ResourceResource" />
<jsp:useBean id="beanCalendar" scope="request" class="ecomm.bean.CalendarCalendar" />
<jsp:useBean id="beanCalendarDirectory" scope="request" class="common.Directory" />
<jsp:useBean id="beanCalendarACL" scope="request" class="ecomm.bean.ACL" />
<jsp:useBean id="beanTams" scope="request" class="ecomm.bean.TamsTams" />
<%@ page import="java.util.Hashtable,java.util.Locale" %>
<%@ include file="/includes/import.jsp" %>
<%
Hashtable userCalendarACL, groupCalendarACL;
String userID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
String moduleName = "Calendar";
String calendarAction = request.getParameter("action");

Messages messages = Messages.getMessages(request);

String language = (String)TvoContextManager.getAttribute(request, "System.language");
String country = (String)TvoContextManager.getAttribute(request, "System.country");
String dateFormat = (String)TvoContextManager.getAttribute(request,"System.dateFormat");
Locale currentLocale = new Locale(language,country);


boolean showIcon = false;    

String contentTitleFont = "contentTitleFont";
if (language.equals("zh") || language.equals("ja"))
  contentTitleFont = "contentTitleGlyphFont";


if ( language.equals("en"))		
  showIcon = true;

// Module Manager - Resource
if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_RESOURCE) )
  beanResource.initTVO(request);
if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_TAMS) )
  beanTams.initTVO(request);

beanCalendar.initTVO(request,application);
beanCalendarDirectory.initTVO(request);
beanCalendarACL.initTVO(request);

userCalendarACL = beanCalendarACL.getRights(userID, moduleName, "User");
groupCalendarACL = beanCalendarACL.getRights(userID, moduleName, "Group");

boolean expandMiddle = false;

if (calendarAction == null)
  calendarAction = "";

if (!calendarAction.equals("addEvent") && !calendarAction.equals("rejectAppt") && 
	!calendarAction.equals("rejectToDo") && !calendarAction.equals("emailRejectToDo") &&
    !calendarAction.equals("viewAgenda") && !calendarAction.equals("reassignToDo") && 
    !calendarAction.equals("editEvent") && !calendarAction.equals("viewToDo") && !calendarAction.equals("printMonth")) {
%>
<HTML>
<HEAD>
<TITLE><%= Constants.PRODUCT_NAME %> - <%= messages.getString("calendar") %></TITLE>
<%@ include file="/includes/no-cache.jsp" %>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=<%= TvoContextManager.getAttribute(request, "System.charset") %>">
<LINK REL="stylesheet" HREF="css/<%= (String)TvoContextManager.getSessionAttribute(request, "Login.CSSFile") %>">
<script language="javascript" src="template/default/general.jsp"></script>
<%
// Module Manager - Personal 
if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_PERSONAL) )  {
  expandMiddle = PersonalPersonal.isRightEmpty(request, userID); 
%><script language="javascript" src="template/default/personalGeneral.js" ></script><%}%>
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
<%
  }
%>
	<%@ include file="/includes/calendarModules.jsp" %>

<%
if (!calendarAction.equals("addEvent") && !calendarAction.equals("rejectAppt") && 
	!calendarAction.equals("rejectToDo") && !calendarAction.equals("emailRejectToDo") && 
    !calendarAction.equals("viewAgenda") && !calendarAction.equals("reassignToDo") && 
    !calendarAction.equals("editEvent") && !calendarAction.equals("viewToDo") && 
	!calendarAction.equals("printMonth")) {
%>
          <%-- = (expandMiddle) ? "" : "</TD><TD WIDTH=24% VALIGN=TOP>" --%>
		  <%-- @ include file="/template/default/rightBox.jsp" --%>
          </TD>
        </TR>
      </TABLE>
    </TD>
  </TR>
</TABLE>
<%@ include file="/template/default/footerMenuBar.jsp" %>
</BODY>
</HTML>
<%
  }
%>
