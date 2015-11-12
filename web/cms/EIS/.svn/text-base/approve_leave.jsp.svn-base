<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page session="true" %>
<%@page import="java.sql.*,
                cms.leave.LeaveDB,CommonFunction" %>
<%@page import="javax.sql.*" %>
<%@page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id='leaveBean' class='cms.leave.LeaveLeave' scope='request'/>
<jsp:useBean id='staff' class='cms.admin.bean.Staff' scope='request'/>
<%
    String refid=request.getParameter("refid");
    Calendar cal= Calendar.getInstance();
  	String leave_year=""+cal.get(Calendar.YEAR);
	Connection conn = null;
    String id=(String)session.getAttribute("staffid");
	String deptCode="";
	Hashtable htLeaves = null;
    LeaveDB leave = new LeaveDB();
 	try
	{
		 Context initCtx = new InitialContext();
    	 Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
    	 DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
	     conn = ds.getConnection();
    	 leave = leaveBean.getLeaveDetails(refid,"view");
         htLeaves = leaveBean.getLeavesBalances(leave.getStaffID(),leave_year);
         staff.setDBConnection(conn);

         if(staff.queryStaffBasicProfile(id))
            deptCode = staff.getDeptCode();
	}
	catch( Exception e )
	{
       System.out.println("Connection Failed:(approve):"+e);
    }
%>
<script>
	function approve(){
		document.form1.action="Leave?action=approve&approve=<%=refid%>";
		document.form1.submit();
	}

	function reject(){
		document.form1.action="Leave?action=reject&approve=<%=refid%>";
        if(document.form1.reason.value=='')
            alert("Please Enter Reason!");
        else
           document.form1.submit();
	}

</script>
<form name=form1 method=post>
<input type=hidden name=refid value='<%= refid %>' >
<TABLE width="100%" border=0 CELLSPACING="1" CELLPADDING="3">
<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
    <TD CLASS="contentBgColorAlternate" ALIGN="MIDDLE" colspan="2" > <B>Approve 
      Leave</B> </td>
</tr>

<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
 <TD CLASS="contentBgColorAlternate" ALIGN="MIDDLE" colspan="2" >
<TABLE cellpadding=3 cellspacing=1 border=0 width="100%">
<TR>
<TD width="30%" CLASS="contentBgColor" align="right" ><b>Name</B></TD>
<TD width="70%" CLASS="contentBgColorAlternate"><%=leave.getStaffName() %> </TD>
</TR>
<TR><TD align="right" CLASS="contentBgColor" width="30%">From Date
</TD><TD  CLASS="contentBgColorAlternate"><%= leave.getDateFrom()%></TD></TR>
<TR><TD align="right" CLASS="contentBgColor" width="30%">To Date
</TD><TD  CLASS="contentBgColorAlternate"><%= leave.getDateTo()%> </TD></TR>
<TR><TD align="right" CLASS="contentBgColor" width="30%">Total Days</TD>
<TD CLASS="contentBgColorAlternate"><%=leave.getTotalDays()%>  </TD></TR>
<TR><TD align="right" CLASS="contentBgColor" width="30%">Leave Type</TD>
<TD CLASS="contentBgColorAlternate"><%=leave.getLeaveType() %> </TD></TR>
<TR><TD align="right" CLASS="contentBgColor" width="30%"><B>Balance</B></TD>
<TD CLASS="contentBgColorAlternate">
<%=htLeaves.get(leave.getLeaveCode())%>
</TD></TR>
<%
	if(leave.getStatus().equals("RECOMMEND") || leave.getStatus().equals("APPLY")) {
%>
		<TR>
		  <TD align="right" CLASS="contentBgColor" width="30%">Reason</TD>
		  <TD  CLASS="contentBgColorAlternate"><%=leave.getReason()%></TD>
	   </TR>
		<TR>
		  <TD align="right" CLASS="contentBgColor" width="30%">Contact Address</TD>
    	  <TD CLASS="contentBgColorAlternate"><%=leave.getAddress()%></TD>
		</TR>
    	<TR>
		<TD align="right" CLASS="contentBgColor" width="30%">Telephone</TD>
    	<TD CLASS="contentBgColorAlternate"><%=leave.getContactNo()%>  </TD>
		</TR>
    	<TR>
    	<TD width="30%" CLASS="contentBgColor" align="right">substitute</TD>
		<TD CLASS="contentBgColorAlternate" COLSPAN="1" ALIGN="LEFT">

<%
    if(staff.querySubstituteStaffs(deptCode,id)) {
%>

		
		<P><SELECT name="substitute">
		<OPTION SELECTED value='0'>....
<%
	while(staff.nextSubstituteStaff()){
        if(!leave.getSubstituteID().equals("") && leave.getSubstituteID().equals(staff.getStaffId()))  {
%>
            <OPTION VALUE='<%=staff.getStaffId()%>' selected><%=CommonFunction.restrictNameLength(staff.getStaffName(),20)%>
<%
        }
        else{
%>
            <OPTION VALUE='<%=staff.getStaffId()%>'><%=CommonFunction.restrictNameLength(staff.getStaffName(),20)%>

<%

        }

	}

%>

</TD>

</TR>

<%	

	}

	if(leave.getStatus().equals("RECOMMEND")|| leave.getStatus().equals("APPLY"))

	{

%>



<TR>

<TD width="30%" CLASS="contentBgColor" valign="top" align="right"><font color=red><b>Kindly, state your reason (if reject)</b></font></TD>

<TD CLASS="contentBgColorAlternate"><INPUT TYPE="TEXT" SIZE="46" NAME="reason"

        style="WIDTH: 380px; HEIGHT: 67px"></TD>

</TR>
<%
    }
%>
</TABLE>
<!--<-/td>
</tr>-->
<% } %>

<TR><TD  CLASS="contentBgColorAlternate" align="center" colspan="2">
<!--<a href='javascript:approve();' onMouseOver='window.status="APPROVE";return true'><img border=0 src="images/cms/leave/ic_approve.gif"></a><img src="images/blank.gif" width="4">
--><%
	if(leave.getStatus().equals("RECOMMEND")|| leave.getStatus().equals("APPLY"))	{
%>
<a href='javascript:reject();' onMouseOver='window.status="REJECT";return true'><img  border=0 src="../leave/images/cms/leave/ic_reject.gif" ></A><img src="../leave/images/blank.gif" width="4">
<%
	}
    if (conn != null)
    try
	{
           conn.close();
    }
    catch(Exception e)
 	{
 	}
%>

</TD></TR>
</form>
</TABLE>