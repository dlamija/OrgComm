<!-- CALENDAR ADD APPT FOOTER START -->
  <TR BGCOLOR="#EFEFEF">
    <TD VALIGN="TOP" CLASS="contentBgColor" COLSPAN="2">&nbsp;</TD>
  </TR>

    <FORM NAME="calendarAdd2" METHOD="POST">
    <TR VALIGN="MIDDLE" ALIGN="RIGHT">
      <TD  BGCOLOR="#003366" CLASS="contentStrapColor" COLSPAN="2">                          
        <SELECT onChange="calDispatch(this.value);">
          <OPTION value="addAppt"><%= messages.getString("select") %></OPTION>
          <OPTION value="addAppt"><%= messages.getString("calendar.appointment") %></OPTION>
          <OPTION value="addToDo"><%= messages.getString("calendar.todo.task") %></OPTION>
          <OPTION value="getFreeTimeSlot">Free Time Slot</OPTION>
        </SELECT>
     </TD>
    </TR>
    </FORM>
</TABLE>
<% String ignoreList = "addAppt,addApptAttach,addConflict,editConflict,listConflict,addToDo,"; %>
<% if (ignoreList.indexOf(action + ",") == -1) { %>
</BODY>
</HTML>
<% } else { %>
		</td></tr>
	</TABLE>
<% } %>
<!-- CALENDAR ADD APPT FOOTER END -->