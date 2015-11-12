package cms.admin.meeting.servlet;

import cms.admin.meeting.bean.MeetingCategory;
import java.beans.Beans;
import java.io.IOException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import common.CommonFunction;
import common.DBConnectionPool;
import tvo.TvoDBConnectionPoolFactory;

/**
 * @web.servlet name = "deleteCategory"
 * @web.servlet-mapping url-pattern = "/deleteCategory"
 */
public class DeleteMeetingCategory extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	String errorMssg = "ERROR";

	public void doPost(HttpServletRequest request, HttpServletResponse response)
    	throws IOException, ServletException
    {
		int i = 1;
		HttpSession localHttpSession = request.getSession(true);
		String catCode = request.getParameter("catCode");
		String status = request.getParameter("status");

		Connection conn = null;
		DBConnectionPool localDBConnectionPool = null;
		try {
			localDBConnectionPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
			conn = localDBConnectionPool.getConnection();

			if (conn != null) {
				MeetingCategory mc = new MeetingCategory();
				boolean result = false;
				mc.setDBConnection(conn);
				//inactiveMeetingCategory
				//removeMtgCategory
				System.out.println("status : " + status);
				if ("APPLY".equals(status)|| "REJECT".equals(status))
					result = mc.removeMtgCategory(catCode); //permanently removed
				else
					result = mc.inactiveMeetingCategory(catCode); // tag status as inactive
				i = 1;
            }
            else {
            	i = 0;
            	this.errorMssg = "Meeting Setup Not Deleted Successfully";
            }          
		}
		catch (Exception localException1) {
			localException1.printStackTrace();
			localHttpSession.setAttribute("errmsg", localException1.toString());
			i = 0;
		}
		finally {
			localDBConnectionPool.returnConnection(conn);
		}

		if (i != 0)
			CommonFunction.printAlert(request, response, "Record successfully deleted.", request.getHeader("Referer"));
		else
			CommonFunction.printAlert(request, response, this.errorMssg, request.getHeader("Referer"));
  }
}