<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ include file="/includes/import.jsp" %>
<jsp:useBean id="announcement" scope="request" class="cms.announcement.announcement" />

<script language="javascript" type="text/javascript" src="ckeditor/ckeditor.js"></script>

<%
	Connection conn = null;
	String action="";
	//String id = (String)session.getAttribute("staffid");
	//String type = (String)session.getAttribute("userType");
	String type = (String)TvoContextManager.getSessionAttribute(request, "Login.userType");
	String id = (String)TvoContextManager.getSessionAttribute(request, "Login.CMSID");
	String id_sub = request.getParameter("ls_sub");
	String dept = (String)session.getAttribute("deptcode");
	String seq = (String)session.getAttribute("seq");
	String addSeq = (String)session.getAttribute("addSeq");
	String kategori = request.getParameter("kategori");
	String tajuk = request.getParameter("tajuk");
	String mesej = request.getParameter("mesej");
	PreparedStatement pstmt2 = null;
	ResultSet rset2 = null;
	boolean status = false;

	String url = request.getParameter("url");
	String access = request.getParameter("access");
	String day = request.getParameter("day");

	try {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup( "java:comp/env" );
		DataSource ds = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
		conn = ds.getConnection();
		announcement.setConn(conn);
	}
	catch( Exception e ) {
		out.println (e.toString());
	}

	if (conn != null) {
		
		String sql_date	= "SELECT AM_SEQ1.NEXTVAL FROM DUAL";
	
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql_date);
			ResultSet rset = pstmt.executeQuery ();
			if (rset.next())
				seq = rset.getString (1);
			
			rset.close();		
			pstmt.close ();
		}
		catch (SQLException e) {
			out.println ("Error announcement/main.jsp: " + e.toString ());
		}
	}

	if (conn != null) {
		String sql2	=	" SELECT AMA.AMA_STUDENT_ID FROM CMSADMIN.ANNOUNCEMENT_MPP_AUTHORIZE AMA "+
				  		" WHERE AMA.AMA_STUDENT_ID = ? ";

				 				 
		try {
		 	pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setString(1, id);
		 	rset2 = pstmt2.executeQuery ();
			if (rset2.next())
				status = false;
			else
				status = true;
			pstmt2.close ();
		}
		catch (SQLException e) {
			out.println ("Error : " + e.toString ()); 
		}
		finally {
			try {
				if (rset2 != null) rset2.close();
				if (pstmt2 != null) pstmt2.close();
			}
			catch (Exception e) { }
		}
	}
%>
<form action="<%=request.getContextPath()%>/AnnouncementServlet?action=<%=type%>" method="post" name="RTEDemo">

<script language="JavaScript" type="text/javascript">
	function submitForm() {
		if (document.RTEDemo.kategori.value=='') {
		  	alert("Please Select The Announcement category");
			return false;
		}
		return true;	  
	}
</script>
<%@include file="/cms/announcement/header.jsp"%>

<TABLE WIDTH="100%" BORDER="1" CELLPADDING="1" CELLSPACING="0" bordercolor="#D4D0C8" bgcolor="#FFFFCC">
	<tr> 
    	<td colspan="9" bgcolor="#FF9900"><font style="font-family: Arial; font-size: 11px;"><strong>Add record</strong></font></td>
    </tr>
    <tr> 
      	<td height="27"><strong><font style="font-family: Arial; font-size: 11px;">Category</font></strong></td>
      	<td><span style="font-family: Arial; font-size: 10px;"><b><font face="Geneva, Arial, Helvetica, san-serif"> 
        <%
			String sqlq = "SELECT AC.AC_CAT_ID,AC.AC_CAT_DESC FROM CMSADMIN.ANNOUNCEMENT_CATEGORY AC ";
			
			try{
				Statement stmt = conn.createStatement();
				ResultSet rset = stmt.executeQuery( sqlq );
				if (rset.isBeforeFirst()) { %>
        			<select name="kategori" class="smallfont" id="sid" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;" >
          				<option value=""><b><font face="Geneva, Arial, Helvetica, san-serif">-Select Category-</font></b></option>
          <%while( rset.next() ){ %>
          <option <% if (request.getParameter("kategori")!=null&&request.getParameter("kategori").toString().equals(rset.getString(1))) { %> selected<% } %> value="<%= rset.getString( 1 ) %>"> 
          <b><font face="Geneva, Arial, Helvetica, san-serif"><%=rset.getString( 2 )%></font></b></option>
          <%}%>
        </select>
        </font></b><b><font face="Geneva, Arial, Helvetica, san-serif"> 
        <%
		  
							}
							rset.close();
							stmt.close();
						}catch( SQLException sqle ){
						}
				%>
        <input name="staff" type="hidden" id="staff" value="<%=id%>">
        <input name="addSeq" type="hidden" id="addSeq" value="<%=seq%>">
        </font></b> </span></td>
    </tr>
    <tr> 
      <td height="27"><strong><font style="font-family: Arial; font-size: 11px;">Title</font></strong></td>
      <td><input name="tajuk" type="text" id="tajuk" size="50" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;"></td>
    </tr>
    <tr> 
      <td colspan="2"><strong><font style="font-family: Arial; font-size: 11px;">Message</font></strong><br><br>
	  		<textarea name="mesej" id="mesej" rows="10" cols="60"></textarea> 
			<script type="text/javascript">
				CKEDITOR.replace( 'mesej' , { toolbar : 'umpBasic' });
			</script>
			
      </td>
    </tr>
    <tr> 
      <td height="27"><strong><font style="font-family: Arial; font-size: 11px;">URL 
        reference </font></strong></td>
      <td><input name="url" type="text" id="url" value="http://" size="50" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;"></td>
    </tr>
    <tr> 
      <td height="27"><strong><font style="font-family: Arial; font-size: 11px;">Access 
        Type</font></strong></td>
      <td><table width="100%" border="0" cellspacing="0">
          <tr> 
            <td width="5%"><input name="access" type="radio" value="Public" checked></td>
            <td width="95%"><font style="font-family: Arial; font-size: 11px;">Public</font></td>
          </tr>
          <tr> 
            <td><input type="radio" name="access" value="STAFF"></td>
            <td><font style="font-family: Arial; font-size: 11px;">Staff</font></td>
          </tr>
          <tr> 
            <td><input type="radio" name="access" value="STUDENT"></td>
            <td><font style="font-family: Arial; font-size: 11px;">Student</font></td>
          </tr>
        </table></td>
    </tr>
    <tr> 
      <td height="27" style="font-family: Arial; font-size: 11px;"><strong>Category</strong></td>
      <td><table width="100%" border="0" cellspacing="0">
          <tr> 
            <td width="5%"><input name="official" type="radio" value="Y"></td>
            <td width="95%"><font style="font-family: Arial; font-size: 11px;">Official</font></td>
          </tr>
          <tr> 
            <td><input name="official" type="radio" value="N" checked></td>
            <td><font style="font-family: Arial; font-size: 11px;">Unofficial</font></td>
          </tr>
		  <% if (!status){%>
          <tr>
            <td><input name="official" type="radio" value="MP"></td>
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
          <input type="submit" name="Submit" value="Save" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;  font-weight: bold" onClick='return submitForm()'>
          <input name="reset" type="reset"  style="font-family: Verdana, sans-serif; font-size: 11px;  8px;  font-weight: bold" value="Reset">
        </div></td>
    </tr>
  </table>
    </td>
  </tr>
</table>
</form>
<br><div align="left">
<%
	try {
		if (conn != null) conn.close();
	}
	catch (Exception e) {  }
%>
