<%@ page import="java.util.Hashtable,java.util.Calendar,java.util.Vector,java.util.Iterator,common.*,ecomm.bean.*" %>
<jsp:useBean id="beanRightEventCalendarACL" scope="request" class="ecomm.bean.ACL" />
<jsp:useBean id="beanRightEventCalendar" scope="request" class="ecomm.bean.CalendarCalendar" />
<%

  String userID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
  Hashtable eventUserACL, eventGroupACL;
  Messages messages = Messages.getMessages(request);
	beanRightEventCalendarACL.initTVO(request);
	beanRightEventCalendar.initTVO(request);
	
  eventUserACL = beanRightEventCalendarACL.getRights(userID, "Calendar", "User");
  eventGroupACL = beanRightEventCalendarACL.getRights(userID, "Calendar", "Group");

  if ( (eventUserACL.containsKey("view") && eventUserACL.get("view").equals("1")) ||
       (eventGroupACL.containsKey("view") && eventGroupACL.get("view").equals("1")) ) {
	
	boolean showIcon = false;

	String language = (String)TvoContextManager.getAttribute(request, "System.language");
	String sideTitleFont = "sideTitleFont";
	if (language.equals("zh") || language.equals("ja"))
  	sideTitleFont = "sideTitleGlyphFont";
		
  if ( language.equals("en"))
    showIcon = true;
	
%>		

<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="1">
  <TR ALIGN="CENTER">
     <TD CLASS="sideTitleBgBorderColor" BGCOLOR="#1059A5">
        <A href="" onclick="toggleBlock('rightevent'); return false" onMouseOver="window.status='<%= CommonFunction.escapeQuote(messages.getString("today.event")) %>';return true;">          </a><a href="" onclick="toggleBlock('rightstatus'); return false" onmouseover="window.status='<%= messages.getString("status") %>';return true;"></a><A href="" onclick="toggleBlock('rightevent'); return false" onMouseOver="window.status='<%= CommonFunction.escapeQuote(messages.getString("today.event")) %>';return true;"><FONT COLOR="#FFFFFF" CLASS="<%= sideTitleFont %>"><%= messages.getString("today.event") %></FONT>
	        </a>
				
				
				<DIV id="rightevent">
                  <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="5">
                    <TR>
                      <TD BGCOLOR="#FFFFFF" Class='contentBgColorAlternate'><!-- CLASS="sideBodyFontAndBgColor"-->
<%
 		 Calendar cal = Calendar.getInstance();
		 

		 String date = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));
		 String month = String.valueOf(cal.get(Calendar.MONTH));
		 String year = String.valueOf(cal.get(Calendar.YEAR));
		 String sDate = "";
		 boolean hasEvent = false;
	  
		 Vector calEvents = beanRightEventCalendar.getCalendarEvents(userID, userID, date, month, year);
%>
			<UL>
<%		 
		 
		 if (calEvents != null && calEvents.size() > 0){
		   for (Iterator it = calEvents.iterator(); it.hasNext();) {
			 	    CalendarEvent event = (CalendarEvent)it.next();
						
						if (!event.isReminder()){
						  hasEvent = true;

%>
						<LI><a href="event.jsp?action=view&date=<%= date %>&month=<%= month %>&year=<%= year %>" onMouseOver="window.status='<%= messages.getString("view") %>';return true;"><%= CommonFunction.getDate("HH:mm", "h:mm aa", event.getStartTime()) %><br>
						<%= event.getDescription() %></a></LI>
<%						
						
						}
						

			 }
			   
		 }
		
		 if (!hasEvent) {
%>
				<LI><%= messages.getString("calendar.viewday.no.events") %></LI>
<%	 }  %>	
      </UL>										
			
      <CENTER>
         <A HREF="javascript:MM_openBrWindow('calendar.jsp?action=addEvent','calendarAdd','scrollbars=yes,resizable=yes,width=480,height=420');" onMouseOver="window.status='<%= messages.getString("add") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_add.gif\" WIDTH=\"30\" HEIGHT=\"18\" BORDER=\"0\" ALT=\"Add\">" : messages.getString("add") %></A>
      </CENTER>

			
					  </td>
					</tr>
				  </table>
			 </div>									
				
    </td>
  </tr>
	   <TR HEIGHT="5">
     <TD></TD>
   </TR>

</table>	 

<% } %>

