<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="common.Messages" %>
<% Messages messages = Messages.getMessages(request); %>

<% if ((String)session.getAttribute("kadpengenalan" ) != null ) { %>
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
	boolean flag = false; 
	boolean flag2 = false;
	String action = request.getParameter("action");
	//String post1 = request.getParameter("post1");
	//String post2 = request.getParameter("post2");
	//String bidang = request.getParameter("bidang");
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
	String date_apply=request.getParameter("date_apply");
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
	String result_bm = request.getParameter("result_bm");
	String result_bi = request.getParameter("result_bi");
	String result_math = request.getParameter("result_math");
	String bm = request.getParameter("bm");
	String bi = request.getParameter("bi");
	String math = request.getParameter("math");
	String condition = "";
	String conditionBI = "";
	String conditionMath = "";
	PreparedStatement pstmt = null;
	ResultSet rset	= null;
	
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
String sql	=	"SELECT SCH_REF_ID,sch_post_1,sch_majoring1,sch_post_2,sch_majoring2,sch_name,sch_gender, "+
				"sch_ic_num,sch_pasport_num,sch_current_address,sch_current_city,state1.sm_state_desc, "+
				"sch_current_country,sch_current_pcode,sch_current_telno, sch_email_addr ,to_char(sch_birth_date,'dd/mm/yyyy'), "+
				"sch_age,sch_handphone_no,sch_co_curriculum_activity, SCH_SPORT_ACTIVITY, "+
				"SCH_PERMANENT_ADDRESS,SCH_PERMANENT_PCODE,SCH_PERMANENT_CITY,state2.sm_state_desc, SCH_GOV_STAFF, "+
				"sci_institution_name,sci_year_from,sci_year_to,sci_qualification, "+
				"sci_class,sci_classification,sci_cgpa_degree, sci_class_degree, "+
				"SCE_EMPLOYER_NAME,SCE_EMPLOYER_ADDRESS,SCE_POST, "+
   				"SCE_BASIC_SALARY, to_char(SCE_DATE_FROM,'dd/mm/yyyy'), sce_total_year, "+
				"SCS_YEAR,SCS_SCHOOL,SCS_QUALIFICATION_CODE,SCS_RESULT_BM, "+
				"SCS_RESULT_BI, SCS_RESULT_MATH,SERVICE1.SS_SERVICE_DESC,SERVICE2.SS_SERVICE_DESC,DEPT1.DM_DEPT_DESC, DEPT2.DM_DEPT_DESC,SCH_MARITAL_STATUS, "+
				"SCL_A,SCL_B,SCL_B1,SCL_B2,SCL_C,SCL_D,SCL_E,SCL_E1,SCL_E2,SCL_F,SCL_G,SCL_H,SCL_I,SCH_RECOMMENDER1_NAME,SCH_RECOMMENDER1_ADDRESS,SCH_RECOMMENDER1_WORK_DESC, "+
				"SCH_RECOMMENDER1_CONTACT_NUM, SCH_RECOMMENDER2_NAME,SCH_RECOMMENDER2_ADDRESS,SCH_RECOMMENDER2_WORK_DESC,SCH_RECOMMENDER2_CONTACT_NUM,SERVICE1.SS_JPA_CODE, "+
				"SERVICE2.SS_JPA_CODE,SCH_JPA,TO_CHAR(SCH_APPLY_DATE,'DD-MM-YYYY'),SUBSTR(SCS_RESULT_BM , 2),SUBSTR(SCS_RESULT_BI , 2),SUBSTR(SCS_RESULT_MATH , 2),RPH_BM,RPH_BI,RPH_MATE "+
				"FROM STAFF_CANDIDATE_HEAD,STAFF_CANDIDATE_INSTITUTION,STAFF_CANDIDATE_EXPERIENCE,STAFF_CANDIDATE_SCHOOL, "+
				"RECRUITMENT_POST POST1,RECRUITMENT_POST POST2,SERVICE_SCHEME SERVICE1,SERVICE_SCHEME SERVICE2, "+
				"DEPARTMENT_MAIN DEPT1, DEPARTMENT_MAIN DEPT2,STAFF_CANDIDATE_LICENCE,STATE_MAIN STATE1, STATE_MAIN STATE2, RECRUITMENT_POST_HEAD "+
				"WHERE SCH_REF_ID = sci_candidate_refid (+) "+
				"AND SCH_REF_ID = SCE_CANDIDATE_REFID (+) "+
				"AND SCH_REF_ID = SCS_CANDIDATE_REFID (+) "+
				"AND SCH_REF_ID = SCL_REF_ID (+) "+
				"AND POST1.RP_REF_ID (+) = SCH_POST_1 " +
				 "AND POST2.RP_REF_ID (+) = SCH_POST_2 " +
				 "AND SERVICE1.SS_SERVICE_CODE(+) = POST1.RP_SERVICE_CODE " +
				 "AND SERVICE2.SS_SERVICE_CODE(+) = POST2.RP_SERVICE_CODE " +
				 "AND POST1.RP_DEPT_CODE=DEPT1.DM_DEPT_CODE(+) " +
				 "AND POST2.RP_DEPT_CODE=DEPT2.DM_DEPT_CODE(+) " +
				 "AND sch_current_state = STATE1.SM_STATE_CODE "+
				 "AND SCH_PERMANENT_STATE = state2.sm_state_code "+
				 "AND POST1.RP_POST_ID = RPH_POST_ID "+
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
		date_apply = rset.getString (76);
		result_bm = rset.getString (77);
		result_bi = rset.getString (78);
		result_math = rset.getString (79);
		bm = rset.getString(80);
		bi = rset.getString(81);
		math = rset.getString(82);
		
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
      //if (conn != null) conn.close();  
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
<head>
<title>Cetak Borang Permohonan</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="/cms/eRecruitment/nocache/no-cache.jsp" %>
<style type="text/css">
<!--
.style11 {	font-family: Arial, Helvetica, sans-serif;
	font-size: 13px;
	font-weight: bold;
	color: #000000;
}
.style11 {	font-family: Arial, Helvetica, sans-serif;
	font-size: 13px;
	font-weight: bold;
	color: #000000;
}
.style21 {	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	color: #000000;
}
.style21 {	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	color: #000000;
}
.textfield_effect    {   
/*we will first set the border styles.*/   
border-width: 1px;   
border-style: solid;    
border-color: #000000;
font-family: Verdana, Arial, Helvetica, sans-serif;
font-size: 11px;
color: #000000;
}
-->
</style>
</head>
<style type="text/css">
<!--
.style1 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 13px;
	font-weight: bold;
	color: #000000;
}
.style2 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	color: #000000;
}
a {
	color: #333333;
	TEXT-DECORATION: none;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
}
-->
</style>
<script language=JavaScript> 
var message="Function Disabled!"; 

/////////////////////////////////// 
function clickIE4(){ 
if (event.button==2){ 
alert(message); 
return false; 
} 
} 

function clickNS4(e){ 
if (document.layers||document.getElementById&&!document.all){ 
if (e.which==2||e.which==3){ 
alert(message); 
return false; 
} 
} 
} 

if (document.layers){ 
document.captureEvents(Event.MOUSEDOWN); 
document.onmousedown=clickNS4; 
} 
else if (document.all&&!document.getElementById){ 
document.onmousedown=clickIE4; 
} 

document.oncontextmenu=new Function("alert(message);return false") 

// --> 
function killCopy(e){
	return false
}
function reEnable(){
	return true
}
document.onselectstart=new Function ("return false")
if (window.sidebar){
	document.onmousedown=killCopy
	document.onclick=reEnable
}
</script>
<body onLoad="window.print()">
<DIV style="page-break-after:always">
<table width="100%" border="0" class='style11'>
  <tr>
    <td width="12%" valign="top"><p><img src="cms/eRecruitment/images/logoump2.jpg" width="114" height="151"></p></td>
    <td width="65%" valign="top"><p><font size="4"><font size="3"><br>
      PERMOHONAN JAWATAN SECARA ONLINE<br>
      UNIVERSITI MALAYSIA PAHANG</font></font><br>
  <em>http://www.ump.edu.my</em></p>
      <p><br>
      <em><font size="2">(Cetakan  Senarai Semak Kelayakan Permohonan Perjawatan Atas Talian)</font></em></p></td>
    <td width="23%">&nbsp;
  	<% 
	if (bm != null && bi !=null && math !=null){
		if (!bm.equals("0") && !math.equals("0") && !bi.equals("0"))
		  { 
		  if ((Integer.parseInt(result_bm) <= Integer.parseInt(bm)) && (Integer.parseInt(result_math) <= Integer.parseInt(math)) && (Integer.parseInt(result_bi) <= Integer.parseInt(bi))) 
		  	{
	%>	<img src="cms/eRecruitment/images/logoPendaftar.gif" width="200" height="193">
	<%		}
		  }
		else if (bm.equals("0") && !math.equals("0") && !bi.equals("0"))
		  {	
		  if ((Integer.parseInt(result_math) <= Integer.parseInt(math)) && (Integer.parseInt(result_bi) <= Integer.parseInt(bi)))
		  	{
	%>
    <img src="cms/eRecruitment/images/logoPendaftar.gif" width="200" height="193">
    <%
			}
		  }
		else if (!bm.equals("0") && math.equals("0") && !bi.equals("0"))
		  { 
		  if((Integer.parseInt(result_bm) <= Integer.parseInt(bm)) && (Integer.parseInt(result_bi) <= Integer.parseInt(bi)))
		  	{
	%>
    <img src="cms/eRecruitment/images/logoPendaftar.gif" width="200" height="193">
    <%
			}
		  }
		else if (!bm.equals("0") && !math.equals("0") && bi.equals("0"))
		  { 
		  if((Integer.parseInt(result_bm) <= Integer.parseInt(bm)) && (Integer.parseInt(result_math) <= Integer.parseInt(math)))
		  	{
	%>
    <img src="cms/eRecruitment/images/logoPendaftar.gif" width="200" height="193">
    <%
			}
		  }

	}
	%>
    </td>
  </tr>
  <tr>
    <td colspan="3" valign="top"><form name="form1" method="post" action="">
      <p>&nbsp;</p>
      <table width="50%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000000">
        <tr>
          <td height="25" bgcolor="#DADADA" class="style21"><strong>&nbsp;&nbsp;SENARAI SEMAK KELAYAKAN</strong></td>
        </tr>
        <tr>
          <td><br>
            <table width="90%" border="0" align="center">
            <tr>
              <td width="62%" class="style21"><strong><u>MAKLUMAT JAWATAN</u></strong></td>
              <td width="38%">&nbsp;</td>
            </tr>
            <tr align="center">
              <td colspan="2"><table width="100%"  border="0" align="center" cellpadding="2" cellspacing="0" class='style2'>
                <tr>
                  <th scope="row" width="40%"><div align="left"><strong><span class="style5">Jawatan Pilihan Pertama</span></strong></div></th>
                  <th scope="row" width="2%">:</th>
                  <td width="8%">&nbsp;<%=job_post1%></td>
                  <td width="2%">-</td>
                  <td width="48%"><%=desc_post1%></td>
                </tr>
                <tr>
                  <th scope="row"><div align="left"><strong><span class="style5">Jawatan Pilihan Kedua</span></strong></div></th>
                  <th scope="row">:</th>
                  <td>&nbsp;<%=job_post2%></td>
                  <td>-</td>
                  <td><%=desc_post2%></td>
                </tr>
              </table></td>
              </tr>
            <tr align="center">
              <td colspan="2">&nbsp;</td>
              </tr>
            <tr>
              <td class="style11"><strong class="style21"><u>UMUR</u></strong></td>
              <td>&nbsp;</td>
              </tr>
            <tr>
              <td class="style21">19 - 25</td>
              <td rowspan="4" align="center"><table width="50%" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000">
                <tr>
                  <td width="86" height="25" align="center" class="style21"><% if (umur != null && Integer.parseInt(umur) <= 25 ) {%>
                    <img src="cms/eRecruitment/images/tick.gif" alt="" width="15" height="15"><%}else{ %>&nbsp;<%}%>
                    </td>
                  </tr>
                <tr>
                  <td width="86" height="25" align="center"><span class="style21"><% if (umur != null && Integer.parseInt(umur) >= 26 && Integer.parseInt(umur) <= 30 ) {%>
                    <img src="cms/eRecruitment/images/tick.gif" alt="" width="15" height="15"><%}else{%>&nbsp;<%}%></td>
                  </tr>
                <tr>
                  <td width="86" height="25" align="center"><span class="style21"><% if (Integer.parseInt(umur) >= 31 && Integer.parseInt(umur) <= 35 ) {%><img src="cms/eRecruitment/images/tick.gif" width="15" height="15">
                    <%}else{%>&nbsp;<%}%></td>
                  </tr>
                <tr>
                  <td height="25" align="center"><span class="style21">
                    <% if (Integer.parseInt(umur) >= 36 ) {%>
                    <img src="cms/eRecruitment/images/tick.gif" alt="" width="15" height="15">
                    <%}else{%>
                    &nbsp;
                    <%}%></td>
                </tr>
              </table></td>
              </tr>
            <tr>
              <td class="style21">26 - 30</td>
              </tr>
            <tr>
              <td class="style21">31 - 35</td>
              </tr>
            <tr>
              <td class="style21">&gt; 35</td>
              </tr>
            <tr>
              <td class="style11">&nbsp;</td>
              <td>&nbsp;</td>
              </tr>
            <tr>
              <td class="style21"><strong><u>KELULUSAN AKADEMIK TERKINI</u></strong></td>
              <td>&nbsp;</td>
              </tr>
            <tr>
              <td class="style21"><strong><%=( ( qualification==null)?"Tiada":qualification )%></strong></td>
              <td>&nbsp;</td>
              </tr>
            <tr>
              <td class="style21">CGPA :</td>
              <td align="center"><table width="50%" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000">
                <tr>
                  <td height="25" align="center" class="style21">&nbsp;<%=( ( instiClass==null)?" ":instiClass )%></td>
                </tr>
              </table></td>
              </tr>
            <tr>
              <td class="style21">&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td class="style21"><strong><u>KELULUSAN AKADEMIK MENENGAH TERTINGGI</u></strong></td>
              <td>&nbsp;</td>
              </tr>
            <tr>
              <td class="style21">UPSR</td>
              <td rowspan="3" align="center"><table width="50%" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000">
                <tr>
                  <td width="86" height="25" align="center" class="style21"><% if (school_qual!=null&&school_qual.equals("16")) {%>
                    <img src="cms/eRecruitment/images/tick.gif" alt="3" width="15" height="15">
                    <%}else{ %>
                    &nbsp;
                    <%}%></td>
                  </tr>
                <tr>
                  <td width="86" height="25" align="center"><span class="style21">
                    <% if (school_qual!=null&& (school_qual.equals("15") || school_qual.equals("06")))  {%>
                    <img src="cms/eRecruitment/images/tick.gif" alt="2" width="15" height="15">
                    <%}else{%>
                    &nbsp;
                    <%}%></td>
                  </tr>
                <tr>
                  <td width="86" height="25" align="center"><span class="style21">
                    <% if (school_qual!=null&&school_qual.equals("05")) {%>
                    <img src="cms/eRecruitment/images/tick.gif" alt="1" width="15" height="15">
                    <%}else{%>
                    &nbsp;
                    <%}%></td>
                  </tr>
              </table></td>
              </tr>
            <tr>
              <td class="style21">PMR / SRP</td>
              </tr>
            <tr>
              <td class="style21">SPM</td>
              </tr>
            <tr>
              <td class="style21">&nbsp;</td>
              <td>&nbsp;</td>
              </tr>
            <tr>
              <td class="style21"><strong><u>KEPUTUSAN <span style="border-top:none">
                <%if (school_qual!=null&&school_qual.equals("16")) { %>
UPSR
<% } %>
<%if (school_qual!=null&&school_qual.equals("15")) { %>
PMR
<% } %>
<%if (school_qual!=null&&school_qual.equals("06")) { %>
SRP
<% } %>
<%if (school_qual!=null&&school_qual.equals("05")) { %>
SPM
<% } %></u>
              </strong></td>
              <td>&nbsp;</td>
              </tr>
            <tr>
              <td class="style21">Bahasa Malaysia                </td>
              <td rowspan="3" align="center"><table width="50%" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000">
                <tr>
                  <td height="25" align="center" class="style21">&nbsp;<%=school_bm%></td>
                  </tr>
                <tr>
                  <td height="25" align="center"><span class="style21">&nbsp;<%=school_math%></span></td>
                  </tr>
                <tr>
                  <td height="25" align="center"><span class="style21">&nbsp;<%=school_bi%></span></td>
                  </tr>
              </table></td>
              </tr>
            <tr>
              <td class="style21">Matematik                </td>
              </tr>
            <tr>
              <td class="style21">Bahasa Inggeris</td>
              </tr>
            <tr>
              <td class="style21">&nbsp;</td>
              <td align="center">&nbsp;</td>
            </tr>
            <tr>
              <td class="style21"><strong>PENGALAMAN KERJA</strong></td>
              <td align="center">&nbsp;</td>
            </tr>
            <tr>
              <td class="style21">5 tahun ke atas</td>
              <td rowspan="3" align="center"><table width="50%" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000">
                <tr>
                  <td width="86" height="25" align="center" class="style21"><% if (jum_tahun != null && Integer.parseInt(jum_tahun) >= 5 ) {%>
                    <img src="cms/eRecruitment/images/tick.gif" alt="11" width="15" height="15">
                    <%}else{ %>
                    &nbsp;
                    <%}%></td>
                </tr>
                <tr>
                  <td width="86" height="25" align="center"><span class="style21">
                    <% if (umur != null && Integer.parseInt(jum_tahun) >= 2 && Integer.parseInt(jum_tahun) < 5 ) {%>
                    <img src="cms/eRecruitment/images/tick.gif" alt="" width="15" height="15">
                    <%}else{%>
                    &nbsp;
                    <%}%></td>
                </tr>
                <tr>
                  <td width="86" height="25" align="center"><span class="style21">
                    <% if (Integer.parseInt(jum_tahun) > 0 && Integer.parseInt(jum_tahun) <= 1 ) {%>
                    <img src="cms/eRecruitment/images/tick.gif" alt="9" width="15" height="15">
                    <%}else{%>
                    &nbsp;
                    <%}%></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td class="style21">2 tahun hingga 5 tahun</td>
              </tr>
            <tr>
              <td class="style21">Kurang 1 tahun</td>
            </tr>
            </table>
            <br></td>
        </tr>
        <tr>
          <td><table width="90%" border="0" align="center">
            <tr>
              <td><span class="style21"><br>
                Disahkan oleh Pegawai Pemilih :</span></td>
            </tr>
            <tr>
              <td><p>&nbsp;</p>
                <p>&nbsp;</p>
                <p class="style21">Nama:<br>
                  Jawatan :
                </p></td>
            </tr>
          </table>
            <br></td>
        </tr>
      </table>
      <p>&nbsp;</p>
    </form>
      <br>
      <br>
      <br>
      <br>
      <br></td>
  </tr>
</table>
</DIV>
<table width="100%" border="0" class='style1'>
  <tr> 
    <td valign="top"><p><font size="4"><br>
        <font size="3">PERMOHONAN JAWATAN SECARA ONLINE<br>
        UNIVERSITI MALAYSIA PAHANG</font></font><br>
        <em>http://www.ump.edu.my</em></p>
      <p><em><font size="2">(Cetakan Borang Permohonan Perjawatan Atas Talian)</font></em></p></td>
    <td width="30%"><div align="right"><img src="cms/eRecruitment/images/logo.gif" width="250" height="126"></div></td>
  </tr>
  <tr> 
    <td valign="top"><br>
      <br>
      <br>
      <table width="21%" height="20" border="1" align="center">
        <tr> 
          <td bgcolor="#000000"><table width="100%" border="0" cellspacing="2" bgcolor="#FFFFFF" class='style2'>
              <tr> 
                <td><p align="center"><br>
                  </p>
                  <p align="center">Gambar Berukuran pasport<br>
                    <em>(Passport Size Photo)</em></p>
                  <p align="center"><br>
                    <br>
                    <br>
                  </p>
                </td>
              </tr>
            </table></td>
        </tr>
      </table></td>
    <td><br>
      <br>
      <table width="60%" border="1" align="center">
        <tr> 
          <td bgcolor="#000000"><table width="100%" border="0" cellspacing="2" bgcolor="#FFFFFF" class='style2'>
              <tr> 
                <td><p align="center"><br>
                    <strong><u>For Office Use Only</u></strong><br>
                    <br>
                    Date of received :</p>
                  <p align="center">----------------------------<br>
                    <br>
                    Notes:</p>
                  <p align="center">----------------------------<br>
                    <br>
                    ----------------------------<br>
                    <br>
                    ----------------------------<br>
                    <br>
                    <br>
                  </p></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellpadding="2" cellspacing="0" bgcolor="#FFFFFF" class='style2'>
  <tr bgcolor="#FFFFFF"> 
    <td nowrap class=normaltext style='border-top:none'><strong>No Rujukan </strong><em>(Reference 
      Number) </em></td>
    <td nowrap class=normaltext style='border-top:none'>:</td>
    <td nowrap class=normaltext style='border-top:none'>&nbsp;<%=refid%></td>
  </tr>
  <tr bgcolor="#FFFFFF"> 
    <td nowrap class=normaltext style='border-top:none'><strong>Tarikh Permohonan 
      </strong><em>(Date Apply)</em></td>
    <td nowrap class=normaltext style='border-top:none'>:</td>
    <td nowrap class=normaltext style='border-top:none'>&nbsp;<%=date_apply%></td>
  </tr>
  <tr bgcolor="#FFFFFF"> 
    <td colspan="3" nowrap class=normaltext style='border-top:none'>&nbsp;</td>
  </tr>
  <tr bgcolor="#DADADA"> 
    <td colspan="3" nowrap bgcolor="#DADADA" class=normaltext style='border-top:none'><strong><font color="#000000">MAKLUMAT 
      JAWATAN YANG DIPOHON</font></strong></td>
  </tr>
  <tr> 
    <td colspan="3" nowrap class=normaltext style='border-top:none'> <table width="100%" border="0" cellspacing="1" class='style2'>
        <tr bgcolor="#CCCCCC"> 
          <td colspan="2" bgcolor="#FFFFFF"> <div align="left"><strong>&nbsp;&nbsp;&nbsp;&nbsp;<u>Pilihan 
              Jawatan Pertama</u></strong></div></td>
        </tr>
        <tr> 
          <td colspan="3"> <table width="100%"  border="0" cellpadding="2" cellspacing="0" class='style2'>
              <tr> 
                <th scope="row" width="16%"><div align="right"><span class="style5">Jawatan<strong> 
                    (<em>Post</em>) </strong></span>: </div></th>
                <td width="84%">&nbsp;<%=desc_post1%></td>
              </tr>
              <tr> 
                <th scope="row"><div align="right"><span class="style5"> Fakulti 
                    <em>(Faculty)<strong> </strong></em>: </span></div></th>
                <td> <p>&nbsp;<%=desc_dept1%></p></td>
              </tr>
              <tr> 
                <th scope="row"><div align="right"><span class="style5">Bidang 
                    <strong>(<em>Majoring</em>)</strong> : </span></div></th>
                <td>&nbsp;<%=bidang%></td>
              </tr>
            </table></td>
        </tr>
        <tr bgcolor="#CCCCCC"> 
          <td bgcolor="#FFFFFF"> <div align="left"><strong>&nbsp;&nbsp;&nbsp;&nbsp;<u>Pilihan 
              Jawatan Kedua</u></strong></div></td>
        </tr>
        <tr> 
          <td colspan="3"> <table width="100%"  border="0" cellpadding="2" cellspacing="0" class='style2'>
              <tr> 
                <th scope="row" width="16%"><div align="right"> <span class="style5">Jawatan<strong> 
                    (<em>Post</em>)</strong> </span>: </div></th>
                <td width="84%">&nbsp;<%=( ( desc_post2==null)?"-":desc_post2 )%> 
                </td>
              </tr>
              <tr> 
                <th scope="row"><div align="right"><span class="style5">Fakulti<strong> 
                    <em>(Faculty)</em></strong> :</span></div></th>
                <td> <p>&nbsp;<%=( ( desc_dept2==null)?"-":desc_dept2 )%></p></td>
              </tr>
              <tr> 
                <th scope="row"><div align="right"><span class="style5">Bidang 
                    <strong>(<em>Majoring</em>)</strong> :</span></div></th>
                <td>&nbsp;<%=( ( bidang2==null)?"-":bidang2 )%></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
  <tr bgcolor="#FFFFFF"> 
    <td colspan="3" nowrap class=normaltext style='border-top:none'>&nbsp;</td>
  </tr>
  <tr bgcolor="#DADADA"> 
    <td colspan="3" nowrap class=normaltext style='border-top:none'><strong><font color="#000000">MAKLUMAT 
      PEMOHON </font></strong></td>
  </tr>
  <tr> 
    <td nowrap class="normaltext">Nama Pemohon (<em>Applicant Name</em>)</td>
    <td>:</td>
    <td width="100%" class="normaltext"><%=name%></td>
  </tr>
  <tr> 
    <td nowrap class="normaltext">Jantina (<em>Gender</em>)</td>
    <td>:</td>
    <td width="100%" class="normaltext"> 
      <% if (jantina!=null&&jantina.equals("L")) { %>
      Lelaki 
      <% } %>
      <% if (jantina!=null&&jantina.equals("P")) { %>
      Perempuan 
      <% } %>
    </td>
  </tr>
  <tr> 
    <td nowrap class="normaltext">Tarikh Lahir (<em>Birth Date</em>)</td>
    <td>:</td>
    <td class="normaltext"><%=tarikhlahir2%> </td>
  </tr>
  <tr>
    <td nowrap class="normaltext">Taraf Perkahwinan (Marital Status)</td>
    <td>:</td>
    <td class="normaltext"><%=marital%></td>
  </tr>
  <tr> 
    <td nowrap class="normaltext">Umur pada iklan ditutup (<em>Age</em>)</td>
    <td>:</td>
    <td width="100%" class="normaltext"><%=umur%></td>
  </tr>
  <tr> 
    <td nowrap class="normaltext">No Kad Pengenalan Baru(<em>I/C No</em>)</td>
    <td>:</td>
    <td width="100%" class="normaltext"><%=newic%> </td>
  </tr>
  <tr> 
    <td nowrap class=normaltext>No Pasport (<em>Passport No</em>)</td>
    <td>:</td>
    <td width="100%" class="normaltext"><%=( ( passport==null)?"-":passport )%> 
    </td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Alamat Tetap (<em>Permanent 
      Addr</em>) </td>
    <td>:</td>
    <td width="100%" class="normaltext"><%=addr_perm%></td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Bandar (<em>City</em>)</td>
    <td>:</td>
    <td width="100%" class="normaltext" ><%=addr_perm_city%> </td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Negeri (<em>State</em>)</td>
    <td>:</td>
    <td width="100%" class="normaltext"> 
      <%=addr_perm_state.toUpperCase()%></td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Poskod (<em>Poscode</em>)</td>
    <td>:</td>
    <td width="100%" class="normaltext"><%=postcode_perm%> </td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Alamat Semasa ( <em>Current 
      Addr</em>)</td>
    <td>:</td>
    <td width="100%" class="normaltext"><%=addr_cur%> </td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Bandar (<em>City</em>)</td>
    <td>:</td>
    <td width="100%" class="normaltext"><%=( ( addr_cur_city==null)?" ":addr_cur_city )%></td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Negeri (<em>State</em>)</td>
    <td>:</td>
    <td width="100%" class="normaltext">
      <%=addr_cur_state.toUpperCase()%></td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Negara (<em>Country</em>)</td>
    <td>:</td>
    <td width="100%" class="normaltext"> 
      <% 
								for (int c=0;c<countrycode.length;c++)
								{
									if (addr_cur_country!=null&&addr_cur_country.equals(countrycode[c])){%>
      <%=countryname[c]%> 
      <%		
											}
								
										}
									}
									catch(Exception e)
									{
										System.out.println("Error:"+e);
									}
								%></SELECT>
    </td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Poskod (<em>Poscode</em>)</td>
    <td>:</td>
    <td class="normaltext"><%=postcode_cur%></td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Telefon (<em>Telephone</em>)</td>
    <td>:</td>
    <td width="100%" class="normaltext"><%=phone%> - Pejabat/Rumah<br> <%=hphone%> 
      - Bimbit </td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Email (<em>Email</em>)</td>
    <td>:</td>
    <td class="normaltext"><%=( ( email==null)?"-":email.toLowerCase() )%></td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Pemegang Biasiswa JPA</td>
    <td>:</td>
    <td class="normaltext"><%=( ( jpa==null)?"-":jpa )%> </td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Lesen Kenderaan </td>
    <td>:</td>
    <td width="100%" class="normaltext"><table width="50%" border="0" class='style2'>
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
        </tr>
      </table></td>
  </tr>
  <tr bgcolor="#DADADA"> 
    <td colspan="3" nowrap class=normaltext style='border-top:none'><strong>MAKLUMAT 
      AKADEMIK MENENGAH TERTINGGI(UPSR/PMR/SPM)</strong></td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Nama Sekolah (<em>School 
      Name</em>)</td>
    <td nowrap class=normaltext style='border-top:none'>:</td>
    <td nowrap class=normaltext style='border-top:none'><%=school_name%></td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Tahun (<em>Year</em>)</td>
    <td nowrap class=normaltext style='border-top:none'>:</td>
    <td nowrap class=normaltext style='border-top:none'> <%=school_year%> </td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Sijil (<em>Certification</em>)</td>
    <td nowrap class=normaltext style='border-top:none'>:</td>
    <td nowrap class=normaltext style='border-top:none'> 
      <%if (school_qual!=null&&school_qual.equals("16")) { %>
      UPSR 
      <% } %>
      <%if (school_qual!=null&&school_qual.equals("15")) { %>
      PMR 
      <% } %>
      <%if (school_qual!=null&&school_qual.equals("06")) { %>
      SRP 
      <% } %>
      <%if (school_qual!=null&&school_qual.equals("05")) { %>
      SPM 
      <% } %>
    </td>
  </tr>
  <tr> 
    <td valign="top" nowrap class=normaltext style='border-top:none'>Pencapaian</td>
    <td valign="top" nowrap class=normaltext style='border-top:none'>:</td>
    <td nowrap class=normaltext style='border-top:none'><table width="100%" border="0" cellspacing="1" class='style2'>
        <tr> 
          <td width="20%">Bahasa Melayu</td>
          <td width="80%"> 
            <%if (school_bm!=null&&school_bm.equals("A1")) { %>
            A1 
            <% } %>
            <%if (school_bm!=null&&school_bm.equals("A2")) { %>
            A2 
            <% } %>
            <%if (school_bm!=null&&school_bm.equals("B3")) { %>
            B3 
            <% } %>
			<%if (school_bm!=null&&school_bm.equals("B4")) { %>
            B4 
            <% } %>
			<%if (school_bm!=null&&school_bm.equals("C3")) { %>
            C3 
            <% } %>
            <%if (school_bm!=null&&school_bm.equals("C4")) { %>
            C4 
            <% } %>
            <%if (school_bm!=null&&school_bm.equals("C5")) { %>
            C5 
            <% } %>
            <%if (school_bm!=null&&school_bm.equals("C6")) { %>
            C6 
            <% } %>
            <%if (school_bm!=null&&school_bm.equals("P7")) { %>
            P7 
            <% } %>
            <%if (school_bm!=null&&school_bm.equals("P8")) { %>
            P8 
            <% } %>
            <%if (school_bm!=null&&school_bm.equals("F9")) { %>
            F9 
            <% } %>
          </td>
        </tr>
        <tr> 
          <td>Bahasa Inggeris</td>
          <td> 
            <%if (school_bi!=null&&school_bi.equals("A1")) { %>
            A1 
            <% } %>
            <%if (school_bi!=null&&school_bi.equals("A2")) { %>
            A2 
            <% } %>
			<%if (school_bi!=null&&school_bi.equals("B3")) { %>
            B3 
            <% } %>
			<%if (school_bi!=null&&school_bi.equals("B4")) { %>
            B4 
            <% } %>
            <%if (school_bi!=null&&school_bi.equals("C3")) { %>
            C3 
            <% } %>
            <%if (school_bi!=null&&school_bi.equals("C4")) { %>
            C4 
            <% } %>
            <%if (school_bi!=null&&school_bi.equals("C5")) { %>
            C5 
            <% } %>
            <%if (school_bi!=null&&school_bi.equals("C6")) { %>
            C6 
            <% } %>
            <%if (school_bi!=null&&school_bi.equals("P7")) { %>
            P7 
            <% } %>
            <%if (school_bi!=null&&school_bi.equals("P8")) { %>
            P8 
            <% } %>
            <%if (school_bi!=null&&school_bi.equals("F9")) { %>
            F9 
            <% } %>
          </td>
        </tr>
        <tr> 
          <td>Matematik</td>
          <td> 
            <%if (school_math!=null&&school_math.equals("A1")) { %>
            A1 
            <% } %>
            <%if (school_math!=null&&school_math.equals("A2")) { %>
            A2 
            <% } %>
			<%if (school_math!=null&&school_math.equals("B3")) { %>
            B3 
            <% } %>
			<%if (school_math!=null&&school_math.equals("B4")) { %>
            B4 
            <% } %>
            <%if (school_math!=null&&school_math.equals("C3")) { %>
            C3 
            <% } %>
            <%if (school_math!=null&&school_math.equals("C4")) { %>
            C4 
            <% } %>
            <%if (school_math!=null&&school_math.equals("C5")) { %>
            C5 
            <% } %>
            <%if (school_math!=null&&school_math.equals("C6")) { %>
            C6 
            <% } %>
            <%if (school_math!=null&&school_math.equals("P7")) { %>
            P7 
            <% } %>
            <%if (school_math!=null&&school_math.equals("P8")) { %>
            P8 
            <% } %>
            <%if (school_math!=null&&school_math.equals("F9")) { %>
            F9 
            <% } %>
          </td>
        </tr>
      </table></td>
  </tr>
  <tr bgcolor="#FFFFFF"> 
    <td colspan="3" nowrap class=normaltext style='border-top:none'>&nbsp;</td>
  </tr>
  <tr bgcolor="#DADADA"> 
    <td colspan="3" nowrap class=normaltext style='border-top:none'><strong>MAKLUMAT 
      AKADEMIK TERKINI</strong></td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Nama Kolej/Universiti 
      (<em>Univesity/College Name</em>)</td>
    <td>:</td>
    <td><%=( ( insti_name==null)?" ":insti_name )%> </td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Tahun Mula (<em>Start 
      Year</em>)</td>
    <td>:</td>
    <td><%=yearFrom%> </td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Tahun Akhir (<em>End Year</em>)</td>
    <td>:</td>
    <td class=normaltext> <%=yearTo%> </td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Sijil/Diploma/Ijazah (<em>Degree/Diploma/Certificate</em>)</td>
    <td>:</td>
    <td><%=( ( qualification==null)?" ":qualification )%> </td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Kelas Kepujian (CGPA@CPA)</td>
    <td>:</td>
    <td> <%=( ( instiClass==null)?" ":instiClass )%> </td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Bidang Pengkhususan (<em>Majoring</em>)</td>
    <td>:</td>
    <td> <%=( ( clasify==null)?" ":clasify )%> </td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>CGPA@CPA diperingkat<br>
      Ijazah Sarjana Muda</td>
    <td>:</td>
    <td class=normaltext> <%=( ( insti_cgpa_degree==null)?" ":insti_cgpa_degree )%></td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Kelas</td>
    <td>:</td>
    <td> 
      <%if (insti_class_degree!=null&&insti_class_degree.equals("KELAS1")) { %>
      Kelas Pertama 
      <% } %>
      <%if (insti_class_degree!=null&&insti_class_degree.equals("KELAS2ATAS")) { %>
      Kelas II Atas 
      <% } %>
      <%if (insti_class_degree!=null&&insti_class_degree.equals("KELAS2BAWAH")) { %>
      Kelas II Bawah 
      <% } %>
      <%if (insti_class_degree!=null&&insti_class_degree.equals("KELAS3")) { %>
      Kelas III 
      <% } %>
    </td>
  </tr>
  <tr bgcolor="#FFFFFF"> 
    <td colspan="3" nowrap class=normaltext style='border-top:none'>&nbsp;</td>
  </tr>
  <tr bgcolor="#DADADA"> 
    <td colspan="3" nowrap class=normaltext style='border-top:none'><strong>MAKLUMAT 
      AKTIVITI KO-KURIKULUM</strong></td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Kegiatan Luar Semasa Di<br>
      (Sekolah/Universiti)<br>
      (<em>External Activities</em>)</td>
    <td>:</td>
    <td class="normaltext"><%=( ( extra==null)?" ":extra )%> </td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Kegiatan Sukan Semasa 
      Di<br>
      (Sekolah/Universiti)<br>
      (<em>Sport Activities</em>)</td>
    <td>:</td>
    <td class="normaltext"> <%=( ( sport==null)?" ":sport )%></td>
  </tr>
  <tr bgcolor="#FFFFFF"> 
    <td colspan="3" nowrap class=normaltext style='border-top:none'>&nbsp;</td>
  </tr>
  <tr bgcolor="#DADADA"> 
    <td colspan="3" nowrap class=normaltext style='border-top:none'><strong>MAKLUMAT 
      PENGALAMAN TERKINI</strong></td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Nama Majikan (<em>Employer 
      Name</em>) </td>
    <td>:</td>
    <td> <%=( ( employer_name==null)?" ":employer_name )%> </td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Alamat Majikan (<em>Employer 
      Addr</em>) </td>
    <td>:</td>
    <td class="normaltext"> <%=( ( employer_address==null)?" ":employer_address )%></td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Tarikh Mula (<em>Start 
      Date</em>)</td>
    <td>:</td>
    <td> <%=( ( t_mula==null)?" ":t_mula )%> </td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Jawatan (<em>Post</em>)</td>
    <td>:</td>
    <td> <%=( ( post==null)?" ":post )%> </td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Gaji pokok sebulan (<em>Salary</em>)</td>
    <td>:</td>
    <td> <%=( ( salary==null)?" ":salary )%> </td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>Jumlah Tahun Bekerja <br>
      Termasuk Pengalaman Terkini</td>
    <td>:</td>
    <td> <%=( ( jum_tahun==null)?" ":jum_tahun )%> </td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr bgcolor="#DADADA"> 
    <td colspan="3" nowrap class=normaltext style='border-top:none'><strong><font color="#000000">RUJUKAN</font></strong></td>
  </tr>
  <tr valign="top"> 
    <td colspan="3" nowrap class=normaltext style='border-top:none'><table width="100%" border="0" cellspacing="0">
        <tr> 
          <td width="47%"><table width="100%" border="0" cellpadding="4" cellspacing="0" bgcolor="#333333" class='style2'>
              <tr bgcolor="#E4E4E4"> 
                <td colspan="3" nowrap class=normaltext style='border-top:none'> 
                  <div align="center"><strong><u>Rujukan 1</u></strong></div></td>
              </tr>
              <tr bgcolor="#FFFFFF"> 
                <td width="24%" nowrap class=normaltext style='border-top:none'>Nama</td>
                <td width="1%">:</td>
                <td width="75%"> <%=nama_penjamin1%></td>
              </tr>
              <tr bgcolor="#FFFFFF"> 
                <td nowrap class=normaltext style='border-top:none'>Alamat</td>
                <td class="normaltext">:</td>
                <td class="normaltext"> <%=alamat_penjamin1%></td>
              </tr>
              <tr bgcolor="#FFFFFF"> 
                <td nowrap class=normaltext style='border-top:none'>Pekerjaan</td>
                <td>:</td>
                <td> <%=pekerjaan_penjamin1%></td>
              </tr>
              <tr bgcolor="#FFFFFF"> 
                <td nowrap class=normaltext style='border-top:none'>Telefon</td>
                <td>:</td>
                <td> <%=tel_penjamin1%></td>
              </tr>
            </table></td>
          <td width="50%"><table width="100%" border="0" cellpadding="4" cellspacing="0" bgcolor="#FFFFFF" class='style2'>
              <tr bgcolor="#E4E4E4"> 
                <td colspan="3" nowrap class=normaltext style='border-top:none'> 
                  <div align="center"><strong><u>Rujukan 2</u></strong></div></td>
              </tr>
              <tr> 
                <td width="23%" nowrap class=normaltext style='border-top:none'>Nama</td>
                <td width="2%">:</td>
                <td width="75%"><%=nama_penjamin2%> </td>
              </tr>
              <tr> 
                <td nowrap class=normaltext style='border-top:none'>Alamat</td>
                <td class="normaltext">:</td>
                <td class="normaltext"><%=alamat_penjamin2%> </td>
              </tr>
              <tr> 
                <td nowrap class=normaltext style='border-top:none'>Pekerjaan</td>
                <td>:</td>
                <td> <%=pekerjaan_penjamin2%> </td>
              </tr>
              <tr> 
                <td nowrap class=normaltext style='border-top:none'>Telefon</td>
                <td>:</td>
                <td><%=tel_penjamin2%> </td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td nowrap class=normaltext style='border-top:none'>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="3" nowrap class=normaltext style='border-top:none'><strong>PENGAKUAN 
      PEMOHON (<em>FORM OF DECLARATION</em>)</strong></td>
  </tr>
  <tr> 
    <td colspan="3" nowrap class=normaltext style='border-top:none'><p>Saya akui 
        bahawa maklumat-maklumat yang saya berikan di dalam Borang Permohonan 
        ini serta lampiran-lampirannya <br>
        adalah lengkap, betul dan benar. Saya faham bahawa sekiranya ada diantara 
        maklumat-maklumat itu didapati palsu, maka <br>
        permohonan saya akan dibatalkan dan seterusnya sekiranya saya telah diberi 
        tawaran jawatan atau telahpun berkhidmat, <br>
        maka maklumat-maklumat palsu itu akan menjadi bukti dan alasan membatalkan 
        tawaran jawatan atau memberhentikan <br>
        saya dari jawatan dengan serta-merta.<br>
        ( <em>(I certify that the above information is correct and I understand 
        that any false information in this application, or its</em> <em>supporting 
        <br>
        documents, will become sufficient grounds for refusal of employment or 
        termination of employment immediately, without notice.)</em> </p>
      <p><br>
        <br>
        <br>
        .........................<br>
        Tandatangan Pemohon <em><br>
        (Applicant Signature)</em> : <br>
        <br>
        Tarikh <em>(Date)</em> : <br>
        <br>
        <br>
        .........................<br>
        No. K/P <em><br>
        (I/C Number)</em> <br>
      </p></td>
  </tr>
  <tr> 
    <td colspan="3" nowrap class=normaltext style='border-top:none'>&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="3" nowrap class=normaltext style='border-top:none'>&nbsp;</td>
  </tr>
  <% if (gov_staff!=null && gov_staff.equals("Y")){%>
  <tr> 
    <td colspan="3" nowrap class=normaltext style='border-top:none'><u><strong>PERAKUAN 
      KETUA JABATAN</strong></u> (* Wajib diisi bagi mereka yang sedang berkhidmat 
      dengan kerajaan)<br> <u><strong><em>CERTIFIED BY THE HEAD OF DEPARTMENT</em></strong> 
      <br>
      <em>(Compulsory to be fulfill by applicant who are currently working at 
      any Government Office/Statutory Body/Local Authority only).</em></u> <br> 
      <br>
      Dengan ini disahkan bahawa pemohon ini ialah kakitangan kerajaan dalam :<br> 
      <em>(I hereby confirmed that this applicant is currently working in our 
      organization which is stated below)</em> : <br> <br> </font> <table width="385" border="1" cellspacing="0" cellpadding="0" class='style2'>
        <tr> 
          <td width="329">i) Tempoh percubaan <br> <em>&nbsp;&nbsp;&nbsp;(Under 
            probation period)</em></td>
          <td width="50">&nbsp;</td>
        </tr>
        <tr> 
          <td>ii) Tetap <br> <em>&nbsp;&nbsp;&nbsp;(Permanent)</em></td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td>iii) Kontrak/Sementara <br> <em>&nbsp;&nbsp;&nbsp;(Contract/Temporary)</em></td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="2">iv) Lain-lain : ............................................. 
            <br> <em>(Others)</em></td>
        </tr>
      </table>
      <br> <br>
      Dengan ini diakui bahawa pemohon ini :<br> <em>(I hereby confirmed that 
      this applicant)</em><br> <br> <table width="385" border="1" cellspacing="0" cellpadding="0" class="style2">
        <tr> 
          <td width="334">i) Telah disahkan dalam jawatan <br> &nbsp;&nbsp;&nbsp;<em>(Has 
            been confirmed in his/her service)</em> </td>
          <td width="45">&nbsp;</td>
        </tr>
        <tr> 
          <td>ii) Belum disahkan dalam jawatan <br> &nbsp;&nbsp;&nbsp; <em>(Has 
            not been confirmed in his/her service)</em> </td>
          <td>&nbsp;</td>
        </tr>
      </table>
      <br> <br>
      Sila Tandakan<br> <em>*Please tick</em> <br> <br> <br>
      .................................<br>
      Tandatangan & Cop Stamp <em>(Signature & Rubber Stamp)</em> <br>
      Ketua Jabatan <em>(Head of Department)</em> <br> <br>
      Tarikh <em>(Date)</em> : <br> </td>
  </tr>
  <%}%>
</table>
</body>
</html>
<%
try
	{ conn.close (); }
catch (Exception e)
	{ conn = null; }
%>
<!--%} else {
response.sendRedirect("../../eRecruitment.jsp");}
% -->
<% } else { session.invalidate(); %>
<SCRIPT LANGUAGE="JavaScript">
			alert('<%= messages.getString("session.expired") %>');
			top.location.href="eRecruitment.jsp?action=logout";
</SCRIPT>
<% } %>

