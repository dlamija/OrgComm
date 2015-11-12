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

function done(ref)
	{
	document.form1.action="update_approve.jsp?action=approve&id=" +ref;
	document.form1.submit();
	//window.opener.document.forms[0].test.value=document.forms[0].position.value
	//window.close();
	}
function done_reject(ref)
	{
	document.form1.action="reject_approve.jsp?action=reject&id=" +ref;
	document.form1.submit();
	//window.opener.document.forms[0].test.value=document.forms[0].position.value
	//window.close();
	}
</script>


<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"></head>

<%
	Connection conn = null;
	String id= (String)session.getAttribute("staffid");
	String action = request.getParameter("action");
	String ref =request.getParameter("id");
	String nama = request.getParameter("nama");
	String staff_approver = request.getParameter("staff_approver");
	String status_approve = request.getParameter("status_approve");
    String kategori=request.getParameter("kategori");
	String tajuk=request.getParameter("tajuk");
	String mesej=request.getParameter("mesej");
	String tarikh=request.getParameter("tarikh");
	String kiriman=request.getParameter("kiriman");
	String url=request.getParameter("url");
	String access=request.getParameter("access");
	String student=request.getParameter("student");
	String nama_student=request.getParameter("nama_student");
	String official = request.getParameter("official");

	boolean status=false;
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
if (conn!=null)
	{
	//Block the user if they already submit the survey
	String sql2	=" SELECT SM.SM_STAFF_NAME,AM.AM_STATUS FROM CMSADMIN.ANNOUNCEMENT_MAIN AM,CMSADMIN.STAFF_MAIN SM "+
				  " WHERE AM.AM_STATUS IS NOT NULL AND SM.SM_STAFF_ID=AM.AM_APPROVER "+
				  " AND AM.AM_REF = ? "+
				  "UNION SELECT SM.SM_STUDENT_NAME,AM.AM_STATUS FROM CMSADMIN.ANNOUNCEMENT_MAIN AM,CMSADMIN.STUDENT_MAIN SM "+
				  " WHERE AM.AM_STATUS IS NOT NULL AND SM.SM_STUDENT_ID=AM.AM_APPROVER "+
				  " AND AM.AM_REF = ? ";

				 
	try
		{
		PreparedStatement pstmt2 = conn.prepareStatement(sql2);
		pstmt2.setString(1, ref);
		pstmt2.setString(2, ref);
		ResultSet rset2 = pstmt2.executeQuery ();
		if (rset2.next())
		{
			status = false;
			nama = rset2.getString(1);
			status_approve = rset2.getString(2);
		}
		else
			status = true;
		pstmt2.close ();
		}
	catch (SQLException e)
		{ out.println ("Error : " + e.toString ()); }
	}
%>
<%
 if (status)
 {
%>
<body background="../images/top3.GIF">
<!----------------mula di sini--------------->

<% if(conn !=null && action!=null && action.equals("approve"))
{

String sql_inst = "{ ? = call ANNOUNCE.ApproveAnnouncement(?, ?) }";
	try
	{
		CallableStatement pstmt = conn.prepareCall(sql_inst);
		System.out.println(staff_approver);
		pstmt.registerOutParameter (1, Types.NUMERIC );
		pstmt.setString (2,ref);
		pstmt.setString(3, id);
        pstmt.execute ();
		pstmt.close ();

	}
     	catch (SQLException e)
        	{			out.println (e.toString ());   }
}

%>

<%
	// Get staff data...
	String sql	=	"SELECT AC.AC_CAT_DESC,AM.AM_TITLE,AM.AM_MESSAGE,TO_CHAR(AM.AM_DATE,'DD-MON-YY'),SM.SM_STAFF_NAME,AM.AM_URL, "+
					"AM.AM_ACCESS,SM.SM_STUDENT_NAME,AM.AM_OFFICIAL "+
                  	"FROM CMSADMIN.ANNOUNCEMENT_MAIN AM,CMSADMIN.STAFF_MAIN SM,CMSADMIN.ANNOUNCEMENT_CATEGORY AC,CMSADMIN.STUDENT_MAIN SM "+
				  	"WHERE AM.AM_REF = ? AND AM.AM_POSTED_BY = SM.SM_STAFF_ID(+) AND AC.AC_CAT_ID = AM.AM_CATEGORY AND SM.SM_STUDENT_ID(+) = AM.AM_POSTED_BY ";	
			 
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
			tarikh     = rset.getString (4);
			kiriman    = rset.getString (5);
			url    = rset.getString (6);
			access = rset.getString (7);
			student = rset.getString(8);
			official = rset.getString (9);
			}
			rset.close();
		pstmt.close ();
		}
	catch (SQLException e)
		{ out.println ("Error SQL: " + e.toString ()); }
%>
<br>
<strong><font size="1" face="Arial"><a href="javascript:void(window.close('cms/kmsentry/view.jsp'))">[ Close Window ]</a> 
</font></strong> 
<p>
<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#999999">
  <tr>
    <td><TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="3">
        <tr bgcolor="#FF9900"> 
          <td colspan="2" CLASS="contentBgColorAlternate"><font color="#FFFFFF" size="1" face="Arial"><strong>Announcement</strong></font></td>
        </tr>
        <tr valign="top" bgcolor="#FFEFCE" class="smallfont"> 
          <td class="contentBgColor"><strong><font size="1" face="Arial">Category 
            </font></strong></td>
          <td bgcolor="#FFEFCE" class="contentBgColor"><font size="2" face="Arial"><font size="1" face="Arial"><%=( ( kategori ==null)?"-":kategori )%></font></font><font size="1" face="Arial">&nbsp; 
            <input name="staff_approver" type="hidden" id="staff_approver" value="<%=id%>">
            </font></td>
        </tr>
        <tr valign="top" bgcolor="#FFEFCE" class="smallfont"> 
          <td width="17%" class="contentBgColor"><strong><font size="1" face="Arial">Title</font></strong></td>
          <td width="83%" bgcolor="#FFEFCE" class="contentBgColor"><font size="2" face="Arial"><font size="1" face="Arial"><%=( ( tajuk ==null)?"-":tajuk )%></font> 
            </font></td>
        </tr>
        <tr valign="top" bgcolor="#FFEFCE" class="smallfont"> 
          <td class="contentBgColor"><strong><font size="1" face="Arial">Message</font></strong></td>
          <td class="contentBgColor"><font size="2" face="Arial"><font size="1" face="Arial"><%=( ( mesej ==null)?"-":mesej )%></font></font></td>
        </tr>
        <tr valign="top" bgcolor="#FFEFCE" class="smallfont"> 
          <td class="contentBgColor"><strong><font size="1" face="Arial">URL 
            </font></strong></td>
          <td class="contentBgColor"><font size="1" face="Arial"><%=( ( url ==null)?"-":url )%></font></td>
        </tr>
        <tr valign="top" bgcolor="#FFEFCE" class="smallfont"> 
          <td class="contentBgColor"><strong><font size="1" face="Arial">Posted 
            by </font></strong></td>
          <td class="contentBgColor"><font size="1" face="Arial"><%=( ( kiriman ==null)?"":kiriman )%><%=( ( student ==null)?"":student )%></font></td>
        </tr>
        <tr valign="top" bgcolor="#FFEFCE" class="smallfont"> 
          <td class="contentBgColor"><font size="1" face="Arial"><strong>Official 
            </strong> </font></td>
          <td class="contentBgColor"><font size="1" face="Arial">
            <% if (official.equals("Y")){%>
            Yes
            <%} else {%>
            No
            <%}%>
            </font></td>
        </tr>
        <tr valign="top" bgcolor="#FFEFCE" class="smallfont"> 
          <td class="contentBgColor"><strong><font size="1" face="Arial">Access 
            Type </font></strong></td>
          <td class="contentBgColor"><font size="1" face="Arial"><%=( ( access ==null)?"-":access )%></font></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<form name="form1" method="post" action="announcement.jsp?action=approve">
  <input type="button" name="Button" value="Approve" style="font-family: Arial; font-size: 11px;" onClick="done(<%=request.getParameter("id")%>);">
  <A HREF="javascript:done(<%=ref%>);" ;return true;"> 
  </A>
  <input type="button" name="Button2" value="Reject" style="font-family: Arial; font-size: 11px;" onClick="done_reject(<%=request.getParameter("id")%>);">
</form>
<br>
<%
}else
{ %>
<font size="1" face="Arial"><%=( ( nama ==null)?"":nama )%> already <%=status_approve%> the announcement...</font> 
<% }
%>
<!--------------------------------------------->
<% conn.close(); %>
</body>

</html>
