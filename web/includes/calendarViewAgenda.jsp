<%@ page import="java.net.URLDecoder" %>
<HTML>
<HEAD>
<TITLE><%= messages.getString("calendar.view.agenda") %></TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=<%= TvoContextManager.getAttribute(request, "System.charset") %>">
</HEAD>

<BODY BGCOLOR="#C0C0C0" onLoad="window.focus();">
  <TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
    <TR>
      <TD>
      <%= URLDecoder.decode(request.getParameter("agenda"))%>
      </TD>
    </TR>
    <TR ALIGN="CENTER">
      <TD><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="5"></TD>
    </TR>
    <TR ALIGN="RIGHT">
      <TD>
      <A HREF="#" onClick="window.close();"><%= showIcon ? "<IMG SRC=\"images/system/ic_cancel.gif\" WIDTH=\"40\" HEIGHT=\"18\" BORDER=\"0\" ALT=\"Click here to cancel and close window\">" : messages.getString("close") %></A></TD>
    </TR>
  </TABLE>
<P>&nbsp;
</P>
</BODY>
</HTML>
