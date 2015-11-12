<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>

<%
	Connection conn = null;
    
	String ANS_01=request.getParameter("ANS_01");
	String ANS_02=request.getParameter("ANS_02");
	String ANS_03=request.getParameter("ANS_03");
	String ANS_04=request.getParameter("ANS_04");
	String ANS_01A=request.getParameter("ANS_01A");
	String ANS_01B=request.getParameter("ANS_01B");
	String ANS_01C=request.getParameter("ANS_01C");
	String ANS_02A=request.getParameter("ANS_02A");
	String ANS_02B=request.getParameter("ANS_02B");
	String ANS_02C=request.getParameter("ANS_02C");
	String ANS_02D=request.getParameter("ANS_02D");
	String refid=request.getParameter("refid");
	String ic_no = request.getParameter("ic_no");
	String action = request.getParameter("action");
	PreparedStatement pstmt =null;
 
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

<% if  (conn !=null && action !=null && action.equals("sendSurvey") ) 
  {

		String sql_insert = "INSERT INTO ERECRUITMENT_SURVEY "+
	                    	"(ES_CANDIDATE_REF_ID,ES_QUE01,ES_QUE02,ES_QUE03,ES_QUE04,ES_QUE01_A, ES_QUE01_B,ES_QUE01_C,ES_QUE02_A, "+
							"ES_QUE02_B,ES_QUE02_C,ES_QUE02_D,ES_DATE_APPLY) "+     
	                  		 "VALUES "+
	                   		"(?,?,?,?,?,?,?,?,?,?,?,?,sysdate) ";
					   
	try
	 {
	         pstmt = conn.prepareStatement(sql_insert);
	         pstmt.setString(1, refid);
			 pstmt.setString(2, ANS_01);
			 pstmt.setString(3, ANS_02);
			 pstmt.setString(4, ANS_03);
			 pstmt.setString(5, ANS_04);
			 pstmt.setString(6, ANS_01A);
			 pstmt.setString(7, ANS_01B);
			 pstmt.setString(8, ANS_01C);
			 pstmt.setString(9, ANS_02A);
			 pstmt.setString(10, ANS_02B);
			 pstmt.setString(11, ANS_02C);
			 pstmt.setString(12, ANS_02D);
			 
	        	           
	         int rc=pstmt.executeUpdate();
                 if (rc>0)
	            { out.println("Record has been save"); }
	         else
		 { out.println("Record fail to save"); }
		   	
    pstmt.close();
	}
	catch (SQLException e)
	{ out.println ("Error sql_insert: " + e.toString () + "\n" + sql_insert); } 
finally {
  try {
  	  if (pstmt != null) pstmt.close();
     // if (conn != null) conn.close();  
  }
  catch (Exception e) 
  { out.println ("Error : " + e.toString ());}
}
response.sendRedirect("../../eRecruitment.jsp?action=finish&refid="+refid+"&ic_no="+ic_no);
%>
<SCRIPT LANGUAGE="JavaScript">
			location="eRecruitment.jsp?action=finish&refid=<%=refid%>&ic_no=<%=ic_no%>";
		</SCRIPT>
<%
}
%>

<% conn.close(); %>

