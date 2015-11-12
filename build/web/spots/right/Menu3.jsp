<%@ page import="common.*" %>
<%@ page import="java.util.Hashtable,java.util.Locale, java.util.Vector" %>
<%@ page import = "ecomm.bean.*" %>
<%@ taglib uri="oscache" prefix="cache" %>

<cache:cache scope="session" time="300" >


<%  
    Messages messages = Messages.getMessages(request);
    String language = (String)TvoContextManager.getAttribute(request, "System.language");
    String menuFont = "menuFont";
    if (language.equals("zh") || language.equals("ja"))
      menuFont = "menuGlyphFont";
%>
<script language="JavaScript" src="menu.js"></script>

<!-- Menu Box START -->
<table width="100%" border="0" cellspacing="1" class="sideTitleBgBorderColor">
  <div align="left" class="title" id="title1" > 
    <tr class="sideTitleBgBorderColor"> 
      <td class="sideTitleBgBorderColor" bgcolor="#1059A5" height="20"> <p align="center"><a href="#" onClick="expandcontent('sc2')"><font color="#FFFFFF" CLASS="sideTitleFont">Policy</font></a> </p></td>
    </tr>
	  </div>
</table>
<div align="left" class="switchcontent" id="sc2" >
  <table width="100%" border="0" cellspacing="0" class="sideTitleBgBorderColor">
    <tr>
      <td><table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF">
          <tr> 
            <td colspan="2" align="CENTER" bgcolor="#1059A5" class="menuBgColorHighlight"><img src="images/system/blank.gif" width="5" height="1"></td>
          </tr>
          <tr> 
            <td height="28" width="20%" align="CENTER"><img src="<%= request.getServletPath().equals("file:///news.jsp") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" width="16" height="16"></td>
            <td height="28" width="80%" class="sideBodyFontAndBgColor"><a href="/ump/sites/default/MBJ/E-Management_Policy.pdf" onMouseOver="window.status='E-Management Policy';return true;" target="_blank"><font color="#000000" size="2" class="sideBodyFontAndBgColor"> 
              E-Management</font></a></td>
          </tr>
          <tr valign="middle"> 
            <td height="28" align="CENTER"><img src="<%= request.getServletPath().equals("file:///news.jsp") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" width="16" height="16"></td>
            <td height="28" class="sideBodyFontAndBgColor"><a href="/ump/sites/default/MBJ/KMS_policy.PDF" onMouseOver="window.status='E-Management Policy';return true;" target="_blank"><font color="#000000" size="2" class="sideBodyFontAndBgColor"> 
              KMS</font></a></td>
          </tr>
          <tr valign="middle"> 
            <td height="28" align="CENTER"><img src="<%= request.getServletPath().equals("file:///news.jsp") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" width="16" height="16"></td>
            <td height="28" class="sideBodyFontAndBgColor"><a href="/ump/sites/default/MBJ/quality_policy.jpg" onMouseOver="window.status='Quality Policy';return true;" target="_blank"><font color="#000000" size="2" class="sideBodyFontAndBgColor">Quality 
              Policy</font></a></td>
          </tr>
          <tr valign="middle"> 
            <td height="28" align="CENTER"><img src="<%= request.getServletPath().equals("file:///news.jsp") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" width="16" height="16"></td>
            <td height="28" class="sideBodyFontAndBgColor"><a href="/ump/sites/default/MBJ/Performance_Measurements.jpg" onMouseOver="window.status='Performance Measurements';return true;" target="_blank"><font color="#000000" size="2" class="sideBodyFontAndBgColor">Performance 
              Measurements</font></a></td>
          </tr>
        </table></td>
  </tr>
</table> 
  
    
  <!-- Menu Box END -->
</div>

</cache:cache>