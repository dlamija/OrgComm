<table width="100%"  border="0" cellpadding="0" cellspacing="1" class='style2'>
                            <tr> 
                              <th scope="row" width="16%"><div align="right">Jawatan 
        : </div></th>
                              
    <td width="84%"><b><font face="Geneva, Arial, Helvetica, san-serif">
                                &nbsp;&nbsp;&nbsp;<select name="post1" id="post1" onchange='go();' style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;"><option>Pilih Jawatan Pilihan Pertama 
                                  <%
PreparedStatement pstmt2 = null;
ResultSet rset2 = null;


	if (conn!=null)
	{
		String sql2	= "select ss_jpa_code,ss_service_desc,to_char(RPH_CLOSING_DATE,'dd-mm-yyyy'),rph_service_code from "+
															"recruitment_post_head,service_scheme "+
															"where ss_service_code=rph_service_code "+
															"AND SYSDATE <= RPH_CLOSING_DATE "+
															"AND RPH_STATUS='OFFERED' "+
															"AND SS_GROUPING='"+ pilihan1 +"' ";

		try
		{
			pstmt2 = conn.prepareStatement(sql2);
			//pstmt.setString (1, session.getAttribute("staffid").toString());
			rset2 = pstmt2.executeQuery ();
			while (rset2.next ())
			{
																
				if (request.getParameter("post1")!=null && request.getParameter("post1").compareTo(rset2.getString(4))==0)
				{ 
%>
                                  <option value="<%=rset2.getString(4)%>" selected="selected"><%=rset2.getString(1)%> - <%=rset2.getString(2)%></option>
                                  <% 
				}
				else
				{
%>
                                  <option value="<%=rset2.getString(4)%>"><%=rset2.getString(1)%> - <%=rset2.getString(2)%></option>
                                  <% 
				}
			}
			//pstmt.close ();
		}
		catch( Exception e )
		{ out.println (e.toString()); }
	finally {
		try {
			if (rset2 != null) rset2.close();
			if (pstmt2 != null) pstmt2.close();
			//if (conn != null) conn.close();
		}
		catch (Exception e) { }
		}
	}
%>
                                </select>
      </font></b></td>
                            </tr>
                            <tr> 
                              <th scope="row"><div align="right"><span class="style5">Fakulti 
        : </span></div></th>
                              <td> <p></p>
                                
      <b><font face="Geneva, Arial, Helvetica, san-serif"> &nbsp;&nbsp; 
      <select name="dept" id="dept" onchange='document.applForm.action="eRecruitment.jsp?action=borangpermohonan";document.applForm.submit();'  style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
        <option value="">Pilih Jabatan/Fakulti 
        <%
PreparedStatement pstmt3 = null;
ResultSet rset3 = null;

	if (conn!=null)
	{
		String sql3	=	"SELECT RP_REF_ID,RP_DEPT_CODE,DM_DEPT_DESC,to_char(RPH_CLOSING_DATE,'dd-mm-yyyy') FROM "+
																"RECRUITMENT_POST,RECRUITMENT_POST_HEAD,DEPARTMENT_MAIN "+
																"WHERE RP_POST_ID=RPH_POST_ID "+
																"AND RP_DEPT_CODE = DM_DEPT_CODE "+
																"AND RP_SERVICE_CODE='"+ post1 +"' "+
																"AND RP_STATUS='OFFERED' ";

		try
		{
			pstmt3 = conn.prepareStatement(sql3);
			//pstmt.setString (1, session.getAttribute("staffid").toString());
			rset3 = pstmt3.executeQuery ();
			while (rset3.next ())
			{
				closing_date = rset3.getString(4);
												
				if (request.getParameter("dept")!=null && request.getParameter("dept").compareTo(rset3.getString(1))==0)
				{ 
%>
        <option value="<%=rset3.getString(1)%>" selected="selected"><%=rset3.getString(3)%></option>
        <% 
				}
				else
				{
%>
        <option value="<%=rset3.getString(1)%>"><%=rset3.getString(3)%></option>
        <% 
				}
			}
			//pstmt.close ();
		}
		catch( Exception e )
		{ out.println (e.toString()); }
	finally {
		try {
			if (rset3 != null) rset3.close();
			if (pstmt3 != null) pstmt3.close();
			//if (conn != null) conn.close();
		}
		catch (Exception e) { }
		}
	}
%>
      </select>
      <input name="closing_date_post1" type="hidden" id="closing_date_post1" value="<%=closing_date%>">
      </font></b></td>
                            </tr>
                            <tr> 
                              <th scope="row"><div align="right"><span class="style5">Bidang 
                                  : </span></div></th>
                              
    <td><b><font face="Geneva, Arial, Helvetica, san-serif">
      &nbsp;&nbsp;&nbsp;<select name="bidang" id="bidang" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
        <option value="">Pilih Bidang
          <%
PreparedStatement pstmt4 = null;
ResultSet rset4 = null;

	if (conn!=null)
	{
		String sql4	=	 "SELECT NVL(RPD_MAJORING, '-') FROM recruitment_post_detl, recruitment_post "+
				 		  									 	 "where rp_ref_id=RPD_REF_ID and RPD_REF_ID ='"+ dept +"' ";

		try
		{
			pstmt4 = conn.prepareStatement(sql4);
			//pstmt.setString (1, session.getAttribute("staffid").toString());
			rset4 = pstmt4.executeQuery ();
			while (rset4.next ())
			{
				
												
				if (request.getParameter("bidang")!=null && request.getParameter("bidang").compareTo(rset4.getString(1))==0)
				{ 
%>
        </option>
        <option value="<%=rset4.getString(1)%>" selected="selected"><%=rset4.getString(1)%></option>
        <% 
				}
				else
				{
%>
        <option value="<%=rset4.getString(1)%>"><%=rset4.getString(1)%></option>
        <% 
				}
			}
			//pstmt.close ();
		}
		catch( Exception e )
		{ out.println (e.toString()); }
	finally {
		try {
			if (rset4 != null) rset4.close();
			if (pstmt4 != null) pstmt4.close();
			//if (conn != null) conn.close();
		}
		catch (Exception e) { }
		}
	}
%>
      </select>
      </font></b></td>
                            </tr>
                          </table>