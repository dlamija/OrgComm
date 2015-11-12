<%@ page session="true" %>
<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="javax.naming.*" %>


<script type="text/javascript">

function ValidateFields()

{

	if (document.form1.status.value == ''){
	alert("Please Select Status");
	return false;}

}

</script>

<br>
<%
	Connection conn = null;
	try
	{
    	Context initCtx = new InitialContext();
    	Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
    	DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
		conn = ds.getConnection();
	}
	catch( Exception e )
	{ 
		System.out.println (e.toString()); 
	}
%>
<%
if (conn!=null)
	{
	String sql = "SELECT SAH_REF_ID,SAH_STAFF_ID,SM_STAFF_NAME,TO_CHAR(SAH_DATE,'DD/MM/YYYY') SAH_DATE, " +
				 "TO_CHAR(SAH_TIME_FROM,'HH24:MI'),TO_CHAR(SAH_TIME_TO,'HH24:MI'),SAH_REASON, "+
				 "LPAD(TRUNC( (SAH_TIME_TO - SAH_TIME_FROM) * 24),2,'0') || ':' || LPAD(TRUNC(MOD( ((SAH_TIME_TO - SAH_TIME_FROM) * 24 * 60), 60 )),2,'0'), " +
				 "TO_CHAR(SAH_DATE_APPLY,'DD/MM/YYYY') SAH_DATE_APPLY " +
				 "FROM STAFF_ATTENDANCE_HEAD,STAFF_MAIN " +
				 "WHERE SM_STAFF_ID = SAH_STAFF_ID " +
				 "AND SAH_TYPE = 'TIMEOFF' " +
				 "AND SAH_STATUS = 'APPLY' " +
				 "AND SAH_APPROVE_BY = ? " +
				 "ORDER BY SAH_STAFF_ID,SAH_DATE";
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString (1, session.getAttribute("staffid").toString());
		ResultSet rset = pstmt.executeQuery ();
		if (rset.isBeforeFirst())
			{
%>
<form action="../timeoffApplication/timeoffApplication.jsp" method="get" name="form1">
<input type="hidden" name="action" value="submit_approve_timeoff">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#999999" >
  <tr>
    <td class = "contentStrapColor"><b>Approve Time Off</b></td>
  </tr>
                <tr>
                    <td>
                        <table width="100%"  align="center" cellpadding="3" cellspacing="1" border="0" bgcolor="#999999">
          <tr> 
            <td width="24%" class="contentBgColor"><strong>Staff</strong></td>
            <td width="7%" class="contentBgColor"><strong>Date Apply</strong></td>
            <td width="7%" class="contentBgColor"><strong>Date Time Off</strong></td>
            <td width="13%" class="contentBgColor"><strong>Time From</strong></td>
            <td width="13%" class="contentBgColor"><strong>Time To</strong></td>
            <td width="28%" class="contentBgColor"><strong>Reason</strong></td>
            <td width="8%" class="contentBgColor">&nbsp;</td>
          </tr>
          <%
			while (rset.next())
				{
%>
          <tr> 
            <td width="24%" class="contentBgColorAlternate"><%=rset.getString(2)%> 
              <%=rset.getString(3)%></td>
            <td align="center" class="contentBgColorAlternate"><%=rset.getString(9)%></td>
            <td align="center" class="contentBgColorAlternate"><%=rset.getString(4)%></td>
            <td align="center" class="contentBgColorAlternate"><%=rset.getString(5)%></td>
            <td align="center" class="contentBgColorAlternate"><%=rset.getString(6)%></td>
            <td width="28%" class="contentBgColorAlternate"><%=rset.getString(7)%></td>
            <td align="center" class="contentBgColorAlternate"><input type="checkbox" name="refid" value="<%=rset.getString(1)%>"></td>
          </tr><input type="hidden" name="hours" value="<%=rset.getString(8)%>">
		  <input type="hidden" name="date_to" value="<%=rset.getString(4)%>">
		  <input type="hidden" name="sid" value="<%=rset.getString(2)%>">
		  <input type="hidden" name="time_from" value="<%=rset.getString(5)%>">
		  <input type="hidden" name="time_to" value="<%=rset.getString(6)%>">
          <%
				}  
%>
          <tr> 
            <td colspan="7" class="contentBgColorAlternate">
			  <p align="right"><br>
			    <strong>Status:
			    <select name="status">
		          <!---<option value="">...</option>-->
		          <option value="APPROVE">APPROVE</option>
		          <option value="REJECT">REJECT</option>
	            </select> 
			    <br>
			    if reject(kindly, please state your reason): 
			<!--<input type="submit" name="Submit" value="Approve">-->
			
			<Textarea name="reason" cols="30" rows="2"></Textarea>
			      </strong></p>
			  <p align="right"><input type="submit" value="Submit" onClick="return ValidateFields()">&nbsp;
		    </p></td>
          </tr>
        </table>
</td></tr></table>
</form>
<%
			}
		else
			{ %>They are no time off application waiting for your approval<% }
		pstmt.close ();
		}
	catch (SQLException e)
		{ out.println ("Error : " + e.toString ()); }
	}
%>
<%conn.close();%>