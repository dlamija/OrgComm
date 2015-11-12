<jsp:useBean id="memoSearchForm" scope="request" class="page.MemoSearchForm" />
<%
if ( (userMemoACL.containsKey("view") && userMemoACL.get("view").equals("1") ) || 
   (groupMemoACL.containsKey("view") &&  groupMemoACL.get("view").equals("1")) )
{
  int[] aListing = new int[5];
  int limit=10,i=0;
  String selected = "";

 if (request.getParameter("isSearch") != null)
 {
  if (TvoContextManager.getSessionAttribute(request, "Memo.listing") != null)
  limit = ((Integer)TvoContextManager.getSessionAttribute(request, "Memo.listing")).intValue();
   
  if (request.getParameter("listing") != null && !request.getParameter("listing").equals("null"))
  {
   limit = Integer.parseInt(request.getParameter("listing"));
   TvoContextManager.setSessionAttribute(request, "Memo.listing", (new Integer(limit)));
  }
  
  
    
%> 

  <TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  	<TD CLASS="contentBgColorAlternate" colspan="7">	
   <form name="folderView">
  	   
		 <b><%= messages.getString("listing") %></b>&nbsp;
			 <Select Name="listing" onChange="javascript:document.folderView.submit();">
<%
     aListing[0] = 10;
     aListing[1] = 20;
     aListing[2] = 30;
     aListing[3] = 50;
     aListing[4] = 100;	
     for (i=0;i<aListing.length;i++)
     {
      selected="";
	  if (limit == aListing[i])	 
	   selected=" SELECTED";
%>
      <option value="<%= aListing[i] %>"<%= selected %>><%= aListing[i] %></option>
<%
	 }
%>
     </select>
	 

   	 <input type="hidden" name="action" value="<%= action %>">
	 <input type="hidden" name="Keyword" value="<%=  request.getParameter("Keyword") %>">
	 <input type="hidden" name="searchBy" value="<%= request.getParameter("searchBy") %>">
     <% if (request.getParameter("sort") != null) { %>
         <input type="hidden" name="sort" value="<%= request.getParameter("sort") %>">
     <% } %>
     <% if (request.getParameter("order") != null) { %>
         <input type="hidden" name="order" value="<%= request.getParameter("order") %>">
     <% } %>
	 <input type="hidden" name="isSearch" value="1">	 	
   </form>
   </td>
</TR>
<%
 }
%>
<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  <TD CLASS="contentBgColorAlternate" colspan="7" ALIGN="MIDDLE">
	   <b><%= (request.getParameter("isSearch") != null) ? messages.getString("search.results") : messages.getString("search.email") %></b>
  </td>
</tr>  

<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
	<TD CLASS="contentBgColor" colspan="7">
		<form name="memoSearch" action="memo.jsp?action=search" method="post">
		<table border="0" cellspacing="0" cellpadding="0" width="100%">
			<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
         		<TD CLASS="contentBgColor">&nbsp;</td>
			</tr>
			<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
				<TD CLASS="contentBgColor" align="center">
				 <b><%= messages.getString("search.by") %></b> 
				  <select name="searchBy">
				  	<option value="0" SELECTED><%= messages.getString("search.all") %></option>
					<option value="1"><%= messages.getString("memo.from") %></option>
					<option value="2"><%= messages.getString("memo.subject") %></option>
					<option value="3"><%= messages.getString("memo.message") %></option>
					<option value="5"><%= messages.getString("memo.department") %></option>
				  </select> 
				  &nbsp;&nbsp;   
				  <b><%= messages.getString("keyword") %></b> <input type="text" name="Keyword" size="50">
				  &nbsp;
				  <A HREF="javascript:document.memoSearch.submit();" onMouseOver="window.status='<%= messages.getString("search.email") %>';return true;">
				  	<IMG SRC="images/system/ic_searchpic.gif" BORDER="0" ALT="<%= messages.getString("search.email") %>" ALIGN="ABSMIDDLE">
				  </A>
				</td>
			</tr>	
			<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
				<TD CLASS="contentBgColor" align="center">
					&nbsp;
				</td>
			</tr>	
			<tr valign="top" bgcolor="#DBDBDB">
				<td class="contentBgColor" align="center">
					<b>Month</b>&nbsp;
					<select id="paramMonth" name="paramMonth">
						<option value="">-- All ---</option>
						<option value="JAN">JAN</option>
						<option value="FEB">FEB</option>
						<option value="MAR">MAC</option>
						<option value="APR">APR</option>
						<option value="MAY">MAY</option>
						<option value="JUN">JUN</option>
						<option value="JUL">JUL</option>
						<option value="AUG">AUG</option>
						<option value="SEP">SEP</option>
						<option value="OCT">OCT</option>
						<option value="NOV">NOV</option>
						<option value="DEC">DEC</option>
					</select>
					&nbsp;&nbsp;
					<b>Year</b>&nbsp;
					<select id="paramYear" name="paramYear">
						<option value="">--- All ---</option>
						<% for(page.PageElement yr:memoSearchForm.getYearList()) {%>
						<option value="<%=yr.getItemValue()%>"><%=yr.getItemValue()%></option>
						<%} %>
					</select>
					&nbsp;&nbsp;
					<b>Category</b>&nbsp;
					<select id="type" name="type">
						<option value="ALL">--- All ---</option>
						<option value="Y">Official</option>
						<option value="N">Unofficial</option>
						<option value="A">Appointment</option>
						<option value="NULL">System Triggered</option>
					</select>
				</td>
			</tr>
			<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
         		<TD CLASS="contentBgColor" align="center">
         		&nbsp;</td>
			</tr>

		</table>

			<input type="hidden" name="isSearch" value="1">	
<!-- 
			<input type="hidden" name="type" value="<%=request.getParameter("type")%>">	
-->	 
		 </form>

	</td>


</tr>	

<%
   if (request.getParameter("isSearch") != null)
   {
		Vector vFoldersID = new Vector();
		Vector vFoldersName = new Vector();
		Vector vUserFoldersID = new Vector();
		Vector vUserFoldersName = new Vector();	
	   
	      
	    Vector vFoldersList = beanMemo.showModule(userID, moduleName, "folders");
	    if (vFoldersList != null)
	    {
	      vFoldersID = (Vector)vFoldersList.get(0);
	      vFoldersName = (Vector)vFoldersList.get(1);
	    }

        %><%@ include file="/includes/memoViewFolder.jsp" %><%
   }
}
else
{
%>
  <tr>
    <TD BGCOLOR="#EBEBEB" CLASS="contentBgColor" colspan="6" ALIGN="LEFT" VALIGN="MIDDLE">
      <%= messages.getString("memo.user.no.access") %>
    </TD>
  </tr>

<%
}
%>