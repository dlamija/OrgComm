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
	String keyword = request.getParameter("keyword");
	String test = request.getParameter("test");
	
	if (keyword == null)
		keyword = "";
	else if (keyword.equals("null"))
		keyword = "";
	else
		keyword = keyword;

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

<!--------------------------result display here------------------------>
<form action="EIS.jsp?action=main" method="post" name="form2">
<TABLE width="100%" border=0 CELLPADDING="3" CELLSPACING="1">
	<TR>
	    <TD class = "contentStrapColor" align="left" colspan="2"> <strong>Search </strong></TD>
	</TR>
	<TR>
	  <TD class = "contentBgColor" align="center"><b> Staff Name </b></TD>
	  <TD class = "contentBgColor" >
	  	<input name="keyword" type="text" id="keyword" size="50" >
      	<input type="submit" name="button" value="Search" bgcolor='#B9E7FF' style="font-family: Verdana, sans-serif; font-size: 11px;  8px; ">
		</TD>
    </TR>
</table>
</form>

<%
if ( conn!=null )
	{
		String sql	=	" SELECT sm_staff_name,UPPER(ss_service_desc), "+
                           " UPPER(DM_DEPT_DESC),SM_TELNO_WORK,SM_HANDPHONE_NO, "+
                           " USERID,LOWER(SM_EMAIL_ADDR),sm_staff_id "+
                           " FROM staff_main,department_main,service_scheme,users, staff_hierarchy "+
                           " where rownum<15 and (SM_STAFF_NAME like UPPER('%"+keyword+"%') or SM_STAFF_NAME like '%"+keyword+"%')  "+
                           " AND SM_DEPT_CODE=DM_DEPT_CODE "+
                           " AND SM_JOB_CODE=SS_SERVICE_CODE  "+
                           " AND SM_STAFF_STATUS='ACTIVE' "+
                           " AND SM_APPS_USERNAME= USERNAME "+
						   " and sh_staff_id=sm_staff_id and sh_report_to='"+sid+"'"+
                           " ORDER by SM_STAFF_NAME asc,UPPER(ss_service_desc) ";
						   
						   %>
						   <%=sql%>
						   <%
						   
	try
		{
		PreparedStatement pstmt=conn.prepareStatement(sql);
		ResultSet rset=pstmt.executeQuery();
		//if(rset.isBeforeFirst()){
		%>
		
	<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="3" bgcolor="#CCCCCC">
		<tr valign="top" bgcolor="#EEEEEE" class="smallbold">
          <td class="contentStrapColor">&nbsp;</td>
	  <td class="contentStrapColor"><b>Staff's Name</b></td>
          <td class="contentStrapColor"><b>Position</b></td>
          <td class="contentStrapColor"><b>Department </b></td>
          <td class="contentStrapColor" align=center><b>Office Tel No</b></td>
          <td class="contentStrapColor"><b>H/P No </b></td>
	 </tr>
		
		 <%
	  if (rset.isBeforeFirst ()) 
	  {
		while (rset.next())
			{
            %>

        <tr valign="top" bgcolor="#FFFFFF" class="smallfont">
          <td class = "contentBgColor"><%=rset.getRow()%></td>
          <td class = "contentBgColor">
          <a href="../../../../../../../../Documents%20and%20Settings/Administrator/Desktop/training_apply.jsp?action=status_staff_kj&staffid=<%=rset.getString(8)%>"> <%=rset.getString(1)%></a></td>
	  <td class = "contentBgColor"><%=( ( rset.getString(2) ==null)?"-":rset.getString(2) )%></td>
	       <td class = "contentBgColor"><%=( ( rset.getString(3) ==null)?"-":rset.getString(3) )%></td>
          <td class = "contentBgColor"><%=( ( rset.getString(4) ==null)?"-":rset.getString(4) )%></td>
          <td class = "contentBgColor"><%=( ( rset.getString(5) ==null)?"-":rset.getString(5) )%></td>
	 </tr>
			
        <% 
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

	


conn.close();
%>

    </table>

<!----------------------------------------------------------->


<%} conn.close(); %>
<p>&nbsp;</p>

</body>
</html>
