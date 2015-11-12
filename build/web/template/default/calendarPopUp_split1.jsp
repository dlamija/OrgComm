<%@ include file="/template/default/calendarPopUp_top.jsp" %>

<%
  // New Action For Conflicting appointments 
  if (action.equals("addAppt") || action.equals("addApptAttach") || action.equals("addToDo") || action.equals("addEvent")) {
    %><%@ include file="/includes/calendarAdd1.jsp" %><%
  }
  
%>