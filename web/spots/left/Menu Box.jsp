<%@ page import="java.util.Hashtable,java.util.Locale, java.util.Vector" %>
<%@ include file="/includes/import.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.text.*" %>
<%@ page import="javax.sql.*" %>

<%

    Messages messages = Messages.getMessages(request);
    String language = (String)TvoContextManager.getAttribute(request, "System.language");
    String menuFont = "menuFont";
    if (language.equals("zh") || language.equals("ja"))
      menuFont = "menuGlyphFont";
%>


<HTML>
<HEAD>
<style type="text/css">

.sidebarmenu ul{
margin: 0;
padding: 0;
list-style-type: none;
font-size:11px;
font-family:Arial, Helvetica, sans-serif;
width: 200px; /* Main Menu Item widths */
/*border-bottom: 1px solid #666;
border-left: 1px solid #666;
border-right:1px solid #666;
border-top:1px solid #666;*/
}
 
.sidebarmenu ul li{
position: relative;
}

/* Top level menu links style */
.sidebarmenu ul li a{
display: block;
overflow: auto; /*force hasLayout in IE7 */
color: black;
text-decoration: none;
padding: 3px;
}

.sidebarmenu ul li a:link, .sidebarmenu ul li a:visited, .sidebarmenu ul li a:active{
background-color: #fff; /*background of tabs (default state)*/
}

.sidebarmenu ul li a:visited{
color: black;
}

.sidebarmenu ul li ul a:hover{
background-color: #A6BCFF;
}

/*Sub level menu items */
.sidebarmenu ul li ul{
position: absolute;
width: 215px; /*Sub Menu Items width */
top: 0;
visibility: hidden;
border:1px solid #666;
}

.sidebarmenu a.subfolderstyle{
background: url(images/menu/arrow_sub1.gif) no-repeat 97% 50%;
}

 
/* Holly Hack for IE \*/
* html .sidebarmenu ul li { float: left; height: 1%; }
* html .sidebarmenu ul li a { height: 1%; }
/* End */

</style>

<script type="text/javascript">

//Nested Side Bar Menu (Mar 20th, 09)
//By Dynamic Drive: http://www.dynamicdrive.com/style/

var menuids=["sidebarmenu1"] //Enter id(s) of each Side Bar Menu's main UL, separated by commas

function initsidebarmenu(){
for (var i=0; i<menuids.length; i++){
  var ultags=document.getElementById(menuids[i]).getElementsByTagName("ul")
    for (var t=0; t<ultags.length; t++){
    ultags[t].parentNode.getElementsByTagName("a")[0].className+=" subfolderstyle"
  if (ultags[t].parentNode.parentNode.id==menuids[i]) //if this is a first level submenu
   ultags[t].style.left=ultags[t].parentNode.offsetWidth+"px" //dynamically position first level submenus to be width of main menu item
  else //else if this is a sub level submenu (ul)
    ultags[t].style.left=ultags[t-1].getElementsByTagName("a")[0].offsetWidth+"px" //position menu to the right of menu item that activated it
    ultags[t].parentNode.onmouseover=function(){
    this.getElementsByTagName("ul")[0].style.display="block"
    }
    ultags[t].parentNode.onmouseout=function(){
    this.getElementsByTagName("ul")[0].style.display="none"
    }
    }
  for (var t=ultags.length-1; t>-1; t--){ //loop through all sub menus again, and use "display:none" to hide menus (to prevent possible page scrollbars
  ultags[t].style.visibility="visible"
  ultags[t].style.display="none"
  }
  }
}

if (window.addEventListener)
window.addEventListener("load", initsidebarmenu, false)
else if (window.attachEvent)
window.attachEvent("onload", initsidebarmenu)

</script>

<TITLE></TITLE>
<!--LINK REL="stylesheet" HREF="css/< %= (String)TvoContextManager.getSessionAttribute(request, "Login.CSSFile") %>">
<!--link rel="stylesheet" type="text/css" href="< %=request.getContextPath()%>/js/flexdropdown.css" />
<script type="text/javascript" src="< %=request.getContextPath()%>/js/jquery.min.js"></script>
<script type="text/javascript" src="< %=request.getContextPath()%>/js/flexdropdown.js"></script -->
<META content="text/html; charset=windows-1252" http-equiv=Content-Type>
 <jsp:useBean id="staffStudent" scope="request" class="common.StaffStudent"/>
  <%

    String userID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
    String staffID = (String) TvoContextManager.getSessionAttribute(request,"Login.CMSID");
    String deptcode = staffStudent.getDeptCode(request,response, staffID);

    session.setAttribute("staffid", staffID);
	session.setAttribute("deptcode", deptcode);

    String action = "view";
    int display = 0;

%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="25" bgcolor="#FFFFFF"> 
      <img src="images/quicklinks/mainmenu.png"></td>
  </tr>
</table>
<div class="sidebarmenu">

  <jsp:useBean id="beanExApplication" scope="request" class="ecomm.bean.ExApplicationExApplication" />
  <%

    String userType = staffStudent.getUserType(request,response, userID);
    String moduleName = "ExApplication";

    beanExApplication.initTVO(request);
    Vector vExApplication = beanExApplication.getExApplication(request,false);
    int count = (vExApplication.size());
    boolean isSuperAdmin = beanExApplication.isSuperAdmin(request);

    display = 0;

    if (isSuperAdmin || count > 0)
        display = 1;

   if (display == 1)    {

%>
<%
    }
    session.setAttribute("userType", userType);
    if (userType.equals("STAFF")) {
%>


  <jsp:useBean class="cms.staff.StaffValidator" id="cmsStaffValidator" scope="page"/>
<body bgcolor="#FFFFFF" text="#000000" link="#000000" vlink="#FFFFFF" alink="#000000">

<!-- flexmenu1 - General Management -->
<ul id="sidebarmenu1">

	<%

	Connection conn=null;
	try
	{
		Context initCtx = new InitialContext();
	    Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
    	DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
    	conn = ds.getConnection();

    	cmsStaffValidator.setDBConnection(conn);
    	cmsStaffValidator.setStaffId(staffID);
    	boolean staffHasSubordinate = cmsStaffValidator.hasSubordinate();

    	if(staffHasSubordinate == true)

    	{

%>
	<li><div align="left"><A HREF="EIS.jsp" onMouseOver="window.status='Executive Approval System';return true;"><img src="images/execMenu.gif"></A></div></li>
  <%}%>
 <li><div align="left"><a class="MenuBarItemSubmenu" href="#"><img src="images/generalMenu.gif"></a></div>
    <ul>
<jsp:useBean id="eMeetingACL" scope="request" class="cms.admin.meeting.EMeetingACL" />
  <%
	Hashtable userMeetingACLTable=null, groupMeetingACLTable=null;
	Hashtable setupUserMeetingACLTable=null,setupGroupMeetingACLTable=null;
	ACL  acl = new ACL();
	acl.initTVO(request);

	userMeetingACLTable  = acl.getRights(userID, "MeetingMain", "User");
	groupMeetingACLTable = acl.getRights(userID, "MeetingMain", "Group");
	setupUserMeetingACLTable  = acl.getRights(userID, "MeetingSetup", "User");
	setupGroupMeetingACLTable = acl.getRights(userID, "MeetingSetup", "Group");

	      if ( (userMeetingACLTable.containsKey("view") && userMeetingACLTable.get("view").equals("1") ) ||
        	   (groupMeetingACLTable.containsKey("view") &&  groupMeetingACLTable.get("view").equals("1")) ||
             (setupUserMeetingACLTable.containsKey("view") && setupUserMeetingACLTable.get("view").equals("1")) ||
             (setupGroupMeetingACLTable.containsKey("view") && setupGroupMeetingACLTable.get("view").equals("1")))
				{
%>
  <li>
    <div align="center"><a href="eMeeting.jsp" onMouseOver="window.status='eMeeting';return true;">eMeeting</A></div>
  </li>
  <div align="left">
    <% } %>
    <jsp:useBean id="mtg" class="cms.admin.meeting.bean.Meeting" scope="session" />
    <%
 	DBConnectionPool dbPool= null;
	Connection conn_mtg =null;
	try
	{
		dbPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
        conn_mtg = dbPool.getConnection();
		
		mtg.setDBConnection(conn_mtg);
		if (mtg.isSenateMember(staffID) || mtg.isSenateAttendee(staffID)) { 
%>
    <!-- senat Meeting -->
  </div>
  <li>
    <div align="center"><a href="senateMeeting.jsp" onMouseOver="window.status='eSenate';return true;">eSenate</A></div>
  </li>
  <div align="center">
    <% 	
 		}
	}
	catch(Exception e) {
		System.out.println("Error (MenuBox.Senate Meeting): " + e);
	}
	finally	{
		dbPool.returnConnection(conn_mtg);
	}
%>
    <!-- document management -->
  </div>
  <li>
    <div align="center"><a href="documentManagement.jsp" onMouseOver="window.status='Document Management';return true;">Document 
      Management</A></div>
  </li>
  <div align="center">
    <!-- senat evoting -->
  </div>
  <li>
    <div align="center"><a href="vote_senate.jsp" onMouseOver="window.status='Senate eVoting';return true;">Senate 
      eVoting</A></div>
  </li>
  
  <div align="center">
    <!-- dean evoting -->
  </div>
  <li>
    <div align="center"><a href="vote_dean.jsp" onMouseOver="window.status='Dean eVoting';return true;">Dean eVoting</A></div>
  </li>
  <div align="center">
    <!-- MBJ evoting -->
  </div>
  <li>
    <div align="center"><a href="vote.jsp" onMouseOver="window.status='MBJ eVoting';return true;">MBJ eVoting</A></div>
  </li>
  <!--div align="left">
    <!-- desn evoting -->
<!--
  </div>
  <li>
    <div align="center"><a href="vote_dean_fta.jsp" onMouseOver="window.status='Dean eVoting (FKKSA)';return true;">Dean eVoting (FKKSA)</A></div>
  </li>-->
  <div align="center">
    <!-- project & collaboration-
	<table width="100%" border="0">
        <tr valign="middle" class='contentBgColorAlternate'> 
          <td width="7%" height="20"><div align="center"><img src="images/yellowdi.gif"></div></td>
          <td width="80%" height="20">	<a href="projectCollaboration.jsp" onmouseover="window.status='Project & Collaboration';return true;"><FONT COLOR="#000000">Project & Collaboration</FONT></A></td>
 	 </tr>
	</table>
	<table border=0 cellpadding=0 cellspacing=0 align=center><tr><td bgcolor=#999999><img src="/images/spacer.gif" width=155 height=1 border=0></td></tr></table>

<!-- TQO-
	<table width="100%" border="0">
        <tr valign="middle" class='contentBgColorAlternate'> 
          <td width="7%" height="20"><div align="center"><img src="images/yellowdi.gif"></div></td>
          <td width="80%" height="20">	<a href="tqo.jsp?action=feedback" onmouseover="window.status='TQO';return true;"><FONT COLOR="#000000">TQO</FONT></A></td>
 	 </tr>
	</table>
	<table border=0 cellpadding=0 cellspacing=0 align=center><tr><td bgcolor=#999999><img src="/images/spacer.gif" width=155 height=1 border=0></td></tr></table>
	
	<!-- Progress Tracking -
	<table width="100%" border="0">
        <tr valign="middle" class='contentBgColorAlternate'> 
          <td width="7%" height="20"><div align="center"><img src="images/yellowdi.gif"></div></td>
          <td width="80%" height="20">	<a href="actionForm.jsp" onmouseover="window.status='Progress Tracking';return true;"><FONT COLOR="#000000">Progress Tracking</FONT></A></td>
 	 </tr>
	</table>
	<table border=0 cellpadding=0 cellspacing=0 align=center><tr><td bgcolor=#999999><img src="/images/spacer.gif" width=155 height=1 border=0></td></tr></table>
	-->
 
  </div>
 
  <div align="center">
    <!-- Resource Booking -->
  </div>
  <li>
    <div align="center"><A HREF="resourceCMS.jsp?action=view"  onMouseOver="window.status='Room & Other Facility Booking';return true;"><FONT COLOR="#000000" >Resource 
      Booking</FONT></A></div>
  </li>
  <div align="center">
    <!-- ICT Equipment Booking -->
  </div>
  <li>
    <div align="center"><a href="ICTInventory.jsp" onMouseOver="window.status='Resource Booking';return true;"><FONT COLOR="#000000">ICT 
      Equipment Booking</FONT></A></div>
  </li>
   <div align="center">
    <!-- Complaint Management -->
  </div>
  <li>
    <div align="center"><a href="complaintForms.jsp" onMouseOver="window.status='Complaint Management';return true;"><FONT COLOR="#000000">ICT Complaint Management</FONT></A></div>
  </li>
  <div align="center">
    <!-- dean evoting-->
    <!--table width="100%" border="0">
        <tr valign="middle" class='contentBgColorAlternate'> 
          <td width="7%" height="20"><div align="center"><img src="images/yellowdi.gif"></div></td>
          <td width="80%" height="20">	<a href="vote_dean.jsp" onMouseOver="window.status='Dean eVoting';return true;"><FONT COLOR="#000000">Dean eVoting (FSK)</FONT></A></td>
 	 </tr>
	</table>
	<table border=0 cellpadding=0 cellspacing=0 align=center><tr><td bgcolor=#999999><img src="/images/spacer.gif" width=155 height=1 border=0></td></tr></table -->
    <!-- dean evoting-->
    <!--table width="100%" border="0">
        <tr valign="middle" class='contentBgColorAlternate'> 
          <td width="7%" height="20"><div align="center"><img src="images/yellowdi.gif"></div></td>
          <td width="80%" height="20">	<a href="vote_dean_fist.jsp" onMouseOver="window.status='Dean eVoting';return true;"><FONT COLOR="#000000">Dean eVoting (FSTI)</FONT></A></td>
 	 </tr>
	</table>
	<table border=0 cellpadding=0 cellspacing=0 align=center><tr><td bgcolor=#999999><img src="/images/spacer.gif" width=155 height=1 border=0></td></tr></table -->
    <!-- Kenaikan Pangkat Akademik -->
  </div>
  <li>
    <div align="center"><a href="kenaikanPangkat.jsp" onMouseOver="window.status='Kenaikan Pangkat Akademik';return true;"><FONT COLOR="#000000">Kenaikan 
      Pangkat Akademik</FONT></A></div>
  </li>
  <div align="center">
    <!-- eFiling -->
  </div>
  <li>
    <div align="center"><a href="eFiling.jsp" target="_blank" onMouseOver="window.status='eFiling.jsp';return true;"><FONT COLOR="#000000">eFiling 
      System</FONT></A></div>
  </li>
  <div align="center">
    <!-- eLetter -->
  </div>
  <li>
    <div align="center"><a href="http://apps-cfm.ump.edu.my/eletter/" target="_blank" onMouseOver="window.status='eLetter';return true;"><FONT COLOR="#000000">eLetter Mgmt. System</FONT></A></div>
  </li>
<div align="center">
    <!-- eLetter Action -->
  </div>
  <li>
    <div align="center"><a href="http://community.ump.edu.my/ecommstaff/eletter.jsp" onMouseOver="window.status='eLetter';return true;"><FONT COLOR="#000000">eLetter Feeback Mgmt.</FONT></A></div>
  </li>
  <div align="center">
    <!-- CENFAD -->
  </div>
  <li>
    <div align="center"><A HREF="javascript:void(window.open('cmsformlink.jsp?form=cenfed','ME'))" onMouseOver="window.status='CENFAD System';return true;"><FONT COLOR="#000000">CENFED 
      System</FONT></A></div>
  </li>
  <div align="center">
   <!-- complaint_JPPH -->
  </div>
  <li>
    <div align="center"><a href="complaint_JPPH.jsp"  onMouseOver="window.status='complaint_JPPH';return true;"><FONT COLOR="#000000">JPPH Complaint Mgmt.</FONT></A></div>
  </li>
<div align="center">
    <!-- Legal Management -->
  </div>
  <!--li>
    <div align="center"><a href="legal.jsp" onMouseOver="window.status='Legal Management';return true;"><FONT COLOR="#000000">Legal 
      Management</FONT></A></div>
  </li --> 


        <li>
        <div align="center"><a class="MenuBarItemSubmenu" href="#">Network & Telecomunication System</a></div>
        <ul>
        <div align="center">  <li><A HREF="tmsApps.jsp"  onMouseOver="window.status='Traffic Monitoring System (TMS)';return true;"><FONT COLOR="#000000" >Traffic Monitoring System (TMS)</FONT></A></li>
          <li><A HREF="webBillApps.jsp"  onMouseOver="window.status='Call Billing System';return true;"><FONT COLOR="#000000" >Call Billing System</FONT></A></li></div>
        </ul>
      </li>
      
</ul>


  <!-- end flexmenu1 - General Managment-->
  <!-- flexmenu2 - Staff Management -->
    <!-- Menu Personal -->
 <li><div align="left"><a class="MenuBarItemSubmenu" href="#"><img src="images/staffMenu.gif"></a></div>
    <ul>
      <li><a class="MenuBarItemSubmenu" href="#">Personal</a> 
      <ul>
          <!-- Staff Profile -->
          <li><A HREF="profileInfo.jsp" onMouseOver="window.status='<%= messages.getString("my.profile") %>';return true;">My 
            Profile</A></li>
          <!-------------Staff Attendance------------------------------>
          <li><A HREF="staffAttendance.jsp" onMouseOver="window.status='Staff_Attendance';return true;"><FONT COLOR="#000000" >Staff 
            Attendance</FONT></A></li>
          <!-------------Staff Time Off------------------------------>
          <li><A HREF="timeoffApplication.jsp" onMouseOver="window.status='Staff_TimeOff';return true;"><FONT COLOR="#000000" >Staff 
            Time off</FONT></A></li>
          <!-------------Staff Movement------------------------------>
          <li><A HREF="staffAttendance.jsp?action=staff_movement" onMouseOver="window.status='Staff_Attendance';return true;"><FONT COLOR="#000000" >Staff 
            Movement</FONT></A></li>
          <!-------------BSC New------------------------------>
          <!--li><A HREF="bsc.jsp" onMouseOver="window.status='BSC';return true;"><FONT COLOR="#000000">Balanced 
            Score Card (BSC)</FONT></A></li --> 
          <!-- Sasaran kerja Tahunan -->
          <li><A HREF="sktnew.jsp" onMouseOver="window.status='Sasaran_Kerja_Tahunan';return true;"><FONT COLOR="#000000" >Sasaran 
            Kerja Tahunan (SKT)</FONT></A></li>
          <!-- Asset declaration -->
          <li><a href="harta.jsp" onMouseOver="window.status='Asset Declaration';return true;"><font COLOR="#000000">Asset 
            Declaration</font></a></li>
          <!-- Overtime -->
          <li><A HREF="overtime.jsp" onMouseOver="window.status='Apply';return true;"><FONT COLOR="#000000"> 
            Overtime</FONT></A></li>
          <!-- Leave -->
          <li><A HREF="leaveMain.jsp" onMouseOver="window.status='Leave';return true;"><FONT COLOR="#000000">Leave</FONT></A></li>
          <!-- workorder  -->
          <li><A HREF="workorderMain.jsp" onMouseOver="window.status='Workorder';return true;"><FONT COLOR="#000000" >WorkOrder</FONT></A></li>
          <!-- TnT -->
          <li><a href="tnt.jsp" onMouseOver="window.status='Travelling & Transport Claims';return true;"><FONT COLOR="#000000">TnT</FONT></A></li>
          <!-- Phone billing -->
          <!--li><a href="phone.jsp" onMouseOver="window.status='Phone Bill';return true;"><font COLOR="#000000" >Phone 
            Bill</font></a></li -->
        </ul>
 </li>
      <!-- HRM Management -->
       <li><a class="MenuBarItemSubmenu" href="#">Human Resource Management</a> 
        <ul>
          <!--MBJ Vote-->
          <li><A HREF="vote.jsp" onMouseOver="window.status='UMP_SURVEY';return true;"><FONT COLOR="#000000" >MBJ 
            Voting</FONT></A></li>
          <!-- Seminar Attendance -->
          <li><a href="seminar.jsp" onMouseOver="window.status='Seminar Attendance';return true;"><font COLOR="#000000" >Seminar 
            Attendance</font></a></li>
          <!-- Training -->
          <!--<li><a href="trainingmanagement.jsp" onMouseOver="window.status='Induction Application';return true;"><font COLOR="#000000" >Training 
            Management</font></a></li>-->
          <!-- Interview -->
          <li><a href="interview.jsp" onMouseOver="window.status='Interview';return true;"><font COLOR="#000000" >Interview</font></a></li>
          <!-- Assessment -->
          <li><A HREF="staffAssessment.jsp" onMouseOver="window.status='Assessment';return true;"><FONT COLOR="#000000" >Assessment</FONT></A></li>
          <!-- Tuntutan Perpindahan Rumah -->
          <li><a href="e_tepr.jsp" onMouseOver="window.status='Tuntutan Perpindahan Rumah';return true;"><font COLOR="#000000">Tuntutan 
            Perpindahan Rumah</font></a></li>
            <li><a href="e_ttlp.jsp" onMouseOver="window.status='Tuntutan Tambang Lantikan Pertama';return true;"><font COLOR="#000000">Tuntutan Tambang Lantikan Pertama</font></a></li>
			<li><a href="clinicBook.jsp" onMouseOver="window.status='Clinics Panel Book Application';return true;"><font COLOR="#000000">Clinics Panel Book Application</font></a></li>
			<li><a href="dentalClaim.jsp" onMouseOver="window.status='Dental Treatment Claim';return true;"><font COLOR="#000000">Dental Treatment Claim</font></a></li>
			<li><a href="smartCard.jsp" onMouseOver="window.status='Dental Treatment Claim';return true;"><font COLOR="#000000">Smart Card Application</font></a></li>
            <!-- Tapisan Keselamatan -->
<li><a href="tapisan_keselamatan.jsp" onMouseOver="window.status='Tapisan Keselamatan';return true;"><font COLOR="#000000">Tapisan 
Keselamatan</font></a></li>
<!-- pekerjaan luar -->
<li><a href="pekerjaan_luar.jsp" onMouseOver="window.status='Permohonan Melakukan Pekerjaan Luar';return true;"><font COLOR="#000000">Permohonan Melakukan Pekerjaan Luar</font></a></li>
  <!-- eCadangan -->
<li><a href="eCadangan.jsp" onMouseOver="window.status='eCadangan/ Aduan Klinik Panel';return true;"><font COLOR="#000000">eCadangan/ Aduan Klinik Panel</font></a></li>
<!-- edocket -->
<li><a href="edocket.jsp" onMouseOver="window.status='eDocket';return true;"><font COLOR="#000000">eDocket</font></a></li>
<li><a href="warm_cloth.jsp" onMouseOver="window.status='Pakaian Panas';return true;"><font COLOR="#000000">Permohonan Pakaian Panas</font></a></li>
<!-- expatriate -->
<li><a href="expatriate.jsp" onMouseOver="window.status='Expatriate Management';return true;"><font COLOR="#000000">Expatriate Management</font></a></li>
<!-- PROFESIONAL BODY -->
<li><a href="profesional_body.jsp" onMouseOver="window.status='Profesional Body Fee';return true;"><font COLOR="#000000">Profesional Body Fee Claim</font></a></li>
<!-- medical 
<li><a href="medical.jsp" onMouseOver="window.status='Non Panel Clinic Claim';return true;"><font COLOR="#000000">Non Panel Clinic Claim</font></a></li>-->
        </ul>
    </li>
    <div align="left">
      <!-- menu Academic Mangement -->
    </div>
    <li><a class="MenuBarItemSubmenu" href="#">Academic Management</a> 
        <ul>
          <!-- Online Research Information System (ORIS) - ADMIN ACCESS  -->
          <% if (cmsStaffValidator.isAuthorized(staffID,"RESCADM001","1.00")) { %>
          <li><a href="cms/admin.jsp" target="_blank"  onMouseOver="window.status='Research Admin';return true;"><FONT COLOR="#000000">ORIS</FONT></A></li>
          <% } %>
          <!-- Online Research Information System (ORIS) - USER ACCESS -->
          <% if (cmsStaffValidator.isAuthorized(staffID,"RESCADM002","1.00")) { %>
          <li><a href="cms/leader.jsp" target="_blank"  onMouseOver="window.status='Research User';return true;"><FONT COLOR="#000000">Research 
            Info System</FONT></A></li>
          <% } %>
          <!-- ASDC -->
          <li><a href="asdc_workload.jsp" onMouseOver="window.status='Workload';return true;"><font COLOR="#000000" >Academic 
            Staf Management</font></a></li>
          <!-- Study Leave -->
         <!-- <li><a href="cutiBelajar.jsp" onMouseOver="window.status='Study Leave';return true;"><FONT COLOR="#000000">Study 
            Leave</FONT></A></li>-->
            <li><a href="epat.jsp" onMouseOver="window.status='Online Evaluation (e-PAT)';return true;"><FONT COLOR="#000000">Online Evaluation (e-PAT)</FONT></A></li>
          <!-- setara -->
          <!--<li><a href="setara.jsp" onMouseOver="window.status='Setara';return true;"><FONT COLOR="#000000">Setara</FONT></A></li>-->
        </ul>
    </li>
    <div align="left">
      <!-- eTempahan -->
      <!-- Facility Management -->
    </div>
    <li><a class="MenuBarItemSubmenu" href="#">Facility Management</a> 
        <ul>
          <li><a href="eTempahan.jsp" onMouseOver="window.status='Sports Facilities Booking';return true;"><font COLOR="#000000" >Sports 
            Facilities Booking</font></a></li>
          <!-- eTempahan  Complex-->
          <li><a href="eTempahan_complex.jsp" onMouseOver="window.status='Sports Complex Booking ';return true;"><font COLOR="#000000" >Sports 
            Complex Booking </font></a></li>
        </ul>
    </li>
    <div align="left">
      <!-- Knowledge -->
    </div>
    <li><a class="MenuBarItemSubmenu" href="#">Knowledge Management</a> 
        <ul>
          <!-- K-Bank-->
          <li><A HREF="kmsentry.jsp"  onMouseOver="window.status='K-Bank';return true;"><FONT COLOR="#000000" >K-Bank</FONT></A></li>
          <!-- files bank -->
          <li><a href="library.jsp?action=view" onMouseOver="window.status='Files Bank';return true;"><FONT COLOR="#000000">Files 
            Bank</FONT></A></li>
        </ul>
    </li>
    <div align="left">
      <!-- Others -->
    </div>
    <li><a class="MenuBarItemSubmenu" href="#">Others</a> 
        <ul>
          <!-- UMP's Survey-->
          <li><A HREF="votesurvey.jsp" onMouseOver="window.status='UMP_SURVEY';return true;"><FONT COLOR="#000000" >UMP's 
            Survey</FONT></A></li>
          <!-- Inventory Management System-->
          <li><a href="javascript:void(window.open('cms/inventoryims/index.jsp','approve', 'height=768,width=1024,menubar=no,toolbar=no,scrollbars=yes'))"><font COLOR="#000000">Inventory 
            Management System</font></a></li>
          <!-- Security Division -->
          
		  <!-- Pusat Kesihatan Pelajar -->
	<%	if ("PKP1000".equals(deptcode)) { %> 
          <li> <A HREF="pkp.jsp" onMouseOver="window.status='PKP - Medical & Disability Info';return true;"><FONT COLOR="#000000" >Pusat Kesihatan Pelajar</FONT></A></li>
	<%	} %>
        </ul>
    </li>
  </ul>
  

    <!-- end flexmenu2 - Staff Management-->
	
    <!-- flexmenu3 - Student Management -->
 <li><div align="left"><a class="MenuBarItemSubmenu" href="#"><img src="images/stdMenu.gif"></a></div>
    <ul>
		<!-- HEP inventory-->
      <li><a href="inventory.jsp" onMouseOver="window.status='HEP Inventory';return true;"><FONT COLOR="#000000">HEP 
        Inventory</FONT></A></li>
      <!-- Student Attendance-->
      <li><a href="attendance.jsp" onMouseOver="window.status='Student Attendance';return true;"><FONT COLOR="#000000">Student 
        Attendance</FONT></A></li>
      <!-- Vehicle registration -->
      <% if (cmsStaffValidator.isAuthorized(staffID,"STUDVEH001","1.00")) { %>
      <li><a href="kenderaan.jsp" onMouseOver="window.status='Student's Vehicle Registration';return true;"><FONT COLOR="#000000">Student's 
        Vehicle Registration</FONT></A></li>
      <% } %>
      <!-- Electrical Application for HEP-->
      <% if (cmsStaffValidator.isAuthorized(staffID,"ELEC01","1.00")) { %>
      <li><a href="electrical_app.jsp" onMouseOver="window.status='Student's Electrical Registration';return true;"><FONT COLOR="#000000">Electrical 
        Registration</FONT></A></li>
      <% } %>
      <!-- post grad -->
      <!-- % if (cmsStaffValidator.isAuthorized(staffID,"ORGSADM001","1.00")) { % -->
      <li><a href="cms/postgrad.jsp" target="_blank"  onMouseOver="window.status='CGS Admin';return true;"><FONT COLOR="#000000">CGS 
        Admin</FONT></A></li>
      <!--% } % -->
      <!-- postgrad supervision -->
      <li><a href="cms/supervise.jsp" target="_blank"  onMouseOver="window.status='CGS Access';return true;"><FONT COLOR="#000000">CGS 
        Access</FONT></A></li>
      <!-- student Financial -->
      <li><a href="staff_std_Finance.jsp" onMouseOver="window.status='Student Financial';return true;"><font COLOR="#000000" >Student 
        Financial</font></a></li>
      <!-- short term fund -->
      <li><a href="short_term_fund.jsp?action=short_term_fundListHepa" onMouseOver="window.status='Short Term Loan';return true;"><FONT COLOR="#000000">Short 
        Term Loan HEPA</FONT></A></li>
      <!-- Death Compensation -->
      <li><a href="death_compensation.jsp?action=death_compensationListHepa" onMouseOver="window.status='Death Compensation HEPA';return true;"><FONT COLOR="#000000">Death 
        Compensation HEPA</FONT></A></li>
          <!-- Student Activity Application-->
      <li><a href="application_activities.jsp?action=leveltype" onMouseOver="window.status='Student Activity Application';return true;"><FONT COLOR="#000000">Student Activity Application
	  </FONT></A></li>
        <!-- CLUB SYSTEM-->
      <li><a href="aktivitiPelajar.jsp?action=main" onMouseOver="window.status='Club System<';return true;"><FONT COLOR="#000000">Club System
	  </FONT></A></li>
       <!-- Disiplin Pelajar-->
      <li><a href="Disiplin.jsp" onMouseOver="window.status='Student Discipline';return true;"><FONT COLOR="#000000">Student Discipline</FONT></A></li>
       <!-- Hostel Pelajar-->
      <li><a href="hostel.jsp" onMouseOver="window.status='Hostel Application';return true;"><FONT COLOR="#000000">Hostel Application</FONT></A></li>
       <!-- Merit Demrit Pelajar-->
      <li><a href="stdmerit.jsp" onMouseOver="window.status='Student Merit Demerit';return true;"><FONT COLOR="#000000">Student Merit Demerit</FONT></A></li>
      <!-- CENFAD -->
      <li><A HREF="javascript:void(window.open('cmsformlink.jsp?form=ekaunseling','ME'))" onMouseOver="window.status='eKaunseling System';return true;"><FONT COLOR="#000000">eKaunseling 
        System</FONT></A></li>
      <!-- eaduan MPP -->
      <li><a href="eaduan_mpp.jsp?action=eaduan_mppListHEPA" onMouseOver="window.status='e-Aduan MPP';return true;"><FONT COLOR="#000000">e-Aduan 
        MPP</FONT></A></li>
	</ul>
    </li>
	
    <!-- end flexmenu3 - Student Management -->
	
	
    
    
	<!-- flexmenu 4 - Financial Management -->
 <li><div align="left"><a class="MenuBarItemSubmenu" href="#"><img src="images/financeMenu.gif"></a></div>
    <ul>
       <li><a class="MenuBarItemSubmenu" href="#">Financial Info</a> 
        <ul>
        <li><A HREF="financialInfo.jsp" onMouseOver="window.status='MyFinance';return true;">MyFinance</A></li>
         <li><A HREF="frontview.jsp" onMouseOver="window.status='iKEW';return true;">iKEW</A></li>
         <li><A HREF="vendor2.jsp" onMouseOver="window.status='Vendor Payment Info';return true;">Vendor Payment Info</A></li>
        </ul>
        </li>
        
          <li><a class="MenuBarItemSubmenu" href="#">E-Services</a> 
        <ul>
        <li><A HREF="javascript:void(window.open('cmsformlink.jsp?form=eprocurement','ME'))"  onMouseOver="window.status='Account Management';return true;"><FONT COLOR="#000000" >eNotice</FONT></A></li>
        <li><A HREF="eTicketing.jsp"  onMouseOver="window.status='eTicketing';return true;"><FONT COLOR="#000000" >eTicketing</FONT></A></li>
        <li><A HREF="loanMgmt.jsp"  onMouseOver="window.status='Loan Management';return true;"><FONT COLOR="#000000" >eLoan Management</FONT></A></li>
        <li><A HREF="pettycash.jsp"  onMouseOver="window.status='Petty Cash Claim';return true;"><FONT COLOR="#000000" >ePetty Cash Claim</FONT></A></li>
        <li><A HREF="budgetVirement.jsp?action=list"  onMouseOver="window.status='Petty Cash Claim';return true;"><FONT COLOR="#000000" >eBudget Virement </FONT></A></li>
        <li><A HREF="ebilling.jsp" onMouseOver="window.status='eBilling';return true;">eBilling</A></li>
        </ul>
        </li>
        
        </ul>
        </li>
      
		<!-- end flexmenu4 -->
<!-- research menu -->
<li><div align="left"><A HREF="rndmgmt.jsp" onMouseOver="window.status='Research Management System';return true;"><img src="images/searchMenu.gif"></A></div></li>
<!-- end research menu -->


		<!-- flexmenu 5 - Research Management -->
        <!-- Personal -->
<!--  <li><a href="cms/smpu/index4.jsp" target="blank" onMouseOver="window.status='Personal';return true;"><FONT COLOR="#000000">Personal</FONT></A></li>
	<% if (cmsStaffValidator.isAuthorized(staffID,"RESCADM003","1.00")) { %>
	<li><A HREF="cms/smpu/index.jsp"  target="blank" onMouseOver="window.status='Super Admin';return true;"><FONT COLOR="#000000" >Super Admin</FONT></A></li>-->
    <% } %>
	<% if (cmsStaffValidator.isAuthorized(staffID,"RESCADM006","1.00") ) { %>
	<!--<li>	<A HREF="cms/smpu/index5.jsp"  target="blank" onMouseOver="window.status='Admin';return true;"><FONT COLOR="#000000" >Admin</FONT></A></li>-->
    <% } %>
    <% if (cmsStaffValidator.isAuthorized(staffID,"RESCADM005","1.00") ) { %>
	<!--<li><A HREF="cms/smpu/index.jsp"  target="blank" onMouseOver="window.status='Administrator';return true;"><FONT COLOR="#000000" >Administrator</FONT></A></li>-->
    <% } %>
		<!-- end flexmenu5-->
  <%
	}
	catch(Exception e)
	{	
		System.out.println("Error (MenuBox.EIS):"+e);
	}
	finally
	{
		conn.close();
	}

%>
	
    
    <!-- flexmenu 6 - Security Management -->
 <li><div align="left"><a class="MenuBarItemSubmenu" href="#"><img src="images/securityMenu.png"></a></div>
    <ul>        <!-- -CCTV -->
		<li><A HREF="cmsformlink.jsp?form=security" target="_blank"  onMouseOver="window.status='CCTV Management';return true;"><FONT COLOR="#000000" >CCTV</FONT></A></li>
        <li> <A HREF="VehicleSticker.jsp" onMouseOver="window.status='Vehicle Registration Application';return true;"><FONT COLOR="#000000" >Security 
            Management</FONT></A></li>
        </ul>
        </li>
    
     <!-- flexmenu 6 - Security Management -->
     
	    <!--ul id="flexmenu7" class="flexdropdownmenu">
        <div align="left"-->
        <!-- -CCTV -->
		<!--li><A HREF="trainingmanagement.jsp"   onMouseOver="window.status='MyLatihan';return true;"><FONT COLOR="#000000" >MyLatihan</FONT></A></li>
        <li><A HREF="cms/calendar/after_login.jsp"   target="_blank" onMouseOver="window.status='Kalendar Latihan';return true;"><FONT COLOR="#000000" >Kalendar Latihan</FONT></A></li>
       
        </div>
        </ul-->
        
     <li><div align="left"><a class="MenuBarItemSubmenu" href="#"><img src="images/trainingMenu.png"></a></div>
    <ul>
           <li><a class="MenuBarItemSubmenu" href="#">MyLatihan</a> 
          <ul>
        <li><A HREF="induction.jsp"  onMouseOver="window.status='Induction';return true;"><FONT COLOR="#000000" >Induction</FONT></A></li>
        <li><A HREF="training_internal.jsp"  onMouseOver="window.status='Internal Training';return true;"><FONT COLOR="#000000" >Internal Training</FONT></A></li>
        <li><A HREF="training.jsp"  onMouseOver="window.status='Training Summary';return true;"><FONT COLOR="#000000" >Training Summary</FONT></A></li>
        <li><A HREF="#"  onMouseOver="window.status='Examination Services';return true;"><FONT COLOR="#000000" >Examination Services</FONT></A></li>
        <li><A HREF="apply_training.jsp"  onMouseOver="window.status='External Training';return true;">External Training</A></li>
         <li><A HREF="#"  onMouseOver="window.status='PTK';return true;"><FONT COLOR="#000000" >PTK</FONT></A></li>
                  <li><A HREF="tna.jsp"  onMouseOver="window.status='Training Need Analysis';return true;">Training Need Analysis </A></li>
        </ul>
        </li>
      
      
      
          <li> 
       <A HREF="cms/calendar/after_login.jsp"   target="_blank" onMouseOver="window.status='Training Calendar';return true;">Training Calendar</a> 
        </li>
        <li><A HREF="javascript:void(window.open('cmsformlink.jsp?form=upload_training','ME'))"  onMouseOver="window.status='Account Management';return true;"><FONT COLOR="#000000" >Training Upload</FONT></A></li>
        <li> 
       <A HREF="training_info.jsp"   onMouseOver="window.status='Training Info';return true;">Training Info</a> 
         </li>
          <li> 
      <a href="#">CPD@UMP</a> 
           </li>
          <li> 
        <a href="training.jsp">Staff Training Summary</a></li></ul></ul>
      </li>
      </ul>
      </div>
      </li>
      </ul>
    </div>
    <!-- Menu : External -->
<% } if (userType.equals("EXTERNAL")) { %>
    <table width="150" height="25" border="0" cellpadding="0" cellspacing="0">
      <TR> 
        <TD HEIGHT="28" WIDTH="20%" ALIGN="CENTER"><IMG SRC="<%= request.getServletPath().equals("/profile.jsp") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" WIDTH="15" HEIGHT="17"></TD>
        <TD HEIGHT="28" WIDTH="80%"><A HREF="profile.jsp?action=viewOthers" onMouseOver="window.status='<%= messages.getString("my.profile") %>';return true;"><FONT COLOR="#000000"> 
          My Profile </FONT></A></TD>
      </TR>
      <TR> 
      
        <TD HEIGHT="28" WIDTH="20%" ALIGN="CENTER"><IMG SRC="<%= request.getServletPath().equals("/cms/examResultForParent/examResultTmsINTRANET.jsp") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" WIDTH="15" HEIGHT="17"></TD>
        <TD HEIGHT="28" WIDTH="80%"><A HREF="examResultForParent.jsp"  onMouseOver="window.status='Course Results';return true;"> 
          <FONT COLOR="#000000">Exam Results</FONT></A></TD>
      </TR>
      
        <TD HEIGHT="28" WIDTH="20%" ALIGN="CENTER"><IMG SRC="<%= request.getServletPath().equals("/studentFinance.jsp") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" WIDTH="15" HEIGHT="17"></TD>
        <TD HEIGHT="28" WIDTH="80%"><A HREF="studentFinance.jsp"  onMouseOver="window.status='Finance Information';return true;"> 
          <FONT COLOR="#000000">Financial Information</FONT></A></TD>
      </TR>
     
      <TR> 
        <TD HEIGHT="28" WIDTH="20%" ALIGN="CENTER"><IMG SRC="<%= request.getServletPath().equals("/VehicleSticker.jsp") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" WIDTH="15" HEIGHT="17"></TD>
        <TD HEIGHT="28" WIDTH="80%"><A HREF="VehicleSticker.jsp"  onMouseOver="window.status='Vehicle Sticker';return true;"> 
          <FONT COLOR="#000000">Vehicle Sticker</FONT></A></TD>
      </TR>
   
      <!-- Online Research Information System (ORIS) - ADMIN ACCESS  -->
      <% if (staffID.equals("T040")) { %>
      <table width="100%" border="0">
        <tr valign="middle" class='contentBgColorAlternate'> 
          <td width="7%" height="20"><div align="center"><img src="images/yellowdi.gif"></div></td>
          <td width="80%" height="20"> <a href="cms/admin.jsp" target="_blank"  onMouseOver="window.status='Research Admin';return true;"><FONT COLOR="#000000">ORIS</FONT></A></td>
        </tr>
      </table>
      
      <% } %>
      <!-- Mac Address -->
      <TR> 
        <TD HEIGHT="28" WIDTH="20%" ALIGN="CENTER"><IMG SRC="<%= request.getServletPath().equals("/radius.jsp") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" WIDTH="15" HEIGHT="17"></TD>
        <TD HEIGHT="28" WIDTH="80%"><A HREF="radius.jsp"  onMouseOver="window.status='Mac Address Registration';return true;"> 
          <FONT COLOR="#000000">MAC Address</FONT></A></TD>
      </TR>
     
   
      <!-- E-Meeting -->
      <%
		Hashtable userMeetingACLTable=null, groupMeetingACLTable=null;
		Hashtable setupUserMeetingACLTable=null,setupGroupMeetingACLTable=null;
		ACL  acl = new ACL();
		acl.initTVO(request);
		userMeetingACLTable  = acl.getRights(userID, "MeetingMain", "User");
		groupMeetingACLTable = acl.getRights(userID, "MeetingMain", "Group");
		setupUserMeetingACLTable  = acl.getRights(userID, "MeetingSetup", "User");
		setupGroupMeetingACLTable = acl.getRights(userID, "MeetingSetup", "Group");
	      if ( (userMeetingACLTable.containsKey("view") && userMeetingACLTable.get("view").equals("1") ) ||
        	   (groupMeetingACLTable.containsKey("view") &&  groupMeetingACLTable.get("view").equals("1")) ||
             (setupUserMeetingACLTable.containsKey("view") && setupUserMeetingACLTable.get("view").equals("1")) ||
             (setupGroupMeetingACLTable.containsKey("view") && setupGroupMeetingACLTable.get("view").equals("1")))
				{
%>
      <TR> 
        <TD HEIGHT="28" WIDTH="20%" ALIGN="CENTER"><IMG SRC="<%= request.getServletPath().equals("/eMeeting.jsp") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" WIDTH="15" HEIGHT="17"></TD>
        <TD HEIGHT="28" WIDTH="80%"><A HREF="eMeeting.jsp"  onMouseOver="window.status='eMeeting';return true;"> 
          <FONT COLOR="#000000">eMeeting</FONT></A></TD>
      </TR>
   
      <% } %>
      <!-- HEP Inventory -->
      <tr> 
        <td height="28" width="20%" align="CENTER"><img src="<%= request.getServletPath().equals("/inventory.jsp") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" width="15" height="17"></td>
        <td height="28" width="80%"><a href="inventory.jsp" onMouseOver="window.status='inventory';return true;"><FONT COLOR="#000000">HEP 
          inventory</font></a></td>
      </tr>
 
      <!-- Staff Claim Info-->
      <tr> 
        <td height="28" width="20%" align="CENTER"><img src="<%= request.getServletPath().equals("/staffClaim.jsp?action=main") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" width="15" height="17"></td>
        <td height="28" width="80%"><a href="staffClaim.jsp?action=main" onMouseOver="window.status='Staff Claim Info';return true;"><FONT COLOR="#000000">Claim 
          Info</font></a></td>
      </tr>
      
      <!-- Payslip -->
      <tr> 
        <td height="28" width="20%" align="CENTER"><img src="<%= request.getServletPath().equals("/payslip.jsp") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" width="15" height="17"></td>
        <td height="28" width="80%"><a href="payslip.jsp" onMouseOver="window.status='Payslip';return true;"><FONT COLOR="#000000">Payslip 
          Info</font></a></td>
      </tr>
      
      <!-- resource booking -->
      <tr> 
        <td height="28" width="20%" align="CENTER"><img src="<%= request.getServletPath().equals("/payslip.jsp") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" width="15" height="17"></td>
        <td height="28" width="80%"><a href="resourcebooking.jsp" onMouseOver="window.status='Resource Booking';return true;"><FONT COLOR="#000000">Resource 
          Booking</font></a></td>
      </tr>
    
     <!-- External Training -->
      <tr> 
        <td height="28" width="20%" align="CENTER"><img src="<%= request.getServletPath().equals("/payslip.jsp") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" width="15" height="17"></td>
        <td height="28" width="80%"><a href="training.jsp" onMouseOver="window.status='Resource Booking';return true;"><FONT COLOR="#000000">External Training</font></a></td>
      </tr>

     <!-- Internal Training -->
      <tr> 
        <td height="28" width="20%" align="CENTER"><img src="<%= request.getServletPath().equals("/payslip.jsp") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" width="15" height="17"></td>
        <td height="28" width="80%"><a href="training_internal.jsp" onMouseOver="window.status='Resource Booking';return true;"><FONT COLOR="#000000">Internal Training</font></a></td>
      </tr>  
      <!-- Leave (Academic Service Scheme) -->
      <tr> 
        <td height="28" width="20%" align="CENTER"><img src="<%= request.getServletPath().equals("/leaveMain.jsp?action=apply_ext") ? "images/system/folder2.gif" : "images/system/folder.gif" %>" width="15" height="17"></td>
        <td height="28" width="80%"><a href="leaveMain.jsp?action=apply_ext" onMouseOver="window.status='Resource Booking';return true;"><FONT COLOR="#000000">Leave</font></a></td>
      </tr>    
    </table -->
    <% } %>
    <!-- tutup menu external --></div>
    <!-- tutup master div --></DIV>
    <!--TUTUP LEFTMENULINK -->
  </div>
</div>

<!-----------quick link------------------------------>
<img src="images/quicklinks/quick_links2.png" /><br>
<img src="images/quicklinks/menu.png" width="211" border="0" usemap="#Map">
<map name="Map">
  <area shape="rect" coords="2,1,49,54" href="memo.jsp?action=folders&amp;type=Y&amp;folderID=1">
  <area shape="rect" coords="49,2,89,54" href="http://webmail.ump.edu.my/" target="_blank">
  <area shape="rect" coords="90,2,147,54" href="library.jsp?action=view">
  <area shape="rect" coords="148,2,211,54" href="cmsformlink.jsp?form=E_LEARNING" target="_blank">
  <area shape="rect" coords="1,57,50,123" href="staffDirectory.jsp">
  <area shape="rect" coords="51,57,105,125" href="cmsformlink.jsp?form=forum" target="_blank">
  <area shape="rect" coords="106,57,155,126" href="ecommUsage.jsp?action=view">
  <area shape="rect" coords="156,57,207,125" href="directory.jsp?action=view">
</map>
<br>
<!--<a href="memo.jsp?action=folders&amp;type=Y&amp;folderID=1"><img src="images/quicklinks/memo.png" alt="Memo" width="58" height="65" border="0"></a>
<a href="http://webmail.ump.edu.my" target="_blank"><img src="images/quicklinks/emel.png" alt="E-Mail" width="58" height="65" border="0"></a>
<a href="library.jsp?action=view"><img src="images/quicklinks/failsbank.png" alt="Files Bank" width="58" height="65" border="0"></a> <br />
<a href="javascript:void(window.open('cmsformlink.jsp?form=E_LEARNING','EL'))" target="_blank"><img src="images/quicklinks/elearning.png" alt="E-Learning" width="58" height="65" border="0" /></a> <a href="staffDirectory.jsp"><img src="images/quicklinks/staff_Directory.png" alt="Staff Directory" width="58" height="65" border="0" /></a> <a href="cmsformlink.jsp?form=forum" target=_blank><img src="images/quicklinks/forum.png" alt="Forum" width="58" height="65" border="0" /></a><br />
<a href="ecommUsage.jsp?action=view"><img src="images/quicklinks/ecommusage.png" width="58" height="65" border="0" /></a>          <a href="directory.jsp?action=view"><img src="images/quicklinks/usergroup.png" width="58" height="65" border="0" /></a> <a href="http://ptmk.ump.edu.my/index.php/artikel.html" target="_blank"><img src="images/quicklinks/articleict.png" width="58" height="65" border="0" /></a>-->
<!------------end line------------------------------>

</HTML>

<div align="left"><div align="left"></cache:cache></div></div>
<cache:cache></div></div>
