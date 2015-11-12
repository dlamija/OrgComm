
<style type="text/css">
	.link {
		font-family: Arial, Helvetica, sans-serif;
		font-size: 9pt;
		color:#0066FF;
	}
</style>

<script type="text/javascript" src="ajaxtags/js/prototype.js"></script>
<script type="text/javascript" src="ajaxtags/js/scriptaculous/scriptaculous.js"></script>
<script type="text/javascript" src="ajaxtags/js/overlibmws/overlibmws.js"></script>
<script type="text/javascript" src="ajaxtags/js/ajaxtags.js"></script>

<%@ page import="java.util.StringTokenizer, java.util.Vector" %>

<%
	String memoType = request.getParameter("type");


    Vector vFoldersList=null, vFoldersID=null, vFoldersName=null, vFoldersMemoCount=null,
           vFoldersUnreadCount=null;
    Vector vUserFoldersID=null, vUserFoldersName=null, vUserFoldersMemoCount=null,
           vUserFoldersUnreadCount=null;
    int i;

    int[] aListing = new int[5];
    int limit=30;
    String selected = "";

    if (TvoContextManager.getSessionAttribute(request, "Memo.listing") != null)
      limit = ((Integer)TvoContextManager.getSessionAttribute(request, "Memo.listing")).intValue();
   
    if (request.getParameter("listing") != null && !request.getParameter("listing").equals("null")) 
    {
      limit = Integer.parseInt(request.getParameter("listing"));
      TvoContextManager.setSessionAttribute(request, "Memo.listing", (new Integer(limit)));
    }

    if ( (userMemoACL.containsKey("view") && userMemoACL.get("view").equals("1") ) || 
         (groupMemoACL.containsKey("view")&& groupMemoACL.get("view").equals("1")) ) 
    {

		if (userID != null && moduleName != null && action != null)  
      	{
        	vFoldersList = beanMemo.showModule(userID, moduleName, action);
        	
        	if (vFoldersList != null)   
        	{
	          	// System folders
				vFoldersID = (Vector)vFoldersList.get(0);
				vFoldersName = (Vector)vFoldersList.get(1);
				// vFoldersMemoCount = (Vector)vFoldersList.get(2);
				//vFoldersUnreadCount = (Vector)vFoldersList.get(3);

				// User folders
				vUserFoldersID = (Vector)vFoldersList.get(2);
				vUserFoldersName = (Vector)vFoldersList.get(3);
				// vUserFoldersMemoCount = (Vector)vFoldersList.get(6);
				// vUserFoldersUnreadCount = (Vector)vFoldersList.get(7);
				
        	}// end if (vFoldersList != null)   
		}//end if (userID != null && moduleName != null && action != null)
%>
<SCRIPT LANGUAGE="JavaScript">
	function memoViewFolder() 
	{
		var index=document.folderView.folderURL.selectedIndex;
  
  		if (document.folderView.folderURL.options[index].value != '')
    		location=document.folderView.folderURL.options[index].value;
	}

	function gotopage (selSelectObject)
	{
		if(selSelectObject.options[selSelectObject.selectedIndex].value != "")
  		{
   			location.href=selSelectObject.options[selSelectObject.selectedIndex].value
  		}
	}
</script>


<style type="text/css">
<!--
.style1 {font-weight: bold}
-->
</style>




<FORM NAME="folderView">

	<table width="100%" align="center">
  	<TR VALIGN="TOP" CLASS="contentBgColorAlternate">
    	<TD CLASS="contentBgColorAlternate" style="font-family: Verdana, sans-serif; font-size: 11px;  8px; " COLSPAN="6">
      		<table border="0" cellspacing="0" cellpadding="0" width="100%">
        		<tr>
	  				<td width="68%" CLASS="contentBgColorAlternate" style="font-family: Verdana, sans-serif; font-size: 11px;  8px; ">        
	  					<!--%@include file="querymemo.jsp"% -->
						<a href="memo.jsp?action=folders&type=Y&folderID=1" class="link" onMouseOver="window.status='Official';return true;">
							<b>OFFICIAL</b>
						</a>
						&nbsp;|&nbsp;
						<a href="memo.jsp?action=folders&type=N&folderID=1" class="link" onMouseOver="window.status='Unofficial';return true;">
							<b>UNOFFICIAL</b>
						</a>
						&nbsp;|&nbsp;
						<a href="memo.jsp?action=folders&type=&folderID=1" class="link" onMouseOver="window.status='Others';return true;">
							<b>REMINDER: APPOINTMENT &amp; OTHERS</b>
						</a>
						<!-- 
						&nbsp;|&nbsp;
						<a href="memo.jsp?action=folders&type=A&folderID=1" class="link" onMouseOver="window.status='Appointment';return true;">
							<b>REMINDER: APPOINTMENT</b>
						</a>
						&nbsp;|&nbsp;
						<a href="memo.jsp?action=folders&type=&folderID=1" class="link" onMouseOver="window.status='Others';return true;">
							<b>OTHERS</b>
						</a>
						 -->
					</td>
          			<td width="32%" align="right"  CLASS="contentBgColorAlternate" style="font-family: Verdana, sans-serif; font-size: 11px;  8px; ">
          		<% if (request.getParameter("memoID") == null)	    {  %>
 	  
            			<b><%= messages.getString("listing") %></b>&nbsp;
	    				<Select Name="listing" onChange="javascript:document.folderView.submit();"  style="font-family: Verdana, sans-serif; font-size: 11px;  8px; ">
<%

				       	aListing[0] = 30;
				    	aListing[1] = 50;
						aListing[2] = 80;
				    	aListing[3] = 100;
						aListing[4] = 150;

				    	for (i=0;i<aListing.length;i++)	     
    					{
							selected="";
	  						if (limit == aListing[i])		
								selected=" SELECTED";
%>
              				<option value="<%= aListing[i] %>"<%= selected %>><%= aListing[i] %>  </option>
<%						}//end for (i=0;i<aListing.length;i++)	  %>
            			</select>
<%    				}//end if (request.getParameter("memoID") == null)  %>	 
	  	  
            <SELECT NAME="folderURL" onchange = "gotopage(this);"  style="font-family: Verdana, sans-serif; font-size: 11px;  8px; ">
              <OPTION VALUE=""><%=messages.getString("email.select.folder2")%></OPTION>
<%
      		if (vFoldersID != null && vFoldersName != null)  
      		{
        		for (i=0; i<vFoldersID.size(); i++)    
        		{
%>
              		<OPTION VALUE="memo.jsp?action=folders&type=<%=request.getParameter("type")%>&folderID=<%= vFoldersID.get(i) %>">
			  			<%= messages.getString(((String)vFoldersName.get(i)).toLowerCase()) %>
			   			<% if (request.getParameter("type").equals("Y")){%>
                      		Memo
                      	<%}else{%>
                      		Reminder: Appointment &amp; Others
                    	<%}%> 
             		</OPTION>      
<%
        		}//end for (i=0; i<vFoldersID.size(); i++ %>
        		<option value="memo.jsp?action=folders&type=<%=request.getParameter("type")%>&folderID=0">Memo Archive</option>
<%      		}//end if (vFoldersID != null && vFoldersName != null)  
      			

			  if (vUserFoldersID != null && vUserFoldersName != null)
			  {
			      if (vUserFoldersID.size() > 0) {
%>
			     <OPTION VALUE="">-------------------------</OPTION>
<%
			      }// if (vUserFoldersID.size() > 0) 
			      for (i=0; i<vUserFoldersID.size(); i++)
			      {
%>
			      <OPTION VALUE="memo.jsp?action=folders&type=<%=request.getParameter("type")%>&folderID=<%= vUserFoldersID.get(i) %>"><%= vUserFoldersName.get(i) %> 
<%
			      }//end for (i=0; i<vUserFoldersID.size(); i++)
			  }//end if (vUserFoldersID != null && vUserFoldersName != null)
%>
  			</SELECT>
  
			<input type="hidden" name="action" value="<%= action %>">
			<input type="hidden" name="folderID" value="<%= request.getParameter("folderID") %>">  
			<input type="hidden" name="type" value="<%= request.getParameter("type") %>">  

  			</td>
  		</tr>
  	</table>
  </TD>
</TR>
</table>

<% if (request.getParameter("order") != null ) {  %>		 
		 <input type="hidden" name="order" value="<%= request.getParameter("order") %>">
		 <input type="hidden" name="sort" value="<%= request.getParameter("sort") %>">
		  <input type="hidden" name="type" value="<%= request.getParameter("type") %>">  
<% } %>		 

</FORM>
<%
  if (request.getParameter("memoID") != null)
  {
    %><%@ include file="/includes/memoViewMemo.jsp" %><%
  }
  else
  {
    %><%@ include file="/includes/memoViewFolder.jsp" %><%
  }//end if (request.getParameter("memoID") != null)
}
else {
%>
  <tr>
    <TD BGCOLOR="#EBEBEB" CLASS="contentBgColor" COLSPAN="5" ALIGN="LEFT" VALIGN="MIDDLE">
      <%= messages.getString("memo.user.no.access") %>
    </TD>
  </tr>
<%
}
%>