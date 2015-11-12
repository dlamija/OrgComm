
<%@ page import="java.util.*" %>
<%@ page buffer="1024kb" autoFlush="true" %> 
<!--%@ include file="//includes/loginCheck.jsp" % -->

<HTML>
<HEAD>
<TITLE>IMSHRM</TITLE>
<%@ include file="//includes/no-cache.jsp" %>
<%--<LINK REL="stylesheet" HREF="css/<%= (String)TvoContextManager.getSessionAttribute(request, "Login.CSSFile") %>">--%>

</HEAD>

<BODY LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" BGCOLOR="#FFFFFF" onLoad="loadBoxes();">
<%@ include file="/template/default/topMenuBar.jsp" %>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><%@ include file="/spots/left/Menu Box.jsp" %>
    



    <!--%@ include file="/spots/left/RefNotepad.jsp" % -->
    <!--%@ include file="/spots/left/RefStatus.jsp" %--></td>
  </tr>
  
</table>
    </td>
    <td width="3%" align=left></td>
    <td width="84%" align=left>
	<!--%@ include file="/includes/personalOutputMiddle.jsp" % -->
     
      <H1>&nbsp;&nbsp;&nbsp;Prayer Time</H1>
     <p><table width="100%" border="0" cellspacing="0" cellpadding="0">
    <td width="68%">&nbsp;</td>
  </tr>
</table></p></td>
  </tr>
  <tr>
    <td colspan="3" align=center valign="top">&nbsp;</td>


</table>

</BODY>
</HTML>
