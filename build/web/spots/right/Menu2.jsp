<%@ page import="common.*" %>
<%@ page import="java.util.Hashtable,java.util.Locale, java.util.Vector" %>
<%@ page import = "ecomm.bean.*" %>
<%@ taglib uri="oscache" prefix="cache" %>

<cache:cache scope="session" time="1800">

<%  
    Messages messages = Messages.getMessages(request);
    String language = (String)TvoContextManager.getAttribute(request, "System.language");
    String menuFont = "menuFont";
    if (language.equals("zh") || language.equals("ja"))
      menuFont = "menuGlyphFont";
%>
<%
    String userID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
    String staffID = (String) TvoContextManager.getSessionAttribute(request,"Login.CMSID");
%>

<script language="JavaScript" src="menu.js"></script>

<!-- Menu Box START --><style type="text/css">
<!--
body {
	margin-top: 0px;
	margin-bottom: 0px;
}
-->
</style>




<!--div align="left" class="switchcontent" id="sc1" -->
<table width="100%" border="0" cellspacing="0" class="sideTitleBgBorderColor">
    <tr>
      <td><table width="100%" border="0" cellspacing="0" cellpadding="0" CLASS="menuBgColor">
        <!--  <tr> 
            <td colspan="2" align="CENTER" bgcolor="#1059A5" class="menuBgColorHighlight"><img src="/images/system/blank.gif" width="5" height="1"></td>
          </tr>-->
          <tr>
		   
            <td CLASS="sideTitleBgBorderColor" BGCOLOR="#1059A5" height="28" colspan="2" align="CENTER"> 
			<FONT COLOR="#FFFFFF" CLASS="sideTitleFont"><strong>Collaboration &amp; Communication</strong></FONT></td>
          </tr>
          <tr> 
            <td height="28" align="CENTER"><img src="<%= request.getServletPath().equals("file:///memo.jsp") ? "images/hyperlink/memoico.png" : "images/hyperlink/memoico.png" %>" ><a href="" onclick="toggleBlock('rightstatus'); return false" onmouseover="window.status='<%= messages.getString("status") %>';return true;"></a></td>
            <td height="28"><A HREF="memo.jsp?action=folders&type=Y&folderID=1" onMouseOver="window.status='<%= messages.getString("memo") %>';return true;"><font color="#000000" size="2" CLASS="<%= menuFont %>"> 
              <%= messages.getString("memo") %></font></a></td>
          </tr>
		  
		  <tr>
           	 <TD colspan="2" ALIGN="CENTER" BGCOLOR="#000000" CLASS="menuBgColorShadow"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
          </tr>
			
			  <tr> 
            <td height="28" align="CENTER"><img src="<%= request.getServletPath().equals("file:///memo.jsp") ? "images/hyperlink/emel.png" : "images/hyperlink/emel.png" %>" ></td>
            <td height="28"><A HREF="http://webmail.ump.edu.my" target="_blank" onMouseOver="window.status='E-Mail';return true;"><font color="#000000" size="2" CLASS="<%= menuFont %>"> 
              E-mail</font></a></td>
          </tr>
		  
		  <tr>
           	 <TD colspan="2" ALIGN="CENTER" BGCOLOR="#000000" CLASS="menuBgColorShadow"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
          </tr>
					  
		      <tr> 
            <td height="28" align="CENTER"><img src="<%= request.getServletPath().equals("file:///annoucement.jsp") ? "images/hyperlink/announcement.png" : "images/hyperlink/announcement.png" %>" ></td>
            <td height="28"><A HREF="announcement.jsp" onMouseOver="window.status='announcement';return true;"><font color="#000000" size="2" CLASS="<%= menuFont %>"> 
              Announcement</font></a></td>
          </tr>
		  
		  <tr>
           	 <TD colspan="2" ALIGN="CENTER" BGCOLOR="#000000" CLASS="menuBgColorShadow"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
          </tr>
					  
		      <tr> 
            <td height="28" align="CENTER"><img src="<%= request.getServletPath().equals("file:///annoucement.jsp") ? "images/hyperlink/announcement.png" : "images/hyperlink/announcement.png" %>" >
			
				</td>
            <td height="28"><A HREF="javascript:void(window.open('cmsformlink.jsp?form=forum','ME'))" onMouseOver="window.status='Forum';return true;"><font color="#000000" size="2" CLASS="<%= menuFont %>"> 
              Forum @ UMP</font></a></td>
          </tr>
		  
		  <%--<tr> 
            <td height="28" align="CENTER"><img src="<%= request.getServletPath().equals("file:///forum.jsp") ? "images/hyperlink/announcement.png" : "images/hyperlink/announcement.png" %>" >
			
				</td>
            <td height="28"><A HREF="cmsformlink.jsp?form=forum"><font color="#000000" size="2" CLASS="<%= menuFont %>"> 
              Forum @ UMP </font></a></td>
          </tr>--%>
		   <tr>
           	 <TD colspan="2" ALIGN="CENTER" BGCOLOR="#000000" CLASS="menuBgColorShadow"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
          </tr>
		  
		   <tr> 
            <td height="28" align="CENTER"><img src="<%= request.getServletPath().equals("file:///news.jsp") ? "images/hyperlink/news.png" : "images/hyperlink/news.png" %>" ></td>
            <td height="28"><A HREF="news.jsp?action=view" onMouseOver="window.status='announcement';return true;"><font color="#000000" size="2" CLASS="<%= menuFont %>"> 
              Latest News</font></a></td>
          </tr>
		  
		   <tr>
           	 <TD colspan="2" ALIGN="CENTER" BGCOLOR="#000000" CLASS="menuBgColorShadow"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
          </tr>
          
            <tr> 
            <td height="28" align="CENTER"><img src="<%= request.getServletPath().equals("file:///latestNews.jsp") ? "images/hyperlink/news.png" : "images/hyperlink/news.png" %>" ></td>
            <td height="28"><A HREF="latestNews.jsp" onMouseOver="window.status='Latest News';return true;"><font color="#000000" size="2" CLASS="<%= menuFont %>"> 
              Latest News Version 2</font></a></td>
          </tr>
		  
		   <tr>
           	 <TD colspan="2" ALIGN="CENTER" BGCOLOR="#000000" CLASS="menuBgColorShadow"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
          </tr>

		  
		      <tr> 
            <td height="28" align="CENTER"><img src="<%= request.getServletPath().equals("file:///staffDirectory.jsp") ? "images/hyperlink/directory.png" : "images/hyperlink/directory.png" %>" ></td>
            <td height="28"><A HREF="staffDirectory.jsp" onMouseOver="window.status='Staff_Directory';return true;"><font color="#000000" size="2" CLASS="<%= menuFont %>"> 
              Staff Directory</font></a></td>
          </tr>
		    <tr>
           	 <TD colspan="2" ALIGN="CENTER" BGCOLOR="#000000" CLASS="menuBgColorShadow"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
          </tr>
		  
		   <tr> 
            <td height="28" align="CENTER"><img src="images/hyperlink/e-greeting.png"></td>
            <td height="28"><A HREF="egreeting.jsp" onMouseOver="window.status='Staff_Directory';return true;"><font color="#000000" size="2" CLASS="<%= menuFont %>"> 
             E-Greeting Card</font></a></td>
          </tr>
		  <tr>
           	 <TD colspan="2" ALIGN="CENTER" BGCOLOR="#000000" CLASS="menuBgColorShadow"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
          </tr>
		  
		    <tr> 
              <td height="28" width="20%" align="CENTER"><img src="<%= request.getServletPath().equals("file:///hotlinks.jsp") ? "images/hyperlink/bookmark.png" : "images/hyperlink/bookmark.png" %>"></td>
              <td height="28" width="80%"><a href="hotlinks.jsp?action=view" onMouseOver="window.status='<%= messages.getString("bookmarks") %>';return true;"><font color="#000000" size="2" class="menuFont">Bookmarks</font></a></td>
            </tr>
			
			
<% if (session.getAttribute("userType").equals("STAFF") || session.getAttribute("userType").equals("STUDENT")) { %>
          <tr>
           	 <TD colspan="2" ALIGN="CENTER" BGCOLOR="#000000" CLASS="menuBgColorShadow"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
          </tr>
          <tr> 
            <td height="28" align="CENTER"><img src="images/hyperlink/filebanks.png"></td>
            <td height="28"><a href="library.jsp?action=view" onMouseOver="window.status='Files Bank';return true;"><font color="#000000" size="2"CLASS="<%= menuFont %>"> 
              Files Bank</font></a></td>
          </tr>
<% } %>  
          <tr>
           	 <TD colspan="2" ALIGN="CENTER" BGCOLOR="#000000" CLASS="menuBgColorShadow"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
          </tr>
          <tr> 
            <td height="28" align="CENTER"><img src="images/hyperlink/usage.png"></td>
            <td height="28"><a href="ecommUsage.jsp?action=view" onMouseOver="window.status='eCommunity Usage';return true;">
				<font color="#000000" size="2"CLASS="<%= menuFont %>">eCommunity Usage</font></a></td>
          </tr>

              <tr>
           	 <TD colspan="2" ALIGN="CENTER" BGCOLOR="#000000" CLASS="menuBgColorShadow"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
            </tr>
            
			<!---
			<tr> 
              <td height="28" width="8%" align="CENTER"><img src="<%= request.getServletPath().equals("file:///news.jsp") ? "images/hyperlink/news.png" : "images/hyperlink/news.png" %>" ></td>
              <td height="28" width="92%"><a href="news.jsp?action=view" onMouseOver="window.status='<%= messages.getString("latest.news") %>';return true;"><font color="#000000" size="2" CLASS="<%= menuFont %>"> 
                <%= messages.getString("latest.news") %></font></a></td>
            </tr>
             <tr>
           	 <TD colspan="2" ALIGN="CENTER" BGCOLOR="#000000" CLASS="menuBgColorShadow"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
            </tr>
			
			
            <tr> 
              <td height="28" align="CENTER"><img src="<%= request.getServletPath().equals("file:///addrBook.jsp") ? "template/default/image/ico_bullet02.gif" : "template/default/image/ico_bullet02.gif" %>" ></td>
              <td height="28" width="92%"><A HREF="addrBook.jsp?action=view" onMouseOver="window.status='<%= CommonFunction.escapeQuote(messages.getString("address.book")) %>';return true;"><font color="#000000" size="2" CLASS="<%= menuFont %>"> 
                <%= messages.getString("address.book") %></font></a></td>
            </tr>
             <tr>
           	 <TD colspan="2" ALIGN="CENTER" BGCOLOR="#000000" CLASS="menuBgColorShadow"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
            </tr>
			-->
		<!--	
            <tr> 
              <td height="28" align="CENTER"><img src="<%= request.getServletPath().equals("file:///forums.jsp") ? "images/hyperlink/forum.png" : "images/hyperlink/forum.png" %>" ></td>
              <td height="28" width="92%"><A HREF="forums.jsp?action=view" onMouseOver="window.status='<%= messages.getString("forums") %>';return true;"><font color="#000000" size="2" CLASS="<%= menuFont %>"> 
                <%= messages.getString("forums") %></font></a></td>
            </tr>
             <tr>
           	 <TD colspan="2" ALIGN="CENTER" BGCOLOR="#000000" CLASS="menuBgColorShadow"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
            </tr>-->
            <tr> 
              <td height="28" align="CENTER"><img src="<%= request.getServletPath().equals("file:///library.jsp") ? "images/hyperlink/event.png" : "images/hyperlink/event.png" %>" ></td>
              <td height="28"> 
			  
			 <SCRIPT LANGUAGE="JavaScript">
			var monthObj = new Date();
			var month = monthObj.getMonth();
			var year = monthObj.getFullYear();
			var date = monthObj.getDate();
			document.write("<A HREF=\"event.jsp?action=view&date="+date+"&month="+month+"&year="+year+"\" onMouseOver=\"window.status=\'Event\';return true;\">");
			</SCRIPT> <font color="#000000" size="2" CLASS="<%= menuFont %>"> 
                Event</font></td>
            </tr>
             <tr>
           	 <TD colspan="2" ALIGN="CENTER" BGCOLOR="#000000" CLASS="menuBgColorShadow"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
            </tr>
            <tr> 
              <td height="28" align="CENTER"><img src="<%= request.getServletPath().equals("file:///event.jsp") ? "images/hyperlink/calendar.png" : "images/hyperlink/calendar.png" %>" ></td>
              <td height="28"> 
			<SCRIPT LANGUAGE="JavaScript">
			var monthObj = new Date();
			var month = monthObj.getMonth();
			var year = monthObj.getFullYear();
			var date = monthObj.getDate();
			document.write("<A HREF=\"calendar.jsp?action=view&date="+date+"&month="+month+"&year="+year+"\" onMouseOver=\"window.status=\'<%= messages.getString("calendar") %>\';return true;\">");
			</SCRIPT> <font color="#000000" size="2" CLASS="<%= menuFont %>"> 
                <%= messages.getString("calendar") %></font></td>
            </tr>
     <!--        <tr>
           	 <TD colspan="2" ALIGN="CENTER" BGCOLOR="#000000" CLASS="menuBgColorShadow"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
            </tr>-->
			
			<!--
            <tr> 
              <td height="28" width="8%" align="CENTER"><img src="<%= request.getServletPath().equals("file:///hotlinks.jsp") ? "template/default/image/ico_bullet02.gif" : "template/default/image/ico_bullet02.gif" %>" ></td>
              <td height="28" width="92%"><a href="hotlinks.jsp?action=view" onMouseOver="window.status='<%= messages.getString("bookmarks") %>';return true;"><font color="#000000" size="2" CLASS="<%= menuFont %>"> <%= messages.getString("bookmarks") %></font></a></td>
            </tr>
			-->
<%  
    String action = "view";
    int display = 0;
%>
            <!--tr> 
              <td height="28" width="20%" align="CENTER"><img src="<%= request.getServletPath().equals("file:///resourceCMS.jsp") ? "template/default/image/ico_bullet02.gif" : "template/default/image/ico_bullet02.gif" %>" ></td>
              <td height="28" width="80%"><a href="resourceCMS.jsp?action=view" onMouseOver="window.status='Resource Booking';return true;"><font color="#000000" size="2" class="sideBodyFontAndBgColor"> 
                Resource Booking </font></a></td>
            </tr --> 
<%
    // Module Manager - TAMS
    if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_TAMS) )   {
%>
            <!-- TAMS -->
         <!--  <tr>
           	 <TD colspan="2" ALIGN="CENTER" BGCOLOR="#000000" CLASS="menuBgColorShadow"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
            </tr>
            <tr> 
              <td height="28" width="8%" align="CENTER"><img src="<%= request.getServletPath().equals("file:///tams.jsp") ? "template/default/image/ico_bullet02.gif" : "template/default/image/ico_bullet02.gif" %>" ></td>
              <td height="28" width="92%"><a href="tams.jsp?action=viewCurrent" onMouseOver="window.status='<%= messages.getString("task.manager") %>';return true;"><font color="#000000" size="2" CLASS="<%= menuFont %>"> 
                <%= messages.getString("task.manager") %></font></a></td>
            </tr>-->
<%   
      // Module Manager - TAMS
    }    
%>
<% if (session.getAttribute("userType").equals("STAFF")) { %>
           <!--  <tr>
           	 <TD colspan="2" ALIGN="CENTER" BGCOLOR="#000000" CLASS="menuBgColorShadow"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
            </tr>
            
			
			<tr> 
              <td height="21" width="8%" valign="TOP" align="CENTER"><img src="<%= request.getServletPath().equals("file:///profile.jsp") ? "template/default/image/ico_bullet02.gif" : "template/default/image/ico_bullet02.gif" %>" ></td>
              <td height="28" width="92%"> <font color="#000000" size="2" CLASS="<%= menuFont %>">Statistics 
                </font><br> 
                <!--a href="javascript:void(window.open('usageReport.jsp','statistics', 'height=600,width=810,menubar=no,toolbar=no,scrollbars=yes'))" onMouseOver="window.status='e-Community usage';return true;"><font color="#000000" size="2" class="sideBodyFontAndBgColor"> 
                - e-Community usage</font></a><br --> 
				<!--<a href="javascript:void(window.open('doorAccessMain.jsp','statistics', 'height=600,width=810,menubar=no,toolbar=no,scrollbars=yes'))" onMouseOver="window.status='Smart Card Door Access';return true;"><font color="#000000" size="2" CLASS="<%= menuFont %>"> 
                - Smart Card Door Access</font></a><br>
			 	<a href="javascript:void(window.open('camera.jsp','statistics', 'height=300,width=300,menubar=no,toolbar=no,scrollbars=yes'))" onMouseOver="window.status='IP Camera Access';return true;"><font color="#000000" size="2" CLASS="<%= menuFont %>"> 
              - IP Camera Access</font></a><br>			 </td>
            </tr>-->
            <% } %>
             <tr>
           	 <TD colspan="2" ALIGN="CENTER" BGCOLOR="#000000" CLASS="menuBgColorShadow"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
            </tr>
			
            <tr> 
              <td height="28" width="8%" align="CENTER"><img src="<%= request.getServletPath().equals("file:///directoryGroups.jsp") || request.getServletPath().equals("/directory.jsp") ? "images/hyperlink/usergroup.png" : "images/hyperlink/usergroup.png" %>" ></td>
              <td height="28" width="92%"><a href="directory.jsp?action=view" onMouseOver="window.status='<%= CommonFunction.escapeQuote(messages.getString("user.and.group")) %>';return true;"><font color="#000000" size="2" CLASS="<%= menuFont %>"> 
                <%= messages.getString("user.and.group") %></font></a></td>
            </tr>
<jsp:useBean id="beanSystemSetup" scope="request" class="ecomm.bean.SystemSetupSystemSetup" />
<jsp:useBean id="beanSystemSetupACL" scope="request" class="ecomm.bean.ACL" />
<%
      Hashtable userSystemSetupACL, groupSystemSetupACL;
      String moduleName = "SystemSetup";

      beanSystemSetup.initTVO(request,application);
      beanSystemSetupACL.initTVO(request);

      userSystemSetupACL = beanSystemSetupACL.getRights(userID, moduleName, "User");
      groupSystemSetupACL = beanSystemSetupACL.getRights(userID, moduleName, "Group");

      if ( (userSystemSetupACL.containsKey("view") && userSystemSetupACL.get("view").equals("1") ) ||
       (groupSystemSetupACL.containsKey("view") &&  groupSystemSetupACL.get("view").equals("1")) )
       {
      %>
             <tr>
           	 <TD colspan="2" ALIGN="CENTER" BGCOLOR="#000000" CLASS="menuBgColorShadow"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
            </tr>
            <tr> 
              <td height="28" width="8%" align="CENTER"><img src="<%= request.getServletPath().equals("file:///systemSetup.jsp") ? "images/hyperlink/setup.png" : "images/hyperlink/setup.png" %>" ></td>
              <td height="28" width="92%"><a href="systemSetup.jsp?action=view" onMouseOver="window.status='<%= messages.getString("system.setup") %>';return true;"><font color="#000000" size="2" CLASS="<%= menuFont %>"> 
                <%= messages.getString("system.setup") %></font></a></td>
            </tr>
         <% } %>
        </table></td>
  </tr>
</table> 
  
    
  <!-- Menu Box END -->
</div>

</cache:cache>