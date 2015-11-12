<%@ page session="true" %>
<%
    String action = null;
    
   if (request.getParameter("action") == null)
        action = "main";
    else
        action = request.getParameter("action");

	if (action.equals("main")) {
        pageContext.include("/cms/eRecruitment/index.jsp");
    }
	else if (action.equals("daftar")) {
         pageContext.include("/cms/eRecruitment/register/register.jsp");
    }
	else if (action.equals("register")) {
         pageContext.include("/cms/eRecruitment/register/register.jsp");
    }
	else if (action.equals("login")) {
         pageContext.include("/cms/eRecruitment/login/login.jsp");
    }
	else if (action.equals("mainpage")) {
         pageContext.include("/cms/eRecruitment/login/mainpage.jsp");
    }
	else if (action.equals("logout")) {
         pageContext.include("/cms/eRecruitment/logout/logout.jsp");
    }
	else if (action.equals("lupakatalaluan")) {
         pageContext.include("/cms/eRecruitment/login/lupakatalaluan.jsp");
    }
	else if (action.equals("sendkatalaluan")) {
         pageContext.include("/cms/eRecruitment/login/sendkatalaluan.jsp");
    }
	else if (action.equals("contact")) {
         pageContext.include("/cms/eRecruitment/contactus.jsp");
    }	
	else if (action.equals("editregistration")) {
         pageContext.include("/cms/eRecruitment/register/editregistration.jsp");
    }
		else if (action.equals("editpermohonan")) {
         pageContext.include("/cms/eRecruitment/register/editregistration.jsp");
    }	
	else if (action.equals("borangpermohonan")) {
         pageContext.include("/cms/eRecruitment/apply/borangpermohonan.jsp");
    }
	else if (action.equals("borang")) {
         pageContext.include("/cms/eRecruitment/apply/borang.jsp");
    }
	else if (action.equals("save")) {
         pageContext.include("/cms/eRecruitment/apply/save.jsp");
    }
	else if (action.equals("finish")) {
         pageContext.include("/cms/eRecruitment/apply/finish.jsp");
    }	
	else if (action.equals("editborang")) {
         pageContext.include("/cms/eRecruitment/apply/editborangpermohonan.jsp");
    }
	else if (action.equals("edit_post1")) {
         pageContext.include("/cms/eRecruitment/apply/post1_edit.jsp");
    }
	else if (action.equals("edit_post2")) {
         pageContext.include("/cms/eRecruitment/apply/post2_edit.jsp");
    }
	else if (action.equals("editpost1")) {
         pageContext.include("/cms/eRecruitment/apply/post1_edit.jsp");
    }
	else if (action.equals("editpost2")) {
         pageContext.include("/cms/eRecruitment/apply/post2_edit.jsp");
    }
	else if (action.equals("edit")) {
         pageContext.include("/cms/eRecruitment/apply/edit.jsp");
    }
	else if (action.equals("print")) {
         pageContext.include("/cms/eRecruitment/apply/print.jsp");
    }
	else if (action.equals("upload")) {
         pageContext.include("/cms/eRecruitment/apply/upload.jsp");
    }
	else if (action.equals("deleteFile")) {
         pageContext.include("/cms/eRecruitment/apply/delete.jsp");
    }
	else if (action.equals("session")) {
         pageContext.include("/cms/eRecruitment/session.jsp");
    }
	else if (action.equals("print_detail")) {
         pageContext.include("/cms/eRecruitment/register/print.jsp");
    }
	else if (action.equals("cetak")) {
         pageContext.include("/cms/eRecruitment/apply/cetak.jsp");
    }
	else if (action.equals("soalselidik")) {
         pageContext.include("/cms/eRecruitment/survey/soalselidik.jsp");
    }	
	else if (action.equals("sendSurvey")) {
         pageContext.include("/cms/eRecruitment/survey/save.jsp");
    }
	else if (action.equals("edit_jawatan")) {
         pageContext.include("/cms/eRecruitment/apply/edit_jawatan.jsp");
    }
		else if (action.equals("editJawatan")) {
         pageContext.include("/cms/eRecruitment/apply/edit_jawatan.jsp");
    }
		else if (action.equals("admin")) {
         pageContext.include("/cms/eRecruitment/admin/login.jsp");
    }	
		else if (action.equals("login_admin")) {
         pageContext.include("/cms/eRecruitment/admin/login.jsp");
    }	
		else if (action.equals("main_admin")) {
         pageContext.include("/cms/eRecruitment/admin/main.jsp");
    }
		else if (action.equals("iklan")) {
         pageContext.include("/cms/eRecruitment/iklan.jsp");
    }
		else if (action.equals("logout_admin")) {
         pageContext.include("/cms/eRecruitment/admin/logout.jsp");
    }	
%>
