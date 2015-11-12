<% // Module Manager - Personal
if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_PERSONAL) ) {

  vModule = (Vector) CommonFunction.listToVector((String) selectedModule.getObj("topModule"));
  vAllModules = (Vector) beanPersonal.getTopModule(request);
  CommonObject tempCommonObject = null;

//Load Personalised Top Content Start
if ( selectedModule != null && !("".equals(selectedModule.getObj("topModule"))) &&
     !("-1".equals(selectedModule.getObj("topModule"))) ) {

  for (i=0; (vModule != null && vModule.size() > i); i++)  {
    currentModule = (String) vModule.get(i);
%>

    <jsp:useBean id="beanCalendarWeekACL" scope="request" class="ecomm.bean.ACL" />
  <%
    beanCalendarWeekACL.initTVO(request);
    Hashtable usrCalendarACL, grpCalendarACL;
    usrCalendarACL = beanCalendarWeekACL.getRights(userID, "Calendar", "User");
    grpCalendarACL = beanCalendarWeekACL.getRights(userID, "Calendar", "Group");




//System.out.println(((String)tempCommonObject.getObj("topHomeOnly")));
    //check if this is calendarweek and is not alowed to be shown other than on Home
     if ( currentModule.equals("calendarweek") ) {
      if ( (usrCalendarACL.containsKey("view") && usrCalendarACL.get("view").equals("1") ) ||
      (grpCalendarACL.containsKey("view") &&  grpCalendarACL.get("view").equals("1")) )
      {
       tempCommonObject = (CommonObject) beanPersonal.getCalendarWeek(request, userID);
       if ( tempCommonObject != null && !request.getServletPath().equals("/home.jsp") )
          continue;
      }
      //else
      //  vModule.remove(i);
	  System.out.println("kalendar : "+usrCalendarACL.get("view"));
System.out.println("kalendar2 : "+grpCalendarACL.get("view"));
System.out.println("kalendar3 : "+ ((String)tempCommonObject.getObj("topHomeOnly")));

    }

    if ( (usrCalendarACL.containsKey("view") && usrCalendarACL.get("view").equals("1") ) ||
        (grpCalendarACL.containsKey("view") &&  grpCalendarACL.get("view").equals("1")) )
    {
    if ((vAllModules.toString()).indexOf(currentModule) != -1) {
      if (currentModule.equals("calendarweek")) {
          %>
        <%@ include file="/includes/personalOutputTopCalendarWeek.jsp"%>

<SCRIPT LANGUAGE="javascript">
<!--
  loadBox('topcalendarweek');
//-->
</SCRIPT>
       <%
       }
      }
    }
  }
}   //Load Personalised Top Content End

} %>
