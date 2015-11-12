<jsp:useBean id="beanLoginCheck" scope="request" class="common.security.LoginCheck" />
<%@page import="common.*" %>
<%
beanLoginCheck.validate(request, response);

String firstName, lastName;
firstName = (String)TvoContextManager.getSessionAttribute(request, "Login.firstName");
lastName = (String)TvoContextManager.getSessionAttribute(request, "Login.lastName");
%>
<script type="text/javascript">
<!--
	var secondsBeforeExpire = <%=session.getMaxInactiveInterval() %>;
	var timeToDecide = 30;
	setTimeout(function() { if (!confirm("Warning! \n\nYour session will expire in 30 seconds. Click OK to continue, or Cancel to logout.")) { window.location = "Logout"}}, (secondsBeforeExpire - timeToDecide) * 1000);
//-->
</script>