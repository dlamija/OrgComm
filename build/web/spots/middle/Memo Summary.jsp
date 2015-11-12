<%@ page import="common.*,ecomm.bean.*,java.util.*,tvo.TvoConstants" %>

<jsp:useBean id="beanPersonal" scope="request" class="ecomm.bean.PersonalPersonal" />
<jsp:useBean id="beanMiddleMemo" scope="request" class="ecomm.bean.MemoMemo" />
<jsp:useBean id="beanMiddleMemoACL" scope="request" class="ecomm.bean.ACL" />
<%@ page import="java.util.Vector, java.text.SimpleDateFormat, java.util.Date, java.text.ParsePosition" %>
<%@ page import="java.util.Hashtable" %>

<%
  Hashtable userMiddleMemoACL=null, groupMiddleMemoACL=null;
  String userID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
  beanPersonal.initTVO(request);
  beanMiddleMemo.initTVO(request);
  beanMiddleMemoACL.initTVO(request);
  userMiddleMemoACL = beanMiddleMemoACL.getRights(userID, "Memo", "User");
  groupMiddleMemoACL = beanMiddleMemoACL.getRights(userID, "Memo", "Group");
  if ( (userMiddleMemoACL.containsKey("view") && userMiddleMemoACL.get("view").equals("1") ) ||
     (groupMiddleMemoACL.containsKey("view") &&  groupMiddleMemoACL.get("view").equals("1")) )
  {
%>

<%
//String userID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
//beanPersonal.initTVO(request);
Messages messages = Messages.getMessages(request);
String language = (String)TvoContextManager.getAttribute(request, "System.language");
String country = (String)TvoContextManager.getAttribute(request, "System.country");
String dateFormat = (String)TvoContextManager.getAttribute(request,"System.dateFormat");
Locale currentLocale = new Locale(language,country);


String contentTitleFont = "contentTitleFont";
if (language.equals("zh") || language.equals("ja"))
  contentTitleFont = "contentTitleGlyphFont";

// Module Manager - Personal
if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_PERSONAL) ) {
%>
                  <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
                    <TR VALIGN="MIDDLE">
                      <TD HEIGHT="22" BACKGROUND="images/system/strap.gif"><FONT COLOR="#FFD553"><FONT COLOR="#FFD752"><IMG SRC="images/system/blank.gif" WIDTH="20" HEIGHT="5"></FONT></FONT><a href="" onclick="toggleBlock('middlememo'); return false" onMouseOver="window.status='<%= messages.getString("memo") %>';return true;"><FONT COLOR="#FFCF63" CLASS="<%= contentTitleFont %>"><%= messages.getString("memo") %></FONT></A>
                      </TD>
                    </TR>
                  </TABLE>
                  <DIV id="middlememo">
                  <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
                    <TR>
                      <TD BGCOLOR="#EFEFEF" VALIGN="TOP" CLASS="contentBgColor"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="10"></TD>
                    </TR>
                    <TR>
                      <TD BGCOLOR="#EFEFEF" VALIGN="TOP" CLASS="contentBgColor">
                        <UL>
<%
/*
Hashtable userMiddleMemoACL=null, groupMiddleMemoACL=null;

beanMiddleMemo.initTVO(request);
beanMiddleMemoACL.initTVO(request);

userMiddleMemoACL = beanMiddleMemoACL.getRights(userID, "Memo", "User");
groupMiddleMemoACL = beanMiddleMemoACL.getRights(userID, "Memo", "Group");
*/

Vector vFolderContents=null;
String memoDatePosted=null, memoSubject=null;
int middleMemoIndex;

if ( (userMiddleMemoACL.containsKey("view") && userMiddleMemoACL.get("view").equals("1") ) ||
     (groupMiddleMemoACL.containsKey("view") &&  groupMiddleMemoACL.get("view").equals("1")) ) {
  if (userID != null) {

    CommonObject memoSetting = (CommonObject) beanPersonal.getMemo(request, userID);
    vFolderContents = beanMiddleMemo.getLatestMemos(userID, Integer.parseInt( ((String)memoSetting.getObj("middleMemoLimit")).trim()));
																																		 
    if (vFolderContents != null && vFolderContents.size() > 0) {

      for (middleMemoIndex=0; middleMemoIndex < vFolderContents.size(); middleMemoIndex++) {
			  MemoDB memo =  (MemoDB) vFolderContents.get(middleMemoIndex);
        memoDatePosted = CommonFunction.parseDate(dateFormat,currentLocale,memo.getMemoDatePosted(),TvoConstants.TIME_FORMAT_LONG);
	      memoSubject = memo.getMemoFax();
        
%><LI><a href="memo.jsp?action=folders&memoID=<%= memo.getMemoID() %>&folderID=<%= memo.getMemoFolderID() %>" onMouseOver="window.status='<%= messages.getString("view") %>';return true;"><%= memoSubject %></a>
	- <%= memo.getName() %> 
  (<%= memoDatePosted %>, <%= memo.getIsMemoRead().equals("0") ? messages.getString("memo.unread.home") : messages.getString("memo.read.home") %>)
</LI><% 
      }
    }

    if (vFolderContents == null || vFolderContents.size() <= 0) {
%><LI><%= messages.getString("memo.no.memo.found") %></LI><%
    }
  }
}
else
{
  %><LI><%= messages.getString("memo.user.no.access") %></LI><%
}
%>
                      </UL><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="5"></TD>
                    </TR>
                    <TR ALIGN="RIGHT" BGCOLOR="#EFEFEF">
                      <TD VALIGN="TOP" CLASS="contentBgColor"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="5"></TD>
                    </TR>
                  </TABLE>
                  </DIV>
				  	<SCRIPT>
		loadBox("middlememo");
	</SCRIPT>

<%
} // Module Manager - Personal %>

<%
 }
%>
