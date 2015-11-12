<%@ include file="/template/default/calendarPopUp_top.jsp" %>

<%
  // New Action For Conflicting appointments 
  if (action.equals("getFreeTimeSlot") || action.equals("addConflict") || action.equals("editConflict") || action.equals("listConflict") ) {
    %><%@ include file="/includes/calendarAdd2.jsp" %><%
  }
%>