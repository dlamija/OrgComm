<%
  int i,j;
  Vector userList=null;
  Vector vReassUserID=null;
  boolean alreadyAssigned=false;
  userList = beanCalendarDirectory.showModule(userID, "Users", "view");
 
  if (request.getParameter("calendarToDoUserID") != null)
  {
    vReassUserID = (Vector)beanCalendar.getToDoReassignees(request.getParameter("calendarToDoUserID"), userID);
  }
%>
<HTML>
<HEAD>
<TITLE><%= Constants.PRODUCT_NAME %> <%= messages.getString("calendar") %></TITLE>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", -1);
%>
<META HTTP-EQUIV="Expires" CONTENT="-1">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" VALUE="no-cache">
</HEAD>
<BODY BGCOLOR="#C0C0C0" LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" onLoad="window.focus();">

<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0">
  <TR>
    <TD ALIGN="LEFT" VALIGN="MIDDLE" BGCOLOR="#003399" COLSPAN="2"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
  </TR>
  <TR>
    <TD VALIGN="MIDDLE"><FONT FACE="Arial" SIZE="2" COLOR="#FFFFFF"></FONT>&nbsp;<FONT FACE="Arial" SIZE="2" COLOR="#FFFFFF"></FONT>&nbsp;<FONT FACE="Arial" SIZE="2" COLOR="#FFFFFF"></FONT></TD>
    <TD VALIGN="MIDDLE" ALIGN="RIGHT">&nbsp;</TD>
  </TR>
  <TR>
    <TD COLSPAN="2" BGCOLOR="#0066CC"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
  </TR>
  <TR>
    <TD COLSPAN="2" ALIGN="CENTER" BGCOLOR="#003399"><FONT SIZE="2" FACE="Arial" COLOR="#FFFFFF"><B><%= messages.getString("calendar.reassign.title") %></B></FONT>
    </TD>
  </TR>
  <TR>
    <TD COLSPAN="2" BGCOLOR="#000037"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="3"></TD>
  </TR>
</TABLE>

<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
  <SCRIPT LANGUAGE="JavaScript">
  function checkReassign()
  {
    if (document.reassignToDo.userIDassigned.selectedIndex <= 0)
      alert("<%= messages.getString("calendar.reassign.select.user") %>");
    else
      document.reassignToDo.submit();  
  }
  </SCRIPT>
  <FORM NAME="reassignToDo" METHOD="POST" ACTION="servlet/Calendar?action=reassignToDo">
  <INPUT TYPE="HIDDEN" NAME="calendarToDoUserID" VALUE="<%= request.getParameter("calendarToDoUserID") %>">
    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT"><%= messages.getString("calendar.reassign.ressign.to") %> &nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%">
        <SELECT NAME="userIDassigned">
          <OPTION VALUE=""><%= messages.getString("select") %></OPTION>
          <%
            if (userList != null)
            for (i=0; i < userList.size()-1; i++)
            {
						  UsersDB users = (UsersDB) userList.get(i);
              if ( !(users.getUserID()).equals(userID) &&
                   !request.getParameter("assignedBy").equals(users.getUserID()) )
              {
                alreadyAssigned = false;
                if (vReassUserID != null)
                {
                  for (j=0; j < vReassUserID.size(); j++)
                    if ( ((String)vReassUserID.get(j)).equals(users.getUserID()) )
                      alreadyAssigned = true;
                }
                if (!alreadyAssigned)
                {                
                  %>
                  <OPTION VALUE="<%= users.getUserID() %>"><%= users.getName() %>
                  <%
                }
              }
            }
          %>
        </SELECT>
      </TD>
    </TR>
    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" ALIGN="RIGHT" VALIGN="TOP"><%= messages.getString("calendar.todo.allow.assign.task") %>?&nbsp;&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" VALIGN="TOP">
        <INPUT TYPE="radio" NAME="allowReassign" VALUE="0" CHECKED>
                          <%= messages.getString("no") %> 
        <INPUT TYPE="radio" NAME="allowReassign" VALUE="1" >
                          <%= messages.getString("yes") %>
      </TD>
    </TR>
    <TR VALIGN="MIDDLE">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%">&nbsp;</TD>
    </TR>
    <TR VALIGN="MIDDLE">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%">
        <P>&nbsp;</P>
      </TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%">
      <A HREF="javascript:checkReassign();" onMouseOver="window.status='<%= messages.getString("save") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_save.gif\" WIDTH=\"34\" HEIGHT=\"18\" BORDER=\"0\">" : messages.getString("save") %></A> <A HREF="javascript:window.close();" onMouseOver="window.status='<%= messages.getString("cancel") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_cancel.gif\" WIDTH=\"40\" HEIGHT=\"18\" BORDER=\"0\">" : messages.getString("cancel") %></A></TD>
    </TR>
    <TR VALIGN="MIDDLE">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%">&nbsp;</TD>
    </TR>
  </FORM>
</TABLE>
</BODY>
</HTML>
