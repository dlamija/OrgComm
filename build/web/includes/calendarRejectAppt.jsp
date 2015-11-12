<HTML>
<HEAD>
<TITLE><%= messages.getString("reject") %>:</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=<%= TvoContextManager.getAttribute(request, "System.charset") %>">
</HEAD>

<BODY BGCOLOR="#C0C0C0" onLoad="window.focus();">
<FORM NAME="rejectAppt" METHOD="POST" ACTION="servlet/Calendar?action=rejectAppt">
<INPUT TYPE="HIDDEN" NAME="userApptID" VALUE="<%= request.getParameter("userApptID") %>">
  <TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0">
    <TR>
      <TD>
        <%= messages.getString("calendar.appt.reject.reason") %>:<br>
        <TEXTAREA NAME="reason" WRAP="VIRTUAL" COLS="51" ROWS="8"></TEXTAREA>
      </TD>
    </TR>
    <TR ALIGN="CENTER">
      <TD><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="5"></TD>
    </TR>
    <TR ALIGN="RIGHT">
      <TD>
      <A HREF="javascript:document.rejectAppt.submit();" onMouseOver="window.status='<%= messages.getString("reject") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_reject.gif\" WIDTH=\"38\" HEIGHT=\"18\" BORDER=\"0\" ALT=\"Click here to reject the appointment now\">" : messages.getString("reject") %></A>
      <A HREF="javascript:window.close();" onMouseOver="window.status='<%= messages.getString("cancel") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_cancel.gif\" WIDTH=\"40\" HEIGHT=\"18\" BORDER=\"0\" ALT=\"Click here to cancel and close window\">" : messages.getString("cancel") %></A></TD>
    </TR>
  </TABLE>
  </FORM>
<P>&nbsp;
</P>
</BODY>
</HTML>
