<% response.setContentType("text/html;charSet="+TvoContextManager.getAttribute(request,"System.charset")); %> 
<%@ include file="/includes/import.jsp" %>
<%@ page buffer="1024kb" autoFlush="true" import="java.util.Vector" %>
<%@ include file="/includes/no-cache.jsp" %>
<%@ include file="/includes/loginCheck.jsp" %>
<jsp:useBean id="beanIMDirectory" scope="request" class="common.Directory" />
<%  beanIMDirectory.initTVO(request); 
	  Messages messages = Messages.getMessages(request);

		boolean showIcon = false;    
		if ( ((String)TvoContextManager.getAttribute(request, "System.language")).equals("en"))		
  		showIcon = true;

%>
<HTML>
<HEAD>
<LINK REL="stylesheet" HREF="css/<%= (String)TvoContextManager.getSessionAttribute(request, "Login.CSSFile") %>">
<SCRIPT LANGUAGE="JavaScript">
<!--
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
function IMComposeMessage()
{
  if (document.IMOnlineUser.userID.selectedIndex != 0)
  {
    MM_openBrWindow('instantMessage.jsp?action=compose&userID='+ document.IMOnlineUser.userID.options[document.IMOnlineUser.userID.selectedIndex].value,'composeIMmessage','width=450,height=200,dependent=yes');
    document.IMOnlineUser.userID.selectedIndex =0;
  }
}
function IMComposeMessageOffline()
{
  if (document.IMOfflineUser.userIDOffline.selectedIndex != 0)
  {
    MM_openBrWindow('instantMessage.jsp?action=compose&userID='+ document.IMOfflineUser.userIDOffline.options[document.IMOfflineUser.userIDOffline.selectedIndex].value,'composeIMmessage','width=450,height=200,dependent=yes');
    document.IMOfflineUser.userIDOffline.selectedIndex = 0;
  }
}

//-->
</SCRIPT>
</HEAD>
<BODY BGCOLOR="#C0C0C0" LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0">
<script language="JavaScript">
  window.focus();
</script>
<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0">
  <TR>
    <TD ALIGN="LEFT" VALIGN="MIDDLE" BGCOLOR="#003399" COLSPAN="2"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
  </TR>
  <TR>
    <TD VALIGN="MIDDLE"><FONT FACE="Arial" SIZE="2" COLOR="#FFFFFF"></FONT>&nbsp;<FONT FACE="Arial" SIZE="2" COLOR="#FFFFFF"></FONT>&nbsp;<FONT FACE="Arial" SIZE="2" COLOR="#FFFFFF"></FONT></TD>
    <TD VALIGN="MIDDLE" ALIGN="RIGHT"><a href="IMUserListOnline.jsp"><%= showIcon ? "<IMG SRC=\"images/system/ic_refresh.gif\" WIDTH=\"50\" HEIGHT=\"18\" ALT=\"Click here to refresh all user status\" BORDER=\"0\">" : messages.getString("refresh") %></a></TD>
  </TR>
  <TR>
    <TD COLSPAN="2" BGCOLOR="#0066CC"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="2"></TD>
  </TR>
  <TR>
    <TD COLSPAN="2" ALIGN="CENTER" BGCOLOR="#003399"><FONT SIZE="2" FACE="Arial" COLOR="#FFFFFF"><B><%= messages.getString("personal.instant.messenger") %></B></FONT>
    </TD>
  </TR>
  <TR>
    <TD COLSPAN="2" BGCOLOR="#000037"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="3"></TD>
  </TR>
</TABLE>

<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="5">
  <TR VALIGN="TOP">
    <TD><FONT FACE="Arial" SIZE="1"><B><BR>
       <%= messages.getString("instantmessage.online.user") %></B></FONT></TD>
  </TR>
  <FORM NAME="IMOnlineUser" METHOD="post" ACTION="">        
  <TR VALIGN="TOP">
    <TD BGCOLOR="#E4E4E4">
        <SELECT NAME="userID" onChange="IMComposeMessage();">
          <OPTION VALUE=""><%= messages.getString("select") %></OPTION>
<%
boolean onlineUserFound = false;
String userID;
Vector userIDsOnline, userFullNamesOnline, usersOffline;			 

userID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
userIDsOnline = (Vector)TvoContextManager.getAttribute(request, "Login.userIDs");
usersOffline = (Vector) beanIMDirectory.showModule(userID,"Users","view");

  
userFullNamesOnline = (Vector)TvoContextManager.getAttribute(request, "Login.userFullNames");
int i, j=0;

for (i=0; i < usersOffline.size()-1; i++)
{  
 onlineUserFound = false;
 UsersDB users = (UsersDB) usersOffline.get(i);
 for (j=0; j< userIDsOnline.size();j++)
 {
 	if ( (users.getUserID()).equals((String) userIDsOnline.get(j)) )
 	{
 	 onlineUserFound = true;
 	 break; 	 	
 	} 
 }
 if (onlineUserFound)
 {
  %>
     <OPTION VALUE="<%= users.getUserID() %>"><%= CommonFunction.restrictNameLength(users.getName(),20) %></OPTION>
  <%
 }
}
%>
        </SELECT>
      </TD>
  </TR>
  </FORM>      
</TABLE>

</BODY>
</HTML>

