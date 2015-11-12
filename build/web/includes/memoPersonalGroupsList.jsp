<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:useBean id="memoPersonalGroupList" class="ecomm.bean.MemoForm" scope="page" />
<jsp:useBean id="memoPersonalGroupSrvc" scope="request" class="ecomm.bean.MemoMemo" />

<% 
	String userId = (String)TvoContextManager.getSessionAttribute(request, "Login.userID");
	memoPersonalGroupSrvc.initTVO(request);
	memoPersonalGroupList.setMemoGroupList(memoPersonalGroupSrvc.getMemoGroupList(userId));
%>

<SCRIPT LANGUAGE="JavaScript">
	function confirmDelete(id)
	{
            document.viewGroup.action = 'Memo?action=delpersonalgroup&groupId='+id;
            if (confirm("Click OK to delete Personal Group."))
              document.viewGroup.submit();
	}
</script>

<form id="viewGroup" name="viewGroup" action="" method="post">
	<c:set var="addBtn" scope="request" >
		<table width="99%" class="contentBgColorAlternate">
			<tr align="right"><td> <a href="memo.jsp?action=addGroup"><IMG SRC="images/system/ic_new.gif" BORDER="0" ALT="Settings"></a></td></tr>
		</table>
	</c:set>
	
	<c:out value="${addBtn}" escapeXml="false"/>
	<table width="99%"  border="0" cellpadding="3" cellspacing="0" class="contentBgColorAlternate">
		<tr class="contentBgColorAlternate">
			<c:choose>
				<c:when test="${not empty memoPersonalGroupList.memoGroupList}" >
				<td width="10"><b>#</b></td>
				<td><b>Group Name</b></td>
				<td width="50"><b>Edit</b></td>
				<td width="50"><b>Delete</b></td>
				</c:when>
				<c:otherwise>
				<td colspan="4" align="center"><b>No personal group found.</b></td>
				</c:otherwise>
			</c:choose>
		</tr>
		<c:forEach items="${memoPersonalGroupList.memoGroupList}" var="group" varStatus="groupStatus">
		<tr class="contentBgColor">
			<td>${groupStatus.index+1}</td><td>${group.mgName}</td>
			<td><a href="memo.jsp?action=editGroup&gid=${group.mgId}">Edit</a></td>
			<td><a href="javascript:confirmDelete('${group.mgId}');">Delete</a></td>
		</tr>
		</c:forEach>
	</table>
	<c:out value="${addBtn}" escapeXml="false"/>
</form>