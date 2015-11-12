<%@ page import="java.util.Calendar" %>
<%
  String date=null, month=null, year=null;
  String nextDate=null, prevDate=null, nextMonth=null, prevMonth=null, nextYear=null, prevYear=null;
  boolean dateIsInvalid = false;
  int i,j,k,lastDateOfMonth=0,lastDayOfMonth=0;
  java.util.Calendar cal, cal2;
  
  TvoContextManager.setSessionAttribute(request, "Calendar.lastView", "viewMonth");
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
      cal.add(Calendar.MONTH, 1);
      nextYear = String.valueOf(cal.get(Calendar.YEAR));
      nextMonth = String.valueOf(cal.get(Calendar.MONTH));
      nextDate = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));
      cal.add(Calendar.MONTH, -2);
      prevYear = String.valueOf(cal.get(Calendar.YEAR));
      prevMonth = String.valueOf(cal.get(Calendar.MONTH));
      prevDate = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));
    }
  }
  
  if (date != null && month != null && year != null && !dateIsInvalid)
  {
    Vector vAppointments=null, vEvents=null, vToDo=null;
    Vector vToDoID=null;
    Vector vEventID=null, vDueDate=null;
    Vector vStartDate=null, vEndDate=null, vRepeatDay=null;
	Vector vDesc=null, vStartTime=null;

    SimpleDateFormat sdfDate=null;
    ParsePosition pos;
    Date dateStart=null, dateEnd=null, dateNow=null, dateTemp=null;
	String apptDesc="", todoDesc="";
    
    String currentDate=null;
    String realUserID=null;
    int apptCount, todoCount, eventCount;
		
		String month2 = monthNames[Integer.parseInt(month)];
		month2 = messages.getString("short."+month2.toLowerCase());
    
%>
    <TR VALIGN="MIDDLE" >
      <TD BGCOLOR="#003366" CLASS="contentStrapColor" COLSPAN="7" ALIGN="CENTER"><b>Calendar </b></TD>
    </TR>

    <TR BGCOLOR="#EFEFEF">
      <TD VALIGN="TOP" CLASS="contentBgColor" COLSPAN="7">
		  <B><A HREF="calendar.jsp?action=view&date=<%= prevDate %>&month=<%= prevMonth %>&year=<%= prevYear %>" onMouseOver="window.status='<%= messages.getString("calendar.go.back.one.month") %>';return true;"><IMG SRC="images/system/previous.gif" BORDER="0" ALT="<%= messages.getString("calendar.go.back.one.month") %>" style="vertical-align:middle;" /></A>
		  <%= messages.getString("calendar.month") %>: <FONT COLOR="#0065CE" CLASS="textFont">
		  <%= month2 %></FONT> <%= year %>
		  <A HREF="calendar.jsp?action=view&date=<%= nextDate %>&month=<%= nextMonth %>&year=<%= nextYear %>" onMouseOver="window.status='<%= messages.getString("calendar.go.forward.one.month") %>';return true;"><IMG SRC="images/system/next.gif" BORDER="0" ALT="<%= messages.getString("calendar.go.forward.one.month") %>" style="vertical-align:middle;" /></A>
		  </B>&nbsp;
			<!-- <a href="calendar.jsp?action=printAppt"><img src="images/system/ic_print.gif" alt="" style="vertical-align:middle;" /></a>&nbsp; -->
			<a href="calendar.jsp?action=printAppt"><img src="images/printexport.png" alt="Print / Export" style="vertical-align:middle; border:0px;" /></a> | 
		  <a target="_blank" href="calendar.jsp?action=printMonth&date=<%=date %>&month=<%=month %>&year=<%=year %>">Print-friendly version</a>
	  </TD>
    </TR>
    
    <TR VALIGN="MIDDLE" BGCOLOR="#DBDBDB">
      <TD BGCOLOR="#DBDBDB" CLASS="contentBgColorAlternate" VALIGN="TOP">
       <B><FONT COLOR="#FF0000"><%= messages.getString("short.sun") %></FONT></B></TD>
      <TD CLASS="contentBgColorAlternate" VALIGN="TOP"><B>
        <%= messages.getString("short.mon") %></B></TD>
      <TD CLASS="contentBgColorAlternate" VALIGN="TOP"><B>
        <%= messages.getString("short.tue") %></B></TD>
      <TD CLASS="contentBgColorAlternate" VALIGN="TOP"><B>
        <%= messages.getString("short.wed") %></B></TD>
      <TD CLASS="contentBgColorAlternate" VALIGN="TOP"><B>
        <%= messages.getString("short.thu") %></B></TD>
      <TD CLASS="contentBgColorAlternate" VALIGN="TOP"><B>
        <%= messages.getString("short.fri") %></B></TD>
      <TD CLASS="contentBgColorAlternate" VALIGN="TOP">
        <B><FONT COLOR="#FF0000"><%= messages.getString("short.sat") %></FONT></B></TD>
    </TR>
<%
  cal = java.util.Calendar.getInstance();
  cal.setLenient(true);
  cal.clear();
  cal.set(Integer.parseInt(year), Integer.parseInt(month), 1);
  cal.get(java.util.Calendar.DATE);
  lastDateOfMonth = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
  cal.clear();
  cal.set(Integer.parseInt(year), Integer.parseInt(month), lastDateOfMonth);
  cal.get(java.util.Calendar.DATE);
  lastDayOfMonth = cal.get(java.util.Calendar.DAY_OF_WEEK);
  
  cal.clear();
  cal.set(Integer.parseInt(year), Integer.parseInt(month), 1);
  cal.get(java.util.Calendar.DATE);

  realUserID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
  if (TvoContextManager.getSessionAttribute(request, "Calendar.viewUserID") == null)
  {    
    vAppointments = (Vector)beanCalendar.getAppointmentsMonth(userID,realUserID,String.valueOf(lastDateOfMonth),month,year);
    vEvents = (Vector)beanCalendar.getEventsMonth(userID,realUserID,String.valueOf(lastDateOfMonth),month,year);
    vToDo = (Vector)beanCalendar.getToDoMonth(userID,realUserID,String.valueOf(lastDateOfMonth),month,year);
  }
  else
  {
    vAppointments = (Vector)beanCalendar.getAppointmentsMonth((String)TvoContextManager.getSessionAttribute(request, "Calendar.viewUserID"),realUserID,String.valueOf(lastDateOfMonth),month,year);
    vEvents = (Vector)beanCalendar.getEventsMonth((String)TvoContextManager.getSessionAttribute(request, "Calendar.viewUserID"),realUserID,String.valueOf(lastDateOfMonth),month,year);
    vToDo = (Vector)beanCalendar.getToDoMonth((String)TvoContextManager.getSessionAttribute(request, "Calendar.viewUserID"),realUserID,String.valueOf(lastDateOfMonth),month,year);
  }
  for (i=1; Integer.parseInt(month) == cal.get(java.util.Calendar.MONTH) && 
            Integer.parseInt(year) == cal.get(java.util.Calendar.YEAR) ; i++)
  {
    cal.set(Integer.parseInt(year), Integer.parseInt(month), i);
    cal.get(java.util.Calendar.DATE);
    
    if (i == 1 && cal.get(java.util.Calendar.DAY_OF_WEEK) != 1 && 
        Integer.parseInt(month) == cal.get(java.util.Calendar.MONTH) && 
        Integer.parseInt(year) == cal.get(java.util.Calendar.YEAR))
    {
      %><TR BGCOLOR="#EFEFEF"><%
      for (j=1; j < cal.get(java.util.Calendar.DAY_OF_WEEK); j++)
      {
        %><TD VALIGN="TOP" CLASS="contentBgColorAlternate" BGCOLOR="#DBDBDB">&nbsp;</TD><%
      }
      %>
      <TD VALIGN="TOP" CLASS="contentBgColorAlternate">
      <%
      if (Integer.parseInt(date) == cal.get(java.util.Calendar.DATE))
      {
        %><B CLASS="textFont"><%
      }
      %><%= i %><%
      if (Integer.parseInt(date) == cal.get(java.util.Calendar.DATE))
      {
        %></B><%
      }
      %></TD><%
    }
    else if (Integer.parseInt(month) == cal.get(java.util.Calendar.MONTH) && 
             Integer.parseInt(year) == cal.get(java.util.Calendar.YEAR) )
    {
      if (cal.get(java.util.Calendar.DAY_OF_WEEK) == 1 && 
          Integer.parseInt(month) == cal.get(java.util.Calendar.MONTH) && 
          Integer.parseInt(year) == cal.get(java.util.Calendar.YEAR) )
      {
      %><TR BGCOLOR="#EFEFEF"><%
      }
      %>
      <TD VALIGN="TOP" CLASS="contentBgColorAlternate">
      <%
      if (Integer.parseInt(date) == cal.get(java.util.Calendar.DATE))
      {
        %><B CLASS="textFont"><%
      }
      %><%= i %><%
      if (Integer.parseInt(date) == cal.get(java.util.Calendar.DATE))
      {
        %></B><%
      }
      %></TD><%
    }
    if (cal.get(java.util.Calendar.DAY_OF_WEEK) == 7 && 
        Integer.parseInt(month) == cal.get(java.util.Calendar.MONTH) && 
        Integer.parseInt(year) == cal.get(java.util.Calendar.YEAR) )
    {
      %>
      </TR>
      <%
    }
    else if ( cal.get(java.util.Calendar.DATE) == 
              cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH) )
    {
      for (j = cal.get(java.util.Calendar.DAY_OF_WEEK)+1; j < 8; j++)
      {
        %><TD VALIGN="TOP" CLASS="contentBgColorAlternate" BGCOLOR="#DBDBDB">&nbsp;</TD><%
      }
      %>
      </TR>
      <%
    }
    if (cal.get(java.util.Calendar.DAY_OF_WEEK) == 7 && 
        Integer.parseInt(month) == cal.get(java.util.Calendar.MONTH) && 
        Integer.parseInt(year) == cal.get(java.util.Calendar.YEAR))
    {
    %>
      <TR BGCOLOR="#DBDBDB" ALIGN="CENTER">
      <%
      for (k=6; k >= 0 ; k--)
      {
        if (k == 6 || k == 0)
        {
        %>        
        <TD BGCOLOR="#DBDBDB" CLASS="contentBgColorAlternate" VALIGN="TOP" align="left"><div id="tablecell" style="height:80;min-width:90;overflow-y:auto;">
        <%
        }
        else
        {
        %>
        <TD BGCOLOR="#DBDBDB" CLASS="contentBgColor" VALIGN="TOP" align="left"><div id="tablecell" style="height:80;min-width:90;overflow-y:auto;">
        <%
        }
        if ( i - k > 0 )
        {
          currentDate = String.valueOf(i-k);
          if (Integer.parseInt(currentDate) < 10)
            currentDate = "0" + String.valueOf(Integer.parseInt(currentDate));

          pos = new ParsePosition(0);
          sdfDate = new SimpleDateFormat("d MMM yyyy");
          dateNow = sdfDate.parse(currentDate+" "+monthNames[Integer.parseInt(month)]+" "+year ,pos);
          sdfDate = new SimpleDateFormat("yyyy-MM-dd");

          apptCount = 0;
		  apptDesc = "";
          if (vAppointments != null && vAppointments.size() > 0)
          {            
            vStartDate = (Vector)vAppointments.get(0);
            vEndDate = (Vector)vAppointments.get(1);
            vDesc = (Vector)vAppointments.get(2);
            vStartTime = (Vector)vAppointments.get(3);

            if (vStartDate != null) {
              for (j=0; j < vStartDate.size(); j++) {
                pos = new ParsePosition(0);
                dateStart = sdfDate.parse((String)vStartDate.get(j),pos);
                pos = new ParsePosition(0);
                dateEnd = sdfDate.parse((String)vEndDate.get(j),pos);
                if ( dateNow.equals(dateStart) || dateNow.equals(dateEnd) )
                {
                  apptCount++;
				  apptDesc += "<b>" + (String)vStartTime.get(j) + "</b>: " + (String)vDesc.get(j) + "<br>";
                }
                if ( dateNow.after(dateStart) && dateNow.before(dateEnd) )
                {
                  apptCount++;
				  apptDesc += "<b>" + (String)vStartTime.get(j) + "</b>: " + (String)vDesc.get(j) + "<br>";
                }
              }
            }
          }
                    
          todoCount=0;
		  todoDesc = "";
          if (vToDo != null && vToDo.size() > 0)
          {
            vStartDate = (Vector)vToDo.get(0);
            vDesc = (Vector)vToDo.get(1);
            if (vStartDate != null)
            {
              for(j=0; j < vStartDate.size(); j++)
              {
                pos = new ParsePosition(0);
                sdfDate = new SimpleDateFormat("yyyy-MM-dd");
                dateStart = sdfDate.parse((String)vStartDate.get(j),pos);
                if (dateNow.equals(dateStart) ) {
					todoCount++;
					todoDesc += (String)vDesc.get(j) + "<br>";
				}
              }
            }
          }
                    

			eventCount = beanCalendar.getEventCount((String)TvoContextManager.getSessionAttribute(request, "Calendar.viewUserID"),
					realUserID, currentDate, month, year);

                    
          if (apptCount > 0 || todoCount > 0 || eventCount > 0)
          {
          %>
		  <a href="calendar.jsp?action=viewDay&date=<%= currentDate %>&month=<%= month %>&year=<%= year %>" onMouseOver="window.status='<%= messages.getString("view") %>';return true;">
			  <FONT COLOR="#0000FF"><%= apptDesc %></FONT>
			  <FONT COLOR="#000000"><%= todoDesc %></FONT>
		  </a>
          <!--<FONT COLOR="#33CC00"><%= eventCount %></FONT><BR>-->
          <A HREF="calendar.jsp?action=viewDay&date=<%= currentDate %>&month=<%= month %>&year=<%= year %>" onMouseOver="window.status='<%= messages.getString("view") %>';return true;"><IMG SRC="images/system/next.gif" WIDTH="14" HEIGHT="14" ALT="<%= messages.getString("calendar.viewmonth.click.scheduler") %>" BORDER="0"></A>            
          <%
          }
          else
          {
          %>
		  <!--
          <A HREF="javascript:MM_openBrWindow('calendar.jsp?action=addAppt&date=<%= currentDate %>&month=<%= month %>&year=<%= year %>','calendarAdd','scrollbars=yes,resizable=yes,width=480,height=420');" onMouseOver="window.status='<%= messages.getString("add") %>';return true"><IMG SRC="images/system/blank.gif" WIDTH="90" HEIGHT="60" BORDER="0" ALT="<%= messages.getString("add") %>"></A>
		  -->
          <A HREF="calendar.jsp?action=addAppt&date=<%= currentDate %>&month=<%= month %>&year=<%= year %>" onMouseOver="window.status='<%= messages.getString("add") %>';return true"><IMG SRC="images/system/blank.gif" WIDTH="90" HEIGHT="60" BORDER="0" ALT="<%= messages.getString("add") %>"></A>
          <%
          }
        }
        else
        {
          %>
          <IMG SRC="images/system/blank.gif" WIDTH="90" HEIGHT="60" BORDER="0">
          <%
        }
       %>
        </div></TD>
      <%
      }
      %>
      </TR>
    <%
    }
  }
if (lastDayOfMonth != 7)
{
%>
<TR ALIGN="CENTER" BGCOLOR="#DBDBDB">
<%
}
for (k=0; k < lastDayOfMonth && lastDayOfMonth != 7; k++)
{
  if (k == 0)
  {
  %>        
  <TD BGCOLOR="#DBDBDB" CLASS="contentBgColorAlternate" VALIGN="TOP">
  <%
  }
  else
  {
  %>
  <TD BGCOLOR="#DBDBDB" CLASS="contentBgColor" VALIGN="TOP">
  <%
  }
    if ( lastDateOfMonth - lastDayOfMonth + k + 1 > 0 )
    {
      currentDate = String.valueOf(lastDateOfMonth - lastDayOfMonth + k + 1);
      
      pos = new ParsePosition(0);
      sdfDate = new SimpleDateFormat("d MMM yyyy");
      dateNow = sdfDate.parse(currentDate+" "+monthNames[Integer.parseInt(month)]+" "+year ,pos);
      sdfDate = new SimpleDateFormat("yyyy-MM-dd");

      apptCount = 0;
      if (vAppointments != null && vAppointments.size() > 0)
      {            
        vStartDate = (Vector)vAppointments.get(0);
        vEndDate = (Vector)vAppointments.get(1);
        if (vStartDate != null)
        {
          for (j=0; j < vStartDate.size(); j++)
          {
            pos = new ParsePosition(0);
            dateStart = sdfDate.parse((String)vStartDate.get(j),pos);
            pos = new ParsePosition(0);
            dateEnd = sdfDate.parse((String)vEndDate.get(j),pos);
            if ( dateNow.equals(dateStart) || dateNow.equals(dateEnd) )
            {
              apptCount++;
            }
            if ( dateNow.after(dateStart) && dateNow.before(dateEnd) )
            {
              apptCount++;
            }
          }
        }
      }
            
      todoCount=0;
      if (vToDo != null && vToDo.size() > 0)
      {
        vStartDate = (Vector)vToDo.get(0);
        if (vStartDate != null)
        {
          for(j=0; j < vStartDate.size(); j++)
          {
            pos = new ParsePosition(0);
            sdfDate = new SimpleDateFormat("yyyy-MM-dd");
            dateStart = sdfDate.parse((String)vStartDate.get(j),pos);
            if (dateNow.equals(dateStart) )
              todoCount++;
          }
        }
      }

			eventCount = beanCalendar.getEventCount((String)TvoContextManager.getSessionAttribute(request, "Calendar.viewUserID"),
					realUserID, currentDate, month, year);
                    
      if (apptCount > 0 || todoCount > 0 || eventCount > 0)
      {
      %>
      <FONT COLOR="#FF0031"><%= apptCount %></FONT><BR>
      <FONT COLOR="#3130FF"><%= todoCount %></FONT><BR>
      <!--<FONT COLOR="#33CC00"><%= eventCount %></FONT><BR>-->
      <A HREF="calendar.jsp?action=viewDay&date=<%= currentDate %>&month=<%= month %>&year=<%= year %>" onMouseOver="window.status='<%= messages.getString("calendar.viewmonth.click.scheduler") %>';return true;"><IMG SRC="images/system/next.gif" WIDTH="14" HEIGHT="14" ALT="<%= messages.getString("calendar.viewmonth.click.scheduler") %>" BORDER="0"></A>            
      <%
      }
      else
      {
      %>
      <A HREF="javascript:MM_openBrWindow('calendar.jsp?action=addAppt&date=<%= currentDate %>&month=<%= month %>&year=<%= year %>','calendarAdd','scrollbars=yes,resizable=yes,width=480,height=420');" onMouseOver="window.status='<%= messages.getString("add") %>';return true;"><IMG SRC="images/system/blank.gif" WIDTH="30" HEIGHT="60" BORDER="0" ALT="<%= messages.getString("add") %>"></A>
      <%
      }
    }
    else
    {
    %>
    <IMG SRC="images/system/blank.gif" WIDTH="30" HEIGHT="60" BORDER="0">
    <%
    }
   %>
  </TD>
<%
}
if (lastDayOfMonth != 6)
{
  for (k=lastDayOfMonth+1; k < 8; k++)
  {
    if (k == 7)
    {
    %>        
    <TD BGCOLOR="#DBDBDB" CLASS="contentBgColorAlternate" VALIGN="TOP">
    <%
    }
    else
    {
    %>
    <TD BGCOLOR="#DBDBDB" CLASS="contentBgColor" VALIGN="TOP">
    <%
    }
    %>
    <IMG SRC="images/system/blank.gif" WIDTH="30" HEIGHT="60" BORDER="0">
    </TD>
  <%
  }
}
else
{
    %>
    <TD BGCOLOR="#DBDBDB" CLASS="contentBgColorAlternate" VALIGN="TOP">&nbsp;</TD>
    <%
}
if (lastDayOfMonth != 7)
{
%>
 </TR>
<%
}
%>
    <TR BGCOLOR="#EFEFEF">
		<TD align="left" VALIGN="TOP" CLASS="contentBgColor" COLSPAN="7">
			<table class="contentBgColor">
				<tr>
					<td><b>Legend : </b></td>
					<td width="10px" style="background-color: blue;">&nbsp;</td>
					<td><%= messages.getString("calendar.addappt.appointment") %></td>
					<td width="10px" style="background-color: black;">&nbsp;</td>
					<td><%= messages.getString("calendar.viewday.todo.list") %></td>
				</tr>
			</table>
			<!-- <IMG SRC="images/system/blank.gif" WIDTH="8" HEIGHT="1"><FONT COLOR="#FF0000">&#149;</FONT> <%= messages.getString("calendar.addappt.appointment") %> <FONT COLOR="#3130FF">&#149;</FONT> <%= messages.getString("calendar.viewday.todo.list") %>  -->
			<!-- <FONT COLOR="#31CF00">&#149;</FONT> <%= messages.getString("calendar.viewday.events") %>-->
		</TD>
    </TR>
<%
}
else
{
%>
    <TR VALIGN="MIDDLE">
      <TD BGCOLOR="#EFEFEF" CLASS="contentBgColor" COLSPAN="7">
        <BLOCKQUOTE>
        <FONT COLOR="#FF0000">ERROR: Invalid Date<BR>
        date=<%= date %>, month=<%= month %>, year=<%= year %><BR><BR>
        <%= messages.getString("calendar.date.error") %>
        </FONT>
        </BLOCKQUOTE>
      </TD>
    </TR>
<%
}
%>
