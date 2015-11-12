<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ include file="/includes/import.jsp" %>
<html>
<head>
<jsp:useBean id="stream" scope="page" class="common.CommonFunction"/>
<script language = "Javascript">

function gotopage (selSelectObject)
{
if(selSelectObject.options[selSelectObject.selectedIndex].value != "")
  {
   location.href=selSelectObject.options[selSelectObject.selectedIndex].value
  }
}

</script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"></head>

<%
	Connection conn = null;
	String id= (String)session.getAttribute("staffid");
	String action = request.getParameter("action");
	
	String ref =request.getParameter("ref");

 	try {
		Context initCtx = new InitialContext();
		Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
		DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
		conn = ds.getConnection();
	}
	catch( Exception e )
	{ out.println (e.toString()); }
%>

<body>
<div align="center"><strong><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><a href="javascript:void(window.close('cms/kmsentry/view.jsp'))">[ 
  Close Window ]</a> </font></strong> 
  <!----------------mula di sini--------------->
  <%
	// Get staff data...
    String kategori=request.getParameter("kategori");
	String tajuk=request.getParameter("tajuk");
	String mesej=request.getParameter("mesej");
	String tarikh=request.getParameter("tarikh");
	String kiriman=request.getParameter("kiriman");
	String url=request.getParameter("url");
	String access=request.getParameter("access");
	String student=request.getParameter("student");
	String mesej2=request.getParameter("mesej2");
	//String ref = request.getParameter("ref");
	
	String sql	= "SELECT ac_cat_desc,am_title,am_message,TO_CHAR(am_date,'DD-MON-YY'),sm_staff_name,am_url,am_access,sm_student_name "+
                  "FROM announcement_main,staff_main,announcement_category,student_main "+
				  "where am_ref = '"+ref+"' and am_posted_by=sm_staff_id(+) and ac_cat_id = am_category and sm_student_id(+)=am_posted_by";
				 
	try {
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rset = pstmt.executeQuery ();
		
		if (rset.next()) {
			kategori = rset.getString (1);
			tajuk = rset.getString (2);
			mesej = stream.stream2String(rset.getAsciiStream("am_message"));
			//mesej = stream.ln2br(mesej2);
			tarikh = rset.getString (4);
			kiriman = rset.getString (5);
			url = rset.getString (6);
			access = rset.getString (7);
			student = rset.getString(8);
		}
		rset.close();
		pstmt.close ();
	}
	catch (SQLException e) {
		out.println ("Error SQL: " + e.toString ()); 
	}
	finally {
		try {
			if (conn != null) conn.close();
		}
		catch (Exception e) {  }
	}
%>
  <br>
  </div>
<TABLE id=Table_01 height=82 cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
	<TBODY>
    	<TR> 
      		<TD width="1%" height=39><IMG height=39 alt="" src="images/clas_01.gif" width=16></TD>
      		<TD width="97%" background="images/clas_02.gif"> 
        		<DIV align=center>
					<FONT color=#ffffff><STRONG><font size="2" face="Verdana, Arial, Helvetica, sans-serif" >Announcement
					<FONT color=#ffff99>Board</font></FONT></STRONG></FONT> 
        		</DIV>
			</TD>
      		<TD width="2%"> <DIV align=left><IMG height=39 alt="" src="images/clas_04.gif" width=17></DIV></TD>
    	</TR>
    	<TR> 
     		<TD background="images/clas_05.gif" height=27>
			 	<IMG height=24 alt="" src="images/clas_05.gif" width=16></TD>
      		<TD align="right" vAlign=top bgColor=#ffffff>
				<DIV align=right> <font color="#333333"><strong><font size="1" face="Verdana, Arial, Helvetica, sans-serif"></font></strong></font>
           <a href="print.jsp?ref=<%=ref%>" onMouseOver="window.status='Print';return true;" target="_blank"><IMG SRC = "../../../images/system/ic_printer.gif" ALT = "Print" border = "0"></a> <TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="3">
            <tr bgcolor="#FF9900"> 
              <td colspan="2" CLASS="contentBgColorAlternate"><font color="#FFFFFF" size="1" face="Verdana, Arial, Helvetica, sans-serif"><strong>Announcement</strong></font></td>
            </tr>
            <tr valign="top" bgcolor="#FFEFCE" class="smallfont"> 
              <td class="contentBgColor"><strong><font size="1" face="Verdana, Arial, Helvetica, sans-serif">Category 
                </font></strong></td>
              <td bgcolor="#FFEFCE" class="contentBgColor"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><%=( ( kategori ==null)?"-":kategori )%></font></font><font size="1" face="Verdana, Arial, Helvetica, sans-serif">&nbsp; 
                </font></td>
            </tr>
            <tr valign="top" bgcolor="#FFEFCE" class="smallfont"> 
              <td width="17%" class="contentBgColor"><strong><font size="1" face="Verdana, Arial, Helvetica, sans-serif">Title</font></strong></td>
              <td width="83%" bgcolor="#FFEFCE" class="contentBgColor"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><%=( ( tajuk ==null)?"-":tajuk )%></font> 
                </font></td>
            </tr>
            <tr valign="top" bgcolor="#FFEFCE" class="smallfont"> 
              <td class="contentBgColor"><strong><font size="1" face="Verdana, Arial, Helvetica, sans-serif">Message</font></strong></td>
              <td class="contentBgColor"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><%=( ( mesej ==null)?"-":mesej )%></font></font></td>
            </tr>
            <tr valign="top" bgcolor="#FFEFCE" class="smallfont"> 
              <td class="contentBgColor"><strong><font size="1" face="Verdana, Arial, Helvetica, sans-serif">URL 
                </font></strong></td>
              <td class="contentBgColor"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><%=( ( url ==null)?"-":url )%></font></td>
            </tr>
            <tr valign="top" bgcolor="#FFEFCE" class="smallfont"> 
              <td class="contentBgColor"><strong><font size="1" face="Verdana, Arial, Helvetica, sans-serif">Posted 
                by </font></strong></td>
              <td class="contentBgColor"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><%=( ( kiriman ==null)?"":kiriman )%><%=( ( student ==null)?"":student )%></font></td>
            </tr>
          </table>
          <font color="#333333"><strong><font size="1" face="Verdana, Arial, Helvetica, sans-serif"> 
          </font></strong></font><strong><font color="white" size="1" face="Verdana, Arial, Helvetica, sans-serif"> 
          </font></strong> </DIV></TD>
      <TD 
                            background="images/clas_07.gif"> 
        <DIV align=left><IMG height=27 alt="" 
                              src="images/clas_07.gif" 
                              width=17></DIV></TD>
    </TR>
    <TR> 
      <TD><IMG height=16 alt="" 
                              src="images/clas_08.gif" 
                              width=16></TD>
      <TD 
                            background="images/clas_09.gif"><IMG 
                              height=16 alt="" 
                              src="images/clas_09.gif" 
                              width=199></TD>
      <TD> <DIV align=left><IMG height=16 alt="" 
                              src="images/clas_10.gif" 
                              width=17></DIV></TD>
    </TR>
  </TBODY>
</TABLE>

<!--------------------------------------------->


</body>

</html>
