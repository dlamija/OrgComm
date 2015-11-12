package cms.admin.meeting.servlet;

import cms.admin.meeting.bean.MeetingAgenda;
import java.beans.Beans;
import java.io.IOException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import common.CommonFunction;
import common.DBConnectionPool;
import tvo.TvoDBConnectionPoolFactory;

/**
 * @web.servlet name = "updagenda"
 * @web.servlet-mapping url-pattern = "/updagenda"
 */
public class UpdateAgenda extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	String mtgCode;
	String agendaDesc;
	String agendaLevel;
	String agendaSeqno;
	String parentAgenda;
	String sortSeq;
	String numbering;
	String errorMssg;
	String agendaSeq;
	String formName;
	String originalFileName;
	String physicalFileName;
	String attachDept = null;

	public UpdateAgenda() {
	    this.mtgCode = null;
	    this.agendaDesc = null;
	    this.agendaLevel = null;
	    this.agendaSeqno = null;
	    this.parentAgenda = null;
	    this.sortSeq = null;
	    this.numbering = null;
	    this.errorMssg = "ERROR";
	    this.agendaSeq = null;
	    this.formName = null;
	    this.originalFileName = null;
	    this.physicalFileName = null;
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
	    String action = request.getParameter("action");
	    
	    agendaSeq = request.getParameter("agendaSeq");
	    agendaDesc = request.getParameter("agendaDesc");
	    agendaLevel = request.getParameter("agendaLevel");
	    agendaSeqno = request.getParameter("agendaSeqno");
	    parentAgenda = request.getParameter("parentAgenda");
	    sortSeq = request.getParameter("sortSeq");
	    numbering = request.getParameter("numbering");
	    formName = request.getParameter("formName");
	    attachDept = request.getParameter("deptAtt");
	    
	    String meetingCode = (String)session.getAttribute("agendaMtgCode");
	    session.removeAttribute("errmsg");
	    if ("updateAttachDept".equals(action)) {
	    	if (attachDept == null || attachDept.length() == 0) {
	    		errorMssg = "The attachment department is not specified.";
		    	i = 0;
	    	}
	    }
	    else {
		    if ((agendaDesc == null) || (agendaDesc.length() == 0)) {
		    	errorMssg = "The agenda is not specified.";
		    	i = 0;
		    }
	    }
	    
	    i = 1;
	    if (i != 0) {
	    	Connection conn = null;
	    	DBConnectionPool dbPool = null;
	    	try {
	    		dbPool = TvoDBConnectionPoolFactory.getConnectionPool(request);
	    		conn = dbPool.getConnection();
	    		if (conn != null) {	    			
	    			MeetingAgenda ma = (MeetingAgenda)session.getAttribute("mtgagenda");
	    			if (ma == null) {
	    				ma = (MeetingAgenda)Beans.instantiate(super.getClass().getClassLoader(), "cms.admin.meeting.bean.MeetingAgenda");
	    				session.setAttribute("mtgagenda", ma);
	    			}
	    			if (ma != null) {
	    				ma.setDBConnection(conn);
	    				ma.setAgendaDesc(this.agendaDesc);
	    				ma.setAgendaLevel(this.agendaLevel);
	    				ma.setAgendaSeqno(this.agendaSeqno);
	    				ma.setParentAgenda(this.parentAgenda);
	    				ma.setSortSeq(this.sortSeq);
	    				ma.setNumbering(this.numbering);
	    				if (action.equals("Update")) {
	    					if (ma.updateMtgAgenda(this.agendaDesc.trim(), this.agendaSeq.trim(), meetingCode.trim())) {
	    						i = 1;
	    					}
	    					else {
	    						i = 0;
	    						errorMssg = "Update Not Successful";
	    						session.setAttribute("errmsg", ma.getErrorMessage() + ma.getSQL());
	    					}
	    				}
	    				else if (action.equals("Remove")) {
	    					if (!(ma.hasChild(meetingCode, this.agendaSeq))) {
	    						if (ma.removeMtgAgenda(request, super.getServletContext(), agendaSeq, meetingCode, sortSeq, parentAgenda, agendaSeqno))
	    						{
	    							i = 1;
	    							ma.updateAgendaNumbering(meetingCode);
	    						}
	    						else {
	    							errorMssg = "Delete not Successful";
	    							i = 0;
	    						}
	    					}
	    					else {
	    						this.errorMssg = "Please Delete SubAgenda First";
	    						i = 0;
	    					}
	    				}
	    				else if (action.equals("updateAttachDept")) {
	    					if (ma.updateAttachmentDept(attachDept.trim(), agendaSeq.trim(), meetingCode.trim())) {
	    						i = 1;
	    					}
	    					else {
	    						i = 0;
	    						errorMssg = "Update Not Successful";
	    						session.setAttribute("errmsg", ma.getErrorMessage() + ma.getSQL());
	    					}
	    				}	    					
	    			}
	    			else {
	    				i = 0;
	    				this.errorMssg = "Meeting Agenda object is not available.";
	    			}
	    			conn.close();
	    		}
	    		else {
	    			i = 0;
	    			this.errorMssg = "Connection to database is not available.";
	    		}
	    	}
	    	catch (Exception ex) {
	    		session.setAttribute("errmsg", ex.toString());
	    		i = 0;
	    	}
	    	finally {
	    		dbPool.returnConnection(conn);
	    	}
	    }
    	if (i != 0)
    		CommonFunction.printAlert(request, response, "Update Successful", "eMeeting.jsp?action=Agenda&meetingCode=" + meetingCode + "#" + this.formName);
    	else
    		CommonFunction.printAlert(request, response, this.errorMssg, "eMeeting.jsp?action=Agenda&meetingCode=" + meetingCode + "#" + this.formName);
  }
}