<%@ page import="common.*,ecomm.bean.*, java.util.*" %>

<%@ include file="/includes/checkPermission.jsp" %>
<jsp:useBean id="beanPersonal" scope="request" class="ecomm.bean.PersonalPersonal" />

<%
	beanPersonal.initTVO(request);
	String uri = request.getRequestURL().toString();

	CommonObject statusSetting = beanPersonal.getStatus(request, userID);
	
	int appletEmail, appletPOP, appletMemo, appletUser, appletMsg,
		refreshEmail, refreshPOP, refreshMemo, refreshUser, refreshMsg;

	appletUser = Integer.parseInt((String)statusSetting.getObj("appletUser"));
	refreshUser  = Integer.parseInt((String)statusSetting.getObj("refreshUser"));
%>
	<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="1">
  		<TR ALIGN="CENTER">
     		<TD CLASS="sideTitleBgBorderColor" BGCOLOR="#1059A5">
				<A href="" onclick="toggleBlock('rightstatus'); return false" onMouseOver="window.status='<%= messages.getString("status") %>';return true;">
				<FONT COLOR="#FFFFFF">User Online Status<!--%= messages.getString("status") %--></FONT>     </A>
              	<DIV id="rightstatus">
                	<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="5">
                    <FORM METHOD="post" ACTION="">
                    	<TR VALIGN="TOP"><TD BGCOLOR="#FFFFFF" class='contentBgColorAlternate'>
					  	<TABLE width="100%">
                 			<TR> 
                     			<TD align="right"> <div align="center"><B><FONT SIZE="2"><%= messages.getString("users") %>:</FONT></B>
							<% 	if (appletUser == 1) { %>
									<APPLET code="StatusApplet.class" codebase="applets" height="15" width="20">
										<param name="url" value="Status?action=usersOnline">
										<param name="refresh" value="<%= refreshUser * 1000 %>">
										<param name="default" value=" ">
                        				<!-- param name="sound" value="applets/users.au" -->
                        <%		}
                       
								Integer usersOnline;
								usersOnline = (Integer)TvoContextManager.getAttribute(request, "Login.counter");
								out.print(usersOnline.toString());
%>
                        	<% 	if (appletUser == 1) { %>
									</APPLET>
                      		<%	}
								else { %>
                     				&nbsp;&nbsp;&nbsp; 
                      		<%	} %>
                      			</FONT></div>
								</TD>
                    		</TR>
                		</TABLE>
                      	</TD></TR>
                  	</FORM>
                  	</TABLE>
             	</DIV>
    		</TD>
   		</TR>
   		<TR HEIGHT="5">
     		<TD></TD>
   		</TR>
	</TABLE>