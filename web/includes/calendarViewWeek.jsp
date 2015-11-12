<%@ page import="java.util.Calendar, java.util.Date, java.text.SimpleDateFormat, java.text.ParsePosition" %>
<%
  String date=null, month=null, year=null;
  String nextDate=null, prevDate=null, nextMonth=null, prevMonth=null, nextYear=null, prevYear=null;
  String weekDate=null, weekMonth=null, weekYear=null;
  boolean dateIsInvalid = false;
  java.util.Calendar cal, cal2;
  int i,j;
    
  TvoContextManager.setSessionAttribute(request, "Calendar.lastView", "viewWeek");
  if (request.getParameter("date") != null) {
    TvoContextManager.setSessionAttribute(request, "Calendar.date", request.getParameter("date"));
    date = request.getParameter("date");
  } else if (TvoContextManager.getSessionAttribute(request, "Calendar.date") != null) {
    date = (String)TvoContextManager.getSessionAttribute(request, "Calendar.date");
  } else {
	  date = Integer.toString(Calendar.getInstance().get(Calendar.DAY_OF_MONTH));
  }

  if (request.getParameter("month") != null) {
    TvoContextManager.setSessionAttribute(request, "Calendar.month", request.getParameter("month"));
    month = request.getParameter("month");
  } else if (TvoContextManager.getSessionAttribute(request, "Calendar.month") != null) {
    month = (String)TvoContextManager.getSessionAttribute(request, "Calendar.month");
  } else {
	  month = Integer.toString(Calendar.getInstance().get(Calendar.MONTH));
  }

  if (request.getParameter("year") != null) {
    TvoContextManager.setSessionAttribute(request, "Calendar.year", request.getParameter("year"));
    year = request.getParameter("year");
  } else if (TvoContextManager.getSessionAttribute(request, "Calendar.year") != null) {
    year = (String)TvoContextManager.getSessionAttribute(request, "Calendar.year");
  } else {
	  year = Integer.toString(Calendar.getInstance().get(Calendar.YEAR));
  }
  
  try
  {
    cal = java.util.Calendar.getInstance();
    cal.setLenient(false);
    cal.clear();
    cal.set(Integer.parseInt(year), Integer.parseInt(month), 1);
    
    if (Integer.parseInt(year) > cal.getActualMaximum(java.util.Calendar.YEAR) ||
        Integer.parseInt(year) < cal.getActualMinimum(java.util.Calendar.YEAR) )
      dateIsInvalid = true;

    if (Integer.parseInt(month) > cal.getActualMaximum(java.util.Calendar.MONTH) ||
        Integer.parseInt(month) < cal.getActualMinimum(java.util.Calendar.MONTH) )
      dateIsInvalid = true;

    if (Integer.parseInt(date) > cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH) ||
        Integer.parseInt(date) < cal.getActualMinimum(java.util.Calendar.DAY_OF_MONTH) )
    {
      if (Integer.parseInt(month) == 1)
      {
        TvoContextManager.setSessionAttribute(request, "Calendar.date", String.valueOf(cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH)));
        date = String.valueOf(cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH));
      }
      else
        dateIsInvalid = true;
    }
  }
  catch (NumberFormatException e)
  {
    dateIsInvalid = true;
  }
  catch (IllegalArgumentException e)
  {
    dateIsInvalid = true;
  }
  finally
  {
    if (!dateIsInvalid)
    {
      cal = java.util.Calendar.getInstance();
      cal.setLenient(false);
      cal.clear();
      cal.set(Integer.parseInt(year), Integer.parseInt(month), Integer.parseInt(date));
      cal.add(Calendar.DATE, 7);
      nextYear = String.valueOf(cal.get(Calendar.YEAR));
      nextMonth = String.valueOf(cal.get(Calendar.MONTH));
      nextDate = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));
      cal.add(Calendar.DATE, -14);
      prevYear = String.valueOf(cal.get(Calendar.YEAR));
      prevMonth = String.valueOf(cal.get(Calendar.MONTH));
      prevDate = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));
    }
  }
  
  if (date != null && month != null && year != null && !dateIsInvalid)
  {
    Vector vAppointments=null, vEvents=null, vToDo=null;
    Vector vEventID=null;
    Vector vRepeatDay=null;
    String realUserID=null;
    boolean toDoHeader;
    SimpleDateFormat sdfTime=null, sdfDate=null;
    String sDate=null, eDate=null, sTime=null, eTime=null, today="", overDue="";
    ParsePosition pos;
    Date dateTemp=null, dateTimeNow=null, dateNow=null;
    
    realUserID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
    
    cal = java.util.Calendar.getInstance();
    cal.setLenient(false);
    cal.clear();
    cal.set(Integer.parseInt(year), Integer.parseInt(month), Integer.parseInt(date));
    cal.get(java.util.Calendar.DATE);
    %>
      <TR VALIGN="MIDDLE" >
        <TD BGCOLOR="#003366" CLASS="contentStrapColor" COLSPAN="2" ALIGN="CENTER"><b>Calendar </b></TD>
      </TR>
      <TR BGCOLOR="#E2E2E2">
        <TD VALIGN="TOP" CLASS="contentBgColor" COLSPAN="2">
			<B><A HREF="calendar.jsp?action=view&date=<%= prevDate %>&month=<%= prevMonth %>&year=<%= prevYear %>" onMouseOver="window.status='<%= messages.getString("calendar.go.back.one.week") %>';return true;"><IMG SRC="images/system/previous.gif" BORDER="0" ALT="<%= messages.getString("calendar.go.back.one.week") %>" style="vertical-align:middle;" /></A>
			<%= messages.getString("calendar.week") %>: 
		<%		
		cal.set(java.util.Calendar.DAY_OF_WEEK, 1);
			String day = dayNames[cal.get(java.util.Calendar.DAY_OF_WEEK)-1];
			day = messages.getString("short."+day.toLowerCase());
			String date2="",month2="",year2="";
			
			
			date2 = String.valueOf(cal.get(java.util.Calendar.DATE));
			if (date2.length() == 1)
			  date2 = "0"+date2;
			month2 =  String.valueOf(cal.get(java.util.Calendar.MONTH)+1);
			if (month2.length() == 1)
			  month2 = "0"+month2;
			year2 = String.valueOf(cal.get(java.util.Calendar.YEAR));
			
			
		out.print(day + ", ");	
		out.print(CommonFunction.parseDate(dateFormat,currentLocale,date2+month2+year2,null,"ddMMyyyy"));																			 
		out.print(" - ");
		
		cal.set(java.util.Calendar.DAY_OF_WEEK, 7);
			day = dayNames[cal.get(java.util.Calendar.DAY_OF_WEEK)-1];
			day = messages.getString("short."+day.toLowerCase());
			
		out.print(day + ", ");
			
		  date2 = String.valueOf(cal.get(java.util.Calendar.DATE));
			if (date2.length() == 1)
			  date2 = "0"+date2;
			month2 =  String.valueOf(cal.get(java.util.Calendar.MONTH)+1);
			if (month2.length() == 1)
			  month2 = "0"+month2;

			year2 = String.valueOf(cal.get(java.util.Calendar.YEAR));
			
			

	  out.print(CommonFunction.parseDate(dateFormat,currentLocale,date2+month2+year2,null,"ddMMyyyy"));



		%>
			<A HREF="calendar.jsp?action=view&date=<%= nextDate %>&month=<%= nextMonth %>&year=<%= nextYear %>" onMouseOver="window.status='<%= messages.getString("calendar.go.forward.one.week") %>';return true;"><IMG SRC="images/system/next.gif" BORDER="0" ALT="<%= messages.getString("calendar.go.forward.one.week") %>" style="vertical-align:middle;" /></A>
			</B>&nbsp;
			<!-- <a href="calendar.jsp?action=printAppt"><img src="images/system/ic_print.gif" alt="" style="vertical-align:middle;" /></a> -->
			<a href="calendar.jsp?action=printAppt"><img src="images/printexport.png" alt="Print / Export" style="vertical-align:middle; border:0px;" /></a>
		</TD>
      </TR>
    <%
    for (i=1; i < 8; i++)
    {
      cal2 = java.util.Calendar.getInstance();
      cal2.get(java.util.Calendar.DATE);
      
      cal = java.util.Calendar.getInstance();
      cal.setLenient(false);
      cal.clear();
      cal.set(Integer.parseInt(year), Integer.parseInt(month), Integer.parseInt(date));
      cal.get(java.util.Calendar.DATE);

      cal.set(java.util.Calendar.DAY_OF_WEEK, i);
      weekDate = String.valueOf(cal.get(java.util.Calendar.DATE));
      weekMonth = String.valueOf(cal.get(java.util.Calendar.MONTH));
      weekYear = String.valueOf(cal.get(java.util.Calendar.YEAR));
      toDoHeader = true;
      %>
      <TR VALIGN="LEFT">
      <%
			  day = dayNames[cal.get(java.util.Calendar.DAY_OF_WEEK)-1];
				day = messages.getString("short."+day.toLowerCase());

      if (cal2.get(java.util.Calendar.DAY_OF_MONTH) == Integer.parseInt(weekDate) &&
          cal2.get(java.util.Calendar.MONTH) == Integer.parseInt(weekMonth) &&
          cal2.get(java.util.Calendar.YEAR) == Integer.parseInt(weekYear) )
      {

      %>
          <TD BGCOLOR="#E2E2E2" CLASS="contentBgColor" VALIGN="TOP" ALIGN="RIGHT" WIDTH="10%">
          <A HREF="calendar.jsp?action=viewDay&date=<%= weekDate %>&month=<%= weekMonth %>&year=<%= weekYear %>" onMouseOver="window.status='<%= messages.getString("view") %>';return true;">
          <B><FONT COLOR="#0065CE" CLASS="textFont"><%= messages.getString("calendar.today") %></FONT>&nbsp;&nbsp;<BR>
            <%= day %></B>&nbsp;&nbsp;<BR>
            <%= cal.get(java.util.Calendar.DATE) %>&nbsp;&nbsp;
            </A>
          </TD>
      <%
      }
      else if (date.equals(weekDate) && month.equals(weekMonth) && year.equals(weekYear))
      {
      %>
          <TD BGCOLOR="#E2E2E2" CLASS="contentBgColor" VALIGN="TOP" ALIGN="RIGHT" WIDTH="10%">
          <A HREF="calendar.jsp?action=viewDay&date=<%= weekDate %>&month=<%= weekMonth %>&year=<%= weekYear %>" onMouseOver="window.status='<%= messages.getString("view") %>';return true;">
          <B><FONT COLOR="#0065CE" CLASS="textFont"><%= day %>*</FONT></B>&nbsp;&nbsp;<BR>
            <%= cal.get(java.util.Calendar.DATE) %>&nbsp;&nbsp;</A>
          </TD>
      <%
      }
      else
      {
      %>
          <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" VALIGN="TOP" ALIGN="RIGHT" WIDTH="10%">
          <A HREF="calendar.jsp?action=viewDay&date=<%= weekDate %>&month=<%= weekMonth %>&year=<%= weekYear %>" onMouseOver="window.status='<%= messages.getString("view") %>';return true;">
          <B><FONT COLOR="#FF0000">
          <%= day %>
          </FONT></B>&nbsp;&nbsp;<BR>
            <%= cal.get(java.util.Calendar.DATE) %>&nbsp;&nbsp;
            </A>
          </TD>
      <%
      }
      %>
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColorAlternate" VALIGN="TOP" WIDTH="90%">
      <!-- APPOINTMENTS START -->
      <%
      if (TvoContextManager.getSessionAttribute(request, "Calendar.viewUserID") == null)
      {    
        vAppointments = (Vector)beanCalendar.getAppointments(userID,realUserID,weekDate,weekMonth,weekYear);
      }
      else
      {
        vAppointments = (Vector)beanCalendar.getAppointments((String)TvoContextManager.getSessionAttribute(request, "Calendar.viewUserID"),realUserID,weekDate,weekMonth,weekYear);
      }      
      if (vAppointments != null && vAppointments.size() > 0)
      {
      %>
      <P>
        <B><FONT COLOR="#003366"><%= messages.getString("calendar.viewday.appointments") %></FONT></B><BR>
        <B><FONT COLOR="#999999">. . . . . . . . . . . . . . . . . . . . . .</FONT></B><BR>
      <%
        for (j=0; j < vAppointments.size(); j++)
        {
				  CalendarApptUser calendarAppt = (CalendarApptUser) vAppointments.get(j);
          pos = new ParsePosition(0);
          sdfDate = new SimpleDateFormat("yyyy-MM-dd");
          dateTemp = sdfDate.parse(weekYear+"-"+String.valueOf(Integer.parseInt(weekMonth)+1)+"-"+weekDate,pos);
          today = sdfDate.format(dateTemp);
      
          if (  calendarAppt.getReminderDate() != null && calendarAppt.getReminderDate().equals(today) )
          {
            %>
              <FONT COLOR="#FF0000"><%= messages.getString("calendar.reminder.for") %>:</FONT><BR>
            <%
          }
					if (!calendarAppt.getStartTime().equals("")){
          sTime = CommonFunction.getDate("HH:mm","h:mm aa",calendarAppt.getStartTime());
          
          eTime = CommonFunction.getDate("HH:mm","h:mm aa",calendarAppt.getEndTime());
          %>
            <FONT COLOR="#FF0000"><%= sTime %> - <%= eTime %></FONT><BR>
          <%
					 }          
		    	 sDate = CommonFunction.parseDate(dateFormat,currentLocale,calendarAppt.getStartDate(),null,TvoConstants.DATE_FOMRAT_SHORT);
    			 eDate = CommonFunction.parseDate(dateFormat,currentLocale,calendarAppt.getEndDate(),null,TvoConstants.DATE_FOMRAT_SHORT);
          
          if ( !(calendarAppt.getStartDate()).equals(calendarAppt.getEndDate()) || 
                (calendarAppt.getReminderDate() != null && calendarAppt.getReminderDate().equals(today)) )
          {
            %>
              <FONT COLOR="#FF0000">(<%= sDate %> - <%= eDate %>)</FONT><BR>
            <%
          }
        
      %>
      <FONT COLOR="#0065CE" CLASS="textFont">
      <%= calendarAppt.getDescription() %>
      </FONT><BR>
			<hr size="1" width="70%" align="left">
      <%
        }
      %>
      </P>
      <%
      }
      %>
      <!-- APPOINTMENTS END -->

      <!-- TO DO LIST START -->
      <%
      if (TvoContextManager.getSessionAttribute(request, "Calendar.viewUserID") == null)
      {    
        vToDo = (Vector)beanCalendar.getToDo(userID,realUserID,weekDate,weekMonth,weekYear);
      }
      else
      {
        vToDo = (Vector)beanCalendar.getToDo((String)TvoContextManager.getSessionAttribute(request, "Calendar.viewUserID"),realUserID,weekDate,weekMonth,weekYear);
      }      
			

      if (vToDo != null && vToDo.size() > 0)
      {

        pos = new ParsePosition(0);
        sdfDate = new SimpleDateFormat("d MMM yyyy");
        dateNow = sdfDate.parse(weekDate+" "+monthNames[Integer.parseInt(weekMonth)]+" "+weekYear ,pos);
      
        cal = java.util.Calendar.getInstance();
        pos = new ParsePosition(0);
        sdfDate = new SimpleDateFormat("d MMM yyyy");
        dateTimeNow = sdfDate.parse(weekDate+" "+monthNames[Integer.parseInt(weekMonth)]+" "+weekYear,pos);
        
        toDoHeader = true;
        for(j=0; j < vToDo.size(); j++)
        {
				  CalendarToDoUser calendar = (CalendarToDoUser) vToDo.get(j);
					
          pos = new ParsePosition(0);
          sdfDate = new SimpleDateFormat("yyyy-MM-dd");
          dateTemp = sdfDate.parse(weekYear+"-"+String.valueOf(Integer.parseInt(weekMonth)+1)+"-"+weekDate,pos);
          today = sdfDate.format(dateTemp);
					

          
          if ( calendar.getReminderDate() != null && calendar.getReminderDate().equals(today) )
          {
            if (toDoHeader)
            {
              toDoHeader = false;
      %>
      <P>
        <B><FONT COLOR="#003366"><%= messages.getString("calendar.viewday.todo.list") %></FONT></B><BR>
        <FONT COLOR="#999999">. . . . . . . . . . . . . . . . . . . . . .</FONT></B><BR>
      <%
            }
            %>
              <FONT COLOR="#FF0000"><%= messages.getString("calendar.reminder.for") %>: </FONT><BR>
            <%
          }
          
					
					eTime = CommonFunction.getDate("HH:mm","h:mm aa",calendar.getDueTime());
          eDate = CommonFunction.parseDate(dateFormat,currentLocale,calendar.getDueDate(),null,TvoConstants.DATE_FOMRAT_SHORT);
          
          pos = new ParsePosition(0);
          sdfDate = new SimpleDateFormat("yyyy-MM-dd");
          dateTemp = sdfDate.parse(calendar.getDueDate(),pos);
          
          if (dateTimeNow.after(dateTemp) && calendar.getStatus().equals("0") )
            overDue = "<U>"+messages.getString("calendar.todo.overdue")+"</U>";
          else if ( calendar.getStatus().equals("1") )
            overDue = "<U>"+messages.getString("calendar.todo.completed")+"</U>";
          else
            overDue = "";
          if ( ( dateTimeNow.equals(dateTemp) || (calendar.getReminderDate() != null && calendar.getReminderDate().equals(today)) ) ||
               ( calendar.getStatus().equals("1") ) 
             )
          {
            if (toDoHeader)
            {
              toDoHeader=false;
      %>
      <P>
        <B><FONT COLOR="#003366"><%= messages.getString("calendar.viewday.todo.list") %></FONT></B><BR>
        <FONT COLOR="#999999">. . . . . . . . . . . . . . . . . . . . . .</FONT></B><BR>
      <%
            }
      %>
      <B><%= overDue %> <%= messages.getString("calendar.todo.deadline") %>:</B>
      <FONT COLOR="#FF0000"><%= eDate %> <%= eTime %></FONT><BR>
      <FONT COLOR="#0065CE" CLASS="textFont">
      <%= calendar.getDescription() %></FONT><BR>
					<hr size="1" width="70%" align="left">
      <%
          }
        }
      %>
      </P>
      <%
      }
      %>
      <!-- TO DO LIST END -->

      <!-- EVENTS START
      <%
		Vector calEvents;
      
      if (TvoContextManager.getSessionAttribute(request, "Calendar.viewUserID") == null && realUserID != null && weekDate != null && weekMonth != null && weekYear != null)
      {    
		  calEvents = beanCalendar.getCalendarEvents(userID,realUserID,weekDate,weekMonth,weekYear);
      }
      else
      {
		  calEvents = beanCalendar.getCalendarEvents((String)TvoContextManager.getSessionAttribute(request, "Calendar.viewUserID"),realUserID,weekDate,weekMonth,weekYear);
      }      
     if (calEvents.size() > 0) {
      %>
      <P>
        <B><FONT COLOR="#003366"> <%= messages.getString("calendar.viewday.events") %></FONT></B><BR>
        <B><FONT COLOR="#999999">. . . . . . . . . . . . . . . . . . . . . .</FONT></B><BR>
      <%
        for (Iterator it = calEvents.iterator(); it.hasNext(); ) {
        		 CalendarEvent event = (CalendarEvent)it.next();
            if (event.isReminder()) {
              %>
                <FONT COLOR="#FF0000"><%= messages.getString("calendar.reminder.for") %>:<BR>
            <% }
 		%>
        <FONT COLOR="#FF0000"><%= CommonFunction.getDate("HH:mm", "h:mm aa", event.getStartTime()) %> - <%= CommonFunction.getDate("HH:mm", "h:mm aa", event.getEndTime()) %></FONT>
		<%
           if (event.isReminder()) {
					   sDate = CommonFunction.getDate(TvoConstants.DATE_FOMRAT_SHORT, event.getStartDate(), 0);
						 sDate = CommonFunction.parseDate(dateFormat,currentLocale,sDate,null,TvoConstants.DATE_FOMRAT_SHORT);
						 
					   eDate = CommonFunction.getDate(TvoConstants.DATE_FOMRAT_SHORT, event.getEndDate(), 0);
						 eDate = CommonFunction.parseDate(dateFormat,currentLocale,eDate,null,TvoConstants.DATE_FOMRAT_SHORT);

						 
              %>
                (<%= sDate %> - <%= eDate %>)</FONT>
              <% } %>
      <br><SPAN CLASS="textFont"><FONT COLOR="#0065CE">
        <%= (event.getDescription() == null) ? "" : event.getDescription() %>
      </FONT></SPAN>
      <BR>   
        <%
        }
        
      %>
      </P>
      <%
      }
      %>
EVENTS END -->
          &nbsp;</TD>
        </TR>
        <TR BGCOLOR="#E2E2E2">
          <TD VALIGN="TOP" CLASS="contentBgColor" WIDTH="10%"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="5"></TD>
          <TD VALIGN="TOP" CLASS="contentBgColor" WIDTH="90%"><IMG SRC="images/system/blank.gif" WIDTH="55" HEIGHT="5"></TD>
        </TR>
      <%
    } // for
}
else
{
%>
  <TR VALIGN="MIDDLE">
    <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" COLSPAN="2">
      <BLOCKQUOTE>
      <FONT COLOR="#FF0000"><%= messages.getString("calendar.invalid.date") %><BR>
      date=<%= date %>, month=<%= month %>, year=<%= year %><BR><BR>
			<%= messages.getString("calendar.date.error") %>
      </FONT>
      </BLOCKQUOTE>
    </TD>
  </TR>
<%
}
%>
