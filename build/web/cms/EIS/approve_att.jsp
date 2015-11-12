<%@ page session="true" %>
<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="javax.naming.*" %>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<%
Connection conn = null;
String id= (String)session.getAttribute("staffid");

try
	{
    	Context initCtx = new InitialContext();
    	Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
    	DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
	conn = ds.getConnection();
	}
catch( Exception e )
	{ out.println (e.toString()); }
%>
<script>
function checkAll(field)
	{
	for (i = 0; i < field.length; i++)
		field[i].checked = true ;
	}
	
	function uncheckAll(field)
	{
	for (i = 0; i < field.length; i++)
		field[i].checked = false ;
	}
	
	function check(action)
	{
	if (document.form1.select == null)
        {
          return;
        }
        
        var ok = 0;
        if (document.form1.select[1] != null)
        {
          for(var c=0; c < document.form1.select.length; c++)
          {
            if(document.form1.select[c].checked)
            {
				ok = 1;
              	break;
			  }
          }
		   }
        else if (document.form1.select.checked)
        {
          ok = 1;
        }
        if(ok == 0)
        {
          alert("You must select at least one...!");
          return;
        }
		if (action == 'approve')
          {
		  	document.form1.action="staffAttendance.jsp?action=approve";
			if (confirm("Click on OK to confirm"))
            document.form1.submit();
          }
		if (action == 'reject')
          {
		  	document.form1.action="staffAttendance.jsp?action=reject";
			if (confirm("Click on OK to confirm"))
            document.form1.submit();
          }
	}
</script>
<body>
<% if (conn!=null && request.getParameter("action").equals("approve") && request.getParameterValues("select")!=null){ %>

<% }%>
<% if (conn!=null && request.getParameter("action").equals("reject") && request.getParameterValues("select")!=null){ %>

<% }%>
<form name="form1" method="post" action="">
 <%
if (conn!=null)
	{
		
	  String sql	=  "SELECT TO_CHAR(SAH_DATE,'DD-MM-YYYY'),TO_CHAR(SAH_TIME_TO,'HH24:MI'),TO_CHAR(SAH_TIME_FROM,'HH24:MI'),SAH_REASON, "+
					   "SAH_STAFF_ID,SM_STAFF_NAME,SAH_REF_ID "+
					   "FROM STAFF_ATTENDANCE_HEAD,STAFF_MAIN "+
                       "WHERE SAH_STAFF_ID = SM_STAFF_ID AND SAH_REASON_STATUS='APPLY' "+
					   "AND SAH_STAFF_ID IN " +
					   "(SELECT SH_STAFF_ID FROM STAFF_HIERARCHY WHERE SH_SYS_ID = 'ADM_AL' " +
				 		"AND SH_REPORT_TO = ?) ";
						
	
		try
			{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString (1, session.getAttribute("staffid").toString());
			ResultSet rset = pstmt.executeQuery ();
			if (rset.isBeforeFirst ()) { %>

  <table width="98%" border="0" align="center" cellspacing="1" bgcolor="#999999">
    <tr bgcolor="#666666"> 
      <td colspan="7" class='contentBgColor'><strong>Approval Staff Attendance 
        Reason</strong></td>
    </tr>
    <tr bgcolor="#666666" class='contentBgColorAlternate'> 
      <td width="31%"><div align="center"><strong>Staff ID</strong></div></td>
      <td width="9%" height="22"> <div align="center"><strong>Date Attendance</strong></div></td>
      <td width="8%"> <div align="center"><strong>Time Check In</strong></div></td>
      <td width="8%"> <div align="center"><strong>Time Check Out</strong></div></td>
      <td width="24%"> <div align="center"><strong>Reason</strong></div></td>
      <td> <div align="center"></div></td>
      <td><div align="center"><strong>Approval Comment</strong></div></td>
    </tr>
    <%   while (rset.next ()) { %>
    <tr bgcolor="#666666" class='contentBgColor'> 
      <td><table width="100%" border="0" cellspacing="0" class='contentBgColor'>
          <tr> 
            <td width="27%"><%=rset.getString(5)%> -</td>
            <td width="73%"><%=rset.getString(6)%></td>
          </tr>
        </table></td>
      <td> <div align="center"><%=rset.getString(1)%></div>
        <div align="center"></div></td>
      <td> <div align="center"><%=( ( rset.getString(3) ==null)?"-":rset.getString(3) )%></div>
        <div align="center"></div></td>
      <td> <div align="left"></div>
        <div align="center"></div>
        <div align="center"><%=( ( rset.getString(2) ==null)?"-":rset.getString(2) )%> 
        </div></td>
      <td><%=rset.getString(4)%></td>
      <td width="2%"> <div align="center"> 
          <input name="select" type="checkbox" id="select" value="<%=rset.getString(7)%>">
        </div></td>
      <td width="18%"><input name="comment" type="text" id="comment"></td>
      <% } %>
    </tr>
  </table>
  
    
  <div align="right"><br>
    <input name="btn_save" type="button" value="Check All" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;" onclick="javascript:checkAll(document.form1.select);">
    <input name="btn_save2" type="button" value="Uncheck All" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;" onclick="javascript:uncheckAll(document.form1.select);">
    <input name="btn_save3" type="button" value="Approve" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;" onclick="check('approve');">
    <input name="btn_save4" type="button" value="Reject" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;" onclick="check('reject');">
    <br>
    <%  } else { %>
  </div>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFF">
  <tr>
      <td height="13" colspan="11" bgcolor="#FFFFFF">They are no staf attendance 
        reason waiting for your approval </td>
  </tr>
</table>
<p>

        <% }

			rset.close ();
			pstmt.close ();
			}
	catch( Exception e )
		{ out.println (e.toString()); }
	}
conn.close ();
%>

</form>
</body>
</html>
