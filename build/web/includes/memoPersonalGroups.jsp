<jsp:useBean id="beanGroupMembers" scope="request" class="ecomm.bean.MemoMemo" />
<%@ page import="ecomm.bean.db.*, java.util.*,ecomm.bean.*" %>


<%
	beanGroupMembers.initTVO(request);

	MemoGroupUsers membersModel = null;
	
	MemoGroup groupModel = new MemoGroup();
	
	MemoMemo memo = new MemoMemo();

	groupModel.setMgName("Insert group name.");
	
	int i = 0;
	
	String paramGid = request.getParameter("gid");
	String paramAction = request.getParameter("action");
	
	if(paramGid==null)
		groupModel.setMgId("");
	else
		groupModel.setMgId(paramGid.trim());
	
 	Vector vUserList=null, vUserID=null, vFirstName=null, vLastName=null, vUserGroupID=null,
        vGroupID=null, vGroupName=null;
 	
 	//list personal group members
 	//Vector vMembersList = null;
 	List<MemoGroupUsers> membersList = new ArrayList<MemoGroupUsers>();

 	StringBuffer stringUserID=null, stringName=null, stringGroupID=null;
 	stringUserID  = new StringBuffer().append("");
 	stringName    = new StringBuffer().append("");
 	stringGroupID = new StringBuffer().append("");
 	
 	StringBuffer stringMemberID=null, stringMemberName=null, stringMembersGroupID=null;
 	stringMemberID  		= new StringBuffer().append("");
 	stringMemberName    	= new StringBuffer().append("");
 	stringMembersGroupID 	= new StringBuffer().append("");
 
 	vUserList = beanGroupMembers.getCoreUserGroupList();
 	
 	if (vUserList != null)  {
  		vUserID = (Vector)vUserList.get(0);
  		vFirstName = (Vector)vUserList.get(1);
  		vLastName = (Vector)vUserList.get(2);
  		vUserGroupID = (Vector)vUserList.get(3);
  		vGroupID = (Vector)vUserList.get(4);
  		vGroupName = (Vector)vUserList.get(5);
 	}
 	
 	//create list for javascript array;
	if (vUserID != null && vFirstName != null && vLastName != null && vUserGroupID != null) { 
 		for (i = 0; i < vUserID.size(); i++) { 
  			stringUserID.append("'" + vUserID.get(i) + "',");
  			stringName.append("'" + CommonFunction.escapeQuote(CommonFunction.restrictNameLength(vFirstName.get(i) + " " + vLastName.get(i), 40)) + "',");
  			stringGroupID.append("\"" + vUserGroupID.get(i) + "\","); 
 		}
 		if (!stringUserID.toString().equals(""))  {
  			stringUserID  = new StringBuffer().append(stringUserID.substring(0, stringUserID.length()-1));
 	 		stringName    = new StringBuffer().append(stringName.substring(0, stringName.length()-1));
  			stringGroupID = new StringBuffer().append(stringGroupID.substring(0, stringGroupID.length()-1));
  		}
	}
	
	
	if (paramAction.equals("editGroup") && paramGid!=null)
	{
		//umpuk memo group details
		memo.initTVO(request);
		groupModel = memo.getMemoGroupDetl(paramGid);
		//umpuk member list
		membersList = beanGroupMembers.getMemoGroupMemberList(paramGid);
/*		
		for (MemoGroupUsers model : membersList)
		{
			System.out.println("\t"+model.getMemberId()+", "+model.getMemberName()+", "+model.getGroupId());
		 	stringMemberID.append("'" + model.getMemberId() + "',");
		 	stringMemberName.append("'" + CommonFunction.escapeQuote(CommonFunction.restrictNameLength(model.getMemberName(), 40)) + "',");
		 	stringMembersGroupID.append("\"" + model.getGroupId() + "\",");
		}
		if (!stringMemberID.toString().equals(""))  {
		stringMemberID  	= new StringBuffer().append(stringMemberID.substring(0, stringMemberID.length()-1));
		stringMemberName    = new StringBuffer().append(stringMemberName.substring(0, stringMemberName.length()-1));
		stringMembersGroupID 		= new StringBuffer().append(stringMembersGroupID.substring(0, stringMembersGroupID.length()-1));
		}
*/		
	}

%>

<!-- Form for Adding / Editing Users -->
<script language = "javascript" type="text/javascript" src ="template/default/moveItem.js" ></script>

<script LANGUAGE="JavaScript" type="text/javascript">
	myUserID    = new Array(<%= stringUserID %>);
 	myNames     = new Array(<%= stringName %>);
 	myGroupID   = new Array(<%= stringGroupID %>);

	//membersID    	= new Array(<%= stringMemberID %>);
 	//membersNames    = new Array(<%= stringMemberName %>);
 	//membersGroupID 	= new Array(<%= stringMembersGroupID %>);

	function checkAddGroup()
	{
            if (confirm("<%= messages.getString("click.OK.confirm") %>"))
              document.addGroup.submit();
	}

	function selectAll(selectBox,selectAll) 
	{
	    // have we been passed an ID
	    if (typeof selectBox == "string") {
	        selectBox = document.getElementById(selectBox);
	    }
	    // is the select box a multiple select box?
	    if (selectBox.type == "select-multiple") {
	        for (var i = 0; i < selectBox.options.length; i++) {
	            selectBox.options[i].selected = selectAll;
	        }
	    }
	}

	function checkEditGroup()
	{
		document.addGroup.action = "Memo?action=editpersonalgroup";
		selectAll(document.addGroup.groupUsers,true);
        if (confirm("<%= messages.getString("click.OK.confirm") %>"))
            document.addGroup.submit();
	}
	
	function checkEmpty(obj) {
 		noItems(obj.allGroupUsers,  "------------ <%= messages.getString("none") %> ------------", -1);
 		noItems(obj.groupUsers,     "------------ <%= messages.getString("none") %> ------------", -1);
	}
</script>

	<form name="addGroup" id="addGroup" action="Memo?action=addpersonalgroup" method="post">
	<table width="100%">
	
		<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
		  <TD CLASS="contentBgColorAlternate" COLSPAN="4" ALIGN="center">
		    <B><%= messages.getString("directory.group.add.new.group") %></B>
		  </td>
		</tr>

		<TR VALIGN="TOP" BGCOLOR="#EBEBEB">
		  <td CLASS="contentBgColor" COLSPAN="4" ALIGN="center">
		    <B><br/><%= messages.getString("directory.group.name") %> </B><BR>
		    <input type="text" name="groupName" value="<%=groupModel.getMgName()%>" SIZE="40" />
		    <input type="hidden" name="groupId" id="groupId" value="<%=groupModel.getMgId()%>" />
		  </td>
		</tr>
		
		<tr><td colspan="4" class="contentBgColor">&nbsp;</td></tr>

		<tr>
		  <td bgcolor="#EBEBEB" class="contentBgColor" align="RIGHT">
		    <B><%= messages.getString("directory.all.groups") %> </B>
		  </td>  
		  <td bgcolor="#EBEBEB" class="contentBgColor" align="left" valign="top">
		      <select name="groupID" size="1" onChange="loadGroupItems(this.options[this.selectedIndex].value, myGroupID, myNames, myUserID, document.addGroup.allGroupUsers, '------------ <%= messages.getString("none") %> ------------', -1, document.addGroup.groupUsers);">
		        <option value="0" SELECTED><%= messages.getString("select") %></option>
		        <option value="-1"><%= messages.getString("all.users") %></option>
		    <%	if (vGroupID != null && vGroupName != null)
		        	for (i=0; i < vGroupID.size(); i++) { %>
						<option value="<%= vGroupID.get(i) %>"><%= CommonFunction.restrictNameLength((String)vGroupName.get(i),30) %></option>
		    <%	} %>
		      </select>
		  </td>
		</tr>

		<tr>
		  <TD BGCOLOR="#EBEBEB" CLASS="contentBgColor" ALIGN="center" VALIGN="TOP" colspan="2">
			
			<table border="0" cellspacing="0" cellpadding="0">
		    	<tr>
			   		<TD BGCOLOR="#EBEBEB" CLASS="contentBgColor" ALIGN="LEFT" VALIGN="TOP">
			    		<select name="allGroupUsers" size="20" style="width:300px;" multiple>
		  				</select>
		      		</td>
					
					<TD CLASS="contentBgColor" ALIGN="CENTER" VALIGN="MIDDLE" >
				      	<A HREF="javascript:moveItems(document.addGroup.allGroupUsers, document.addGroup.groupUsers, '--------------- <%= messages.getString("none") %> ---------------', -1);" onMouseOver="window.status='<%= messages.getString("add") %>';return true;"><IMG SRC="images/system/ic_rightarrow.gif" BORDER="0" ALT="<%= messages.getString("add") %>"></A><BR><BR>
				      	<A HREF="javascript:moveItems(document.addGroup.groupUsers, document.addGroup.allGroupUsers, '--------------- <%= messages.getString("none") %> ---------------', -1);" onMouseOver="window.status='<%= messages.getString("email.remove") %>';return true;"><IMG SRC="images/system/ic_leftarrow.gif" BORDER="0" ALT="<%= messages.getString("email.remove") %>"></A>
					</TD>
		     
				    <TD CLASS="contentBgColor" VALIGN="TOP">
				  		<select name="groupUsers" size="20" style="width:300px;"  multiple>
				  			<% for (MemoGroupUsers mmbr : membersList) {%>
				  			<option value="<%=mmbr.getMemberId()%>"><%=mmbr.getMemberName()%></option>
				  			<% }//end for (int i; i<= membersList.size() ; i++) {%>
				  		</select>
					</TD>
				</tr>
			
			<tr>
				<td class="contentBgColor" align="left" valign="top">
		    	<% if (showIcon) {  %>		  
		      	<A HREF="javascript:selectAllItems(document.addGroup.allGroupUsers);" onMouseOver="window.status='Select All';return true;"><IMG SRC="images/system/ic_selectall.gif" BORDER="0" ALT="Select All"></A> 
		      	<A HREF="javascript:clearAllItems(document.addGroup.allGroupUsers);" onMouseOver="window.status='Clear All';return true;"><IMG SRC="images/system/ic_clear.gif" BORDER="0" ALT="Clear All Selected"></A>
				<% } else {  %>
		        <A HREF="javascript:selectAllItems(document.addGroup.allGroupUsers);" onMouseOver="window.status='<%= messages.getString("select.all") %>';return true;"><%= messages.getString("select.all") %></A> 
		        <A HREF="javascript:clearAllItems(document.addGroup.allGroupUsers);" onMouseOver="window.status='<%= messages.getString("clear.all") %>';return true;"><%= messages.getString("clear.all") %></A>
			  	<% }  %>	
		      </TD>
		      <TD CLASS="contentBgColor">&nbsp;</TD>
		      <TD CLASS="contentBgColor" ALIGN="LEFT" VALIGN="TOP">
			  <% if (showIcon) {  %>
		        <A HREF="javascript:selectAllItems(document.addGroup.groupUsers);" onMouseOver="window.status='Select All';return true;">
		        	<IMG SRC="images/system/ic_selectall.gif" BORDER="0" ALT="Select All">
		        </A> 
		        <A HREF="javascript:clearAllItems(document.addGroup.groupUsers);" onMouseOver="window.status='Clear All';return true;">
		        	<IMG SRC="images/system/ic_clear.gif" BORDER="0" ALT="Clear All Selected">
		        </A>
			  <% } else { %>
		        <A HREF="javascript:selectAllItems(document.addGroup.groupUsers);" onMouseOver="window.status='<%=messages.getString("select.all") %>';return true;">
		        	<%= messages.getString("select.all") %>
		        </A> 
		        <A HREF="javascript:clearAllItems(document.addGroup.groupUsers);" onMouseOver="window.status='<%= messages.getString("clear.all") %>';return true;">
		        	<%= messages.getString("clear.all") %>
		        </A>
			  <% }  %>
		      </TD></TR>
		  </table>
		 </td>	  
		</tr>

		<tr valign="top" bgcolor="#EBEBEB">
			<td class="contentBgColor" colspan="4" align="center">
			<% if (paramAction!=null && paramAction.trim().equals("addGroup")) {%>
				<A HREF="javascript:checkAddGroup();" onMouseOver="window.status='<%= messages.getString("add") %>';return true;">
					<IMG SRC="images/system/<%= messages.getString("add.icon") %>.gif" BORDER="0" ALT="<%= messages.getString("add") %>">
				</a>
			<% } else if (paramAction!=null && paramAction.trim().equals("editGroup")) {%>
				<A HREF="javascript:checkEditGroup();" onMouseOver="window.status='<%= messages.getString("update") %>';return true;">
					<IMG SRC="images/system/<%= messages.getString("update.icon") %>.gif" BORDER="0" ALT="<%= messages.getString("update") %>">
				</a>
			<% } %>
			</td>
		</tr>
</table>
</form>

<SCRIPT LANGUAGE="Javascript">
 	checkEmpty(document.addGroup);
</SCRIPT>
