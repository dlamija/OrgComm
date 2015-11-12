<%@ include file="/template/default/calendarPopUp_top.jsp" %>

<%
  // New Action For Conflicting appointments
  if (action.equals("editAppt") || action.equals("editApptAttach") || action.equals("editToDo") || action.equals("editEvent")) {
    %><%@ include file="/includes/calendarEdit.jsp" %><%
  }
  else if (action.equals("rejectAppt") ) {
    %><%@ include file="/includes/calendarRejectAppt.jsp" %><%
  }
  else if (action.equals("rejectToDo") ) {
    %><%@ include file="/includes/rejectToDo.jsp" %><%
  }
  else if (action.equals("emailRejectToDo") ) {
    %><%@ include file="/includes/emailRejectToDo.jsp" %><%
  }
  else if (action.equals("viewAgenda") ) {
    %><%@ include file="/includes/calendarViewAgenda.jsp" %><%
  }
  else if (action.equals("reassignToDo") ) {
    %><%@ include file="/includes/calendarToDoReassign.jsp" %><%
  }
%>