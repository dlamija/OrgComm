<table width="100%"  border="0" cellpadding="0" cellspacing="1" class='style2'>
                            <tr> 
                              <th scope="row" width="16%"><div align="right">Jawatan 
        : </div></th>
                              
    <td width="84%"><b><font face="Geneva, Arial, Helvetica, san-serif">
     &nbsp;&nbsp;&nbsp;<select name="post2" id="post2" onchange='go2();' style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
        <option>Pilih Jawatan Pilihan Pertama
          <%
PreparedStatement pstmt5 = null;
ResultSet rset5 = null;

	if (conn!=null)
	{
		String sql5	= "select ss_jpa_code,ss_service_desc,RPH_CLOSING_DATE,rph_service_code from "+
															"recruitment_post_head,service_scheme "+
															"where ss_service_code=rph_service_code "+
															"AND SYSDATE <= RPH_CLOSING_DATE "+
															"AND RPH_STATUS='OFFERED' "+
															"AND SS_GROUPING='"+ pilihan2 +"' ";

		try
		{
			pstmt5 = conn.prepareStatement(sql5);
			//pstmt.setString (1, session.getAttribute("staffid").toString());
			rset5 = pstmt5.executeQuery ();
			while (rset5.next ())
			{
				
												
				if (request.getParameter("post2")!=null && request.getParameter("post2").compareTo(rset5.getString(4))==0)
				{ 
%>
        </option>
        <option value="<%=rset5.getString(4)%>" selected="selected"><%=rset5.getString(1)%> - <%=rset5.getString(2)%></option>
        <% 
				}
				else
				{
%>
        <option value="<%=rset5.getString(4)%>"><%=rset5.getString(1)%> - <%=rset5.getString(2)%></option>
        <% 
				}
			}
			//pstmt.close ();
		}
		catch( Exception e )
		{ out.println (e.toString()); }
	finally {
		try {
			if (rset5 != null) rset5.close();
			if (pstmt5 != null) pstmt5.close();
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
&nbsp;&nbsp;<select name="dept2" id="dept2" onchange='document.applForm.action="eRecruitment.jsp?action=borangpermohonan";document.applForm.submit();'  style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
      <option value=" ">Pilih Jabatan/Fakulti 
        <%
PreparedStatement pstmt6 = null;
ResultSet rset6 = null;

	if (conn!=null)
	{
		String sql6	=	"SELECT RP_REF_ID,RP_DEPT_CODE,DM_DEPT_DESC,to_char(RPH_CLOSING_DATE,'dd-mm-yyyy') FROM "+
																"RECRUITMENT_POST,RECRUITMENT_POST_HEAD,DEPARTMENT_MAIN "+
																"WHERE RP_POST_ID=RPH_POST_ID "+
																"AND RP_DEPT_CODE = DM_DEPT_CODE "+
																"AND RP_SERVICE_CODE='"+ post2 +"' "+
																"AND RP_STATUS='OFFERED' ";

		try
		{
			pstmt6 = conn.prepareStatement(sql6);
			//pstmt.setString (1, session.getAttribute("staffid").toString());
			rset6 = pstmt6.executeQuery ();
			while (rset6.next ())
			{
				closing_date2 = rset6.getString(4);
												
				if (request.getParameter("dept2")!=null && request.getParameter("dept2").compareTo(rset6.getString(1))==0)
				{ 
%>
        <option value="<%=rset6.getString(1)%>" selected="selected"><%=rset6.getString(3)%></option>
        <% 
				}
				else
				{
%>
        <option value="<%=rset6.getString(1)%>"><%=rset6.getString(3)%></option>
        <% 
				}
			}
			//pstmt.close ();
		}
		catch( Exception e )
		{ out.println (e.toString()); }
	finally {
		try {
			if (rset6 != null) rset6.close();
			if (pstmt6 != null) pstmt6.close();
			//if (conn != null) conn.close();
		}
		catch (Exception e) { }
		}
	}
%>
      </select>
      <b><font face="Geneva, Arial, Helvetica, san-serif">
      <input name="closing_date_post2" type="hidden" id="closing_date_post2" value="<%=( ( closing_date2==null)?"-":closing_date2 )%>">
      </font></b></td>
                            </tr>
                            <tr> 
                              <th scope="row"><div align="right"><span class="style5">Bidang 
                                  : </span></div></th>
                              
    <td> 
<b><font face="Geneva, Arial, Helvetica, san-serif">
&nbsp;&nbsp;&nbsp;<select name="bidang2" id="bidang2" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
        <option value="">Pilih Bidang
          <%
PreparedStatement pstmt7 = null;
ResultSet rset7 = null;

	if (conn!=null)
	{
		String sql7	=	  "SELECT NVL(RPD_MAJORING, '-') FROM recruitment_post_detl, recruitment_post "+
				 		  									 	 "where rp_ref_id=RPD_REF_ID and RPD_REF_ID ='"+ dept2 +"' ";

		try
		{
			pstmt7 = conn.prepareStatement(sql7);
			//pstmt.setString (1, session.getAttribute("staffid").toString());
			rset7 = pstmt7.executeQuery ();
			while (rset7.next ())
			{
				
												
				if (request.getParameter("bidang2")!=null && request.getParameter("bidang2").compareTo(rset7.getString(1))==0)
				{ 
%>
        </option>
        <option value="<%=rset7.getString(1)%>" selected="selected"><%=rset7.getString(1)%></option>
        <% 
				}
				else
				{
%>
        <option value="<%=rset7.getString(1)%>"><%=rset7.getString(1)%></option>
        <% 
				}
			}
			//pstmt.close ();
		}
		catch( Exception e )
		{ out.println (e.toString()); }
	finally {
		try {
			if (rset7 != null) rset7.close();
			if (pstmt7 != null) pstmt7.close();
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