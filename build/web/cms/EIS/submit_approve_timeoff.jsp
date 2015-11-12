<%@ page session="true" %>
<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="javax.naming.*" %>
<%@include file="validate.jsp" %>

<html>
<head>
<title>Time Off Approval</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>


<%
	Connection conn = null; 

	String staff_id  = (String)session.getAttribute("staffid");
	String []ref_id   = request.getParameterValues("refid");
	String []date_to   = request.getParameterValues("date_to");
	String []time_from   = request.getParameterValues("time_from");
	String []time_to   = request.getParameterValues("time_to");
	String []hours   = request.getParameterValues("hours");
	String []staffid   = request.getParameterValues("sid");
	String status=request.getParameter("status");
    String reason=request.getParameter("reason");
	
	String current_date = "";
	String current_day = "";
	String current_time = "";
	ResultSet rs_all 	= null;

 	try
	{
		Context initCtx = new InitialContext();
		Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
		DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
		conn = ds.getConnection();		
	}
	catch( Exception e ) { 
		out.println (e.toString()); 
	}
%>

<body>

<%
try {	
	if (status ==null) { %>
		Kindly, please choose the category status(Approve/Reject).
		<input type="button" value="Back" onClick="history.go(-1)">
<%	}
	else {
		if (conn!=null) {
			String sql = "SELECT TO_CHAR(SYSDATE,'HH24:MI'),TO_CHAR(SYSDATE,'YYYY'),TO_CHAR(SYSDATE,'DAY') FROM DUAL ";
	
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rset = pstmt.executeQuery ();
				if (rset.next()) {
					current_time = rset.getString (1);
					current_date = rset.getString (2);
					current_day = rset.getString (3);
				}
				pstmt.close ();
				rset.close ();
			}
			catch (SQLException e) {
				out.println ("Error : " + e.toString ());
			}
		}
	
		if (conn !=null && ref_id!=null && status!=null && status.equals("APPROVE")) {
			//String [] refid = request.getParameterValues("refid");
			String sql3 = "{ ? = call STAFF_ATTENDANCE.ApproveTimeOff (?) }";
	
			for (int a=0; a<ref_id.length && a<staffid.length; a++) {
				try {
					CallableStatement cstmt = conn.prepareCall (sql3);
					cstmt.registerOutParameter (1, Types.NUMERIC);
					cstmt.setString (2, ref_id[a]);
					cstmt.execute ();
					if (cstmt.getInt(1)==1)// Submit approve time off succesful
						{ %>Approving time off Ref ID <%=ref_id[a]%>... Done<% }
					else // Submit checkin reason
						{ %>Approving time off Ref ID <%=ref_id[a]%> ... Fail<% }
					cstmt.close ();
				}
				catch (SQLException e) {
					out.println ("Error : " + e.toString ());
				}
			}		
		}
		else {
	
			//String [] refid = request.getParameterValues("refid");
			String sql4 = "{ ? = call STAFF_ATTENDANCE.RejectTimeOff (?, ?, ?) }";
	
			for (int a=0; a<ref_id.length && a<staffid.length; a++) {
				try {
					CallableStatement cstmt = conn.prepareCall (sql4);
					cstmt.registerOutParameter (1, Types.NUMERIC);
					cstmt.setString (2, ref_id[a]);
					cstmt.setString (3, staffid[a]);
					cstmt.setString (4, reason);
					cstmt.execute ();
					if (cstmt.getInt(1)==1) // Submit approve time off succesful
						{ %>Reject time off Ref ID <%=ref_id[a]%>... Done<% }
					else // Submit checkin reason
						{ %>Reject time off Ref ID <%=ref_id[a]%> ... Fail<% }
					cstmt.close ();
				}
				catch (SQLException e) {
					out.println ("Error : " + e.toString ()); 
				}
			}
		}
	}
} // try
catch (Exception e) {
	out.println (e.toString());
}
finally {
	try {
		if (conn != null) conn.close();
	}
	catch (Exception e) {  }
}
%>
</body>
</html>