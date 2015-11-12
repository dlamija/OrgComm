package cms.admin.meeting.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.beans.*;
import common.*;
import tvo.*;
import utilities.AttachmentUtil;
import java.util.*;

import cms.admin.meeting.bean.MeetingDecisionProgressAttachment;

/**
 * @web.servlet name = "progressAttachment"
 * @web.servlet-mapping url-pattern = "/progressAttachment"
 */
public class ProgressAttachment extends HttpServlet {

	private static final long serialVersionUID = 1L;
	String mtgCode      = null;
    String agendaDesc   = null;
    String agendaLevel  = null;
    String agendaSeqno  = null;
    String parentAgenda = null;
    String sortSeq      = null;
    String numbering    = null;
	String errorMssg = null;
	String progressSeq = null;

	String originalFileName = null;
	String physicalFileName = null;

	

	public void doGet(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException
  	{
    	doPost(request, response);
  	}


    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException
    {
        boolean status = true;
        HttpSession session = request.getSession(true);

		String progressSeq;		
		String meetingCode = (String) session.getAttribute("decisionMtgCode");		
		String action = request.getParameter("action");
	    session.removeAttribute("errmsg");
		
		Connection conn = null;
		DBConnectionPool dbPool = null;
            try{
               
			   dbPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
               conn = dbPool.getConnection();				
				
                if( conn != null ){
			        if (action.equals("addProgressAttach"))
					{
						

						   progressSeq = request.getParameter("progressSeq");
						   if (addProgressAttach(request, response, meetingCode))
						   {
							/*
							PrintWriter out = response.getWriter();
							out.println("<script>");
							out.println("opener.location.reload();");
							out.println("opener.location.hash = '" + progressSeq + "_updateDecisionActionProgressForm';");
							out.println("window.close();");
							out.println("</script>"); */
							status = true;

						   }
						   else	
						   {
							status = false;
							errorMssg = "Add Attachment Not Successful ";
						   }
					}
					else if (action.equals("RemoveAttachment"))
					{
							
							MeetingDecisionProgressAttachment maa = null;
							maa = ( MeetingDecisionProgressAttachment )Beans.instantiate( this.getClass().getClassLoader(),
                                                                     "cms.admin.meeting.bean.MeetingDecisionProgressAttachment" );

	
							progressSeq = request.getParameter("progressSeq");
							String seqNo = request.getParameter("seqNo");
 
							maa.setDBConnection(conn);
							
							
							String physicalFileName =  maa.queryPhysicalFileName(progressSeq,seqNo);
							
						   							
							if (maa.removeAttachment(progressSeq,seqNo ))
							{
							  
							  status = true;
							  CommonFunction.printAlert(request,response, "Attachment Deleted", "eMeeting.jsp?action=DecisionActionProgress&meetingCode=" + meetingCode + "#" + progressSeq.trim() + "_updateDecisionActionProgressForm"); 	
						   
							}
							else
							{
								status = false;
								errorMssg = "Delete Attachment Not Successful ";
							}
							
							if (! physicalFileName.equals("null"))
							{
							  ServletContext context = getServletContext();
							  String finalDir = TvoContextManager.getRealPath(context, request, "/eMeeting/" + meetingCode);
							  							  
							  AttachmentUtil au = new AttachmentUtil ();
							  au.deleteAttachment(finalDir,physicalFileName);	  	
							
							}  
						
					}
					
						else if (action.equals("RemoveAttachmentSenat"))
					{
							
							MeetingDecisionProgressAttachment maa = null;
							maa = ( MeetingDecisionProgressAttachment )Beans.instantiate( this.getClass().getClassLoader(),
                                                                     "cms.admin.meeting.bean.MeetingDecisionProgressAttachment" );

	
							progressSeq = request.getParameter("progressSeq");
							String seqNo = request.getParameter("seqNo");
 
							maa.setDBConnection(conn);
							
							
							String physicalFileName =  maa.queryPhysicalFileName(progressSeq,seqNo);
							
						   							
							if (maa.removeAttachment(progressSeq,seqNo ))
							{
							  
							  status = true;
							  CommonFunction.printAlert(request,response, "Attachment Deleted", "senateMeeting.jsp?action=DecisionActionProgress&meetingCode=" + meetingCode + "#" + progressSeq.trim() + "_updateDecisionActionProgressForm"); 	
						   
							}
							else
							{
								status = false;
								errorMssg = "Delete Attachment Not Successful ";
							}
							
							if (! physicalFileName.equals("null"))
							{
							  ServletContext context = getServletContext();
							  String finalDir = TvoContextManager.getRealPath(context, request, "/eMeeting/" + meetingCode);
							  							  
							  AttachmentUtil au = new AttachmentUtil ();
							  au.deleteAttachment(finalDir,physicalFileName);	  	
							
							}  
						
					}


				 }
				 else
				 {
                    status = false;
					errorMssg = "Connection to database is not available.";
                    
                 }

			
            
            
            
            }catch( Exception e ){
                e.printStackTrace();
                session.setAttribute( "errmsg", e.toString() );
                status = false;
            }
            finally{
                      dbPool.returnConnection(conn);
            }
        

        if( status ){
            //response.sendRedirect(request.getHeader("Referer"));
			//CommonFunction.printAlert(request,response,"");
			CommonFunction.printAlert(request,response,"File attachment successfully saved.",request.getHeader("Referer"));
        }else{
			if (errorMssg.equals("null"))
				errorMssg = "Error!";
            CommonFunction.printAlert(request,response, errorMssg, request.getHeader("Referer"));        
        }
    } //end of do Post






	public synchronized boolean addProgressAttach(HttpServletRequest request, HttpServletResponse response, String meetingCode)
    {

	
	
  	String errMsg = "";
	ServletContext context = getServletContext();
	String creatorUserID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
	
	String finalDir = TvoContextManager.getRealPath(context, request, "/eMeeting/" + meetingCode);
    String tempDir = TvoContextManager.getRealPath(context, request, "/eMeeting/temp/" + meetingCode);
    
	     	   	
	DBConnectionPool dbPool = null;
	Connection con = null;
	PreparedStatement pstmt = null;
	boolean status = false;

	PreparedStatement pstmtMax = null;
	ResultSet rsMax = null;	
   	
   	try {
		MultipartRequest multipartRequest = new MultipartRequest(request, tempDir);	  
		//int calendarApptID = Integer.parseInt(multipartRequest.getParameter("calendarApptID"));
		
		dbPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
		con = dbPool.getConnection();

		String progressSeq = multipartRequest.getParameter("progressSeq");
	    
	    		
		int attachID = 1;
		pstmtMax = con.prepareStatement(
					"SELECT Max(MDAP_ATTC_SEQNO) " +
					"FROM MEETING_PROGRESS_ATTC " +
					"WHERE MDAP_PROGRESS_SEQ = ?"
		);
		pstmtMax.setString(1, progressSeq);
		rsMax = pstmtMax.executeQuery();
		if (rsMax.next()) {
			attachID = rsMax.getInt(1) + 1;
	   

		}
			    
	    pstmt = con.prepareStatement(
					"INSERT INTO MEETING_PROGRESS_ATTC " +
					" (MDAP_PROGRESS_SEQ, MDAP_ATTC_SEQNO, MDAP_ORIGINAL_FILE_NAME, MDAP_PHYSICAL_FILE_NAME ) " +
					" VALUES " + 
					" (?, ?, ?, ?)");

       
		Enumeration eUploadedFiles = multipartRequest.getFileNames();
		while (eUploadedFiles.hasMoreElements()) {
			String originalFileName = multipartRequest.getFilesystemName((String) eUploadedFiles.nextElement());
			if (originalFileName != null) {
				// Copy to final destination
				
				String physicalFileName = AttachmentUtil.saveAttachment(tempDir, finalDir, originalFileName);
				
				
				if (physicalFileName != null) {

				
					
					pstmt.setString(1, progressSeq);
				   	pstmt.setInt(2, attachID);
					pstmt.setString(3, originalFileName);
					pstmt.setString(4, physicalFileName);
					pstmt.executeUpdate();
					attachID++;

				

				}
			}
		}
		status = true;
	
	} catch (Exception e) {
		
		errMsg = e.toString();
		e.printStackTrace();
		status = false;
	} finally {
		try {
		
			if (pstmt != null) { pstmt.close(); }
			if (con != null)   { dbPool.returnConnection(con); }
			if (rsMax != null)    { rsMax.close(); }
			if (pstmtMax != null) { pstmtMax.close(); }
			CommonFunction.delFileTree(tempDir);
		
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	return status;
	
  }

}
