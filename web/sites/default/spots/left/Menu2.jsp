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

<!-- Menu Box START -->
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
  <TR BGCOLOR="#CCCCCC" ALIGN="CENTER"> 
    <TD VALIGN="MIDDLE" CLASS="sideTitleBgBorderColor" BGCOLOR="#1059A5" ALIGN="CENTER"><B><a href="" onclick="toggleBlock('rightMenu2'); return false" onMouseOver="window.status='General Menu';return true;"><FONT COLOR="#FFFFFF" CLASS="sideTitleFont">General 
      Menu</FONT></a></B></TD>
    <TD VALIGN="MIDDLE" CLASS="sideTitleBgBorderColor" BGCOLOR="#1059A5" ALIGN="CENTER"><IMG SRC="file:///C|/oc4j/j2ee/home/applications/kuktem/kuktem/sites/default/spots/right/images/system/blank.gif" WIDTH="1" HEIGHT="20"></TD>
  </TR>
  <TR BGCOLOR="#CCCCCC" ALIGN="CENTER">
    <TD VALIGN="MIDDLE" CLASS="sideTitleBgBorderColor" BGCOLOR="#1059A5" ALIGN="CENTER">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF">
        <tr> 
          <td colspan="2" align="CENTER" bgcolor="#1059A5" class="menuBgColorHighlight"><img src="file:///C|/oc4j/j2ee/home/applications/kuktem/kuktem/sites/default/spots/right/images/system/blank.gif" width="5" height="1"></td>
        </tr>
        <jsp:useBean id="beanNews" scope="request" class="ecomm.bean.NewsNews" />
        <jsp:useBean id="beanNewsACL" scope="request" class="ecomm.bean.ACL" />
        <%
    Hashtable userNewsACL, groupNewsACL;
    String userID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
    String moduleName = "News";

    beanNews.initTVO(request,application);
    beanNewsACL.initTVO(request);

    userNewsACL = beanNewsACL.getRights(userID, moduleName, "User");
    groupNewsACL = beanNewsACL.getRights(userID, moduleName, "Group");
    String staffID = (String) TvoContextManager.getSessionAttribute(request,"Login.CMSID");
%>
        <jsp:useBean id="deptCode" scope="request" class="common.StaffStudent"/>
        <%  
    String deptcode = deptCode.getDeptCode(request,response, staffID);
	  	 
    session.setAttribute("staffid", staffID); 
    session.setAttribute("deptcode", deptcode); 	  
	  

    if ( (userNewsACL.containsKey("view") && userNewsACL.get("view").equals("1") ) ||
       (groupNewsACL.containsKey("view") &&  groupNewsACL.get("view").equals("1")) )   {
%>
        <tr> 
          <td height="28" width="20%" align="CENTER"><img src="<%= request.getServletPath().equals("/news.jsp") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" width="16" height="16"></td>
          <td height="28" width="80%"><a href="file:///C|/oc4j/j2ee/home/applications/kuktem/kuktem/sites/default/spots/right/news.jsp?action=view" onMouseOver="window.status='<%= messages.getString("latest.news") %>';return true;"><font color="#000000" size="2" class="sideBodyFontAndBgColor"> 
            <%= messages.getString("latest.news") %></font></a></td>
        </tr>
        <%  }  %>
        <jsp:useBean id="beanLibrary" scope="request" class="ecomm.bean.LibraryLibrary" />
        <jsp:useBean id="beanLibraryDirectory" scope="request" class="common.Directory" />
        <jsp:useBean id="beanLibraryACL" scope="request" class="ecomm.bean.ACL" />
        <%

    Hashtable userLibraryACL, groupLibraryACL;
    moduleName = "Library";

    beanLibrary.initTVO(request,application);
    beanLibraryDirectory.initTVO(request);
    beanLibraryACL.initTVO(request);
    boolean showIcon = false;
    userLibraryACL = beanLibraryACL.getRights(userID, moduleName, "User");
    groupLibraryACL = beanLibraryACL.getRights(userID, moduleName, "Group");

    if ( (userLibraryACL.containsKey("view") && userLibraryACL.get("view").equals("1") ) ||
         (groupLibraryACL.containsKey("view") &&  groupLibraryACL.get("view").equals("1")) )
            {
%>
        <tr> 
          <td height="28" width="20%" align="CENTER"><img src="<%= request.getServletPath().equals("/library.jsp") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" width="15" height="17"></td>
          <td height="28" width="80%"><a href="file:///C|/oc4j/j2ee/home/applications/kuktem/kuktem/sites/default/spots/right/library.jsp?action=view" onMouseOver="window.status='<%= messages.getString("files.library") %>';return true;"><font color="#000000" size="2" class="sideBodyFontAndBgColor"> 
            <%= messages.getString("files.library") %></font></a></td>
        </tr>
        <%  } %>
        <jsp:useBean id="beanHotLinksACL" scope="request" class="ecomm.bean.ACL" />
        <jsp:useBean id="beanHotLinks" scope="request" class="ecomm.bean.HotLinksHotLinks" />
        <jsp:useBean id="beanHotLinksDirectory" scope="request" class="common.Directory" />
        <%
    Hashtable userHotLinksACL, groupHotLinksACL;
    moduleName = "HotLinks";


    beanHotLinks.initTVO(request);
    beanHotLinksACL.initTVO(request);
    beanHotLinksDirectory.initTVO(request);

    userHotLinksACL = beanHotLinksACL.getRights(userID, moduleName, "User");
    groupHotLinksACL = beanHotLinksACL.getRights(userID, moduleName, "Group");

    if ( (userHotLinksACL.containsKey("view") && userHotLinksACL.get("view").equals("1") ) ||
         (groupHotLinksACL.containsKey("view") &&  groupHotLinksACL.get("view").equals("1")) )
    {
%>
        <tr> 
          <td height="28" width="20%" align="CENTER"><img src="<%= request.getServletPath().equals("/hotlinks.jsp") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" width="15" height="17"></td>
          <td height="28" width="80%"><a href="file:///C|/oc4j/j2ee/home/applications/kuktem/kuktem/sites/default/spots/right/hotlinks.jsp?action=view" onMouseOver="window.status='<%= messages.getString("bookmarks") %>';return true;"><font color="#000000" size="2" class="sideBodyFontAndBgColor"> 
            <%= messages.getString("bookmarks") %></font></a></td>
        </tr>
        <%  }
    String action = "view";
    int display = 0;

%>
        <tr> 
          <td height="28" width="20%" align="CENTER"><img src="<%= request.getServletPath().equals("/resourceCMS.jsp") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" width="15" height="17"></td>
          <td height="28" width="80%"><a href="file:///C|/oc4j/j2ee/home/applications/kuktem/kuktem/sites/default/spots/right/resourceCMS.jsp?action=view" onMouseOver="window.status='Resource Booking';return true;"><font color="#000000" size="2" class="sideBodyFontAndBgColor"> 
            Resource Booking </font></a></td>
        </tr>
        <%
    // Module Manager - TAMS
    if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_TAMS) )   {
%>
        <!-- TAMS -->
        <jsp:useBean id="beanCalendarACL" scope="request" class="ecomm.bean.ACL" />
        <jsp:useBean id="beanTams" scope="request" class="ecomm.bean.TamsTams" />
        <jsp:useBean id="beanTamsDirectory" scope="request" class="common.Directory" />
        <%
      action = request.getParameter("action");
      Hashtable userCalendarACL, groupCalendarACL;
      moduleName = "Calendar";

      beanCalendarACL.initTVO(request);
      beanTams.initTVO(request);

      userCalendarACL = beanCalendarACL.getRights(userID, moduleName, "User");
      groupCalendarACL = beanCalendarACL.getRights(userID, moduleName, "Group");

      if ( (userCalendarACL.containsKey("view") && userCalendarACL.get("view").equals("1") ) ||
           (groupCalendarACL.containsKey("view") &&  groupCalendarACL.get("view").equals("1")) )     {
%>
        <tr> 
          <td height="28" width="20%" align="CENTER"><img src="<%= request.getServletPath().equals("/tams.jsp") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" width="15" height="17"></td>
          <td height="28" width="80%"><a href="file:///C|/oc4j/j2ee/home/applications/kuktem/kuktem/sites/default/spots/right/tams.jsp?action=viewCurrent" onMouseOver="window.status='<%= messages.getString("task.manager") %>';return true;"><font color="#000000" size="2" class="sideBodyFontAndBgColor"> 
            <%= messages.getString("task.manager") %></font></a></td>
        </tr>
        <%    }
    
      // Module Manager - TAMS
    }    
%>
        <jsp:useBean id="beanExApplication" scope="request" class="ecomm.bean.ExApplicationExApplication" />
        <jsp:useBean id="staffStudent" scope="request" class="common.StaffStudent"/>
        <%
    String userType = staffStudent.getUserType(request,response, userID);
    moduleName = "ExApplication";

    beanExApplication.initTVO(request);
    Vector vExApplication = beanExApplication.getExApplication(request,false);
    int count = (vExApplication.size());
    boolean isSuperAdmin = beanExApplication.isSuperAdmin(request);

    display = 0;

    if (isSuperAdmin || count > 0)
        display = 1;


    if (display == 1)    {
%>
        <tr> 
          <td height="28" width="20%" align="CENTER"><img src="<%= request.getServletPath().equals("/exApplication.jsp") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" width="15" height="17"></td>
          <td height="28" width="80%"><a href="file:///C|/oc4j/j2ee/home/applications/kuktem/kuktem/sites/default/spots/right/exApplication.jsp?action=view" onMouseOver="window.status='<%= messages.getString("external.application") %>';return true;"><font color="#000000" size="2" class="sideBodyFontAndBgColor"> 
            <%= messages.getString("external.application") %></font></a></td>
        </tr>
        <%  }  %>
        <% if (userType.equals("STAFF")) { %>
        <!-- TQO Feedback module -->
        <tr> 
          <td height="28" width="20%" align="CENTER"><img src="<%= (request.getServletPath().equals("/tqo.jsp") )  ? "images/system/folder2.gif" : "images/system/folder.gif" %>" width="15" height="17"></td>
          <td height="28" width="80%"><a href="file:///C|/oc4j/j2ee/home/applications/kuktem/kuktem/sites/default/spots/right/tqo.jsp?action=feedback" onMouseOver="window.status='TQO Feedback';return true;"><font color="#000000" size="2" class="sideBodyFontAndBgColor">TQO 
            Feedback</font></a></td>
        </tr>
        <!-- Document Management -->
        <tr> 
          <td height="28" width="20%" align="CENTER"><img src="<%= (request.getServletPath().equals("/documentManagement.jsp") )  ? "images/system/folder2.gif" : "images/system/folder.gif" %>" width="15" height="17"></td>
          <td height="28" width="80%"><a href="file:///C|/oc4j/j2ee/home/applications/kuktem/kuktem/sites/default/spots/right/documentManagement.jsp" onMouseOver="window.status='Document Management';return true;"><font color="#000000" size="2" class="sideBodyFontAndBgColor">Document 
            Management</font></a></td>
        </tr>
        <!-- Project Collaboration -->
        <tr> 
          <td height="28" width="20%" align="CENTER"><img src="<%= request.getServletPath().equals("/projectCollaboration.jsp") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" width="15" height="17"></td>
          <td height="28" width="80%"><a href="projectCollaboration.jsp" onMouseOver="window.status='Project & Collaboration';return true;"><font color="#000000" size="2" class="sideBodyFontAndBgColor">Project 
            & Collaboration</font></a></td>
        </tr>
        <tr> 
          <td height="21" width="20%" valign="TOP" align="CENTER"><img src="<%= request.getServletPath().equals("/profile.jsp") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" width="15" height="17"></td>
          <td height="28" width="80%"> <font color="#000000" size="2" class="sideBodyFontAndBgColor">Statistics 
            </font><br>
            <a href="javascript:void(window.open('usageReport.jsp','statistics', 'height=600,width=810,menubar=no,toolbar=no,scrollbars=yes'))" onMouseOver="window.status='e-Community usage';return true;"><font color="#000000" size="2" class="sideBodyFontAndBgColor"> 
            - e-Community usage</font></a><br>
          </td>
        </tr>
        <% } %>
        <jsp:useBean id="beanUserDirectory" scope="request" class="common.Directory" />
        <jsp:useBean id="beanUserACL" scope="request" class="ecomm.bean.ACL" />
        <%
    Hashtable userDirectoryACL, groupDirectoryACL;
    moduleName = "Users";

    beanUserDirectory.initTVO(request,application);
    beanUserACL.initTVO(request);

    userDirectoryACL = beanUserACL.getRights(userID, moduleName, "User");
    groupDirectoryACL = beanUserACL.getRights(userID, moduleName, "Group");



    if ( (userDirectoryACL.containsKey("view") && userDirectoryACL.get("view").equals("1") ) ||
	   (groupDirectoryACL.containsKey("view") &&  groupDirectoryACL.get("view").equals("1")) )
	  {
    %>
        <tr> 
          <td height="28" width="20%" align="CENTER"><img src="<%= request.getServletPath().equals("/directoryGroups.jsp") || request.getServletPath().equals("/directory.jsp") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" width="15" height="17"></td>
          <td height="28" width="80%"><a href="file:///C|/oc4j/j2ee/home/applications/kuktem/kuktem/sites/default/spots/right/directory.jsp?action=view" onMouseOver="window.status='<%= CommonFunction.escapeQuote(messages.getString("user.and.group")) %>';return true;"><font color="#000000" size="2" class="sideBodyFontAndBgColor"> 
            <%= messages.getString("user.and.group") %></font></a></td>
        </tr>
        <%
      }
      %>
        <jsp:useBean id="beanSystemSetup" scope="request" class="ecomm.bean.SystemSetupSystemSetup" />
        <jsp:useBean id="beanSystemSetupACL" scope="request" class="ecomm.bean.ACL" />
        <%
      Hashtable userSystemSetupACL, groupSystemSetupACL;
      moduleName = "SystemSetup";

      beanSystemSetup.initTVO(request,application);
      beanSystemSetupACL.initTVO(request);

      userSystemSetupACL = beanSystemSetupACL.getRights(userID, moduleName, "User");
      groupSystemSetupACL = beanSystemSetupACL.getRights(userID, moduleName, "Group");

      if ( (userSystemSetupACL.containsKey("view") && userSystemSetupACL.get("view").equals("1") ) ||
       (groupSystemSetupACL.containsKey("view") &&  groupSystemSetupACL.get("view").equals("1")) )
       {
      %>
        <tr> 
          <td height="28" width="20%" align="CENTER"><img src="<%= request.getServletPath().equals("/systemSetup.jsp") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" width="15" height="17"></td>
          <td height="28" width="80%"><a href="file:///C|/oc4j/j2ee/home/applications/kuktem/kuktem/sites/default/spots/right/systemSetup.jsp?action=view" onMouseOver="window.status='<%= messages.getString("system.setup") %>';return true;"><font color="#000000" size="2" class="sideBodyFontAndBgColor"> 
            <%= messages.getString("system.setup") %></font></a></td>
        </tr>
        <%
         }
        %>
      </table>
    </TD>
    <TD VALIGN="MIDDLE" CLASS="sideTitleBgBorderColor" BGCOLOR="#1059A5" ALIGN="CENTER">&nbsp;</TD>
  </TR>
</TABLE>

<p>&nbsp;</p>
<DIV id="rightMenu2"> </DIV>
      <!-- Menu Box END -->

<SCRIPT>
  loadBox("rightMenu2");
</SCRIPT>

</cache:cache>

