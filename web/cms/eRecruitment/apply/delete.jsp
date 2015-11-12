<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ page import="Messages" %>

<%
	Connection conn = null;
	String message = null;
	String kadpengenalan= (String)session.getAttribute("kadpengenalan");	
	String action = request.getParameter("action");
	String refid_file[]= request.getParameterValues("refid_file");
	String refid=request.getParameter("refid");
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

<% 
if(action!=null && action.equals("deleteFile"))
{
					
String sql_inst4 = 	"delete staff_candidate_attachment "+
		      		"where sca_ref_id = ? "+
					"and SCA_CANDIDATE_REFID = ? ";
					
	try
	{
	 for (int a=0; a<refid_file.length; a++)
		 {
		 System.out.println("1");
			PreparedStatement pstmt4 = conn.prepareCall(sql_inst4);
			pstmt4.setString(1, refid_file[a]);
			pstmt4.setString(2, refid);
			pstmt4.execute();
			System.out.println("berjaya");
			pstmt4.close ();
	        //File file = new File(s2);
            file.delete();

		}
	}
	catch (SQLException e)
	{ 
		out.println ("Error delete: " + e.toString ()); 
	}
	response.sendRedirect("../../eRecruitment.jsp?action=upload&refid="+refid+"");	
}
conn.close();
%>
<%
	conn.close ();
%>
