package cms.admin.meeting.servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import common.CommonFunction;
import common.DBConnectionPool;
import tvo.TvoDBConnectionPoolFactory;

/**
 * @web.servlet name = "descCategory"
 * @web.servlet-mapping url-pattern = "/descCategory"
 */
public class DecisionCategory extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	PreparedStatement pstmt = null;
	ResultSet rset = null;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
    	throws ServletException, IOException
    {
		doPost(request, response);
  	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
    	throws IOException, ServletException
    {
	    String action = request.getParameter("action");
	    String errMsg = null;
	    
	    if ("add".equals(action)) {
	    	errMsg = add(request);
	    	if (errMsg == null || errMsg.equals(""))
	    		CommonFunction.printAlert(request, response, "Add Successful", "eMeeting.jsp?action=admin");
	    	else
	    		CommonFunction.printAlert(request, response, "Add record failed.\\nError: " + errMsg, "eMeeting.jsp?action=admin");
	    }
	    else if ("delete".equals(action)) {
	    	errMsg = delete(request);
	    	if (errMsg == null || errMsg.equals(""))
	    		CommonFunction.printAlert(request, response, "Delete Successful", "eMeeting.jsp?action=admin");
	    	else
	    		CommonFunction.printAlert(request, response, "Deletion failed.\\nError: " + errMsg, "eMeeting.jsp?action=admin");
	    }
	    else if ("update".equals(action)) {
	    	errMsg = update(request);
	    	if (errMsg == null || errMsg.equals(""))
	    		CommonFunction.printAlertNCloseWindow(request, response, "Update Successful", "eMeeting.jsp?action=admin");
	    	else
	    		CommonFunction.printAlert(request, response, "Update failed.\\nError: " + errMsg, "eMeeting.jsp?action=admin");
	    }
    }
	
	private Connection getConnection(HttpServletRequest request) {
		Connection conn = null;
    	DBConnectionPool dbPool = null;
    	try {
    		dbPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
    		conn = dbPool.getConnection();
    	}
    	catch (Exception e) {
    		e.printStackTrace();
    	}
    	return conn;
	}
	
	private String add(HttpServletRequest request) {
		String errMsg = null;
		Connection conn = null;
		StringBuilder sb = new StringBuilder("INSERT INTO meeting_decision_category ");
		sb.append("(mdc_code,mdc_desc) VALUES ( ? , ? )");
		
		try {
			conn = getConnection(request);
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, request.getParameter("code"));
			pstmt.setString(2, request.getParameter("desc"));
			
			pstmt.executeUpdate();
			pstmt.close();
		}
		catch (Exception e) {
			e.printStackTrace();
			errMsg = e.toString();
		}
		finally {
			try {
				if (conn != null) conn.close();
			}
			catch (Exception e) { }
		}
		return errMsg;
	}

	private String delete(HttpServletRequest request) {
		String errMsg = null;
		Connection conn = null;
		StringBuilder sb = new StringBuilder("DELETE FROM meeting_decision_category WHERE mdc_code = ?");
		
		try {
			conn = getConnection(request);
			boolean isExist = hasAttachRecord(request, conn);
			if (isExist) {
				errMsg = "Selected Decision Category currently being used by Meeting Decision.";
			}
			else {
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setString(1, request.getParameter("code"));
				
				pstmt.executeUpdate();
				pstmt.close();
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			errMsg = e.toString();
		}
		finally {
			try {
				if (conn != null) conn.close();
			}
			catch (Exception e) { }
		}
		return errMsg;
	}
	
	private boolean hasAttachRecord(HttpServletRequest request, Connection conn) {
		boolean isExist = false;
		StringBuilder sb = new StringBuilder("SELECT count(1) FROM meeting_decision WHERE md_decision_category = ?");
		
		try {
			conn = getConnection(request);
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, request.getParameter("code"));
			
			rset = pstmt.executeQuery();
			if (rset.isBeforeFirst()) {
				if (rset.next()) {
					if (rset.getInt(1)>0)	isExist = true;
				}
			}
			rset.close();
			pstmt.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}		
		return isExist;
	}
	

	private String update(HttpServletRequest request) {
		String errMsg = null;
		Connection conn = null;
		StringBuilder sb = new StringBuilder("UPDATE meeting_decision_category ");
		sb.append("SET mdc_desc = ? WHERE mdc_code = ?");
		
		try {
			conn = getConnection(request);
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, request.getParameter("desc"));
			pstmt.setString(2, request.getParameter("code"));
			
			pstmt.executeUpdate();
			pstmt.close();
		}
		catch (Exception e) {
			e.printStackTrace();
			errMsg = e.toString();
		}
		finally {
			try {
				if (conn != null) conn.close();
			}
			catch (Exception e) { }
		}
		return errMsg;
	}

}