<%@ page import="java.util.Calendar" %>
<%
  String date=null, month=null, year=null;
  String nextDate=null, prevDate=null, nextMonth=null, prevMonth=null, nextYear=null, prevYear=null;
  boolean dateIsInvalid = false;
  int i,j,k,lastDateOfMonth=0,lastDayOfMonth=0;
  java.util.Calendar cal, cal2;
  
  //TvoContextManager.setSessionAttribute(request, "Calendar.lastView", "viewMonth");
  TvoContextManager.setSessionAttribute(request, "Calendar.lastView", "viewActivity");
  
  if (request.getParameter("date") != null)
  {
    TvoContextManager.setSessionAttribute(request, "Calendar.date", request.getParameter("date"));
    date = request.getParameter("date");
  }
  else if (TvoContextManager.getSessionAttribute(request, "Calendar.date") != null)
  {
    date = (String)TvoContextManager.getSessionAttribute(request, "Calendar.date");
  }

  if (request.getParameter("month") != null)
  {
    TvoContextManager.setSessionAttribute(request, "Calendar.month", request.getParameter("month"));
    month = request.getParameter("month");
  }
  else if (TvoContextManager.getSessionAttribute(request, "Calendar.month") != null)
  {
    month = (String)TvoContextManager.getSessionAttribute(request, "Calendar.month");
  }

  if (request.getParameter("year") != null)
  {
    TvoContextManager.setSessionAttribute(request, "Calendar.year", request.getParameter("year"));
    year = request.getParameter("year");
  }
  else if (TvoContextManager.getSessionAttribute(request, "Calendar.year") != null)
  {
    year = (String)TvoContextManager.getSessionAttribute(request, "Calendar.year");
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
    Vector vStartDate=null, vEndDate=null, vRepeatDay=null, vEvent=null;

    SimpleDateFormat sdfDate=null;
    ParsePosition pos;
    Date dateStart=null, dateEnd=null, dateNow=null, dateTemp=null, event=null;
    
    String currentDate=null;
    String realUserID=null;
    int apptCount;
		
		String month2 = monthNames[Integer.parseInt(month)];
		month2 = messages.getString("short."+month2.toLowerCase());
    
%>
    <TR VALIGN="MIDDLE" >
      <TD BGCOLOR="#003366" CLASS="contentStrapColor" COLSPAN="7" ALIGN="CENTER"><b>Calendar </b></TD>
    </TR>

    <TR BGCOLOR="#EFEFEF">
      <TD VALIGN="TOP" CLASS="contentBgColor" COLSPAN="7">
      <B><A HREF="calendar.jsp?action=view&date=<%= prevDate %>&month=<%= prevMonth %>&year=<%= prevYear %>" onMouseOver="window.status='<%= messages.getString("calendar.go.back.one.month") %>';return true;"><IMG SRC="images/system/previous.gif" BORDER="0" ALT="<%= messages.getString("calendar.go.back.one.month") %>" ALIGN="MIDDLE"></A>
      <%= messages.getString("calendar.month") %>: <FONT COLOR="#0065CE" CLASS="textFont">
      <%= month2 %></FONT> <%= year %>
      <A HREF="calendar.jsp?action=view&date=<%= nextDate %>&month=<%= nextMonth %>&year=<%= nextYear %>" onMouseOver="window.status='<%= messages.getString("calendar.go.forward.one.month") %>';return true;"><IMG SRC="images/system/next.gif" BORDER="0" ALT="<%= messages.getString("calendar.go.forward.one.month") %>" ALIGN="MIDDLE"></A>
      </B></TD>
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
 
 vAppointments = (Vector)beanCalendarEvent.getAppointmentsMonth2(String.valueOf(lastDateOfMonth),month,year);
 
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
        <TD BGCOLOR="#DBDBDB" CLASS="contentBgColorAlternate" VALIGN="TOP">
        <%
        }
        else
        {
        %>
        <TD BGCOLOR="#DBDBDB" CLASS="contentBgColor" VALIGN="TOP">
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
          if (vAppointments != null && vAppointments.size() > 0)
          {    
            vEvent = (Vector)vAppointments.get(0);
	    vStartDate = (Vector)vAppointments.get(1);
            vEndDate = (Vector)vAppointments.get(2);
            
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
                    
              
                    
          if (apptCount > 0)
          {
          %>
          <FONT COLOR="#FF0031"><%= apptCount %></FONT><BR>
          
          <A HREF="javascript:MM_openBrWindow('cms/stdActivity/calendar.jsp?action=viewDay&date=<%= currentDate %>&month=<%= month %>&year=<%= year %>','calendarAdd','scrollbars=yes,resizable=yes,width=800,height=300');" onMouseOver="window.status='<%= messages.getString("view") %>';return true"><IMG SRC="images/system/4.ico" WIDTH="14" HEIGHT="14" ALT="<%= messages.getString("calendar.viewmonth.click.scheduler") %>" BORDER="0"></A>  

          <%
          }
          else
          {
          %>
          <IMG SRC="images/system/blank.gif" WIDTH="30" HEIGHT="60" BORDER="0">
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
            vEvent = (Vector)vAppointments.get(0);
	    vStartDate = (Vector)vAppointments.get(1);
            vEndDate = (Vector)vAppointments.get(2);
            
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
            
                  
      if (apptCount > 0)
      {
      %>
      <FONT COLOR="#FF0031"><%= apptCount %></FONT><BR>

       <A HREF="javascript:MM_openBrWindow('cms/stdActivity/calendar.jsp?action=viewDay&date=<%= currentDate %>&month=<%= month %>&year=<%= year %>','calendarAdd','scrollbars=yes,resizable=yes,width=800,height=300');" onMouseOver="window.status='<%= messages.getString("view") %>';return true"><IMG SRC="images/system/4.ico" WIDTH="14" HEIGHT="14" ALT="<%= messages.getString("calendar.viewmonth.click.scheduler") %>" BORDER="0"></A>  
      <%
      }
      else
      {
      %>
      <IMG SRC="images/system/blank.gif" WIDTH="30" HEIGHT="60" BORDER="0">
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
      <TD VALIGN="TOP" CLASS="contentBgColor" COLSPAN="7">
      <IMG SRC="images/system/blank.gif" WIDTH="8" HEIGHT="1">
      <FONT COLOR="#FF0000">&#149;</FONT> 
      No of Activity(s)
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
