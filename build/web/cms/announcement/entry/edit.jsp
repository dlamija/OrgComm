<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ include file="/includes/import.jsp" %>
<jsp:useBean id="stream" scope="page" class="common.CommonFunction"/>

<script language="javascript" type="text/javascript" src="ckeditor/ckeditor.js"></script>

<script language="JavaScript" type="text/javascript" src="cms/announcement/entry/richtext.js"></script>
<script language="JavaScript" type="text/javascript" src="cms/announcement/entry/html2xhtml.js"></script>
<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "http://community.ump.edu.my/ump/includes/";                     // URL to htmlarea files
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
String kategori = request.getParameter("kategori");
String tajuk = request.getParameter("tajuk");
String url = request.getParameter("url");
String access = request.getParameter("access");
String day = request.getParameter("day");
String kiriman = request.getParameter("kiriman");
String tarikh = request.getParameter("tarikh");
String mesej = request.getParameter("mesej");
String official = request.getParameter("official");
String addSeq = request.getParameter("addSeq");



String agent = request.getHeader("User-Agent");
  agent = agent.toLowerCase();
  int ind = agent.indexOf("msie");
  int ver = 0;
  if (ind != -1)
    ver = Integer.parseInt(agent.substring(ind + 5 ,ind + 6));
  else
    ver = 0;

  boolean ie6 = false;
  if (ver >= 6 && ind != -1)
    ie6 = true;


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


<%
	// Get staff data...
	
	String sql	= "SELECT AM.AM_CATEGORY,AM.AM_TITLE,AM.AM_MESSAGE,TO_CHAR(AM.AM_DATE,'DD-MON-YY'),SM_STAFF_NAME,AM_URL, "+
				  "AC.AC_CAT_DESC,AM.AM_ACCESS,AM.AM_TOTAL_DAY,AM.AM_OFFICIAL "+
                  "FROM CMSADMIN.ANNOUNCEMENT_MAIN AM,CMSADMIN.STAFF_MAIN SM, CMSADMIN.ANNOUNCEMENT_CATEGORY AC "+
				  "WHERE AM.AM_REF = ? AND AM.AM_POSTED_BY = SM.SM_STAFF_ID AND AC.AC_CAT_ID = AM.AM_CATEGORY";

				 
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, ref);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			kategori	= rset.getString (1);
			tajuk		= rset.getString (2);
			mesej 		= stream.stream2String(rset.getAsciiStream("am_message"));
			tarikh     	= rset.getString (4);
			kiriman    	= rset.getString (5);
			url  	  	= rset.getString (6);
			cat_desc	= rset.getString (7);
			access_type = rset.getString (8);
			day 		= rset.getString (9);
			official	= rset.getString (10);
			}
			rset.close();
		pstmt.close ();
		}
	catch (SQLException e)
		{ out.println ("Error SQL: " + e.toString ()); }
%>


<form name="RTEDemo" action="AnnouncementServlet?action=update" method="post">
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

<jsp:include page="../header.jsp" flush="true" />

  <TABLE WIDTH="100%" BORDER="1" CELLPADDING="3" CELLSPACING="0" bordercolor="#D4D0C8" bgcolor="#FFFFCC">
    <tr> 
      <td colspan="9" bgcolor="#FF9900"><font style="font-family: Arial; font-size: 11px;"><strong>Edit 
        Record </strong></font></td>
    </tr>
    <tr> 
      <td height="27"><strong><font style="font-family: Arial; font-size: 11px;">Category</font></strong></td>
      <td><span style="font-family: Arial; font-size: 10px;"> 
        <%
						String sqlq = "SELECT AC.AC_CAT_ID,AC.AC_CAT_DESC FROM CMSADMIN.ANNOUNCEMENT_CATEGORY AC ";
						
						try{
							Statement stmt = conn.createStatement();
							ResultSet rset = stmt.executeQuery( sqlq );
							if (rset.isBeforeFirst()) {
								%>
        <select name="kategori" class="smallfont" id="sid" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;" >
          <option value="<%=kategori%>"></<b><font face="Geneva, Arial, Helvetica, san-serif"> 
          <% if (kategori != null){ %>
          <%=cat_desc%> 
          <% } else %>
          -Select Category-</font></b></option>
          <%while( rset.next() ){ %>
          <option <% if (request.getParameter("kategori")!=null&&request.getParameter("kategori").toString().equals(rset.getString(1))) { %> selected<% } %> value="<%= rset.getString( 1 ) %>"> 
          <b><font face="Geneva, Arial, Helvetica, san-serif"><%=rset.getString( 2 )%></font></b></option><b><font face="Geneva, Arial, Helvetica, san-serif"> 
          <%=rset.getString( 2 )%></font></b> 
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
        <input name="staff" type="hidden" id="staff" value="<%=id%>">
        <input name="addSeq" type="hidden" id="staff" value="">
        </font></b> </span></td>
    </tr>
    <tr> 
      <td height="27"><strong><font style="font-family: Arial; font-size: 11px;">Title</font></strong></td>
      <td><input name="tajuk" type="text" id="tajuk" size="50" value="<%=tajuk%>" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;"></td>
    </tr>
    <tr> 
      <td height="27"><strong><font style="font-family: Arial; font-size: 11px;">Message</font></strong></td>
      <td> 
	  		<textarea name="mesej" id="mesej" rows="10" cols="60"><%= mesej %></textarea> 
			<script type="text/javascript">
				CKEDITOR.replace( 'mesej' , { toolbar : 'umpBasic' });
			</script>
      </td>
    </tr>
    <tr> 
      <td height="27"><strong><font style="font-family: Arial; font-size: 11px;">URL 
        reference</font></strong></td>
      <td><input name="url" type="text" id="url" size="50" value="<%=url%>" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;"></td>
    </tr>
    <tr> 
      <td height="27"><strong><font style="font-family: Arial; font-size: 11px;">Access 
        Type</font></strong></td>
      <td><table width="100%" border="0" cellspacing="0">
          <tr> 
            <td width="5%"> 
              <% if (access_type.equals("Public")) { %>
              <input name="access" type="radio" value="Public" checked="checked"> 
              <% } else {%>
              <input name="access" type="radio" value="Public"> 
              <% } %>
            </td>
            <td width="95%"><font style="font-family: Arial; font-size: 11px;">Public</font></td>
          </tr>
          <tr> 
            <td> 
              <% if (access_type.equals("STAFF")) { %>
              <input name="access" type="radio" value="STAFF" checked="checked"> 
              <% } else {%>
              <input name="access" type="radio" value="STAFF"> 
              <% } %>
            </td>
            <td><font style="font-family: Arial; font-size: 11px;">Staff</font></td>
          </tr>
          <tr> 
            <td> 
              <% if (access_type.equals("STUDENT")) { %>
              <input type="radio" name="access" value="STUDENT" checked="checked"> 
              <% } else {%>
              <input type="radio" name="access" value="STUDENT"> 
              <%}%>
            </td>
            <td><font style="font-family: Arial; font-size: 11px;">Student</font></td>
          </tr>
        </table></td>
    </tr>
    <tr>
      <td height="27" style="font-family: Arial; font-size: 11px;"><strong>Official</strong></td>
      <td><table width="100%" border="0" cellspacing="0">
          <tr> 
            <td width="5%">
			<% if (official.equals("Y")) {%>
			  <input name="official" type="radio" value="Y" checked="checked">
			<% }else {%>
			<input name="official" type="radio" value="Y">
			<%}%>
			</td>
            <td width="95%"><font style="font-family: Arial; font-size: 11px;">Official</font></td>
          </tr>
          <tr> 
            <td>
			<% if (official.equals("N")) {%>
			<input name="official" type="radio" value="N" checked="checked">
			<%} else {%>
			  <input name="official" type="radio" value="N">
			<%}%>
			</td>
            <td><font style="font-family: Arial; font-size: 11px;">Unofficial</font></td>
          </tr>
		  <% if (id.equals("AA03030") || id.equals("ST0031")){%>
		   <tr> 
            <td>
			<% if (official.equals("MP")) {%>
			<input name="official" type="radio" value="MP" checked="checked">
			<%} else {%>
			  <input name="official" type="radio" value="MP">
			<%}%>
			</td>
            <td><font style="font-family: Arial; font-size: 11px;">MPP</font></td>
          </tr>
		  <%}%>
        </table></td>
    </tr>
    <tr> 
      <td height="27"><strong><font style="font-family: Arial; font-size: 11px;">Announcement 
        View </font></strong></td>
      <td><span style="font-family: Arial; font-size: 10px;"><b><font face="Geneva, Arial, Helvetica, san-serif"> 
        <select name="day" class="smallfont" id="day" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;" >
          <option value="<%=day%>"> 
          <% if (day != null){%>
          <%=day%> Days 
          <% } else {%>
          - 
          <%}%>
          </option>
          <option value="1">1 Day</option>
          <option value="2">2 Days</option>
          <option value="3">3 Days</option>
          <option value="4">4 Days</option>
          <option value="5">5 Days</option>
        </select>
        </font></b></span></td>
    </tr>
    <tr> 
      <td height="27" colspan="2"><div align="right"> 
          <input type="submit" name="Submit" value="Update" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;  font-weight: bold">
          <input name="reset" type="reset"  style="font-family: Verdana, sans-serif; font-size: 11px;  8px;  font-weight: bold" value="Reset">
        </div></td>
    </tr>
  </table>
    </td>
  </tr>
</table>
</form>

<% conn.close(); %>
