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
<jsp:useBean class="cms.staff.StaffValidator" id="cmsStaffValidator" scope="page"/>

<%

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
<%

    	} else {
%>

<BODY LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" BGCOLOR="#FFFFFF" onLoad="loadBoxes();">
<%@ include file="/template/default/topMenuBar.jsp" %>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><%@ include file="/template/default/leftBox.jsp" %>
    



    <%@ include file="/spots/left/RefNotepad.jsp" %>
    <%@ include file="/spots/left/RefStatus.jsp" %></td>
  </tr>
  
</table>
    </td>
    <td width="3%" align=left></td>
    <td width="84%" align=left>
	<%@ include file="/includes/personalOutputMiddle.jsp" %>
     
      <% if (userType.equals("STAFF")) { %>
      
     <H1>&nbsp;&nbsp;&nbsp;Integrated Management System (IMS)</H1>
    <div align=left>
      <p><a href="cmsformlink.jsp?form=IMS_ADMINHR_LOGON" target="_blank"><img src="images/quicklinks/admin_HRM.png" alt="IMS HRM" width="196" height="67" border="0"></a> <a href="cmsformlink.jsp?form=IMS_FINANCE_LOGON" target="_blank"><img src="images/quicklinks/financial.png" alt="IMS Finance" width="196" height="67" border="0"></a>&nbsp;<a href="cmsformlink.jsp?form=IMS_ACADSYS_LOGON" target="_blank"><img src="images/quicklinks/academic.png" alt="IMS Academic" width="196" height="67" border="0"></a> <a href="cmsformlink.jsp?form=IMS_STUDENT_LOGON" target="_blank"><img src="images/quicklinks/student.png" alt="IMS Student" width="196" height="67" border="0"></a> <a href="cmsformlink.jsp?form=IMS_ADMINHR_LOGON" target="_blank"><img src="images/quicklinks/ict.png" alt="IMS ICT" width="196" height="67" border="0"></a> <a href="cmsformlink.jsp?form=IMS_EIS_LOGON" target="_blank"><img src="images/quicklinks/eis.png" alt="IMS EIS" width="196" height="67" border="0"></a> <a href="cmsformlink.jsp?form=IMS_ADMINHR_LOGON" target="_blank"><img src="images/quicklinks/clinic.png" alt="IMS Clinic" width="196" height="67" border="0"></a> <a href="cmsformlink.jsp?form=IMS_ADMINHR_LOGON" target="_blank"><img src="images/quicklinks/security.png" alt="IMS Security" width="196" height="67" border="0"></a>
        </p>
    </div>

    
    <H1>&nbsp;&nbsp;&nbsp;Electronic Government</H1>
    <p><a href="https://hrmis.eghrmis.gov.my/" target="_blank"><img src="images/quicklinks/hrmis.png" width="196" height="67" border="0"> </a><a href="https://sppii.icu.gov.my/" target="_blank"><img src="images/quicklinks/icujpm.png" width="196" height="67" border="0"></a></p>
        
		<%}%>
    
      <H1>&nbsp;&nbsp;&nbsp;Prayer Time</H1>
     <p><table width="100%" border="0" cellspacing="0" cellpadding="0">
    <td width="68%"><iframe align=left frameborder=0 height=100% width=100%  scrolling=no src=http://www.ump.edu.my/solat/solat.cgi?lokasi=3.833333333,103.3166667,Kuantan&action=kira&lang=ENG&fontface=Arial&fontsize=1&fontcolor=000000&bgcolor=F0FBFF&orientation=0> </iframe></td>
  </tr>
</table></p></td>
  </tr>
  <tr>
    <td colspan="3" align=center valign="top">&nbsp;</td>


</table>
<%@ include file="/template/default/footerMenuBar.jsp" %>
<%
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

%>
</BODY>
</HTML>
