<%@ page session="true" %>
<%
    String action = null;
    
   	if (request.getParameter("action") == null)
        action = "main";
    else
        action = request.getParameter("action");

	if (action.equals("main")) {
        pageContext.include("/cms/announcement/main.jsp");
    }
	else if (action.equals("add")) {
         pageContext.include("/cms/announcement/entry/main.jsp");
    }
	else if (action.equals("previous")) {
         pageContext.include("/cms/announcement/previous.jsp");
    }
	else if (action.equals("save")) {
         pageContext.include("/cms/announcement/entry/save.jsp");
    }
	else if (action.equals("edit")) {
         pageContext.include("/cms/announcement/entry/edit.jsp");
    }
	else if (action.equals("delete")) {
         pageContext.include("/cms/announcement/entry/delete.jsp");
    }
	else if (action.equals("update")) {
         pageContext.include("/cms/announcement/entry/update.jsp");
    }
	else if (action.equals("approve")) {
         pageContext.include("/cms/announcement/approve.jsp");
    }	
	else if (action.equals("viewstd")) {
         pageContext.include("/cms/announcement/view_student.jsp");
    }
	else if (action.equals("rejectstd")) {
         pageContext.include("/cms/announcement/view_student.jsp");
    }	
	else if (action.equals("archive")) {
         pageContext.include("/cms/announcement/archive.jsp");
    }	
	else if (action.equals("mpp_authorize")) {
         pageContext.include("/cms/announcement/entry/mpp_authorize.jsp");
    }	
	else if (action.equals("insert_mpp")) {
         pageContext.include("/cms/announcement/entry/mpp_authorize.jsp");
    }
	else if (action.equals("delete_mpp")) {
         pageContext.include("/cms/announcement/entry/mpp_authorize.jsp");
    }	
	else if (action.equals("search")) {
        pageContext.include("/cms/announcement/search.jsp");
   }
%>
