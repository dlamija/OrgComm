<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ include file="/includes/import.jsp" %>


<script language="JavaScript" type="text/javascript" src="cms/announcement/entry/richtext.js"></script>
<script language="JavaScript" type="text/javascript" src="cms/announcement/entry/html2xhtml.js"></script>
<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "http://community.kuktem.edu.my/kuktem/includes/";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }



if (win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// --></script>

<%
Connection conn = null;



String action="";
String id= (String)session.getAttribute("staffid");
String id_sub = request.getParameter("ls_sub");
String ref = request.getParameter("ref");
String cat_desc = request.getParameter("cat_desc");
String access_type = request.getParameter("access_type");


try
	{
    	Context initCtx = new InitialContext();
    	Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
    	DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
	conn = ds.getConnection();
	}
catch( Exception e )
	{ out.println (e.toString()); }

%>

<form name="RTEDemo" action="announcement.jsp?action=save" method="post">
<input type="hidden" name="action" value="update">
<input type="hidden" name="ref" value="<%=ref%>">

<script language="JavaScript" type="text/javascript">
<!--
function submitForm() {
	//make sure hidden and iframe values are in sync before submitting form
	//to sync only 1 rte, use updateRTE(rte)
	//to sync all rtes, use updateRTEs
	//updateRTE('rte1');
	updateRTEs();
	alert("rte1 = " + document.RTEDemo.rte1.value);
	//alert("rte2 = " + document.RTEDemo.rte2.value);
	//alert("rte3 = " + document.RTEDemo.rte3.value);
	
	//change the following line to true to submit form
	return false;
}

//Usage: initRTE(imagesPath, includesPath, cssFile, genXHTML)
initRTE("images/", "", true, true);
//-->
</script>


  <TABLE WIDTH="100%" BORDER="1" CELLPADDING="3" CELLSPACING="0" bordercolor="#D4D0C8" bgcolor="#FFFFCC">
    <tr> 
      <td colspan="9" bgcolor="#FF9900"><font style="font-family: Arial; font-size: 11px;"><strong>Edit 
        Record </strong></font></td>
    </tr>
    <tr> 
      <td height="27"><strong><font style="font-family: Arial; font-size: 11px;">Category</font></strong></td>
      <td><span style="font-family: Arial; font-size: 10px;"> 
        <%
						String sqlq = "SELECT AC_CAT_ID,AC_CAT_DESC FROM ANNOUNCEMENT_CATEGORY ";
						
						try{
							Statement stmt = conn.createStatement();
							ResultSet rset = stmt.executeQuery( sqlq );
							if (rset.isBeforeFirst()) {
								%>
        <select name="kategori" class="smallfont" id="sid" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;" >
          <option value=""><b><font face="Geneva, Arial, Helvetica, san-serif"> 
        </font></b></option>
          <%while( rset.next() ){ %>
          <option <% if (request.getParameter("kategori")!=null&&request.getParameter("kategori").toString().equals(rset.getString(1))) { %> selected<% } %> value="<%= rset.getString( 1 ) %>"> 
          <b><font face="Geneva, Arial, Helvetica, san-serif"><%=rset.getString( 2 )%></font></b></option><b><font face="Geneva, Arial, Helvetica, san-serif"> 
          <%=rset.getString( 2 )%></font></b></option> 
          <%}%>
        </select>
        <b><font face="Geneva, Arial, Helvetica, san-serif"> 
        <%
		  
							}
							rset.close();
							stmt.close();
						}catch( SQLException sqle ){
						}
				%>
        </font></b> </span></td>
    </tr>
    <tr> 
      <td height="27"><strong><font style="font-family: Arial; font-size: 11px;">Title</font></strong></td>
      <td><input name="tajuk" type="text" id="tajuk" size="50" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;"></td>
    </tr>
    <tr> 
      <td height="27"><strong><font style="font-family: Arial; font-size: 11px;">Message</font></strong></td>
      <td> <textarea id="mesej" style="display: none;" name="mesej" rows="10" cols="60" marginheight="0" marginwidth="0">
  
  </textarea>	
        <script language="javascript1.2">
												editor_generate('mesej');
											  </script> </td>
    </tr>
    <tr> 
      <td height="27"><strong><font style="font-family: Arial; font-size: 11px;">URL 
        reference</font></strong></td>
      <td><input name="url" type="text" id="url" size="50" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;"></td>
    </tr>
    <tr> 
      <td height="27"><strong><font style="font-family: Arial; font-size: 11px;">Access 
        Type</font></strong></td>
      <td><table width="100%" border="0" cellspacing="0">
          <tr> 
            <td width="5%"> 
             <input name="access" type="radio" value="Public"> 
             </td>
            <td width="95%"><font style="font-family: Arial; font-size: 11px;">Public</font></td>
          </tr>
          <tr> 
            <td> 
     <input name="access" type="radio" value="STAFF"> 
            </td>
            <td><font style="font-family: Arial; font-size: 11px;">Staff</font></td>
          </tr>
          <tr> 
            <td> 
              <input type="radio" name="access" value="STUDENT"> 
            </td>
            <td><font style="font-family: Arial; font-size: 11px;">Student</font></td>
          </tr>
        </table></td>
    </tr>
    <tr>
      <td height="27"><strong><font style="font-family: Arial; font-size: 11px;">Announcement 
        View </font></strong></td>
      <td><span style="font-family: Arial; font-size: 10px;"><b><font face="Geneva, Arial, Helvetica, san-serif"> 
        <select name="day" class="smallfont" id="day" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;" >
		<option value="">-</option>
          <option value="1">1 Day</option>
          <option value="2">2 Days</option>
          <option value="3">3 Days</option>
          <option value="4">4 Days</option>
          <option value="5">5 Days</option>
        </select>
        </font></b></span></td>
    </tr>
    <tr> 
      <td height="27">&nbsp;</td>
      <td><input type="submit" name="Submit" value="Update" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;  font-weight: bold"> 
        <input name="reset" type="reset"  style="font-family: Verdana, sans-serif; font-size: 11px;  8px;  font-weight: bold" value="Reset"> 
      </td>
    </tr>
  </table>
    </td>
  </tr>
</table>
</form>
<br>
<div align="left">






<% conn.close(); %>
