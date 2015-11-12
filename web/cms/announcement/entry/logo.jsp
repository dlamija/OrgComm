<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ include file="/includes/import.jsp" %>


<%
Connection conn = null;
float total;
boolean data = false;


String action="";
String id= (String)session.getAttribute("staffid");
String id_sub = request.getParameter("ls_sub");


try
	{
    	Context initCtx = new InitialContext();
    	Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
    	DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
	conn = ds.getConnection();
	}
catch( Exception e )
	{ out.println (e.toString()); }
pageContext.include("/cms/votesurvey/votesurveyHeader.jsp");
%>



<script language="JavaScript">
<!--

//Disable right click script III- By Renigade (renigade@mediaone.net)
//For full source code, visit http://www.dynamicdrive.com

if (window.Event)
document.captureEvents(Event.MOUSEUP);
function nocontextmenu()
{
  event.cancelBubble = true;
  event.returnValue  = false;
  return false;
}
function norightclick(e)
{
  if (window.Event)
  {
    if (e.which == 2 || e.which == 3)
    return false;
  }
  else
  if (event.button == 2 || event.button == 3)
  {
    event.cancelBubble = true;
    event.returnValue  = false;
    return false;
  }
}
if (document.layers)
{
  document.captureEvents(Event.MOUSEDOWN);
}
document.oncontextmenu = nocontextmenu;
document.onmousedown   = norightclick;
document.onmouseup     = norightclick;
// --> 


</script>


<form name="form1"  action="votesurvey.jsp" method="GET">
<input type="hidden" name="action" value="votesubmit">




<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="3">
     <tr>
       <td colspan="8" bgcolor="#FF9900"><strong><font color="#FFFFFF" size="2" face="Arial">Vote Now</font></strong></td>
     </tr>
	 
	 <tr>
	 <td>
	 <p><font size="2"><b><font face="Arial">Here's your chance to choose the KUKTEM's Logo.  
	   Vote for the Logo you like best ! </font></b></font></p>
	 <table width="16%" border="0" cellpadding="3">
       <tr>
         <td width="32"><div align="center"><font style="font-family: Verdana, sans-serif; font-size: 11px;  8px;  font-weight: bold"><A href="javascript:void(window.open('cms/votesurvey/daily/logo1.jsp','logo1', 'height=460,width=700,menubar=no,toolbar=no,scrollbars=yes'))"><img src="cms/votesurvey/logo/logo1.GIF" alt="Logo 1"  border="0" scr=""></a> </font></div></td>
         <td width="32"><div align="center"><font style="font-family: Verdana, sans-serif; font-size: 11px;  8px;  font-weight: bold"><A href="javascript:void(window.open('cms/votesurvey/daily/logo2.jsp','logo2', 'height=460,width=700,menubar=no,toolbar=no,scrollbars=yes'))"><img src="cms/votesurvey/logo/logo2.GIF" alt="Logo 2"  border="0" scr=""></a> </font></div></td>
         <td width="32"><div align="center"><font style="font-family: Verdana, sans-serif; font-size: 11px;  8px;  font-weight: bold"><A href="javascript:void(window.open('cms/votesurvey/daily/logo3.jsp','logo3', 'height=460,width=700,menubar=no,toolbar=no,scrollbars=yes'))"><img src="cms/votesurvey/logo/logo3.GIF" alt="Logo 3"  border="0" scr=""></a> </font></div></td>
         <td width="40"><div align="center"><font style="font-family: Verdana, sans-serif; font-size: 11px;  8px;  font-weight: bold"><A href="javascript:void(window.open('cms/votesurvey/daily/logo4.jsp','logo4', 'height=460,width=700,menubar=no,toolbar=no,scrollbars=yes'))"><img src="cms/votesurvey/logo/logo4.GIF" alt="Logo 4"  border="0" scr=""></a> </font></div></td>
       </tr>
       <tr>
         <td><div align="center"><font style="font-family: Verdana, sans-serif; font-size: 11px;  8px;  font-weight: bold">
             <input name=choose type="radio" value=logo1>
         </font></div></td>
         <td><div align="center">
           <input name=choose type="radio" value=logo2>
         </div></td>
         <td><div align="center">
           <input name=choose type="radio" value=logo3>
         </div></td>
         <td><div align="center">
           <input name=choose type="radio" value=logo4>
         </div></td>
       </tr>
     </table>	 
	 <p><font size="2" face="Arial"><strong><em>Click on picture to enlarge</em></strong><br>
	   <br>
	   <br>
	   <font size="1">Prepared by:<br>
	   Corporate Service Unit<br>
	   KUKTEM
       <br>
       <br>
       Date:<br>
       28 Februari 2006
</font> </font></p>	 </td>
	 </tr>
	 

  </table>
    </td>
  </tr>
</table>
<br>
<div align="left">
<input type="submit" name="hantar2" value="Vote" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;  font-weight: bold">
<input type="reset" name="hantar2" value="Reset" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;  font-weight: bold">

</form>





<% conn.close(); %>
