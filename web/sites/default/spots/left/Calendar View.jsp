<%@ page import="common.*" %>
<%@ page import = "ecomm.bean.*" %>
<%@ page import="java.util.Hashtable,java.util.Locale" %>

  <jsp:useBean id="beanCalendarACL" scope="request" class="ecomm.bean.ACL" />
  <jsp:useBean id="beanTams" scope="request" class="ecomm.bean.TamsTams" />
    <%
      //String action = request.getParameter("action");
      String userID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
      Hashtable userCalendarACL, groupCalendarACL;
      
      String moduleName = "Calendar";

      beanCalendarACL.initTVO(request);
      beanTams.initTVO(request);

      userCalendarACL = beanCalendarACL.getRights(userID, moduleName, "User");
      groupCalendarACL = beanCalendarACL.getRights(userID, moduleName, "Group");

      if ( (userCalendarACL.containsKey("view") && userCalendarACL.get("view").equals("1") ) ||
      (groupCalendarACL.containsKey("view") &&  groupCalendarACL.get("view").equals("1")) )
      {
      %>


<%
  Messages messages = Messages.getMessages(request);
	boolean showIcon = false;
  if ( ((String)TvoContextManager.getAttribute(request, "System.language")).equals("en"))
    showIcon = true;

  String uid="", name="";
  javax.servlet.http.Cookie[] cookieArray=null;
  int indexA=0;
  boolean loadCalendarMonth = true, foundCookie=false;

/*  uid = (String) TvoContextManager.getSessionAttribute(request, "Login.userID");
  name = uid + "leftcalendarmonth";
  cookieArray = request.getCookies();

  loadCalendarMonth = true;
  foundCookie=false;
  for (indexA = 0; cookieArray != null && indexA < cookieArray.length; indexA++) {
    if ( ((String)cookieArray[indexA].getName()).equals(name) ) {
      foundCookie=true;
      if ( ((String)cookieArray[indexA].getValue()).equals("none") )
        loadCalendarMonth = true;
      break;
    }
  }*/
%>      <!-- Current Month Calendar Box START -->
      <TABLE BGCOLOR="white" BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
        <TR BGCOLOR="#666666" ALIGN="CENTER">
          <TD VALIGN="MIDDLE" COLSPAN="7" CLASS="calendarMonthBgColor"><IMG SRC="images/system/blank.gif" WIDTH="155" HEIGHT="2"></TD>
        </TR>
        <TR BGCOLOR="#CCCCCC" ALIGN="CENTER">
          <TD VALIGN="MIDDLE" COLSPAN="7" BGCOLOR="#666666" CLASS="calendarMonthBgColor">
          <B><img src="images/hyperlink/calendar2.png"  /><a href="" onclick="toggleBlock('leftcalendarmonth'); return false;"><FONT COLOR="#FFFFFF" CLASS="calendarMonthFont">
<SCRIPT LANGUAGE="JavaScript">
var monthNames = new Array("<%= messages.getString("january") %>","<%= messages.getString("february") %>","<%= messages.getString("march") %>","<%= messages.getString("april") %>","<%= messages.getString("may") %>","<%= messages.getString("june") %>","<%= messages.getString("july") %>","<%= messages.getString("august") %>","<%= messages.getString("september") %>","<%= messages.getString("october") %>","<%= messages.getString("november") %>","<%= messages.getString("december") %>");
var monthBoxSmallDateObj = new Date();
var monthBoxSmallMonth = <%= request.getParameter("month") != null ? request.getParameter("month") : "null" %>;
if (monthBoxSmallMonth == null)
  monthBoxSmallMonth = <%= TvoContextManager.getSessionAttribute(request, "Calendar.month") != null ? TvoContextManager.getSessionAttribute(request, "Calendar.month") : "null" %>;
if (monthBoxSmallMonth == null)
  monthBoxSmallMonth = monthBoxSmallDateObj.getMonth();
document.write(monthNames[monthBoxSmallMonth]);
</SCRIPT>
            </FONT></a></B>          </TD>
        </TR>
      </TABLE>
      <DIV id="leftcalendarmonth">
<% if (loadCalendarMonth) { %>
<TABLE BGCOLOR="white" BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">
        <TR ALIGN="CENTER" BGCOLOR="#EFEFEF">
          <TD COLSPAN=7 HEIGHT=20 CLASS="calendarBgColor">
              <SPAN CLASS="calendarContentFont">
<SCRIPT LANGUAGE="JavaScript">
var monthBoxSmallDateObj = new Date();
var monthBoxSmallYear = <%= request.getParameter("year") != null ? request.getParameter("year") : "null"  %>;
if (monthBoxSmallYear == null)
  monthBoxSmallYear = <%= TvoContextManager.getSessionAttribute(request, "Calendar.year") != null ? TvoContextManager.getSessionAttribute(request, "Calendar.year") : "null"  %>;
if (monthBoxSmallYear == null)
  monthBoxSmallYear = monthBoxSmallDateObj.getFullYear();
document.write(monthBoxSmallYear);
</SCRIPT>
              </SPAN>
   		  </TD>
        </TR>
        <TR BGCOLOR="#EFEFEF" CLASS="calendarBgColor">
          <TD ALIGN=middle CLASS="calendarContentFont" ><B><%= messages.getString("sunday") %></B></TD>
          <TD ALIGN=middle CLASS="calendarContentFont" ><B><%= messages.getString("monday") %></B></TD>
          <TD ALIGN=middle CLASS="calendarContentFont" ><B><%= messages.getString("tuesday") %></B></TD>
          <TD ALIGN=middle CLASS="calendarContentFont" ><B><%= messages.getString("wednesday") %></B></TD>
          <TD ALIGN=middle CLASS="calendarContentFont" ><B><%= messages.getString("thursday") %></B></TD>
          <TD ALIGN=middle CLASS="calendarContentFont" ><B><%= messages.getString("friday") %></B></TD>
          <TD ALIGN=middle CLASS="calendarContentFont" ><B><%= messages.getString("saturday") %></B></TD>
        </TR>
<SCRIPT LANGUAGE="JavaScript">
  var monthNames;
  var monthBoxSmallDateObj = new Date();
  var monthBoxSmallDay;
  var monthBoxSmallDate, monthBoxSmallMonth, monthBoxSmallYear;
  var date, day, today, selectedDate;
  
  today =  monthBoxSmallDateObj.getDate();
  monthBoxSmallDateObj.setDate(1);
  selectedDate = <%= request.getParameter("date") %>;
  if (selectedDate == null)
    selectedDate = <%= TvoContextManager.getSessionAttribute(request, "Calendar.date") != null ? TvoContextManager.getSessionAttribute(request, "Calendar.date") : "null" %>;
  if (selectedDate == null)
    selectedDate = today;
  monthBoxSmallMonth = <%= request.getParameter("month") != null ? request.getParameter("month") : "null"  %>;
  if (monthBoxSmallMonth == null)
    monthBoxSmallMonth = <%= TvoContextManager.getSessionAttribute(request, "Calendar.month") != null ? TvoContextManager.getSessionAttribute(request, "Calendar.month") : "null"  %>;
  if (monthBoxSmallMonth == null)
    monthBoxSmallMonth = monthBoxSmallDateObj.getMonth();
  // else
  monthBoxSmallDateObj.setMonth(monthBoxSmallMonth);
  monthBoxSmallYear = <%= request.getParameter("year") != null ? request.getParameter("year") : "null"  %>;
  if (monthBoxSmallYear == null)
    monthBoxSmallYear = <%= TvoContextManager.getSessionAttribute(request, "Calendar.year") != null ? TvoContextManager.getSessionAttribute(request, "Calendar.year") : "null"  %>;
  if (monthBoxSmallYear == null)
    monthBoxSmallYear = monthBoxSmallDateObj.getFullYear();
  // else
  monthBoxSmallDateObj.setFullYear(monthBoxSmallYear);
  for (date=1; monthBoxSmallMonth == monthBoxSmallDateObj.getMonth() && monthBoxSmallYear == monthBoxSmallDateObj.getFullYear(); date++)
  {
    monthBoxSmallDateObj.setDate(date);
    monthBoxSmallDay = monthBoxSmallDateObj.getDay();
    monthBoxSmallDate = monthBoxSmallDateObj.getDate();
    if (date == 1 && monthBoxSmallDay != 0 && monthBoxSmallMonth == monthBoxSmallDateObj.getMonth()&& monthBoxSmallYear == monthBoxSmallDateObj.getFullYear())
    {
      document.writeln("<TR BGCOLOR=\"#EFEFEF\" CLASS=\"calendarBgColor\">");
      for (day=0; day < monthBoxSmallDay; day ++)
      {
        document.writeln("<TD ALIGN=middle CLASS=\"calendarContentFont\">&nbsp;</TD>");
      }
      document.write("<TD ALIGN=middle CLASS=\"calendarContentFont\"><A HREF=\"calendar.jsp?action=viewDay&date="+monthBoxSmallDate+"&month="+monthBoxSmallMonth+"&year="+monthBoxSmallYear+"\" onMouseOver=\"window.status=\'<%= messages.getString("view") %>\';return true;\">");
      if (selectedDate == date)
        document.write("<FONT COLOR=\"#FF0000\" CLASS=\"highlight\">");
      document.write(monthBoxSmallDate);
      if (selectedDate == date)
        document.write("</FONT>");
      document.writeln("</A>&nbsp;</TD>");
    }
    else if (monthBoxSmallMonth == monthBoxSmallDateObj.getMonth() && monthBoxSmallYear == monthBoxSmallDateObj.getFullYear())
    {
      if (monthBoxSmallDay == 0 && monthBoxSmallMonth == monthBoxSmallDateObj.getMonth()&& monthBoxSmallYear == monthBoxSmallDateObj.getFullYear())
      {
        document.writeln("<TR BGCOLOR=\"#EFEFEF\" CLASS=\"calendarBgColor\">");
      }
      document.write("<TD ALIGN=middle CLASS=\"calendarContentFont\"><A HREF=\"calendar.jsp?action=viewDay&date="+monthBoxSmallDate+"&month="+monthBoxSmallMonth+"&year="+monthBoxSmallYear+"\" onMouseOver=\"window.status=\'<%= messages.getString("view") %>\';return true;\">");
      if (selectedDate == date)
        document.write("<FONT COLOR=\"#FF0000\" CLASS=\"highlight\">");
      document.write(monthBoxSmallDate);
      if (selectedDate == date)
        document.write("</FONT>");
      document.writeln("</A>&nbsp;</TD>");
    }
    if (monthBoxSmallDay == 6 && monthBoxSmallMonth == monthBoxSmallDateObj.getMonth() && monthBoxSmallYear == monthBoxSmallDateObj.getFullYear())
      document.write("</TR>");
    else if (monthBoxSmallMonth != monthBoxSmallDateObj.getMonth() || monthBoxSmallYear != monthBoxSmallDateObj.getFullYear())
    {
      if (monthBoxSmallDay != 0)
      {
        for (day=monthBoxSmallDay; day < 7; day ++)
        {
          document.writeln("<TD ALIGN=middle CLASS=\"calendarContentFont\">&nbsp;</TD>");
        }
        document.write("</TR>");
      }
    }
  }  
</SCRIPT>
        <TR BGCOLOR="#EFEFEF" CLASS="calendarBgColor">
          <TD COLSPAN=7><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="8"></TD>
        </TR>
        <TR BGCOLOR="#EFEFEF" CLASS="calendarBgColor" ALIGN="CENTER">
          <FORM NAME="monthGo" ACTION="calendar.jsp" METHOD="POST">
          <TD COLSPAN=7 VALIGN=center>
          <INPUT TYPE="HIDDEN" NAME="date" VALUE="1">
            <SELECT NAME="month">
              <OPTION VALUE="0"><%= messages.getString("short.jan") %></OPTION>
              <OPTION VALUE="1"><%= messages.getString("short.feb") %></OPTION>
              <OPTION VALUE="2"><%= messages.getString("short.mar") %></OPTION>
              <OPTION VALUE="3"><%= messages.getString("short.apr") %></OPTION>
              <OPTION VALUE="4"><%= messages.getString("short.may") %></OPTION>
              <OPTION VALUE="5"><%= messages.getString("short.jun") %></OPTION>
              <OPTION VALUE="6"><%= messages.getString("short.jul") %></OPTION>
              <OPTION VALUE="7"><%= messages.getString("short.aug") %></OPTION>
              <OPTION VALUE="8"><%= messages.getString("short.sep") %></OPTION>
              <OPTION VALUE="9"><%= messages.getString("short.oct") %></OPTION>
              <OPTION VALUE="10"><%= messages.getString("short.nov") %></OPTION>
              <OPTION VALUE="11"><%= messages.getString("short.dec") %></OPTION>
            </SELECT>
            <SELECT NAME="year">
            <%
            for (int j=Integer.parseInt((String)TvoContextManager.getAttribute(request, "System.startYear"));
                 j <= Integer.parseInt((String)TvoContextManager.getAttribute(request, "System.endYear"));
                 j++)
            {
              %><OPTION VALUE="<%= j %>"><%= j %></OPTION><%
            }
            %>
            </SELECT>
						<% if (showIcon) { %>
              <INPUT 
            ALIGN=absMiddle ALT="Go to the date selected" BORDER=0 cache
            HEIGHT=18 SRC="images/system/ic_go.gif" TYPE=image VALUE=go WIDTH=25 
            TARGET="content">
					 <%	} else { %>
					    <a href = "javascript:document.monthGo.submit()" onMouseOver="window.status='<%= messages.getString("go") %>';return true;"><%= messages.getString("go") %></a>
					 <%   } 	%>
		    </TD>
          </FORM>
<SCRIPT LANGUAGE="JavaScript">
var monthObj = new Date();
var date = monthObj.getDate();
var month = monthObj.getMonth();
var year = monthObj.getFullYear();
var i;
document.monthGo.date.value = date;
document.monthGo.month.options[month].selected = true;
for (i=0; i < document.monthGo.year.length; i++)
{
  if (document.monthGo.year.options[i].text == year)
  {
    document.monthGo.year.options[i].selected = true;
    break;
  }
}

loadBox("leftcalendarmonth");
</SCRIPT>
        </TR>
        <TR BGCOLOR="#EFEFEF" CLASS="calendarBgColor">
          <TD ALIGN=middle COLSPAN=7 VALIGN=center><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="5"></TD>
        </TR>
      </TABLE>
      </DIV>
      <% } %>

      <%
      }
      %>

      <!-- Current Month Calendar Box END -->
