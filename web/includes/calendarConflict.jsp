<%@ page import="java.net.URLEncoder" %>
<%
  int i;
  String sDate=null, eDate=null, sTime=null, eTime=null,str=null;
  String realUserID=null, tempString=null, resType="", calDescription="", resDesc="";
  
  Vector vConflicts=null;
         
  Vector vUsers=null, vUsersType=null, vUserConflicts=null, vCalToAdd=null;
  
  Vector vResourceList=null, vResourceIDs=null, vResourceName=null, vResourceApproval=null;
  Vector selectedResourcesInfo=null, resourceConflicts=null;
  
  boolean standardAtt=false, firstTime=true;
  
  resType = request.getParameter("resType");
  vConflicts = (Vector)TvoContextManager.getSessionAttribute(request, "Calendar.vConflicts");
  
  vUsers = (Vector) vConflicts.get(1);
  vUsersType = (Vector) vConflicts.get(2);
  vUserConflicts = (Vector) vConflicts.get(3);

  // Module Manager - Resource
  if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_RESOURCE) )
  {
    //vResources = (Vector) vConflicts.get(4);
    //vResourceConflicts = (Vector) vConflicts.get(5);
	selectedResourcesInfo = (Vector) vConflicts.get(10);
	resourceConflicts     = (Vector) vConflicts.get(11);
	

    vResourceList = beanResource.showModule(request, userID, "Resource", "view", "resourceName", "asc", 0, 0);

    if (vResourceList != null && vResourceList.size() > 0)
    {
      vResourceIDs = (Vector) vResourceList.get(0);
      vResourceName = (Vector) vResourceList.get(1);
      vResourceApproval = (Vector) vResourceList.get(5);
    }
  }

  vCalToAdd = (Vector) vConflicts.get(9);
  

 

  if (vCalToAdd != null)
  {

    if (resType.equals("appt"))
    {
      resDesc = messages.getString("calendar.appointment");
      

      sDate = CommonFunction.parseDate(dateFormat,currentLocale, ((String)vCalToAdd.get(2) + "-" + (String)vCalToAdd.get(3) + "-" + (String)vCalToAdd.get(4)),null,TvoConstants.DATE_FOMRAT_SHORT);
      sTime = CommonFunction.getDate("HH:mm", "h:mm aa", ((String)vCalToAdd.get(5) + ":" + (String)vCalToAdd.get(6))) + " - ";
      
      eDate = CommonFunction.parseDate(dateFormat,currentLocale, ((String)vCalToAdd.get(7) + "-" + (String)vCalToAdd.get(8) + "-" + (String)vCalToAdd.get(9)),null,TvoConstants.DATE_FOMRAT_SHORT);
      eTime = CommonFunction.getDate("HH:mm", "h:mm aa", ((String)vCalToAdd.get(10) + ":" + (String)vCalToAdd.get(11)));

      if (action.equals("editConflict"))
      {
        %>
        <FORM NAME="calendarConflict" METHOD="POST" ACTION="Calendar?action=editAppt">
          <input type="hidden" name="prevReminderDate" value="<%= (String)vCalToAdd.get(22)%>">
          <input type="hidden" name="apptID"           value="<%= (String)vCalToAdd.get(23)%>">
        <%
      }
      else if (action.equals("addConflict"))
      {
        %>
        <FORM NAME="calendarConflict" METHOD="POST" ACTION="Calendar?action=addAppt">
        <%
      }
      %>
          <% if (request.getParameter("addAttachments") != null) { %>
          <input type="hidden" name="addAttachments"   value="<%= request.getParameter("addAttachments") %>">
          <% } else if (request.getParameter("editAttachments") != null) { %>
          <input type="hidden" name="editAttachments"  value="<%= request.getParameter("editAttachments") %>">
          <% } %>
          <input type="hidden" name="startYear"        value="<%= (String)vCalToAdd.get(2)%>">
          <input type="hidden" name="startMonth"       value="<%= (String)vCalToAdd.get(3)%>">
          <input type="hidden" name="startDay"         value="<%= (String)vCalToAdd.get(4)%>">
          <input type="hidden" name="startHour"        value="<%= (String)vCalToAdd.get(5)%>">
          <input type="hidden" name="startMinute"      value="<%= (String)vCalToAdd.get(6)%>">
          <input type="hidden" name="endYear"          value="<%= (String)vCalToAdd.get(7)%>">
          <input type="hidden" name="endMonth"         value="<%= (String)vCalToAdd.get(8)%>">
          <input type="hidden" name="endDay"           value="<%= (String)vCalToAdd.get(9)%>">
          <input type="hidden" name="endHour"          value="<%= (String)vCalToAdd.get(10)%>">
          <input type="hidden" name="endMinute"        value="<%= (String)vCalToAdd.get(11)%>">
          <input type="hidden" name="reminderSetting"  value="<%= (String)vCalToAdd.get(12)%>">
          <input type="hidden" name="description"      value="<%= (String)vCalToAdd.get(13)%>">
          <% calDescription = (String)vCalToAdd.get(13); %>
          <input type="hidden" name="agenda"           value="<%= (String)vCalToAdd.get(14)%>">
          <input type="hidden" name="notifyMethod"     value="<%= (String)vCalToAdd.get(15)%>">
          <input type="hidden" name="notifyInfo"       value="<%= (String)vCalToAdd.get(16)%>">
          <input type="hidden" name="location"         value="<%= (String)vCalToAdd.get(17)%>">
          <input type="hidden" name="publicFlag"       value="<%= (String)vCalToAdd.get(18)%>">
		<input type="hidden" name="allDayEvent"      value="<%= (String)vCalToAdd.get(19)%>">
		<input type="hidden" name="excludeScheduler" value="<%= (String)vCalToAdd.get(20)%>">
		<input type="hidden" name="official" value="<%= (String)vCalToAdd.get(21)%>">
					
      <%
					if ( ((String)vCalToAdd.get(19)) != null && !((String)vCalToAdd.get(19)).equals("null")) {
					  sTime = messages.getString("calendar.appointment.all.day.event");
						eTime = "";
					}
    }
    else if (resType.equals("toDo"))
    {
      resDesc = messages.getString("calendar.todo.task");
      
      sDate = "";
      sTime = "";
      eDate = CommonFunction.parseDate(dateFormat,currentLocale, ((String)vCalToAdd.get(4) + "-" + (String)vCalToAdd.get(5) + "-" + (String)vCalToAdd.get(6)),null,TvoConstants.DATE_FOMRAT_SHORT);			
      eTime = CommonFunction.getDate("HH:mm", "h:mm aa", ((String)vCalToAdd.get(7) + ":" + (String)vCalToAdd.get(8)));

      if (action.equals("editConflict"))
      {
        %>
        <FORM NAME="calendarConflict" METHOD="POST" ACTION="Calendar?action=editToDo">
          <input type="hidden" name="toDoID"       value="<%= (String)vCalToAdd.get(18)%>">
          <% if (((String)vCalToAdd.get(18)) != null) { %>
          <input type="hidden" name="prevFilename" value="<%= (String)vCalToAdd.get(19) %>">
          <% } %>
        <%
      }
      else if (action.equals("addConflict"))
      {
        %>
        <FORM NAME="calendarConflict" METHOD="POST" ACTION="Calendar?action=addToDo">
        <%
      }
        %>
          <input type="hidden" name="userIDAssigned"  value="<%= (String)vCalToAdd.get(2)%>">
          <input type="hidden" name="userIDCC"        value="<%= (String)vCalToAdd.get(3)%>">
          <input type="hidden" name="dueYear"         value="<%= (String)vCalToAdd.get(4)%>">
          <input type="hidden" name="dueMonth"        value="<%= (String)vCalToAdd.get(5)%>">
          <input type="hidden" name="dueDay"          value="<%= (String)vCalToAdd.get(6)%>">
          <input type="hidden" name="dueHour"         value="<%= (String)vCalToAdd.get(7)%>">
          <input type="hidden" name="dueMinute"       value="<%= (String)vCalToAdd.get(8)%>">
          <input type="hidden" name="reminderSetting" value="<%= (String)vCalToAdd.get(9)%>">
          <input type="hidden" name="repeatDay"       value="<%= (String)vCalToAdd.get(10)%>">
          <input type="hidden" name="description"     value="<%= (String)vCalToAdd.get(11)%>">
          <% calDescription = (String)vCalToAdd.get(11); %>
          <% if (((String)vCalToAdd.get(12)) != null) { %>
          <input type="hidden" name="uploadedFile"    value="<%= vCalToAdd.get(12) %>">
          <% } %>
          <input type="hidden" name="publicFlag"      value="<%= (String)vCalToAdd.get(13)%>">
          <input type="hidden" name="allowReassign"   value="<%= (String)vCalToAdd.get(14)%>">
          <input type="hidden" name="notifyMethod"    value="<%= (String)vCalToAdd.get(15)%>">
          <input type="hidden" name="notifyInfo"      value="<%= (String)vCalToAdd.get(16)%>">
		  <input type="hidden" name="tamsCategory"    value="<%= (String)vCalToAdd.get(17)%>">
        <%
    }
    else if (resType.equals("event"))
    {
      resDesc = messages.getString("calendar.event");

      sDate = CommonFunction.parseDate(dateFormat, currentLocale,((String)vCalToAdd.get(2) + "-" + (String)vCalToAdd.get(3) + "-" + (String)vCalToAdd.get(4)),null,TvoConstants.DATE_FOMRAT_SHORT);
      sTime = CommonFunction.getDate("HH:mm", "h:mm aa", ((String)vCalToAdd.get(5) + ":" + (String)vCalToAdd.get(6))) + " - ";
      
      eDate = CommonFunction.parseDate( dateFormat,currentLocale, ((String)vCalToAdd.get(7) + "-" + (String)vCalToAdd.get(8) + "-" + (String)vCalToAdd.get(9)),null,TvoConstants.DATE_FOMRAT_SHORT);
      eTime = CommonFunction.getDate("HH:mm", "h:mm aa", ((String)vCalToAdd.get(10) + ":" + (String)vCalToAdd.get(11)));

      if (action.equals("editConflict"))
      {
        %>
        <FORM NAME="calendarConflict" METHOD="POST" ACTION="Calendar?action=editEvent">
          <input type="hidden" name="eventID" value="<%= (String)vCalToAdd.get(23)%>">
        <%
      }
      else if (action.equals("addConflict"))
      {
        %>
        <FORM NAME="calendarConflict" METHOD="POST" ACTION="Calendar?action=addEvent">
        <%
      }
        %>
          <input type="hidden" name="startYear"        value="<%= (String)vCalToAdd.get(2)%>">
          <input type="hidden" name="startMonth"       value="<%= (String)vCalToAdd.get(3)%>">
          <input type="hidden" name="startDay"         value="<%= (String)vCalToAdd.get(4)%>">
          <input type="hidden" name="startHour"        value="<%= (String)vCalToAdd.get(5)%>">
          <input type="hidden" name="startMinute"      value="<%= (String)vCalToAdd.get(6)%>">
          <input type="hidden" name="endYear"          value="<%= (String)vCalToAdd.get(7)%>">
          <input type="hidden" name="endMonth"         value="<%= (String)vCalToAdd.get(8)%>">
          <input type="hidden" name="endDay"           value="<%= (String)vCalToAdd.get(9)%>">
          <input type="hidden" name="endHour"          value="<%= (String)vCalToAdd.get(10)%>">
          <input type="hidden" name="endMinute"        value="<%= (String)vCalToAdd.get(11)%>">
          <input type="hidden" name="reminderSetting"  value="<%= (String)vCalToAdd.get(12)%>">
          <input type="hidden" name="description"      value="<%= (String)vCalToAdd.get(13)%>">
          <% calDescription = (String)vCalToAdd.get(13); %>
          <input type="hidden" name="repeatDay"        value="<%= (String)vCalToAdd.get(14)%>">
          <input type="hidden" name="repeatStartYear"  value="<%= (String)vCalToAdd.get(15)%>">
          <input type="hidden" name="repeatStartMonth" value="<%= (String)vCalToAdd.get(16)%>">
          <input type="hidden" name="repeatStartDay"   value="<%= (String)vCalToAdd.get(17)%>">
          <input type="hidden" name="repeatEndYear"    value="<%= (String)vCalToAdd.get(18)%>">
          <input type="hidden" name="repeatEndMonth"   value="<%= (String)vCalToAdd.get(19)%>">
          <input type="hidden" name="repeatEndDay"     value="<%= (String)vCalToAdd.get(20)%>">
          <input type="hidden" name="location"         value="<%= (String)vCalToAdd.get(21)%>">
          <input type="hidden" name="publicFlag"       value="<%= (String)vCalToAdd.get(22)%>">
        <%
    }
      %>
        <tr>
          <td align="center" colspan="2" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate">
            <b><%= resDesc %></b><br>
          </td>
        </tr>
               
        <tr>
          <td align="center" colspan="2" BGCOLOR="#EFEFEF" CLASS="contentBgColor">&nbsp;&nbsp;</td>
        </tr>
        
        <tr>
          <td align="center" colspan="2" BGCOLOR="#EFEFEF" CLASS="contentBgColor">

          <table border="0" cellspacing="0" cellpadding="5">
						<tr>
		          <td align="right" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate">
		            <%= resType.equals("toDo") ? messages.getString("calendar.todo.due.date") : messages.getString("library.date") %>:&nbsp;&nbsp;
		          </td>
		          <td align="left" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate">
		            <FONT COLOR="#FF0000">
		            <%= resType.equals("toDo") ? "" : (sDate + " - ") %><%= eDate %>
		            </FONT>
		          </td>
		        </tr>
						
		        <tr>
		          <td align="right" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate">
		            <%= resType.equals("toDo") ? messages.getString("calendar.todo.due.time") : messages.getString("calendar.time") %>:&nbsp;&nbsp;
		          </td>
		          <td align="left" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate">
		            <FONT COLOR="#FF0000">
		            <%= resType.equals("toDo") ? "" : sTime  %><%= eTime %>
		            </FONT>
		          </td>
		        </tr>
		        <tr>
		          <td valign="top" align="right" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate">
		            <%= messages.getString("calendar.addappt.description") %>:&nbsp;&nbsp;
		          </td>
		          <td align="left" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate">
		            <FONT COLOR="#FF0000">
		            <%= beanCalendar.ln2br((String) calDescription) %>
		            </FONT>
		          </td>
						</tr>
					</table>
					</td>
        </tr>
        
        <tr>
          <td align="center" colspan="2" BGCOLOR="#EFEFEF" CLASS="contentBgColor">&nbsp;&nbsp;</td>
        </tr>

        <tr>
          <td align="center" colspan="2" BGCOLOR="#EFEFEF" CLASS="contentBgColor">
            <a href="calendar.jsp?action=listConflict" onMouseOver="window.status='<%= messages.getString("calendar.conflict.view.all") %>';return true;" title="<%= messages.getString("calendar.conflict.view.all") %>">
              <%= messages.getString("calendar.conflict.view.all") %>
            </a>
          </td>
        </tr>
        
        <tr>
          <td align="center" colspan="2" BGCOLOR="#EFEFEF" CLASS="contentBgColor">&nbsp;&nbsp;</td>
        </tr>

        <tr>
          <td align="center" colspan="2" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" width="100%">
          <table border="0" cellspacing="0" cellpadding="0" width="95%">
          <tr>
            <td align="left" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" width="60%">
              <b><%= resType.equals("toDo") ? messages.getString("calendar.todo.assigned.by") : messages.getString("calendar.scheduler") %></b>
            </td>
            <td align="center" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" width="20%">
              <b><%= resType.equals("appt") ? messages.getString("calendar.status") : "&nbsp;" %></b>
            </td>
            <td align="center" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" width="20%">
              <b>&nbsp;</b>
            </td>
          </tr>
          <%
            if (vUsers != null && vUsers.size() > 0)
            {
            firstTime = true;
            for (i=0; i < vUsers.size(); i++)
            {
              if (vUsersType.get(i).equals("C") && i > 0 && firstTime)
              {
                firstTime = false;
              %>
          </table>
          </td>
        </tr>
        
        <tr>
          <td align="center" colspan="2" BGCOLOR="#EFEFEF" CLASS="contentBgColor">&nbsp;&nbsp;</td>
        </tr>
        <tr>
          <td align="center" colspan="2" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" width="100%">
          <table border="0" cellspacing="0" cellpadding="0" width="95%">
            <tr>
              <td align="left" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" width="60%">
                <b><%= messages.getString("calendar.addappt.compulsory.attendees") %></b>
              </td>
              <td align="center" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" width="20%">
                <b><%= messages.getString("calendar.status") %></b>
              </td>
              <td align="center" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" width="20%">
                <b><%= messages.getString("calendar.conflict.confirm") %>?</b>
              </td>
            </tr>
              <%
              }
              if (vUsersType.get(i).equals("S") && !standardAtt)
              {
                standardAtt = true;
              %>
          </table>
          </td>
        </tr>
        
        <tr>
          <td align="center" colspan="2" BGCOLOR="#EFEFEF" CLASS="contentBgColor">&nbsp;&nbsp;</td>
        </tr>
        <tr>
          <td align="center" colspan="2" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" width="100%">
          <table border="0" cellspacing="0" cellpadding="0" width="95%">
            <tr>
              <td align="left" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" width="60%">
                <b><%= messages.getString("calendar.addappt.attendees") %></b>
              </td>
              <td align="center" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" width="20%">
                <b><%= messages.getString("calendar.status") %></b>
              </td>
              <td align="center" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" width="20%">
                <b><%= messages.getString("calendar.conflict.confirm") %>?</b>
              </td>
            </tr>
              <%
              }
              %>
              <tr>
              <td align="left" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate">
                <FONT SIZE="2">
              <%
              tempString = beanCalendarDirectory.getUserName((String)vUsers.get(i));
              if (vUserConflicts.get(i) != null && ((Vector) vUserConflicts.get(i)).size() > 0)
              {
                %>								
                <a href="calendar.jsp?action=listConflict&conflictUserID=<%= (String)vUsers.get(i) %>" onMouseOver="window.status='<%= messages.getString("calendar.conflict.view") %> - <%= (tempString.replace('\'', '`')).replace('\"', '`') %>';return true;" title="<%= messages.getString("calendar.conflict.view") %> - <%= (tempString.replace('\'', '`')).replace('\"', '`') %>">
                <FONT COLOR="#FF0000">
                <%
              }
              %>
              <%= tempString %>
              <%
              if (vUserConflicts.get(i) != null && ((Vector) vUserConflicts.get(i)).size() > 0)
              {
                %>
                </FONT>
                </a>
                <%
              }
              %>
                </FONT>
              </td>
              <td align="center" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate">
                <FONT SIZE="2">
              <%
              if (vUserConflicts.get(i) != null && ((Vector) vUserConflicts.get(i)).size() > 0)
              {
                %>
                <FONT COLOR="#FF0000">
                <%= messages.getString("calendar.conflict") %>
                </FONT>
                <%
              }
              else
              {
                %>
                <%= (vUsers.get(i).equals((String)vCalToAdd.get(0)) && (!resType.equals("appt"))) ? "&nbsp;" : "OK" %>
                <%
              }
              %>
              </FONT>
              </td>
              <td align="center" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate">&nbsp;
              <%
              if (!vUsers.get(i).equals((String)vCalToAdd.get(0)))
              {
                if (standardAtt)
                {
                %>
                <input type="checkbox" name="attendees" value="<%= (String)vUsers.get(i) %>" CHECKED>
                <%
                }
                else
                {
                %>
                <input type="checkbox" name="compulsoryAttendees" value="<%= (String)vUsers.get(i) %>" CHECKED>
                <%
                }
              }
              else
              {
                %>
                <b>&nbsp;</b>
                <%
              }
              %>
                &nbsp;
              </td>
              </tr>
              <%
            } //for (i=0; i < vUsers.size(); i++)
            }
            else
            {
            %>
            <TR>
              <TD ALIGN="MIDDLE" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" WIDTH="100%" COLSPAN="3">
                <%= messages.getString("calendar.error.no.users") %>
              </TD>
            </TR>
            <%
            } // if (vUsers != null && vUsers.size() > 0)
    %>
          </table>
          </td>
        </tr>
        
        <tr>
          <td align="center" colspan="2" BGCOLOR="#EFEFEF" CLASS="contentBgColor">&nbsp;&nbsp;</td>
        </tr>
        
        <%
      // Module Manager - Resource
      if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_RESOURCE) )
      {
        if (selectedResourcesInfo != null && selectedResourcesInfo.size() > 0)
        {
        %>
        <tr>
          <td align="center" colspan="2" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" width="100%">
          <table border="0" cellspacing="0" cellpadding="0" width="95%">
          <tr>
            <td align="left" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" width="60%">
              <b><%= messages.getString("calendar.addappt.resources") %></b>
            </td>
            <td align="center" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" width="20%">
              <b><%= messages.getString("calendar.status") %></b>
            </td>
            <td align="center" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" width="20%">
              <b><%= messages.getString("calendar.conflict.confirm") %>?</b>
            </td>
          </tr>
          <%
            for (i=0; i<selectedResourcesInfo.size(); i++) {
                Hashtable ht = (Hashtable) selectedResourcesInfo.get(i);
                String selectedResourceID = (String) ht.get("RESOURCE_ID");
          %>
              <tr>
              <td align="left" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate">
                <FONT SIZE="2">
                <% if (resourceConflicts.indexOf(selectedResourceID) != -1) { %>
                    <FONT COLOR="#FF0000"><%= ht.get("RESOURCE_DESC") %></FONT>
                <% } else { %>
                    <%= ht.get("RESOURCE_DESC") %>
                <% } %>
                </FONT>
              </td>
              <td align="center" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate">
                <FONT SIZE="2">
                <% if (resourceConflicts.indexOf(selectedResourceID) != -1) { %>
                    <FONT COLOR="#FF0000"><%= messages.getString("calendar.conflict") %></FONT>
                <% } else { %>
                    OK
                <% } %>
                </FONT>
              </td>
              <td align="center" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate">&nbsp;
                <% if (resourceConflicts.indexOf(selectedResourceID) == -1) { %>
                    <input type="checkbox" name="selectedResources" value="<%= selectedResourceID %>" CHECKED>
                <% } else { %>
                    -
                <% } %>
              </td>
              </tr>
          <%
            }
          %>
          <% if (resourceConflicts.size() != 0) { %>
          <tr>
            <td align="left" BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" colspan="3">
              <FONT SIZE="2">(Note: Conflicting resources will not be saved)</FONT>
            </td>
          </tr>
          <% } %>
          </table>
          </td>
        </tr>
        <%
        } // if (vResources != null && vResources.size() > 0)
      } // Module Manager - Resource
	  

      if (action.equals("addConflict")) {
  	    if (resType.equals("appt")) 
	  	  str = "addAppt";
		else if (resType.equals("event")) 
		  str = "addEvent";
		else 
		  str = "addToDo";

	  }
	  else if (action.equals("editConflict")) {
	    if (resType.equals("appt") )
  	      str = "editAppt&apptID="+vCalToAdd.get(22);		  
		else if (resType.equals("event")) 
  		  str = "editEvent&eventID="+vCalToAdd.get(23);
		else
		  str = "editToDo&toDoID="+vCalToAdd.get(18);
	  }
	  

	  
        %>
        <tr>
          <td align="center" colspan="2" BGCOLOR="#EFEFEF" CLASS="contentBgColor">
            <IMG SRC="images/system/blank.gif" WIDTH="1" HEIGHT="42" BORDER="0">
            &nbsp;&nbsp;
          </td>
        </tr>
        <TR>
        <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="25%" VALIGN="TOP">
          <P>&nbsp;</P>
        </TD>
        <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" WIDTH="75%" VALIGN="TOP">
          <A HREF="javascript:calConfirm('<%= resDesc %>');" onMouseOver="window.status='<%= messages.getString("save") %>';return true;">
          <%= showIcon ? "<IMG SRC=\"images/system/ic_save.gif\" WIDTH=\"34\" HEIGHT=\"18\" BORDER=\"0\" ALT=\"Save\">" : messages.getString("save") %></A>
          <A HREF="javascript:document.calendarConflict.action='calendar.jsp?action=<%= str %>';document.calendarConflict.submit();" onMouseOver="window.status='<%= messages.getString("cancel") %>';return true;">
          <%= showIcon ? "<IMG SRC=\"images/system/ic_cancel.gif\" WIDTH=\"40\" HEIGHT=\"18\" BORDER=\"0\" ALT=\"Cancel\">" : messages.getString("cancel") %></A></TD>
        </TR>
      </FORM>
  <%
  }
  else
  {
    out.println(messages.getString("calendar.error.check.conflict"));
  }
  %>
