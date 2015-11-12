<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ include file="/includes/import.jsp" %>


<%	//Connection...
	Connection conn = null;
		
	String []refid = request.getParameterValues("refid");
	String sid= (String)session.getAttribute("staffid");
	String dept= (String)session.getAttribute("deptcode");
	String action = request.getParameter("action");
	String nama_training = request.getParameter("nama_training");
	String level = request.getParameter("level");
	String keyword = request.getParameter("keyword");
	
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
		
	}
	catch( Exception e )
	{ 
		out.println (e.toString()); 
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
.style1 {color: #0033FF}
.style3 {font-size: 10px}
-->
</style>

</head>
<body>

<jsp:useBean id="stream" scope="page" class="common.CommonFunction"/>
<!----------------------------------------------------------->
<%
if ( conn!=null )
	{
 /*   int classCount=0;
	if (cntInt>1)
	{	
	
		String sql	=	" SELECT sm_staff_name,UPPER(ss_service_desc), "+
                           " UPPER(DM_DEPT_DESC),SM_TELNO_WORK,SM_HANDPHONE_NO, "+
                           " USERID,LOWER(SM_EMAIL_ADDR),sm_staff_id "+
                           " FROM staff_main,department_main,service_scheme,users, staff_hierarchy "+
                           " where rownum<15 and (SM_STAFF_NAME like UPPER('%"+keyword+"%') or SM_STAFF_NAME like '%"+keyword+"%')  "+
                           " AND SM_DEPT_CODE=DM_DEPT_CODE "+
                           " AND SM_JOB_CODE=SS_SERVICE_CODE  "+
                           " AND SM_STAFF_STATUS='ACTIVE' AND SM_STAFF_TYPE='STAFF' "+
                           " AND SM_APPS_USERNAME= USERNAME "+
						   " and sh_staff_id=sm_staff_id and sh_report_to='"+sid+"'"+
                           " ORDER by SM_STAFF_NAME asc,UPPER(ss_service_desc) ";
	try
		{
		PreparedStatement pstmt=conn.prepareStatement(sql);
		ResultSet rset=pstmt.executeQuery();
		//if(rset.isBeforeFirst()){
		int a=start;*/
		%>
		
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="3" bgcolor="#CCCCCC">
  <tr valign="top" bgcolor="#EEEEEE" class="smallbold"> 
    <td width="4%" class="contentStrapColor"><div align="center"><strong>No</strong></div></td>
    <td width="25%" class="contentStrapColor"><div align="center"><strong>Type 
        of Report</strong></div></td>
    <td width="21%" class="contentStrapColor"><div align="center"><strong>Sub 
        of Approval Report</strong></div></td>
    <td width="16%" class="contentStrapColor"><div align="center"><strong>Approve 
        Link </strong></div></td>
    <td width="18%" class="contentStrapColor"><div align="center"><b>Report Link</b></div></td>
    <td width="16%" class="contentStrapColor"><div align="center"><b><img src="cms/EIS/images/graf.gif" width="15" height="15">Statistic</b></div></td>
  </tr>
  <%
/*	  if (rset.isBeforeFirst ()) 
	  {
		while (rset.next())
			{
			classCount++;          			
							if (classCount >= start && classCount < start+limit){*/
            %>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
    <td rowspan="2" class = "contentBgColor"><div align="center">1</div></td>
    <td rowspan="2" class = "contentBgColor">Sistem Kehadiran Staf/<br> <em>Staff 
      Attendance</em></td>
    <td height="28" class = "contentBgColor"> <div align="center">Reason Approval</div></td>
    <td class = "contentBgColor"><div align="center"><a href="staffAttendance.jsp?action=approveReason">Link</a> 
        <img src="cms/EIS/images/arrowup.gif" width="15" height="15" border="0"> 
        - </div></td>
    <td class = "contentBgColor"> <div align="center"> <a href="staffAttendance.jsp?action=attendance_report">Link</a> 
      </div></td>
    <td class = "contentBgColor"><div align="center"><img src="cms/EIS/images/graf.gif" width="15" height="15" border="0"> 
        <a href="EIS.jsp?action=main_graphatt">Graph</a></div></td>
  </tr>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
    <td height="25" class = "contentBgColor"> <div align="center">Time Off</div></td>
    <td class = "contentBgColor"><div align="center"><a href="timeoffApplication.jsp?action=approve_timeoff">Link</a> 
        <img src="cms/EIS/images/arrowup.gif" width="15" height="15" border="0"> 
        - </div></td>
    <td class = "contentBgColor"> <div align="center"><a href="timeoffApplication.jsp?action=query_surbodinate">Link</a></div></td>
    <td class = "contentBgColor"><div align="center"><img src="cms/EIS/images/graf.gif" width="15" height="15" border="0"> 
        <a href="EIS.jsp?action=main_graph_timeoff">Graph</a></div></td>
  </tr>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
    <td class = "contentBgColor"><div align="center">2 </div>
      <div align="center"></div></td>
    <td class = "contentBgColor">Sistem Cuti/ <em><br>
      Staff Leave</em></td>
    <td class = "contentBgColor"><div align="center">Leave</div></td>
    <td class = "contentBgColor"><div align="center"><a href="leaveMain.jsp?action=approvelist">Link</a> 
        <img src="cms/EIS/images/arrowup.gif" width="15" height="15" border="0"> 
        - </div></td>
    <td class = "contentBgColor"><div align="center"><a href="EIS.jsp?action=report_leave">Link</a></div></td>
    <td class = "contentBgColor"><div align="center"><img src="cms/EIS/images/graf.gif" width="15" height="15" border="0"><a href="EIS.jsp?action=main_graph_leave"></a> 
        <a href="EIS.jsp?action=main_graph_leave2">Graph</a> </div></td>
  </tr>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
    <td class = "contentBgColor"><div align="center">3</div></td>
    <td class = "contentBgColor">Sistem Arahan Kerja/<em><br>
      Staff Workorder</em></td>
    <td class = "contentBgColor"><div align="center">Workorder</div></td>
    <td class = "contentBgColor"><div align="center"><a href="workorderMain.jsp?action=approve">Link</a> 
        <img src="cms/EIS/images/arrowup.gif" width="15" height="15" border="0"> 
        - </div></td>
    <td class = "contentBgColor"><div align="center"><a href="workorderMain.jsp">Link</a></div></td>
    <td class = "contentBgColor"><div align="center"><img src="cms/EIS/images/graf.gif" width="15" height="15" border="0"><a href="EIS.jsp?action=main_graph_wo"></a> 
        <a href="EIS.jsp?action=main_graph_wo3">Graph</a> </div></td>
  </tr>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
    <td class = "contentBgColor"><div align="center">4</div></td>
    <td class = "contentBgColor">Sistem Kursus Induksi/<br> <em> Staff Induction 
      Course</em></td>
    <td class = "contentBgColor"> <p align="center">Induction Course</p></td>
    <td class = "contentBgColor"><div align="center"><a href="induction.jsp?action=approve">Link</a> 
        <img src="cms/EIS/images/arrowup.gif" width="15" height="15" border="0"> 
        - </div></td>
    <td class = "contentBgColor"><div align="center"><a href="EIS.jsp?action=report_induksi">Link</a></div></td>
    <td class = "contentBgColor"><div align="center">-</div></td>
  </tr>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
    <td class = "contentBgColor"><div align="center">5</div></td>
    <td class = "contentBgColor">Sistem Penilaian Staf /<em><br>
      Staff Assessment</em></td>
    <td class = "contentBgColor"><div align="center">Assessment</div></td>
    <td class = "contentBgColor"><div align="center"><a href="EIS.jsp?action=approve_ptk">Link</a> 
        <img src="cms/EIS/images/arrowup.gif" width="15" height="15" border="0"> 
        - </div></td>
    <td class = "contentBgColor"><div align="center"><a href="EIS.jsp?action=result_assessment2">Link</a></div></td>
    <td class = "contentBgColor"><div align="center"><img src="cms/EIS/images/graf.gif" width="15" height="15" border="0"> 
        <a href="EIS.jsp?action=main_graph_assessment">Graph</a></div></td>
  </tr>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
    <td class = "contentBgColor"><div align="center">6</div></td>
    <td class = "contentBgColor">Sasaran Kerja Tahunan (SKT)<br>
      / <em>Annual Target</em></td>
    <td class = "contentBgColor"><div align="center">Bahagian I,II, III</div></td>
    <td class = "contentBgColor"><div align="center"><a href="sktnew.jsp?action=approvedbhg1">Link</a> 
        <img src="cms/EIS/images/arrowup.gif" width="15" height="15" border="0"> 
        -</div></td>
    <td class = "contentBgColor"><div align="center">-</div></td>
    <td class = "contentBgColor"><div align="center">-</div></td>
  </tr>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
    <td class = "contentBgColor"><div align="center">7</div></td>
    <td class = "contentBgColor">Sistem Kerja Lebih Masa/<br> <em> Staff Overtime</em></td>
    <td class = "contentBgColor"><div align="center">Overtime</div></td>
    <td class = "contentBgColor"><div align="center"><a href="overtime.jsp?action=verify">Link</a> 
        <img src="cms/EIS/images/arrowup.gif" width="15" height="15" border="0"> 
      </div></td>
    <td class = "contentBgColor"><div align="center"><a href="EIS.jsp?action=report_ot">Link</a></div></td>
    <td class = "contentBgColor"><div align="center"><img src="cms/EIS/images/graf.gif" width="15" height="15" border="0"> 
        <a href="EIS.jsp?action=main_graph_ot">Graph </a></div></td>
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
  <tr valign="bottom" class='contentBgColor'> 
    <td height="30" colspan="8">&nbsp;</td>
  </tr>
</table>

<!----------------------------------------------------------->


<%} conn.close(); %>
<p>&nbsp;</p>

</body>
</html>
