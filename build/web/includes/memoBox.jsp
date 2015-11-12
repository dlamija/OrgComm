<jsp:useBean id="beanMemoBox" scope="request" class="MemoMemo" />
<jsp:useBean id="beanMemoBoxACL" scope="request" class="ecomm.bean.ACL" />
<%@ page import="java.util.Vector, java.text.SimpleDateFormat, java.util.Date, java.text.ParsePosition" %>
<%@ page import="java.util.Hashtable" %>
<%
Hashtable userMemoACL=null, groupMemoACL=null;
String memoBoxUserID = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
String memoBoxModuleName = "Memo";
String memoBoxAction="view";

beanMemoBox.initTVO(request);
beanMemoBoxACL.initTVO(request);

userMemoACL = beanNewsBoxACL.getRights(memoBoxUserID, memoBoxModuleName, "User");
groupMemoACL = beanNewsBoxACL.getRights(memoBoxUserID, memoBoxModuleName, "Group");
%>
<%
Vector vFolderContents=null;
Vector vMemoID=null, vFromFirstName, vFromLastName, vMemoDatePosted, vIsMemoRead, vMemoSubject;
String memoDatePosted=null, memoSubject;
Date memoBoxDate;
SimpleDateFormat memoBoxSDF;
ParsePosition memoBoxPos=null;
int memoBoxIndex;


if ( (userMemoACL.containsKey("view") && userMemoACL.get("view").equals("1") ) || 
     (groupMemoACL.containsKey("view")&& groupMemoACL.get("view").equals("1")) ||
     (userMemoACL.containsKey("add")  && userMemoACL.get("add").equals("1") ) || 
     (groupMemoACL.containsKey("add") && groupMemoACL.get("add").equals("1")) )
{

  if (memoBoxUserID != null && memoBoxModuleName != null && memoBoxAction != null)
  {
    vFolderContents = beanMemoBox.getLatestMemos(memoBoxUserID, 5);
    if (vFolderContents != null && vFolderContents.size() > 0)
    {
      %>
      <UL>
      <%
      vMemoID = (Vector)vFolderContents.get(0);
      vFromFirstName = (Vector)vFolderContents.get(1);
      vFromLastName  = (Vector)vFolderContents.get(2);
      vMemoDatePosted = (Vector)vFolderContents.get(3);
      vIsMemoRead = (Vector)vFolderContents.get(4);
      vMemoSubject = (Vector)vFolderContents.get(5);

      for (memoBoxIndex=0; memoBoxIndex < vMemoID.size(); memoBoxIndex++)
      {
        memoBoxPos = new ParsePosition(0);
        memoBoxSDF = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        memoBoxDate = memoBoxSDF.parse((String)vMemoDatePosted.get(memoBoxIndex), memoBoxPos);
        memoBoxSDF = new SimpleDateFormat("dd MMM yyyy hh:mm:ss aa");
        memoDatePosted = memoBoxSDF.format(memoBoxDate);
	memoSubject = (String)vMemoSubject.get(memoBoxIndex);
        
	if (memoSubject.trim().length() > 0) {
	%>
        <LI>
        <a href="memo.jsp?action=folders&memoID=<%= vMemoID.get(memoBoxIndex) %>" onMouseOver="window.status='View';return true;"><%= memoSubject %></a>
	- <%= vFromFirstName.get(memoBoxIndex) %> <%= vFromLastName.get(memoBoxIndex) %>
        (<%= memoDatePosted %>, <%= vIsMemoRead.get(memoBoxIndex).equals("0") ? "Unread" : "Read" %>)
        </LI>
        <%
	} else {
	%>
        <LI>
        <a href="memo.jsp?action=folders&memoID=<%= vMemoID.get(memoBoxIndex) %>" onMouseOver="window.status='View';return true;"><%= vFromFirstName.get(memoBoxIndex) %> <%= vFromLastName.get(memoBoxIndex) %></a>
        (<%= memoDatePosted %>, <%= vIsMemoRead.get(memoBoxIndex).equals("0") ? "Unread" : "Read" %>)
        </LI>
	<%
	}
      }
      %>
      </UL>
      <%
    }
  }
  if (vMemoID == null || vMemoID.size() <= 0)
  {
    %>
    <UL>
    <LI><%= messages.getString("memo.no.memo.found") %></LI>
    </UL>
    <%
  }
}
else
{
  %>
  <UL><LI>
  <%= messages.getString("memo.user.no.access ") %>
  </LI></UL>
  <%
}
%>
