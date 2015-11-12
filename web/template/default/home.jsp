<jsp:useBean id="staffStudent" scope="request" class="common.StaffStudent"/>
<!-- %
	//check if user is staff or student
	String userStatus = staffStudent.getUserType(request,response, (String)TvoContextManager.getSessionAttribute(request, "Login.userID"));

    	if (userStatus.equals("STUDENT"))
	{
%>
		<SCRIPT LANGUAGE="JavaScript">
			alert("This e-Community is only available for staff & external user!");
			// location="servlet/Logout";
			location="Logout";
		</SCRIPT>
< %
		return;
	}
% -->
<%@ page import="java.util.*" %>
<%@ page buffer="1024kb" autoFlush="true" %> 
<%@ include file="//includes/loginCheck.jsp" %>

<HTML>
<HEAD>
<TITLE><%= Constants.PRODUCT_NAME %></TITLE>
<%@ include file="//includes/no-cache.jsp" %>
<%--<LINK REL="stylesheet" HREF="css/<%= (String)TvoContextManager.getSessionAttribute(request, "Login.CSSFile") %>">--%>
<SCRIPT LANGUAGE="JavaScript">
<!--

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}

<% // Module Manager - Personal
if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_PERSONAL) ) { %>
  function loadBoxes() {
    if(navigator.appName != "Microsoft Internet Explorer")
      return false;
  }
<% } else { %>
function loadBoxes () {
  if(navigator.appName != "Microsoft Internet Explorer")
    return false;

  loadBox('leftcalendarmonth');
  loadBox('leftmenubox');
  loadBox('statusbox');
  loadBox('apptbox');
  loadBox('addrbookbox');
  loadBox('newsbox');
  loadBox('memobox');
  loadBox('todobox');
  loadBox('forumbox');
}
<% }//Module Manager - Personal %>

function getCookieVal (offset) {  
  var endstr = document.cookie.indexOf (";", offset);  
  if (endstr == -1)    
    endstr = document.cookie.length;  
  return unescape(document.cookie.substring(offset, endstr));
}

function GetCookie (name) {
  var uid = "<%= TvoContextManager.getSessionAttribute(request, "Login.userID") %>";
  name = uid + name;
  var arg = name + "=";
  var alen = arg.length;  
  var clen = document.cookie.length;  
  var i = 0;  
  while (i < clen) {    
    var j = i + alen;    
    if (document.cookie.substring(i, j) == arg)      
      return getCookieVal (j);    
    i = document.cookie.indexOf(" ", i) + 1;    
    if (i == 0) break;   
  }  
  return null;
}

function toggleBlock(b) {
  if(navigator.appName != "Microsoft Internet Explorer")
    return false;
    
  if(document.all[b].style.display == "block" || document.all[b].style.display == "")
    hideBlock(b);
  else
    showBlock(b);

  saveBox(b);
}

function hideBlock(b) {
  document.all[b].style.display = "none";
}

function showBlock(b) {
  document.all[b].style.display = "block";
}

function saveBox(b) {
  var uid = "<%= TvoContextManager.getSessionAttribute(request, "Login.userID") %>";
  var cookieStr = "";
  var expDays = 3650;
  var exp = new Date(); 
  exp.setTime(exp.getTime() + (expDays*24*60*60*1000));
  
  cookieStr = uid + b + "=" + document.all[b].style.display + "; expires=" + exp.toGMTString();
  document.cookie = cookieStr;
}

function loadBox(b) {
  if (GetCookie(b) == "block" || GetCookie(b) == "" || GetCookie(b) == null)
    showBlock(b);
  else
    hideBlock(b);
}
//-->
</SCRIPT>
<% 
String moduleName = "Home"; 
String userID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
  
Messages messages = Messages.getMessages(request);
boolean showIcon = false;    

String language = (String)TvoContextManager.getAttribute(request, "System.language");


if ( language.equals("en"))		
  showIcon = true;

boolean expandMiddle = false;
// Module Manager - Personal
if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_PERSONAL) )  
  expandMiddle = PersonalPersonal.isRightEmpty(request, userID);
%>
</HEAD>
<!--jsp:useBean class="cms.staff.StaffValidator" id="cmsStaffValidator" scope="page"/>

<!--%

	Connection conn=null;
	String staffid = (String)session.getAttribute("staffid");
	
	try
	{
		Context initCtx = new InitialContext();
	    Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
    	DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
    	conn = ds.getConnection();

    	cmsStaffValidator.setDBConnection(conn);
    	cmsStaffValidator.setStaffId(staffid);
    	boolean staffProfile = cmsStaffValidator.isStaffProfile();
		boolean staffSpouse = cmsStaffValidator.isSpouseProfile();
		boolean qualification = cmsStaffValidator.isQualification();


    	if(staffProfile == true || staffSpouse == true || qualification == true)

    	{
System.out.println("BERJAYA");
%>
Please be informed that your personal information not updated. Please Update your information <a href="StaffProfile.jsp">here</a>. Thank You
<!--%

    	} else {
% -->

<BODY LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" BGCOLOR="#FFFFFF" onLoad="loadBoxes();">
<%@ include file="/template/default/topMenuBar.jsp" %>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><%@ include file="/template/default/leftBox.jsp" %>
    



    <!--%@ include file="/spots/left/RefNotepad.jsp" %-->
    <!--%@ include file="/spots/left/RefStatus.jsp" %--></td>
  </tr>
  
</table>
    </td>
    <td width="3%" align=left></td>
    <td width="84%" align=left>
	<%@ include file="/includes/personalOutputMiddle.jsp" %>
     
     </td>
  </tr>
</table></p></td>
  </tr>
  <tr>
    <td colspan="3" align=center valign="top">&nbsp;</td>


</table>
<%@ include file="/template/default/footerMenuBar.jsp" %>
<!--%
		}
	}
	catch(Exception e)
	{
		System.out.println("Error Checking Staff Profile:"+e);
	}
	finally
	{
		conn.close();
	}

% -->
</BODY>
</HTML>
