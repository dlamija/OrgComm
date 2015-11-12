<% response.setContentType("text/html;charSet="+TvoContextManager.getAttribute(request,"System.charset")); %> 
<%@ include file="/includes/import.jsp" %>

<jsp:useBean id="beanResource" scope="request" class="ecomm.bean.ResourceResource" />
<jsp:useBean id="beanCalendar" scope="request" class="ecomm.bean.CalendarCalendar" />
<jsp:useBean id="beanCalendarDirectory" scope="request" class="common.Directory" />
<jsp:useBean id="beanCalendarACL" scope="request" class="ecomm.bean.ACL" />
<jsp:useBean id="beanTams" scope="request" class="ecomm.bean.TamsTams" />
<%@ page buffer="2048kb" import="java.util.Vector, java.util.Hashtable, java.net.URLEncoder, java.net.URLDecoder, java.util.Iterator, java.util.StringTokenizer,java.util.Locale" %>
<%
Hashtable userCalendarACL, groupCalendarACL;
String userID     = request.getParameter("userID");
String action     = request.getParameter("action");
String moduleName = request.getParameter("moduleName");

// Module Manager - Resource
if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_RESOURCE) )
  beanResource.initTVO(request);
if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_TAMS) )
  beanTams.initTVO(request);

beanCalendar.initTVO(request);
beanCalendarDirectory.initTVO(request,application);
beanCalendarACL.initTVO(request);

userCalendarACL = beanCalendarACL.getRights(userID, moduleName, "User");
groupCalendarACL = beanCalendarACL.getRights(userID, moduleName, "Group");

boolean showIcon = false;    
if ( ((String)TvoContextManager.getAttribute(request, "System.language")).equals("en"))		
  showIcon = true;

String language = (String)TvoContextManager.getAttribute(request, "System.language");
String country = (String)TvoContextManager.getAttribute(request, "System.country");
String dateFormat = (String)TvoContextManager.getAttribute(request,"System.dateFormat");
Locale currentLocale = new Locale(language,country);
	
  
Messages messages = Messages.getMessages(request);




%>