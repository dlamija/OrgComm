<%@ page import="utilities.LoggingUtil" %>
<%@ page import="common.*" %>
<%
	{
		String userID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
		LoggingUtil logUtil = new LoggingUtil();
		logUtil.initTVO(request);
		logUtil.recordModule(userID, "EIS");
	}
	
	String staffid = request.getParameter("staffid");
%>

<jsp:forward page="/cms/EIS/EIS.jsp" />