<%@ page session="true" %>
<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="javax.naming.*" %>
<jsp:useBean class="cms.staff.StaffValidator" id="cmsStaffValidator" scope="page"/>
	<%

	Connection conn=null;
	String sid= (String)session.getAttribute("staffid");
	try
	{
		Context initCtx = new InitialContext();
	    Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
    	DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
    	conn = ds.getConnection();

    	cmsStaffValidator.setDBConnection(conn);
    	
		}
		catch( Exception e )
		{ 
			out.println (e.toString()); 
		}
		
		boolean status = false;
		cmsStaffValidator.setStaffId(sid);
  		boolean staffHasSubordinate = cmsStaffValidator.hasSubordinate();	
			if(staffHasSubordinate == true)
				status = true;
			else
				status = false;

if (status)
{

    String action = null;
	
    if (request.getParameter("action") == null)
        action = "main";
    else
        action = request.getParameter("action");

	if (action.equals("main")) {
        pageContext.include("/cms/EIS/main_linkA.jsp");
    }
	else if (action.equals("main_linkB")) {
        pageContext.include("/cms/EIS/main_linkB.jsp");
	}
	else if (action.equals("main_linkB2")) {
        pageContext.include("/cms/EIS/main_linkB2.jsp");
	}
	else if (action.equals("main_linkB3")) {
        pageContext.include("/cms/EIS/main_linkB3.jsp");
	}
	else if (action.equals("main_linkB4")) {
        pageContext.include("/cms/EIS/main_linkB4.jsp");
	}
	else if (action.equals("main_linkB5")) {
        pageContext.include("/cms/EIS/main_linkB5.jsp");
	}
	else if (action.equals("main_linkB6")) {
        pageContext.include("/cms/EIS/main_linkB6.jsp");
	}
	else if (action.equals("main_linkB7")) {
        pageContext.include("/cms/EIS/main_linkB7.jsp");
	}
	else if (action.equals("approve_ptk")) {
        pageContext.include("/cms/EIS/approve_ptk.jsp");
	}
	else if (action.equals("approve_skt")) {
        pageContext.include("/cms/EIS/approve_skt.jsp");
	}
	else if (action.equals("approve_harta")) {
        pageContext.include("/cms/EIS/approve_harta.jsp");
	}
	else if (action.equals("approve_wo2")) {
        pageContext.include("/cms/EIS/approve_wo2.jsp");
	}
	else if (action.equals("approve_leave_timeoff")) {
        pageContext.include("/cms/EIS/approve_leave_timeoff.jsp");
	}
	else if (action.equals("approve_ot")) {
        pageContext.include("/cms/EIS/approve_ot.jsp");
	}
	else if (action.equals("approve_btn")) {
        pageContext.include("/cms/EIS/approve_btn.jsp");
	}
	else if (action.equals("timeoffApplication")) {
        pageContext.include("/cms/EIS/timeoffApplication.jsp");
	}
	else if (action.equals("attendance_report")) {
        pageContext.include("/cms/EIS/attendance_report.jsp");
	}
	else if (action.equals("wo_viewdetailhod")) {
        pageContext.include("/cms/EIS/wo_viewdetailhod.jsp");
	}
	else if (action.equals("main_graph")) {
        pageContext.include("/cms/EIS/main_graph.jsp");
    }  
	 else if (action.equals("graph")) {
        pageContext.include("/cms/EIS/graph.jsp");
    }
	else if (action.equals("report_induction")) {
        pageContext.include("/cms/EIS/report_induction.jsp");
	}
	else if (action.equals("main_graphatt")) {
        pageContext.include("/cms/EIS/main_graphatt.jsp");
	}
	else if (action.equals("graphatt")) {
        pageContext.include("/cms/EIS/graphatt.jsp");
	}
	else if (action.equals("main_graph_timeoff")) {
        pageContext.include("/cms/EIS/main_graph_timeoff.jsp");
	}
	else if (action.equals("graph_timeoff")) {
        pageContext.include("/cms/EIS/graph_timeoff.jsp");
	}
	else if (action.equals("testgraph")) {
        pageContext.include("/cms/EIS/testgraph.jsp");
	}
	else if (action.equals("main_graph_leave")) {
        pageContext.include("/cms/EIS/main_graph_leave.jsp");
	}
		else if (action.equals("graph_leave")) {
        pageContext.include("/cms/EIS/graph_leave.jsp");
	}
	else if (action.equals("report_leave")) {
        pageContext.include("/cms/EIS/report_leave.jsp");
	}
		else if (action.equals("report_induksi")) {
        pageContext.include("/cms/EIS/report_induksi.jsp");
	}
	else if (action.equals("main_graph_wo")) {
        pageContext.include("/cms/EIS/main_graph_wo.jsp");
	}
	else if (action.equals("graph_wo")) {
        pageContext.include("/cms/EIS/graph_wo.jsp");
	}
	else if (action.equals("main_graph_assessment")) {
        pageContext.include("/cms/EIS/main_graph_assessment.jsp");
	}
	else if (action.equals("graph_assessment")) {
        pageContext.include("/cms/EIS/graph_assessment.jsp");
	}
	else if (action.equals("result_assessment")) {
        pageContext.include("/cms/EIS/result_assessment.jsp");
	}
	else if (action.equals("view_assessment")) {
        pageContext.include("/cms/EIS/view_assessment.jsp");
	}
	else if (action.equals("main_graph_ot")) {
        pageContext.include("/cms/EIS/main_graph_ot.jsp");
	}
	else if (action.equals("graph_ot")) {
        pageContext.include("/cms/EIS/graph_ot.jsp");
	}
	else if (action.equals("graph_leave2")) {
        pageContext.include("/cms/EIS/graph_leave2.jsp");
	}
	else if (action.equals("main_graph_leave2")) {
        pageContext.include("/cms/EIS/main_graph_leave2.jsp");
	}
	else if (action.equals("main_graph_wo3")) {
        pageContext.include("/cms/EIS/main_graph_wo3.jsp");
	}
	else if (action.equals("graph_wo3")) {
        pageContext.include("/cms/EIS/graph_wo3.jsp");
	}
	else if (action.equals("result_assessment2")) {
        pageContext.include("/cms/EIS/result_assessment2.jsp");
	}
	else if (action.equals("report_ot")) {
        pageContext.include("/cms/EIS/report_ot.jsp");
	}
///report
	else if (action.equals("workorderMain")) {
        pageContext.include("/cms/EIS/workorderMain.jsp");
	}
	else if (action.equals("module")) {
        pageContext.include("/cms/EIS/module.jsp");
	}
	else if (action.equals("attendance_no")) {
        pageContext.include("/cms/EIS/attendance_no.jsp");
	}
	else if (action.equals("report_slot")) {
        pageContext.include("/cms/EIS/report_slot.jsp");
	}
	else if (action.equals("report_slot_detl")) {
        pageContext.include("/cms/EIS/report_slot_detl.jsp");
	}
	else if (action.equals("report_mark_ipta")) {
        pageContext.include("/cms/EIS/report_mark.jsp");
	}
	else if (action.equals("report_mark_ipta2")) {
        pageContext.include("/cms/EIS/report_mark.jsp");
	}
	else if (action.equals("report_mark_kuktem")) {
        pageContext.include("/cms/EIS/report_mark2.jsp");
	}
	else if (action.equals("report_mark_kuktem2")) {
        pageContext.include("/cms/EIS/report_mark2.jsp");
	}
	else if (action.equals("report_mark_ipta3")) {
        pageContext.include("/cms/EIS/report_mark3.jsp");
	}
	else if (action.equals("report_mark_kuktem4")) {
        pageContext.include("/cms/EIS/report_mark4.jsp");
	}
	//else if (action.equals("report_mark_ipta5")) {
      //  pageContext.include("/cms/EIS/report_mark3.jsp");
	//}
	//else if (action.equals("report_mark_kuktem6")) {
      //  pageContext.include("/cms/EIS/report_mark4.jsp");
	//}*/
		} else {
%>
You are not authorize
<%}%>

