<%@ page import="common.*,ecomm.bean.*,java.util.*,tvo.TvoConstants" %>
<%@ page import="java.util.Hashtable,java.util.Locale" %>
<jsp:useBean id="beanPersonal" scope="request" class="ecomm.bean.PersonalPersonal" />

<jsp:useBean id="beanNews" scope="request" class="ecomm.bean.NewsNews" />
  <jsp:useBean id="beanNewsACL" scope="request" class="ecomm.bean.ACL" />

    <%
    Hashtable userNewsACL, groupNewsACL;
    String userID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
    String moduleName = "News";

    beanNews.initTVO(request,application);
    beanNewsACL.initTVO(request);

    userNewsACL = beanNewsACL.getRights(userID, moduleName, "User");
    groupNewsACL = beanNewsACL.getRights(userID, moduleName, "Group");

    if ( (userNewsACL.containsKey("view") && userNewsACL.get("view").equals("1") ) ||
       (groupNewsACL.containsKey("view") &&  groupNewsACL.get("view").equals("1")) )
    {
%>

<%
//String userID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
beanPersonal.initTVO(request);
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
                      <TD HEIGHT="22" BACKGROUND="images/system/strap.gif"><FONT COLOR="#FFD553"><FONT COLOR="#FFD752"><IMG SRC="images/system/blank.gif" WIDTH="20" HEIGHT="5"></FONT></FONT><a href="" onclick="toggleBlock('middlenews'); return false" onMouseOver="window.status='<%= messages.getString("latest.news") %>';return true;"><FONT COLOR="#FFCF63" CLASS="<%= contentTitleFont %>"><%= messages.getString("latest.news") %></FONT></a></TD>
                    </TR>
                  </TABLE>
                  <DIV id="middlenews">
                    <TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
                      <TR>
                        <TD BGCOLOR="#EFEFEF" VALIGN="TOP" CLASS="contentBgColor"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="10"></TD>
                      </TR>
                      <TR>
                        <TD BGCOLOR="#EFEFEF" VALIGN="TOP" CLASS="contentBgColor">
                        &nbsp;&nbsp;&nbsp;<B><A HREF="javascript:MM_openBrWindow('newsHeadline.jsp','newsHeadline','scrollbars=yes,status=no,width=600,height=400');" onMouseOver="window.status='<%= messages.getString("news.view.headline.news") %>';return true;"><%= messages.getString("news.view.headline.news") %></A></B>
                        </TD>
                      </TR>
                      <TR>
                        <TD BGCOLOR="#EFEFEF" VALIGN="TOP" ALIGN="CENTER" CLASS="contentBgColor">
                        <HR SIZE="1" WIDTH="95%">
                        </TD>                    
                      </TR>
                      <TR>
                        <TD BGCOLOR="#EFEFEF" VALIGN="TOP" CLASS="contentBgColor">
                          <UL>
<jsp:useBean id="beanMiddleNews" scope="request" class="ecomm.bean.NewsNews" />
<jsp:useBean id="beanMiddleNewsACL" scope="request" class="ecomm.bean.ACL" />
<%@ page import="java.util.Hashtable" %>
<%
Hashtable userMiddleNewsACL, groupMiddleNewsACL;

beanMiddleNews.initTVO(request);
beanMiddleNewsACL.initTVO(request);

userMiddleNewsACL = beanMiddleNewsACL.getRights(userID, "News", "User");
groupMiddleNewsACL = beanMiddleNewsACL.getRights(userID, "News", "Group");

int middleNewsIndex;
if ( (userMiddleNewsACL.containsKey("view") && userMiddleNewsACL.get("view").equals("1") ) || 
   (groupMiddleNewsACL.containsKey("view") &&  groupMiddleNewsACL.get("view").equals("1")) ) {
  if (userID != null) {
    String urlPrefix = "news.jsp?newsArticle=";

    CommonObject newsSetting = (CommonObject) beanPersonal.getNews(request, userID);
    Vector vViewNewsList = beanMiddleNews.viewNews("view","home","newsDatePosted","DESC",request, Integer.parseInt( ((String)newsSetting.getObj("middleNewsLimit")).trim()),1);

    if (vViewNewsList != null && vViewNewsList.size() > 0) {
      for (middleNewsIndex=0; middleNewsIndex <vViewNewsList.size()-1; middleNewsIndex++) {
	     NewsDB news = (NewsDB) vViewNewsList.get(middleNewsIndex );
%> <LI>
   <a href="<%= urlPrefix + news.getNewsID() %>" onMouseOver="window.status='<%= messages.getString("view") %>';return true;"><B><%= news.getNewsTitle() %></B></a><BR>
   <%= messages.getString("news.updated") %> <%= CommonFunction.parseDate(dateFormat,currentLocale,news.getNewsDatePosted(),TvoConstants.TIME_FORMAT_LONG)  %></LI><%   
      }
    }

    if (vViewNewsList == null || vViewNewsList.size() <= 0) {
%><LI><%= messages.getString("news.no.news.found") %></LI><%
    }
  }
}
else
{
  %><LI><%= messages.getString("news.user.no.access.view.news") %></LI>
  <%
}
%>
                        </UL><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="5"></TD>
                      </TR>
                      <TR ALIGN="RIGHT" BGCOLOR="#EFEFEF">
                        <TD VALIGN="TOP" CLASS="contentBgColor"><IMG SRC="images/system/blank.gif" WIDTH="5" HEIGHT="5"></TD>
                      </TR>
                    </TABLE>
                  </DIV>
<%
} // Module Manager - Personal %>

<SCRIPT>
  loadBox("middlenews");
</SCRIPT>

        <%
         }
        %>


