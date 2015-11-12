<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page session="true" %>
<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="javax.naming.*" %>
<%@ page import="java.util.*" %>

<%    
	String id=(String)session.getAttribute("staffid");
	String refid=request.getParameter("refid");
	String name=request.getParameter("name");
%>

<%!
 	String sql=null,sql1=null , leave_tt=null ;
	Connection conn = null;
	ResultSet rs=null,rs1=null;
	Statement st=null,st1=null;
	boolean ins_sts ;
	
	public String getD(java.sql.Date d) {
		int yy,mm,dd ;
		yy = d.getYear() + 1900 ;
		mm = d.getMonth()+ 1 ;
		dd = d.getDate() ;
		String sd = dd + "/"+ mm+ "/"+ yy ;
		return sd ;
	}
	
	public String getT(double d)
	{
		String result="";
		int hh=(int)d;
		int mi=(int)(((double)d-(int)(d))*60);
		String temp=Integer.toString(mi).length()==1?"0"+Integer.toString(mi):Integer.toString(mi);
		result=hh+":"+temp;
		return result;
	}	


%>

<%
		
 	try
	{
		Context initCtx = new InitialContext();
		Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
		DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
		conn = ds.getConnection();

		//Class.forName("oracle.jdbc.driver.OracleDriver");
	 	//conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:cms","tmsintranet3","root");
	}
	catch( Exception e ){
%>
	<font color="#ff0000">
	   Sorry, fail to connect to database.<br>
	   Error Msg : <%=e.toString()%> </font> 
 <%
       conn = null;
       }
%>



<html>
<head>

<title>Recommend</title>

</head>
<body>

<form name=form1 method=post>
<input type=hidden name=refid value='<%= refid %>' >
<TABLE width="100%" border=0 CELLSPACING="1" CELLPADDING="3">

<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  <TD CLASS="contentBgColorAlternate" ALIGN="MIDDLE" colspan="2" >
   <B>Approve Overtime</B>
  </td>
</tr>

<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  <TD CLASS="contentBgColorAlternate" ALIGN="MIDDLE" colspan="2" >
<TABLE cellpadding=3 cellspacing=1 border=0 width="100%">

<% 
try
{
		st=conn.createStatement();
      	Statement st_l=conn.createStatement();
		String work_name="";
		sql="select * from cmsadmin.staff_leave_overtime where slo_ref_id='"+ refid +"'";
		ResultSet rs_l;
		rs=st.executeQuery(sql);
	
		while (rs.next())  
		{
			String sql_l="select woh_desc from cmsadmin.work_order_head where woh_workorder_id='"+rs.getString("slo_workorder_id")+"'";
			rs_l=st_l.executeQuery(sql_l);
			while(rs_l.next())
			{
				work_name=rs_l.getString("woh_desc");
			}
			
%>
<TR>
<TD align="right"width="20%" CLASS="contentBgColor" align="right"><b>Name</B></TD>
<TD width="30%" CLASS="contentBgColorAlternate"><%= name %> </TD>
</TR>

<TR><TD align="right" CLASS="contentBgColor" width="20%">Overtime Date
</TD><TD width="80%" CLASS="contentBgColorAlternate"><%= getD(rs.getDate("slo_date"))%></TD></TR>

<TR><TD align="right" CLASS="contentBgColor" width="20%">Work description</TD>
<TD width="80%" CLASS="contentBgColorAlternate"><%= work_name%>  </TD></TR>
 
<TR><TD align="right" CLASS="contentBgColor" width="20%">Total Hours</TD>
<TD width="80%" CLASS="contentBgColorAlternate"><%= getT(rs.getDouble("slo_total_hours"))%>  </TD></TR>

<%
	}
}
catch(Exception e)
{
	out.println("Error: "+e);
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

</TABLE> 
</td>
</tr>

<TR><TD  CLASS="contentStrapColor" align="center" colspan="2">
<img src="../../images/cms/leave/ic_approve.gif" onClick='document.form1.action="leaveMain.jsp?action=appovertimesubmit" ; document.form1.submit();'><img src="../../leave/images/blank.gif" width="4">
</TD></TR>

</TABLE>
 
</form>
</body>
</html>

