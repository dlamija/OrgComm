<%@ page import="java.util.*" %>
<%
  if (request.getParameter("date") != null &&
      request.getParameter("month") != null &&
      request.getParameter("year") != null )
  {
    TvoContextManager.setSessionAttribute(request, "Calendar.date", request.getParameter("date"));
    TvoContextManager.setSessionAttribute(request, "Calendar.month", request.getParameter("month"));
    TvoContextManager.setSessionAttribute(request, "Calendar.year", request.getParameter("year"));
  }

  String calendarAddHeaderName="";
  if (action.equals("addAppt"))
  {
    calendarAddHeaderName = messages.getString("calendar.adding.new.appointment");
  }
  else if (action.equals("addConflict") || action.equals("editConflict"))
  {
    calendarAddHeaderName = messages.getString("calendar.conflicts.detected");
  }
  else if (action.equals("listConflict"))
  {
    calendarAddHeaderName = messages.getString("calendar.conflicts");
  }
  else if (action.equals("addToDo"))
  {
    calendarAddHeaderName = messages.getString("calendar.adding.todo.task");
  }
  else if (action.equals("addEvent"))
  {
    calendarAddHeaderName = messages.getString("calendar.adding.new.event");
  }
  if (action.equals("addAppt") || action.equals("addToDo") || action.equals("addEvent") || action.equals("addConflict") || action.equals("editConflict") || action.equals("listConflict") )
  {
    %><%@ include file="/template/default/calendarAddHeader.jsp" %><%
  }
%>

<%
if ( (userCalendarACL.containsKey("view") && userCalendarACL.get("view").equals("1") ) || 
   (groupCalendarACL.containsKey("view") &&  groupCalendarACL.get("view").equals("1")) )
{
  if (userID != null && moduleName != null && action != null)
  {
    if (action.equals("addAppt"))
    {
      %><%@ include file="/includes/calendarAddAppt.jsp" %><%
    }
    else if (action.equals("addConflict") || action.equals("editConflict"))
    {
      %><%@ include file="/includes/calendarConflict.jsp" %><%
    }
    else if (action.equals("listConflict"))
    {
      %><%@ include file="/includes/calendarListConflict.jsp" %><%
    }
    else if (action.equals("addToDo"))
    {
      %><%@ include file="/includes/calendarAddToDo.jsp" %><%
    }
    else if (action.equals("addEvent"))
    {
      %><%@ include file="/includes/calendarAddEvent.jsp" %><%
    }
  }
}
else
{
  out.println(messages.getString("calendar.user.no.access.add"));
}
%>

<%
  if (action.equals("addAppt") || action.equals("addToDo") || action.equals("addEvent") || action.equals("addConflict") || action.equals("editConflict") || action.equals("listConflict") )
  {
    %><%@ include file="/template/default/calendarAddFooter.jsp" %><%
  }
%>
