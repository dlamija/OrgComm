<%
	String outStr = null;
	String action = request.getParameter("action");
	if (action == null) {
		action="view";
	}

	// if user clicked on appt box, revert to the userID stored in session
	if (request.getParameter("revert") != null) {
		TvoContextManager.setSessionAttribute(request, "Calendar.viewUserID", 
		TvoContextManager.getSessionAttribute(request, "Login.userID"));
		TvoContextManager.setSessionAttribute(request, "Calendar.lastView", "viewDay");
	}

	// The following handles user module actions
	if (action != null) {
		// set default view here
		if (action.equals("view") && TvoContextManager.getSessionAttribute(request, "Calendar.lastView") == null ) {
			action = "viewDay";
		}
		if (action.equals("view") && TvoContextManager.getSessionAttribute(request, "Calendar.lastView") != null ) {
			action = (String)TvoContextManager.getSessionAttribute(request, "Calendar.lastView");
		}
  
		// action for printing
		if (action.equals("printMonth")) {
%>
			<%@ include file="/includes/calendarPrintMonth.jsp" %>
<%		
		} else if (action.equals("printAppt")) {
%>
			<%@ include file="/includes/calendarPrintAppt.jsp" %>
<%		
		} else if (action.equals("viewDay") || action.equals("viewWeek") || action.equals("viewMonth")  || 
				(ModuleManager.isEnabled(request, ModuleManager.MODULE_TAMS) && action.equals("viewToDo"))) {
%>
			<%@ include file="/includes/calendarView.jsp" %><%-- <jsp:include page="/includes/calendarView.jsp" flush="true"/> --%>
<%
	}

//Breaking up Calendar to allow more code to be entered.
  if (action.equals("addAppt") || action.equals("addApptAttach") || action.equals("addToDo") || action.equals("addEvent") ||
      action.equals("getFreeTimeSlot") ||
      action.equals("addConflict") || action.equals("editConflict") || action.equals("listConflict") ||
      action.equals("editAppt") || action.equals("editApptAttach") || action.equals("editToDo") || action.equals("editEvent") ||
      action.equals("rejectAppt") || action.equals("rejectToDo")  || action.equals("emailRejectToDo") || action.equals("viewAgenda") || action.equals("reassignToDo") ) {
  %><jsp:include page="/calendarPopUp.jsp" flush="true">
      <jsp:param name="userID"     value="<%= userID %>" />
      <jsp:param name="action"     value="<%= action %>" />
      <jsp:param name="moduleName" value="<%= moduleName %>" />
    </jsp:include> 
		<%
  }
} // end of action handler
%>
