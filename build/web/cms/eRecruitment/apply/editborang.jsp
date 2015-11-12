<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>

<%	//Connection...
	Connection conn = null;
	String kadpengenalan= (String)session.getAttribute("kadpengenalan");
	String post1_edit = request.getParameter("post1_edit");
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
	boolean flag = false; 
	boolean flag2 = false;
	String action = request.getParameter("action");
	String service_code_post1 = request.getParameter("service_code_post1");
	String service_code_post2 = request.getParameter("service_code_post2");
	String post2_edit = request.getParameter("post2_edit");
	//String bidang2 = request.getParameter("bidang2");
   	String name = request.getParameter("name");
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
	String tarikhlahir2 = request.getParameter("tarikhlahir2");
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
	String desc_post1=request.getParameter("desc_post1");
	String desc_post2=request.getParameter("desc_post2");
	String desc_dept1=request.getParameter("desc_dept1");
	String desc_dept2=request.getParameter("desc_dept2");
	String marital=request.getParameter("marital");
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
	String job_post1 = request.getParameter("job_post1");
	String job_post2 = request.getParameter("job_post2");
	String jpa = request.getParameter("jpa");
	String closing_date_post1 = request.getParameter("closing_date_post1");
	String closing_date_post2 = request.getParameter("closing_date_post2");
	String group_post1 = request.getParameter("group_post1");
	String group_post2 = request.getParameter("group_post2");
	String closing_edit_post1 = request.getParameter("closing_edit_post1");
	String closing_edit_post2 = request.getParameter("closing_edit_post2");
	String closing_date1 = request.getParameter("closing_date1");
	String closing_date2 = request.getParameter("closing_date2");
	String bidang_post1 = request.getParameter("bidang_post1");
	boolean flag3 = false; 
	PreparedStatement pstmt_edit = null; 
	ResultSet rset_edit 	= null;
	PreparedStatement pstmt = null; 
	ResultSet rset 			= null;
	//String flag3 = request.getParameter("flag3");
				
				
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
if (conn != null)
{
String sql	= "SELECT SCH_REF_ID FROM STAFF_CANDIDATE_HEAD "+
			  "WHERE SCH_IC_NUM='" + kadpengenalan +"' AND SCH_ARCHIVE='N' "+
			  "AND SCH_REF_ID='" + refid + "' "+
			  "AND SUBSTR(SCH_REF_ID, 0,4) = TO_CHAR(SYSDATE,'YYYY') ";

//System.out.println("ashaksaksha"+ sql);
try
{
	pstmt_edit = conn.prepareStatement(sql); 
	rset_edit			= pstmt_edit.executeQuery();
	if (rset_edit.next())
	{
		flag3 = true;
	}
	rset_edit.close();
	pstmt_edit.close();
}
	catch (SQLException e)
		{ out.println ("Error : " + e.toString ()); }
	finally {
  try {
        if (rset_edit != null) rset_edit.close();
		if (pstmt_edit != null) pstmt_edit.close();
  }
  catch (Exception e) { }
 }
 }
 %>
<% if (flag3) {%>
<%
if (conn != null)
{
String sql	=	"SELECT SCH_REF_ID,sch_post_1,sch_majoring1,sch_post_2,sch_majoring2,sch_name,sch_gender, "+
				"sch_ic_num,sch_pasport_num,sch_current_address,sch_current_city,sch_current_state, "+
				"sch_current_country,sch_current_pcode,sch_current_telno, sch_email_addr ,to_char(sch_birth_date,'dd/mm/yyyy'), "+
				"sch_age,sch_handphone_no,sch_co_curriculum_activity, SCH_SPORT_ACTIVITY, "+
				"SCH_PERMANENT_ADDRESS,SCH_PERMANENT_PCODE,SCH_PERMANENT_CITY,SCH_PERMANENT_STATE, SCH_GOV_STAFF, "+
				"sci_institution_name,sci_year_from,sci_year_to,sci_qualification, "+
				"sci_class,sci_classification,sci_cgpa_degree, sci_class_degree, "+
				"SCE_EMPLOYER_NAME,SCE_EMPLOYER_ADDRESS,SCE_POST, "+
   				"SCE_BASIC_SALARY, to_char(SCE_DATE_FROM,'dd/mm/yyyy'), sce_total_year, "+
				"SCS_YEAR,SCS_SCHOOL,SCS_QUALIFICATION_CODE,SCS_RESULT_BM, "+
				"SCS_RESULT_BI, SCS_RESULT_MATH,SERVICE1.SS_SERVICE_DESC,SERVICE2.SS_SERVICE_DESC,DEPT1.DM_DEPT_DESC, DEPT2.DM_DEPT_DESC,SCH_MARITAL_STATUS, "+
				"SCL_A,SCL_B,SCL_B1,SCL_B2,SCL_C,SCL_D,SCL_E,SCL_E1,SCL_E2,SCL_F,SCL_G,SCL_H,SCL_I,SCH_RECOMMENDER1_NAME,SCH_RECOMMENDER1_ADDRESS,SCH_RECOMMENDER1_WORK_DESC, "+
				"SCH_RECOMMENDER1_CONTACT_NUM, SCH_RECOMMENDER2_NAME,SCH_RECOMMENDER2_ADDRESS,SCH_RECOMMENDER2_WORK_DESC, "+
				"SCH_RECOMMENDER2_CONTACT_NUM,SERVICE1.SS_JPA_CODE,SERVICE2.SS_JPA_CODE,SCH_JPA,SCH_CLOSING_DATE_POST1,SCH_CLOSING_DATE_POST2, "+
				"SERVICE1.SS_GROUPING,SERVICE2.SS_GROUPING,SERVICE1.SS_SERVICE_CODE,SERVICE2.SS_SERVICE_CODE  "+
				"FROM STAFF_CANDIDATE_HEAD,STAFF_CANDIDATE_INSTITUTION,STAFF_CANDIDATE_EXPERIENCE,STAFF_CANDIDATE_SCHOOL, "+
				"RECRUITMENT_POST POST1,RECRUITMENT_POST POST2,SERVICE_SCHEME SERVICE1,SERVICE_SCHEME SERVICE2, "+
				"DEPARTMENT_MAIN DEPT1, DEPARTMENT_MAIN DEPT2,STAFF_CANDIDATE_LICENCE "+
				"WHERE SCH_REF_ID = sci_candidate_refid (+) "+
				"AND SCH_REF_ID = SCE_CANDIDATE_REFID (+)"+
				"AND SCH_REF_ID = SCS_CANDIDATE_REFID (+) "+
				"AND SCH_REF_ID = SCL_REF_ID (+) "+
				"AND POST1.RP_REF_ID (+) = SCH_POST_1 " +
				 "AND POST2.RP_REF_ID (+) = SCH_POST_2 " +
				 "AND SERVICE1.SS_SERVICE_CODE(+) = POST1.RP_SERVICE_CODE " +
				 "AND SERVICE2.SS_SERVICE_CODE(+) = POST2.RP_SERVICE_CODE " +
				 "AND POST1.RP_DEPT_CODE=DEPT1.DM_DEPT_CODE(+) " +
				 "AND POST2.RP_DEPT_CODE=DEPT2.DM_DEPT_CODE(+) " +
				"AND SCH_REF_ID='"+ refid +"' ";
try
{
	pstmt = conn.prepareStatement(sql); 
	rset 			= pstmt.executeQuery();
	if (rset.next())
	{
		refid		=	rset.getString (1);
		post1		=	rset.getString (2);
		bidang		=	rset.getString (3);
		post2		=	rset.getString (4);
		bidang2		=	rset.getString (5);
		name		=	rset.getString (6);
		jantina		=	rset.getString (7);
		newic		=	rset.getString (8);
		passport	=	rset.getString (9);
		addr_cur	=	rset.getString (10);
		addr_cur_city	=	rset.getString (11);
		addr_cur_state	=	rset.getString (12);
		addr_cur_country=	rset.getString (13);
		postcode_cur	=	rset.getString (14);
		phone		=	rset.getString (15);
		email		=	rset.getString (16);
		tarikhlahir2	=	rset.getString (17);
		umur		=	rset.getString (18);
		hphone		=	rset.getString (19);
		extra		=	rset.getString (20);
		sport		=	rset.getString (21);
		addr_perm	=	rset.getString (22);
		postcode_perm	=	rset.getString (23);
		addr_perm_city	=	rset.getString (24);
		addr_perm_state	=	rset.getString (25);
		gov_staff	=	rset.getString (26);
		insti_name	=	rset.getString (27);
		yearFrom	=	rset.getString (28);
		yearTo		=	rset.getString (29);
		qualification	=	rset.getString (30);
		instiClass	=	rset.getString (31);
		clasify		=	rset.getString (32);
		insti_cgpa_degree=	rset.getString (33);
		insti_class_degree=	rset.getString (34);
		employer_name	=	rset.getString (35);
		employer_address=	rset.getString (36);
		post		=	rset.getString (37);
		salary		=	rset.getString (38);
		t_mula		=	rset.getString (39);
		jum_tahun	=	rset.getString (40);
		school_year	=	rset.getString (41);
		school_name	=	rset.getString (42);
		school_qual	=	rset.getString (43);
		school_bm	=	rset.getString (44);
		school_bi	=	rset.getString (45);
		school_math	=	rset.getString (46);
		desc_post1 = rset.getString (47);
		desc_post2 = rset.getString(48);
		desc_dept1 = rset.getString(49);
		desc_dept2 = rset.getString(50);
		marital = rset.getString(51);
		A = rset.getString (52);
		B = rset.getString (53);
		B1 = rset.getString (54);
		B2 = rset.getString (55);
		C = rset.getString (56);
		D = rset.getString (57);
		E = rset.getString (58);
		E1 = rset.getString (59);
		E2 = rset.getString (60);
		F = rset.getString (61);
		G = rset.getString (62);
		H = rset.getString (63);
		I = rset.getString (64);
		nama_penjamin1 = rset.getString (65);
		alamat_penjamin1 = rset.getString (66);
		pekerjaan_penjamin1 = rset.getString (67);
		tel_penjamin1 = rset.getString (68);
		nama_penjamin2 = rset.getString (69);
		alamat_penjamin2 = rset.getString (70);
		pekerjaan_penjamin2 = rset.getString (71);
		tel_penjamin2 = rset.getString (72);
		job_post1 = rset.getString (73);
		job_post2 = rset.getString (74);
		jpa = rset.getString (75);
		group_post1 = rset.getString (78);
		group_post2 = rset.getString (79);
		service_code_post1 = rset.getString (80);
		service_code_post2 = rset.getString (81);
	}
	rset.close();
	pstmt.close();
}
	catch (SQLException e)
		{ out.println ("Error : " + e.toString ()); }
	finally {
  try {
        if (rset != null) rset.close();
		if (pstmt != null) pstmt.close();
  }
  catch (Exception e) { }
 }
 }
%>

<%
	// Temporarily hardcode state & country
	String [] statecode = { "00","01","02","03","04","05","06","07","08","09","10","11","12",
							"13","14","15","16","17","18","19","20" };
	String [] statename = { "","Johor","Kedah","Kelantan","Melaka","Negeri Sembilan","Pahang","Pulau Pinang",
							"Perak","Perlis","Selangor","Terengganu","Sabah","Sarawak","Wilayah Persekutuan (K. Lumpur)",
							"Wilayah Persekutuan (Labuan)","Singapura","Brunei","Indonesia","Thailand","Lain-lain" };
	String [] countrycode = { "AGU","AND","ANG","ANT","ARG","AS","ASC","AUS","AUT","AZO","BAG","BAH","BAN","BAR",
	"BEL","BEN","BER","BHR","BHU","BLZ","BOL","BOR","BOT","BRA","BRB","BRN","BRU","BSI","BUK","BUL","BUR","BVI",
	"CAI","CAM","CAN","CAP","CAR","CAY","CHA","CHI","CHN","CM","COL","COM","CON","COS","CRE","CUB","CYP","CZE","DAH",
	"DEN","DJI","DOM","DOR","ECU","EGU","EGY","ELS","EST","ETH","ETI","FAL","FAR","FGU","FIJ","FIN","FPO","FRA","FUT",
	"GAM","GHA","GIB","GRL","GRN","GU","GUA","GUB","GUD","GUI","GUY","HAI","HOL","HON","HUN","ICE","INA","IND","IRE",
	"IRN","IRQ","ISR","ITL","IVC","JAM","JAP","JOR","KAM","KEN","KON","MAL","MAR","MEX","MID","MLD","MLI","MLT","MON",
	"MOR","MOT","MOZ","MRT","NAM","NAN","NAU","NCA","NEP","NET","NEV","NEW","NGR","NIC","NIG","NOR","NYA","OMA","PAK",
	"PAN","PAR","PER","PHI","PIT","PNG","POL","POR","PRI","REU","RHO","RWA","SA","SAF","SAO","SAU","SEN","SEY","SIN",
	"SOL","SOM","SPA","SRI","SRL","STC","STH","STL","STV","SUD","SUR","SWA","SWE","SWI","SYA","TAH","TAI","TAN","TAS",
	"THA","TOC","TOG","TON","TRI","TT","TUR","UAE","UGA","UK","URU","VAT","VEN","VI","VIE","WAF","WAL","WKI","WSA","YAR",
	"YPD","YUG","ZAI","ZAM","ZIM"};

	String [] countryname = {"ANGUILLA","ANDORRA","ANGOLA","ANTIGUA","ARGENTINA","AMERICA SAMOA","ASCENSION","AUSTRALIA",
	"AUSTRIA","AZORE","GABON","BAHAMAS","BANGLADESH","BARBADOS","BELGIUM","BENIN","BERMUDA","BAHRAIN","BHUTAN","BELIZE",
	"BOLIVA","BORNEO","BOTSWANIA","BRAZIL","BARBUDA","BURUNDI","BRUNEI","BRITISH SOLOMON ISLES","BURKINA","BULGARIA",
	"BURMA","BRITISH VIRGIN ISLANDS","CAICOS ISLANDS","CAMEROON","CANADA","CAPE VERDE","CENTRAL AFRICAN REP","CAYMAN ISLANDS ",
	"CHAD","CHILE","CHINA","MARINNA ISLANDS","COLOMBIA","COMOROS","CONGO","COSTA RICA","GREECE","CUBA","CYPRUS","CZECHOSLOVAKIA",
	"DAHOMEY","DENMARK","DJIBOUTI","DOMINICA","DOMINICAN REP","ECUADOR","EQUATORIAL GUINEA","EGYPT","EL SALVADOR","ESTONIA",
	"ETHOPIA","EAST TIMOR","FALKLAND ISLANDS","FAROE ISLANDS","FRENCH GUIANA","FIJI","FINLAND","FRENCH POLYNESIA","FRANCE",
	"FUTUNA ISLAND","GAMBIA","GHANA","GIBRALTAR","GREENLAND","GRENADA","GUAM","GUATEMALA","GUINEA-BUSSAU","GUADELOUPE",
	"GUINEA","GUYANA","HAITI","HOLLAND","HONDURAS","HUNGARY","ICELAND","INDONESIA","INDIA","IRELAND","IRAN","IRAQ","ISRAEL",
	"ITALY","IVORY COAST","JAMAICA","JAPAN","JORDAN","CAMBODIA","KENYA","HONG KONG","MALAYSIA","MAURITIUS","MEXICO","MIDWAY ISLAND","MALDIVES","MALI","MALTA","MONGOLIA","MOROCCO","MONTSERRAT","MOZAMBIQUE","MARTINIQUE","NAMBIA","NETH. ANTILLES",
	"NAURA","NEW CALEDONIA","NEPAL","NETHERLANDS","NEVIS","NEW ZEALAND","NIGER","NICARAGUA","NIGERIA","NORWAY","NYASALAND",
	"OMAN","PAKISTAN","PANAMA","PARAGUAY","PERU","PHILLIPINES","PITCAIRN ISLANDS","PAPUA NEW GUINEA","POLAND","PORTUGAL",
	"PUERTO RICO","REUNION ISLAND","RHODESA","TWANDA","SAMOA","SOUTH AFRICA","SAO TOME","SAUDI ARABIA","SENEGAL","SEYCHELLES",
	"SINGAPORE","SOLOMON ISLANDS","SOMALIA","SPAIN","SRI LANKA","SIERRA LEONE","SAINT CHRISTOPHER","SAINT HELENA","SAINT LUCIA",
	"SAINT VINCENT","SUDAN","SURINAME","SWAZILAND","SWEDEN","SWITZERLAND","SYRIA","TAHITI","TAIWAN","TANZANIA","TASMANIA",
	"THAILAND","TRISTAN DA CUNHA","TOGO","TONGA","TRINIDAD TOBAGO","MICRONESIA","TURKEY","UNITED ARAB EMIRATES","UGANDA","UNITED KINGDOM","URUGUAY","VATICAN CITY","VENEZUELA","VIRGINA ISLANDS","VIETNAM","WEST AFRICA","WALLIS ISLANDS","WAKE ISLAND",
	"WESTERN SAMOA","YEMEN ARAB REP","YEMEN PEOPLES DEMOCRATIC REP","YUGOSLAVIA","ZAIRE","ZAMBIA","ZIMBABWE"};

	try
	{
	
		String sql_state="SELECT sm_state_code,sm_state_desc FROM cmsadmin.state_main order by sm_state_desc";
		String sql_country="SELECT cm_country_code,cm_country_desc FROM cmsadmin.country_main order by cm_country_desc";
%>
<html>
<script language="JavaScript" type="text/JavaScript" src="cms/eRecruitment/js/scw.js"></script>
<script>
function emailCheck (emailStr) {

var checkTLD=1;
var knownDomsPat=/^(com|net|org|edu|int|mil|gov|arpa|biz|aero|name|coop|info|pro|museum)$/;
var emailPat=/^(.+)@(.+)$/;
var specialChars="\\(\\)><@,;:\\\\\\\"\\.\\[\\]";
var validChars="\[^\\s" + specialChars + "\]";
var quotedUser="(\"[^\"]*\")";
var ipDomainPat=/^\[(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\]$/;
var atom=validChars + '+';
var word="(" + atom + "|" + quotedUser + ")";
var userPat=new RegExp("^" + word + "(\\." + word + ")*$");
var domainPat=new RegExp("^" + atom + "(\\." + atom +")*$");
var matchArray=emailStr.match(emailPat);

if (matchArray==null) {
alert("Email address seems incorrect (check @ and .'s)");
return false;
}
var user=matchArray[1];
var domain=matchArray[2];

for (i=0; i<user.length; i++) {
if (user.charCodeAt(i)>127) {
alert("Ths username contains invalid characters (email address).");
return false;
   }
}
for (i=0; i<domain.length; i++) {
if (domain.charCodeAt(i)>127) {
alert("Ths domain name contains invalid characters (email address).");
return false;
   }
}

if (user.match(userPat)==null) {
alert("The username doesn't seem to be valid (email address).");
return false;
}

var IPArray=domain.match(ipDomainPat);
if (IPArray!=null) {

for (var i=1;i<=4;i++) {
if (IPArray[i]>255) {
alert("Destination IP address is invalid!");
return false;
   }
}
return true;
}
var atomPat=new RegExp("^" + atom + "$");
var domArr=domain.split(".");
var len=domArr.length;
for (i=0;i<len;i++) {
if (domArr[i].search(atomPat)==-1) {
alert("The domain name does not seem to be valid (email address).");
return false;
   }
}

return true;
}


function validateForm()
{
 if (document.applForm.nama.value=='')
  {
     alert("Sila Masukkan Nama (Please Enter Name)");
	 document.applForm.nama.focus();
	 //return false;
  }
  else if (document.applForm.jantina.value=='')
  {
     alert("Sila Masukkan Jantina (Please Enter Gender)");
	 document.applForm.jantina.focus();
	 //return false;
  }
  
 else if (document.applForm.tarikhlahir.value=='')
  {
     alert("Sila Masukkan Tarikh Lahir (Please Enter Date of Birth)");
	 document.applForm.tarikhlahir.focus();
	 //return false;
  }
  
  else if (document.applForm.marital.value=='')
  {
     alert("Sila Masukkan Taraf Perkahwinan (Please Enter Marital Status)");
	 document.applForm.marital.focus();
	 //return false;
  }
  
  else if (document.applForm.umur.value=='')
  {
     alert("Sila Masukkan Umur (Please Enter Age)");
	 document.applForm.umur.focus();
	 //return false;
  }
  
  else if (document.applForm.newic.value=='')
  {
     alert("Sila Masukkan No. Kad Pengenalan Baru (Please Enter New IC Number)");
	 document.applForm.newic.focus();
	 //return false;
  }
  
  else if (document.applForm.addr_perm.value=='')
  {
     alert("Sila Masukkan Alamat Tetap(Please Enter Address)");
	 document.applForm.addr_perm.focus();
	 //return false;
  }
  else if (document.applForm.addr_perm_city.value=='')
  {
     alert("Sila Masukkan Bandar (Please Select Permanent City)");
	 document.applForm.addr_perm_city.focus();
	 //return false;
  }
  else if (document.applForm.addr_perm_state.value=='')
  {
     alert("Sila Masukkan Negeri (Please Select Permanent State)");
	 document.applForm.addr_perm_state.focus();
	 //return false;
  }
  else if (document.applForm.postcode_perm.value=='')
  {
     alert("Sila Masukkan Poskod (Please Enter Permanent Postcode)");
	 document.applForm.postcode_perm.focus();
	 //return false;
  }

  else if (document.applForm.addr_cur.value=='')
  {
     alert("Sila Masukkan Alamat Surat Menyurat(Please Enter Current Address)");
	 document.applForm.addr_cur.focus();
	 //return false;
  }
  else if (document.applForm.addr_cur_city.value=='')
  {
     alert("Sila Masukkan Bandar (Please Select Current City)");
	 document.applForm.addr_cur_city.focus();
	 //return false;
  }
  else if (document.applForm.addr_cur_state.value=='')
  {
     alert("Sila Masukkan Negeri (Please Select Current State)");
	 document.applForm.addr_cur_state.focus();
	 //return false;
  }
  else if (document.applForm.addr_cur_country.value=='')
  {
     alert("Sila Pilih Negara (Please Select Current Country)");
	 document.applForm.addr_cur_country.focus();
	 //return false;
  }
  else if (document.applForm.postcode_cur.value=='')
  {
     alert("Sila Masukkan Poskod (Please Enter Current Postcode)");
	 document.applForm.postcode_cur.focus();
	 //return false;
  }
  else if (document.applForm.phone.value=='')
  {
     alert("Sila Masukkan Telefon Pejabat/Rumah (Please Enter Your Office/House Phone Number)");
	 document.applForm.phone.focus();
	 //return false;
  }
  else if (document.applForm.hphone.value=='')
  {
     alert("Sila Masukkan Telefon Bimbit (Please Enter Your HandPhone Number)");
	 document.applForm.hphone.focus();
	 //return false;
  }
  else if (document.applForm.email.value=='')
  {
     alert("Sila Masukkan Alamat Emel (Please Enter Your Emel Addres)");
	 document.applForm.email.focus();
	 //return false;
  }
   else if (document.applForm.jpa.value=='')
  {
     alert("Sila Masukkan Maklumat Pemegang JPA (Please Enter Your JPA Information)");
	 document.applForm.jpa.focus();
	 //return false;
  }
  else if(document.applForm.school_name.value=='')
		{
			alert("Sila Masukkan Maklumat Akademik Menengah Tertinggi");
			document.applForm.school_name.focus();
			//return false;
		}
else if(document.applForm.school_year.value=='')
		{
			alert("Sila Masukkan Maklumat Akademik Menengah Tertinggi");
			document.applForm.school_year.focus();
			//return false;
		}
else if(document.applForm.school_qual.value=='')
		{
			alert("Sila Masukkan Maklumat Akademik Menengah Tertinggi");
			document.applForm.school_qual.focus();
			//return false;
		}
else if(document.applForm.school_bm.value=='')
		{
			alert("Sila Masukkan Maklumat Pencapaian Bahasa Melayu");
			document.applForm.school_bm.focus();
			//return false;
		}
else if(document.applForm.school_bi.value=='')
		{
			alert("Sila Masukkan Maklumat Pencapaian Bahasa English");
			document.applForm.school_bi.focus();
			//return false;
		}
else if(document.applForm.school_mate.value=='')
		{
			alert("Sila Masukkan Maklumat Pencapaian Matematik");
			document.applForm.school_mate.focus();
			//return false;
		}
/* else if(document.applForm.employer_name.value=='')
  {
	alert("Sila Masukkan Nama Majikan (Please enter employer name)");
	document.applForm.employer_name.focus();
			//return false;
  }
		
else if(document.applForm.employer_address.value=='')
		{
			alert("Sila Masukkan Alamat Majikan (Please enter employer address)");
			document.applForm.employer_address.focus();
			//return false;
		}
else if(document.applForm.t_mula.value=='')
		{
			alert("Sila Masukkan Tarikh Mula Bekerja (Please enter Your Employee Date)");
			document.applForm.t_mula.focus();
			//return false;
		}
		
else if(document.applForm.post.value=='')
		{
			alert("Sila Masukkan Jawatan (Please enter position)");
			document.applForm.post.focus();
			//return false;
		}*/
else if(document.applForm.gov_staff.value=='')
		{
			alert("Sila Masukkan Maklumat sama ada Anda Kakitangan Kerajaan atau Bukan");
			document.applForm.gov_staff.focus();
			//return false;
		}
else if(document.applForm.nama_penjamin1.value=='')
		{
			alert("Sila Masukkan Nama Penjamin 1 (Please Include Guarantor Name 1 )");
			document.applForm.nama_penjamin1.focus();
			//return false;
		}
else if(document.applForm.alamat_penjamin1.value=='')
		{
			alert("Sila Masukkan Alamat Penjamin 1 (Please Include Guarantor Address 1 )");
			document.applForm.alamat_penjamin1.focus();
			//return false;
		}
else if(document.applForm.pekerjaan_penjamin1.value=='')
		{
			alert("Sila Masukkan Pekerjaan Penjamin 1 (Please Include Guarantor Job 1 )");
			document.applForm.pekerjaan_penjamin1.focus();
			//return false;
		}
else if(document.applForm.tel_penjamin1.value=='')
		{
			alert("Sila Masukkan Telefon Penjamin 1 (Please Include Guarantor Phone 1 )");
			document.applForm.tel_penjamin1.focus();
			//return false;
		}
else if(document.applForm.nama_penjamin2.value=='')
		{
			alert("Sila Masukkan Nama Penjamin 2 (Please Include Guarantor Name 2 )");
			document.applForm.nama_penjamin2.focus();
			//return false;
		}
else if(document.applForm.alamat_penjamin2.value=='')
		{
			alert("Sila Masukkan Alamat Penjamin 2 (Please Include Guarantor Address 1 )");
			document.applForm.alamat_penjamin2.focus();
			//return false;
		}
else if(document.applForm.pekerjaan_penjamin2.value=='')
		{
			alert("Sila Masukkan Pekerjaan Penjamin 2 (Please Include Guarantor Job 2 )");
			document.applForm.pekerjaan_penjamin2.focus();
			//return false;
		}
else if(document.applForm.tel_penjamin2.value=='')
		{
			alert("Sila Masukkan Telefon Penjamin 2 (Please Include Guarantor Phone 2 )");
			document.applForm.tel_penjamin2.focus();
			//return false;
		}
/*else if ((document.applForm.post1.value =='DA41') && (parseFloat(document.applForm.insti_cgpa_degree.value) < 3.00) )
		{
			alert("Hanya pemohon yang mempunyai CGPA@PNGK 3.00 ke atas sahaja yang LAYAK memohon bagi jawatan Tutor.\nTerima Kasih");
			document.applForm.insti_cgpa_degree.focus();
		}
else if ((document.applForm.post2.value =='DA41') && (parseFloat(document.applForm.insti_cgpa_degree.value) < 3.00) )
		{
			alert("Hanya pemohon yang mempunyai CGPA@PNGK 3.00 ke atas sahaja yang LAYAK memohon bagi jawatan Tutor.\nTerima Kasih");
			document.applForm.insti_cgpa_degree.focus();
		}*/
else
		{
			document.applForm.action="eRecruitment.jsp?action=edit&refid=<%=refid%>";
			document.applForm.submit();
		}
}


function yearDispFrom(yy)
	{
		var time = new Date();
		var year = time.getYear();
		if (year < 1900) {
		year = year + 1900;
		}
		var date = year ;
		var future = year-61; /*change the '100' to the number of years in the future you want to show */
		document.writeln ("<SELECT NAME=insti_year_from style='font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;'> <OPTION value='0'>Tahun");
		do
		{
			if(yy==date)
			{
				document.write ("<OPTION selected value=\"" +date+"\">" +date+ "");
			}
			else
			{
				document.write ("<OPTION  value=\"" +date+"\">" +date+ "");
			}
			date--;
		}
		while (date > future)
		document.write ("</SELECT>");
	}

	function yearDispTo(yy)
	{
		var time = new Date();
		var year = time.getYear();
		if (year < 1900) {
		year = year + 1900;
		}
		var date = year ;
		var future = year-61; /*change the '100' to the number of years in the future you want to show */
		document.writeln ("<SELECT NAME=insti_year_to style='font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;'> <OPTION value='0'>Tahun");
		do
		{
			if(yy==date)
			{
				document.write ("<OPTION selected value=\"" +date+"\">" +date+ "");
			}
			else
			{
				document.write ("<OPTION  value=\"" +date+"\">" +date+ "");
			}
			date--;
		}
		while (date > future)
		document.write ("</SELECT>");
	}			

function yearDispFromSchool(yy)
	{
		var time = new Date();
		var year = time.getYear();
		if (year < 1900) {
		year = year + 1900;
		}
		var date = year ;
		var future = year-61; /*change the '100' to the number of years in the future you want to show */
		document.writeln ("<SELECT NAME=school_year style='font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;'> <OPTION value='0'>Tahun");
		do
		{
			if(yy==date)
			{
				document.write ("<OPTION selected value=\"" +date+"\">" +date+ "");
			}
			else
			{
				document.write ("<OPTION  value=\"" +date+"\">" +date+ "");
			}
			date--;
		}
		while (date > future)
		document.write ("</SELECT>");
	}
		
function taLimit() {
	var taObj=event.srcElement;
	if (taObj.value.length==taObj.maxLength*1) return false;
}

function taCount(visCnt) { 
	var taObj=event.srcElement;
	if (taObj.value.length>taObj.maxLength*1) taObj.value=taObj.value.substring(0,taObj.maxLength*1);
	if (visCnt) visCnt.innerText=taObj.maxLength-taObj.value.length;
}

function toUpperCase(field)
  {
    field.value = field.value.toUpperCase();
  }

 function setTextFieldToUpper()
  {
    var input =  document.getElementsByTagName("input");
    for (i=0;i<input.length;i++)
    {
        input[i].onblur = new Function("toUpperCase(this)");
    }
  }

function go()
{
		if(document.applForm.post1_edit.value =='DA41')
		  {
		  alert("Permohonan bagi jawatan TUTOR hanya layak bagi pemohon\nyang mempunyai CGPA@PNGK 3.00 ke atas sahaja.\n\nTerima Kasih");
		  document.applForm.action = "eRecruitment.jsp?action=editborang&refid=<%=refid%>";
     	  document.applForm.submit();
		  }
		  else
		  {
			document.applForm.action = "eRecruitment.jsp?action=editborang&refid=<%=refid%>";
			document.applForm.submit();
		  }
}
function go2()
{
		if(document.applForm.post2_edit.value =='DA41')
		  {
		  alert("Permohonan bagi jawatan TUTOR hanya layak bagi pemohon\nyang mempunyai CGPA@PNGK 3.00 ke atas sahaja.\n\nTerima Kasih");
		  document.applForm.action = "eRecruitment.jsp?action=editborang&refid=<%=refid%>";
     	  document.applForm.submit();
		  }
		  else
		  {
			document.applForm.action = "eRecruitment.jsp?action=editborang&refid=<%=refid%>";
			document.applForm.submit();
		  }
}
function go3()
{
			document.applForm.action = "eRecruitment.jsp?action=editborang&refid=<%=refid%>";
			document.applForm.submit();
 }

function isNumberKey(evt)
      {
         var charCode = (evt.which) ? evt.which : event.keyCode
         if (charCode > 31 && (charCode < 48 || charCode > 57))
		 {alert("Sila Masukkan Nombor Sahaja");
            return false;
		} else
         return true;
      }
  </script>

<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
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
<body onLoad="setTextFieldToUpper();">
<div align="center"><img src="cms/eRecruitment/images/permohonan.gif"><br>
</div>
<form action="eRecruitment.jsp?action=borangpermohonan" method="post" name="applForm" id="applForm">
  <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#666666" class='style2'>
    <tr> 
      <td><table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
          <tr> 
            <td><table width="100%" border="0" cellpadding="4" cellspacing="0" bgcolor="#FFFFFF" class='style2'>
                <tr> 
                  <td colspan="3" nowrap bgcolor="#666666" class=normaltext style='border-top:none'><strong><font color="#FFFFFF">Maklumat 
                    Jawatan </font></strong></td>
                </tr>
                <tr> 
                  <td colspan="3" nowrap class=normaltext style='border-top:none'><br> 
                    <table width="100%" border="0" cellspacing="1" class='style2'>
                      <tr valign="top" bgcolor="#FFFFFF"> 
                        <td height="40" colspan="2"><img src="cms/eRecruitment/images/penting.gif" width="45" height="14"> 
                          Calon dikehendaki memilih jawatan yang hendak dipohon 
                          berdasarkan kategori dan mengikut kelayakan masing-masing. 
                          Setiap calon dibenarkan membuat 2 pilihan jawatan sahaja. 
                          <br> <br> <br> <font color="#FF0000">Sila pastikan anda 
                          tidak mengaktifkan &quot;Pop-up Blocker&quot;.</font><br> 
                          <br> </td>
                      </tr>
                      <tr bgcolor="#666666"> 
                        <td height="20" colspan="2"><strong><font color="#FFFFFF">&nbsp;Maklumat 
                          Permohonan Jawatan Terdahulu</font></strong></td>
                      </tr>
                      <tr bgcolor="#FFFFFF"> 
                        <td height="105" colspan="2"> <table width="100%" border="0" cellpadding="1" cellspacing="0" class="style2">
                            <tr> 
                              <td height="20" colspan="2" bgcolor="#E4E4E4"> <div align="center"><strong>Pilihan 
                                  Jawatan Pertama</strong></div></td>
                              <td height="20" colspan="2" bgcolor="#E4E4E4"> <div align="center"><strong>Pilihan 
                                  Jawatan Kedua</strong></div></td>
                            </tr>
                            <tr bgcolor="#EAF4FF"> 
                              <th height="20" class="style2" scope="row"><div align="right">Kategori 
                                  : </div></th>
                              <td height="20">&nbsp;<%=group_post1%></td>
                              <th height="20" class="style2" scope="row"><div align="right">Kategori 
                                  : </div></th>
                              <td height="20">&nbsp;<%=( ( group_post2==null)?"Tiada":group_post2 )%></td>
                            </tr>
                            <tr bgcolor="#EAF4FF"> 
                              <th width="10%" height="20" class="style2" scope="row"> 
                                <div align="right">Jawatan : </div></th>
                              <td width="37%" height="20">&nbsp;<%=desc_post1%></td>
                              <th width="11%" height="20" class="style2" scope="row"> 
                                <div align="right">Jawatan : </div></th>
                              <td width="42%" height="20">&nbsp;<%=( ( desc_post2==null)?"Tiada":desc_post2 )%></td>
                            </tr>
                            <tr bgcolor="#EAF4FF"> 
                              <th height="20" class="style2" scope="row"> <div align="right"><span class="style5">Fakulti 
                                  : </span></div></th>
                              <td height="20">&nbsp;<%=desc_dept1%></td>
                              <th height="20" class="style2" scope="row"> <div align="right"><span class="style5">Fakulti 
                                  : </span></div></th>
                              <td height="20">&nbsp;<%=( ( desc_dept2==null)?"Tiada":desc_dept2 )%></td>
                            </tr>
                            <tr bgcolor="#EAF4FF"> 
                              <th height="20" class="style2" scope="row"> <div align="right"><span class="style5">Bidang 
                                  : </span></div></th>
                              <td height="20">&nbsp;<%=( ( bidang==null)?"Tiada":bidang )%></td>
                              <th height="20" class="style2" scope="row"> <div align="right"><span class="style5">Bidang 
                                  : </span></div></th>
                              <td height="20">&nbsp;<%=( ( bidang2==null)?"Tiada Bidang":bidang2 )%></td>
                            </tr>
                          </table>
                          </td>
                      </tr>
                      <tr bgcolor="#FFFFFF"> 
                        <td width="48%" height="50"><strong>&nbsp;&nbsp;<a href="javascript:void(window.open('eRecruitment.jsp?action=edit_post1&refid=<%=refid%>','statistics', 'height=220,width=700,menubar=no,toolbar=no,scrollbars=yes'))" onMouseOver="window.status='Kemaskini Jawatan';return true;"><img src="cms/eRecruitment/images/26.gif" width="10" height="7" border="0"> 
                          <font color="#0000FF">Klik untuk kemaskini maklumat 
                          jawatan Pertama</font></a></strong></td>
                        <td width="52%"><strong>&nbsp;&nbsp;<a href="javascript:void(window.open('eRecruitment.jsp?action=edit_post2&refid=<%=refid%>','statistics', 'height=220,width=700,menubar=no,toolbar=no,scrollbars=yes'))" onMouseOver="window.status='Kemaskini Jawatan';return true;"><img src="cms/eRecruitment/images/26.gif" width="10" height="7" border="0"> 
                          <font color="#0000FF">Klik untuk kemaskini maklumat 
                          jawatan Kedua</font></a></strong></td>
                      </tr>
                    </table>
                    </td>
                </tr>
                <tr bgcolor="#666666"> 
                  <td colspan="3" nowrap class=normaltext style='border-top:none'><strong><font color="#FFFFFF">Maklumat 
                    Peribadi </font></strong></td>
                </tr>
                <tr> 
                  <td nowrap class="normaltext"><strong>Nama Penuh<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td width="100%" class="normaltext"><input name="nama" type="text" id="nama" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" value="<%=name%>" size="50" maxlength="100"></td>
                </tr>
                <tr> 
                  <td nowrap class="normaltext"><strong>Jantina<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td width="100%" class="normaltext"><select name="jantina" id="jantina" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                      <option value="">Sila Pilih</option>
                      <option value="L" <% if (jantina!=null&&jantina.equals("L")) { %> selected<% } %>>Lelaki</option>
                      <option value="P" <% if (jantina!=null&&jantina.equals("P")) { %> selected<% } %>>Perempuan</option>
                    </select> </td>
                </tr>
                <tr> 
                  <td nowrap class="normaltext"><strong>Tarikh Lahir<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td class="normaltext"><input name="tarikhlahir" type="text" id="nama2" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" value="<%=tarikhlahir2%>" size="12" readonly> 
                    <img src='cms/eRecruitment/images/calendar.jpg' title='Klik disini' alt='Klik disini' onClick="scwShow(scwID('tarikhlahir'),event);" /> 
                  </td>
                </tr>
                <tr> 
                  <td nowrap class="normaltext"><strong>Taraf Perkahwinan<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td class="normaltext"><select name="marital" id="marital" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                      <option value="">Sila Pilih</option>
                      <option value="SINGLE" <% if (marital!=null && marital.equals("SINGLE")) { %> selected<% } %>>Bujang</option>
                      <option value="MARRIED" <% if (marital!=null && marital.equals("MARRIED")) { %> selected<% } %>>Berkahwin</option>
                      <option value="DIVORCED" <% if (marital!=null && marital.equals("DIVORCED")) { %> selected<% } %>>Janda/Duda</option>
                    </select></td>
                </tr>
                <tr> 
                  <td nowrap class="normaltext"><strong>Umur pada iklan ditutup<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td width="100%" class="normaltext"><input name="umur" type="text" id="nama3" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" value="<%=umur%>" size="10"> 
                    <font size="1">contoh : 25</font></td>
                </tr>
                <tr> 
                  <td nowrap class="normaltext"><strong>No Kad Pengenalan Baru<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td width="100%" class="normaltext"><input name="newic" type="text" id="nama32" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" value="<%=kadpengenalan%>" size="25"> 
                    <font size="1">contoh : 800120065566</font></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext><strong>No Pasport</strong></td>
                  <td>&nbsp;</td>
                  <td width="100%" class="normaltext"><input name="pasport" type="text" id="nama33" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" value="<%=( ( passport==null)?"":passport )%>" size="25"> 
                  </td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Alamat 
                    Tetap<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td width="100%" class="normaltext"><textarea name="addr_perm" cols="50" id="nama332" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;"><%=addr_perm%></textarea></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Bandar<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td width="100%" class="normaltext" ><input name="addr_perm_city" type="text" id="nama333" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" value="<%=addr_perm_city%>" size="30"> 
                  </td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Negeri<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td width="100%" class="normaltext"><span style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10px;"> 
                    <SELECT name="addr_perm_state" id="addr_perm_state" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                      <OPTION value="" selected>Sila Pilih</OPTION>
                      <%
							for (int c=0;c<statecode.length;c++){
						%>
                      <OPTION VALUE='<%=statecode[c]%>' <% if (addr_perm_state!=null&&addr_perm_state.equals(statecode[c])) { %> selected<% } %>><%=statename[c]%> 
                      </OPTION>
                      <%}%>
                    </SELECT>
                    </span> </td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Poskod<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td width="100%" class="normaltext"><input name="postcode_perm" type="text" id="nama335" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" value="<%=postcode_perm%>" size="20"> 
                    <font size="1">contoh : 25505 </font></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Alamat 
                    Surat Menyurat<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td width="100%" class="normaltext"><textarea name="addr_cur" cols="50" id="addr_cur" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;"><%=addr_cur%></textarea> 
                  </td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Bandar<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td width="100%" class="normaltext"><input name="addr_cur_city" type="text" id="addr_cur_city" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" value="<%=addr_cur_city%>" size="30"></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Negeri<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td width="100%" class="normaltext"><span style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10px;"> 
                    <SELECT name="addr_cur_state" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                      <OPTION value="" selected>Sila Pilih</OPTION>
                      <%
							for (int c=0;c<statecode.length;c++){
						%>
                      <OPTION VALUE='<%=statecode[c]%>' <% if (addr_cur_state!=null&&addr_cur_state.equals(statecode[c])) { %> selected<% } %>><%=statename[c]%> 
                      </OPTION>
                      <%}%>
                    </SELECT>
                    </span></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Negara<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td width="100%" class="normaltext"> <SELECT name="addr_cur_country" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                      <OPTION selected>Sila Pilih</OPTION>
                      <% 
								for (int c=0;c<countrycode.length;c++)
								{
									if (countrycode[c].equals("MAL"))
									{
						%>
                      <OPTION VALUE='<%=countrycode[c]%>' selected><%=countryname[c]%></OPTION>
                      <%}else{%>
                      <OPTION VALUE='<%=countrycode[c]%>' <% if (addr_cur_country!=null&&addr_cur_country.equals(countrycode[c])) { %> selected<% } %>><%=countryname[c]%></OPTION>
                      <%		
								}
					
							}
						}
						catch(Exception e)
						{
							System.out.println("Error:"+e);
						}
					%>
                    </SELECT> </td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Poskod<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td class="normaltext"><input name="postcode_cur" type="text" id="nama336" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" value="<%=postcode_cur%>" size="20"> 
                    <font size="1">contoh : 25505 </font></td>
                </tr>
                <tr> 
                  <td valign="top" nowrap class=normaltext style='border-top:none'><strong>Telefon<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td width="100%" class="normaltext"><table width="100%" border="0" cellpadding="2" cellspacing="1" class='style2'>
                      <tr> 
                        <td width="13%"><strong>Pejabat/Rumah </strong></td>
                        <td width="87%"><input name="phone" type="text" id="phone" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" value="<%=phone%>" size="15"> 
                          <font size="1">contoh : 095492190</font></td>
                      </tr>
                      <tr> 
                        <td><strong>Bimbit </strong></td>
                        <td><input name="hphone" type="text" id="hphone2" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" value="<%=hphone%>" size="15"> 
                          <font size="1">contoh : 0133333335</font></td>
                      </tr>
                    </table></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Email<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td class="normaltext"><input name="email" type="text" id="email" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" value="<%=email%>" size="40" maxlength="100"> 
                    <font size="1">contoh : norhazarina@ump.edu.my</font></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Pemegang 
                    Biasiswa JPA<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td class="normaltext"><span style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10px;"> 
                    <select name="jpa" class="normaltext" id="select4" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                      <option value="">Sila Pilih</option>
                      <option value="Ya" <% if (jpa!=null && jpa.equals("Ya")) { %> selected<% } %>>Ya</option>
                      <option value="Tidak" <% if (jpa!=null && jpa.equals("Tidak")) { %> selected<% } %>>Tidak</option>
                    </select>
                    </span></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Lesen 
                    Kenderaan </strong></td>
                  <td>&nbsp;</td>
                  <td class="normaltext"><table width="100%" border="0" class='style2'>
                      <tr> 
                        <td width="10%" valign="middle"> <input name="A" type="checkbox" id="A" value="A" <% if (A!=null && A.equals("A")) { %> checked<% } %>>
                          A</td>
                        <td width="10%" valign="middle"> <input name="B" type="checkbox" id="B" value="B" <% if (B!=null && B.equals("B")) { %> checked<% } %>>
                          B</td>
                        <td width="10%" valign="middle"> <input name="B1" type="checkbox" id="B1" value="B1" <% if (B1!=null && B1.equals("B1")) { %> checked<% } %>>
                          B1</td>
                        <td width="10%" valign="middle"> <input name="B2" type="checkbox" id="B2" value="B2" <% if (B2!=null && B2.equals("B2")) { %> checked<% } %>>
                          B2</td>
                        <td width="10%" valign="middle"> <input name="C" type="checkbox" id="C" value="C" <% if (C!=null && C.equals("C")) { %> checked<% } %>>
                          C</td>
                        <td width="10%" valign="middle"> <input name="D" type="checkbox" id="D" value="D" <% if (D!=null && D.equals("D")) { %> checked<% } %>>
                          D</td>
                        <td width="10%" valign="middle"> <input name="E" type="checkbox" id="E" value="E" <% if (E!=null && E.equals("E")) { %> checked<% } %>>
                          E</td>
                        <td colspan="6">&nbsp; </td>
                      </tr>
                      <tr> 
                        <td valign="middle"> <input name="E1" type="checkbox" id="E1" value="E1" <% if (E1!=null && E1.equals("E1")) { %> checked<% } %>>
                          E1</td>
                        <td valign="middle"> <input name="E2" type="checkbox" id="E2" value="E2" <% if (E2!=null && E2.equals("E2")) { %> checked<% } %>>
                          E2</td>
                        <td valign="middle"> <input name="F" type="checkbox" id="F" value="F" <% if (F!=null && F.equals("F")) { %> checked<% } %>>
                          F</td>
                        <td valign="middle"> <input name="G" type="checkbox" id="G" value="G" <% if (G!=null && G.equals("G")) { %> checked<% } %>>
                          G</td>
                        <td valign="middle"> <input name="H" type="checkbox" id="H" value="H" <% if (H!=null && H.equals("H")) { %> checked<% } %>>
                          H</td>
                        <td valign="middle"> <input name="I" type="checkbox" id="I" value="I" <% if (I!=null && I.equals("I")) { %> checked<% } %>>
                          I</td>
                        <td valign="middle">&nbsp;</td>
                        <td width="10%">&nbsp;</td>
                        <td width="10%">&nbsp;</td>
                        <td width="10%">&nbsp;</td>
                        <td width="10%">&nbsp;</td>
                        <td width="10%">&nbsp;</td>
                        <td width="10%">&nbsp;</td>
                      </tr>
                    </table></td>
                </tr>
                <tr> 
                  <td colspan="3" nowrap bgcolor="#666666" class=normaltext style='border-top:none'><strong><font color="#FFFFFF">Maklumat 
                    Akademik Menengah Tertinggi(UPSR/PMR/SPM)</font></strong></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Nama 
                    Sekolah<font color="#FF0000">*</font></strong></td>
                  <td nowrap class=normaltext style='border-top:none'>&nbsp;</td>
                  <td nowrap class=normaltext style='border-top:none'><input name="school_name" type="text" id="school_name" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" value="<%=school_name%>" size="50" maxlength="100"></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Tahun 
                    Tamat Persekolahan<font color="#FF0000">*</font></strong></td>
                  <td nowrap class=normaltext style='border-top:none'>&nbsp;</td>
                  <td nowrap class=normaltext style='border-top:none'><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                    <script>yearDispFromSchool('<%=school_year%>');</script>
                    </font></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Nama 
                    Sijil (UPSR/PMR/SPM)<font color="#FF0000">*</font></strong></td>
                  <td nowrap class=normaltext style='border-top:none'>&nbsp;</td>
                  <td nowrap class=normaltext style='border-top:none'><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                    <select name="school_qual" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                      <option value="" selected>Sila Pilih</option>
                      <option value="16" <%if (school_qual!=null&&school_qual.equals("16")) { %> selected<% } %>>UPSR</option>
                      <option value="15"  <%if (school_qual!=null&&school_qual.equals("15")) { %> selected<% } %>>PMR 
                      </option>
                      <option value="06"  <%if (school_qual!=null&&school_qual.equals("06")) { %> selected<% } %>>SRP</option>
                      <option value="05"  <%if (school_qual!=null&&school_qual.equals("05")) { %> selected<% } %>>SPM 
                      </option>
                    </select>
                    </font></font></td>
                </tr>
                <tr> 
                  <td valign="top" nowrap class=normaltext style='border-top:none'><strong>Pencapaian<font color="#FF0000">*</font></strong></td>
                  <td nowrap class=normaltext style='border-top:none'>&nbsp;</td>
                  <td nowrap class=normaltext style='border-top:none'><table width="100%" border="0" cellspacing="1" class='style2'>
                      <tr> 
                        <td width="25%">Bahasa Melayu</td>
                        <td width="75%"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                          <select name="school_bm" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" >
                            <!--<option selected >...</option>-->
                            <option value="A1"  <%if (school_bm!=null&&school_bm.equals("A1")) { %> selected<% } %>>A1</option>
                            <option value="A2" <%if (school_bm!=null&&school_bm.equals("A2")) { %> selected<% } %>>A2 
                            </option>
                            <option value="B3" <%if (school_bm!=null&&school_bm.equals("B3")) { %> selected<% } %>>B3</option>
                            <option value="B4" <%if (school_bm!=null&&school_bm.equals("B4")) { %> selected<% } %>>B4 
                            </option>
                            <option value="C5" <%if (school_bm!=null&&school_bm.equals("C5")) { %> selected<% } %>>C5</option>
                            <option value="C6" <%if (school_bm!=null&&school_bm.equals("C6")) { %> selected<% } %>>C6 
                            </option>
                            <option value="P7" <%if (school_bm!=null&&school_bm.equals("P7")) { %> selected<% } %>>P7</option>
                            <option value="P8" <%if (school_bm!=null&&school_bm.equals("P8")) { %> selected<% } %>>P8 
                            </option>
                            <option value="F9" <%if (school_bm!=null&&school_bm.equals("F9")) { %> selected<% } %>>F9 
                            </option>
                          </select>
                          </font></td>
                      </tr>
                      <tr> 
                        <td>Bahasa Inggeris</td>
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                          <select name="school_bi" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                            <!--<option selected >...</option>-->
                            <option value="A1" <%if (school_bi!=null&&school_bi.equals("A1")) { %> selected<% } %>>A1</option>
                            <option value="A2" <%if (school_bi!=null&&school_bi.equals("A2")) { %> selected<% } %>>A2 
                            </option>
                            <option value="B3" <%if (school_bi!=null&&school_bi.equals("B3")) { %> selected<% } %>>B3</option>
                            <option value="B4" <%if (school_bi!=null&&school_bi.equals("B4")) { %> selected<% } %>>B4 
                            </option>
                           <option value="C5" <%if (school_bi!=null&&school_bi.equals("C5")) { %> selected<% } %>>C5</option>
                            <option value="C6" <%if (school_bi!=null&&school_bi.equals("C6")) { %> selected<% } %>>C6 
                            </option>
                            <option value="P7" <%if (school_bi!=null&&school_bi.equals("P7")) { %> selected<% } %>>P7</option>
                            <option value="P8" <%if (school_bi!=null&&school_bi.equals("P8")) { %> selected<% } %>>P8 
                            </option>
                            <option value="F9" <%if (school_bi!=null&&school_bi.equals("F9")) { %> selected<% } %>>F9 
                            </option>
                          </select>
                          </font></td>
                      </tr>
                      <tr> 
                        <td>Matematik</td>
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                          <select name="school_mate" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                            <!--<option selected >...</option>-->
                            <option value="A1" <%if (school_math!=null&&school_math.equals("A1")) { %> selected<% } %>>A1</option>
                            <option value="A2" <%if (school_math!=null&&school_math.equals("A2")) { %> selected<% } %>>A2 
                            </option>
                            <option value="B3" <%if (school_math!=null&&school_math.equals("B3")) { %> selected<% } %>>B3</option>
                            <option value="B4" <%if (school_math!=null&&school_math.equals("B4")) { %> selected<% } %>>B4 
                            </option>
                           <option value="C5" <%if (school_math!=null&&school_math.equals("C5")) { %> selected<% } %>>C5</option>
                            <option value="C6" <%if (school_math!=null&&school_math.equals("C6")) { %> selected<% } %>>C6 
                            </option>
                            <option value="P7" <%if (school_math!=null&&school_math.equals("P7")) { %> selected<% } %>>P7</option>
                            <option value="P8" <%if (school_math!=null&&school_math.equals("P8")) { %> selected<% } %>>P8 
                            </option>
                            <option value="F9" <%if (school_math!=null&&school_math.equals("F9")) { %> selected<% } %>>F9 
                            </option>
                          </select>
                          </font></font></td>
                      </tr>
                    </table></td>
                </tr>
                <tr> 
                  <td colspan="3" nowrap bgcolor="#666666" class=normaltext style='border-top:none'><strong><font color="#FFFFFF">Maklumat 
                    Akademik Terkini</font></strong></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Nama 
                    Kolej/Universiti</strong></td>
                  <td>&nbsp;</td>
                  <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                    <input type="text" name="insti_name"  value="<%=( ( insti_name==null)?"":insti_name )%>" size="40" maxlength="100" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                    </font></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Tahun 
                    Mula</strong></td>
                  <td>&nbsp;</td>
                  <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                    <script>yearDispFrom('<%=yearFrom%>');</script>
                    </font></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Tahun 
                    Akhir</strong></td>
                  <td>&nbsp;</td>
                  <td class=normaltext><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                    <script>yearDispTo('<%=yearTo%>'); </script>
                    </font></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Sijil/Diploma/Ijazah</strong></td>
                  <td>&nbsp;</td>
                  <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                    <input type="text" name="insti_qual"  value="<%=( ( qualification==null)?"":qualification )%>" size="40" maxlength="100" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                    </font></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Kelas 
                    Kepujian (CGPA@CPA)</strong></td>
                  <td>&nbsp;</td>
                  <td> <input name="insti_class" type="text" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" value="<%=( ( instiClass==null)?"":instiClass )%>" size="10" maxlength="10"> 
                    <font size="1">contoh : 3.76</font></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Bidang 
                    Pengkhususan</strong></td>
                  <td>&nbsp;</td>
                  <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                    <input type="text" name="clasify"  value="<%=( ( clasify==null)?"":clasify )%>" size="20" maxlength="100" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                    </font></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>CGPA@CPA 
                    diperingkat<br>
                    Ijazah Sarjana Muda</strong></td>
                  <td>&nbsp;</td>
                  <td class=normaltext> <input name="insti_cgpa_degree" type="text" id="insti_cgpa_degree"  value="<%=( ( insti_cgpa_degree==null)?"":insti_cgpa_degree )%>" size="10" maxlength="10" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;"> </font> 
                    <font size="1">contoh : 3.76</font><font size="2" face="Verdana, Arial, Helvetica, sans-serif">&nbsp; 
                    </font></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Kelas</strong></td>
                  <td>&nbsp;</td>
                  <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                    <select name="insti_class_degree" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                      <option value="">Sila Pilih</option>
                      <option value="KELAS1" <%if (insti_class_degree!=null&&insti_class_degree.equals("KELAS1")) { %> selected<% } %>>Kelas 
                      Pertama</option>
                      <option value="KELAS2ATAS" <%if (insti_class_degree!=null&&insti_class_degree.equals("KELAS2ATAS")) { %> selected<% } %>>Kelas 
                      II Atas</option>
                      <option value="KELAS2BAWAH" <%if (insti_class_degree!=null&&insti_class_degree.equals("KELAS2BAWAH")) { %> selected<% } %>>Kelas 
                      II Bawah</option>
                      <option value="KELAS3" <%if (insti_class_degree!=null&&insti_class_degree.equals("KELAS3")) { %> selected<% } %>>Kelas 
                      III</option>
                    </select>
                    </font></td>
                </tr>
                <tr> 
                  <td colspan="3" nowrap bgcolor="#666666" class=normaltext style='border-top:none'><strong><font color="#FFFFFF">Maklumat 
                    Aktiviti Ko-Kurikulum</font></strong></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Kegiatan 
                    Luar Semasa Di<br>
                    (Sekolah/Universiti)</strong></td>
                  <td>&nbsp;</td>
                  <td class="normaltext"><textarea name="extra" cols="50" id="extra" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" onKeyPress="return taLimit()" onKeyUp="return taCount(myCounter)" maxlength="1000"><%=( ( extra==null)?"":extra )%></textarea> 
                  </td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Kegiatan 
                    Sukan Semasa Di<br>
                    (Sekolah/Universiti)</strong></td>
                  <td>&nbsp;</td>
                  <td class="normaltext"> <textarea name="sport" cols="50" id="sport" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" onKeyPress="return taLimit()" onKeyUp="return taCount(myCounter)" maxlength="1000"><%=( ( sport==null)?"":sport )%></textarea></td>
                </tr>
                <tr> 
                  <td colspan="3" nowrap bgcolor="#666666" class=normaltext style='border-top:none'><strong><font color="#FFFFFF">Maklumat 
                    Pengalaman Terkini</font></strong></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Nama 
                    Majikan</strong></td>
                  <td>&nbsp;</td>
                  <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                    <input type="text" name="employer_name"  value="<%=( ( employer_name==null)?"":employer_name )%>" size="20" maxlength="50"style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                    </font></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Alamat 
                    Majikan</strong></td>
                  <td>&nbsp;</td>
                  <td class="normaltext"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                    <textarea name="employer_address" value='' style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" cols="50"><%=( ( employer_address==null)?"":employer_address )%></textarea>
                    </font></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Tarikh 
                    Mula</strong></td>
                  <td>&nbsp;</td>
                  <td> <input type="text" name="t_mula"  value="<%=( ( t_mula==null)?"":t_mula )%>" size="12" maxlength="14" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                    <img src='cms/eRecruitment/images/calendar.jpg' title='Klik disini' alt='Klik disini' onClick="scwShow(scwID('t_mula'),event);" /></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Jawatan</strong></td>
                  <td>&nbsp;</td>
                  <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                    <input type="text" name="post"  value="<%=( ( post==null)?"":post )%>" size="20" maxlength="100" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                    </font></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Gaji 
                    pokok sebulan </strong></td>
                  <td>&nbsp;</td>
                  <td> <input type="text" name="salary"  value="<%=( ( salary==null)?"":salary )%>" size="20" maxlength="255" onKeyPress="return isNumberKey(event)" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;"> 
                    <font size="1">contoh : 1200</font></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Jumlah 
                    Tahun Bekerja <br>
                    Termasuk Pengalaman Terkini</strong></td>
                  <td>&nbsp;</td>
                  <td> <input type="text" name="jum_tahun"  value="<%=( ( jum_tahun==null)?"":jum_tahun )%>" size="10" maxlength="15" onKeyPress="return isNumberKey(event)" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;"> 
                    <font size="1">contoh : 12</font></td>
                </tr>
                <tr> 
                  <td colspan="3" nowrap bgcolor="#666666" class=normaltext style='border-top:none'><strong><font color="#FFFFFF">Maklumat 
                    Kakitangan Kerajaan</font></strong></td>
                </tr>
                <tr> 
                  <td height="50" nowrap class=normaltext style='border-top:none'><strong>Adakah 
                    Anda Kakitangan Kerajaan?<font color="#FF0000">*</font></strong></td>
                  <td height="50">&nbsp;</td>
                  <td height="50"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                    <select name="gov_staff" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                      <option selected >Sila Pilih</option>
                      <option value="Y" <%if (gov_staff!=null&&gov_staff.equals("Y")) { %> selected<% } %>>Ya 
                      <option value="N" <%if (gov_staff!=null&&gov_staff.equals("N")) { %> selected<% } %>>Tidak 
                      </option>
                    </select>
                    </font></td>
                </tr>
                <tr> 
                  <td colspan="3" nowrap bgcolor="#666666" class=normaltext style='border-top:none'><strong><font color="#FFFFFF">Rujukan</font></strong></td>
                </tr>
                <tr valign="top"> 
                  <td colspan="3" nowrap class=normaltext style='border-top:none'><table width="100%" border="0" cellspacing="0">
                      <tr> 
                        <td width="47%"><table width="100%" border="0" cellpadding="4" cellspacing="0" bgcolor="#333333" class='style2'>
                            <tr bgcolor="#E4E4E4"> 
                              <td colspan="2" nowrap class=normaltext style='border-top:none'> 
                                <div align="center"><strong>Rujukan 1</strong></div></td>
                            </tr>
                            <tr bgcolor="#FFFFFF"> 
                              <td width="25%" nowrap class=normaltext style='border-top:none'><strong>Nama<font color="#FF0000">*</font></strong></td>
                              <td width="75%"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                                <input name="nama_penjamin1" type="text" id="nama_penjamin1"style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;"  value="<%=nama_penjamin1%>" size="20" maxlength="50">
                                </font></td>
                            </tr>
                            <tr bgcolor="#FFFFFF"> 
                              <td nowrap class=normaltext style='border-top:none'><strong>Alamat<font color="#FF0000">*</font></strong></td>
                              <td class="normaltext"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                                <textarea name="alamat_penjamin1" cols="25" id="alamat_penjamin1" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" value=''><%=alamat_penjamin1%></textarea>
                                </font></td>
                            </tr>
                            <tr bgcolor="#FFFFFF"> 
                              <td nowrap class=normaltext style='border-top:none'><strong>Pekerjaan<font color="#FF0000">*</font> 
                                </strong></td>
                              <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                                <input name="pekerjaan_penjamin1" type="text" id="pekerjaan_penjamin1" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;"  value="<%=pekerjaan_penjamin1%>" size="25" maxlength="100">
                                </font> </td>
                            </tr>
                            <tr bgcolor="#FFFFFF"> 
                              <td nowrap class=normaltext style='border-top:none'><strong>Telefon<font color="#FF0000">*</font></strong></td>
                              <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                                <input name="tel_penjamin1" type="text" id="tel_penjamin1" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;"  value="<%=tel_penjamin1%>" size="20" maxlength="100">
                                </font></td>
                            </tr>
                          </table></td>
                        <td width="50%"><table width="100%" border="0" cellpadding="4" cellspacing="0" bgcolor="#FFFFFF" class='style2'>
                            <tr bgcolor="#E4E4E4"> 
                              <td colspan="2" nowrap class=normaltext style='border-top:none'> 
                                <div align="center"><strong> Rujukan 2</strong></div></td>
                            </tr>
                            <tr> 
                              <td width="26%" nowrap class=normaltext style='border-top:none'><strong>Nama<font color="#FF0000">*</font></strong></td>
                              <td width="74%"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                                <input name="nama_penjamin2" type="text" id="nama_penjamin2"style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;"  value="<%=nama_penjamin2%>" size="20" maxlength="50">
                                </font></td>
                            </tr>
                            <tr> 
                              <td nowrap class=normaltext style='border-top:none'><strong>Alamat<font color="#FF0000">*</font></strong></td>
                              <td class="normaltext"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                                <textarea name="alamat_penjamin2" cols="25" id="alamat_penjamin2" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" value=''><%=alamat_penjamin2%></textarea>
                                </font></td>
                            </tr>
                            <tr> 
                              <td nowrap class=normaltext style='border-top:none'><strong>Pekerjaan<font color="#FF0000">*</font> 
                                </strong></td>
                              <td> <font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                                <input name="pekerjaan_penjamin2" type="text" id="pekerjaan_penjamin2" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;"  value="<%=pekerjaan_penjamin2%>" size="25" maxlength="100">
                                </font> </td>
                            </tr>
                            <tr> 
                              <td nowrap class=normaltext style='border-top:none'><strong>Telefon<font color="#FF0000">*</font></strong></td>
                              <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                                <input name="tel_penjamin2" type="text" id="tel_penjamin2" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;"  value="<%=tel_penjamin2%>" size="20" maxlength="100">
                                </font></td>
                            </tr>
                          </table></td>
                      </tr>
                    </table></td>
                </tr>
                <tr align="right" valign="middle"> 
                  <td colspan="3" nowrap bgcolor="#CCCCCC" class=normaltext style='border-top:none'>Sila 
                    pastikan segala maklumat yg diisi adalah tepat dan lengkap. 
                    <A HREF="javascript:validateForm();" onMouseOver="window.status='Kemaskini';return true;"><IMG SRC="cms/eRecruitment/images/ic_update.gif" BORDER="0" ALT="Kemaskini"></A> 
                    <A HREF="eRecruitment.jsp?action=mainpage" onMouseOver="window.status='Kemaskini';return true;"><IMG SRC="cms/eRecruitment/images/ic_cancel.gif" BORDER="0" ALT="Batal"></A> 
                    &nbsp;</td>
                </tr>
              </table></td>
          </tr>
        </table></td>
    </tr>
  </table>
</form>
			</body>
</html>
<% conn.close();%>
<%} else{
response.sendRedirect("../../eRecruitment.jsp?action=mainpage");
}%>
