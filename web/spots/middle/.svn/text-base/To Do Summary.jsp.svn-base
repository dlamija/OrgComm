<%@ page import="common.*,ecomm.bean.*,java.util.*,tvo.TvoConstants" %>
<jsp:useBean id="beanMiddleToDoCalendar" scope="request" class="ecomm.bean.CalendarCalendar" />
<jsp:useBean id="beanMiddleToDoCalendarACL" scope="request" class="ecomm.bean.ACL" />
<jsp:useBean id="beanPersonal" scope="request" class="ecomm.bean.PersonalPersonal" />
<%
  String userID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
  Hashtable middleToDoUserACL, middleToDoGroupACL;
  String middleToDoUserID;
  beanMiddleToDoCalendar.initTVO(request);
  beanMiddleToDoCalendarACL.initTVO(request);

  middleToDoUserID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
  middleToDoUserACL = beanMiddleToDoCalendarACL.getRights(middleToDoUserID, "Calendar", "User");
  middleToDoGroupACL = beanMiddleToDoCalendarACL.getRights(middleToDoUserID, "Calendar", "Group");

  if ( (middleToDoUserACL.containsKey("view") && middleToDoUserACL.get("view").equals("1")) ||
       (middleToDoGroupACL.containsKey("view") && middleToDoGroupACL.get("view").equals("1")) )
  {
%>

<%
//String userID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
beanPersonal.initTVO(request);
Messages messages = Messages.getMessages(request);
String language = (String)TvoContextManager.getAttribute(request, "System.language");
String contentTitleFont = "contentTitleFont";
if (language.equals("zh") || language.equals("ja"))
  contentTitleFont = "contentTitleGlyphFont";


// Module Manager - Personal
if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_PERSONAL) ) {
%>
                  <!-- To Do List Main Content Box START -->
                  <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
                    <TR VALIGN="MIDDLE">
                      <TD HEIGHT="22" BACKGROUND="images/system/strap.gif"><IMG SRC="images/system/blank.gif" WIDTH="20" HEIGHT="5"><a href="" onclick="toggleBlock('middletodo'); return false"><FONT COLOR="#FFCC66" CLASS="<%= contentTitleFont %>"><%= messages.getString("calendar.viewday.todo.list") %></FONT></A></TD>
                    </TR>
                  </TABLE>
                  <DIV id="middletodo">
                  <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
                    <TR>
                      <TD BGCOLOR="#EFEFEF" VALIGN="TOP" CLASS="contentBgColor"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="10"></TD>
                    </TR>
                    <TR>
                      <TD BGCOLOR="#EFEFEF" VALIGN="TOP" CLASS="contentBgColor">
                        <UL>

<%@ page import="java.util.Calendar, java.util.Date,java.util.Locale" %>
<%
  String[] middleToDoMonthNames = {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};

  String middleToDoDate=null, middleToDoMonth=null, middleToDoYear=null;
  int middleToDoIndex;
  java.util.Calendar middleToDoCal;

  //Hashtable middleToDoUserACL, middleToDoGroupACL;
  //String middleToDoUserID;

  //beanMiddleToDoCalendar.initTVO(request);
  //beanMiddleToDoCalendarACL.initTVO(request);


	String country = (String)TvoContextManager.getAttribute(request, "System.country");
	String dateFormat = (String)TvoContextManager.getAttribute(request,"System.dateFormat");
	Locale currentLocale = new Locale(language,country);


  //middleToDoUserID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
  //middleToDoUserACL = beanMiddleToDoCalendarACL.getRights(middleToDoUserID, "Calendar", "User");
  //middleToDoGroupACL = beanMiddleToDoCalendarACL.getRights(middleToDoUserID, "Calendar", "Group");

  if ( (middleToDoUserACL.containsKey("view") && middleToDoUserACL.get("view").equals("1")) ||
       (middleToDoGroupACL.containsKey("view") && middleToDoGroupACL.get("view").equals("1")) ) {


      middleToDoCal = java.util.Calendar.getInstance();
      middleToDoDate = String.valueOf(middleToDoCal.get(java.util.Calendar.DAY_OF_MONTH));
      middleToDoMonth = String.valueOf(middleToDoCal.get(java.util.Calendar.MONTH));
      middleToDoYear = String.valueOf(middleToDoCal.get(java.util.Calendar.YEAR));
    
      if (userID != null && middleToDoDate != null && middleToDoMonth != null && middleToDoYear != null) {
        Vector vToDo=null;
        Vector vToDoID=null, vUserID=null, vDueDate=null, vDueTime=null, vDescription=null;
        String eDate=null, eTime=null, overDue="";
    
        Date dateTemp=null, dateNow=null, dateTimeNow=null;
        vToDo = (Vector)beanMiddleToDoCalendar.getToDoToday(userID,middleToDoDate,middleToDoMonth,middleToDoYear);
    
    %><!-- TO DO LIST START --><%
    
    if (vToDo != null && vToDo.size() > 0) {
      vToDoID = (Vector)vToDo.get(0);
      vUserID = (Vector)vToDo.get(1);
      vDueDate = (Vector)vToDo.get(2);
      vDueTime = (Vector)vToDo.get(3);
      vDescription = (Vector)vToDo.get(4);

      middleToDoCal = java.util.Calendar.getInstance();
    
      dateNow = CommonFunction.getDate("d MMM yyyy", middleToDoDate+" "+middleToDoMonthNames[Integer.parseInt(middleToDoMonth)]+" "+middleToDoYear, 0);
    
      dateTimeNow = CommonFunction.getDate("d MMM yyyy hh:mm", middleToDoDate+" "+middleToDoMonthNames[Integer.parseInt(middleToDoMonth)]+" "+middleToDoYear+" "+
                    String.valueOf(middleToDoCal.get(java.util.Calendar.HOUR_OF_DAY)) +":"+
                    String.valueOf(middleToDoCal.get(java.util.Calendar.MINUTE)), 0);
    
      for(middleToDoIndex=0; middleToDoIndex < vToDoID.size(); middleToDoIndex++) {
    %><LI><%
        if (dateNow.equals(CommonFunction.getDate("yyyy-MM-dd", (String)vDueDate.get(middleToDoIndex), 0)))
          eDate = messages.getString("calendar.today");
        else
          eDate = null;
    
        dateTemp = CommonFunction.getDate("yyyy-MM-dd hh:mm", (String)vDueDate.get(middleToDoIndex)+" "+(String)vDueTime.get(middleToDoIndex), 0);
    
        if (eDate == null || !eDate.equals("Today")) {
		      eDate = CommonFunction.getDate("yyyy-MM-dd", dateTemp, 0);
					eDate = CommonFunction.parseDate(dateFormat,currentLocale,eDate,null,TvoConstants.DATE_FOMRAT_SHORT);
        }
        eTime = CommonFunction.getDate("h:mm aa", dateTemp, 0);
    
        overDue = "";
        if (dateTimeNow.after(dateTemp))
          overDue = "<U>"+messages.getString("calendar.todo.overdue") +"</U> ";
    
    %><a href="servlet/Calendar?action=completeToDo&toDoID=<%= vToDoID.get(middleToDoIndex) %>" onMouseOver="window.status='<%= messages.getString("calendar.todo.completed.button") %>';return (true);"><IMG 
      SRC="images/system/checkbox.gif" BORDER="0" WIDTH="14" HEIGHT="14" ALIGN="ABSMIDDLE" ALT="<%= messages.getString("calendar.todo.completed.button") %>"></a> <%
    
        if ( ((String)vUserID.get(middleToDoIndex)).equals(userID) ) {
    %><A HREF="javascript:MM_openBrWindow('calendar.jsp?action=editToDo&toDoID=<%= vToDoID.get(middleToDoIndex) %>','calendarAdd','scrollbars=yes,resizable=yes,width=480,height=420');" onMouseOver="window.status='<%= messages.getString("edit") %>';return true;"><IMG 
       SRC="images/system/note.gif" BORDER="0" WIDTH="13" HEIGHT="16" ALIGN="ABSMIDDLE" ALT="<%= messages.getString("edit") %>"></A><%
        } else {
    %><IMG SRC="images/system/todoedit.gif" BORDER="0" WIDTH="15" HEIGHT="14" ALIGN="ABSMIDDLE" ALT="Assigned Task"><%
        }
    %> <A HREF="calendar.jsp?action=view&date=<%= middleToDoDate %>&month=<%= middleToDoMonth %>&year=<%= middleToDoYear %>" onMouseOver="window.status='<%= messages.getString("view") %>';return true;"><%= vDescription.get(middleToDoIndex) %></A>
        - <FONT COLOR="#FF0000" CLASS="highlight" SIZE="2"><%= overDue %><%= messages.getString("calendar.todo.deadline") %>: <%= eDate %> <%= eTime %></FONT>
    </LI><%
      }
    }
    else
    {
    %>
      <LI><%= messages.getString("calendar.viewday.no.todo") %></LI>
    <%
    }
    %><!-- TO DO LIST END --><%
    }
    else
    {
    %><LI><FONT COLOR="#FF0000">ERROR: Invalid Date<BR>
      date=<%= middleToDoDate %>, month=<%= middleToDoMonth %>, year=<%= middleToDoYear %><BR><BR>
      Possible causes: parameters not provided when calling this page or parameters are out of range
      </FONT></LI><%
    }


  }
  else {
    // no permission
%>  
  <LI>
  You have no access to the Calendar, please contact your System Administrator for access.
  </LI>
<%
  }    
%>
                          </UL><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="5"></TD>
                        </TR>
                        <TR BGCOLOR="#EFEFEF">
                          <TD VALIGN="TOP" CLASS="contentBgColor"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="5"></TD>
                        </TR>
                      </TABLE>
                      </DIV>
	<SCRIPT>
		loadBox("middletodo");
	</SCRIPT>
                      <!-- To Do List Main Content Box END -->
<%
} } // Module Manager - Personal %>
