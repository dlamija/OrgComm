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

<TITLE></TITLE>
<LINK REL="stylesheet" HREF="css/<%= (String)TvoContextManager.getSessionAttribute(request, "Login.CSSFile") %>">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/flexdropdown.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/flexdropdown.js"></script>

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
<table width="100%" border="0" cellpadding="0" cellspacing="0">
 
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
 <tr> 
    <td height="25">&nbsp;</td>
    <td><A HREF="EIS.jsp" onMouseOver="window.status='Executive Approval System';return true;"><img src="images/execMenu.gif"></A></td>
  </tr>
  <%}%>


  <tr> 
    <td width="10%" height="25"><div align="center"></div></td>
    <td width="90%"><a href="#" data-flexmenu="flexmenu1" data-dir="h" data-offsets="8,0"><img src="images/generalMenu.gif"></a></td>
  </tr>
  <tr> 
    <td height="25"><div align="center"></div></td>
    <td height="25"><a href="#" data-flexmenu="flexmenu2" data-dir="h" data-offsets="8,0"><img src="images/staffMenu.gif" width="100" height="35" border="0"></a></td>
  </tr>
  <tr> 
    <td height="25"><div align="center"></div></td>
    <td height="25"><a href="#" data-flexmenu="flexmenu3" data-dir="h" data-offsets="8,0"><img src="images/stdMenu.gif" border="0"></a></td>
  </tr>
  <tr> 
    <td height="25"><div align="center"></div></td>
    <td height="25"><a href="#" data-flexmenu="flexmenu4" data-dir="h" data-offsets="8,0"><img src="images/financeMenu.gif" width="100" height="35" border="0"></a></td>
  </tr>
  <tr> 
    <td height="25"><div align="center"></div></td>
    <td height="25"><a href="#" data-flexmenu="flexmenu5" data-dir="h" data-offsets="8,0"><img src="images/searchMenu.gif" border="0"></a></td>
  </tr>
</table>


 
<!-- flexmenu1 - General Management -->
<ul id="flexmenu1" class="flexdropdownmenu">

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
    <div align="left"><a href="eMeeting.jsp" onMouseOver="window.status='eMeeting';return true;">eMeeting</A></div>
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
    <div align="left"><a href="senateMeeting.jsp" onMouseOver="window.status='eSenate';return true;">eSenate</A></div>
  </li>
  <div align="left">
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
    <div align="left"><a href="documentManagement.jsp" onMouseOver="window.status='Document Management';return true;">Document 
      Management</A></div>
  </li>
  <div align="left">
    <!-- senat evoting -->
  </div>
  <li>
    <div align="left"><a href="vote_senate.jsp" onMouseOver="window.status='Senate eVoting';return true;">Senate 
      eVoting</A></div>
  </li>
  <div align="left">
    <!-- dean evoting -->
  </div>
  <li>
    <div align="left"><a href="vote_dean.jsp" onMouseOver="window.status='Dean eVoting (FKASA)';return true;">Dean eVoting (FKASA)</A></div>
  </li>
  <div align="left">
    <!-- desn evoting -->
  </div>
  <li>
    <div align="left"><a href="vote_dean_fta.jsp" onMouseOver="window.status='Dean eVoting (FKKSA)';return true;">Dean eVoting (FKKSA)</A></div>
  </li>
  <div align="left">
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
 
  <div align="left">
    <!-- Resource Booking -->
  </div>
  <li>
    <div align="left"><A HREF="resourceCMS.jsp?action=view"  onMouseOver="window.status='Room & Other Facility Booking';return true;"><FONT COLOR="#000000" >Resource 
      Booking</FONT></A></div>
  </li>
  <div align="left">
    <!-- ICT Equipment Booking -->
  </div>
  <li>
    <div align="left"><a href="ICTInventory.jsp" onMouseOver="window.status='Resource Booking';return true;"><FONT COLOR="#000000">ICT 
      Equipment Booking</FONT></A></div>
  </li>
  <div align="left">
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
    <div align="left"><a href="kenaikanPangkat.jsp" onMouseOver="window.status='Kenaikan Pangkat Akademik';return true;"><FONT COLOR="#000000">Kenaikan 
      Pangkat Akademik</FONT></A></div>
  </li>
  <div align="left">
    <!-- eFiling -->
  </div>
  <li>
    <div align="left"><a href="eFiling.jsp" target="_blank" onMouseOver="window.status='eFiling.jsp';return true;"><FONT COLOR="#000000">eFiling 
      System</FONT></A></div>
  </li>
  <div align="left">
    <!-- eLetter -->
  </div>
  <li>
    <div align="left"><a href="http://apps-cfm.ump.edu.my/eletter/" target="_blank" onMouseOver="window.status='eLetter';return true;"><FONT COLOR="#000000">eLetter 
      System</FONT></A></div>
  </li>
  <div align="left">
    <!-- CENFAD -->
  </div>
  <li>
    <div align="left"><A HREF="javascript:void(window.open('cmsformlink.jsp?form=cenfed','ME'))" onMouseOver="window.status='CENFAD System';return true;"><FONT COLOR="#000000">CENFED 
      System</FONT></A></div>
  </li>
  <div align="left">
    <!-- Legal Management -->
  </div>
  <!--li>
    <div align="left"><a href="legal.jsp" onMouseOver="window.status='Legal Management';return true;"><FONT COLOR="#000000">Legal 
      Management</FONT></A></div>
  </li --> 
</ul>
<div align="left">
  <!-- end flexmenu1 - General Managment-->
  <!-- flexmenu2 - Staff Management -->
  <ul id="flexmenu2" class="flexdropdownmenu">
    <!-- Menu Personal -->
    <li>
      <div align="left"><a href="#">Personal</a> 
        <ul>
          <!-- Staff Profile -->
          <li><A HREF="StaffProfile.jsp" onMouseOver="window.status='<%= messages.getString("my.profile") %>';return true;">My 
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
      </div>
    </li>
    <div align="left">
      <!-- HRM Management -->
    </div>
    <li>
      <div align="left"><a href="#">Human Resource Management</a> 
        <ul>
          <!--MBJ Vote-->
          <li><A HREF="vote.jsp" onMouseOver="window.status='UMP_SURVEY';return true;"><FONT COLOR="#000000" >MBJ 
            Voting</FONT></A></li>
          <!-- Seminar Attendance -->
          <li><a href="seminar.jsp" onMouseOver="window.status='Seminar Attendance';return true;"><font COLOR="#000000" >Seminar 
            Attendance</font></a></li>
          <!-- Training -->
          <li><a href="trainingmanagement.jsp" onMouseOver="window.status='Induction Application';return true;"><font COLOR="#000000" >Training 
            Management</font></a></li>
          <!-- Interview -->
          <li><a href="interview.jsp" onMouseOver="window.status='Interview';return true;"><font COLOR="#000000" >Interview</font></a></li>
          <!-- Assessment -->
          <li><A HREF="staffAssessment.jsp" onMouseOver="window.status='Assessment';return true;"><FONT COLOR="#000000" >Assessment</FONT></A></li>
          <!-- Tuntutan Perpindahan Rumah -->
          <li><a href="e_tepr.jsp" onMouseOver="window.status='Tuntutan Perpindahan Rumah';return true;"><font COLOR="#000000">Tuntutan 
            Perpindahan Rumah</font></a></li>
			<li><a href="clinicBook.jsp" onMouseOver="window.status='Clinics Panel Book Application';return true;"><font COLOR="#000000">Clinics Panel Book Application</font></a></li>
			<li><a href="dentalClaim.jsp" onMouseOver="window.status='Dental Treatment Claim';return true;"><font COLOR="#000000">Dental Treatment Claim</font></a></li>
			<li><a href="smartCard.jsp" onMouseOver="window.status='Dental Treatment Claim';return true;"><font COLOR="#000000">Smart Card Application</font></a></li>
        </ul>
      </div>
    </li>
    <div align="left">
      <!-- menu Academic Mangement -->
    </div>
    <li>
      <div align="left"><a href="#">Academic Management</a> 
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
          <li><a href="cutiBelajar.jsp" onMouseOver="window.status='Study Leave';return true;"><FONT COLOR="#000000">Study 
            Leave</FONT></A></li>
          <!-- setara -->
          <!--<li><a href="setara.jsp" onMouseOver="window.status='Setara';return true;"><FONT COLOR="#000000">Setara</FONT></A></li>-->
        </ul>
      </div>
    </li>
    <div align="left">
      <!-- eTempahan -->
      <!-- Facility Management -->
    </div>
    <li>
      <div align="left"><a href="#">Facility Management</a> 
        <ul>
          <!-- HelpDesk - complaint&suggestion system -->
          <li><A HREF="complaintForms.jsp" onMouseOver="window.status='Complaint_Management';return true;"><FONT COLOR="#000000" >Complaint 
            Management</FONT></A></li>
          <li><a href="eTempahan.jsp" onMouseOver="window.status='Sports Facilities Booking';return true;"><font COLOR="#000000" >Sports 
            Facilities Booking</font></a></li>
          <!-- eTempahan  Complex-->
          <li><a href="eTempahan_complex.jsp" onMouseOver="window.status='Sports Complex Booking ';return true;"><font COLOR="#000000" >Sports 
            Complex Booking </font></a></li>
        </ul>
      </div>
    </li>
    <div align="left">
      <!-- Knowledge -->
    </div>
    <li>
      <div align="left"><a href="#">Knowledge Management</a> 
        <ul>
          <!-- K-Bank-->
          <li><A HREF="kmsentry.jsp"  onMouseOver="window.status='K-Bank';return true;"><FONT COLOR="#000000" >K-Bank</FONT></A></li>
          <!-- files bank -->
          <li><a href="library.jsp?action=view" onMouseOver="window.status='Files Bank';return true;"><FONT COLOR="#000000">Files 
            Bank</FONT></A></li>
        </ul>
      </div>
    </li>
    <div align="left">
      <!-- Others -->
    </div>
    <li>
      <div align="left"><a href="#">Others</a> 
        <ul>
          <!-- UMP's Survey-->
          <li><A HREF="votesurvey.jsp" onMouseOver="window.status='UMP_SURVEY';return true;"><FONT COLOR="#000000" >UMP's 
            Survey</FONT></A></li>
          <!-- Inventory Management System-->
          <li><a href="javascript:void(window.open('cms/inventoryims/index.jsp','approve', 'height=768,width=1024,menubar=no,toolbar=no,scrollbars=yes'))"><font COLOR="#000000">Inventory 
            Management System</font></a></li>
          <!-- Security Division -->
          <li> <A HREF="VehicleSticker.jsp" onMouseOver="window.status='Vehicle Registration Application';return true;"><FONT COLOR="#000000" >Security 
            Management</FONT></A></li>
		  <!-- Pusat Kesihatan Pelajar -->
	<%	if ("PKP1000".equals(deptcode)) { %> 
          <li> <A HREF="pkp.jsp" onMouseOver="window.status='PKP - Medical & Disability Info';return true;"><FONT COLOR="#000000" >Pusat Kesihatan Pelajar</FONT></A></li>
	<%	} %>
        </ul>
      </div>
    </li>
  </ul>

    <!-- end flexmenu2 - Staff Management-->
	
    <!-- flexmenu3 - Student Management -->
    <ul id="flexmenu3" class="flexdropdownmenu">
        <div align="left">
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
      <!-- CENFAD -->
      <li><A HREF="javascript:void(window.open('cmsformlink.jsp?form=ekaunseling','ME'))" onMouseOver="window.status='eKaunseling System';return true;"><FONT COLOR="#000000">eKaunseling 
        System</FONT></A></li>
      <!-- eaduan MPP -->
      <li><a href="eaduan_mpp.jsp?action=eaduan_mppListHEPA" onMouseOver="window.status='e-Aduan MPP';return true;"><FONT COLOR="#000000">e-Aduan 
        MPP</FONT></A></li>
    </DIV>
	</ul>
	
    <!-- end flexmenu3 - Student Management -->
	
	
	<!-- flexmenu 4 - Financial Management -->
	    <ul id="flexmenu4" class="flexdropdownmenu">
        <div align="left">
		<!-- -Financial Info -->
		<li><A HREF="payslip.jsp"  onMouseOver="window.status='Account Management';return true;"><FONT COLOR="#000000" >Financial Info</FONT></A></li>
		<!-- -Procument -->
			 <li> <A HREF="javascript:void(window.open('cmsformlink.jsp?form=eprocurement','ME'))"  onMouseOver="window.status='Account Management';return true;"><FONT COLOR="#000000" >eNotice</FONT></A></li>
		<!-- eTicketing -->
      			  <li><A HREF="eTicketing.jsp"  onMouseOver="window.status='eTicketing';return true;"><FONT COLOR="#000000" >eTicketing</FONT></A></li>
	    <!-- -Loan Management -->       
         			  <li><A HREF="loanMgmt.jsp"  onMouseOver="window.status='Loan Management';return true;"><FONT COLOR="#000000" >Loan Management</FONT></A></li>
			<!-- Petty cash -->        
           			  <li><A HREF="pettycash.jsp"  onMouseOver="window.status='Petty Cash Claim';return true;"><FONT COLOR="#000000" >Petty Cash Claim</FONT></A></li>
		<!-- Budget Virement -->       
        			  <li><A HREF="budgetVirement.jsp?action=list"  onMouseOver="window.status='Petty Cash Claim';return true;"><FONT COLOR="#000000" >Budget Virement </FONT></A></li>
				</div>
		</ul>
		<!-- end flexmenu4 -->

		<!-- flexmenu 5 - Research Management -->
	    <ul id="flexmenu5" class="flexdropdownmenu">
        <div align="left">
        <!-- Personal -->
  <li><a href="cms/smpu/index4.jsp" target="blank" onMouseOver="window.status='Personal';return true;"><FONT COLOR="#000000">Personal</FONT></A></li>
	<% if (cmsStaffValidator.isAuthorized(staffID,"RESCADM003","1.00")) { %>
	<li><A HREF="cms/smpu/index.jsp"  target="blank" onMouseOver="window.status='Super Admin';return true;"><FONT COLOR="#000000" >Super Admin</FONT></A></li>
    <% } %>
	<% if (cmsStaffValidator.isAuthorized(staffID,"RESCADM006","1.00") ) { %>
	<li>	<A HREF="cms/smpu/index5.jsp"  target="blank" onMouseOver="window.status='Admin';return true;"><FONT COLOR="#000000" >Admin</FONT></A></li>
    <% } %>
    <% if (cmsStaffValidator.isAuthorized(staffID,"RESCADM005","1.00") ) { %>
	<li><A HREF="cms/smpu/index.jsp"  target="blank" onMouseOver="window.status='Administrator';return true;"><FONT COLOR="#000000" >Administrator</FONT></A></li>
    <% } %>
</div>
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
