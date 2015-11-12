<%
  String calendarEditHeaderName="";
  if (action.equals("editAppt"))
  {
    calendarEditHeaderName = messages.getString("calendar.editappt.appointment") ;
  }
  if (action.equals("editApptAttach"))
  {
    calendarEditHeaderName = "Edit Appointment Attachments";
  }
  if (action.equals("editToDo"))
  {
    calendarEditHeaderName = messages.getString("calendar.edit.todo.task") ;
  }
  if (action.equals("editEvent"))
  {
    calendarEditHeaderName = messages.getString("calendar.edit.event");
  }
  if (action.equals("editAppt") || action.equals("editApptAttach") || action.equals("editToDo") || action.equals("editEvent") )
  {
    %><%@ include file="/template/default/calendarEditHeader.jsp" %><%
  }
%>

<%
//if ( (userCalendarACL.containsKey("edit") && userCalendarACL.get("edit").equals("1") ) || 
 //  (groupCalendarACL.containsKey("edit") &&  groupCalendarACL.get("edit").equals("1")) )
//{
  if (userID != null && moduleName != null && action != null)
  {
    if (action.equals("editAppt"))
    {
      %><%@ include file="/includes/calendarEditAppt.jsp" %><%
    }
    if (action.equals("editApptAttach"))
    {
      %><%@ include file="/includes/calendarEditApptAttach.jsp" %><%
    }
    if (action.equals("editToDo"))
    {
      %><%@ include file="/includes/calendarEditToDo.jsp" %><%
    }
    if (action.equals("editEvent"))
    {
      %><%@ include file="/includes/calendarEditEvent.jsp" %><%
    }
  }
//}
//else
//{
//  out.println(messages.getString("calendar.user.no.access.edit"));
//}
%>

<%
  if (action.equals("editAppt") || action.equals("editApptAttach") || action.equals("editToDo") || action.equals("editEvent"))
  {
    %><%@ include file="/template/default/calendarEditFooter.jsp" %><%
  }
%>
