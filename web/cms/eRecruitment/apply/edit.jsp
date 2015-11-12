<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ page import="common.Messages" %>

<%
	Connection conn = null;
	String message = null;
	String kadpengenalan= (String)session.getAttribute("kadpengenalan");	
	String action = request.getParameter("action");
	String dept = request.getParameter("dept");
	String dept2 = request.getParameter("dept2");
	String post2 = request.getParameter("post2");
	String bidang_post1 = request.getParameter("bidang_post1");
	String bidang_post2 = request.getParameter("bidang_post2");
   	String nama = request.getParameter("nama");
	String jantina = request.getParameter("jantina");
	String newic = request.getParameter("newic");
	String passport = request.getParameter("passport");
	String addr_cur = request.getParameter("addr_cur");
	String addr_cur_city = request.getParameter("addr_cur_city");
	String addr_cur_state = request.getParameter("addr_cur_state");
	String addr_cur_country = request.getParameter("addr_cur_country");
	String postcode_cur = request.getParameter("postcode_cur");
	String phone = request.getParameter("phone");
	String email = request.getParameter("email");
	String tarikhlahir = request.getParameter("tarikhlahir");
	String umur = request.getParameter("umur");
	String hphone = request.getParameter("hphone");
	String insti_name = request.getParameter("insti_name");
	String yearFrom = request.getParameter("insti_year_from");
	String yearTo = request.getParameter("insti_year_to");
	String qualification =request.getParameter("insti_qual");
	String instiClass= request.getParameter("insti_class");
	String clasify = request.getParameter("clasify");
	String extra = request.getParameter("extra");
	String sport = request.getParameter("sport");
	String employer_name = request.getParameter("employer_name");
	String employer_address = request.getParameter("employer_address");
	String post= request.getParameter("post");
	String salary= request.getParameter("salary");
	String date_from = request.getParameter("date_from");
	String date_to = request.getParameter("date_to");
	String type = request.getParameter("type");
	String type_desc= request.getParameter("others");
	String gov_staff= request.getParameter("gov_staff");
	String addr_perm= request.getParameter("addr_perm");
	String addr_perm_city= request.getParameter("addr_perm_city");
	String addr_perm_state = request.getParameter("addr_perm_state");
	String postcode_perm = request.getParameter("postcode_perm");
	String school_name = request.getParameter("school_name");
	String school_year= request.getParameter("school_year");
	String school_qual= request.getParameter("school_qual");
	String school_bm= request.getParameter("school_bm");
	String school_bi = request.getParameter("school_bi");
	String school_math = request.getParameter("school_mate");
	String insti_cgpa_degree = request.getParameter("insti_cgpa_degree");
	String jum_tahun= request.getParameter("jum_tahun");
	String t_mula= request.getParameter("t_mula");
	String insti_class_degree= request.getParameter("insti_class_degree");
	String refid=request.getParameter("refid");
	String marital = request.getParameter("marital");
	String A = request.getParameter("A");
	String B = request.getParameter("B");
	String B1 = request.getParameter("B1");
	String B2 = request.getParameter("B2");
	String C = request.getParameter("C");
	String D = request.getParameter("D");
	String E = request.getParameter("E");
	String E1 = request.getParameter("E1");
	String E2 = request.getParameter("E2");
	String F = request.getParameter("F");
	String G = request.getParameter("G");
	String H = request.getParameter("H");
	String I = request.getParameter("I");
	String nama_penjamin1 = request.getParameter("nama_penjamin1");
	String alamat_penjamin1 = request.getParameter("alamat_penjamin1");
	String pekerjaan_penjamin1 = request.getParameter("pekerjaan_penjamin1");
	String tel_penjamin1 = request.getParameter("tel_penjamin1");
	String nama_penjamin2 = request.getParameter("nama_penjamin2");
	String alamat_penjamin2 = request.getParameter("alamat_penjamin2");
	String pekerjaan_penjamin2 = request.getParameter("pekerjaan_penjamin2");
	String tel_penjamin2 = request.getParameter("tel_penjamin2");
	String jpa = request.getParameter("jpa");
	String closing_date1 = request.getParameter("closing_date1");
	String closing_date2 = request.getParameter("closing_date2");

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
<% 
if(action!=null && action.equals("edit"))
{
	/*String filterClosingDate2 = "";
		if (request.getParameter("closing_date2") == null) 
			filterClosingDate2 = ",sch_closing_date_post2 = to_char(to_date(?,'dd/mm/yyyy'))"; */
			
//insert into staff_candidate_head
String sql_inst = 	"UPDATE STAFF_CANDIDATE_HEAD "+
		      		"SET sch_name = ?, "+
					"sch_gender = ?, "+
					"sch_ic_num = ?, "+
					"sch_pasport_num = ?, "+
					"sch_current_address = ?,"+
					"sch_current_city = ?, "+
					"sch_current_state = ?, "+
					"sch_current_country = ?, "+
					"sch_current_pcode = ?, "+
					"sch_current_telno = ?, "+
					"sch_email_addr = ?,"+
					"sch_birth_date = to_char(to_date(?,'dd/mm/yyyy')), "+
					"sch_age = ?, "+
					"sch_handphone_no = ?, "+
					"sch_co_curriculum_activity = ?, "+
					"SCH_SPORT_ACTIVITY = ?, "+
					"SCH_PERMANENT_ADDRESS = ?, "+
					"SCH_PERMANENT_PCODE = ?, "+
					"SCH_PERMANENT_CITY = ?, "+
					"SCH_PERMANENT_STATE = ?, "+
					"SCH_GOV_STAFF = ?, "+
					"SCH_MARITAL_STATUS = ?, "+
					"SCH_RECOMMENDER1_NAME = ?, "+                 
					"SCH_RECOMMENDER1_ADDRESS = ?, "+              
					"SCH_RECOMMENDER1_WORK_DESC = ?, "+            
					"SCH_RECOMMENDER1_CONTACT_NUM = ?, "+          
					"SCH_RECOMMENDER2_NAME = ?, "+                 
					"SCH_RECOMMENDER2_ADDRESS = ?, "+              
					"SCH_RECOMMENDER2_WORK_DESC = ?, "+            
					"SCH_RECOMMENDER2_CONTACT_NUM = ?, "+  
					"SCH_JPA = ?, "+
					"SCH_APPLY_DATE = sysdate "+ 
					/* "sch_post_1 = ?, "+
				   "sch_majoring1 = ?, "+
				   "sch_closing_date_post1 = to_char(to_date(?,'dd/mm/yyyy')), "+
				    "sch_post_2 = ? ,"+
				   "sch_majoring2 = ? "+
				   filterClosingDate2 +*/
					"WHERE SCH_REF_ID = ? ";
	try
	{
		//System.out.println("dah masuk candidate");
		//System.out.println(refid);
		PreparedStatement pstmt = conn.prepareCall(sql_inst);
		pstmt.setString(1, nama);
		pstmt.setString(2, jantina);
		pstmt.setString(3, newic);
		pstmt.setString(4, passport);
		pstmt.setString(5, addr_cur);
		pstmt.setString(6, addr_cur_city);
		pstmt.setString(7, addr_cur_state);
		pstmt.setString(8, addr_cur_country);
		pstmt.setString(9, postcode_cur);
		pstmt.setString(10, phone);
		pstmt.setString(11, email);
		pstmt.setString(12, tarikhlahir);
		pstmt.setString(13, umur);
		pstmt.setString(14, hphone);
		pstmt.setString(15,extra);
		pstmt.setString(16,sport);
		pstmt.setString(17,addr_perm);
		pstmt.setString(18,postcode_perm);
		pstmt.setString(19,addr_perm_city);
		pstmt.setString(20,addr_perm_state);
		pstmt.setString(21, gov_staff);
		pstmt.setString(22, marital);
		pstmt.setString(23, nama_penjamin1);
		pstmt.setString(24, alamat_penjamin1);
		pstmt.setString(25, pekerjaan_penjamin1);
		pstmt.setString(26, tel_penjamin1);
		pstmt.setString(27, nama_penjamin2);
		pstmt.setString(28, alamat_penjamin2);
		pstmt.setString(29, pekerjaan_penjamin2);
		pstmt.setString(30, tel_penjamin2);
		pstmt.setString(31, jpa);
		pstmt.setString(32, refid);
		/*pstmt.setString(32, dept);
		pstmt.setString(33, bidang_post1);
		pstmt.setString(34, closing_date1);
		pstmt.setString(35, dept2);
		pstmt.setString(36, bidang_post2);
		if (request.getParameter("closing_date2") == null)
		{
		pstmt.setString(37, closing_date2);
		pstmt.setString(38, refid);
		} else if (request.getParameter("closing_date2") != null)
		pstmt.setString(37, refid);
		//System.out.println("belum execute");*/
		pstmt.execute();
		pstmt.close ();
	}
	catch (SQLException e)
	{ 
		out.println ("Error candidate: " + e.toString ()); 
	}
//conn.commit();	

//insert into staff_candidate_institution
				
String sql_inst2 = 	"UPDATE STAFF_CANDIDATE_INSTITUTION "+
		      		"SET sci_institution_name = nvl(?,'-'), "+
					"sci_year_from = nvl(?,0), "+
					"sci_year_to = nvl(?,0), "+
					"sci_qualification = ?, "+
					"sci_class = ?, "+
					"sci_classification = ?, "+
					"sci_cgpa_degree = ?, "+
					"sci_class_degree = ? "+
					"WHERE SCI_CANDIDATE_REFID = ? ";
	try
	{
		PreparedStatement pstmt2 = conn.prepareCall(sql_inst2);
		pstmt2.setString(1, insti_name);
		pstmt2.setString(2, yearFrom);
		pstmt2.setString(3, yearTo);
		pstmt2.setString(4, qualification);
		pstmt2.setString(5, instiClass);
		pstmt2.setString(6, clasify);
		pstmt2.setString(7, insti_cgpa_degree);
		pstmt2.setString(8, insti_class_degree);
		pstmt2.setString(9, refid);
		pstmt2.execute();
		pstmt2.close ();
	}
	catch (SQLException e)
	{ 
		out.println ("Error institution: " + e.toString ()); 
	}

//insert into staff_candidate_experience

String sql_inst3 = 	"UPDATE STAFF_CANDIDATE_EXPERIENCE "+
		      		"SET SCE_EMPLOYER_NAME = nvl(?,'-'), "+
					"SCE_EMPLOYER_ADDRESS = nvl(?,'-'), "+
					"SCE_POST = nvl(?,'-'), "+
					"SCE_BASIC_SALARY = nvl(?,0), "+
					"SCE_DATE_FROM = to_date(?,'DD-MM-YYYY'), "+
					"sce_total_year = nvl(?,0) "+
					"WHERE SCE_CANDIDATE_REFID = ? ";
	try
	{
		PreparedStatement pstmt3 = conn.prepareCall(sql_inst3);
		pstmt3.setString(1, employer_name);
		pstmt3.setString(2, employer_address);
		pstmt3.setString(3, post);
		pstmt3.setString(4, salary);
		pstmt3.setString(5, t_mula);
		pstmt3.setString(6, jum_tahun);
		pstmt3.setString(7, refid);
		pstmt3.execute();
		pstmt3.close ();
	}
	catch (SQLException e)
	{ 
		out.println ("Error employer: " + e.toString ()); 
	}

//insert into staff_candidate_licence

String sql_inst5 = 	"UPDATE STAFF_CANDIDATE_LICENCE "+
		      		"SET SCL_A = ? ,"+ 
					"SCL_B = ? ,"+
					"SCL_B1 = ? ,"+
					"SCL_B2 = ? ,"+
					"SCL_C = ? ,"+ 
					"SCL_D = ? ,"+ 
					"SCL_E = ? ,"+ 
					"SCL_E1 = ? ,"+
					"SCL_E2 = ? ,"+
					"SCL_F = ? ,"+ 
					"SCL_G = ? ,"+ 
					"SCL_H = ? ,"+ 
					"SCL_I = ? "+
					"WHERE SCL_REF_ID = ? ";
	try
	{
		PreparedStatement pstmt5 = conn.prepareCall(sql_inst5);
		pstmt5.setString(1, A);
		pstmt5.setString(2, B);
		pstmt5.setString(3, B1);
		pstmt5.setString(4, B2);
		pstmt5.setString(5, C);
		pstmt5.setString(6, D);
		pstmt5.setString(7, E);
		pstmt5.setString(8, E1);
		pstmt5.setString(9, E2);
		pstmt5.setString(10, F);
		pstmt5.setString(11, G);
		pstmt5.setString(12, H);
		pstmt5.setString(13, I);
		pstmt5.setString(14, refid);
		pstmt5.execute();
		pstmt5.close ();
	}
	catch (SQLException e)
	{ 
		out.println ("Error licence: " + e.toString ()); 
	}

//insert into staff_candidate_school
					
String sql_inst4 = 	"UPDATE staff_candidate_school "+
		      		"SET SCS_YEAR = nvl(?,0), "+
					"SCS_SCHOOL = ?, "+
					"SCS_QUALIFICATION_CODE = ?, "+
					"SCS_RESULT_BM = ?, "+
					"SCS_RESULT_BI = ?, "+
					"SCS_RESULT_MATH = ? "+
					"WHERE SCS_CANDIDATE_REFID = ? ";
	try
	{
		PreparedStatement pstmt4 = conn.prepareCall(sql_inst4);
		pstmt4.setString(1, school_year);
		pstmt4.setString(2, school_name);
		pstmt4.setString(3, school_qual);
		pstmt4.setString(4, school_bm);
		pstmt4.setString(5, school_bi);
		pstmt4.setString(6, school_math);
		pstmt4.setString(7, refid);
		pstmt4.execute();
		pstmt4.close ();
	}
	catch (SQLException e)
	{ 
		out.println ("Error scholl: " + e.toString ()); 
	}	
	//response.sendRedirect("../../eRecruitment.jsp?action=editborang&refid="+refid);	
	//tak betul nie vresponse.sendRedirect("../../eRecruitment.jsp?action=editborang&refid="+refid+"&ic_no="+newic);	

%>
<SCRIPT LANGUAGE="JavaScript">
			location="eRecruitment.jsp?action=editborang&refid=<%=refid%>";
		</SCRIPT>
<%}
conn.close();
%>

