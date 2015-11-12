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


<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
.style1 {color: #0033FF}
.style3 {font-size: 10px}
-->
</style>
</head>
<body>
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
<TABLE WIDTH="102%" BORDER="0" CELLSPACING="1" CELLPADDING="3" bgcolor="#CCCCCC">
  <tr valign="top" bgcolor="#EEEEEE" class="smallbold"> 
    <td width="4%" class="contentStrapColor"><div align="center"><strong>No</strong></div></td>
    <td width="23%" class="contentStrapColor"><div align="center"><strong>Type 
        of Report</strong></div></td>
    <td width="17%" class="contentStrapColor"><div align="center"><strong>Sub 
        of Report</strong></div></td>
    <td width="15%" class="contentStrapColor"><div align="center"><strong>Approve</strong></div></td>
    <td width="18%" class="contentStrapColor"><div align="center"><b>Report</b></div></td>
    <td width="23%" class="contentStrapColor"><div align="center"><b>Graph</b></div></td>
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
    <td rowspan="2" class = "contentBgColor">Staff Attendance</td>
    <td height="75" class = "contentBgColor"> 
      <div align="center">Attendance</div></td>
    <td class = "contentBgColor"><div align="center">-</div></td>
    <td class = "contentBgColor"> <div align="center"><a href="staffAttendance.jsp?action=attendance_report"> 
        View</a> 
        <form>
          <select name="SelectURL" size="1">
            <option value="http://www.codelifter.com/main/javascript/slide1_1.html">Picture 
            One</option>
            <option value="http://www.codelifter.com/main/javascript/slide1_2.html">Picture 
            Two</option>
            <option value="http://www.codelifter.com/main/javascript/slide1_3.html">Picture 
            Three</option>
            <option value="http://www.codelifter.com/main/javascript/slide1_4.html">Picture 
            Four</option>
            <option value="http://www.codelifter.com/main/javascript/slide1_5.html">Picture 
            Five</option>
          </select>
          <input name="button" type="button" onClick="go(this.form.SelectURL.options)" value="go">
        </form>
        <p></p>
</div></td>
    <td rowspan="2" class = "contentBgColor"><p>&nbsp; 
    
      </td>
  </tr>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
    <td height="32" class = "contentBgColor"> 
      <div align="center">Time Off</div></td>
    <td class = "contentBgColor"><div align="center"><a href="timeoffApplication.jsp?action=approve_timeoff">Link</a></div></td>
    <td class = "contentBgColor"><div align="center"><a href="timeoffApplication.jsp?action=report_detl_indv">View</a></div></td>
  </tr>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
    <td class = "contentBgColor"><div align="center">2 </div>
      <div align="center"></div></td>
    <td class = "contentBgColor">Staff Leave</td>
    <td class = "contentBgColor">&nbsp;</td>
    <td class = "contentBgColor"><div align="center"><a href="leaveMain.jsp?action=approvelist">Link</a></div></td>
    <td class = "contentBgColor"><select name="bulan" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;">
        <!---<option value="">...</option>--->
        <%
	if (conn!=null)
	{
/*		String sql	= "SELECT DISTINCT TO_CHAR (WOH_DATE_FROM,'MON YYYY'),TO_CHAR (WOH_DATE_FROM,'YYYY') "+
                      "FROM WORK_ORDER_HEAD,WORK_ORDER_DETL "+
				  	  "WHERE WOD_WORKORDER_ID = WOH_WORKORDER_ID "+
				      "AND WOD_STAFF_ID = ?  " +
				    //"AND WOH_STATUS = '"+status+"' "+
			 	      "ORDER BY TO_DATE (WOH_DATE_FROM,'MM/YYYY') DESC ";
*/
		String sql	= "SELECT DISTINCT TO_CHAR (WOH_DATE_FROM,'MON YYYY') WOH_DATE_FROM, TO_CHAR (WOH_DATE_FROM,'MONTH YYYY') " +
                      "FROM WORK_ORDER_HEAD,WORK_ORDER_DETL " +
				      "WHERE WOD_WORKORDER_ID = WOH_WORKORDER_ID " +
				      "AND WOD_STAFF_ID = ?  " +
				    //"AND WOH_STATUS = '"+status+"' " +
			 	      "ORDER BY TO_DATE (WOH_DATE_FROM,'MON YYYY') DESC ";

		try
		{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString (1, session.getAttribute("staffid").toString());
			ResultSet rset = pstmt.executeQuery ();
			while (rset.next ())
			{
				if (request.getParameter("bulan")!=null && request.getParameter("bulan").compareTo(rset.getString(1))==0)
				{ 
%>
        <option value="<%=rset.getString(1)%>" selected><%=rset.getString(2)%></option>
        <% 
				}
				else
				{
%>
        <option value="<%=rset.getString(1)%>"><%=rset.getString(2)%></option>
        <% 
				}
			}
			rset.close ();
			pstmt.close ();
		}
		catch( Exception e )
		{ out.println ("Error during retrieving month : " + e.toString()); }
	}
%>
      </select>
      &nbsp; 
      <!---        
		<B>Status</B> : 
		<select name="status" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;">
			<option value="" selected>...</option>
			<option value="APPROVE">APPROVED</option>
			<option value="ENTRY">APPLY</option>
        </select>&nbsp;
---->
      <input name="Go" type="submit" id="Go" value="Go"></td>
    <td class = "contentBgColor">&nbsp;</td>
  </tr>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
    <td class = "contentBgColor"><div align="center">3</div></td>
    <td class = "contentBgColor">Staff Overtime</td>
    <td class = "contentBgColor">&nbsp;</td>
    <td class = "contentBgColor"><div align="center"><a href="EIS.jsp?action=main_linkB4">Link</a></div></td>
    <td class = "contentBgColor">&nbsp;</td>
    <td class = "contentBgColor">&nbsp;</td>
  </tr>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
    <td class = "contentBgColor"><div align="center">4</div></td>
    <td class = "contentBgColor">Staff Workorder</td>
    <td class = "contentBgColor">&nbsp;</td>
    <td class = "contentBgColor"> <div align="center"><a href="workorderMain.jsp?action=approve"> 
        Link</a></div></td>
    <td class = "contentBgColor">&nbsp;</td>
    <td class = "contentBgColor">&nbsp; </td>
  </tr>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
    <td class = "contentBgColor"><div align="center">5</div></td>
    <td class = "contentBgColor">Induction Course</td>
    <td class = "contentBgColor">&nbsp;</td>
    <td class = "contentBgColor"> <div align="center"><a href="induction.jsp?action=approve">Link</a></div></td>
    <td class = "contentBgColor">&nbsp;</td>
    <td class = "contentBgColor">&nbsp; </td>
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
    <td height="30" colspan="8">No Record Available </td>
  </tr>
  <tr valign="bottom" class='contentBgColor'> 
    <td height="30" colspan="8">&nbsp;</td>
  </tr>
</table>

<!----------------------------------------------------------->


<%} conn.close(); %>
<p>&nbsp;</p>

</body>
</html>
