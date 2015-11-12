<%
//session.invalidate();
response.sendRedirect( "../../eRecruitment.jsp?action=login_admin" );
session.invalidate();
%>