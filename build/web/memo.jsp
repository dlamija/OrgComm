<%@ page import="utilities.LoggingUtil" %>
<%@ page import="common.*" %>
<%
	/*
		Dynamically includes one of the two parts of memo module to reduce the size of the compiled code
	*/
	
	{
		String userID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
		LoggingUtil logUtil = new LoggingUtil();
		logUtil.initTVO(request);
		logUtil.recordModule(userID, "Memo");
	}
	
	String[] partOne = {"compose", "reply", "draft", "sendagain", "forward", "replyAll", "folders","folders2"};
	
	String action = request.getParameter("action");
	
	boolean inPartOne = false;
	
	if (action==null)
		action="folders";
	
	if (action != null) {	
		for (int i=0; i<partOne.length; i++) {
			if (action.equals(partOne[i])) {
				inPartOne = true;
				break;
			}
		}
	}
	
	if (inPartOne)
		pageContext.include("/template/default/memo_split1.jsp");
	else if( action.equals("print"))
		pageContext.include("/includes/memoPrintMemo.jsp");
	//20100628 AidyAziziSyahmi - new portion to print orcl report.
	else if( action.equals("printPdf") ) 
		pageContext.include("/includes/memoPrintOrclReport.jsp");
	else
		pageContext.include("/template/default/memo_split2.jsp");

%>































