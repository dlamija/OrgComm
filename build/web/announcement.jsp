<%@ page import="utilities.LoggingUtil" %>
<%@ page import="common.*" %>
<%
	{
		String userID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
		LoggingUtil logUtil = new LoggingUtil();
		logUtil.initTVO(request);
		logUtil.recordModule(userID, "announcement");
	}
	
	String mesej = request.getParameter("rte1");	
	String ref =request.getParameter("id");
	
%>

<jsp:forward page="cms/announcement/announcement.jsp" />
