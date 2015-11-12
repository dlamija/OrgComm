<%	//Connection...
	String action = request.getParameter("action");
 
%>
<!--
<TABLE WIDTH="100%" BORDER="0" CELLPADDING="3" CELLSPACING="0">
  <tr>
    
  <td class="contentStrapColor" align = "right"> 
    <!---
	<input type="button" value="Claim" onClick="javascript:window.location.href='tnt.jsp?action=addeditClaim';">
	<input type="button" value="Request" onClick="javascript:window.location.href='tnt.jsp?action=viewWorkOrder';">
	<input type="button" value="View Previous" onClick="javascript:window.location.href='tnt.jsp?action=claim';">
	
	<form action =tnt.jsp?action=addeditClaim method=post ><input type=submit value="Travelling Claim" ></form>
	<form action =tnt.jsp?action=viewWorkOrder method=post><input type=button value="Travelling Request"></form>
	<form action =tnt.jsp?action=claim method=post><input type=button value="View Previous Travelling Claim"></form>
	
    </td>
  </tr>
</table>

<font size="1" face="Arial"><br></font>
  <tr>
  	<TD HEIGHT="22" background="images/tnt_one.gif" >
	  <A HREF="tnt.jsp?action=addeditClaim" onMouseOver="window.status='Traveling Claim';return true;">
	  <IMG SRC="images/system/blank.gif" WIDTH="200" HEIGHT="16" BORDER="0"></A>
	  <A HREF="tnt.jsp?action=viewWorkOrder" onMouseOver="window.status='Traveling Request';return true;">
	  <IMG SRC="images/system/blank.gif" WIDTH="200" HEIGHT="16" BORDER="0"></A>
    </TD>
  </tr>
</table> -->

<!---
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="3">	
  <tr>
    <td class="contentStrapColor" align = "right" colspan = "2">
      <a href="tnt.jsp?action=claim"><IMG SRC = "images/system/cms_main.gif" BORDER="0" ALT="Main"></a>
      <a href="tnt.jsp?action=addeditClaim"><IMG SRC = "images/cms/tnt/ic_addeditclaim.gif" BORDER="0" ALT="Add/Edit Claim"></a>&nbsp;
      <a href="tnt.jsp?action=submitClaim"><IMG SRC = "images/cms/tnt/ic_submitclaim.gif" BORDER="0" ALT="Submit Claim"></a>&nbsp;
    </td>
  </tr>
</table>
---><table width="100%" border="0" cellpadding="0">
<tr> 
  <td <%= action.equals("Y") ? "BACKGROUND=\"images/menu2.gif\"" : "" %><%= action.equals("N") ? "BACKGROUND=\"images/menu.gif\"" : "" %><%= action.equals("MP") ? "BACKGROUND=\"images/menu3.gif\"" : "" %>> 
    <A HREF="call2.jsp?action=Y" onMouseOver="window.status='Official';return true;"> 
    <IMG SRC="../../images/system/blank.gif" WIDTH="89" HEIGHT="17" BORDER="0"></A> 
    <A HREF="call2.jsp?action=N" onMouseOver="window.status='Unofficial';return true;"> 
    <IMG SRC="../../images/system/blank.gif" WIDTH="89" HEIGHT="17" BORDER="0"></A> 
	 <A HREF="call2.jsp?action=MP" onMouseOver="window.status='MPP';return true;"> 
    <IMG SRC="../../images/system/blank.gif" WIDTH="89" HEIGHT="17" BORDER="0"></A> 
  </td>
  <tr>
    <td bgcolor="#666666"></td>

