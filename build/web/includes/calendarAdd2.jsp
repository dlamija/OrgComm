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
  if (action.equals("getFreeTimeSlot"))
  {
    calendarAddHeaderName = "Get Free Time Slot";
  }
  else if (action.equals("addConflict") || action.equals("editConflict"))
  {
    calendarAddHeaderName = messages.getString("calendar.conflicts.detected");
  }
  else if (action.equals("listConflict"))
  {
    calendarAddHeaderName = messages.getString("calendar.conflicts");
  }
  if (action.equals("getFreeTimeSlot") || action.equals("addConflict") || action.equals("editConflict") || action.equals("listConflict") )
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
    if (action.equals("getFreeTimeSlot"))
    {
      %><%@ include file="/includes/calendarGetFreeTimeSlot.jsp" %><%
    }
    else if (action.equals("addConflict") || action.equals("editConflict"))
    {
      %><%@ include file="/includes/calendarConflict.jsp" %><%
    }
    else if (action.equals("listConflict"))
    {
      %><%@ include file="/includes/calendarListConflict.jsp" %><%
    }
  }
}
else
{
  out.println(messages.getString("calendar.user.no.access.add"));
}
%>

<%
  if (action.equals("getFreeTimeSlot") || action.equals("addConflict") || action.equals("editConflict") || action.equals("listConflict") )
  {
    %><%@ include file="/template/default/calendarAddFooter.jsp" %><%
  }
%>
