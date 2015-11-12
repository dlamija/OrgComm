<table width="100%"  border="0" cellpadding="0" cellspacing="1" class='style2'>
                            <tr> 
                              <th scope="row" width="17%"><div align="right">Fakulti 
                                  : </div></th>
                              
    <td width="83%"> 
      <% if (request.getParameter("pilihan2") == null){%>
      <select name="dept2" id="dept2" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
        <option value="null">Pilih Fakulti/Jabatan</option>
      </select> 
      <%} else if (request.getParameter("pilihan2") != null && request.getParameter("pilihan2").equals("akademik") || request.getParameter("pilihan2") != null && request.getParameter("pilihan2").equals("teknikal")){%>
      <select name="dept2" size="1" id="dept2"  value="" onChange = 'document.applForm.action="eRecruitment.jsp?action=borangpermohonan";document.applForm.submit();' style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
        <option>Pilih Fakulti/Jabatan 
        <%
									try
									{
										Statement st_threfid2=conn.createStatement();
										String sql_threfid2 =  null;
										sql_threfid2 =		"SELECT dm_dept_code, dm_dept_desc " +
															"FROM DEPARTMENT_MAIN " +
															"WHERE DM_LEVEL='1' " +
															"and DM_TYPE ='ACADEMIC' "+
															"ORDER BY dm_dept_desc";
										
										ResultSet rs_threfid2=st_threfid2.executeQuery(sql_threfid2);
										while(rs_threfid2.next())
										{
											String code2 = rs_threfid2.getString("dm_dept_code");
											String desc2 = rs_threfid2.getString("dm_dept_desc");
								
											if(dept2!=null && dept2.equals(code2))
											{
								
										%>
										<option value='<%=code2%>' selected><%=desc2%> 
										<% } else { %>
										<option value='<%=code2%>'><%=desc2%> 
										<%
											}
										}
										st_threfid2.close ();
										rs_threfid2.close ();
									}
									catch(Exception e)
									{
										System.out.println("Error in th_ref_id dept2:"+e);
									}
								%>
      </select> 
      <%}else if (request.getParameter("pilihan2") != null && request.getParameter("pilihan2").equals("sokongan")){%>
      <select name="dept2" size="1" id="dept2"  value="" onChange = 'document.applForm.action="eRecruitment.jsp?action=borangpermohonan";document.applForm.submit();' style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
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
								
											if(dept2!=null && dept2.equals(code))
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
										System.out.println("Error in th_ref_id dept2:"+e);
									}
								%>
							  </select> 
							  <%} else {%>
							  <select name="dept2" id="dept2" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
								<option value="null">Pilih Fakulti/Jabatan</option>
							  </select>
      <%}%>
    </td>
                            </tr>
                            <tr> 
                              <th scope="row"><div align="right"><span class="style5">Jawatan 
                                  : </span></div></th>
                              <td> <p></p>
                                
						  <select name="post2" size="1" id="post2" onChange='go2();' style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
							<option value="">Pilih Jawatan 
                                  <%
										try
										{
											Statement st_threfid=conn.createStatement();
											String sql_threfid = null;
											if (request.getParameter("pilihan2")!=null && request.getParameter("pilihan2").equals("akademik"))
												 sql_threfid =	"SELECT SS_JPA_CODE, RP_SERVICE_CODE, INITCAP(NVL(SS_SERVICE_DESC,' ')) SS_SERVICE_DESC,NVL(DM_DEPT_DESC,''),RP_REF_ID "+
																"FROM RECRUITMENT_POST,SERVICE_SCHEME,DEPARTMENT_MAIN "+
																"WHERE SS_SERVICE_CODE(+) = RP_SERVICE_CODE "+
																"AND DM_DEPT_CODE(+) = RP_DEPT_CODE "+
																"AND SYSDATE <= RP_CLOSING_DATE "+
																"AND RP_STATUS='OFFERED' "+
																"and RP_DEPT_CODE='" + dept2 +"' "+
																"and ss_grouping ='ACADEMIC' "+
																"ORDER BY RP_SERVICE_CODE ";
												else
												 sql_threfid =	"SELECT SS_JPA_CODE, RP_SERVICE_CODE, INITCAP(NVL(SS_SERVICE_DESC,' ')) SS_SERVICE_DESC,NVL(DM_DEPT_DESC,''),RP_REF_ID "+
																"FROM RECRUITMENT_POST,SERVICE_SCHEME,DEPARTMENT_MAIN "+
																"WHERE SS_SERVICE_CODE(+) = RP_SERVICE_CODE "+
																"AND DM_DEPT_CODE(+) = RP_DEPT_CODE "+
																"AND SYSDATE <= RP_CLOSING_DATE "+
																"AND RP_STATUS='OFFERED' "+
																"and RP_DEPT_CODE='" + dept2 +"' "+
																"and ss_grouping ='NON ACADEMIC' "+
																"ORDER BY RP_SERVICE_CODE ";
											
											ResultSet rs_threfid=st_threfid.executeQuery(sql_threfid);
											while(rs_threfid.next())
											{
												String title = rs_threfid.getString("SS_JPA_CODE");
												String title2 = rs_threfid.getString("SS_SERVICE_DESC");
												String refid2 = rs_threfid.getString("RP_REF_ID");
									
												if(post2!=null && post2.equals(refid2))
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
											System.out.println("Error in th_ref_id jawatan2:"+e);
										}
									%>
                                </select>
    </td>
                            </tr>
                            <tr> 
                              <th scope="row"><div align="right"><span class="style5">Bidang 
                                  : </span></div></th>
                              
    <td> 
      <% if(flag2!=true){%>
      <em> - Tiada Bidang -</em> <input name="bidang2" type="hidden">
      <%} else if(flag2!=false && request.getParameter("post2")!= null){%>
      <%				
									String sql_status2	=	 "SELECT NVL(RPD_MAJORING, '-') FROM recruitment_post_detl, recruitment_post " +
				 		  									 "where rp_ref_id=RPD_REF_ID and RPD_REF_ID ='"+ post2 +"' and rp_dept_code ='"+ dept2 +"' ";

											try
												{
												PreparedStatement stmt2 = conn.prepareStatement(sql_status2);
												ResultSet rset2 = stmt2.executeQuery ();
												if (rset2.isBeforeFirst())
													{
										%>
      <select name="bidang2" class="smallfont" id="bidang2" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
        <option value="">Pilih Bidang</option>
        <%	while (rset2.next ()){%>
        <option<% if (request.getParameter("bidang2")!=null&&request.getParameter("bidang2").toString().equals(rset2.getString(1))) { %> selected<% } %> value="<%= rset2.getString( 1 ) %>"> 
        <%=rset2.getString(1)%></option>
        <%}%>
      </select>
      <%
													}
												rset2.close ();
												stmt2.close ();
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