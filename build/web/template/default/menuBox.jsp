      <!-- Menu Box START -->
      <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
      <TR>
        <TD COLSPAN="2" ALIGN="CENTER" BGCOLOR="#000000" CLASS="menuBgColorShadow"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
      </TR>
      <TR BGCOLOR="#CCCCCC" ALIGN="CENTER">
        <TD VALIGN="MIDDLE" BGCOLOR="#666666" CLASS="calendarMonthBgColor" ALIGN="CENTER"><B><a href="" onclick="toggleBlock('leftmenubox'); return false" onMouseOver="window.status='<%= messages.getString("menu") %>';return true;""><FONT COLOR="#FFFFFF" CLASS="calendarMonthFont"><%= messages.getString("menu") %></FONT></a></B></TD>
        <TD VALIGN="MIDDLE" BGCOLOR="#666666" CLASS="calendarMonthBgColor" ALIGN="CENTER"><IMG SRC="images/system/blank.gif" WIDTH="1" HEIGHT="20"></TD>
      </TR>
      <TR>
        <TD COLSPAN="2" ALIGN="CENTER" BGCOLOR="#000000" CLASS="menuBgColorShadow"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
      </TR>
      </TABLE>
      <DIV id="leftmenubox">
      <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
       <TR>
          <TD COLSPAN="2" ALIGN="CENTER" BGCOLOR="#1059A5" CLASS="menuBgColorHighlight"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="1"></TD>
        </TR>
        <TR>
          <TD WIDTH="20%" HEIGHT="28" ALIGN="CENTER" bgcolor="#000000"><IMG SRC="<%= request.getServletPath().equals("/news.jsp") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" WIDTH="16" HEIGHT="16"></TD>
          <TD WIDTH="80%" HEIGHT="28" bgcolor="#000000"><B><A HREF="EIS.jsp" onMouseOver="window.status='<%= messages.getString("latest.news") %>';return true;"><FONT COLOR="#FFFFFF" CLASS="menuFont">
           Executive Approval System</FONT></A></B></TD>
        </TR>
        <TR>
          <TD COLSPAN="2" ALIGN="CENTER" BGCOLOR="#1059A5" CLASS="menuBgColorHighlight"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="1"></TD>
        </TR>
       
        <TR bgcolor="#000000">
          <TD COLSPAN="2" ALIGN="CENTER" CLASS="menuBgColorShadow"><IMG SRC="images/system/blank.gif" WIDTH="120" HEIGHT="2"></TD>
        </TR>
        <TR bgcolor="#000000">
          <TD COLSPAN="2" ALIGN="CENTER" CLASS="menuBgColorHighlight"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="1"></TD>
        </TR>
        <TR>
          <TD WIDTH="20%" HEIGHT="28" ALIGN="CENTER" bgcolor="#000000"><IMG SRC="<%= request.getServletPath().equals("/library.jsp") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" WIDTH="15" HEIGHT="17"></TD>
          <TD WIDTH="80%" HEIGHT="28" bgcolor="#000000"><B><A HREF="announcement.jsp" onMouseOver="window.status='<%= messages.getString("files.library") %>';return true;"><FONT COLOR="#FFFFFF" CLASS="menuFont">
            Announcement</FONT></A></B></TD>
        </TR>
         <TR bgcolor="#000000">
          <TD COLSPAN="2" ALIGN="CENTER" CLASS="menuBgColorHighlight"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="1"></TD>
        </TR>
        <TR>
          <TD WIDTH="20%" HEIGHT="28" ALIGN="CENTER" bgcolor="#000000"><IMG SRC="<%= request.getServletPath().equals("/library.jsp") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" WIDTH="15" HEIGHT="17"></TD>
          <TD WIDTH="80%" HEIGHT="28" bgcolor="#000000"><B><A HREF="memo.jsp?action=folders&type=Y&folderID=1" onMouseOver="window.status='<%= messages.getString("files.library") %>';return true;"><FONT COLOR="#FFFFFF" CLASS="menuFont">
            Memo</FONT></A></B></TD>
        </TR>
         <TR bgcolor="#000000">
          <TD COLSPAN="2" ALIGN="CENTER" CLASS="menuBgColorHighlight"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="1"></TD>
        </TR>
      
      
        <TR>
          <TD COLSPAN="2" ALIGN="CENTER" BGCOLOR="#000000" CLASS="menuBgColorShadow"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
        </TR>
        <TR>
          <TD COLSPAN="2" ALIGN="CENTER" BGCOLOR="#1059A5" CLASS="menuBgColorHighlight"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="1"></TD>
        </TR>
      </TABLE>
</DIV>
      <!-- Menu Box END -->

