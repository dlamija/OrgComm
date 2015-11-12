<%@ page import="common.*, ecomm.bean.*, java.util.*, tvo.TvoConstants" %>
<jsp:useBean id="beanRightApptCalendar" scope="request" class="ecomm.bean.CalendarCalendar" />
<jsp:useBean id="beanRightApptCalendarACL" scope="request" class="ecomm.bean.ACL" />
<jsp:useBean id="beanPersonal" scope="request" class="ecomm.bean.PersonalPersonal" />

<%
  String userID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
  Hashtable apptUserACL, apptGroupACL;
  beanRightApptCalendar.initTVO(request);
  beanRightApptCalendarACL.initTVO(request);
  apptUserACL = beanRightApptCalendarACL.getRights(userID, "Calendar", "User");
  apptGroupACL = beanRightApptCalendarACL.getRights(userID, "Calendar", "Group");
	String language = (String)TvoContextManager.getAttribute(request, "System.language");
  if ( (apptUserACL.containsKey("view") && apptUserACL.get("view").equals("1")) ||
       (apptGroupACL.containsKey("view") && apptGroupACL.get("view").equals("1")) )
  {


  beanPersonal.initTVO(request);

  Messages messages = Messages.getMessages(request);
	boolean showIcon = false;

	String sideTitleFont = "sideTitleFont";
	if (language.equals("zh") || language.equals("ja"))
  	sideTitleFont = "sideTitleGlyphFont";

  if ( language.equals("en"))
    showIcon = true;


// Module Manager - Personal
if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_PERSONAL) ) {
%>
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="1">
  <TR ALIGN="CENTER">
     <TD CLASS="sideTitleBgBorderColor" BGCOLOR="#1059A5">
     <A href="" onclick="toggleBlock('rightappt'); return false" onMouseOver="window.status='<%= CommonFunction.escapeQuote(messages.getString("today.appointment")) %>';return true;">     </A><a href="" onclick="toggleBlock('rightstatus'); return false" onmouseover="window.status='<%= messages.getString("status") %>';return true;"></a><A href="" onclick="toggleBlock('rightappt'); return false" onMouseOver="window.status='<%= CommonFunction.escapeQuote(messages.getString("today.appointment")) %>';return true;"><FONT COLOR="#FFFFFF" CLASS="<%= sideTitleFont %>"><%= messages.getString("today.appointment") %></FONT>
     </A>

                  <DIV id="rightappt">
                  <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="5">
                    <TR>
                      <TD BGCOLOR="#FFFFFF" class='contentBgColorAlternate'><!--CLASS="sideBodyFontAndBgColor"-->

<%@ page import="java.util.Calendar, java.util.Date,java.util.Locale" %>
<%

  String date=null, month=null, year=null;
  java.util.Calendar cal;
  int j;

  // permission check
  if ( (apptUserACL.containsKey("view") && apptUserACL.get("view").equals("1")) ||
       (apptGroupACL.containsKey("view") && apptGroupACL.get("view").equals("1")) ) {

      cal = java.util.Calendar.getInstance();
      date = String.valueOf(cal.get(java.util.Calendar.DAY_OF_MONTH));
      month = String.valueOf(cal.get(java.util.Calendar.MONTH));
      year = String.valueOf(cal.get(java.util.Calendar.YEAR));

      if (date != null && month != null && year != null) {
        Vector vAppointments=null;
    
        String sTime="";
        
        Date dateTemp=null;
				
				String country = (String)TvoContextManager.getAttribute(request, "System.country");
				String dateFormat = (String)TvoContextManager.getAttribute(request,"System.dateFormat");
				Locale currentLocale = new Locale(language,country);

        
        vAppointments = (Vector)beanRightApptCalendar.getAppointmentsToday(userID,date,month,year, 2);
    %>
    <!-- APPOINTMENT START -->
    <UL>
        <%
        if (vAppointments != null && vAppointments.size() > 0) {

          for (j=0; j < vAppointments.size(); j++) {
					  	 CalendarAppt calendar = (CalendarAppt) vAppointments.get(j);
            %><LI><%
						
						if (!calendar.getStartTime().equals("00:00")  && !calendar.getEndTime().equals("23:59"))
	            sTime = CommonFunction.getDate("HH:mm", "h:mm aa", calendar.getStartTime()); 



          %><A HREF="calendar.jsp?action=view&date=<%= date %>&month=<%= month %>&year=<%= year %>&revert=true" onMouseOver="window.status='<%= messages.getString("view") %>';return true;">
					<% if (!sTime.equals("")) { %>
            <B><%= sTime %></B>
						<br>
          <% } %>						
            <%= calendar.getDescription() %>
            </A>
            </LI><%
          }
        } else {
        %>
          <LI><%= messages.getString("calendar.viewday.no.appointments") %></LI>
        <%
        }
       %></UL><%
      } else {
      %>
      <FONT COLOR="#FF0000">ERROR: Invalid Date<BR>
      date=<%= date %>, month=<%= month %>, year=<%= year %><BR><BR>
      Possible causes: parameters not provided when calling this page or parameters are out of range
      </FONT>
      <%
      }
    %>
    <!-- APPOINTMENT END -->
                            <CENTER>
                              <A HREF="calendar.jsp?action=addAppt" onMouseOver="window.status='<%= messages.getString("add") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_add.gif\" WIDTH=\"30\" HEIGHT=\"18\" BORDER=\"0\" ALT=\"Add\">" : messages.getString("add") %></A>
                            </CENTER>
<% }
   else {
%>
<UL><LI>AAA<%= messages.getString("calendar.user.no.access") %></LI></UL>
<%   
   }
   // end permission check 
%>
   
                      </TD>
                    </TR>
                  </TABLE>
                  </DIV>
    </TD>
  </TR>
   <TR HEIGHT="5">
     <TD></TD>
   </TR>
</TABLE>
	<SCRIPT LANGUAGE="JavaScript">
		loadBox('rightappt');
	</SCRIPT>
<%
} } // Module Manager - Personal %>
