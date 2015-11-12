
<%


// Module Manager - Personal
if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_PERSONAL) ) {
%>
<jsp:useBean id="beanRightNotepad" scope="request" class="ecomm.bean.NotepadNotepad" />
<%
  int ci;
  Cookie cookies[] = request.getCookies();
  String cookiename;
  boolean loadNotepad = true;
  StringBuffer notepadContents = new StringBuffer("");
  
  cookiename = userID + "rightnotepad";
  for (ci=0; ci < cookies.length; ci++)
  {
    if (cookies[ci].getName().equals(cookiename))
    {
      if ( cookies[ci].getValue().equals("none") )
        loadNotepad = false;
      break;
    }
  }
  if (loadNotepad)
  {
    beanRightNotepad.initTVO(request);
    notepadContents = beanRightNotepad.getNotepadContents(userID);
  }
	String contents = notepadContents.toString();
		
	String sideTitleFont = "sideTitleFont";
  if (language.equals("zh") || language.equals("ja"))
    sideTitleFont = "sideTitleGlyphFont";

  if ( language.equals("en"))
    showIcon = true;
	

%>
<SCRIPT LANGUAGE="JavaScript">
function notepadSave()
{
  if (document.notepadRightBoxSave.notepadContents.value.length > <%= beanRightNotepad.MAX_LENGTH %>)
  {
    alert('Notepad Contents Exceeds <%= beanRightNotepad.MAX_LENGTH %> characters, it will be truncated.');
    document.notepadRightBoxSave.notepadContents.value = document.notepadRightBoxSave.notepadContents.value.substr(0, <%= beanRightNotepad.MAX_LENGTH %>);
  }
  document.notepadRightBoxSave.submit();
}
function notepadClear()
{
  if (confirm("<%= messages.getString("notepad.sure") %>"))
  {
    document.notepadRightBoxSave.notepadContents.value = "";
    document.notepadRightBoxSave.submit();
  }
}
function notepadShow()
{
  var reloadNotepad = false;
  if (document.all['rightnotepad'].style.display == "none" )
    reloadNotepad = true;
  toggleBlock('rightnotepad');
  if (reloadNotepad)
    location.reload();
}
</SCRIPT><img src="images/quicklinks/notepad.png" />
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="1">
<TR ALIGN="CENTER">
     <TD CLASS="sideTitleBgBorderColor" BGCOLOR="#1059A5">
       <!--CLASS="sideTitleBgBorderColor"-->
       <DIV id="rightnotepad">
         <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="5">
                    <TR ALIGN="CENTER">
                      <TD BGCOLOR="#FFFFFF" class='contentBgColorAlternate'><!--CLASS="sideBodyFontAndBgColor"-->
                      <FORM METHOD="POST" ACTION="Notepad" NAME="notepadRightBoxSave">
                        <INPUT TYPE="HIDDEN" NAME="action" VALUE="save">
                        <TEXTAREA NAME="notepadContents" ROWS="8" COLS="25" wrap="virtual" CLASS="TextAreaScrollColor" style="font-size:11px; border: none font-family: Arial; background-color: #EEEEEE"><%= contents %></TEXTAREA>
                        <BR><A HREF="javascript:notepadSave();" onMouseOver="window.status='<%= messages.getString("save") %>';return true;"><IMG SRC="images/system/<%= messages.getString("save.icon") %>.gif" ALIGN="MIDDLE" BORDER="0" ALT="<%= messages.getString("save") %>"></A> <A HREF="javascript:notepadClear();" onMouseOver="window.status='<%= messages.getString("clear") %>';return true;"><IMG SRC="images/system/<%= messages.getString("clear.icon") %>.gif" ALIGN="MIDDLE" BORDER="0" ALT="<%= messages.getString("clear") %>"></A>
                        </FORM>
                      </TD>
                    </TR>
         </TABLE>
       </DIV>
    </TD>
  </TR>
   <TR HEIGHT="5">
     <TD></TD>
   </TR>
</TABLE>
	<SCRIPT LANGUAGE="JavaScript">
		loadBox('rightnotepad');
	</SCRIPT>
<%
} // Module Manager - Personal %>

