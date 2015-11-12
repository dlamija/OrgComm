<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.text.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.util.StringTokenizer" %>

<jsp:useBean id="beanResource" scope="request" class="ecomm.bean.ResourceResource" />
<jsp:useBean id="staffStudentUser" scope="request" class="common.StaffStudent"/>

<%
    if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_RESOURCE) )
      beanResource.initTVO(request);
%>
<%
	Connection conn = null;
	boolean status = true;
	String memoID = request.getParameter("memoID");

//to
    String name = null;
	String department = "";
	String position = "";
	String phone = "";
	String ext = "";
    String type = "";
	String matric = "";
    String faculty = "";

//cc
    String departmentcc = "";
	String positioncc = "";
    String typecc = "";
	PreparedStatement pstmt = null;
	ResultSet rset = null;
			
 try
	{
		Context initCtx = new InitialContext();
		Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
		DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
		conn = ds.getConnection();
				
	}
	catch( Exception e )
	{ 
		out.println (e.toString()); 
	}
%>

<script language = "Javascript">

function gotopage (selSelectObject)
{
	if(selSelectObject.options[selSelectObject.selectedIndex].value != "")
	  {
	   location.href=selSelectObject.options[selSelectObject.selectedIndex].value
	  }
	}

	var ReportWin;
	
	function printReport(memoid,subj) {
		if (ReportWin && !ReportWin.closed) ReportWin.close();			
			ReportWin = window.open('memo.jsp?action=printPdf&memoid=' + memoid+'&subject='+subj, 'printReport', 'width=800,height=600,resizable=yes,scrollbars=1');		
		if (ReportWin && !ReportWin.closed) ReportWin.focus();
	}
</script>



<% 
if (conn!=null)
	{
	String sqlstatus = "SELECT M.userID FROM tmsintranet3.Memo M "+
	                   "WHERE M.memoID = '" + memoID +"' AND M.touserid = '"+ userID +"' ";

	try
		{
		PreparedStatement pstmtstatus = conn.prepareStatement(sqlstatus);
		ResultSet rsetstatus = pstmtstatus.executeQuery ();
		if (rsetstatus.next())
			status = true;
		else
			status = false;
		pstmtstatus.close ();
		rsetstatus.close ();
		}
	catch (SQLException e)
		{ out.println ("Error : " + e.toString ()); }
}
%>
<%
	try { // added try block - cikgu
		if (status) { %>

<%--  
<SCRIPT LANGUAGE="JavaScript">

function appConfirm(url, recordID, resourceID)  {	
  if(!confirm("You are about to confirm your booking."))
  { return;
  }
  else  
  { document.approvedResource.resourceRecord.value=recordID;
    document.approvedResource.resourceID.value=resourceID;
  	document.approvedResource.submit();
    self.location=url;
  }
}

function appReject(url, recordID, resourceID)  {	
  if(!confirm("Are you sure you want to reject?"))
  { return;
  }
  else  
  { document.rejectedResource.resourceRecord.value=recordID;
    document.rejectedResource.resourceID.value=resourceID;
  	document.rejectedResource.submit();
    self.location=url;
  }
}
</SCRIPT>
--%>
<style type="text/css">
<!--
.style1 {
	font-family: Arial;
	font-weight: bold;
	font-size: 10px;
}
.style3 {
	font-size: 12px;
	font-style: italic;
}
.style5 {font-family: Arial; font-weight: bold; font-size: 11px; }
.style7 {
	color: #FF9900;
	font-weight: bold;
	font-family: Arial;
	font-size: 10px;
}
.style9 {
	font-family: Arial;
	font-size: 10px;
	font-style: italic;
	color: #000000;
}
.style11 {font-family: Arial; font-size: 11px; }
.style13 {font-family: Arial; font-weight: bold; font-size: 11px; color: #000000; }
-->
</style>


<FORM NAME="approvedResource" METHOD="POST" ACTION="servlet/Resource?action=approvingResource" TARGET="calendarAdd">
  <input type="hidden" name="userID" value="<%=userID%>">
  <input type="hidden" name="resourceRecord" value="">
  <input type="hidden" name="resourceID" value="">
</FORM>

<FORM NAME="rejectedResource" METHOD="POST" ACTION="servlet/Resource?action=rejectResource" TARGET="calendarAdd">
  <input type="hidden" name="userID" value="<%=userID%>">
  <input type="hidden" name="resourceRecord" value="">
  <input type="hidden" name="resourceID" value="">
</FORM>

<%
    Vector vMemoFoldersList=null, vMemoFoldersID=null, vMemoFoldersName=null;
    Vector vMemoFoldersCount=null, vMemoFoldersUnreadCount=null;
    Vector vMemoUserFoldersID=null, vMemoUserFoldersName=null;
    Vector vMemoUserFoldersCount=null, vMemoUserFoldersUnreadCount=null;
    String memoFilename, memoMessage,memoFlag="";
    StringTokenizer stMemoFlags,stMemoPhysicalFileName;
    int ii;
    String viewFolderName = "", folderID = "1";


					   
    if ( (userMemoACL.containsKey("view") && userMemoACL.get("view").equals("1") ) || 
         (groupMemoACL.containsKey("view")&& groupMemoACL.get("view").equals("1")) ) {

      if (userID != null && moduleName != null && action != null)  {

        MemoDB memo = beanMemo.getMemoContents(request.getParameter("memoID"),request);

        vMemoFoldersList = beanMemo.showModule(userID, moduleName, "folders");
        if (vMemoFoldersList != null)    {

          // System folders
          vMemoFoldersID = (Vector)vMemoFoldersList.get(0);
          vMemoFoldersName = (Vector)vMemoFoldersList.get(1);
        //  vMemoFoldersCount = (Vector)vFoldersList.get(2);
         // vMemoFoldersUnreadCount = (Vector)vFoldersList.get(3);
      
          // User folders
          vMemoUserFoldersID = (Vector)vMemoFoldersList.get(2);
          vMemoUserFoldersName = (Vector)vMemoFoldersList.get(3);
          //vMemoUserFoldersCount = (Vector)vFoldersList.get(6);
          //vMemoUserFoldersUnreadCount = (Vector)vFoldersList.get(7);
        }
      
        if (memo != null)        {      
          stMemoFlags = new StringTokenizer(memo.getMemoStatus(),",");
          memoFilename = CommonFunction.parseDate(dateFormat,currentLocale,memo.getMemoDatePosted(),TvoConstants.TIME_FORMAT_LONG);
      
          memoMessage = CommonFunction.ln2br(memo.getMemoMessage());

  
		  String toName =  memo.getToName();
		  String toGroupName = memo.getToGroupName();
		  if (toName.length() != 0 && toGroupName.length() != 0) {
			  toName = ", " + toName;
		  }
		  toName = toGroupName + toName;
		  
		  if (toName.length() > 0 && toName.endsWith(","))	
	    	toName = toName.substring(0,toName.length()-1);
	
		  int recipientMaxLen = 145;
		  String expandUrl = "memo.jsp?action=folders"
	   					   + "&memoID=" + request.getParameter("memoID") 
				  		   + "&sort=" + request.getParameter("sort")
						   + "&order=" + request.getParameter("order")
						   + "&folderID=" + request.getParameter("folderID")
						   + "&type=" + request.getParameter("type")
						   + "&recipientExpand=1";
		  boolean expandRecipient = (request.getParameter("recipientExpand") != null);
	  
		  boolean toShrinked = false;		  
		  if (!expandRecipient && toName.length() > recipientMaxLen) {
	    	toName = toName.substring(0, recipientMaxLen - 5) + " ... ";
		    toShrinked = true;
		  }
	
		  String ccName =  memo.getCcName();
		  String ccGroupName = memo.getCcGroupName();
		  if (ccName.length() != 0 && ccGroupName.length() != 0) {
			  ccName = ", " + ccName;
		  }
		  ccName = ccGroupName + ccName;
		  
		  if (ccName.length() > 0 && ccName.endsWith(","))	
	    	ccName = ccName.substring(0,ccName.length()-1);

		  boolean ccShrinked = false;		  
		  if (!expandRecipient && ccName.length() > recipientMaxLen) {
	    	ccName = ccName.substring(0, recipientMaxLen - 5) + " ... ";
		    ccShrinked = true;
		  }

	String user = memo.getFromUserID();
	String type_view = staffStudentUser.getUserType(request,response, memo.getFromUserID());

%>
<SCRIPT LANGUAGE="JavaScript">

function confirmDelete()      {
  return confirm("<%= messages.getString("click.OK.confirm") %>");
}

function confirmMove(obj1,obj2)	  {

  if (obj1.value != '')	{
    obj2.submit();
  }
  else  {
    alert("<%= messages.getString("memo.select.folder.move") %>");
  }
}

</SCRIPT>

<TR VALIGN="TOP" BGCOLOR="#DBDBDB">			  
  <TD CLASS="contentBgColorAlternate" style="font-family: Verdana, sans-serif; font-size: 11px;  8px; " COLSPAN="5">
    <table border="0" cellspacing = "0" cellpadding = "3" width="100%">
		<tr> 
        <td colspan=3 CLASS="contentBgColorAlternate" style="font-family: Verdana, sans-serif; font-size: 11px;  8px; " align = "center" width="94%"> 
          <%  
		  folderID = request.getParameter("folderID");

		  if (vFoldersID != null && vFoldersName != null && request.getParameter("isSearch") == null) {
            for (i=0; i<vFoldersID.size(); i++)	{
		      if (vFoldersID.get(i).equals(folderID)) {
	 	        viewFolderName = messages.getString(((String)vFoldersName.get(i)).toLowerCase());
            	break;
              }
            }
      	  }

      	  if (vUserFoldersID != null && vUserFoldersName != null) {
            for (i=0; i<vUserFoldersID.size(); i++) {
		      if (vUserFoldersID.get(i).equals(folderID)) {
                viewFolderName = (String)vUserFoldersName.get(i);
            	break;
              }
            }
      	  }	
%>
          <b><!--<a href="memo.jsp?action=folders&folderID=<%= request.getParameter("folderID") %>&sort=<%= request.getParameter("sort") %>&order=<%= request.getParameter("order") %>" onMouseOver="window.status='<%= messages.getString("view") %>';return true;"><%= viewFolderName %></a>--></b> 
<%        if ( !request.getParameter("folderID").equals("null") && !memo.getNext().equals("")	) {  %>
    <a href="memo.jsp?action=folders&memoID=<%= memo.getNext() %>&sort=<%= request.getParameter("sort") %>&type=<%=request.getParameter("type")%>&order=<%= request.getParameter("order") %>&folderID=<%= request.getParameter("folderID") %>" onMouseOver="window.status='<%= messages.getString("prev") %>';return true;"><%= messages.getString("prev") %></a>
	
<%        }  %>									 
    <b><%= messages.getString("memo.view.memo") %></b>
<% 	  	  if ( !request.getParameter("folderID").equals("null") && request.getParameter("folderID") != null && !memo.getPrev().equals("")	) {  %>
    <a href="memo.jsp?action=folders&memoID=<%= memo.getPrev() %>&sort=<%= request.getParameter("sort") %>&type=<%=request.getParameter("type")%>&order=<%= request.getParameter("order") %>&folderID=<%= request.getParameter("folderID") %>" onMouseOver="window.status='<%= messages.getString("next.small") %>';return true;"><%= messages.getString("next.small") %></a>
<%        }  %>		



        </td>
        <td CLASS="contentBgColorAlternate" width="3%" align = "right" valign="top"  style="font-family: Verdana, sans-serif; font-size: 11px;  8px; ">
		<A HREF="javascript:MM_openBrWindow('memo.jsp?action=print&memoID=<%= request.getParameter("memoID") %>&type=<%=request.getParameter("type")%>', 'viewMemo', 'resizable=yes,menubar,toolbar=no,scrollbars=yes,width=500,height=400')", 'viewMemo','resizable=yes,toolbar=no,scrollbars=yes,width=500,height=400')" onMouseOver="window.status='Large Memo';return true;"><img src="images/hyperlink/largepage.png" alt="Large Page" border="0"></A></td>
        
		<td CLASS="contentBgColorAlternate" width="3%" align = "right"  style="font-family: Verdana, sans-serif; font-size: 11px;  8px;">
			<A HREF="javascript:MM_openBrWindow('memo.jsp?action=print&memoID=<%= request.getParameter("memoID") %>&type=<%=request.getParameter("type")%>', 'viewMemo', 'resizable=yes,menubar=no,toolbar=no,scrollbars=yes,width=500,height=400')", 'viewMemo','resizable=yes,toolbar=no,scrollbars=yes,width=500,height=400')" onMouseOver="window.status='Print';return true;">
				<img SRC="images/hyperlink/print.png" BORDER="0" ALT="<%= messages.getString("library.print")%>" border="0">
			</A>
			<!--
			<A HREF="javascript:printReport('<%=memoID%>','<%= memo.getMemoFax() %>');" onMouseOver="window.status='Print';return true;">
				<img SRC="images/pdficon.gif" BORDER="0" ALT="<%= messages.getString("library.print")%>" border="0">
			</A>
			 -->
			<!-- A HREF="javascript:MM_openBrWindow('PdfGeneratorYahp?yahpUrl=memo.jsp?action=print_N_memoID=<%--=memoID--%>_N_type=<%--=memoType--%>', 'viewMemo', 'resizable=yes,menubar=no,toolbar=no,scrollbars=yes,width=500,height=400')", 'viewMemo','resizable=yes,toolbar=no,scrollbars=yes,width=500,height=400')" onMouseOver="window.status='Print';return true;">Test PDF</A -->  
		</td>
		
		<td CLASS="contentBgColorAlternate" width="3%" align = "right"  style="font-family: Verdana, sans-serif; font-size: 11px;  8px; ">
		<!--<A HREF="javascript:MM_openBrWindow('memo.jsp?action=print&memoID=<%= request.getParameter("memoID") %>&type=<%=request.getParameter("type")%>', 'viewMemo', 'resizable=yes,menubar=no,toolbar=no,scrollbars=yes,width=500,height=400')", 'viewMemo','resizable=yes,toolbar=no,scrollbars=yes,width=500,height=400')" onMouseOver="window.status='Print';return true;"><img SRC="images/hyperlink/ic_save2.gif" BORDER="0" ALT="<%= messages.getString("library.print")%>" border="0"></A>-->
		</td>
		  
      </tr>
    </table>
  </td>
</tr>
<!--			
<tr>
  <td CLASS="contentBgColorAlternate" style="font-family: Verdana, sans-serif; font-size: 11px;  8px; " align = "center" colspan = "4">
<%        if ( !request.getParameter("folderID").equals("null") && !memo.getNext().equals("")	) {  %>
    <a href="memo.jsp?action=folders&memoID=<%= memo.getNext() %>&sort=<%= request.getParameter("sort") %>&order=<%= request.getParameter("order") %>&folderID=<%= request.getParameter("folderID") %>" onMouseOver="window.status='<%= messages.getString("prev") %>';return true;"><%= messages.getString("prev") %></a>
	
<%        }  %>									 
    <b><%= messages.getString("memo.view.memo") %></b>
<% 	  	  if ( !request.getParameter("folderID").equals("null") && request.getParameter("folderID") != null && !memo.getPrev().equals("")	) {  %>
    <a href="memo.jsp?action=folders&memoID=<%= memo.getPrev() %>&sort=<%= request.getParameter("sort") %>&order=<%= request.getParameter("order") %>&folderID=<%= request.getParameter("folderID") %>" onMouseOver="window.status='<%= messages.getString("next.small") %>';return true;"><%= messages.getString("next.small") %></a>
<%        }  %>				 
  </td>
</tr>-->
<form name="moveToFolder2" action="servlet/Memo?action=move" method="post">
<table width="100%"  border="0" cellpadding="0" cellspacing="0" bordercolor="#EFEFEF">
  <tr>
    <td></td>
  </tr>
  <TR VALIGN="TOP" BGCOLOR="#DBDBDB">
    <TD CLASS="contentBgColorAlternate" COLSPAN="4" ALIGN = "LEFT"><div align="center">
    <% if (request.getParameter("type").equals("Y")){%>
    <img src="images/hyperlink/letter_head[1].GIF"  width=600 height="87" /> 
    <%} else if(request.getParameter("type").equals("N")) {%>
   <img src="images/hyperlink/letter_head2[1].GIF"  width=600 height="87" /> 
    <%}else{%>
    <img src="images/hyperlink/letter_head3[1].GIF"  width=600 height="83" /> 
      <%}%>
    
  </div></td>
  </tr>
  <TR VALIGN="TOP" BGCOLOR="#DBDBDB">
    <TD CLASS="contentBgColorAlternate" COLSPAN="4" ALIGN = "LEFT">
      <!--a href="transfer.jsp?memoID=<%= request.getParameter("memoID") %>&memoClobID=<%= memo.getMemoClobID() %>" onMouseOver="window.status='To Email';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_toemail.gif\" BORDER=\"0\" ALT=\"To Email\">" : "To Email"%></a -->
      <a href="memo.jsp?action=reply&type=<%=request.getParameter("type")%>&memoID=<%= request.getParameter("memoID") %>&folderID=<%= request.getParameter("folderID") %>" onMouseOver="window.status='<%= messages.getString("email.reply") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_reply.gif\" BORDER=\"0\" ALT=\"Reply\">" : messages.getString("email.reply") %></a>
      <a href="memo.jsp?action=replyAll&type=<%=request.getParameter("type")%>&memoID=<%= request.getParameter("memoID") %>&folderID=<%= request.getParameter("folderID") %>" onMouseOver="window.status='<%= messages.getString("email.replyall") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_replyall.gif\" BORDER=\"0\" ALT=\"Reply All\">" : messages.getString("email.replyall") %></a>
      <a href="memo.jsp?action=forward&type=<%=request.getParameter("type")%>&memoID=<%= request.getParameter("memoID") %>&clearAttach=yes&folderID=<%= request.getParameter("folderID") %>" onMouseOver="window.status='<%= messages.getString("email.forward") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_forward.gif\" BORDER=\"0\" ALT=\"Forward\">" : messages.getString("email.forward") %></a>
<%	  	  if (folderID.equals("2"))	 { %>
      <a href="memo.jsp?action=sendagain&type=<%=request.getParameter("type")%>&memoID=<%= request.getParameter("memoID") %>&clearAttach=yes&folderID=<%= request.getParameter("folderID") %>" onMouseOver="window.status='<%= messages.getString("send.again") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_sendagain.gif\" BORDER=\"0\" ALT=\"Send Again\">" : messages.getString("send.again") %></a>
<%        }  			

		  if (memo.getIsWorkFlow() == 0) {
	        if (showIcon) {
%>  
      <a href="Memo?action=delete&type=<%=request.getParameter("type")%>&memoID=<%= request.getParameter("memoID") %>&folderID=<%= request.getParameter("folderID") %>" onClick="return confirmDelete();" onMouseOver="window.status='Delete';return true;"><IMG SRC="images/system/ic_delete.gif" BORDER="0" ALT="Delete"></a>
<%          }
		    else   { 
%>
      <a href="Memo?action=delete&type=<%=request.getParameter("type")%>&memoID=<%= request.getParameter("memoID") %>&folderID=<%= request.getParameter("folderID") %>" onClick="return confirmDelete();" onMouseOver="window.status='<%= messages.getString("delete") %>';return true;"><%= messages.getString("delete") %></a>
<%        
            }
          }
%>		  		      
      <select style="font-family: Verdana, sans-serif; font-size: 11px;  8px; border:#003399 1 solid position:relative;left:0;height:20;top:0;" name="moveFolderID" onChange="javascript:confirmMove(document.moveToFolder2.moveFolderID,document.moveToFolder2);" >    
        <option value="" SELECTED><%= messages.getString("memo.move.folder") %>:
<%
          for (ii=0; ii<vMemoFoldersID.size(); ii++)     {
	    	if (ii != 3 && (memo.getIsWorkFlow() == 0 || (memo.getIsWorkFlow() == 1 && !vMemoFoldersID.get(ii).equals("3"))) )	   {
%>
        <option value="<%= vMemoFoldersID.get(ii) %>"><%= messages.getString(((String)vMemoFoldersName.get(ii)).toLowerCase()) %>
<%
            }
          }
		  if (vMemoUserFoldersID.size() > 0){
%>
       <!-- <OPTION VALUE="">-------------------------</OPTION>-->
<%
	   	  }
          for (ii=0; ii<vMemoUserFoldersID.size(); ii++)         {
%>
      <!--  <option value="<!--%= vMemoUserFoldersID.get(ii) %>"><!--%= vMemoUserFoldersName.get(ii) %>-->
<%        }  %>
      </select><a href="javascript:void(window.open('includes/view.htm','approve', 'height=300,width=800,menubar=no,toolbar=no,scrollbars=yes'))" class="style13"><img src="images/hyperlink/info.png" alt="Clik here for information" width="32" height="32"   border=0>Click Me</a>    </td>
  </tr>


  </td>
  </tr>
</table>

  <input type="hidden" name="folderID" value="<%= request.getParameter("folderID") %>">
  <input type="hidden" name="memoID" value="<%= request.getParameter("memoID") %>">
</form>
      
      <table width="100%"  border="0" cellpadding="3" cellspacing="0" bordercolor="#E9E9E9">

<%

if (conn!=null)
	{
	String sql = null;
	
	if (type_view.equals("STAFF"))
	sql	=		  " SELECT DM_DEPT_DESC, SS_SERVICE_DESC, USERTYPE "+
	              " FROM STAFF_MAIN,SERVICE_SCHEME,DEPARTMENT_MAIN,CMSUSERS_VIEW "+
				  " WHERE SM_JOB_CODE = SS_SERVICE_CODE AND DM_DEPT_CODE = SM_DEPT_CODE AND SM_APPS_USERNAME=LOGIN_USERNAME AND userid = '" + memo.getFromUserID() + "'";
	else if (type_view.equals("STUDENT"))
	sql	=		  " SELECT DM_DEPT_DESC, SM_STUDENT_ID, USERTYPE "+
	              " FROM STUDENT_MAIN,DEPARTMENT_MAIN,CMSUSERS_VIEW "+
				  " WHERE DM_DEPT_CODE = SM_FACULTY_CODE AND SM_STUDENT_ID=LOGIN_USERNAME AND userid = '" + memo.getFromUserID() + "'";
	else if (type_view.equals("EXTERNAL"))
	sql	=		  " SELECT USERNAME, FIRSTNAME,USERID "+
	              " FROM USERS "+
				  " WHERE userid = '" + memo.getFromUserID() + "'";
	try
		{
		pstmt = conn.prepareStatement(sql);
		rset = pstmt.executeQuery ();
		if (rset.next())
			{
			department = rset.getString (1);
			position = rset.getString (2);
			type = rset.getString (3);
			}
		//pstmt.close ();
		}
	catch (SQLException e)
		{ out.println ("Error : " + e.toString ()); }
		finally {
		try {
			if (rset != null) rset.close();
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
		}
		catch (Exception e) { }
	}
}
%>


<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
   <TD CLASS="contentBgColorAlternate" COLSPAN="6" ALIGN="RIGHT">  </TR>
<TR VALIGN="TOP" BGCOLOR="#DBDBDB">

  </TR>
<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  <TD CLASS="contentBgColorAlternate" COLSPAN="3" ALIGN="RIGHT">&nbsp;</TD>
  <TD width="98%" COLSPAN="3" ALIGN="RIGHT" CLASS="contentBgColorAlternate"><div align="left">
    
    <%       
		  if ((memo.getPriority()) != null) {
		    String priority = memo.getPriority();			      
			Object variable[] = new Object[1];
			variable[0] = priority;
			  
			if (variable[0].equals("0"))  {  
			  variable[0] = messages.getString("high.priority"); 
%>
					<font color=red><%= messages.getString("memo.priority.status",variable) %></font> 
<%    	    }	
			else {	    
              if (variable[0].equals("2"))  {	
			    variable[0] = messages.getString("low.priority"); 
%>
				     <%= messages.getString("memo.priority.status",variable) %>
<%	    
		 	  }
			}
		  }
%></div>
</TR>
<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  <TD CLASS="contentBgColorAlternate" COLSPAN="3" ALIGN="RIGHT">
    <div align="left"><span class="style13"><%= messages.getString("memo.date") %> </span></div></TD>
  <TD CLASS="contentBgColorAlternate" COLSPAN="3" ALIGN="RIGHT">
        <div align="left"><%= memoFilename %> </div>  </TR>

<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  <TD CLASS="contentBgColorAlternate" COLSPAN="3" ALIGN="RIGHT">
     <div align="left"><span class="style13"><%= messages.getString("memo.from") %></span></div></TD>
  <TD CLASS="contentBgColorAlternate" COLSPAN="3" ALIGN="RIGHT">
    <div align="left">
      <% if (type_view != null && type_view.equals("STAFF")) {%>
        <span class="style13"><%= memo.getFromName() %></span><span class="style1"><br>
          </span><%=position%><br /><%=department%>
        <%}else if (type_view != null && type_view.equals("STUDENT")){%>
        <span class="style7"><%= memo.getFromName() %></span><br>
       <span class="style3"><%=position%>,<%=department%>  </span>
        <%}else {%>
        <span class="style5"><%= position %></span><br>
        <%}%> 
    </div></TD>
</TR>

<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  <TD CLASS="contentBgColorAlternate" COLSPAN="3" ALIGN="RIGHT">
    <div align="left"><span class="style13"><%= messages.getString("memo.to") %></span></div></TD>
    <TD CLASS="contentBgColorAlternate" COLSPAN="3" ALIGN="RIGHT"><div align="left"><span class="style13">
      <%= toName %>    
      <% if (toShrinked) { %>
      <a href="<%=expandUrl%>"><IMG SRC="images/system/next.gif" BORDER="0" ALT="Show the rest of the recipients"></a>
      <% } %>
      &nbsp;
      </span></div></TD>
</TR>

<% 		  if (memo.getMemoFrom().trim().length() > 0) { %>
<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  <TD CLASS="contentBgColorAlternate" COLSPAN="3" ALIGN="RIGHT">
    <div align="left"><span class="style13"><%= messages.getString("memo.respond.to") %>  </span></div></TD>
  
  <TD CLASS="contentBgColorAlternate" COLSPAN="3" ALIGN="RIGHT">
    <div align="left" class="style13"><%= memo.getMemoFrom() %></div></TD>
</TR>
<% 		  }  %>  

<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  <TD CLASS="contentBgColorAlternate" COLSPAN="3" ALIGN="RIGHT">
    <div align="left"><span class="style13"><%= messages.getString("memo.cc") %>    </span></div></TD>
  <TD CLASS="contentBgColorAlternate" COLSPAN="3" ALIGN="RIGHT">
    <div align="left"><span class="style13"><%= ccName %><br>    
      <% if (ccShrinked) { %>
          <a href="<%=expandUrl%>"><IMG SRC="images/system/next.gif" BORDER="0" ALT="Show the rest of the recipients"></a>
        <% } %>
    </span></div></TD>
</TR>

<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  <TD CLASS="contentBgColorAlternate" COLSPAN="3" ALIGN="RIGHT">
    <div align="left"><B><%= messages.getString("memo.subject") %> </B> </div></TD>
  
  <TD COLSPAN="1" ALIGN="LEFT" bgcolor="#DBDBDB" CLASS="contentBgColorAlternate"><strong>
    <%= memo.getMemoFax() %>&nbsp;
  </strong></TD>
</TR>

<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  <TD CLASS="contentBgColorAlternate" COLSPAN="3" ALIGN="RIGHT">
    <div align="left"><B><%= messages.getString("memo.status") %> </B> </div></TD>
  <TD CLASS="contentBgColorAlternate" COLSPAN="1" ALIGN="LEFT">
<%
		  
		  while (stMemoFlags.hasMoreTokens())          {
		    memoFilename = stMemoFlags.nextToken();
			if (memoFilename.equals("Please Call Back"))
			  memoFilename = messages.getString("memo.please.call.back");
			else if	(memoFilename.equals("Returning Your Call"))
			  memoFilename = messages.getString("memo.return.call");
			else if	(memoFilename.equals("FYI"))
			  memoFilename = messages.getString("memo.fyi");
			else  if (memoFilename.equals("Urgent"))
			  memoFilename = messages.getString("memo.urgent");

			memoFlag += memoFilename + ", ";
          }
		  if (memoFlag.length() > 0)
		    memoFlag = memoFlag.substring(0,memoFlag.length()-2);
%>
		<%= memoFlag %>
  &nbsp;</TD>
</TR>

<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  <TD CLASS="contentBgColor" COLSPAN="3" ALIGN="RIGHT">
    <div align="left"><B><%= messages.getString("memo.message") %> </B> </div></TD>
  <TD COLSPAN="1" ALIGN="LEFT" bgcolor="#DBDBDB" CLASS="contentBgColor">
    <div align="justify">
        <span class="style11">
        <% 		  session.setAttribute("memoID", request.getParameter("memoID"));  %>
        <%= memoMessage %>        </span>&nbsp;<br>
  <br>
  <span class="style9">This is a computer generated document and no signature is required.</span> </div></TD>
</TR>

<!-- START : COMMENTED BY AIDYAZIZISYAHMI ON 2010-06-24 AS REQUESTED BY USER
<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  <TD CLASS="contentBgColorAlternate" COLSPAN="3" ALIGN="RIGHT">
    <div align="left"><B><%--= messages.getString("memo.attachments") --%></B> </div></TD>
  <TD CLASS="contentBgColorAlternate" COLSPAN="1" ALIGN="LEFT">
<%--		  if ( memo.getMemoTel().trim().length() < 1 || !memo.getMemoTel().startsWith(",") || memo.getMemoTel().equals(","))  {  --%>
		   <%--= messages.getString("email.none") --%>&nbsp;
<%--
		  }
		  else  {
		   stMemoFlags = new StringTokenizer(memo.getMemoTel(),",");
		   stMemoPhysicalFileName = new StringTokenizer(memo.getMemoPhysicalFileName(),",");
		   while (stMemoFlags.hasMoreTokens()) {
		    memoMessage = stMemoFlags.nextToken();
			memoFilename = stMemoPhysicalFileName.nextToken();
--%>
    <a href="<%--= TvoContextManager.generateFolderName(request)--%>/memo/<%--= memoFilename.trim() --%>" target="memoAttachment" onMouseOver="window.status='<%--= messages.getString("view") --%>';return true;"><%--= memoMessage --%></a><BR>
		   <%--
		   }
		  }
		--%>    </TD>
      </TR>
      
END : COMMENTED BY AIDYAZIZISYAHMI ON 2010-06-24 AS REQUESTED BY USER  -->
  
</table>
      <table width="100%"  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <th scope="col"><form name="moveToFolder" action="servlet/Memo?action=move" method="post">
        <TD CLASS="contentBgColorAlternate" COLSPAN="4" ALIGN="LEFT">
            <!--a href="transfer.jsp?memoID=<%= request.getParameter("memoID") %>&memoClobID=<%= memo.getMemoClobID() %>" onMouseOver="window.status='To Email';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_toemail.gif\" BORDER=\"0\" ALT=\"To Email\">" : "To Email"%></a -->
            <a href="memo.jsp?action=reply&type=<%=request.getParameter("type")%>&memoID=<%= request.getParameter("memoID") %>&folderID=<%= request.getParameter("folderID") %>" onMouseOver="window.status='<%= messages.getString("email.reply") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_reply.gif\" BORDER=\"0\" ALT=\"Reply\">" : messages.getString("email.reply") %></a>
            <a href="memo.jsp?action=replyAll&type=<%=request.getParameter("type")%>&memoID=<%= request.getParameter("memoID") %>&folderID=<%= request.getParameter("folderID") %>" onMouseOver="window.status='<%= messages.getString("email.replyall") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_replyall.gif\" BORDER=\"0\" ALT=\"Reply All\">" : messages.getString("email.replyall") %></a>
		  	<a href="memo.jsp?action=forward&type=<%=request.getParameter("type")%>&memoID=<%= request.getParameter("memoID") %>&type=<%=request.getParameter("type")%>&clearAttach=yes&folderID=<%= request.getParameter("folderID") %>" onMouseOver="window.status='<%= messages.getString("email.forward") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_forward.gif\" BORDER=\"0\" ALT=\"Forward\">" : messages.getString("email.forward") %></a>
<%

  if (folderID.equals("2"))	 { %>
    <a href="memo.jsp?action=sendagain&type=<%=request.getParameter("type")%>&memoID=<%= request.getParameter("memoID") %>&clearAttach=yes&folderID=<%= request.getParameter("folderID") %>" onMouseOver="window.status='<%= messages.getString("send.again") %>';return true;"><%= showIcon ? "<IMG SRC=\"images/system/ic_sendagain.gif\" BORDER=\"0\" ALT=\"Send Again\">" : messages.getString("send.again") %></a>

<%
  }

%>



<%

  if (memo.getIsWorkFlow() == 0)
  {
   if (showIcon) {
%>  
          <a href="Memo?action=delete&memoID=<%= request.getParameter("memoID") %>&folderID=<%= request.getParameter("folderID") %>" onClick="return confirmDelete();" onMouseOver="window.status='Delete';return true;"><IMG SRC="images/system/ic_delete.gif" BORDER="0" ALT="Delete"></a>
<% } else { %>
          <a href="Memo?action=delete&memoID=<%= request.getParameter("memoID") %>&folderID=<%= request.getParameter("folderID") %>" onClick="return confirmDelete();" onMouseOver="window.status='<%= messages.getString("delete") %>';return true;"><%= messages.getString("delete") %></a>
<% }
  }
%>		  		  
                <select name="moveFolderID" onChange="javascript:confirmMove(document.moveToFolder.moveFolderID,document.moveToFolder);" style="font-family: Verdana, sans-serif; font-size: 11px;  8px; ">
                <option value="" SELECTED><%= messages.getString("memo.move.folder") %>:
                <%
                  for (ii=0; ii<vMemoFoldersID.size(); ii++)
                  {
			       if (ii != 3 && (memo.getIsWorkFlow() == 0 || (memo.getIsWorkFlow() == 1 && !vMemoFoldersID.get(ii).equals("3"))) )
				   {
                    %>
                  <option value="<%= vMemoFoldersID.get(ii) %>"><%= messages.getString(((String)vMemoFoldersName.get(ii)).toLowerCase()) %>
                    <%
				    }
                  }
						 if (vMemoUserFoldersID.size() > 0){
				 %>
			      <OPTION VALUE="">-------------------------</OPTION>
				 <%
				 }
                  for (ii=0; ii<vMemoUserFoldersID.size(); ii++)
                  {
                    %>
                    <option value="<%= vMemoUserFoldersID.get(ii) %>"><%= vMemoUserFoldersName.get(ii) %></option>
                    <%
                  }
                %>
                </select>
        </TD>
			<input type="hidden" name="folderID" value="<%= request.getParameter("folderID") %>">
            <input type="hidden" name="memoID" value="<%= request.getParameter("memoID") %>">
      </form>
      
<%
    }
  }
} %>
	</td>
	</tr>
</table>
<% } else { %>
		<font color="#990000" size="2" face="Arial">Please 
		do not try to access other person's memo....</font> 
<% }
}
catch (Exception e) { }
finally {
	try {
		if (conn != null) conn.close();
	}
	catch (Exception e) {  }
}
%>
