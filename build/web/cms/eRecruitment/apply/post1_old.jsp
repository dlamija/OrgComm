<table width="100%"  border="0" cellpadding="0" cellspacing="1" class='style2'>
                            <tr> 
                              <th scope="row" width="17%"><div align="right">Fakulti 
                                  : </div></th>
                              
    <td width="83%"> 
	<% if (request.getParameter("pilihan1") == null){%>
	  <select name="dept" id="dept" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
        <option value="null">Pilih Fakulti/Jabatan</option>
      </select>
	 <%} else if (request.getParameter("pilihan1") != null && request.getParameter("pilihan1").equals("akademik") || request.getParameter("pilihan1") != null && request.getParameter("pilihan1").equals("teknikal")){%>
      <select name="dept" size="1" id="dept"  value="" onChange = 'document.applForm.action="eRecruitment.jsp?action=borangpermohonan";document.applForm.submit();' style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                                  <option>Pilih Fakulti/Jabatan 
                                  <%
									try
									{
										Statement st_threfid=conn.createStatement();
										String sql_threfid =  null;
										sql_threfid =		"SELECT dm_dept_code, dm_dept_desc " +
															"FROM DEPARTMENT_MAIN " +
															"WHERE DM_LEVEL='1' " +
															"and DM_TYPE ='ACADEMIC' "+
															"ORDER BY dm_dept_desc";
										
										ResultSet rs_threfid=st_threfid.executeQuery(sql_threfid);
										while(rs_threfid.next())
										{
											String code = rs_threfid.getString("dm_dept_code");
											String desc = rs_threfid.getString("dm_dept_desc");
								
											if(dept!=null && dept.equals(code))
											{
								
								%>
                                  <option value='<%=code%>' selected><%=desc%> 
                                  <% } else { %>
                                  <option value='<%=code%>'><%=desc%> 
                                  <%
											}
										}
										st_threfid.close ();
										rs_threfid.close ();
									}
									catch(Exception e)
									{
										System.out.println("Error in th_ref_id dept:"+e);
									}
								%>
                                </select>
								<%} else if (request.getParameter("pilihan1") != null && request.getParameter("pilihan1").equals("sokongan")){%>
    							
      <select name="dept" size="1" id="dept"  value="" onChange = 'document.applForm.action="eRecruitment.jsp?action=borangpermohonan";document.applForm.submit();' style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
        <option>Pilih Fakulti/Jabatan 
								<%
									try
									{
										Statement st_threfid=conn.createStatement();
										String sql_threfid =  null;
										
										sql_threfid=		"SELECT dm_dept_code, dm_dept_desc " +
															"FROM DEPARTMENT_MAIN " +
															"WHERE DM_LEVEL='1' " +
															"and DM_TYPE ='ADMIN' "+
															"ORDER BY dm_dept_desc";
										
										ResultSet rs_threfid=st_threfid.executeQuery(sql_threfid);
										while(rs_threfid.next())
										{
											String code = rs_threfid.getString("dm_dept_code");
											String desc = rs_threfid.getString("dm_dept_desc");
								
											if(dept!=null && dept.equals(code))
											{
								
									%>
									<option value='<%=code%>' selected><%=desc%> 
									<% } else { %>
									<option value='<%=code%>'><%=desc%> 
									<%
											}
										}
										st_threfid.close ();
										rs_threfid.close ();
									}
									catch(Exception e)
									{
										System.out.println("Error in th_ref_id dept:"+e);
									}
								%>
							  </select>
							  <%} else {%>
							  <select name="dept" id="dept" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
								<option value="null">Pilih Fakulti/Jabatan</option>
							  </select>
      <%}%>
    </td>
                            </tr>
                            <tr> 
                              <th scope="row"><div align="right"><span class="style5">Jawatan 
                                  : </span></div></th>
                              <td> <p></p>
                                <select name="post1" size="1" id="post1" onChange='go();' style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                                  <option value="">Pilih Jawatan 
                                  <%
								
										try
										{
											Statement st_threfid=conn.createStatement();
											String sql_threfid = null;
											if (request.getParameter("pilihan1")!= null && request.getParameter("pilihan1").equals("akademik"))
												 sql_threfid =	"SELECT SS_JPA_CODE, RP_SERVICE_CODE, INITCAP(NVL(SS_SERVICE_DESC,' ')) SS_SERVICE_DESC,NVL(DM_DEPT_DESC,''),RP_REF_ID "+
																"FROM RECRUITMENT_POST,SERVICE_SCHEME,DEPARTMENT_MAIN "+
																"WHERE SS_SERVICE_CODE(+) = RP_SERVICE_CODE "+
																"AND DM_DEPT_CODE(+) = RP_DEPT_CODE "+
																"AND SYSDATE <= RP_CLOSING_DATE "+
																"AND RP_STATUS='OFFERED' "+
																"and RP_DEPT_CODE='" + dept +"' "+
																"and ss_grouping ='ACADEMIC' "+
																"ORDER BY RP_SERVICE_CODE ";
												else
												 sql_threfid =	"SELECT SS_JPA_CODE, RP_SERVICE_CODE, INITCAP(NVL(SS_SERVICE_DESC,' ')) SS_SERVICE_DESC,NVL(DM_DEPT_DESC,''),RP_REF_ID "+
																"FROM RECRUITMENT_POST,SERVICE_SCHEME,DEPARTMENT_MAIN "+
																"WHERE SS_SERVICE_CODE(+) = RP_SERVICE_CODE "+
																"AND DM_DEPT_CODE(+) = RP_DEPT_CODE "+
																"AND SYSDATE <= RP_CLOSING_DATE "+
																"AND RP_STATUS='OFFERED' "+
																"and RP_DEPT_CODE='" + dept +"' "+
																"and ss_grouping ='NON ACADEMIC' "+
																"ORDER BY RP_SERVICE_CODE ";
											
											ResultSet rs_threfid=st_threfid.executeQuery(sql_threfid);
											while(rs_threfid.next())
											{
												String title = rs_threfid.getString("SS_JPA_CODE");
												String title2 = rs_threfid.getString("SS_SERVICE_DESC");
												String refid2 = rs_threfid.getString("RP_REF_ID");
									
												if(ref!=null && ref.equals(refid2))
												{
									
									%>
                                  <option value='<%=refid2%>' selected><%=title%>-<%=title2%>
                                  <% } else {%>
                                  <option value='<%=refid2%>'><%=title%>-<%=title2%>
                                  <%
												}
											}
											st_threfid.close ();
											rs_threfid.close ();
										}
										catch(Exception e)
										{
											System.out.println("Error in th_ref_id jawatan:"+e);
										}
									%>
                                </select>
    </td>
                            </tr>
                            <tr> 
                              <th scope="row"><div align="right"><span class="style5">Bidang 
                                  : </span></div></th>
                              <td> 
                                <% if(flag!=true){%>
                                <em> - Tiada Bidang -</em> <input name="bidang" type="hidden">
                                <%} else if(flag!=false && request.getParameter("post1")!= null){%>
                                <%				
									String sql_status	=	 "SELECT NVL(RPD_MAJORING, '-') FROM recruitment_post_detl, recruitment_post " +
				 		  									 "where rp_ref_id=RPD_REF_ID and RPD_REF_ID ='"+ post1 +"' and rp_dept_code ='"+ dept +"' ";

											try
												{
												PreparedStatement stmt = conn.prepareStatement(sql_status);
												ResultSet rset = stmt.executeQuery ();
												if (rset.isBeforeFirst())
													{
										%>
																		
									  <select name="bidang" class="smallfont" id="bidang" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
										<option value="0">Pilih Bidang</option>
										<%	while (rset.next ()){%>
										<option<% if (request.getParameter("bidang")!=null&&request.getParameter("bidang").toString().equals(rset.getString(1))) { %> selected<% } %> value="<%= rset.getString( 1 ) %>"> 
										<%=rset.getString(1)%></option>
										<%}%>
										</select>
      <%
													}
												rset.close ();
												stmt.close ();
													}
												//}
											catch (SQLException e)
												{ out.println ("Error1 : " + e.toString ()); }
											//}
										%>
      <%}%>
    </td>
                            </tr>
                          </table>