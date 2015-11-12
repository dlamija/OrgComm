<%@ page import="java.net.URLEncoder" %>

<!-- TOP Menu Bar START --->
<SCRIPT LANGUAGE="JavaScript">
function doLogout()  {
  return true;
}
</SCRIPT>



<LINK title=Red href="<%=request.getContextPath()%>/css/styleazlee/red.css" type=text/css rel=stylesheet>
<!--<LINK href="css/styleazlee/red.css" type=text/css rel=stylesheet>-->
<style type="text/css">
<!--
.style1 {color: #FFFFFF}
.style2 {
	font-family: Arial;
	font-size: 10px;
}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>



<%
  String titleMenuFont = "titleMenuFont";
  if (language.equals("zh") || language.equals("ja"))
    titleMenuFont = "titleMenuGlyphFont";
		


  if ( TvoContextManager.getSessionAttribute(request, "Forms.CSVHeader") != null)
   TvoContextManager.removeSessionAttribute(request, "Forms.CSVHeader");    
   
  if ( TvoContextManager.getSessionAttribute(request, "Forms.CSVData") != null)
   TvoContextManager.removeSessionAttribute(request, "Forms.CSVData");    
   
 // if (session.getMaxInactiveInterval() < 86400)  {
  //  if (showIcon) {
%>
<!--  <a href="timeOut.jsp?action=disable" onMouseOver="window.status='Disable Idle Time Out';return true;"><IMG SRC="images/system/ic_disabletimeout.gif" BORDER="0" ALIGN="RIGHT"></a>-->
<%  //} 
 // }
  //else {
   // if (showIcon) {
%>
<!--  <a href="timeOut.jsp?action=enable" onMouseOver="window.status='Enable Idle Time Out';return true;"><IMG SRC="images/system/ic_enabletimeout.gif" BORDER="0" ALIGN="RIGHT"></a>-->
<% // }
 // }
%>
  
<%@ page import="java.util.Hashtable,java.util.Locale" %>
<%@ page import = "ecomm.bean.*" %>
  
<jsp:useBean id="menuEmailACL" scope="request" class="ecomm.bean.ACL" />

  
<jsp:useBean id="menuCalendarACL" scope="request" class="ecomm.bean.ACL" />

  
<jsp:useBean id="menuForumsACL" scope="request" class="ecomm.bean.ACL" />

  
<jsp:useBean id="menuAddrBookACL" scope="request" class="ecomm.bean.ACL" />

  
<jsp:useBean id="topMenustaffStudent" scope="request" class="common.StaffStudent"/>

  
  
<%
  //Check for permission to view Email
  boolean emailsAccess = false;
  Hashtable menuUserEmailACL, menuGroupEmailACL;
  userID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
  String userType = topMenustaffStudent.getUserType(request,response, userID);
  String topStaffExecutive = null;
  if (userType.equals("STAFF"))  {
    String staffID = topMenustaffStudent.getStaffID(request,response,userID);
    topStaffExecutive = topMenustaffStudent.getStaffExecutive(request,response,staffID);
  }
  else if (userType.equals("STUDENT"))  {
      topStaffExecutive = "A";
  }


  //moduleName = "Email";
 // menuEmailACL.initTVO(request);
 // menuUserEmailACL = menuEmailACL.getRights(userID, moduleName, "User");
 // menuGroupEmailACL = menuEmailACL.getRights(userID, moduleName, "Group");
 // if ( (menuUserEmailACL.containsKey("view") && menuUserEmailACL.get("view").equals("1") ) ||
  //     (menuGroupEmailACL.containsKey("view") &&  menuGroupEmailACL.get("view").equals("1")) )
  //  emailsAccess = true;



  //Check for permission to view Memo
  boolean memosAccess = false;
  Hashtable menuUserMemoACL=null, menuGroupMemoACL=null;
  menuEmailACL.initTVO(request);
  menuUserMemoACL = menuEmailACL.getRights(userID, "Memo", "User");
  menuGroupMemoACL = menuEmailACL.getRights(userID, "Memo", "Group");
  if ( (menuUserMemoACL.containsKey("view") && menuUserMemoACL.get("view").equals("1") ) ||
     (menuGroupMemoACL.containsKey("view") &&  menuGroupMemoACL.get("view").equals("1")) )
    memosAccess = true;


  //Check for permission to view Calender
  boolean calendars = false;
  Hashtable menuUserCalendarACL, menuGroupCalendarACL;
  moduleName = "Calendar";
  menuCalendarACL.initTVO(request);
  menuUserCalendarACL = menuCalendarACL.getRights(userID, moduleName, "User");
  menuGroupCalendarACL = menuCalendarACL.getRights(userID, moduleName, "Group");
  if ( (menuUserCalendarACL.containsKey("view") && menuUserCalendarACL.get("view").equals("1") ) ||
     (menuGroupCalendarACL.containsKey("view") &&  menuGroupCalendarACL.get("view").equals("1")) )
    calendars = true;

  //Check for permission to view Address Book
  boolean addrBooks = false;
  Hashtable menuUserAddrBookACL, menuGroupAddrBookACL;
  moduleName = "AddrBook";
  menuAddrBookACL.initTVO(request);
  menuUserAddrBookACL = menuAddrBookACL.getRights(userID, moduleName, "User");
  menuGroupAddrBookACL = menuAddrBookACL.getRights(userID, moduleName, "Group");
  if ( (menuUserAddrBookACL.containsKey("view") && menuUserAddrBookACL.get("view").equals("1") ) ||
      (menuGroupAddrBookACL.containsKey("view") &&  menuGroupAddrBookACL.get("view").equals("1")) )
    addrBooks = true;

  //Check for permission to view Forum
  boolean forums = false;
  Hashtable menuUserForumsACL, menuGroupForumsACL;
  moduleName = "Forums";
  menuForumsACL.initTVO(request);
  menuUserForumsACL = menuForumsACL.getRights(userID, moduleName, "User");
  menuGroupForumsACL = menuForumsACL.getRights(userID, moduleName, "Group");
  if ( (menuUserForumsACL.containsKey("view") && menuUserForumsACL.get("view").equals("1") ) ||
     (menuGroupForumsACL.containsKey("view") &&  menuGroupForumsACL.get("view").equals("1")) )
    forums = true;
		
  boolean personalize = false;
  menuUserEmailACL = menuEmailACL.getRights(userID, "Personal", "User");
  menuGroupEmailACL = menuEmailACL.getRights(userID, "Personal", "Group");
  if ( (menuUserEmailACL.containsKey("view") && menuUserEmailACL.get("view").equals("1") ) ||
       (menuGroupEmailACL.containsKey("view") &&  menuGroupEmailACL.get("view").equals("1")) )
    personalize = true;
%>


<table  background="images/menubaru/headerbg_carbon.png" repeat-y top left; width=100% border="0" cellspacing="0" cellpadding="0">
  <tr >
    <td><a href="<%=request.getContextPath()%>/home.jsp"><img src="images/menubaru/default_logo.png" width="107" height="82" /></a></td>
    <td width="88%"><table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="3">
          <tr>
            <td height="31" align=left>&nbsp;&nbsp;&nbsp;&nbsp;<strong><font color=yellow><%= firstName %> <%= lastName %> <!--%= CommonFunction.getDate("hh:mm:ss a zzz") %--></font></strong></td>
          </tr>
        </table></td>
        </tr>
      <tr>
        <td><!--div align="left"-->
          <!-- START: WRAPPER -->
          <div id="inner">
            <!-- START: INNER -->
            <div id="container">
              <!-- start: container -->
              <!-- START: TOP AREA -->
              <!-- END: TOP AREA -->
              <!-- START: SUCKERFISH -->
              <div id="navdiv">
                <div id="nav">
                  <script type="text/javascript">
<!--//--><![CDATA[//><!--

sfHover = function() {
	var sfEls = document.getElementById("nav").getElementsByTagName("LI");
	for (var i=0; i<sfEls.length; i++) {
		sfEls[i].onmouseover=function() {
			this.className+=" sfhover";
		}
		sfEls[i].onmouseout=function() {
			this.className=this.className.replace(new RegExp(" sfhover\\b"), "");
		}
	}
}
if (window.attachEvent) window.attachEvent("onload", sfHover);

//--><!]]>
      </script>
                  <ul>
                    <li class="active"><a href="home.jsp"><b><FONT COLOR=RED>HOME</FONT></b></a></li>
					
                   <!-- <li><a class="daddy" href=""><b>ADMINISTRATOR</b></a>
   						<ul>
	  						<li><a href="http://" title="">System Setup</a></li>
	 						 <li><a href="ecommUsage.jsp?action=view" title="">Statistic</a></li>
     					</ul>
					</li>

                    
                    <li><a href="javascript:MM_openBrWindow('template/default/contact.htm', 'ContactUs', 'resizable=yes,toolbar=no,scrollbars=yes,width=400,height=200')"><b>CONTACT US</b></a></li>-->
                    <!-- <LI><A href="servlet/Logout" onClick="return doLogout()">LOGOUT</A></LI> -->
                    <li><a href="Logout" onclick="return doLogout()"><b>LOGOUT</b></a></li>
                    </ul>
                  </div>
                </div>
              <!-- END: SUCKERFISH -->
              <!-- START: MAIN CONTENT -->
              <!-- END: INNER -->
              </div>
            <!-- END: WRAPPER -->
            <!-- </div> end: wrapbg -->
            <!--/div-->
            <!-- 1227001569 -->
          </div></td>
        </tr>
    </table></td>
  </tr>
</table>
<!-------------------------END-------------------------------------------------------->

<!-- TOP Menu Bar END --->
<% // Module Manager - Personal
if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_PERSONAL) ) { 
  String url_en = (request.getQueryString() != null) ? URLEncoder.encode(request.getQueryString()) : "";
%>
  <jsp:include page="/personalOutput.jsp" flush="true">
    <jsp:param name="outputLocation" value="top" />
    <jsp:param name="url_en" value="<%=url_en%>" />
  </jsp:include>
<% } //Module Manager - Personal %>

