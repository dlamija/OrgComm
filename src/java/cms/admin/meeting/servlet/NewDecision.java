package cms.admin.meeting.servlet;

import cms.admin.meeting.bean.MeetingDecision;
import java.beans.Beans;
import java.io.IOException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import common.CommonFunction;
import common.DBConnectionPool;
import tvo.TvoDBConnectionPoolFactory;

/**
 * @web.servlet name = "adddecision"
 * @web.servlet-mapping url-pattern = "/adddecision"
 */
public class NewDecision extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	String mtgCode = null;
	String decisionLevel = null;
	String decisionSeqno = null;
	String parentDecision = null;
	String sortSeq = null;
	String numbering = null;
	String errorMssg = null;
	String decisionSeq = null;
	String decision = null;
	String agendaSeq = null;
	String dueDate = null;

	public void doPost(HttpServletRequest request, HttpServletResponse response)
    	throws IOException, ServletException
    {
	    int i = 1;
	    HttpSession session = request.getSession(true);

	    agendaSeq = request.getParameter("agendaSeq");
	    decision = request.getParameter("decision");
	    decisionLevel = request.getParameter("decisionLevel");
	    decisionSeqno = request.getParameter("decisionSeqno");
	    parentDecision = request.getParameter("parentDecision");
	    sortSeq = request.getParameter("sortSeq");
	    numbering = request.getParameter("numbering");
	    mtgCode = request.getParameter("mtgCode");
	    dueDate = request.getParameter("dueDate");

	    session.removeAttribute("errmsg");

	    if ((decision == null) || (decision.length() == 0)) {
	    	errorMssg = "The decision is not specified.";
	    	i = 0;
	    }

	    if (i != 0) {
	    	Connection conn = null;
	    	DBConnectionPool dbPool = null;
	    	try
	    	{
	    		dbPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
	    		conn = dbPool.getConnection();

	    		if (conn != null)
	    		{
	    			MeetingDecision md = (MeetingDecision)session.getAttribute("mtgdecision");
	    			if (md == null) {
	    				md = (MeetingDecision)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingDecision");

	    				session.setAttribute("mtgdecision", md);
	    			}

	    			if (md != null)
	    			{
			            md.setDBConnection(conn);
			            md.setAgendaSeq(this.agendaSeq);
			            md.setDecision(this.decision);
			            md.setDecisionLevel(this.decisionLevel);
			            md.setDecisionSeqno(this.decisionSeqno);
			            md.setParentDecision(this.parentDecision);
			            md.setSortSeq(this.sortSeq);
			            md.setNumbering(this.numbering);
			            md.setMtgCode(this.mtgCode);
			            md.setDueDate(dueDate);

			            if (md.addMtgDecision(this.agendaSeq))
			            {
			            	i = 1;
			            	this.decisionSeq = md.getDecisionSeq();
			            }
			            else {
			            	i = 0;
			            	this.errorMssg = md.getErrorMessage() + md.getSQL();
			            }
	    			}
	    			else
	    			{
	    				i = 0;
	    				this.errorMssg = "Meeting Decision object is not available.";
	    			}

	    			//conn.close();
	    		}
	    		else {
	    			i = 0;
	    			this.errorMssg = "Connection to database is not available.";
	    		}
	    	}
	    	catch (Exception localException1)
	    	{
	    		session.setAttribute("errmsg", localException1.toString());
	    		i = 0;
	    	}
	    	finally {
	    		dbPool.returnConnection(conn);
	    	}
	    }
	    if (i != 0) {
	    	CommonFunction.printAlert(request, response, "Decision Created Successfully", "eMeeting.jsp?action=Decision&meetingCode=" + this.mtgCode + "#" + this.decisionSeq + "_updateDecisionForm");
	    }
	    else
	    	CommonFunction.printAlert(request, response, this.errorMssg, "eMeeting.jsp?action=Decision&meetingCode=" + this.mtgCode + "#" + this.decisionSeq + "_updateDecisionForm");
    }
}