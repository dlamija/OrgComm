<%@ page import="common.*,ecomm.bean.*,java.util.*,tvo.TvoConstants" %>
<jsp:useBean id="beanMiddleForums" scope="request" class="ecomm.bean.ForumsForums" />
<jsp:useBean id="beanMiddleForumsACL" scope="request" class="ecomm.bean.ACL" />
<%@ page import="java.util.Hashtable,java.util.Locale" %>
<jsp:useBean id="beanPersonal" scope="request" class="ecomm.bean.PersonalPersonal" />

<%
Hashtable userMiddleForumsACL, groupMiddleForumsACL;
String userID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
beanMiddleForums.initTVO(request);
beanMiddleForumsACL.initTVO(request);

userMiddleForumsACL = beanMiddleForumsACL.getRights(userID, "Forums", "User");
groupMiddleForumsACL = beanMiddleForumsACL.getRights(userID, "Forums", "Group");

if ( (userMiddleForumsACL.containsKey("view") && userMiddleForumsACL.get("view").equals("1") ) ||
   (groupMiddleForumsACL.containsKey("view") &&  groupMiddleForumsACL.get("view").equals("1")) )
{

%>

<%

beanPersonal.initTVO(request);
Messages messages = Messages.getMessages(request);


String language = (String)TvoContextManager.getAttribute(request, "System.language");

String contentTitleFont = "contentTitleFont";
if (language.equals("zh") || language.equals("ja"))
  contentTitleFont = "contentTitleGlyphFont";


// Module Manager - Personal
if ( ModuleManager.isEnabled(request, ModuleManager.MODULE_PERSONAL) ) {
%>
                  <!-- Forum Messages Main Content Box START -->
                  <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
                    <TR VALIGN="MIDDLE">
                      <TD HEIGHT="22" BACKGROUND="images/system/strap.gif"><FONT   COLOR="#FFD553"><FONT   COLOR="#FFD752"><IMG SRC="images/system/blank.gif" WIDTH="20" HEIGHT="5"></FONT></FONT><a href="" onclick="toggleBlock('middleforums'); return false"><FONT COLOR="#FFCF63" CLASS="<%= contentTitleFont %>"><%= messages.getString("forums.messages") %></FONT></A></TD>
                    </TR>
                  </TABLE>
                  <DIV id="middleforums">
                  <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
                    <TR>
                      <TD BGCOLOR="#EFEFEF" VALIGN="TOP" CLASS="contentBgColor"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="10"></TD>
                    </TR>
                    <TR>
                      <TD BGCOLOR="#EFEFEF" VALIGN="TOP" CLASS="contentBgColor">
                        <UL>

<%
String country = (String)TvoContextManager.getAttribute(request, "System.country");
String dateFormat = (String)TvoContextManager.getAttribute(request,"System.dateFormat");
Locale currentLocale = new Locale(language,country);


int resultsShown=0, searchIndex;

if ( (userMiddleForumsACL.containsKey("view") && userMiddleForumsACL.get("view").equals("1") ) ||
   (groupMiddleForumsACL.containsKey("view") &&  groupMiddleForumsACL.get("view").equals("1")) ) {

  if (userID != null) {

    CommonObject forumSetting = (CommonObject) beanPersonal.getForum(request, userID);
    Vector searchResults;
    Vector vSearchTopicID=null, vSearchResponseID=null;
		String forumName = "";

  	int topicIDSize=1, responseIDSize=1, 
        topicLimit = Integer.parseInt( ((String)forumSetting.getObj("middleForumTopicLimit")).trim()), 
        responseLimit = Integer.parseInt( ((String)forumSetting.getObj("middleForumResponseLimit")).trim());

    searchResults = (Vector)beanMiddleForums.search(userID, "", "0", "topicIDresponseID", "desc");



    if (searchResults != null && searchResults.size() > 0) {
      searchResults.removeElementAt(2);
      vSearchTopicID = (Vector)searchResults.get(0);
      vSearchResponseID = (Vector)searchResults.get(1);
	    topicIDSize = vSearchTopicID.size();
	    responseIDSize = vSearchResponseID.size(); 

      if (topicIDSize > topicLimit)
        topicIDSize = topicLimit;
      if (responseIDSize > responseLimit)
        responseIDSize = responseLimit;

	    for (searchIndex=0; searchIndex < topicIDSize; searchIndex++) {
        ForumsTopics Forums = (ForumsTopics) vSearchTopicID.get(searchIndex);
				forumName = beanMiddleForums.getForumName(Forums.getTopicID(),"topicID");
				
%><li><%= forumName %>: <a href="forums.jsp?action=topic&topicID=<%= Forums.getTopicID() %>" onMouseOver="window.status='<%= messages.getString("view") %>';return true;"><%= Forums.getSubject() %></a> (<%= CommonFunction.parseDate(dateFormat,currentLocale,Forums.getComposed(),TvoConstants.TIME_FORMAT_SHORT) %>) - <%= Forums.getAuthor() %></li><%
	    }
	    
      for (searchIndex=0; searchIndex < responseIDSize; searchIndex++) {
        ForumsResponses Forums2 = (ForumsResponses) vSearchResponseID.get(searchIndex);
				forumName = beanMiddleForums.getForumName(Forums2.getResponseID(),"responseID");
%><li><%= forumName %>: <a href="forums.jsp?action=response&responseID=<%= Forums2.getResponseID() %>" onMouseOver="window.status='<%= messages.getString("view") %>';return true;"><%= Forums2.getSubject() %></a> (<%= CommonFunction.parseDate(dateFormat,currentLocale,Forums2.getComposed(),TvoConstants.TIME_FORMAT_SHORT) %>) - <%= Forums2.getAuthor() %></LI><%
      }
      
      if (searchResults == null || searchResults.size() <= 0) {
%><LI><%= messages.getString("forums.no.post.no.topic") %></LI><%
      }
    }

    if (topicIDSize == 0 && responseIDSize == 0) {
%><LI><%= messages.getString("forums.no.topics.no.messages") %></LI><%
	  }
  }
}  
else
{
%><LI><%= messages.getString("forums.user.no.access") %></LI><% 
}
%>
                      </UL><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="5"></TD>
                    </TR>
                    <TR BGCOLOR="#EFEFEF">
                      <TD VALIGN="TOP" CLASS="contentBgColor"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="5"></TD>
                    </TR>
                  </TABLE>
                  </DIV>
	<SCRIPT>
		loadBox("middleforums");
	</SCRIPT>
                  <!-- Forum Messages Main Content Box END -->
<%
} } // Module Manager - Personal %>

