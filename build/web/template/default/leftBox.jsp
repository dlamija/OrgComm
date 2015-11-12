  <!--% 
  // Module Manager - Personal
  if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_PERSONAL) ) { %>
    <jsp:include page="/personalOutput.jsp" flush="true">
      <jsp:param name="outputLocation" value="left" />
    </jsp:include>
  < % } 	else { % -->
  
    <!--%@ include file="/template/default/monthBox.jsp" % -->
    <%@ include file="/template/default/menuBox.jsp" %>
  <!-- % } // Module Manager - Personal % --> 

