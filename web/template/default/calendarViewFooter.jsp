<%
  if (ModuleManager.isEnabled(request, ModuleManager.MODULE_RESOURCE))
  {
%>
 <TR BGCOLOR="#EFEFEF">
    <TD VALIGN="TOP" CLASS="contentBgColor" COLSPAN="2">&nbsp;</TD>
  </TR>
    <FORM NAME="calendarAdd2" METHOD="POST" ACTION="calendar.jsp" TARGET="calendarAdd">
    <TR VALIGN="MIDDLE" ALIGN="RIGHT">
      <TD  BGCOLOR="#003366" CLASS="contentStrapColor" COLSPAN="2">                          
        <SELECT NAME="action" onChange="MM_openBrWindow('','calendarAdd','scrollbars=yes,resizable=yes,width=480,height=420');document.calendarAdd2.submit();">
          <OPTION value="addAppt"><%= messages.getString("select") %></OPTION>
          <OPTION value="addAppt"><%= messages.getString("calendar.appointment") %></OPTION>
          <OPTION value="addToDo"><%= messages.getString("calendar.todo.task") %></OPTION>
          <!--<OPTION value="addEvent"><%= messages.getString("calendar.event") %></OPTION>-->
        </SELECT>
    </TR>
    </FORM>
</TABLE>
</BODY>
</HTML>

<%
  }
%>