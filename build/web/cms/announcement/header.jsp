<table width="100%" cellspacing="1" class='contentBgColorAlternate'>
  <tr> 
    <td class = "contentBgColor" width="590" height="20"><div align="right"></div></td>
    <td class = "contentBgColor" width="47"> <div align="center">
    	<a href="announcement.jsp"  onMouseOver="window.status='Add Record';return true;"><strong>Main</strong></a></div></td>
    <td class = "contentBgColor" width="10"><div align="center">|</div></td>
    <td class = "contentBgColor" width="27"><div align="center">
    	<a href="announcement.jsp?action=add" onMouseOver="window.status='Add Record';return true;"><strong>Add</strong></a></div></td>
    <td class = "contentBgColor" width="10"><div align="center">|</div></td>
    <td class = "contentBgColor" width="27"><div align="center">
    	<a href="announcement.jsp?action=search" onMouseOver="window.status='Search Record';return true;"><strong>Search</strong></a></div></td>    	
    <% if ((id.equals("0031"))||(id.equals("0245")) ||(id.equals("0782")) || (id.equals("ED06044")) || (id.equals("CB06102")) ){%>
    <td class = "contentBgColor" width="10"><div align="center">|</div></td>
    <td class = "contentBgColor" width="42" height="20"> <div align="center"><a href="announcement.jsp?action=viewstd"  onMouseOver="window.status='View Record';return true;"><strong>View</strong></a></div></td>
    <%}%>
    <td class = "contentBgColor" width="10"><div align="center">| </div></td>
    <td class = "contentBgColor" width="60" height="20"> <div align="center"><a href="announcement.jsp?action=archive"  onMouseOver="window.status='Archive Record';return true;"><strong>Archive</strong></a></div></td>
    <td class = "contentBgColor" width="11"><div align="center">| </div></td>
    <% if ((id.equals("0031"))||(id.equals("FB10008")) ||(id.equals("0235"))) {%>
	<td class = "contentBgColor" width="153" height="20"> <div align="center"><a href="announcement.jsp?action=mpp_authorize"  onMouseOver="window.status='MPP Authorize';return true;"><strong>MPP Authorization</strong></a></div></td>
	<%}%>
</table>

