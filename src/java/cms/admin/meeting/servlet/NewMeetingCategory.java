package cms.admin.meeting.servlet;

import cms.admin.meeting.bean.MeetingCategory;
import java.beans.Beans;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import javax.servlet.*;
import javax.servlet.http.*;

import common.*;
import tvo.TvoDBConnectionPoolFactory;
import tvo.TvoDebug;

/**
 * @web.servlet name = "addMtgGroup"
 * @web.servlet-mapping url-pattern = "/addMtgGroup"
 */
public class NewMeetingCategory extends HttpServlet {

	private static final long serialVersionUID = 1L;
	String mtgCatDesc = null;
	String mtgDeptCode = null;

	String errorMssg = null;

  public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException
  {
    int i = 1;
    HttpSession session = request.getSession(true);
    DBConnectionPool localDBConnectionPool = null;
    Connection conn = null;
    String staffID = (String)TvoContextManager.getSessionAttribute(request, "Login.CMSID");
    String userID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");

    mtgCatDesc = request.getParameter("mtgCatDesc");
    mtgDeptCode = request.getParameter("mtgDeptCode");

    session.removeAttribute("errmsg");

    try
      {
        localDBConnectionPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
        conn = localDBConnectionPool.getConnection();
        if (conn != null)
        {
          MeetingCategory mc = (MeetingCategory)session.getAttribute("mtgCat");
          if (mc == null) {
        	  mc = (MeetingCategory)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingCategory");
        	  session.setAttribute("mtgCat", mc);
          }

          if (mc != null) {
        	  mc.setDBConnection(conn);
        	  mc.setMtgCatDesc(mtgCatDesc.trim());
        	  mc.setMtgDeptCode(mtgDeptCode.trim());
        	  mc.setMtgCreatedBy(staffID);

        	  if (mc.addMeetingCategory()) {
        		  i = 1;
        		  session.setAttribute("mtgTypecode", mc.getMtgCatCode());
        		          		  
        		  //send memo to approver
        		  Object approvers[] = getApproval(conn);
        		  String msgBody = "New Meeting Category application has been created for your approval." + "<br>" +
        		  						"Meeting Category: " + mtgCatDesc;
        		  CommonFunction.sendMemo(conn, approvers, userID, msgBody, CommonFunction.getDate("yyyy-MM-dd HH:mm:ss"), "FYI", 
        		    		"New Meeting Category.", "Y");
        	  }
        	  else {
        		  i = 0;
        		  errorMssg = mc.getErrorMessage();
        	  }
          }
          else {
        	  i = 0;
        	  errorMssg = "Meeting Category object is not available.";
          }
        }
        else
        {
          i = 0;
          errorMssg = "Connection to database is not available.";
        }
      }
      catch (Exception localException)
      {
        localException.printStackTrace();
        session.setAttribute("errmsg", localException.toString());
        i = 0;
      }
      finally {
        localDBConnectionPool.returnConnection(conn);
      }


      if (i != 0)
    	  CommonFunction.printAlert(request, response, "New Meeting Category submitted for approval.", "eMeeting.jsp");
    	  //response.sendRedirect("eMeeting.jsp?action=addMembers");
      else
    	  CommonFunction.printAlert(request, response, this.errorMssg, request.getHeader("Referer"));
  }
  
  public Object[] getApproval(Connection con)
  {
    Statement stmt = null;
    Object[] userID = null;
    Vector vUserID = new Vector();
    ResultSet rs = null;
    
    StringBuilder sb = new StringBuilder("SELECT userid FROM cmsusers_view,cmsadmin.cms_user_application ");
    sb.append("WHERE cmsid = cua_staff_id and cua_application = 'AHF010' and cua_status = 'Y'");
    
    try {
    	stmt = con.createStatement();
    	rs = stmt.executeQuery(sb.toString());

    	if (rs.isBeforeFirst()) {
    		while (rs.next())
    			vUserID.add(rs.getString("userID"));
    		rs.close();
    	}
    	userID = vUserID.toArray();
    	stmt.close();
    }
    catch (SQLException e) {
      TvoDebug.printStackTrace(e);
    }
    finally {
    	try {
    		if (rs != null) rs.close();
            if (stmt != null) stmt.close();
    	}
    	catch (SQLException e) { }
    }
    return userID;
  }

}