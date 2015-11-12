<%@ page import="java.net.URLEncoder,java.sql.*" %>
<%@ taglib uri="http://ajaxtags.sourceforge.net/tags/ajaxtags" prefix="ajax"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:useBean id="tempMemo" scope="request" class="ecomm.bean.MemoDB"/>
<jsp:useBean id="memoFormBean" scope="request" class="ecomm.bean.MemoForm" />
<jsp:useBean id="staffStudent2" scope="request" class="common.StaffStudent"/>



<%
	Vector vFolderContents=null;
	
	String viewFolderName = "", memoDatePosted=null;
	String folderID,toName = "",isMemoRead = "";
	String currentSortOrder = "desc", sortOrder="desc";
	String sortBy="memoDate";
	String fontColor = "";

	int start=1;
	int memoCount=0, memoCountUnread=0, pageNo=1,pageSum=0;
	String FolderID="1";
	int memoFolderID = 1;
	Object markRead[] = new Object[1];
					
if ( (userMemoACL.containsKey("view") && userMemoACL.get("view").equals("1") ) || 
     (groupMemoACL.containsKey("view")&& groupMemoACL.get("view").equals("1")) )
{
  String str = "";
  
  page.MemoSearchForm searchForm = new page.MemoSearchForm();
  
  if (request.getParameter("isSearch") != null)
  {
	  
	  if(request.getParameter("Keyword")!=null)
		  searchForm.setKeyword(request.getParameter("Keyword"));
	  if(request.getParameter("searchBy")!=null)
		  searchForm.setSearchKeywordBy(request.getParameter("searchBy"));
	  //paramMonth
	  if(request.getParameter("paramMonth")!=null)
		  searchForm.setParamMonth(request.getParameter("paramMonth"));
	  //paramYear
	  if(request.getParameter("paramYear")!=null)
		  searchForm.setParamYear(request.getParameter("paramYear"));
	  //type
	  if(request.getParameter("type")!=null)
		  searchForm.setParamCategory(request.getParameter("type"));

    str = "&Keyword="+URLEncoder.encode(request.getParameter("Keyword"))+"&searchBy="+request.getParameter("searchBy")+"&isSearch=1";
  }
  
  if (userID != null && moduleName != null && action != null)
  { 
    if (request.getParameter("start") != null)
    start = Integer.parseInt(request.getParameter("start"));

    if (request.getParameter("sort") != null)
    	sortBy = request.getParameter("sort");
    if (request.getParameter("order") != null)
    	sortOrder = request.getParameter("order");
	  
    // get folderID
    folderID = request.getParameter("folderID");
    
    if (folderID != null && !folderID.equals("")) {
        try {			  
            Integer.parseInt(folderID);						
        }
        catch(Exception e) {
            folderID = "1";
        }
    }
    else {
            folderID = "1";
    }
    
    // get memos 
   	if (request.getParameter("isSearch") != null)
   	{
     	//vFolderContents = beanMemo.searchMemo(request.getParameter("Keyword"),request.getParameter("searchBy"),sortBy, sortOrder, start, limit,userID);
     	vFolderContents = beanMemo.searchMemo(searchForm,sortBy, sortOrder, start, limit,userID);
     	memoFormBean.setvFolderContents(vFolderContents);
     	//memoFormBean.setvFolderContentsList(vFolderContents);
    }
    else {
    	//System.out.println("web/includes/memoViewFolder.jsp \tisnotSearch");
	    vFolderContents = beanMemo.getFolderContents(userID, folderID, sortBy, sortOrder, start, limit, request.getParameter("type"), "ALL" );
	    
	    //vFolderContents = beanMemo.getFolderContents(userID, folderID, sortBy, sortOrder, start, limit);
	    memoFormBean.setvFolderContents(vFolderContents);
	    memoFormBean.setUnreadMemoList( beanMemo.getFolderContents(userID, folderID, sortBy, sortOrder, start, limit, request.getParameter("type"), "UNREAD") );
	    //memoFormBean.setvFolderContentsList(vFolderContents);
    }
    
	currentSortOrder = sortOrder;
	
    if (request.getParameter("order") == null)
      sortOrder = "asc";	  
	  
    if (vFolderContents != null && vFolderContents.size() > 0)
    {
	  if (request.getParameter("order") != null)  
	  {
        if (request.getParameter("order").equals("desc"))
          sortOrder="asc";
      	else
          sortOrder="desc";
	  }//end if (request.getParameter("order") != null)  
	
      if (vFoldersID != null && vFoldersName != null && request.getParameter("isSearch") == null)
      {
        for (i=0; i<vFoldersID.size(); i++)
        {
          if (vFoldersID.get(i).equals(folderID))
          {
            viewFolderName = messages.getString(((String)vFoldersName.get(i)).toLowerCase());
            break;
          }
        }
      }//end if (vFoldersID != null && vFoldersName != null && request.getParameter("isSearch") == null)
	  
      if (vUserFoldersID != null && vUserFoldersName != null)
      {
        for (i=0; i<vUserFoldersID.size(); i++)
        {
          if (vUserFoldersID.get(i).equals(folderID))
          {
            viewFolderName = (String)vUserFoldersName.get(i);
            break;
          }
        }
      }//end if (vUserFoldersID != null && vUserFoldersName != null)
%>
        <SCRIPT LANGUAGE="JavaScript">
        function confirmFolderDelete(action)
        {
          if (confirm("<%= messages.getString("click.OK.confirm") %>"))
            location.href = action;
        }
        function confirmDelete(action)
        {																	 
          if (document.viewMemo.memoID == null)
          {
            return;
          }
          
          var ok = 0;
          if (document.viewMemo.memoID[1] != null)
          {
            for(var c=0; c < document.viewMemo.memoID.length; c++)
            {
              if(document.viewMemo.memoID[c].checked)
              {
                ok = 1;
                break;
              }
            }
          }
          else if (document.viewMemo.memoID.checked)
          {
            ok = 1;
          }
          if(ok == 0)
          {
            alert("<%= messages.getString("memo.select.all.error") %>");
            return;
          }
          
          if (action == 'delete')
          {
            document.viewMemo.action = 'Memo?action=delete&type=<%=request.getParameter("type")%>';
            if (confirm("<%= messages.getString("click.OK.confirm") %>"))
              document.viewMemo.submit();
          }
		
          else if (action == 'move')
          {
            if (document.viewMemo.moveFolderID.value != '')
            {
              document.viewMemo.action = 'Memo?action=move&type=<%=request.getParameter("type")%>';
              if (confirm("<%= messages.getString("click.OK.confirm") %>"))
                document.viewMemo.submit();
            }
            else
            {
              alert("<%= messages.getString("memo.select.folder.move") %>")
            }
          }
		  else if (action == 'move1')
          {
            document.viewMemo.moveFolderID.selectedIndex = document.viewMemo.moveFolderID1.selectedIndex;
		  
		  	if (document.viewMemo.moveFolderID.value != '')
            {
              document.viewMemo.action = 'Memo?action=move&type=<%=request.getParameter("type")%>';
              if (confirm("<%= messages.getString("click.OK.confirm") %>"))
                document.viewMemo.submit();
            }
            else
            {
              alert("<%= messages.getString("memo.select.folder.move") %>")
            }
          }

          else
          {
            if (confirm("<%= messages.getString("click.OK.confirm") %>"))
              location.href = action;
          }
        }
        function selectAll()
        {
          /* will now be transformed into a toggle*/ 
          if(document.viewMemo.memoID == null)
          {
            return;
          }
          if (document.viewMemo.memoID[1] != null)
          {
            for (var i=0; i < document.viewMemo.memoID.length; i++)
            {
              document.viewMemo.memoID[i].checked = !document.viewMemo.memoID[i].checked;
            }
          }
          else
              document.viewMemo.memoID.checked = !document.viewMemo.memoID.checked;
        }
        </SCRIPT>

		<script language="javascript">
			var ProfileWin_q;
			
			function viewProfile(userid) {
				if (ProfileWin_q && !ProfileWin_q.closed) ProfileWin_q.close();			
					ProfileWin_q = window.open('<%=request.getContextPath()%>/includes/directoryUsersProfile.jsp?userProfile='+userid, 'ProfileWin_q', 'width=800,height=300,resizable=yes,scrollbars=1');
				
				if (ProfileWin_q && !ProfileWin_q.closed) ProfileWin_q.focus();
			}
		
		</script>

<% 
	//to upgrade into bean
	memoFormBean.setDateFormat(dateFormat); 
	memoFormBean.setFolderId(folderID);
	memoFormBean.setSortBy(sortBy);
	memoFormBean.setSortOrder(sortOrder);
	memoFormBean.setCurrentSortOrder(currentSortOrder);
%>		
	
		
<FORM NAME="viewMemo" ACTION="Memo?action=delete&type=<%=request.getParameter("type")%>" METHOD="POST">
	<INPUT TYPE="HIDDEN" NAME="folderID" VALUE="<%=memoFormBean.getFolderId()%>">
		<table width="100%"  border="0" cellpadding="2" cellspacing="0" class="contentBgColorAlternate">
		 
<%
		if (request.getParameter("isSearch") == null)
		{
%>		
			<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
          		<TD CLASS="sideTitleBgBorderColor" COLSPAN="6" ALIGN="center">
		  
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
                    		<td width="3%" CLASS="sideTitleBgBorderColor">
                    			<img src="images/hyperlink/begmemo.gif" width="22" height="22" border="0" />
                    		</td>
                    		<td width="40%" CLASS="sideTitleBgBorderColor"> 
								<FONT COLOR="#FFFFFF" CLASS="sideTitleFont" style="font-weight: bolder">
								<c:choose>
									<c:when test="${param.type=='Y'}">
										<b>OFFICIAL +<%= viewFolderName %>+</b>
									</c:when>
									<c:when test="${param.type=='N'}">
										<b>UNOFFICIAL +<%= viewFolderName %>+</b>
									</c:when>
									<%-- c:when test="${param.type=='A'}">
										<b>REMINDER: APPOINTMENT +<%= viewFolderName %>+</b>
									</c:when --%>
									<c:otherwise>
										<b>REMINDER: APPOINTMENT &amp;OTHERS +<%= viewFolderName %>+</b>
									</c:otherwise>
								</c:choose>	
								<% 
								memoCount = memoFormBean.getvFolderContents().get(memoFormBean.getvFolderContents().size()-1).getTotalRecords(); 
								memoCountUnread = memoFormBean.getvFolderContents().get(memoFormBean.getvFolderContents().size()-1).getTotalRecords(); 
								
								%>
								:: <%=memoCount%>&nbsp;total memos (<%=memoFormBean.getUnreadMemoList().size()%> unread) ::			  
							 	</FONT>
							</td>
							
                    		<td width="70%" CLASS="sideTitleBgBorderColor">
		                      <div align="right">
								<% if (showIcon) { %>
                        		<a href="javascript:selectAll();" onMouseOver="window.status='Select All';return true;">
                        			<img src="images/system/ic_selectall.gif" border="0" alt="Select All" />
                        		</a> 
                        		<a href="javascript:confirmDelete('delete');" onMouseOver="window.status='Delete';return true;">
                        			<img src="images/system/ic_delete.gif" border="0" alt="Delete" />
                        		</a>
                        		<% } else { %>
                        		<input name="checkbox" type="checkbox" onClick="selectAll()" />
                        		<%= messages.getString("select.all") %> <a href="javascript:confirmDelete('delete');" onMouseOver="window.status='<%= messages.getString("delete") %>';return true;"><%= messages.getString("delete") %></a>
                        		<% } %>
                        <a href="memo.jsp?action=folders&type=Y&folderID=1" onMouseOver="window.status='<%=messages.getString("memo")%>';return true;"></a>&nbsp;<img src="images/hyperlink/info.png" width="22" height="22"  border="0" />
                        <a href="memo.jsp?action=folders&type=<%=request.getParameter("type")%>&folderID=1" onMouseOver="window.status='<%= messages.getString("memo") %>';return true;"></a>&nbsp;
                        <a href="javascript:void(window.open('includes/view.htm','approve', 'height=300,width=800,menubar=no,toolbar=no,scrollbars=yes'))"><FONT COLOR="#FFFFFF" CLASS="sideTitleFont"><b>Click Me</b></FONT></a></div>
                        </td>
                  </tr>
            </table>
          <B><%--= viewFolderName --%></B>
          
          
          <% 
          if (Integer.parseInt(folderID) > 4 )
          {
					  if (showIcon) {
            %>
            <a href="javascript:confirmFolderDelete('Memo?action=delfolder&type=<%=request.getParameter("type")%>&folderID=<%= folderID %>');" onMouseOver="window.status='Delete this folder';return true;">
            	<IMG SRC="images/system/ic_delete.gif" ALIGN="RIGHT" BORDER="0" ALT="Delete">
            </a>
           	<a href="memo.jsp?action=editfolder&type=<%=request.getParameter("type")%>&folderID=<%= folderID %>" onMouseOver="window.status='Edit this folder';return true;">
           		<IMG SRC="images/system/ic_edit.gif" ALIGN="RIGHT" BORDER="0" ALT="Edit">
           	</a>
         <%	} else { %>
				 		<table cellpadding="0" cellspacing="0" width="100%">
					<TR VALIGN="TOP" CLASS="sideTitleBgBorderColor" BGCOLOR="#DBDBDB">			  
						<TD CLASS="sideTitleBgBorderColor" colspan="5" ALIGN="right">						 
        	               <a href="memo.jsp?action=editfolder&type=<%=request.getParameter("type")%>&folderID=<%= folderID %>" onMouseOver="window.status='<%= messages.getString("memo.edit.folder") %>';return true;"><%= messages.getString("edit") %></a>						
						   <a href="javascript:confirmFolderDelete('Memo?action=delfolder&type=<%=request.getParameter("type")%>&folderID=<%= folderID %>');" onMouseOver="window.status='<%= messages.getString("memo.delete.folder") %>';return true;"><%= messages.getString("delete") %></a>
						</td>
				     </tr>
			     </table>
	
				 <%		}
          }
          %>
          </td>
        </tr>  
<%
	   }
%>	  

			<TR valign="TOP" bgcolor="#000000">      
				<TD width="5%" ALIGN="LEFT">
					<a href="memo.jsp?action=<%= action %>&type=<%=request.getParameter("type")%>&folderID=<%= folderID %>&sort=priority&order=<%= sortOrder %>&start=<%= start %>&listing=<%= request.getParameter("listing") %><%= str %>" onMouseOver="window.status='<%= messages.getString("priority") %>';return true;">
						<b><font color="#FFFFFF" class="sideTitleFont"><%= messages.getString("priority") %></font></B>
					</a>
       	 		</TD>
			<% if (!action.equals("search")) {  %>				 
		     	<TD ALIGN="LEFT"></TD>
             <% }%>		 
	     		<TD width="20%" ALIGN="LEFT">
	     		<B>
		    <% 	   if (folderID.equals("2") || folderID.equals("4"))  { %>	   
              		<A HREF="memo.jsp?action=folders&type=<%=request.getParameter("type")%>&folderID=<%= folderID %>&sort=toName&order=<%= sortOrder %>&start=<%= start %>&listing=<%= request.getParameter("listing") %>" onMouseOver="window.status='<%= messages.getString("memo.to") %>';return true;">
			  	<B><font color="#FFFFFF" CLASS="sideTitleFont"><%= messages.getString("memo.to") %></font></B></a>
			 <%} else { %>	   
			       <A HREF="memo.jsp?action=<%= action %>&type=<%=request.getParameter("type")%>&folderID=<%= folderID %>&sort=firstName&order=<%= sortOrder %>&start=<%= start %>&listing=<%= request.getParameter("listing") %><%= str %>" onMouseOver="window.status='<%= messages.getString("memo.from") %>';return true;">
				   <B><font color="#FFFFFF" CLASS="sideTitleFont"><%= messages.getString("memo.from") %></font></B></a>
			<% } %>
            </B>
          </td>
		  <% if ( ((String)TvoContextManager.getAttribute(request, "System.language")).equals("en")) {%>
          <TD ALIGN="LEFT">
		  	<A HREF="memo.jsp?action=<%= action %>&type=<%=request.getParameter("type")%>&folderID=<%= folderID %>&sort=memoFax&order=<%= sortOrder %>&start=<%= start %>&listing=<%= request.getParameter("listing") %><%= str %>" onMouseOver="window.status='<%= messages.getString("memo.subject") %>';return true;">
			<B><font color="#FFFFFF" CLASS="sideTitleFont"><%= messages.getString("memo.subject") %></font></B></a>
		  </td>
		  <% }
		     else {   %>
			    <TD CLASS="menuBgColor" ALIGN="LEFT">
			    <b><font color="#FFFFFF" CLASS="sideTitleFont"><%=messages.getString("memo.subject")%></font></b>
				</td>
		  <% }	%>
		  <TD width="15%" ALIGN="LEFT">
            <A HREF="memo.jsp?action=<%= action %>&type=<%=request.getParameter("type")%>&folderID=<%= folderID %>&sort=memoDatePosted&order=<%= sortOrder %>&start=<%= start %>&listing=<%= request.getParameter("listing") %><%= str %>" onMouseOver="window.status='<%= messages.getString("memo.date") %>';return true;">
			<B><font color="#FFFFFF" CLASS="sideTitleFont"><%= messages.getString("memo.date") %></font></B></a>
		  </td>
          <TD ALIGN="LEFT">
          	<b><font color="#FFFFFF" CLASS="sideTitleFont">Status</font></b>
			<!-- <A HREF="memo.jsp?action=<%= action %>&folderID=<%= folderID %>&sort=isMemoRead&order=<%= sortOrder %>&start=<%= start %>&listing=<%= request.getParameter("listing") %><%= str %>" onMouseOver="window.status='<%= messages.getString("memo.read") %>';return true;"><B><%= messages.getString("memo.read") %></B></a>
          	-->
		  </td>		  
		  

		<c:if test="$(not empty param.isSearch)">
			<td ALIGN="LEFT">
				<b>
				<% if (showIcon) {  %>
	    	     <A HREF="memo.jsp?action=<%= action %>&type=<%=request.getParameter("type")%>&folderID=<%= folderID %>&sort=memoFolderName&order=<%= sortOrder %>&start=<%= start %>&listing=<%= request.getParameter("listing") %><%= str %>" onMouseOver="window.status='<%= messages.getString("memo.folder") %>';return true;">
				 <b><font color="#FFFFFF" CLASS="sideTitleFont"><%= messages.getString("memo.folder") %></font></b></a>
	      		<% } else { %>
					<b>	<font color="#FFFFFF" CLASS="sideTitleFont"><%= messages.getString("memo.folder") %></font></b>
				<% } %>					 
				</b>
        	</td>
        </c:if>  
        	  
        </tr>
 
        <tr>
        	<td>
        		<c:if test="${not empty memoFormBean.vFolderContents}">
        		<c:forEach items="${memoFormBean.vFolderContents}" var="fldrContent" varStatus="fldrContentStatus">
        			<tr valign="TOP" bgcolor="#EBEBEB">
		   				<td height="1" COLSPAN="8" nowrap  background="images/hr_dotted.gif"></TD>
          			</tr>
          			
        			<c:set target="${memoFormBean}" property="tempUserId" value="${fldrContent.fromUserID}"/>
        			
        			<c:choose>
        				<c:when test="${empty param.isSearch}">
        					<c:set target="${memoFormBean}" property="tempToName" value="${fldrContent.toName}"/>
        					<c:set target="${memoFormBean}" property="tempToGroupName" value="${fldrContent.toGroupName}"/>
        					<%
        						if (memoFormBean.getTempToName().length() != 0 && memoFormBean.getTempToGroupName().length() != 0) {
        						  //toName = ", " + toName;
        						  memoFormBean.setTempToName(", " + memoFormBean.getTempToName());
        						}
        						//toName = toGroupName + toName;
        						memoFormBean.setTempToName( memoFormBean.getTempToGroupName() + memoFormBean.getTempToName() );
        						
        						if (memoFormBean.getTempToName().length() > 0 && memoFormBean.getTempToName().endsWith(","))
        						{
        						  //toName = CommonFunction.restrictNameLength(toName.substring(0,toName.length()-1),33);
        						  memoFormBean.setTempToName( CommonFunction.restrictNameLength(memoFormBean.getTempToName().substring(0,memoFormBean.getTempToName().length()-1),33) );
        						}
        					%>
        				</c:when>
        				<c:otherwise>
        					<c:set target="${memoFormBean}" property="tempToName" value="${fldrContent.memoFrom}"/>
        				</c:otherwise>
        			</c:choose>
        			
					<% 
						memoFormBean.setTempUserType(staffStudent2.getUserType(request, response, memoFormBean.getTempUserId()));
						//System.out.println("\tmemoFormBean.getTempUserId()="+memoFormBean.getTempUserId()+"\n\tmemoFormBean.getTempUserType()=" + memoFormBean.getTempUserType());
					%>
					<c:choose>
						<c:when test="${memoFormBean.tempUserType=='STAFF'}">
							<c:set target="${memoFormBean}" property="fontColorStyle" value="#0066CC"/>
						</c:when>
						<c:when test="${memoFormBean.tempUserType=='STUDENT'}">
							<c:set target="${memoFormBean}" property="fontColorStyle" value="#9900CC"/>
						</c:when>
						<c:otherwise>
							<c:set target="${memoFormBean}" property="fontColorStyle" value="#000000"/>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${fldrContent.isMemoRead=='0'}">
							<c:set target="${memoFormBean}" property="fontWeightStyle" value="bold"/>
							<c:set target="${memoFormBean}" property="bgColorStyle" value="#FFFF99"/>
						</c:when>
						<c:otherwise>
							<c:set target="${memoFormBean}" property="fontWeightStyle" value="normal"/>
							<c:set target="${memoFormBean}" property="bgColorStyle" value="#FFFFCC"/>
						</c:otherwise>
					</c:choose>
					
        			<tr valign="top" class="contentBgColor"
        				style="color:${memoFormBean.fontColorStyle};font-weight:${memoFormBean.fontWeightStyle};background-color:${memoFormBean.bgColorStyle};">

          				<td align="left">
          					<input type="checkbox" name="memoID" value="${fldrContent.memoID}">
          					<input type="hidden" name="memoFolderID" value="${fldrContent.memoFolderID}">
          					
          					<c:if test="${not empty fldrContent.memoFolderID and fldrContent.memoFolderID=='4'}" >
	          					<a href="memo.jsp?action=draft&type=${param.type}&memoID=${fldrContent.memoID}" onMouseOver="window.status='Edit';return true;">
	          						<img src="images/system/ic_edit.gif" border="0" alt="Edit">
	          					</a>
          					</c:if>
          					
          					<c:if test="${not empty fldrContent.priority}">
          						<c:if test="${fldrContent.priority=='0'}">
          							<img src="images/system/ic_highp${fldrContent.memoIcon}.gif">
          						</c:if>
          						<c:if test="${fldrContent.priority=='2'}">
          							<img src="images/system/ic_lowp${fldrContent.memoIcon}.gif">
          						</c:if>
          					</c:if>
          				</td>
          				
          				<c:if test="${empty param.isSearch}">
          					<td>&nbsp;</td>
						</c:if>
						
          				<td align="left">
          					
          					<% memoFormBean.setTempToName(CommonFunction.emptyToStr( memoFormBean.getTempToName(),"<>")); %> 
          					<c:choose>
	          					<c:when test="${not empty fldrContent.memoFolderID and fldrContent.memoFolderID!='4'}" >
		          					<!-- a class="def${fldrContent.memoID}" 
										href="memo.jsp?action=folders&type=${param.type}&memoID=${fldrContent.memoID}&sort=${memoFormBean.sortBy}&order=${memoFormBean.currentSortOrder}&folderID=${memoFormBean.folderId}" 
										onMouseOver="window.status='${fldrContent.memoFolderID}';">
										<font color="${memoFormBean.fontColorStyle}">
											<c:out value="${memoFormBean.tempToName}" />
										</font>
									</a -->
									
									<a href="javascript:viewProfile('${memoFormBean.tempUserId}')">
										<font color="${memoFormBean.fontColorStyle}">
											<img src=images/hyperlink/guest2.gif>  <c:out value="${memoFormBean.tempToName}" />
										</font>
									</a>
									
									<!-- ajax:callout sourceClass="def${fldrContent.memoID}"  baseUrl="MemoCallout" -->
<!--											parameters="memoId=${fldrContent.memoID}" title="${fldrContent.memoID}"-->
<!--											overlib="WRAPMAX,600" />-->
								</c:when>
								<c:otherwise>
									<c:out value="${memoFormBean.tempToName}" />
								</c:otherwise>
							</c:choose>		
          				</td>
          				
          				<td align="left">
          					<a class="def${fldrContent.memoID}" href="memo.jsp?action=folders&type=${param.type}&memoID=${fldrContent.memoID}&sort=${memoFormBean.sortBy}&order=${memoFormBean.currentSortOrder}&folderID=${memoFormBean.folderId}" 
								onMouseOver="window.status='${fldrContent.memoFolderID}';">
								<font color="${memoFormBean.fontColorStyle}">
								${fldrContent.memoFax}
								</font>
							</a>
          				</td>
          					
          				<td align="left">
          					<c:set target="${memoFormBean}" property="tempMemoDate" value="${fldrContent.memoDatePosted}"/>
          					<%=CommonFunction.parseDate(dateFormat,currentLocale,memoFormBean.getTempMemoDate(),TvoConstants.TIME_FORMAT_LONG)%>
          				</td>
          				
          				<td align="center">
          					<c:if test="${not empty fldrContent.memoFolderID and fldrContent.memoFolderID!='4'}" >
          						<c:if test="${empty param.isSearch}">
          							<a href="Memo?action=markReadUnread&type=${param.type}&memoID=${fldrContent.memoID}&memoRead=${fldrContent.isMemoRead}" 
          								onMouseOver="window.status='<%= messages.getString("email.mark.as",markRead) %>';return true;">
          								<font color="${memoFormBean.fontColorStyle}">
          								<c:choose>
          									<c:when test="${fldrContent.isMemoRead=='0'}">
          										<%=messages.getString("memo.unread.home")%>
          									</c:when>
          									<c:otherwise>
												<%=messages.getString("memo.read.home")%>
          									</c:otherwise>
          								</c:choose>
          								</font>
          							</a>
          						</c:if>
          						<c:if test="${not empty param.isSearch}">
          							<a href="Memo?action=markReadUnread&type=${param.type}&memoID=${fldrContent.memoID}&memoRead=${fldrContent.isMemoRead}&search=1<%= str %>&order=${memoFormBean.currentSortOrder}&sort=${memoFormBean.sortBy}&start=<%= start %>" 
          								onMouseOver="window.status='<%= messages.getString("view") %>';return true;">
          								<font color="${memoFormBean.fontColorStyle}">
          								<c:choose>
          									<c:when test="${fldrContent.isMemoRead=='0'}">
          										<%=messages.getString("memo.unread.home")%>
          									</c:when>
          									<c:otherwise>
												<%=messages.getString("memo.read.home")%>
          									</c:otherwise>
          								</c:choose>
          								</font>
          							</a>
          						</c:if>
          					</c:if>
          				</td>
          				<c:if test="${not empty param.isSearch}">
          				<td align="left">
          					<c:choose>
          						<c:when test="${fldrContent.memoFolderID<5}">
          							<c:set target="${memoFormBean}" property="tempBundleMesej" value="${fldrContent.memoFolderNameLower}"/>
          							<c:out value="${fldrContent.memoFolderName}" />
          						</c:when>
          						<c:otherwise>
          							<c:out value="${fldrContent.memoFolderName}" />
          						</c:otherwise>
          					</c:choose>
          				</td>
          				</c:if> 				
          			</tr>
        		</c:forEach> 
        		</c:if> 		
        	</td>
        </tr>
		

      
	  <%@ include file="/includes/memoPage.jsp" %>
	  
      <TR VALIGN="TOP" BGCOLOR="#DBDBDB" align="right">
        <TD CLASS="contentBgColorAlternate" COLSPAN="7" ALIGN="LEFT">
		<% if (showIcon) { %>
          <A HREF="javascript:selectAll();" onMouseOver="window.status='Select All';return true;"><IMG SRC="images/system/ic_selectall.gif" BORDER="0" ALT="Select All"></A>
          <a href="javascript:confirmDelete('delete');" onMouseOver="window.status='Delete';return true;"><IMG SRC="images/system/ic_delete.gif" BORDER="0" ALT="Delete"></a>
        <% } else { %>		  
		  <input type="checkbox" onClick="selectAll()"><%= messages.getString("select.all") %>
          <a href="javascript:confirmDelete('delete');" onMouseOver="window.status='<%= messages.getString("delete") %>';return true;"><%= messages.getString("delete") %></a>
		<% } 
		   //if (!folderID.equals("4")) {
		%>
	    <!--  <a href="javascript:confirmDelete('move');" onMouseOver="window.status='<!--%= messages.getString("move") %>';return true;"><!%= showIcon ? "<IMG SRC=\"images/system/ic_move.gif\" BORDER=\"0\" ALT=\"Move\">" : messages.getString("move") %></a> -->
          
          
<%       //}  %>					
        </TD>
      </TR>		    
	  <tr>	
	  	<td class="contentBgColorAlternate">		 	  
			<input type="hidden" name="folderID" value="<%= request.getParameter("folderID") %>" />
			<input type="hidden" name="sort" value="<%= sortBy %>" />
			<input type="hidden" name="order" value="<%= currentSortOrder %>" />
			<c:if test="not empty param.isSearch">
			<input type="hidden" name="isSearch" value="1" />
		    <input type="hidden" name="Keyword" value="<%= request.getParameter("Keyword") %>" />
			<input type="hidden" name="searchBy" value="<%= request.getParameter("searchBy") %>" />
	 		</c:if>
		</td> 
	</tr>
<%
    } else {
%>
		<TR valign="TOP" class="contentBgColorAlternate" >      
			<TD ALIGN="center" class="contentBgColorAlternate" colspan="7">
				<b>No memo found!</b>
			</TD>
		</TR>
		<TR valign="TOP" class="contentBgColorAlternate">      
			<TD ALIGN="center" class="contentBgColorAlternate" colspan="7">
				<b>&nbsp;</b>
			</TD>
		</TR>
<% 
    }
  }
}
%>

</table>

    
   