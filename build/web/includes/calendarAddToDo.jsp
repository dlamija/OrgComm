<jsp:useBean id="staffStudent2" scope="request" class="common.StaffStudent"/>
<% 
    String userType = staffStudent2.getUserType(request,response, userID); 
    int i,parameterInt = -1;
  
    Vector resourceIDs=null, resourceName=null, resourceApproval=null, resourceList=null;
    String resourceID="", selected="",parameterStr="";
    TvoContextManager.removeSessionAttribute(request, "Calendar.vConflicts");
  
    // Module Manager - Resource
    if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_RESOURCE) ) {
      resourceList = beanResource.showModule(request, userID, "Resource", "calView", "resourceName", "asc", 0, 0);
      if (request.getParameter("resourceID") != null)
        resourceID = request.getParameter("resourceID");

      if (resourceList != null && resourceList.size() > 0) {
        resourceIDs = (Vector) resourceList.get(0);
        resourceName = (Vector) resourceList.get(1);
        resourceApproval = (Vector) resourceList.get(5);
      }
    } // Module Manager - Resource

    if (request.getParameter("dueDay") != null) 
      parameterInt = Integer.parseInt(request.getParameter("dueDay"));
%>

<script>
<!--
	var recipientWin;
	
 	function recipientPopup() {
		if (recipientWin == null || recipientWin.closed) {
			recipientWin = window.open('calendarrecipient.jsp?popupType=todo', 'recipientPopup', 'width=600,height=450,resizable=yes,scrollbars=yes');
		}
		recipientWin.focus();
	}
	
	function getRecipient(columnName) {
		var myFormField = eval("document.calendarToDo." + columnName);
		if (myFormField != null) {
			return(myFormField.value);
		} else {
			return("");
		}
	}
	
	function updateRecipient(columnName, newValue) {
		var myFormField = eval("document.calendarToDo." + columnName);
		if (myFormField != null) {
			myFormField.value = newValue;
		}
	}
	
	function updateDisplay(columnType, newValue) {
		var myFormField = eval("document.calendarToDo.dispRecipient" + columnType);
		if (myFormField != null) {
			myFormField.value = newValue;
		}
	}
//-->
</script>

<FORM NAME="calendarToDo" ENCTYPE="multipart/form-data" METHOD="POST" ACTION="Calendar?action=addCheckToDo">  	
  <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" WIDTH="32%" ALIGN="RIGHT" VALIGN="MIDDLE"><%= messages.getString("calendar.todo.due.date") %>&nbsp; </TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" WIDTH="68%">
        <SELECT NAME="dueDay">
<%  for (i=1;i<32;i++) {  %>
			  <option value="<%= ( i>0 && i<10 ? "0":"")+i %>"<% if (parameterInt > -1 && parameterInt == i ) { %> SELECTED<% } %>><%= ( i>0 && i<10 ? "0":"")+i %> </option>
<%  }  %>		
        </SELECT>
<%  if (request.getParameter("dueMonth") != null) 
      parameterStr = request.getParameter("dueMonth");		
%>

        <SELECT NAME="dueMonth">
          <OPTION VALUE="01" <% if (!parameterStr.equals("") && parameterStr.equals("01") ) { %> SELECTED<% } %>><%= messages.getString("short.jan") %></option>
          <OPTION VALUE="02" <% if (!parameterStr.equals("") && parameterStr.equals("02") ) { %> SELECTED<% } %>><%= messages.getString("short.feb") %></OPTION>
          <OPTION VALUE="03" <% if (!parameterStr.equals("") && parameterStr.equals("03") ) { %> SELECTED<% } %>><%= messages.getString("short.mar") %></OPTION>
          <OPTION VALUE="04" <% if (!parameterStr.equals("") && parameterStr.equals("04") ) { %> SELECTED<% } %>><%= messages.getString("short.apr") %></OPTION>
          <OPTION VALUE="05" <% if (!parameterStr.equals("") && parameterStr.equals("05") ) { %> SELECTED<% } %>><%= messages.getString("short.may") %></OPTION>
          <OPTION VALUE="06" <% if (!parameterStr.equals("") && parameterStr.equals("06") ) { %> SELECTED<% } %>><%= messages.getString("short.jun") %></OPTION>
          <OPTION VALUE="07" <% if (!parameterStr.equals("") && parameterStr.equals("07") ) { %> SELECTED<% } %>><%= messages.getString("short.jul") %></OPTION>
          <OPTION VALUE="08" <% if (!parameterStr.equals("") && parameterStr.equals("08") ) { %> SELECTED<% } %>><%= messages.getString("short.aug") %></OPTION>
          <OPTION VALUE="09" <% if (!parameterStr.equals("") && parameterStr.equals("09") ) { %> SELECTED<% } %>><%= messages.getString("short.sep") %></OPTION>
          <OPTION VALUE="10" <% if (!parameterStr.equals("") && parameterStr.equals("10") ) { %> SELECTED<% } %>><%= messages.getString("short.oct") %></OPTION>
          <OPTION VALUE="11" <% if (!parameterStr.equals("") && parameterStr.equals("11") ) { %> SELECTED<% } %>><%= messages.getString("short.nov") %></OPTION>
          <OPTION VALUE="12" <% if (!parameterStr.equals("") && parameterStr.equals("12") ) { %> SELECTED<% } %>><%= messages.getString("short.dec") %></OPTION>

        </SELECT>
<%  if (request.getParameter("dueYear") != null) 
      parameterInt = Integer.parseInt(request.getParameter("dueYear"));		
%>

        <SELECT NAME="dueYear">
<%  
    for (i=Integer.parseInt((String)TvoContextManager.getAttribute(request, "System.startYear"));
    i <= Integer.parseInt((String)TvoContextManager.getAttribute(request, "System.endYear"));
    i++) {
        %><OPTION VALUE="<%= i %>" <% if (parameterInt > -1 && parameterInt == i ) { %> SELECTED<% } %>><%= i %></OPTION><% } %>
        </SELECT>
      </TD>
    </TR>
    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" COLSPAN="2" VALIGN="MIDDLE">&nbsp;&nbsp;</TD>
    </TR>
<%  if (request.getParameter("dueHour") != null) 
      parameterInt = Integer.parseInt(request.getParameter("dueHour"));		
%>

    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" WIDTH="32%" ALIGN="RIGHT" VALIGN="MIDDLE"><%= messages.getString("calendar.todo.due.time") %>&nbsp;  </TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" WIDTH="68%">
        <SELECT NAME="dueHour">
<%  for (i=0;i<24;i++) {  %>
		      <option value="<%= ( i>=0 && i<10 ? "0":"")+i %>" <% if (parameterInt > -1 && parameterInt == i ) { %> SELECTED<% } %>> <%= ( i>=0 && i<10 ? "0":"")+i %> </option>
<%  }  %>
        </SELECT> : 
<%  if (request.getParameter("dueMinute") != null) 
      parameterInt = Integer.parseInt(request.getParameter("dueMinute"));		
%>

        <SELECT NAME="dueMinute">
<%  for (i=0;i<60;i++) {  %>
			  <option value="<%= ( i>=0 && i<10 ? "0":"")+i %>" <% if (parameterInt > -1 && parameterInt == i ) { %> SELECTED<% } %>> <%= ( i>=0 && i<10 ? "0":"")+i %> </option>		  
<%  }  %>
        </SELECT>
      </TD>
    </TR>
    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT" VALIGN="MIDDLE">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="MIDDLE">&nbsp;</TD>
    </TR>
<%  
    parameterStr = "0";
    if (request.getParameter("reminderSetting") != null) 
      parameterStr = request.getParameter("reminderSetting");		
%>

    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT" VALIGN="MIDDLE"><%= messages.getString("calendar.addappt.set.reminder") %>&nbsp;&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="MIDDLE">
        <SELECT NAME="reminderSetting">
          <OPTION value="0" <% if (parameterStr.equals("0") ) { %> SELECTED<% } %>><%= messages.getString("none") %></OPTION>
          <OPTION value="1" <% if (parameterStr.equals("1") ) { %> SELECTED<% } %>><%= messages.getString("calendar.addappt.reminder.one.day") %></OPTION>
          <OPTION value="3" <% if (parameterStr.equals("3") ) { %> SELECTED<% } %>><%= messages.getString("calendar.addappt.reminder.three.day") %></OPTION>
          <OPTION value="5" <% if (parameterStr.equals("5") ) { %> SELECTED<% } %>><%= messages.getString("calendar.addappt.reminder.five.day") %></OPTION>
          <OPTION value="7" <% if (parameterStr.equals("7") ) { %> SELECTED<% } %>><%= messages.getString("calendar.addappt.reminder.one.week") %></OPTION>
          <OPTION value="14" <% if (parameterStr.equals("14") ) { %> SELECTED<% } %>><%= messages.getString("calendar.addappt.reminder.two.week") %></OPTION>
        </SELECT>
      </TD>
    </TR>
    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT" VALIGN="MIDDLE">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="MIDDLE">&nbsp;</TD>
    </TR>
    <INPUT TYPE="HIDDEN" NAME="repeatDay" VALUE="-2">
<% 
    if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_TAMS) ) {
      Vector vCategory = beanTams.getCategory(request,userID,true,true); 
      if (request.getParameter("tamsCategory") != null)
        parameterInt = Integer.parseInt(request.getParameter("tamsCategory"));
%>	
	   <TR VALIGN="TOP">
        <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT"><%= messages.getString("calendar.todo.category") %> &nbsp;&nbsp;</TD>
        <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%">
	    <SELECT name = "tamsCategory">
<% 
      if (vCategory != null && vCategory.size()>0) {
        for (i=0;i<vCategory.size();i++) {
	  TamsGroups Tams = (TamsGroups)vCategory.get(i);

	  if (Tams.getGroupName().equals("General"))
	    Tams.setGroupName(messages.getString("general"));
%>
		      <option value="<%= Tams.getTamsGroupID() %>"<% if (parameterInt > -1 && parameterInt == Tams.getTamsGroupID() ) { %> SELECTED<% } %>><%= Tams.getGroupName() %></option>
<%    
        }
      } 
%>
	    </select>
       </TD>
      </TR>
	
	  <TR VALIGN="TOP">
       <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT">&nbsp;</TD>
       <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%">&nbsp;</TD>
      </TR>
<%  
    }
    parameterStr = "";
    if (request.getParameter("description") != null)
      parameterStr = request.getParameter("description");
%>	  

	
    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT"><%= messages.getString("calendar.addappt.description") %> &nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%">
        <TEXTAREA NAME="description" COLS="23" ROWS="4" wrap><%= parameterStr %></TEXTAREA>
      </TD>
    </TR>
    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%">&nbsp;</TD>
    </TR>
	<%  
	    parameterStr = "";
	    if (request.getParameter("uploadedFile") != null) {
		  parameterStr = request.getParameter("uploadedFile");	   		 
    %>
		  <input type="hidden" name="uploadedFile" value="<%= parameterStr %>">
	      <TR VALIGN="TOP">
            <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" ALIGN="RIGHT" VALIGN="MIDDLE">Current File &nbsp;</TD>
            <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" VALIGN="MIDDLE">
              <P>
               <%= URLDecoder.decode(parameterStr) %>
              </P>
            </TD>
          </TR>
	<%  }  %>
    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" ALIGN="RIGHT" VALIGN="MIDDLE"><%= messages.getString("calendar.todo.attach.file") %> &nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" VALIGN="MIDDLE">
        <P>
          <INPUT TYPE="file" NAME="fileName">
        </P>
      </TD>
    </TR>
    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" ALIGN="RIGHT" VALIGN="MIDDLE">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" VALIGN="MIDDLE">&nbsp;</TD>
    </TR>
	<%
        parameterStr = "0";
	    if (request.getParameter("allowReassign") != null) 
		  parameterStr = request.getParameter("allowReassign");	   		 	
	%>
    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" ALIGN="RIGHT" VALIGN="TOP"><%= messages.getString("calendar.todo.allow.assign.task") %>?&nbsp;&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" VALIGN="TOP">
        <INPUT TYPE="radio" NAME="allowReassign" VALUE="0"<% if (parameterStr.equals("0") ) { %> CHECKED<% } %>><%= messages.getString("no") %>
		<INPUT TYPE="radio" NAME="allowReassign" VALUE="1"<% if (parameterStr.equals("1") ) { %> CHECKED<% } %>><%= messages.getString("yes") %>
      </TD>
    </TR>
    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" ALIGN="RIGHT" VALIGN="MIDDLE">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" VALIGN="MIDDLE">&nbsp;</TD>
    </TR>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2">
      <TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0">
      <TR><TD CLASS="contentBgColor" COLSPAN="3">
      <a href="javascript: recipientPopup();"><%= messages.getString("calendar.todo.assign.to") %></a><BR>
      <input type="hidden" name="userIDassigned" value="">
      <textarea name="dispRecipientAssigned" rows="3" cols="40" readonly></textarea>
      </TD></TR>
      </TABLE>
      </TD>
    </TR>
    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" ALIGN="RIGHT" VALIGN="MIDDLE">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" VALIGN="MIDDLE">&nbsp;</TD>
    </TR>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2">
      <TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0">
      <TR><TD CLASS="contentBgColor" COLSPAN="3">
      <a href="javascript: recipientPopup();"><%= messages.getString("calendar.todo.cc.to") %></a><BR>
      <input type="hidden" name="userIDCC" value="">
      <textarea name="dispRecipientCC" rows="3" cols="40" readonly></textarea>
      </TD></TR>
      </TABLE>
      </TD>
    </TR>
    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%">&nbsp;</TD>
    </TR>
<%-- // Not in use
<% // Module Manager - Resource
  if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_RESOURCE) ) { %>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" ALIGN="CENTER" VALIGN="TOP" COLSPAN="2">
      <TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0">
      <TR><TD CLASS="contentBgColor" COLSPAN="3">
      <%= messages.getString("calendar.addappt.resources") %>
      </TD></TR>
      <TR><TD CLASS="contentBgColor" VALIGN="TOP">
  		<select name="allResources" size="5" multiple>
 		<%
		    vParameter = null;
			if (request.getParameterValues("resources") != null)
			  vParameter = CommonFunction.arrayToVector(request.getParameterValues("resources"));
			
		    for (i=0; resourceIDs != null && i < resourceIDs.size(); i++) {
              if ( (parameterInt == -1 && !resourceID.equals("") && Integer.parseInt(resourceID) == ((Integer)resourceIDs.get(i)).intValue()) ||
			       (vParameter != null && vParameter.indexOf(((Integer)resourceIDs.get(i)).toString()) != -1)
			  )
                continue;

        %>
		      <option value="<%= resourceIDs.get(i) %>"><%= CommonFunction.restrictNameLength((String)resourceName.get(i), 20) %><%= (resourceApproval.get(i).equals("1")) ? "(A)" : "" %></option>
        <%  }  %>
  		</select>
      </TD>
      <TD CLASS="contentBgColor" ALIGN="CENTER" VALIGN="MIDDLE" >
      <A HREF="javascript:moveItems(document.calendarToDo.allResources, document.calendarToDo.resources, '<%= messages.getString("none.with.line") %>', -1);" onMouseOver="window.status='<%= messages.getString("add") %>';return true;"><IMG SRC="images/system/ic_rightarrow.gif" BORDER="0" ALT="<%= messages.getString("add") %>"></A><BR><BR>
      <A HREF="javascript:moveItems(document.calendarToDo.resources, document.calendarToDo.allResources, '<%= messages.getString("none.with.line") %>', -1);" onMouseOver="window.status='<%= messages.getString("email.remove") %>';return true;"><IMG SRC="images/system/ic_leftarrow.gif" BORDER="0" ALT="<%= messages.getString("email.remove") %>"></A>
      </TD>
      <TD CLASS="contentBgColor" VALIGN="TOP">
  		<select name="resources" size="5" multiple>
 		<%
		    for (i=0; resourceIDs != null && i < resourceIDs.size(); i++) {
              if ( (parameterInt == -1 && !resourceID.equals("") && Integer.parseInt(resourceID) == ((Integer)resourceIDs.get(i)).intValue()) ||
			  	   (vParameter!= null && vParameter.indexOf(((Integer)resourceIDs.get(i)).toString()) != -1)
			  )  {
        %>
		      <option value="<%= resourceIDs.get(i) %>"><%= CommonFunction.restrictNameLength((String)resourceName.get(i), 20) %><%= (resourceApproval.get(i).equals("1")) ? "(A)" : "" %></option>
        <%    } 
		    }
		%>
  		</select>
      </TD>
      </TR>
      <TR><TD CLASS="contentBgColor" ALIGN="LEFT" VALIGN="TOP">
      <A HREF="javascript:selectAllItems(document.calendarToDo.allResources);" onMouseOver="window.status='<%= messages.getString("select.all") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_selectall.gif\" BORDER=\"0\" ALT=\"Select All\">" : messages.getString("select.all") %></A> 
      <A HREF="javascript:clearAllItems(document.calendarToDo.allResources);" onMouseOver="window.status='<%= messages.getString("clear.all") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_clear.gif\" BORDER=\"0\" ALT=\"Clear All Selected\">" : messages.getString("clear.all") %></A>
      </TD>
      <TD CLASS="contentBgColor">&nbsp;</TD>
      <TD CLASS="contentBgColor" ALIGN="LEFT" VALIGN="TOP">
      <A HREF="javascript:selectAllItems(document.calendarToDo.resources);" onMouseOver="window.status='<%= messages.getString("select.all") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_selectall.gif\" BORDER=\"0\" ALT=\"Select All\">" : messages.getString("select.all") %></A> 
      <A HREF="javascript:clearAllItems(document.calendarToDo.resources);" onMouseOver="window.status='<%= messages.getString("clear.all") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_clear.gif\" BORDER=\"0\" ALT=\"Clear All Selected\">" : messages.getString("clear.all") %></A>
      </TD></TR>
      </TABLE>
      </TD>
    </TR>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" VALIGN="TOP">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="TOP">&nbsp;</TD>
    </TR>
<% }// Module Manager - Resource %>
--%>
<%
   parameterStr = "1";
   if (request.getParameter("notifyMethod") != null)
     parameterStr = request.getParameter("notifyMethod");
		 
		 
	 StringTokenizer stk = new StringTokenizer(parameterStr,",");
 	 String memoCheck = "",emailCheck="";
 	 while (stk.hasMoreTokens()) {
			   parameterStr = stk.nextToken();
				 if (parameterStr.equals("1")) {
				   memoCheck = " CHECKED";
				 }
				 else if (parameterStr.equals("2")) {
 				   emailCheck = " CHECKED";
				 }
 	 }	 
%>
    <TR>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT" VALIGN="TOP"><%= messages.getString("calendar.addappt.notify.method") %>: &nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="TOP">
	      <INPUT TYPE="checkbox" NAME="notifyMemo" <%= memoCheck %>><%= messages.getString("memo") %> &nbsp;				 
	      <INPUT TYPE="checkbox" NAME="notifyEmail" <%= emailCheck %>><%= messages.getString("email") %> &nbsp;
      </TD>
    </TR>
    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT" VALIGN="MIDDLE">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%" VALIGN="MIDDLE">&nbsp;</TD>
    </TR>
	<%
        parameterStr = "";
        if (request.getParameter("notifyInfo") != null)
          parameterStr = request.getParameter("notifyInfo");
	%>
    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT"><%= messages.getString("calendar.addappt.notify.note") %> &nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%">
        <TEXTAREA NAME="notifyInfo" COLS="23" ROWS="4" wrap><%= parameterStr %></TEXTAREA>
      </TD>
    </TR>
    <TR VALIGN="TOP">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%">&nbsp;</TD>
    </TR>
	<%
        parameterStr = "1";
        if (request.getParameter("publicFlag") != null)
          parameterStr = request.getParameter("publicFlag");	
	%>
    <TR VALIGN="MIDDLE">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%" ALIGN="RIGHT"><%= messages.getString("calendar.addappt.viewing.status") %> &nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%">
        <INPUT TYPE="radio" NAME="publicFlag" VALUE="1"<% if (parameterStr.equals("1") ) { %> CHECKED<% } %>><%= messages.getString("calendar.addappt.public") %> 
        <INPUT TYPE="radio" NAME="publicFlag" VALUE="0"<% if (parameterStr.equals("0") ) { %> CHECKED<% } %>><%= messages.getString("calendar.addappt.private") %>
      </FONT></TD>
    </TR>
    <TR VALIGN="MIDDLE">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%">&nbsp;</TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%">&nbsp;</TD>
    </TR>
    <TR VALIGN="MIDDLE">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="32%">
        <P>&nbsp;</P>
      </TD>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="68%">
      <input type="hidden" name="dummy">
      <A HREF="javascript:checkToDoCalendarForm(document.calendarToDo);" onMouseOver="window.status='<%= messages.getString("save") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_save.gif\" WIDTH=\"34\" HEIGHT=\"18\" BORDER=\"0\" ALT=\"Save\">" : messages.getString("save") %></A> <A HREF="calendar.jsp" onMouseOver="window.status='<%= messages.getString("cancel") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_cancel.gif\" WIDTH=\"40\" HEIGHT=\"18\" BORDER=\"0\" ALT=\"Cancel\">" : messages.getString("cancel") %></A></TD>
    </TR>
  </FORM>

<SCRIPT LANGUAGE="JavaScript">
<%  if (parameterInt == -1) {  %>    
      setToDoCalendarForm(document.calendarToDo);
<%  }  %>
obj = document.calendarToDo;
noItems(obj.allResources, '<%= messages.getString("none.with.line") %>', -1);
noItems(obj.resources, '<%= messages.getString("none.with.line") %>', -1);
</SCRIPT>

