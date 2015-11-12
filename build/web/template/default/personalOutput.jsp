<% 

// Module Manager - Personal
if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_PERSONAL) ) {
  String outputLocation = request.getParameter("outputLocation");


if (outputLocation != null) {

%><jsp:useBean id="beanPersonal" scope="request" class="ecomm.bean.PersonalPersonal" /><%
beanPersonal.initTVO(request);

String userID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
String language = (String)TvoContextManager.getAttribute(request, "System.language");
String country = (String)TvoContextManager.getAttribute(request, "System.country");
String dateFormat = (String)TvoContextManager.getAttribute(request,"System.dateFormat");
Locale currentLocale = new Locale(language,country);


CommonObject selectedModule = (CommonObject) beanPersonal.getHome(request, userID);
Vector vModule = null, vAllModules = null;
String currentModule = null;

int i=0;
Messages messages = Messages.getMessages(request);

  if (outputLocation.equals("top")) {
    %><%@ include file="/includes/personalOutputTop.jsp"%><%
  }
	

	
}

} // Module Manager - Personal 
%>


