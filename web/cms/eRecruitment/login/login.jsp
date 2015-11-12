<%if (session.isNew()==true)
response.sendRedirect(response.encodeRedirectURL("eRecruitment.jsp"));%>

<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ include file="/includes/import.jsp" %>

<jsp:useBean id="recruitment" scope="page" class="cms.eRecruitment.eRecruitment"/>


<%
	Connection conn=null;
	String kadpengenalan= request.getParameter("kadpengenalan");
	String password= request.getParameter("password");
	
	try
	{
		Context initCtx = new InitialContext();
		Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
		DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
		conn = ds.getConnection();
		recruitment.setDBConnection(conn);
	}
	catch( Exception e )
	{ 
		out.println (e.toString()); 
	}
	/*finally {
		try {
			if (conn != null) conn.close();
		}
		catch (Exception e) { }
	}*/
	
	boolean status = false;
	if (recruitment.isPemohon(kadpengenalan,password))
		status = true;
	else
		status = false;
%>	
<%
 if (status)
 {

 	session.removeAttribute("kadpengenalan");
	session.setAttribute("kadpengenalan", kadpengenalan );
	//session.setMaxInactiveInterval(100);
	//String kadpengenalan= (String)session.getAttribute("kadpengenalan")
//	response.sendRedirect("../../eRecruitment.jsp?action=mainpage&kadpengenalan="+kadpengenalan);
%>

<SCRIPT LANGUAGE="JavaScript">
			location="eRecruitment.jsp?action=mainpage&kadpengenalan=<%=kadpengenalan%>";
		</SCRIPT>

<%
 } 
if (!status)
{
%>
		<SCRIPT LANGUAGE="JavaScript">
			alert('No Kad Pengenalan/Kata Laluan TIDAK SAH!');
			location="eRecruitment.jsp";
		</SCRIPT>
<%
}
%>	

<%
try
	{ conn.close (); }
catch (Exception e)
	{ conn = null; }
%>	


