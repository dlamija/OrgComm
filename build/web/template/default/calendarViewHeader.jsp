<%
  if (ModuleManager.isEnabled(request, ModuleManager.MODULE_RESOURCE))
  {
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
<SCRIPT LANGUAGE="JavaScript">
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
</script>
<BODY BGCOLOR="#C0C0C0" LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" onLoad="window.focus();">

<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0">
  <TR>
    <TD ALIGN="LEFT" VALIGN="MIDDLE" BGCOLOR="#003399" COLSPAN="2"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
  </TR>
  <FORM NAME="calendarAdd" METHOD="POST" ACTION="calendar.jsp" TARGET="calendarAdd">
  <TR>
    <TD VALIGN="MIDDLE"><FONT FACE="Arial" SIZE="2" COLOR="#FFFFFF"></FONT>&nbsp;<FONT FACE="Arial" SIZE="2" COLOR="#FFFFFF"></FONT>&nbsp;<FONT FACE="Arial" SIZE="2" COLOR="#FFFFFF"></FONT></TD>
    <TD VALIGN="MIDDLE" ALIGN="RIGHT">
      <SELECT NAME="action" onChange="MM_openBrWindow('','calendarAdd','scrollbars=yes,resizable=yes,width=480,height=420');document.calendarAdd.submit();">
        <OPTION value="addAppt"><%= messages.getString("select") %></OPTION>
        <OPTION value="addAppt"><%= messages.getString("calendar.appointment") %></OPTION>
        <OPTION value="addToDo"><%= messages.getString("calendar.todo.task") %></OPTION>
        <!--<OPTION value="addEvent"><%= messages.getString("calendar.event") %></OPTION>-->
      </SELECT>
  </TR>
  </FORM>
  <TR>
    <TD COLSPAN="2" BGCOLOR="#0066CC"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
  </TR>
  <TR>
    <TD COLSPAN="2" ALIGN="CENTER" BGCOLOR="#003399"><FONT SIZE="2" FACE="Arial" COLOR="#FFFFFF"><B><%= messages.getString("calendar.view.todo") %></B></FONT>
    </TD>
  </TR>
  <TR>
    <TD COLSPAN="2" BGCOLOR="#000037"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="3"></TD>
  </TR>
</TABLE>

<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
  <TR>
    <TD BGCOLOR="#EFEFEF" VALIGN="TOP" CLASS="contentBgColor" COLSPAN="2"><IMG SRC="images/system/blank.gif" WIDTH="83" HEIGHT="10"></TD>
  </TR>
  
<%
  }
%>  