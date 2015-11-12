<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>

<%	//Connection...
	Connection conn = null;
	String kadpengenalan= (String)session.getAttribute("kadpengenalan");
	String bidang = request.getParameter("bidang"); 
	String bidang2 = request.getParameter("bidang2"); 
	String pilihan1 = request.getParameter("pilihan1");
	String pilihan2 = request.getParameter("pilihan2");
	String ref = request.getParameter("post1");
	String ref2 = request.getParameter("dept");
	String post1 = request.getParameter("post1");
	String dept2 = request.getParameter("dept2");
	String ic_no = request.getParameter("ic_no");
	String dept = request.getParameter("dept");
	String post2 = request.getParameter("post2");
	String refid = request.getParameter("refid");
	String action = request.getParameter("action");
	String closing_edit_post2 = request.getParameter("closing_edit_post2");
	String closing_date2 = request.getParameter("closing_date2");
	PreparedStatement pstmt2 = null;
	PreparedStatement pstmt = null;
	boolean flag = false; 
	boolean flag2 = false;

 try
	{
		Context initCtx = new InitialContext();
		Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
		DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
		conn = ds.getConnection();
	}
	catch( Exception e )
	{
		out.println (e.toString());
	}
%>
<script>
function go()
{
		if(document.applForm.post2.value =='DA41')
		  {
		  alert("Permohonan bagi jawatan TUTOR hanya layak bagi pemohon\nyang mempunyai CGPA@PNGK 3.00 ke atas sahaja.\n\nTerima Kasih");
		  document.applForm.action = "eRecruitment.jsp?action=edit_post2&refid=<%=refid%>";
     	  document.applForm.submit();
		  }
		  else
		  {
			document.applForm.action = "eRecruitment.jsp?action=edit_post2&refid=<%=refid%>";
			document.applForm.submit();
		  }
}

function refreshmain()
{ 
if (document.applForm.post2.value=='')
  {
     alert("Sila Pilih Jawatan (Please Select post)");
	 document.applForm.post2.focus();
	 //return false;
  }
else if (document.applForm.dept2.value=='')
  {
     alert("Sila Pilih Jabatan/Fakulti (Please Select Department)");
	 document.applForm.dept2.focus();
	 //return false;
  }
 else
 			{

			document.applForm.action = "eRecruitment.jsp?action=editpost2&refid=<%=refid%>";
			document.applForm.submit();
			window.opener.location.reload(); 
			window.close();
			}
}
  </script>
<%
	if (conn != null && request.getParameter("post2")!=null)
	{
	String sql = "SELECT 1 FROM recruitment_post_detl, recruitment_post " +
				 "where rp_ref_id=RPD_REF_ID and RPD_REF_ID ='"+ post2 +"' ";

	try
		{
		pstmt = conn.prepareStatement(sql);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			flag2 = true;
			}
		pstmt.close ();
		rset.close ();
		}
	catch (SQLException e)
		{ out.println ("Error : " + e.toString ()); }
	finally {
  try {
      if (pstmt != null) 
	  pstmt.close();  
  }
  catch (Exception e) { }
 }
	}
%>
<% if(conn !=null && action!=null && action.equals("editpost2"))
{

String sql_inst = "update staff_candidate_head "+
                   "set sch_post_2 = ?, "+
				   "sch_majoring2 = ?, "+
				   "sch_closing_date_post2 = to_char(to_date(?,'dd/mm/yyyy')) "+
				   "where sch_ref_id = '" + refid +"' ";
	try
	{
		pstmt2 = conn.prepareStatement(sql_inst);
		pstmt2.setString(1, dept2);
		pstmt2.setString(2, bidang2);
		pstmt2.setString(3, closing_date2);
		int rc= pstmt2.executeUpdate();
		if(rc>0)
		{ out.println("<font color='#FF0000' size='2' face='Arial, Helvetica, sans-serif'>Maklumat jawatan telah dikemaskini!</font>"); }
		else
		{ out.println("<font color='#FF0000' size='2' face='Arial, Helvetica, sans-serif'>Maklumat jawatan tidak dikemaskini!</font>"); }
		
        pstmt2.close ();

	}
     	catch (SQLException e)
        	{out.println (e.toString ());   }
		finally {
  try {
      if (pstmt2 != null) 
	   pstmt2.close ();
  }
  catch (Exception e) { }
  }
		}
%>
<style type="text/css">
<!--
.style1 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 13px;
	font-weight: bold;
	color: #707C8A;
}
.style2 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	color: #333333;
}
a {
	color: #333333;
	TEXT-DECORATION: none;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
}
-->
</style>


<title>Kemaskini Pilihan Jawatan Kedua</title>
<form name="applForm" method="post" action="">
  <table width="100%" border="0">
    <tr> 
      <td height="30" class="style2"><strong>Kemaskini Jawatan Pilihan Kedua</strong></td>
    </tr>
    <tr>
      <td height="20" class="style2"><span class="style2"><strong>No Rujukan : 
        <%=refid%></strong></span></td>
    </tr>
  </table>
  <table width="100%"  border="0" cellpadding="0" cellspacing="1" class='style2'>
    <tr> 
      <th width="18%" bgcolor="#999999" scope="row">Pilihan Jawatan Pertama</th>
      <td width="82%" bgcolor="#CCCCCC"><b><font face="Geneva, Arial, Helvetica, san-serif"> 
        &nbsp; 
        <select name="pilihan2" id="pilihan2" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" onChange = 'document.applForm.action="eRecruitment.jsp?action=edit_post2&refid=<%=refid%>";document.applForm.submit();'>
          <option value="">Pilihan Jawatan Kedua</option>
          <% if (request.getParameter("pilihan2") != null && request.getParameter("pilihan2").equals("ACADEMIC")) {%>
          <option value="ACADEMIC" selected>Jawatan Akademik</option>
          <% } else {%>
          <option value="ACADEMIC">Jawatan Akademik</option>
          <%} %>
          <%  if (request.getParameter("pilihan2") != null && request.getParameter("pilihan2").equals("NON ACADEMIC")) {%>
          <option value="NON ACADEMIC" selected>Jawatan Bukan Akademik</option>
          <% } else {%>
          <option value="NON ACADEMIC">Jawatan Bukan Akademik</option>
          <%} %>
        </select>
        </font></b></td>
    </tr>
    <tr> 
      <th height="20" colspan="2" bgcolor="#EAF4FF" scope="row"> <div align="right">
          <table width="100%"  border="0" cellpadding="0" cellspacing="1" class='style2'>
            <tr> 
              <th width="20%" scope="row"><div align="right">Jawatan : </div></th>
              <td width="80%"> <select name="post2" size="1" id="post2"  value="" onChange = 'go();' style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                  <option>Pilih Jawatan Pilihan Kedua 
                  <%
									try
									{
										
										String sql_threfid =  null;
										sql_threfid =		"select ss_jpa_code,ss_service_desc,RPH_CLOSING_DATE,rph_service_code from "+
															"recruitment_post_head,service_scheme "+
															"where ss_service_code=rph_service_code "+
															"AND SYSDATE <= RPH_CLOSING_DATE "+
															"AND RPH_STATUS='OFFERED' "+
															"AND SS_GROUPING='"+ pilihan2 +"' ";
										
										Statement st_threfid=conn.createStatement();
										ResultSet rs_threfid=st_threfid.executeQuery(sql_threfid);
										while(rs_threfid.next())
										{
											String code = rs_threfid.getString("rph_service_code");
											String desc = rs_threfid.getString("ss_service_desc");
											String jpa = rs_threfid.getString("ss_jpa_code");
								
											if(post2!=null && post2.equals(code))
											{
								
								%>
                  <option value='<%=code%>' selected><%=jpa%> - <%=desc%> 
                  <% } else { %>
                  <option value='<%=code%>'><%=jpa%> - <%=desc%> 
                  <%
											}
										}
										st_threfid.close ();
										rs_threfid.close ();
									}
									catch(Exception e)
									{
										System.out.println("Error in th_ref_id jawatan edit 2:"+e);
									}
								%>
                </select> </td>
            </tr>
            <tr> 
              <th scope="row"><div align="right"><span class="style5">Fakulti 
                  : </span></div></th>
              <td> <p></p>
                <select name="dept2" size="1" id="dept2" onChange='document.applForm.action="eRecruitment.jsp?action=edit_post2&refid=<%=refid%>";document.applForm.submit();' style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                  <option value="">Pilih Jabatan/Fakulti 
                  <%
							
								
										try
										{
											
											String sql_threfid = null;
											//if (request.getParameter("pilihan1")!= null && request.getParameter("pilihan1").equals("akademik"))
												 sql_threfid =	"SELECT RP_REF_ID,RP_DEPT_CODE,DM_DEPT_DESC,to_char(RPH_CLOSING_DATE,'dd-mm-yyyy') FROM "+
																"RECRUITMENT_POST,RECRUITMENT_POST_HEAD,DEPARTMENT_MAIN "+
																"WHERE RP_POST_ID=RPH_POST_ID "+
																"AND RP_DEPT_CODE = DM_DEPT_CODE "+
																"AND RP_SERVICE_CODE='"+ post2 +"' "+
																"AND RP_STATUS='OFFERED' ";
																						
											Statement st_threfid=conn.createStatement();
											ResultSet rs_threfid=st_threfid.executeQuery(sql_threfid);
											while(rs_threfid.next())
											{
												String title = rs_threfid.getString("RP_DEPT_CODE");
												String title2 = rs_threfid.getString("DM_DEPT_DESC");
												String refid2 = rs_threfid.getString("RP_REF_ID");
												closing_edit_post2 = rs_threfid.getString(4);
									
												if(dept2!=null && dept2.equals(refid2))
												{
									
									%>
                  <option value='<%=refid2%>' selected><%=title2%> 
                  <% } else {%>
                  <option value='<%=refid2%>'><%=title2%> 
                  <%
												}
											}
											st_threfid.close ();
											rs_threfid.close ();
										}
										catch(Exception e)
										{
											System.out.println("Error in th_ref_id dept edit 2:"+e);
										}
									%>
                </select>
                <input name="closing_date2" type="hidden" id="closing_date2" value="<%=closing_edit_post2%>"> 
              </td>
            </tr>
            <tr> 
              <th scope="row"><div align="right"><span class="style5">Bidang : 
                  </span></div></th>
              <td> <select name="bidang2" size="1" id="bidang2" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                  <option value="">Pilih Bidang 
                  <%
								
										try
										{
											
											String sql_threfid = null;

												 sql_threfid =	 "SELECT NVL(RPD_MAJORING, '-') FROM recruitment_post_detl, recruitment_post "+
				 		  									 	 "where rp_ref_id=RPD_REF_ID and RPD_REF_ID ='"+ dept2 +"' ";
																						
											Statement st_threfid=conn.createStatement();
											ResultSet rs_threfid=st_threfid.executeQuery(sql_threfid);
											while(rs_threfid.next())
											{
												String refid2 = rs_threfid.getString(1);
									
												if(bidang2!=null && bidang2.equals(refid2))
												{
									
									%>
                  <option value='<%=refid2%>' selected><%=refid2%> 
                  <% } else {%>
                  <option value='<%=refid2%>'><%=refid2%> 
                  <%
												}
											}
											st_threfid.close ();
											rs_threfid.close ();
										}
										catch(Exception e)
										{
											System.out.println("Error in th_ref_id bidang edit 2:"+e);
										}
									%>
                </select> </td>
            </tr>
          </table>
        </div></th>
    </tr>
  </table>
  <div align="right"><br>
      <A HREF="javascript:refreshmain();" onMouseOver="window.status='Update';return true;"><IMG SRC="cms/eRecruitment/images/ic_update.gif" BORDER="0" ALT="Update"></A> 
  </div>
</form>
<% conn.close();%>