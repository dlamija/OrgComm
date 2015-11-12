<%@ page import="java.util.StringTokenizer, java.util.Vector" %>
<jsp:useBean id="beanMemoCheck" scope="request" class="ecomm.bean.MemoMemo" />
<%
beanMemoCheck.initTVO(request);


Vector memoCount = null;

if (memos)
{
     
  if (userID != null)
  {
    memoCount = beanMemoCheck.showModule(userID, "Memo", "check");
      
    if (memoCount != null)
    {
      %>
      <%= memoCount.get(0) %>
      <%
    }
  }
}
else {
    out.println("-");
}

%>
