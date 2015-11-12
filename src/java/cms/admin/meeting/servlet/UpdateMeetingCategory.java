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
 * @web.servlet name = "updateMtgCat"
 * @web.servlet-mapping url-pattern = "/updateMtgCat"
 */
public class UpdateMeetingCategory extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	String mtgCatDesc = null;
	String mtgDeptCode = null;
	String errorMssg = null;
	String mtgCatCode = null;

	public void doPost(HttpServletRequest request, HttpServletResponse response)
    	throws IOException, ServletException
    {
	    int i = 1;
	    HttpSession localHttpSession = request.getSession(true);
	    DBConnectionPool localDBConnectionPool = null;
	    Connection conn = null;
	    
		mtgCatCode = request.getParameter("mtgCatCode");
		mtgCatDesc = request.getParameter("mtgCatDesc");
		mtgDeptCode = request.getParameter("mtgDeptCode");

		try {
			localDBConnectionPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
			conn = localDBConnectionPool.getConnection();
			if (conn != null) {
				MeetingCategory mtgCategory = (MeetingCategory)localHttpSession.getAttribute("mtgCat");
				if (mtgCategory == null) {
					mtgCategory = (MeetingCategory)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingCategory");

					localHttpSession.setAttribute("mtgCat", mtgCategory);
				}

				if (mtgCategory != null) {
					mtgCategory.setDBConnection(conn);
					mtgCategory.setMtgCatDesc(mtgCatDesc);
					mtgCategory.setMtgDeptCode(mtgDeptCode);

					if (mtgCategory.updateMeetingCategory(mtgCatCode.trim()))
						i = 1;              
					else {
						i = 0;
						this.errorMssg = mtgCategory.getErrorMessage();
					}
				}
				else {
					i = 0;
					this.errorMssg = "Meeting Type object is not available.";
				}
			}
			else {
				i = 0;
				this.errorMssg = "Connection to database is not available.";
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			localHttpSession.setAttribute("errmsg", e.toString());
			i = 0;
		}
		finally {
			localDBConnectionPool.returnConnection(conn);
		}

		if (i != 0)
			CommonFunction.printAlert(request, response, "Record successfully saved.", request.getHeader("Referer"));
		else
			CommonFunction.printAlert(request, response, this.errorMssg, request.getHeader("Referer"));
  }
}