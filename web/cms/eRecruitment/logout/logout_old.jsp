<% 
if (session.isNew()==true)
response.sendRedirect( "../../eRecruitment.jsp" );
%>

<%session.invalidate();%>
<h4 align="center" class="style1">You were being Logged out </h4>
<div align="center"><br>
  <!--% response.sendRedirect(response.encodeRedirectURL("login.jsp"));%-->
  <!--<a href = "login.jsp"> Login </a><br>-->
  <b>Session ID: </b><%= session.getId() %>&nbsp; 
  <p></p>
</div>
            <!--%@ page session="true" %>
<!--%
//session.invalidate();
response.sendRedirect( "../../eRecruitment.jsp" );
session.invalidate();
% -->


