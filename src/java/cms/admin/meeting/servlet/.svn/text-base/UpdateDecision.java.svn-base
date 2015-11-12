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
 * @web.servlet name = "upddecision"
 * @web.servlet-mapping url-pattern = "/upddecision"
 */
public class UpdateDecision extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	String mtgCode;
	String decisionLevel;
	String decisionSeqno;
	String parentDecision;
	String sortSeq;
	String numbering;
	String errorMssg;
	String decisionSeq;
	String decision;
	String agendaSeq;
	String formName;
	String dueDate;
	String decisionCategory = null;

	public UpdateDecision() {
	    this.mtgCode = null;
	    this.decisionLevel = null;
	    this.decisionSeqno = null;
	    this.parentDecision = null;
	    this.sortSeq = null;
	    this.numbering = null;
	    this.errorMssg = "ERROR";
	    this.decisionSeq = null;
	    this.decision = null;
	    this.agendaSeq = null;
	    this.formName = null;
	    this.dueDate = null;
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
    	throws ServletException, IOException
    {
		doPost(request, response);
    }

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
	    formName = request.getParameter("formName");
	    dueDate = request.getParameter("dueDate");
	    decisionSeq = request.getParameter("decisionSeq");
	    decisionCategory = request.getParameter("decisionCat");
	    
	    String str3 = (String)session.getAttribute("decisionMtgCode");
	    session.removeAttribute("errmsg");
   
	    if ((this.decision == null) || (this.decision.length() == 0))
	    {
	    	this.errorMssg = "The decision is not specified.";
	    	i = 0;
	    }
	    if (i != 0)
	    {
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
	    			if (md != null) {
	    				md.setDBConnection(conn);
	    				md.setDecisionSeq(this.decisionSeq);
	    				md.setAgendaSeq(this.agendaSeq.trim());
	    				md.setDecision(this.decision);
	    				md.setDecisionLevel(this.decisionLevel);
	    				md.setDecisionSeqno(this.decisionSeqno.trim());
	    				md.setParentDecision(this.parentDecision);
	    				md.setSortSeq(this.sortSeq);
	    				md.setNumbering(this.numbering);
	    				md.setDueDate(this.dueDate);
	    				md.setDecisionCategory(decisionCategory);
	    				
	    				String action = request.getParameter("action");
	    				if (action.equals("Update")) {
	    					if (md.updateMtgDecision()) {
	    						i = 1;
	    					}
	    					else {
	    						i = 0;
	    						this.errorMssg = "Update Not Successful";
	    						session.setAttribute("errmsg", md.getErrorMessage() + md.getSQL());
	    					}
	    				}
	    				else if (action.equals("Remove")) {
	    					if (md.removeMtgDecision(request, super.getServletContext(), this.agendaSeq))
	    					{
	    						i = 1;
	    					}
	    					else {
	    						this.errorMssg = "Delete not Successful";
	    						i = 0;
	    					}
	    				}
	    				else if (action.equals("updateDecCat")) {
	    					if (md.updateDecisionCategory()) {
	    						i = 1;
	    					}
	    					else {
	    						this.errorMssg = "Update not Successful";
	    						i = 0;
	    					}
	    				}	    				
	    			}
	    			else {
	    				i = 0;
	    				this.errorMssg = "Meeting Decision object is not available.";
	    			}
	    		}
	    		else {
	    			i = 0;
	    			this.errorMssg = "Connection to database is not available.";
	    		}
	    	}
	    	catch (Exception ex)
	    	{
	    		this.errorMssg = "Error";
	    		ex.printStackTrace();
	    		session.setAttribute("errmsg", ex.toString());
	    		i = 0;
	    	}
	    	finally {
	    		dbPool.returnConnection(conn);
	    	}
	    }
	    if (i != 0)
	    	CommonFunction.printAlert(request, response, "Update Successful", "eMeeting.jsp?action=Decision&meetingCode=" + str3 + "#" + this.formName);
	    else
	    	CommonFunction.printAlert(request, response, this.errorMssg, "eMeeting.jsp?action=Decision&meetingCode=" + str3 + "#" + this.formName);
    }
}