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
	String bidang = request.getParameter("bidang");
	String bidang2 = request.getParameter("bidang2");
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
	String closing_date_post1 = request.getParameter("closing_date_post1");
	String closing_date_post2 = request.getParameter("closing_date_post2");
	
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
if(action!=null && action.equals("save"))
{
//select refid from staff_candidate_head_seq

String sql	=	"SELECT TO_CHAR(SYSDATE,'YYYY')||'-'||LTRIM(TO_CHAR(STAFF_CANDIDATE_HEAD_SEQ.NEXTVAL,'000000')) "+
				"FROM DUAL ";

	try
	{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
		{
		refid = rset.getString (1);
		}
		pstmt.close ();
	}
	catch (SQLException e)
	{ out.println ("Error select refid: " + e.toString ());}

//insert into staff_candidate_head
if (refid.compareTo("") != 0 && nama.compareTo("") != 0 && jantina.compareTo("") != 0 && newic.compareTo("") != 0 && addr_cur.compareTo("") != 0 && addr_cur_city.compareTo("") != 0 && addr_cur_state.compareTo("") != 0 && addr_cur_country.compareTo("") != 0 && postcode_cur.compareTo("") != 0 && phone.compareTo("") != 0 && email.compareTo("") != 0 && tarikhlahir.compareTo("") !=0 && umur.compareTo("") != 0 && hphone.compareTo("") != 0 && addr_perm.compareTo("") != 0 && postcode_perm.compareTo("") != 0 && addr_perm_city.compareTo("") != 0 && addr_perm_state.compareTo("") != 0 && gov_staff.compareTo("") != 0 && marital.compareTo("") != 0 && nama_penjamin1.compareTo("") != 0 && alamat_penjamin1.compareTo("") != 0 && pekerjaan_penjamin1.compareTo("") != 0 && tel_penjamin1.compareTo("") != 0 && nama_penjamin2.compareTo("") != 0 && alamat_penjamin2.compareTo("") != 0 && pekerjaan_penjamin2.compareTo("") != 0 && tel_penjamin2.compareTo("") != 0 && jpa.compareTo("") != 0)
{
	String filterClosingDate2 = "";
	String filterClosingFieldDate2 = "";
	String filterDept2 = "";
	String filterDeptField2 = "";
	
	
		if (!closing_date_post2.equals("-")) 
			{filterClosingFieldDate2 = ",SCH_CLOSING_DATE_POST2,sch_post_2,sch_majoring2";
			filterClosingDate2 = ",to_char(to_date(?,'dd-mm-yyyy')),?,?";
			}
						System.out.println("date closing :"+closing_date_post2);
						System.out.println("filter :"+filterClosingFieldDate2);
		
String sql_inst = 	"INSERT INTO STAFF_CANDIDATE_HEAD "+
		      		"(SCH_REF_ID,sch_post_1,sch_majoring1,sch_name,sch_gender, "+
					" sch_ic_num,sch_pasport_num,sch_current_address,sch_current_city,sch_current_state, "+
					" sch_current_country,sch_current_pcode,sch_current_telno, sch_email_addr ,sch_birth_date, "+
					" sch_age,sch_handphone_no,sch_status,sch_apply_date,sch_co_curriculum_activity, SCH_SPORT_ACTIVITY, "+
					" SCH_PERMANENT_ADDRESS,SCH_PERMANENT_PCODE,SCH_PERMANENT_CITY,SCH_PERMANENT_STATE, SCH_ARCHIVE,SCH_GOV_STAFF,SCH_MARITAL_STATUS, "+
		 	  		" SCH_RECOMMENDER1_NAME,SCH_RECOMMENDER1_ADDRESS,SCH_RECOMMENDER1_WORK_DESC,SCH_RECOMMENDER1_CONTACT_NUM,SCH_RECOMMENDER2_NAME, "+
					" SCH_RECOMMENDER2_ADDRESS,SCH_RECOMMENDER2_WORK_DESC,SCH_RECOMMENDER2_CONTACT_NUM,SCH_JPA,SCH_CLOSING_DATE_POST1 "+
					filterClosingFieldDate2 +
					") "+		
					"VALUES "+
		      		"(?,?,?,?,?,?,?,?,?,?,?,?,?,?,to_char(to_date(?,'dd/mm/yyyy')),?,?,'APPLY',sysdate,?,?,?,?,?,?,'N',?,?,?,?,?,?,?,?,?,?,?,to_char(to_date(?,'dd-mm-yyyy')) "+
					filterClosingDate2 +
					") ";
	try
	{
		//System.out.println("dah masuk candidate");
		System.out.println(sql_inst);
		PreparedStatement pstmt = conn.prepareCall(sql_inst);
		pstmt.setString(1, refid);
		pstmt.setString(2, dept);
		pstmt.setString(3, bidang);
		pstmt.setString(4, nama);
		pstmt.setString(5, jantina);
		pstmt.setString(6, newic);
		pstmt.setString(7, passport);
		pstmt.setString(8, addr_cur);
		pstmt.setString(9, addr_cur_city);
		pstmt.setString(10, addr_cur_state);
		pstmt.setString(11, addr_cur_country);
		pstmt.setString(12, postcode_cur);
		pstmt.setString(13, phone);
		pstmt.setString(14, email);
		pstmt.setString(15, tarikhlahir);
		pstmt.setString(16, umur);
		pstmt.setString(17, hphone);
		pstmt.setString(18,extra);
		pstmt.setString(19,sport);
		pstmt.setString(20,addr_perm);
		pstmt.setString(21,postcode_perm);
		pstmt.setString(22,addr_perm_city);
		pstmt.setString(23,addr_perm_state);
		pstmt.setString(24, gov_staff);
		pstmt.setString(25, marital);
		pstmt.setString(26, nama_penjamin1);
		pstmt.setString(27, alamat_penjamin1);
		pstmt.setString(28, pekerjaan_penjamin1);
		pstmt.setString(29, tel_penjamin1);
		pstmt.setString(30, nama_penjamin2);
		pstmt.setString(31, alamat_penjamin2);
		pstmt.setString(32, pekerjaan_penjamin2);
		pstmt.setString(33, tel_penjamin2);
		pstmt.setString (34, jpa);
		pstmt.setString(35, closing_date_post1);
		if (!closing_date_post2.equals("-")) {
		pstmt.setString(36, closing_date_post2);
		pstmt.setString(37, dept2);
		pstmt.setString(38, bidang2);
		}
		//System.out.println("belum execute");
		pstmt.execute();
		//System.out.println("dah execute");
		pstmt.close ();
	}
	catch (SQLException e)
	{ 
		out.println ("Error candidate: " + e.toString ()); 
	}
//conn.commit();	
}

if (refid.compareTo("") != 0) {
{
//insert into staff_candidate_institution
				
String sql_inst2 = 	"INSERT INTO STAFF_CANDIDATE_INSTITUTION "+
		      		"(sci_candidate_refid,sci_institution_name,sci_year_from,sci_year_to,sci_qualification, "+
					"sci_class,sci_classification,sci_cgpa_degree, sci_class_degree) "+
		 	  		"VALUES "+
		      		"(?,nvl(?,'-'),nvl(?,0),nvl(?,0),?,?,?,?,?) ";
	try
	{
		PreparedStatement pstmt2 = conn.prepareCall(sql_inst2);
		pstmt2.setString(1, refid);
		pstmt2.setString(2, insti_name);
		pstmt2.setString(3, yearFrom);
		pstmt2.setString(4, yearTo);
		pstmt2.setString(5, qualification);
		pstmt2.setString(6, instiClass);
		pstmt2.setString(7, clasify);
		pstmt2.setString(8, insti_cgpa_degree);
		pstmt2.setString(9, insti_class_degree);
		pstmt2.execute();
		pstmt2.close ();
	}
	catch (SQLException e)
	{ 
		out.println ("Error institution: " + e.toString ()); 
	}
//conn.commit();
}

{
//insert into staff_candidate_experience

String sql_inst3 = 	"INSERT INTO STAFF_CANDIDATE_EXPERIENCE "+
		      		"(SCE_CANDIDATE_REFID,SCE_EMPLOYER_NAME,SCE_EMPLOYER_ADDRESS,SCE_POST, "+
					" SCE_BASIC_SALARY, SCE_DATE_FROM, sce_total_year) "+
		 	  		"VALUES "+
		      		"(?,nvl(?,'-'),nvl(?,'-'),nvl(?,'-'),nvl(?,0),to_date(?,'DD/MM/YYYY'),nvl(?,0)) ";
					
	try
	{
		PreparedStatement pstmt3 = conn.prepareCall(sql_inst3);
		pstmt3.setString(1, refid);
		pstmt3.setString(2, employer_name);
		pstmt3.setString(3, employer_address);
		pstmt3.setString(4, post);
		pstmt3.setString(5, salary);
		pstmt3.setString(6, t_mula);
		pstmt3.setString(7, jum_tahun);
		pstmt3.execute();
		pstmt3.close ();
	}
	catch (SQLException e)
	{ 
		out.println ("Error EXPERIENCE : " + e.toString ()); 
	}
//conn.commit();
}

{
//insert into staff_candidate_licence 

String sql_inst5 = 	"INSERT INTO STAFF_CANDIDATE_LICENCE "+
		      		"(SCL_REF_ID,SCL_A,SCL_B,SCL_B1,SCL_B2,SCL_C,SCL_D,SCL_E,SCL_E1,SCL_E2,SCL_F,SCL_G,SCL_H,SCL_I )"+
		 	  		"VALUES "+
		      		"(?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
					
	try
	{
		PreparedStatement pstmt5 = conn.prepareCall(sql_inst5);
		pstmt5.setString(1, refid);
		pstmt5.setString(2, A);
		pstmt5.setString(3, B);
		pstmt5.setString(4, B1);
		pstmt5.setString(5, B2);
		pstmt5.setString(6, C);
		pstmt5.setString(7, D);
		pstmt5.setString(8, E);
		pstmt5.setString(9, E1);
		pstmt5.setString(10, E2);
		pstmt5.setString(11, F);
		pstmt5.setString(12, G);
		pstmt5.setString(13, H);
		pstmt5.setString(14, I);
		pstmt5.execute();
		pstmt5.close ();
	}
	catch (SQLException e)
	{ 
		out.println ("Error lesen : " + e.toString ()); 
	}
//conn.commit();
}

{

//insert into staff_candidate_school
					
String sql_inst4 = 	"INSERT INTO staff_candidate_school "+
		      		"(SCS_CANDIDATE_REFID,SCS_YEAR,SCS_SCHOOL,SCS_QUALIFICATION_CODE,SCS_RESULT_BM, "+
					"SCS_RESULT_BI, SCS_RESULT_MATH) "+
		 	  		"VALUES "+
		      		"(?,nvl(?,0),?,?,?,?,?) ";
					
	try
	{
		PreparedStatement pstmt4 = conn.prepareCall(sql_inst4);
		pstmt4.setString(1, refid);
		pstmt4.setString(2, school_year);
		pstmt4.setString(3, school_name);
		pstmt4.setString(4, school_qual);
		pstmt4.setString(5, school_bm);
		pstmt4.setString(6, school_bi);
		pstmt4.setString(7, school_math);
		pstmt4.execute();
		pstmt4.close ();
	}
	catch (SQLException e)
	{ 
		out.println ("Error school: " + e.toString ()); 
	}
	}
conn.commit();
//response.sendRedirect("../../eRecruitment.jsp?action=soalselidik&ic_no="+newic+"&refid="+refid);	
%>
<SCRIPT LANGUAGE="JavaScript">
			location="eRecruitment.jsp?action=soalselidik&refid=<%=refid%>&ic_no=<%=newic%>";
		</SCRIPT>
	
<%}
}
conn.close();
%>

