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
    windowDoPop=window.open(whichURL[whichURL.selectedIndex].value,'doPop','toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=no,width=1200,height=800');
    windowDoPop.focus();
}

//-->
</SCRIPT>
</head>
<body>
<%
if (conn!=null)
{	 		
		int classCountt=0; //paging variable
		sqlchk =  "SELECT count(*) as cnt"+ //count(distinct set_staff_id ) "+
                           " FROM staff_main,department_main,service_scheme,users, staff_hierarchy "+
                           " where rownum<15 and (SM_STAFF_NAME like UPPER('%"+keyword+"%') or SM_STAFF_NAME like '%"+keyword+"%')  "+
                           " AND SM_DEPT_CODE=DM_DEPT_CODE "+
                           " AND SM_JOB_CODE=SS_SERVICE_CODE  "+
                           " AND SM_STAFF_STATUS='ACTIVE' AND SM_STAFF_TYPE='STAFF' "+
                           " AND SM_APPS_USERNAME= USERNAME "+
						   " and sh_staff_id=sm_staff_id and sh_report_to='"+sid+"'";
		try
		{
			PreparedStatement pstmtchk = conn.prepareStatement(sqlchk);
			ResultSet rsetchk = pstmtchk.executeQuery ();
			while (rsetchk.next())
			{
							cntt=rsetchk.getString("cnt");
							cntInt=Integer.parseInt(cntt);
							totalRec=Integer.parseInt(cntt);
	  	    }
			rsetchk.close();
			pstmtchk.close();
	    }

     catch (SQLException e)
     { out.println ("Error! : " + e.toString ()); }
}
     %>
<%
//________________________________________________training____________________________________________
/*if (level.equals("training"))
{
if ( conn!=null )
	{
    int classCount=0;
	if (cntInt>1)
	{	
	
		String sql	=	" SELECT DISTINCT SET_REF_ID, upper(SET_TRAINING_NAME), SET_TRAINING_VENUE, SET_TRAINING_ORGANIZER, "+
						" TO_CHAR(SET_DATE_FROM, 'DD-MON-YYYY'), TO_CHAR(SET_DATE_TO, 'DD-MON-YYYY'),  SM_DEPT_CODE, TO_DATE(SET_DATE_FROM, 'DD-MM-YYYY') sdf "+
						" FROM STAFF_EXTERNAL_TRAINING, staff_main, staff_hierarchy "+
						" WHERE set_staff_id=sm_staff_id and  SET_STATUS ='INSERT' AND SM_DEPT_CODE = '"+dept+"'"+
						" and (SET_TRAINING_NAME like UPPER('%"+keyword+"%') or SET_TRAINING_VENUE like '%"+keyword+"%')  "+
						" and TO_DATE(sysdate, 'DD-MM-YYYY') <= TO_DATE(SET_DATE_FROM, 'DD-MM-YYYY') "+
						" and sh_staff_id=set_staff_id and sh_report_to='"+sid+"'"+
						" GROUP BY SET_DATE_FROm , SET_TRAINING_NAME, SET_TRAINING_VENUE, SET_TRAINING_ORGANIZER, SET_REF_ID,  "+
						"  SET_DATE_TO,  SM_DEPT_CODE  order by sdf asc ";
	try
		{
		PreparedStatement pstmt=conn.prepareStatement(sql);
		ResultSet rset=pstmt.executeQuery();
		//if(rset.isBeforeFirst()){
		int a=start;
		%>
<!----------------------------------------------------------->
<%
}
else*/
if (level.equals("staff"))
{
if ( conn!=null )
	{
    int classCount=0;
	if (cntInt>1)
	{	
	
		String sql_i	=	" SELECT sm_staff_name,UPPER(ss_service_desc), "+
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
		PreparedStatement pstmt=conn.prepareStatement(sql_i);
		ResultSet rset=pstmt.executeQuery();
		//if(rset.isBeforeFirst()){
		int a=start;
		%>
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="3" bgcolor="#CCCCCC">
  <tr valign="top" bgcolor="#EEEEEE" class="smallbold"> 
    <td colspan="6" class="contentStrapColor"><strong>STAFF ATTENDANCE</strong></td>
  </tr>
  <tr valign="top" bgcolor="#EEEEEE" class="smallbold"> 
    <td width="7%" class="contentStrapColor"><div align="center"><strong>Bil</strong></div></td>
    <td width="10%" class="contentStrapColor"><div align="center"><strong>Staff 
        ID</strong></div></td>
    <td width="18%" class="contentStrapColor"><div align="center"><b>Staff's Name</b></div></td>
    <td width="14%" class="contentStrapColor"><div align="center"><b>Position</b></div></td>
    <td width="28%" class="contentStrapColor"><div align="center"><b>Department 
        </b></div></td>
    <td width="23%" align=center class="contentStrapColor"><div align="center"></div></td>
  </tr>
  <%
	  if (rset.isBeforeFirst ()) 
	  {
		while (rset.next())
			{
			classCount++;          			
							if (classCount >= start && classCount < start+limit){
            %>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
    <td class = "contentBgColor"><%=rset.getRow()%></td>
    <td class = "contentBgColor"><%=( ( rset.getString(8) ==null)?"-":rset.getString(8) )%></td>
    <td class = "contentBgColor"><%=( ( rset.getString(1) ==null)?"-":rset.getString(1) )%> 
    </td>
    <td class = "contentBgColor"><%=( ( rset.getString(2) ==null)?"-":rset.getString(2) )%></td>
    <td class = "contentBgColor"><%=( ( rset.getString(3) ==null)?"-":rset.getString(3) )%></td>
    <td class = "contentBgColor"><div align="center">
        <form>
             <%
if (conn!=null)
	{
	String sql = "SELECT DISTINCT TO_CHAR(SAH_DATE,'MM/YYYY') SAH_DATE,TO_CHAR(SAH_DATE,'MONTH YYYY'), "+
				" TO_CHAR(SAH_DATE,'YYYY') as a,TO_CHAR(SAH_DATE,'MM') as b  "+
	              "FROM STAFF_ATTENDANCE_HEAD " +
				 "WHERE sah_staff_id = '"+rset.getString(8)+"' " +
				" AND exists " +
				 "(select 1 from staff_hierarchy " +
				"where sah_staff_id = sh_staff_id " +
				"and sh_sys_id = 'ADM_AL') " ;
				//"and SH_REPORT_TO= ? ) " +
//				"order by a desc, b desc  ";
				%>
          <%//=sql%>
          <%
		   	try
		{
		PreparedStatement pstmt1=conn.prepareStatement(sql);
		ResultSet rset1=pstmt1.executeQuery();
%>
          <select name="month" >
            <%		while (rset1.next ())
			{
			//if (rset.isFirst())
			//month = rset.getString(1);
%>
            <option value="staffAttendance.jsp?action=attendance_report&month=<%=rset1.getString(1)%>"><%=rset1.getString(2)%></option>
            <%
			}
%>
          </select>
          <%
		rset1.close ();
		pstmt1.close ();
		}
	catch (SQLException e)
		{ out.println ("Error! : " + e.toString ()); }
	}
%>
          <input type="hidden" name="subordinate" value="<%=rset.getString(8)%>" />
          <input name="button" type="button" onClick="go(this.form.month.options)" value="go">
          </a> 
        </form>
      
  </tr>
  <% 
		} 
			}
			}
		else
			{ %>
  <tr class='contentBgColor'> 
    <td colspan="6" valign="middle"> No Record Available </td>
  </tr>
  <%
	}
	pstmt.close ();
	rset.close ();
	}
	catch(Exception e)
	{
		System.out.println(e);
	}

	}
	}


conn.close();
%>
  <tr valign="bottom" class='contentBgColor'> 
    <td height="30" colspan="8"> 
    </td>
  </tr>
</table>

<!----------------------------------------------------------->


<%} conn.close(); %>
<p>&nbsp;</p>

</body>
</html>
