<%
    Storage storage = beanMemo.getDiskSpace(request);
    long usedSize = storage.getDiskSpaceUsed();
    long longSize = (long) storage.getMaxStorageSize() * 1024 * 1024;
%>
<TR VALIGN="TOP"  BGCOLOR="#DBDBDB"> <!--CLASS="contentBgColorAlternate"-->
  <TD  CLASS="contentBgColorAlternate" bgcolor='#B9E7FF'  colspan="7" ALIGN="center"><b>Disk Space</b></td>
</tr>
<TR VALIGN="TOP"  BGCOLOR="#DBDBDB">
  <TD CLASS="contentBgColor" bgcolor='#D9F2FF'  colspan="7" ALIGN="center"><br>
	Allocated Disk Space : <%= storage.getMB(longSize) %> MB<br>
	Disk Space Used  : <%= storage.getMB(usedSize) %> MB<br><br>
	<% if (storage.isStorageEmpty()) { %>
		<font color = "red">Your disk space is <b>FULL</b>. Please delete your memos and empty the trash.</font>
	<% } else if (storage.isStorageLow()) { %>
		<font color = "red">Your disk space is running low. Please delete your memos and empty the trash.</font>
	<% } %>
  </td>
</tr>




