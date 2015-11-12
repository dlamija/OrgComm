<!-- CALENDAR BOX FOOTER START -->
                    <FORM NAME="calendarAdd2" METHOD="POST">
                    <TR VALIGN="MIDDLE" ALIGN="RIGHT">
                      <TD  BGCOLOR="#003366" CLASS="contentStrapColor" COLSPAN="2">                          
                        <SELECT NAME="action" onChange="calDispatch(this.value);">
                          <OPTION value="addAppt"><%= messages.getString("select") %></OPTION>
                          <OPTION value="addAppt"><%= messages.getString("calendar.appointment") %></OPTION>
                          <OPTION value="addToDo"><%= messages.getString("calendar.todo.task") %></OPTION>
                          <OPTION value="getFreeTimeSlot">Free Time Slot</OPTION>
                        </SELECT>
                    </TR>
                    </FORM>
                  </TABLE>
                </TD>
              </TR>
            </TABLE>
<!-- CALENDAR BOX FOOTER END -->
