<%@ page import="java.util.StringTokenizer, java.io.File,tvo.*,ecomm.bean.*" %>
<jsp:useBean id="beanPersonal" scope="request" class="ecomm.bean.PersonalPersonal" />
<%
  beanPersonal.initTVO(request);
  int richEditActive = beanPersonal.getRichEdit(request, userID);
int i,j;


Vector vAttachList=null;
Vector vAttachListID=null;

StringTokenizer stReplyMemoFlags;
StringTokenizer stDraftAttach,stAttach;
String composeMemoAttach = "",composeMemoPhysicalName="";
String draftAttach1;

//String targetDir = TvoContextManager.getRealPath(application, request, "/memo/" + userID + "/attach_temp/");
//TvoSiteManager.createDirectory(new File(targetDir));

boolean pleaseCallBack=false, FYI=false, returningYourCall=false, urgent=false, displayUser=true;
String temp ="", memoMessage="",respondTo="";
//String memoMessage2="";

String[] dispRecipient = {"", "", ""};
String[] hiddenUserID  = {"", "", ""};
String[] hiddenGroupID = {"", "", ""};


String agent = request.getHeader("User-Agent");
  agent = agent.toLowerCase();
  int ind = agent.indexOf("msie");
  int ver = 0;
  if (ind != -1)
    ver = Integer.parseInt(agent.substring(ind + 5 ,ind + 6));
  else
    ver = 0;

  boolean ie6 = false;
  if (ver >= 6 && ind != -1)
    ie6 = true;


if ( (userMemoACL.containsKey("view") && userMemoACL.get("view").equals("1") ) ||
     (groupMemoACL.containsKey("view")&& groupMemoACL.get("view").equals("1")) ||
     (userMemoACL.containsKey("add")  && userMemoACL.get("add").equals("1") ) ||
     (groupMemoACL.containsKey("add") && groupMemoACL.get("add").equals("1")) ) {

   MemoDB memo = new MemoDB();
	{
		String tempMemoMessage = (String) TvoContextManager.getSessionAttribute(request, "Memo.Message");
		if (tempMemoMessage != null) {
			memoMessage = tempMemoMessage;
			//memoMessage2 = tempMemoMessage;
			TvoContextManager.removeSessionAttribute(request, "Memo.Message");
		}
	}
   
	 String pageAction = action;
	 String allUserIDSize = "16";
	 if (css.equals("default.css") || css.equals("style0.css") )
	   allUserIDSize = "15";

	 MemoPreferences memoPreferences = beanMemo.getMemoPreferences(userID);

  if (userID != null && moduleName != null && action != null) {
    vAttachList = new Vector();

    if ((action.equals("replyAll") || action.equals("sendagain") || action.equals("reply") || (action.equals("draft") || action.equals("forward")) && TvoContextManager.getSessionAttribute(request, "Memo.saveOutBox") == null)) {
      memo = beanMemo.getMemoContents(request.getParameter("memoID"),request);

		if (action.equals("draft") || action.equals("sendagain")) {
			dispRecipient[0] = memo.getDispToName();
			dispRecipient[1] = memo.getDispCcName();
			dispRecipient[2] = memo.getDispBccName();

			hiddenUserID[0] = memo.getToUserID();
			hiddenUserID[1] = memo.getCcUserID();
			hiddenUserID[2] = memo.getBccUserID();

			hiddenGroupID[0] = memo.getToGroupID();
			hiddenGroupID[1] = memo.getCcGroupID();
			hiddenGroupID[2] = memo.getBccGroupID();
		}
		
		if (action.equals("reply")) {
			if (!userID.equals(memo.getFromUserID())) {
				dispRecipient[0] = memo.getFromName();
				hiddenUserID[0]  = memo.getFromUserID();
			}
		}
		
		if (action.equals("replyAll")) {
			dispRecipient[0] = memo.getDispToName();
			dispRecipient[1] = memo.getDispCcName();
			hiddenUserID[0]  = memo.getToUserID();
			hiddenUserID[1]  = memo.getCcUserID();
			hiddenGroupID[0] = memo.getToGroupID();
			hiddenGroupID[1] = memo.getCcGroupID();
			
			if (!userID.equals(memo.getFromUserID())) {
				if (hiddenUserID[0].equals("") && hiddenGroupID[0].equals("")) {
					dispRecipient[0] = memo.getFromName();
					hiddenUserID[0]  = memo.getFromUserID();
				} else {
					dispRecipient[0] = memo.getFromName() + ", " + dispRecipient[0];
					hiddenUserID[0]  = memo.getFromUserID() + "," + hiddenUserID[0];
				}
			}
		}

        if (action.equals("draft") || action.equals("sendagain")) {
          // set body and sender from saved draft

          respondTo = memo.getMemoFrom();
          memoMessage = memo.getMemoMessage();
          //memoMessage2 = memo.getMemoMessage();
          composeMemoAttach =  memo.getMemoTel();
          composeMemoPhysicalName = memo.getMemoPhysicalFileName();
          
          stReplyMemoFlags = new StringTokenizer(memo.getMemoStatus(), ",");
          while (stReplyMemoFlags.hasMoreTokens()) {
              temp = stReplyMemoFlags.nextToken();
              if (temp.equals("Please Call Back"))
                  pleaseCallBack = true;
              if (temp.equals("FYI"))
                  FYI = true;
              if (temp.equals("Returning Your Call"))
                  returningYourCall = true;
              if (temp.equals("Urgent"))
                  urgent = true;
          }
        }
       else {
            // create body for reply
            memoMessage = "\n\n> ";

            //if (ie6 && (richEditActive != 0))
            //{
                 memoMessage += memo.getMemoMessage();
                memoMessage = CommonFunction.replaceString(memo.getMemoMessage(),"<P>","<P>> ");
                memoMessage = CommonFunction.replaceString(memoMessage,"<p>","<p>> ");

                if (memo.getMemoMessage().indexOf("<P>") == -1)
                {
                  memoMessage = "\n\n> ";
                  for (i=0; i < memo.getMemoMessage().length(); i++)
                  {
                    if (memo.getMemoMessage().charAt(i) == '\n')
                    {
                      memoMessage += "\n> ";
                    }
                    else
                      memoMessage += memo.getMemoMessage().charAt(i);
                  }
                  memoMessage = CommonFunction.ln2br(memoMessage);
                }
            //}
            /*else
            {
            memoMessage = CommonFunction.replaceString(memo.getMemoMessage(),"</p>","");
            memoMessage = CommonFunction.replaceString(memoMessage,"</P>","");
            memoMessage = CommonFunction.replaceString(memoMessage,"<P>","\n");
            memoMessage = CommonFunction.replaceString(memoMessage,"<p>","\n");
            memoMessage = CommonFunction.replaceString(memoMessage,"<BR>","\n");
            memoMessage = CommonFunction.replaceString(memoMessage,"<br>","\n");


            //String memoMessageStr = memo.getMemoMessage();
            String memoMessageStr = memoMessage;
            memoMessage = "";
            int length = memoMessageStr.length();
            for (i=0; i < length; i++)
            {
              if (memoMessageStr.charAt(i) == '\n')
                {
                    memoMessage += "\n> ";
                }
                else
                  memoMessage += memoMessageStr.charAt(i);
            }
            }*/
        }
    }


  }

//create list for javascript array;
%>

<script language="javascript" type="text/javascript" src="ckeditor/ckeditor.js"></script>

<SCRIPT LANGUAGE="JavaScript">

	function toggleLayer( whichLayer, altLayer )
	{
	  var elem, elem2, vis, vis2;
	  if( document.getElementById ) // this is the way the standards work
	  { 
		  elem = document.getElementById( whichLayer );
		  elem2 = document.getElementById( altLayer );
	  }
	  else if( document.all ) // this is the way old msie versions work
	  {
	      elem = document.all[whichLayer];
	      elem2 = document.all[altLayer];
	  }
	  else if( document.layers ) // this is the way nn4 works
	  {
		    elem = document.layers[whichLayer];
		    elem = document.layers[altLayer];
	  }
	  
	  vis = elem.style;
	  vis2 = elem2.style;

	  vis.display = 'block';
	  vis2.display = 'none';
	}

	function swapImage(proses){
		var image = document.getElementById("imageToSwap");
		var dropd = document.getElementById("dd");
		image.src = dropd.value;	
	};
	
function checkAttachedFile() {
<%
  if (ie6 && (richEditActive == 0))
  {
  %>
   //copyVisualToSource();
   toggle('html');
  <%
  }
  %>

 if (document.composeMemo.memoAttachAdd.value.replace(/ /g, "") == '') {
   alert("<%= messages.getString("email.browse.click") %>");
 } else {
   alert("This process may take a while. Please be patient and DO NOT REFESH this page");
   document.composeMemo.action= "servlet/Memo?action=upload&page=<%= pageAction %>&memoID=<%= request.getParameter("memoID") %>";
   getAllAttachList();
 }
}

function checkMemoForm(str) {
  //alert(view);
  <%
  if (ie6 && (richEditActive == 0))
  {
  %>
      //copyVisualToSource();
      toggle('html');
  <%
  }
  %>

	if (document.composeMemo.saveDraft[0] != null && document.composeMemo.saveDraft[0].checked)
	  document.composeMemo.action = str + "&isDraft=1";
	else
	  document.composeMemo.action= str;

  var memoFlagChecked = false;
  var obj = document.composeMemo;
  for (var i=0; i < obj.memoFlag.length; i++) {
    if (obj.memoFlag[i].checked) {
      memoFlagChecked = true;
      break;
    }
  }


  if (obj.userID_To.value == "" && obj.groupID_To.value == "") {
    alert("<%= messages.getString("memo.no.recipient") %>");
  }
  else if (obj.memoFax.value.replace(/ /g,"") == '') {
    alert("<%= messages.getString("memo.subject.required") %>");
    obj.memoFax.focus();
  }
  else if (document.getElementById('memoMessage').value.replace(/ /g,"") == '')
   alert ("<%= messages.getString("memo.message.required") %>");
  else
  {

  getAllAttachList();
  }
}

function getAllAttachList()
{
  <%
  if (ie6 && (richEditActive == 0))
  {
  %>
   toggle('html');
  <%
  }
  %>

 var fileNameList="";

 if (document.composeMemo.memoAttachList != null) {
  for (var i=0; i < document.composeMemo.memoAttachList.length;i++) {
   fileNameList = fileNameList + "," + document.composeMemo.memoAttachList.options[i].value;
  }

 }

 document.composeMemo.fileList.value = fileNameList;

 document.composeMemo.submit();
 
}
</SCRIPT>

<script language = "javascript">
<!--
	var recipientWin;
	
	function recipientPopup() {
		if (recipientWin == null || recipientWin.closed) {
			recipientWin = window.open('memorecipient.jsp', 'recipientPopup', 'width=600,height=450,resizable=yes,scrollbars=yes');
		}
		recipientWin.focus();
	}
	
	function getRecipient(idType, columnType) {
		var myFormField = eval("document.composeMemo." + idType + "_" + columnType);
		return(myFormField.value);
	}
	
	function updateRecipient(idType, columnType, newValue) {
		var myFormField = eval("document.composeMemo." + idType + "_" + columnType);
		myFormField.value = newValue;
	}
	
	function updateDisplay(columnType, newValue) {
		var myFormField = eval("document.composeMemo.dispRecipient" + columnType);
		myFormField.value = newValue;
	}
//-->
</script>





<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "includes/";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }



if (win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write('language="Javascript1.2"></scr' + 'ipt>');  
} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// --></script>
<table width="100%" border="0" cellpadding="3" cellspacing="1">
  <tr>
    <td>
    
    <!-- Form for Writing a Memo -->
    
	<form name="composeMemo" action="Memo?action=compose" method="post">
		<table width="100%">
			<tr>
				<td colspan="5"><input type="hidden" name="fileList" value=""></td>
			</tr>
			
			<TR VALIGN="TOP" CLASS="contentBgColor"><!--CLASS="contentBgColorAlternate"-->
			  	<TD COLSPAN="5"><img src="images/hyperlink/memoico.png">
			    	<B><span class="style13"><%= messages.getString("memo.compose.memo") %></span></B>  
			    </td>
			</tr>

<% 
	String[] arrName  = {"To", "CC", "BCC"};
	
	for (int index=0; index<3; index++) 
	{ 
		if (TvoContextManager.getSessionAttribute(request,"Memo.dispRecipient" + arrName[index]) != null) 
		{
			dispRecipient[index] = (String) TvoContextManager.getSessionAttribute(request,"Memo.dispRecipient" + arrName[index]);
			hiddenUserID[index]  = (String) TvoContextManager.getSessionAttribute(request,"Memo.userID_" + arrName[index]);
			hiddenGroupID[index] = (String) TvoContextManager.getSessionAttribute(request,"Memo.groupID_" + arrName[index]);
		}
%>
	
			<tr valign="TOP" CLASS="contentBgColorAlternate" bgcolor="#DBDBDB">
				<td class="contentBgColorAlternate" bgcolor='#D9F2FF' colspan="3" align="left">
					<input type="hidden" name="userID_<%=arrName[index]%>" value="<%=hiddenUserID[index]%>">
					<input type="hidden" name="groupID_<%=arrName[index]%>" value="<%=hiddenGroupID[index]%>">
					<img src="images/hyperlink/guest2.gif"><a href="javascript: recipientPopup();"><b><span class="style13"><%=arrName[index]%></span></b></a>
				</td>
				<td  CLASS="contentBgColorAlternate" bgcolor='#CCEEFF' colspan="1" align="left">
					<textarea  name="dispRecipient<%=arrName[index]%>" rows="2" cols="70" readonly style="font-family: Verdana, sans-serif; font-size: 11px;  8px; "><%=dispRecipient[index]%></textarea>
				</td>
			</tr>
<% } %>

			<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
			  <TD CLASS="contentBgColorAlternate" bgcolor='#D9F2FF' COLSPAN="3" ALIGN="left">
			    <B><span class="style13"><%= messages.getString("memo.respond.to") %> </span></B>
			  </td>
			  <TD CLASS="contentBgColorAlternate" bgcolor='#D9F2FF' style="font-family: Verdana, sans-serif; font-size: 11px;  8px; " COLSPAN="1" ALIGN="LEFT">
			    <input type="text" name="memoCompany" value="<% 
						if (TvoContextManager.getSessionAttribute(request,"Memo.respondTo") != null)
						{
						%><%= TvoContextManager.getSessionAttribute(request,"Memo.respondTo") %><%
						}
						else
						{
						%><%= respondTo %><%			
						}
						%>" size="30">
			    <BR>
			    [<%= messages.getString("memo.leave.blank") %>]
			  </td>
			</tr> 
			<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
			  <TD CLASS="contentBgColorAlternate" bgcolor='#D9F2FF'  COLSPAN="3" ALIGN="left">
			    <B><span class="style13"><%= messages.getString("memo.subject") %></span></B>
			  </td>
			  <TD CLASS="contentBgColorAlternate" bgcolor='#D9F2FF' style="font-family: Verdana, sans-serif; font-size: 11px;  8px; " COLSPAN="1" ALIGN="LEFT">
			    <input type="text" name="memoFax" style="font-family: Verdana, sans-serif; font-size: 11px;  8px; " value="<%
				 if (TvoContextManager.getSessionAttribute(request,"Memo.subject") != null)
				 {
				 %><%= TvoContextManager.getSessionAttribute(request,"Memo.subject") %><%
				 }	 
				 else
				 {
				 %><% 
			    if (action.equals("reply") || action.equals("replyAll"))
			            out.println("Re: " + memo.getMemoFax());
			    else if (action.equals("draft"))
			            out.println(memo.getMemoFax());
			    else if (action.equals("forward"))
				        out.println("Fwd: " + memo.getMemoFax());
				else if (action.equals("sendagain"))
				        out.println(memo.getMemoFax());
				else
			            out.println("");
				 }
				 %>" size="70" maxlength="255">
			  </td>
			</tr>
			
			<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
			  	<TD CLASS="contentBgColorAlternate" bgcolor='#D9F2FF' COLSPAN="3" ALIGN="left">
			    	<B><span class="style13"><%= messages.getString("memo.status") %></span></B>
				</td>
				<TD CLASS="contentBgColorAlternate" bgcolor='#D9F2FF' style="font-family: Verdana, sans-serif; font-size: 11px;  8px; " COLSPAN="1" ALIGN="LEFT">
  <%
  if (TvoContextManager.getSessionAttribute(request,"Memo.status") != null)
	{
     String statusList[] = (String[]) TvoContextManager.getSessionAttribute(request,"Memo.status");
	 for (i=0; i<statusList.length; i++)
	 {
	  if (statusList[i].equals("Please Call Back") )
	   pleaseCallBack = true;
	  else if (statusList[i].equals("FYI") )
	   FYI = true;
	  else if (statusList[i].equals("Returning Your Call") )
	   returningYourCall = true;
	  else if (statusList[i].equals("Urgent") )
	   urgent = true;
	 }
	}

  %>
    <input type="checkbox" name="memoFlag" value="Please Call Back" 
    <%= (pleaseCallBack) ? " CHECKED " : "" %>
    >
    <%= messages.getString("memo.please.call.back") %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="checkbox" name="memoFlag" value="FYI" 
    <%= (FYI) ? " CHECKED " : "" %>
    >
    <%= messages.getString("memo.fyi") %><br>
    <input type="checkbox" name="memoFlag" value="Returning Your Call" 
    <%= (returningYourCall) ? " CHECKED " : "" %>
    >
    <%= messages.getString("memo.return.call") %> &nbsp;&nbsp;&nbsp;
    <input type="checkbox" name="memoFlag" value="Urgent" 
    <%= (urgent) ? " CHECKED " : "" %>
    >
    <%= messages.getString("memo.urgent") %>
  </td>
</tr>
<!--% if (session.getAttribute("deptcode").equals("KEW1000") || session.getAttribute("deptcode").equals("PEN1000") || session.getAttribute("deptcode").equals("REK1000") || session.getAttribute("deptcode").equals("HEP1000")) { % -->

<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
	<TD CLASS="contentBgColorAlternate" bgcolor='#D9F2FF' COLSPAN="3" ALIGN="left">
		<b><span class="style13">Official</span></b> 
	</td>	
	<TD CLASS="contentBgColorAlternate" bgcolor='#D9F2FF' style="font-family: Verdana, sans-serif; font-size: 11px;  8px; " COLSPAN="1" ALIGN="LEFT"> 
            <strong><font color=red>  
            <input name="official" type="radio" value="N">
            No 
            <input name="official" type="radio" value="Y" checked="checked">
            Yes </font></strong>
    </td>
</TR>
            <!-- tr valign="top" bgcolor="#DBDBDB" >
            	<td class="contentBgColorAlternate" bgcolor='#D9F2FF' colspan="4" align="left">
					<input type=hidden name=official value=Y />&nbsp;
				</td>
			</tr -->
<!--% } else {%><input name="official" type="hidden" value="N"><!--% } % -->

		<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
			<TD CLASS="contentBgColorAlternate" bgcolor='#D9F2FF' COLSPAN="3" ALIGN="left">
				<b><span class="style13"><%= messages.getString("priority") %></span></b> 
			</td>	
			<TD CLASS="contentBgColorAlternate" bgcolor='#D9F2FF' style="font-family: Verdana, sans-serif; font-size: 11px;  8px; " COLSPAN="1" ALIGN="LEFT">
   
<% 
		   String priority = "";
			 if (memo.getPriority() !=null){
			   priority =memo.getPriority(); 
			 }
			 if (TvoContextManager.getSessionAttribute(request,"Memo.priority") != null) 
			   priority = (String)TvoContextManager.getSessionAttribute(request,"Memo.priority");
%>	   
				<select name="priority" style="font-family: Verdana, sans-serif; font-size: 11px;  8px; "> 
				<% if (priority.equals("") || priority==null && action.equals("sendagain") ) { %> 
					<option value="" selected><%= messages.getString("normal.priority") %>
				<% } else { %>
					<option value=""><%= messages.getString("normal.priority") %>
				<% } %>
		
				<% if (priority.equals("0") || action.equals("sendagain")) { %>
					<option value="0" selected><%= messages.getString("high.priority") %>
				<% } else { %>
					<option value="0"><%= messages.getString("high.priority") %>
				<% } %>
				
				<% if (priority.equals("2") || action.equals("sendagain")) { %>
					<option value="2" selected><%= messages.getString("low.priority") %>
				<% } else { %>
					<option value="2"><%= messages.getString("low.priority") %>
				<% } %>
			    </select>
 			</td>  	   
		</tr>

		<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
		  <TD CLASS="contentBgColorAlternate" bgcolor='#D9F2FF' style="font-family: Verdana, sans-serif; font-size: 11px;  8px; " COLSPAN="3" ALIGN="LEFT">&nbsp;</td>
		
		  <TD CLASS="contentBgColorAlternate" bgcolor='#D9F2FF' style="font-family: Verdana, sans-serif; font-size: 11px;  8px; " COLSPAN="1" ALIGN="LEFT">
		     <input type = "checkbox" name="saveOutBox" <%= (memoPreferences.getSaveOutGoing().equals("1") && TvoContextManager.getSessionAttribute(request,"Memo.saveOutBox") == null ) || (TvoContextManager.getSessionAttribute(request,"Memo.saveOutBox") != null && ((String)TvoContextManager.getSessionAttribute(request,"Memo.saveOutBox")).equals("1"))? " CHECKED" : "" %>> <%= messages.getString("memo.save.copy.outbox") %>
		  </td>
		</tr>

		<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
			<TD CLASS="contentBgColorAlternate" bgcolor='#D9F2FF' style="font-family: Verdana, sans-serif; font-size: 11px;  8px; " COLSPAN="3" ALIGN="LEFT">&nbsp;</td>
		  <TD CLASS="contentBgColorAlternate" bgcolor='#D9F2FF' style="font-family: Verdana, sans-serif; font-size: 11px;  8px; " COLSPAN="1" ALIGN="LEFT">
		     <input type = "checkbox" name="useSignature" <%= (memoPreferences.getSignatureFlag().equals("1") && TvoContextManager.getSessionAttribute(request,"Memo.saveOutBox") == null ) || (TvoContextManager.getSessionAttribute(request,"Memo.saveOutBox") != null && ((String)TvoContextManager.getSessionAttribute(request,"Memo.useSignature")).equals("1"))? " CHECKED" : "" %>> <%= messages.getString("email.use.signature") %>
		  </td>
		</tr>

		<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
		  <TD CLASS="contentBgColor" bgcolor='#B9E7FF' style="font-family: Verdana, sans-serif; font-size: 11px;  8px; " COLSPAN="4" ALIGN="LEFT">
		       <span class="style13"><b><%= messages.getString("memo.message") %></b></span>
		    </td>
		</tr>

		<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
		  <TD CLASS="contentBgColor" bgcolor='#D9F2FF' style="font-family: Verdana, sans-serif; font-size: 11px;  8px; " COLSPAN="4" ALIGN="center">
			
			<textarea class="input_text" COLS="40" ROWS="15" id="memoMessage" name="memoMessage" style="width:600; height:250">
				<%=memoMessage%>
			</textarea>
			 <!-- 
			  <script language="javascript1.2">
				editor_generate('memoMessage');
			  </script> 
			   -->
			<script type="text/javascript">
				CKEDITOR.replace( 'memoMessage' , { toolbar : 'umpLite' });
			</script>
		  </td>
		</tr>

<%-- <TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  <TD bgcolor='#D9F2FF' style="font-family: Verdana, sans-serif; font-size: 11px;  8px; " COLSPAN="3" ALIGN="left">
    <B><%= messages.getString("memo.save.copy.outbox") %></B>
  </td>
  <TD bgcolor='#D9F2FF' style="font-family: Verdana, sans-serif; font-size: 11px;  8px; " COLSPAN="1" ALIGN="LEFT">
  <%
	if ( memoPreferences.getSaveOutGoing().equals("1") || (TvoContextManager.getSessionAttribute(request,"Memo.saveOutBox") != null && TvoContextManager.getSessionAttribute(request,"Memo.saveOutBox").equals("1")))
	{
  %>
	 <input type="radio" name="saveOutBox" value="1" CHECKED>
     <%= messages.getString("yes") %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     <input type="radio" name="saveOutBox" value="0">
     <%= messages.getString("no") %>
  <%
	}
	else
	{
  %>
	 <input type="radio" name="saveOutBox" value="1">
     <%= messages.getString("yes") %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     <input type="radio" name="saveOutBox" value="0" CHECKED>
     <%= messages.getString("no") %>
  <%
    }
  %>
  </td>
</tr> --%>

<%
if (!action.equals("draft"))
{
	System.out.println("\tincludes/memoCompose.jsp \taction:"+action);

%>
<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  <TD CLASS="contentBgColor" bgcolor='#D9F2FF' style="font-family: Verdana, sans-serif; font-size: 11px;  8px; " COLSPAN="3" ALIGN="left">
    <B><%= messages.getString("memo.save.draft") %></B>
  </td>
     <TD CLASS="contentBgColor" bgcolor='#D9F2FF' style="font-family: Verdana, sans-serif; font-size: 11px; 8px; font-style: italic;" COLSPAN="1" ALIGN="LEFT">
	 <%
	   if ( TvoContextManager.getSessionAttribute(request,"Memo.saveDraft") != null 
			   && TvoContextManager.getSessionAttribute(request,"Memo.saveDraft").equals("1"))
	   {
	 %>
	    <input type="radio" name="saveDraft" value="1" onclick="javascript:toggleLayer('draftBtnDiv','sendBtnDiv');"  checked="checked">
        <%= messages.getString("yes") %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="radio" name="saveDraft" value="0" onclick="javascript:toggleLayer('sendBtnDiv','draftBtnDiv');" >
        <%= messages.getString("no") %>
	 <%
	   }
	   else
	   {
	 %>
        <input type="radio" name="saveDraft" value="1" onclick="javascript:toggleLayer('draftBtnDiv','sendBtnDiv');" >
        <%= messages.getString("yes") %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="radio" name="saveDraft" value="0" onclick="javascript:toggleLayer('sendBtnDiv','draftBtnDiv');" checked="checked">
        <%= messages.getString("no") %>
	<%
	   }
	%>
  &nbsp;&nbsp;&nbsp;&nbsp;*<span id="result_box"><span title="memo will not be sent if option save to draf is chosen" closure_hashcode_xf42xc="86"> Memo will not be   sent if  &quot;<strong>Save as Draft</strong>&quot; option is chosen</span></span></td>
</tr>
<%
}
else
{
%>
<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
	<td>
		<input type="hidden" name="saveDraft" value="0" />
	</td>
</tr>
<%
}
%>
<TR VALIGN="TOP" BGCOLOR="#DBDBDB">
  <TD CLASS="contentBgColorAlternate" COLSPAN="4" ALIGN="center">
  	<input type="hidden" name="dummy">
  		<% if (!action.equals("draft")) { %>
  		<table>
  			<tr>
  				<td>
  					<div id="sendBtnDiv" style="display: block;">
						<A HREF="javascript:checkMemoForm('Memo?action=compose&type=<%=request.getParameter("type")%>')" 
							onMouseOver="window.status='<%= messages.getString("memo.send") %>';return true;">
							<%= showIcon  ? "<IMG SRC=\"images/system/ic_send.gif\" BORDER=\"0\" ALT=\"Send\">" :  messages.getString("memo.send") %>
						</A>
					</div>
  				</td>
  				<td>
					<div id="draftBtnDiv" style="display: none; ">
						<A HREF="javascript:checkMemoForm('Memo?action=compose&type=<%=request.getParameter("type")%>')" 
							onMouseOver="window.status='<%= messages.getString("memo.send") %>';return true;">
							<%= showIcon  ? "<IMG SRC=\"images/system/ic_draft.gif\" BORDER=\"0\" ALT=\"Send\">" :  messages.getString("email.draft") %>
						</A>
					</div>
  				</td>
  				<td>
	  				<A HREF="memo.jsp?action=folders&folderID=1&type=${param.type}" onMouseOver="window.status='<%= messages.getString("cancel") %>';return true;">
						<%= showIcon ? "<IMG SRC=\"images/system/ic_cancel.gif\" BORDER=\"0\" ALT=\"Cancel\">" :  messages.getString("cancel") %>
					</A>
  				</td>
  			</tr>
  		</table>
		
		<% 
			}//end if (!action.equals("draft")) {
			else if (action.equals("draft")) 
  			{ 
  		%>
		<A HREF="javascript:checkMemoForm('Memo?action=compose&type=<%=request.getParameter("type")%>')" 
			onMouseOver="window.status='<%= messages.getString("memo.send") %>';return true;">
			<%= showIcon  ? "<IMG SRC=\"images/system/ic_send.gif\" BORDER=\"0\" ALT=\"Send\">" :  messages.getString("memo.send") %>
		</A>
		<A HREF="javascript:checkMemoForm('Memo?action=compose&type=<%=request.getParameter("type")%>&memoID=<%= request.getParameter("memoID") %>&isDraftSaved=1')" 
			onMouseOver="window.status='<%= messages.getString("email.draft") %>';return true;">
				<%= showIcon ? "<IMG SRC=\"images/system/ic_draft.gif\" BORDER=\"0\" ALT=\"Draft\">" : messages.getString("email.draft") %>
		</A>
		<A HREF="memo.jsp?action=folders&folderID=1&type=${param.type}" onMouseOver="window.status='<%= messages.getString("cancel") %>';return true;">
			<%= showIcon ? "<IMG SRC=\"images/system/ic_cancel.gif\" BORDER=\"0\" ALT=\"Cancel\">" :  messages.getString("cancel") %>
		</A>
		<% } //end else if (action.equals("draft"))  %>
  <BR>
  </td>
</tr>
</table>
</form>
<!-- End Form for Writing a Memo -->
<%
}

if (TvoContextManager.getSessionAttribute(request,"Memo.attachList") != null)
 TvoContextManager.removeSessionAttribute(request, "Memo.attachList");
if (TvoContextManager.getSessionAttribute(request,"Memo.attachListID") != null)
 TvoContextManager.removeSessionAttribute(request, "Memo.attachListID");


if (TvoContextManager.getSessionAttribute(request,"Memo.To") != null)
 TvoContextManager.removeSessionAttribute(request, "Memo.To"); 		    
if (TvoContextManager.getSessionAttribute(request,"Memo.Cc") != null)
 TvoContextManager.removeSessionAttribute(request, "Memo.Cc"); 	   
if (TvoContextManager.getSessionAttribute(request,"Memo.Bcc") != null)
 TvoContextManager.removeSessionAttribute(request, "Memo.Bcc");
if (TvoContextManager.getSessionAttribute(request,"Memo.respondTo") != null)
 TvoContextManager.removeSessionAttribute(request, "Memo.respondTo");  
if (TvoContextManager.getSessionAttribute(request,"Memo.subject") != null)
 TvoContextManager.removeSessionAttribute(request, "Memo.subject"); 
if (TvoContextManager.getSessionAttribute(request,"Memo.status") != null)
 TvoContextManager.removeSessionAttribute(request, "Memo.status");  
if (TvoContextManager.getSessionAttribute(request,"Memo.message") != null)
 TvoContextManager.removeSessionAttribute(request, "Memo.message");   
if (TvoContextManager.getSessionAttribute(request,"Memo.saveOutBox") != null)
 TvoContextManager.removeSessionAttribute(request, "Memo.saveOutBox");    
if (TvoContextManager.getSessionAttribute(request,"Memo.saveDraft") != null)
 TvoContextManager.removeSessionAttribute(request, "Memo.saveDraft"); 
if (TvoContextManager.getSessionAttribute(request,"Memo.priority") != null)
 TvoContextManager.removeSessionAttribute(request, "Memo.priority");

String[] arrName = {"To", "CC", "BCC"};
if (TvoContextManager.getSessionAttribute(request, "Memo.dispRecipientTo") != null) {
	for (int index=0; index<3; index++) {
		TvoContextManager.removeSessionAttribute(request, "Memo.dispRecipient" + arrName[index]);
		TvoContextManager.removeSessionAttribute(request, "Memo.userID_" + arrName[index]);
		TvoContextManager.removeSessionAttribute(request, "Memo.groupID_" + arrName[index]);
	}
}

%>
	</td>
  </tr>
</table>
