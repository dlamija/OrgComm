<%
String[] monthNames = {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
String[] dayNames = {"Sun","Mon","Tue","Wed","Thu","Fri","Sat"};

if ( (userCalendarACL.containsKey("view") && userCalendarACL.get("view").equals("1") ) || 
   (groupCalendarACL.containsKey("view") &&  groupCalendarACL.get("view").equals("1")) )
{
  if (userID != null && moduleName != null && action != null)
  {

	
    if (action.equals("viewDay") || action.equals("viewWeek"))
    {
      %><%@ include file="/template/default/calendarHeaderBox.jsp" %><%
    }
    if (action.equals("viewDay"))
    {
      %><%@ include file="/includes/calendarViewDay.jsp" %><%
    }
    if (action.equals("viewWeek"))
    {
      %><%@ include file="/includes/calendarViewWeek.jsp" %><%
    }
    if (action.equals("viewDay") || action.equals("viewWeek"))
    {
      %><%@ include file="/template/default/calendarFooterBox.jsp" %><%
    }
    
    if (action.equals("viewMonth"))
    {
      %>
      <%@ include file="/template/default/calendarHeaderMonthBox.jsp" %>
      <%@ include file="/includes/calendarViewMonth.jsp" %>
      <%@ include file="/template/default/calendarFooterMonthBox.jsp" %>      
      <%
    }
	
	if (ModuleManager.isEnabled(request, ModuleManager.MODULE_TAMS) &&
        action.equals("viewToDo"))
	{
	 String calendarEditHeaderName="";
	 calendarEditHeaderName = "View To Do";
	  %>        		
	    <%@ include file="/template/default/calendarViewHeader.jsp" %>
		<%@ include file="/includes/calendarViewToDo.jsp" %>
		<%@ include file="/template/default/calendarViewFooter.jsp" %>
	  <%
	}		
		
  }
}
else
{
%>

<TABLE WIDTH="100%" BORDER="0" CELLSPACING="10" CELLPADDING="0">
  <TR VALIGN="TOP">
    <TD> 
        <TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="3">
          <TR VALIGN="MIDDLE" >
            <TD HEIGHT="22" BACKGROUND="images/system/strap.gif" COLSPAN="5"><B><IMG SRC="images/system/blank.gif" WIDTH="20" HEIGHT="8"><FONT COLOR="#FFCC66" SIZE="2" CLASS="contentTitleFont">Calendar</FONT></B></TD>
          </TR>
          <TR VALIGN="MIDDLE">
            <TD  BGCOLOR="#003366" CLASS="contentStrapColor">&nbsp;</TD>
          </TR>
          
  <tr>
    <TD BGCOLOR="#EBEBEB" CLASS="contentBgColor" ALIGN="LEFT" VALIGN="MIDDLE">
    <%= messages.getString("calendar.user.no.access") %>
    </TD>
  </tr>
        
          <TR VALIGN="MIDDLE">
            <TD  BGCOLOR="#003366" CLASS="contentStrapColor">&nbsp;</TD>
          </TR>
        </TABLE>
    </TD>
  </TR>
</TABLE>
<%
}
%>
