<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ include file="/includes/import.jsp" %>
<jsp:useBean id="ot" class="cms.staff.OvertimeBean" scope="request" />
<jsp:useBean class="cms.staff.StaffValidator" id="cmsStaffValidator" scope="page"/>


<%	//Connection...
	Connection conn = null;
		
	String []refid = request.getParameterValues("refid");
	String sid= (String)session.getAttribute("staffid");
	String dept= (String)session.getAttribute("deptcode");
	String action = request.getParameter("action");
	String nama_training = request.getParameter("nama_training");
	String level = request.getParameter("level");
	String keyword = request.getParameter("keyword");
	String current_year = request.getParameter("current_year");
	
	if (nama_training == null)
		nama_training = "";
	else if (nama_training.equals("null"))
		nama_training = "";
	else
		nama_training = nama_training;

	if (keyword == null)
		keyword = "";
	else if (keyword.equals("null"))
		keyword = "";
	else
		keyword = keyword;

	if (level == null)
		level = "staff";
	else if (level.equals("null"))
		level = "staff";
	else
		level = level;


  	String sqlchk="";
   	String cntt="";
   	int cntInt=0;

   //PAGING VARIABLE
   	int totalRec=0;
	int start=1,pageSum=0,pageNo=1;
   	int limit = 25; //set default displayed record per page
	
   if (request.getParameter("start") != null)
     start = Integer.parseInt(request.getParameter("start"));

 try
	{
		Context initCtx = new InitialContext();
		Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
		DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
		conn = ds.getConnection();

        ot.setDBConnection (conn);
		boolean otRecommender = ot.approverRecommenderId2(sid);


	}
	catch( Exception e )
	{ 
		out.println (e.toString()); 
	}
%>
<%
if (conn!=null)
	{
	// Get current date
	String sql = null;
	
		sql = "SELECT (TO_CHAR(SYSDATE,'YYYY')) FROM DUAL";
	
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			current_year = rset.getString (1);
			}
		pstmt.close ();
		}
	catch (SQLException e)
		{ out.println ("Error : " + e.toString ()); }
	}
%>

<html>
<head>
<SCRIPT TYPE="text/javascript">
<!--
/*function popup(staffAttendance.jsp?action=attendance_report, windowname)
{
if (! window.focus)return true;
var href;
if (typeof(staffAttendance.jsp?action=attendance_report) == 'string')
   href=staffAttendance.jsp?action=attendance_report;
else
   href=staffAttendance.jsp?action=attendance_report.href;
window.open(href, windowname, 'width=400,height=500,scrollbars=yes');
return false;
}*/

var windowDoPop

function go(whichURL) {
    windowDoPop=window.open(whichURL[whichURL.selectedIndex].value,'doPop','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=200,height=200');
    windowDoPop.focus();
}

//-->
</SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
.style1 {font-weight: bold}
.style2 {
	color: #FF0000;
	font-weight: bold;
}
-->
</style>
</head>
<body>

<jsp:useBean id="stream" scope="page" class="common.CommonFunction"/>
<!----------------------------------------------------------->

 <%@include file="include/date.jsp"%>
 <span class="style2">Perhatian: Sistem EAS ini dalam proses penambahbaikan. Harap maklum.</span><br>
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="3" bgcolor="#CCCCCC">
  <tr valign="top" bgcolor="#EEEEEE" class="smallbold"> 
    <td width="3%" class="contentStrapColor"><div align="center"><strong>No</strong></div></td>
    <td width="27%" class="contentStrapColor"><div align="center"><strong>Application 
        Name </strong></div></td>
    <td width="22%" class="contentStrapColor"><div align="center"><strong>Sub 
        Application</strong></div></td>
    <td width="10%" class="contentStrapColor"><div align="center"><strong>Approve 
        Link </strong></div></td>
    <td width="13%" class="contentStrapColor"><div align="center"><strong>Waiting</strong></div></td>
    <td width="13%" class="contentStrapColor"><div align="center"><b>Report Link</b></div></td>
    <td width="12%" class="contentStrapColor"><div align="center"><b><img src="cms/EIS/images/graf.gif" width="15" height="15">Statistic</b></div></td>
  </tr>

  <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
    <td rowspan="3" class = "contentBgColor"><div align="center"><strong>1</strong></div></td>
    <td rowspan="3" class = "contentBgColor"><strong>Sistem Kehadiran Staf/<br>
      <em>Staff Attendance</em></strong></td>
    <td height="28" class = "contentBgColor"> <div align="center">Attendance</div></td>
    <td class = "contentBgColor"><div align="center">-</div></td>
    <td class = "contentBgColor"><div align="center">-</div></td>
    <td class = "contentBgColor"> <div align="center"> <a href="staffAttendance.jsp?action=attendance_report">Link</a> 
      </div></td>
    <td class = "contentBgColor"><div align="center">-</div></td>
  </tr>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
    <td height="25" class = "contentBgColor"><div align="center">Reason Approval</div></td>
    <td valign="middle" class = "contentBgColor">
<div align="center"><a href="staffAttendance.jsp?action=approveReason">Link</a></div></td>
    <td valign="middle" class = "contentBgColor"> 
      <div align="center"><strong> 
        <%@ include file="attendance_no.jsp" %>
        </strong></div></td>
    <td valign="middle" class = "contentBgColor">
<div align="center">-</div></td>
    <td valign="middle" class = "contentBgColor">
<div align="center"><img src="cms/EIS/images/graf.gif" width="15" height="15" border="0"> 
        <a href="EIS.jsp?action=main_graphatt">Graph</a></div></td>
  </tr>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
    <td height="25" class = "contentBgColor"> <div align="center">Time Off</div></td>
    <td class = "contentBgColor"><div align="center"><a href="timeoffApplication.jsp?action=approve_timeoff">Link</a></div></td>
    <td class = "contentBgColor"> <div align="center"><strong> 
        <%@ include file="timeoff_no.jsp" %>
        </strong></div></td>
    <td class = "contentBgColor"> <div align="center"><a href="timeoffApplication.jsp?action=query_surbodinate">Link</a></div></td>
    <td class = "contentBgColor"><div align="center"><img src="cms/EIS/images/graf.gif" width="15" height="15" border="0"> 
        <a href="EIS.jsp?action=main_graph_timeoff">Graph</a></div></td>
  </tr>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
    <td class = "contentBgColor style1"><div align="center">2 </div>
      <div align="center"></div></td>
    <td class = "contentBgColor"><strong>Sistem Cuti/ <em><br>
      Staff Leave</em></strong></td>
    <td valign="middle" class = "contentBgColor">
<div align="center">Leave</div></td>
    <td valign="middle" class = "contentBgColor">
<div align="center"><a href="leaveMain.jsp?action=approvelist">Link</a></div></td>
    <td valign="middle" class = "contentBgColor"> 
      <div align="center"><strong> 
        <%@ include file="leave_no.jsp" %>
        </strong></div></td>
    <td valign="middle" class = "contentBgColor">
<div align="center"><a href="EIS.jsp?action=report_leave">Link</a></div></td>
    <td valign="middle" class = "contentBgColor">
<div align="center"><img src="cms/EIS/images/graf.gif" width="15" height="15" border="0"><a href="EIS.jsp?action=main_graph_leave"></a> 
        <a href="EIS.jsp?action=main_graph_leave2">Graph</a> </div></td>
  </tr>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont">
    <td class = "contentBgColor">&nbsp;</td>
    <td class = "contentBgColor">&nbsp;</td>
    <td align="center" valign="middle" class = "contentBgColor">Cancel Leave</td>
    <td align="center" valign="middle" class = "contentBgColor"><a href="leaveMain.jsp?action=approvelist&module=cancel">Link</a></td>
    <td align="center" valign="middle" class = "contentBgColor"><%@ include file="Cancelleave_no.jsp" %></td>
    <td align="center" valign="middle" class = "contentBgColor">-</td>
    <td align="center" valign="middle" class = "contentBgColor">-</td>
  </tr>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont">
    <td class = "contentBgColor">&nbsp;</td>
    <td class = "contentBgColor">&nbsp;</td>
    <td valign="middle" class = "contentBgColor"><div align="center"> Overtime (Claim for Replacement Leave)</div></td>
    <td valign="middle" class = "contentBgColor"><div align="center"><a href="leaveMain.jsp?action=approvelist&module=overtime">Link</a></div></td>
    <td valign="middle" class = "contentBgColor"><div align="center"><%@ include file="OTleave_no.jsp" %></div></td>
    <td valign="middle" class = "contentBgColor"><div align="center">-</div></td>
    <td valign="middle" class = "contentBgColor"><div align="center">-</div></td>
  </tr>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
    <td class = "contentBgColor"><div align="center"><strong>3</strong></div></td>
    <td class = "contentBgColor"><strong>Sistem Arahan Kerja/<em><br>
      Staff Workorder</em></strong></td>
    <td valign="middle" class = "contentBgColor">
<div align="center">Workorder</div></td>
    <td valign="middle" class = "contentBgColor">
	
<!--- untuk workorder link --->
		
	<%
	String month2 = "";
	String wo_1	=  "SELECT DISTINCT TO_CHAR (WOH.WOH_ENTER_DATE,'MM/YYYY') WOH_ENTER_DATE, TO_CHAR (WOH.WOH_ENTER_DATE,'MONTH YYYY') "+
  							" FROM CMSADMIN.WORK_ORDER_HEAD WOH "+
							" WHERE WOH.WOH_STATUS  = 'ENTRY' "+
							" AND WOH.WOH_APPROVE_BY = ? "+
							" AND ROWNUM < 2 "+
 							" ORDER BY TO_DATE (WOH.WOH_ENTER_DATE,'MM/YYYY') DESC ";


	
	
	
	/*	"SELECT count(SAH_REF_ID) "+
						"FROM STAFF_ATTENDANCE_HEAD,STAFF_MAIN "+
						"WHERE SAH_STAFF_ID = SM_STAFF_ID AND SAH_STATUS='APPLY' "+
						"AND SAH_STAFF_ID IN "+
						"(SELECT SH_STAFF_ID FROM STAFF_HIERARCHY WHERE SH_SYS_ID = 'ADM_AL' "+
						"AND SH_REPORT_TO = '"+sid+"') "; */
	try {
		PreparedStatement pstmt = conn.prepareStatement(wo_1);
		pstmt.setString(1, sid);
		ResultSet rset = pstmt.executeQuery ();
		
		if (rset.next()) {
			month2 = rset.getString (1);
		}
		rset.close();
		pstmt.close ();
	}
	catch (SQLException e) {
		out.println ("Error SQL: " + e.toString ()); 
	}
%>
	
    

<div align="center"><a href="workorderMain.jsp?action=approve&month2=<%=month2%>">Link</a></div></td>
    <td valign="middle" class = "contentBgColor">
<div align="center"><strong> 
        <%@ include file="workorder_no.jsp" %>
        </strong></div></td>
    <td valign="middle" class = "contentBgColor"> 
      <!--- untuk workorder report --->
      <div align="center"><a href="workorderMain.jsp">Link</a></div></td>
    <td valign="middle" class = "contentBgColor">
<div align="center"><img src="cms/EIS/images/graf.gif" width="15" height="15" border="0"><a href="EIS.jsp?action=main_graph_wo"></a> 
        <a href="EIS.jsp?action=main_graph_wo3">Graph</a> </div></td>
  </tr>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
    <td class = "contentBgColor"><div align="center"><strong>4</strong></div></td>
    <td rowspan="2" class = "contentBgColor"><strong>Sistem Pengurusan Latihan /<br>
        <em>Training Management</em></strong></td>
    <td class = "contentBgColor"> <p align="center">    Staff Induction Course</p></td>
    <td valign="middle" class = "contentBgColor">
<div align="center"><a href="induction.jsp?action=approve">Link</a></div></td>
    <td valign="middle" class = "contentBgColor"> 
      <div align="center"><strong> 
        <%@ include file="induction_no.jsp" %>
        </strong></div></td>
    <td valign="middle" class = "contentBgColor">
<div align="center"><a href="EIS.jsp?action=report_induksi">Link</a></div></td>
    <td valign="middle" class = "contentBgColor">
<div align="center">-</div></td>
  </tr>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont">
    <td class = "contentBgColor">&nbsp;</td>
    <td valign="middle" class = "contentBgColor"><div align="center">Training</div></td>
    <td valign="middle" class = "contentBgColor"><div align="center">-</div></td>
    <td valign="middle" class = "contentBgColor"><div align="center">-</div></td>
    <td valign="middle" class = "contentBgColor"><div align="center">-</div></td>
    <td valign="middle" class = "contentBgColor"><div align="center">-</div></td>
  </tr>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont">
    <td class = "contentBgColor"><div align="center"><strong>5</strong></div></td>
    <td class = "contentBgColor"><strong>Sistem Penilaian Staf /<em><br>
Staff Assessment</em></strong></td>
    <td valign="middle" class = "contentBgColor"><div align="center">Pegawai Penilai Pertama (PPP) </div></td>
    <td valign="middle" class = "contentBgColor"><div align="center"><a href="staffAssessment.jsp?action=ppp">Link</a></div></td>
    <td valign="middle" class = "contentBgColor">
	
	<div align="center"> 
        <%@ include file="assessment_no2.jsp" %>
      </div></td>
    <td valign="middle" class = "contentBgColor"><div align="center">-</div></td>
    <td valign="middle" class = "contentBgColor"><div align="center">-</div></td>
  </tr>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
    <td class = "contentBgColor"><div align="center"></div></td>
    <td class = "contentBgColor">&nbsp;</td>
    <td valign="middle" class = "contentBgColor">
      <div align="center">Pegawai Penilai Kedua (PPK) </div></td>
    <td valign="middle" class = "contentBgColor">
<div align="center"><a href="staffAssessment.jsp?action=ppk">Link</a></div></td>
    <td valign="middle" class = "contentBgColor">
<div align="center"> 
        <%@ include file="assessment_no.jsp" %>
      </div></td>
    <td valign="middle" class = "contentBgColor">
<div align="center"><a href="EIS.jsp?action=result_assessment2">Link</a></div></td>
    <td valign="middle" class = "contentBgColor">
<div align="center"><img src="cms/EIS/images/graf.gif" width="15" height="15" border="0"> 
        <a href="EIS.jsp?action=main_graph_assessment">Graph</a></div></td>
  </tr>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
    <td rowspan="3" class = "contentBgColor"><div align="center"><strong>6</strong></div></td>
    <td rowspan="3" class = "contentBgColor"><strong>Sasaran Kerja Tahunan (SKT) 
      /<br>
      <em>Annual Target</em></strong></td>
    <td class = "contentBgColor"><div align="center">Bahagian I / Part I</div></td>
    <td class = "contentBgColor"><div align="center"><a href="sktnew.jsp?action=approvedbhg1">Link</a></div></td>
    <td class = "contentBgColor"><div align="center"><strong> 
        <%@ include file="skt1_no.jsp" %>
        </strong></div></td>
    <td class = "contentBgColor"><div align="center">-</div></td>
    <td class = "contentBgColor"><div align="center">-</div></td>
  </tr>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
    <td class = "contentBgColor"><div align="center">Bahagian II / Part II</div></td>
    <td class = "contentBgColor"><div align="center"><a href="sktnew.jsp?action=approvedbhg1">Link</a></div></td>
    <td class = "contentBgColor"><div align="center"><strong> 
        <%@ include file="skt2_no.jsp" %>
        </strong></div></td>
    <td class = "contentBgColor"><div align="center">-</div></td>
    <td class = "contentBgColor"><div align="center">-</div></td>
  </tr>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
    <td class = "contentBgColor"><div align="center">Bahagian III / Part III</div></td>
    <td class = "contentBgColor"><div align="center"><a href="sktnew.jsp?action=approvedbhg1">Link</a></div></td>
    <td class = "contentBgColor"><div align="center"><strong> 
        <%@ include file="skt3_no.jsp" %>
        </strong></div></td>
    <td class = "contentBgColor"><div align="center">-</div></td>
    <td class = "contentBgColor"><div align="center">-</div></td>
  </tr>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
    <td rowspan="2" class = "contentBgColor"><div align="center"><strong>7</strong></div></td>

<!--- due date ot---->
<%
    String claim_month = "";
    String due = "";
/*    String sqldue	= "SELECT HP_PARM_DESC FROM hradmin_parms "+
	                  "WHERE HP_PARM_CODE ='OT_CLAIM_DUE_DATE' ";
*/					  
					  
    String sqldue	= "SELECT TO_CHAR(OS.OS_CLAIM_MONTH, 'MM/YYYY'), TO_CHAR(OS.OS_CLAIM_DUE_DATE, 'DD/MM/YYYY') "+
					  "FROM CMSADMIN.OVERTIME_SETUP OS "+
					  "WHERE OS.OS_CLAIM_DUE_DATE = "+
					  "( "+
					  "SELECT MIN(OS.OS_CLAIM_DUE_DATE) "+
					  "FROM CMSADMIN.OVERTIME_SETUP OS "+
					  "WHERE OS.OS_CLAIM_DUE_DATE >= TRUNC(SYSDATE) "+
					  ")";
					  
					  
     try {
		PreparedStatement pstmt = conn.prepareStatement(sqldue);
		ResultSet rset = pstmt.executeQuery ();
		
		if (rset.next()) {
			claim_month = rset.getString (1);
			due = rset.getString (2);
		}
		rset.close();
		pstmt.close ();
	}
	catch (SQLException e) {
		out.println ("Error SQL: " + e.toString ()); 
	}
%>

    <td rowspan="2" class = "contentBgColor"><strong>Sistem Kerja Lebih Masa/<br>
      <em> Staff Overtime</em></strong></td>
    <td height="39" valign="middle" class = "contentBgColor"><table width="99%" border="0">
      <tr valign="top" bgcolor="#FFFFFF" class="contentBgColor">
        <td><div align="center"> Recommend</div></td>
      </tr>
      <tr valign="top" bgcolor="#FFFFFF" class="contentBgColor">
        <td><div align="center"><font color="#FF0000"><strong> Due Date : <%=due%></strong></font></div></td>
      </tr>
    </table></td>

    <td valign="middle" class = "contentBgColor">
 		<%

//	Connection conn=null;
	try
	{

    	cmsStaffValidator.setDBConnection(conn);
    	cmsStaffValidator.setStaffId(sid);
    	boolean staffHasSubordinate = cmsStaffValidator.hasSubordinate();
		boolean staffIsDirector = cmsStaffValidator.isDirector();


%>
 
        <div align="center">
     <% if(staffIsDirector == true || (ot.approverRecommenderId2(sid)) == true){%>
        <a href="overtime.jsp?action=recommend">Link</a>
        <% } else { %> - <% } %>
       </div>  
    </td>
    <td valign="middle" class = "contentBgColor"> 
      <div align="center"><strong> 
        <%@ include file="overtime_no.jsp" %>
        </strong></div></td>

    <td rowspan="2" valign="middle" class = "contentBgColor">
<div align="center"><a href="EIS.jsp?action=report_ot">Link</a></div></td>
    <td rowspan="2" valign="middle" class = "contentBgColor">
<div align="center"><img src="cms/EIS/images/graf.gif" width="15" height="15" border="0"> 
        <a href="EIS.jsp?action=main_graph_ot">Graph </a></div></td>

  </tr>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
    <td height="37" valign="middle" class = "contentBgColor"><table width="99%" border="0">
      <tr valign="top" bgcolor="#FFFFFF" class="contentBgColor">
        <td><div align="center">Verify</div></td>
      </tr>
      <tr valign="top" bgcolor="#FFFFFF" class="contentBgColor">
        <td><div align="center"><font color="#FF0000"><strong> Due Date : <%=due%></strong></font></div></td>
      </tr>
    </table></td>
    <td valign="middle" class = "contentBgColor"><div align="center">
 <%   
   if(staffHasSubordinate == true){%>
       <a href="overtime.jsp?action=verify">Link</a>
	<% } else { %> - <% } %></div></td>
    <td valign="middle" class = "contentBgColor">
<div align="center"><strong> 
        <%@ include file="overtime_no2.jsp" %>
        </strong></div></td>



<%

	}
	catch(Exception e)
	{
		System.out.println("Error (MenuBox.EIS):"+e);
	}
	//finally
	//{
		//conn.close();
	//}
		/*finally 
		{
		try 
			{
				if (conn != null) 
	  				conn.close();    // Close the connection no matter what
  			}
  		catch (Exception e) 
			{ }
		}*/

%>			

  </tr>

  <% 
	/*	} 
			}
			}
		else
			{
			
	}
	pstmt.close ();
	rset.close ();
	}
	catch(Exception e)
	{
		System.out.println(e);
	}

	}
	


conn.close();*/
%>

 <tr valign="top" bgcolor="#FFFFFF" class="smallfont">
   <td rowspan="2" class = "contentBgColor"><div align="center">8.</div></td>
   <td rowspan="2" class = "contentBgColor"><div align="left">
       <p><strong>Sistem Pengisytiharan Harta/<br>
             <em>Asset Declaration</em></strong></p>
   </div></td>
   <td class = "contentBgColor"><div align="center">Pengisytiharan</div></td>
   <td class = "contentBgColor"><div align="center">-</div></td>
   <td class = "contentBgColor"><div align="center">-</div></td>
   <td class = "contentBgColor"><div align="center">-</div></td>
   <td class = "contentBgColor"><div align="center">-</div></td>
  </tr>
 <tr valign="top" bgcolor="#FFFFFF" class="smallfont">
   <td class = "contentBgColor"><div align="center">Pelupusan</div></td>
   <td class = "contentBgColor"><div align="center">-</div></td>
   <td class = "contentBgColor"><div align="center">-</div></td>
   <td class = "contentBgColor"><div align="center">-</div></td>
   <td class = "contentBgColor"><div align="center">-</div></td>
 </tr>
 <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
    <td class = "contentBgColor">&nbsp;</td>
    <td class = "contentBgColor">&nbsp;</td>
    <td class = "contentBgColor">&nbsp;</td>
    <td class = "contentBgColor">&nbsp;</td>
    <td class = "contentBgColor">&nbsp;</td>
    <td class = "contentBgColor">&nbsp;</td>
    <td class = "contentBgColor">&nbsp;</td>
  </tr>
  <tr valign="bottom" class='contentBgColor'> 
    <td height="30" colspan="9"><br> <!--<table width="100%" border="0">
        <tr> 
          <td><img src="cms/EIS/images/announce.gif" width="32" height="32"></td>
          <td><strong><span class="style3">Pengumuman/<em>Announcement:</em></span></strong></td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
          <td>-</td>
        </tr>
        <tr> 
          <td width="3%"><strong><img src="cms/EIS/images/acess.gif" width="32" height="32"></strong></td>
          <td width="97%"><strong><span class="style3">Navigasi/<em>Navigation</em>:</span></strong></td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
          <td><span class="style3"><strong><img src="cms/EIS/images/indent1.png" width="20" height="10"></strong><a href="http://www.ump.edu.my/ump/pekeliling/index.htm" target="_blank">Portal 
            Pekeliling/Polisi/Garis Panduan/Prosedur</a></span></td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
          <td><a href="http://www.ump.edu.my/ump/ispumpx/" target="_blank"><strong><img src="cms/EIS/images/indent1.png" width="20" height="10" border="0"></strong><span class="style3">Pelan 
            Strategik &amp; Pelan Tindakan UMP 2008-2010 </span></a></td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
      </table>-->
      <br>
      Contact us: <br> <br>
      Bahagian Aplikasi &amp; Pembangunan Sistem<br>
      Pusat Teknologi Maklumat &amp; Komunikasi<br>
      Universiti Malaysia Pahang<br>
      Tel: 09-5492177 (Helpdesk) </td>
  </tr>
</table>

<!----------------------------------------------------------->


<%//}
		try {
			if (conn != null) conn.close();
		}
		catch (Exception e) {  }

  %>
<p>&nbsp;</p>

</body>
</html>
