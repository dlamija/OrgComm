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
	String ref = request.getParameter("dept");
	String ref2 = request.getParameter("dept");
	String post1 = request.getParameter("post1");
	String dept2 = request.getParameter("dept2");
	String ic_no = request.getParameter("ic_no");
	String dept = request.getParameter("dept");
	String post2 = request.getParameter("post2");
	String closing_date = request.getParameter("closing_date");
	String closing_date2 = request.getParameter("closing_date2");
	PreparedStatement pstmt_refid = null;
	ResultSet rset_refid	= null;
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
<%
if (conn != null)
{
String sql	= "SELECT SCH_REF_ID,SCH_APPLY_DATE,SUBSTR(SCH_REF_ID, 0,4) REFID FROM STAFF_CANDIDATE_HEAD "+
			  "WHERE SCH_IC_NUM='" + kadpengenalan +"' AND SCH_ARCHIVE='N' "+
			  "AND SUBSTR(SCH_REF_ID, 0,4) = TO_CHAR(SYSDATE,'YYYY') ";
try
{
	pstmt_refid = conn.prepareStatement(sql); 
	rset_refid 			= pstmt_refid.executeQuery();
	if (rset_refid.next())
	{
		flag = true;
	}
	rset_refid.close();
	pstmt_refid.close();
}
	catch (SQLException e)
		{ out.println ("Error : " + e.toString ()); }
	finally {
  try {
     if (rset_refid != null) rset_refid.close();
	if (pstmt_refid != null) pstmt_refid.close();
  }
  catch (Exception e) { }
 }
 }
%>
<% if (!flag) {%>
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
<%@include file="../../../cms/eRecruitment/login/profile.jsp" %>
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
 if (document.applForm.post1.value=='')
  {
     alert("Sila Pilih Jawatan (Please Select post)");
	 document.applForm.post1.focus();
	 //return false;
  }
  else if (document.applForm.dept.value=='')
  {
     alert("Sila Pilih Fakulti/Jabatan (Please Select Faculty/Department)");
	 document.applForm.dept.focus();
	 //return false;
  }
  else if (document.applForm.nama.value=='')
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
 /*else if(document.applForm.employer_name.value=='')
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
			document.applForm.action="eRecruitment.jsp?action=save";
			document.applForm.submit();
		}
}


function yearDispFrom()
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
			document.write ("<OPTION  value=\"" +date+"\">" +date+ "");
			date--;			
		}
		while (date > future)
		document.write ("</SELECT>");
	}

	function yearDispTo()
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
			document.write ("<OPTION  value=\"" +date+"\">" +date+ "");
			date--;			
		}
		while (date > future)
		document.write ("</SELECT>");
	}					

function yearDispFromSchool()
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
			document.write ("<OPTION  value=\"" +date+"\">" +date+ "");
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
		if(document.applForm.post1.value =='DA41')
		  {
		  alert("Permohonan bagi jawatan TUTOR hanya layak bagi pemohon\nyang mempunyai CGPA@PNGK 3.00 ke atas sahaja.\n\nTerima Kasih");
		  document.applForm.action = "eRecruitment.jsp?action=borangpermohonan";
     	  document.applForm.submit();
		  }
		  else
		  {
			document.applForm.action = "eRecruitment.jsp?action=borangpermohonan";
			document.applForm.submit();
		  }
}
function go2()
{
		 if(document.applForm.post2.value=='DA41')
		 {
			  alert("Permohonan bagi jawatan TUTOR hanya layak bagi pemohon\nyang mempunyai CGPA@PNGK 3.00 ke atas sahaja.\n\nTerima Kasih");
			  document.applForm.action = "eRecruitment.jsp?action=borangpermohonan";
			  document.applForm.submit();
		 }
		  else
		  {
				document.applForm.action = "eRecruitment.jsp?action=borangpermohonan";
				document.applForm.submit();
		   }
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
 
function toggle_sub(id, opt)
{
	var Element = document.getElementById(id);
	if(opt == 'open')
		Element.style.display = "";
	else if(opt == 'close')
		Element.style.display = "none";
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
                        <td height="40" colspan="5"><img src="cms/eRecruitment/images/penting.gif" width="45" height="14"> 
                          Calon dikehendaki memilih jawatan yang hendak dipohon 
                          berdasarkan kategori dan mengikut kelayakan masing-masing. 
                          Setiap calon dibenarkan membuat 2 pilihan jawatan sahaja. 
                          <br> <br> <font color="#FF0000">Sila pastikan anda tidak 
                          mengaktifkan &quot;Pop-up Blocker&quot;.</font><br></td>
                      </tr>
                      <tr bgcolor="#CCCCCC"> 
                        <td colspan="2" bgcolor="#999999"> <div align="center"><strong>Pilihan 
                            Jawatan Pertama</strong></div></td>
                        <td width="84%" colspan="3"><b><font face="Geneva, Arial, Helvetica, san-serif"> 
                          &nbsp; 
                          <select name="pilihan1" id="pilihan1" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" onChange = 'document.applForm.action="eRecruitment.jsp?action=borangpermohonan";document.applForm.submit();'>
                            <option value="">Pilihan Jawatan Pertama</option>
                            <% if (request.getParameter("pilihan1") != null && request.getParameter("pilihan1").equals("ACADEMIC")) {%>
                            <option value="ACADEMIC" selected>Jawatan Akademik</option>
                            <% } else {%>
                            <option value="ACADEMIC">Jawatan Akademik</option>
                            <%} %>
                            <%  if (request.getParameter("pilihan1") != null && request.getParameter("pilihan1").equals("NON ACADEMIC")) {%>
                            <option value="NON ACADEMIC" selected>Jawatan Bukan 
                            Akademik</option>
                            <% } else {%>
                            <option value="NON ACADEMIC">Jawatan Bukan Akademik</option>
                            <%} %>
                          </select>
                          </font></b></td>
                      </tr>
                      <tr bgcolor="#EAF4FF"> 
                        <td colspan="5"> 
                          <%@include file="post1.jsp" %>
                        </td>
                      </tr>
                      <tr bgcolor="#CCCCCC"> 
                        <td colspan="2" bgcolor="#999999"> <div align="center"><strong>Pilihan 
                            Jawatan Kedua</strong></div></td>
                        <td colspan="3"><b><font face="Geneva, Arial, Helvetica, san-serif">&nbsp; 
                          <select name="pilihan2" id="pilihan2" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" onChange = 'document.applForm.action="eRecruitment.jsp?action=borangpermohonan";document.applForm.submit();'>
                            <option value="">Pilihan Jawatan Kedua</option>
                            <% if (request.getParameter("pilihan2") != null && request.getParameter("pilihan2").equals("ACADEMIC")) {%>
                            <option value="ACADEMIC" selected>Jawatan Akademik</option>
                            <% } else {%>
                            <option value="ACADEMIC">Jawatan Akademik</option>
                            <%} %>
                            <%  if (request.getParameter("pilihan2") != null && request.getParameter("pilihan2").equals("NON ACADEMIC")) {%>
                            <option value="NON ACADEMIC" selected>Jawatan Bukan 
                            Akademik</option>
                            <% } else {%>
                            <option value="NON ACADEMIC">Jawatan Bukan Akademik</option>
                            <%} %>
                          </select>
                          </font></b></td>
                      </tr>
                      <tr bgcolor="#EAF4FF"> 
                        <td colspan="5"> 
                          <%@include file="post2.jsp" %>
                        </td>
                      </tr>
                    </table>
                    <br> </td>
                </tr>
                <tr> 
                  <td colspan="3" nowrap bgcolor="#666666" class=normaltext style='border-top:none'><strong><font color="#FFFFFF">Maklumat 
                    Peribadi </font></strong></td>
                </tr>
                <tr> 
                  <td nowrap class="normaltext"><strong>Nama Penuh<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td width="100%" class="normaltext"><input name="nama" type="text" id="nama" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" value="<%=nama%>" size="50" maxlength="100"></td>
                </tr>
                <tr> 
                  <td nowrap class="normaltext"><strong>Jantina<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td width="100%" class="normaltext"><select name="jantina" id="jantina" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                      <option value="">Sila Pilih</option>
                      <option value="L">Lelaki</option>
                      <option value="P">Perempuan</option>
                    </select> </td>
                </tr>
                <tr> 
                  <td nowrap class="normaltext"><strong>Tarikh Lahir<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td class="normaltext"><input name="tarikhlahir" type="text" id="nama2" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" size="12" readonly=""> 
                    <img src='cms/eRecruitment/images/calendar.jpg' title='Klik disini' alt='Klik disini' onClick="scwShow(scwID('tarikhlahir'),event);" /> 
                  </td>
                </tr>
                <tr> 
                  <td nowrap class="normaltext"><strong>Taraf Perkahwinan<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td class="normaltext"><select name="marital" id="marital" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                      <option value="">Sila Pilih</option>
                      <option value="SINGLE">Bujang</option>
                      <option value="MARRIED">Berkahwin</option>
                      <option value="DIVORCED">Janda/Duda</option>
                    </select></td>
                </tr>
                <tr> 
                  <td nowrap class="normaltext"><strong>Umur pada iklan ditutup<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td width="100%" class="normaltext"><input name="umur" type="text" id="nama3" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" size="10"> 
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
                  <td width="100%" class="normaltext"><input name="pasport" type="text" id="nama33" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" size="25"> 
                  </td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Alamat 
                    Tetap<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td width="100%" class="normaltext"><textarea name="addr_perm" cols="50" id="nama332" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;"></textarea></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Bandar<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td width="100%" class="normaltext" ><input name="addr_perm_city" type="text" id="nama333" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" size="30"> 
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
                      <OPTION VALUE='<%=statecode[c]%>'><%=statename[c]%> </OPTION>
                      <%}%>
                    </SELECT>
                    </span> </td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Poskod<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td width="100%" class="normaltext"><input name="postcode_perm" type="text" id="nama335" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" size="20"> 
                    <font size="1">contoh : 25505</font></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Alamat 
                    Surat Menyurat<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td width="100%" class="normaltext"><textarea name="addr_cur" cols="50" id="addr_cur" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;"></textarea> 
                  </td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Bandar<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td width="100%" class="normaltext"><input name="addr_cur_city" type="text" id="addr_cur_city" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" size="30"></td>
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
                      <OPTION VALUE='<%=statecode[c]%>'><%=statename[c]%> </OPTION>
                      <%}%>
                    </SELECT>
                    </span></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Negara<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td width="100%" class="normaltext"><SELECT name="addr_cur_country" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                      <OPTION selected>Sila Pilih</OPTION>
                      <% 
								for (int c=0;c<countrycode.length;c++)
								{
									if (countrycode[c].equals("MAL"))
									{
						%>
                      <OPTION VALUE='<%=countrycode[c]%>' SELECTED><%=countryname[c]%></OPTION>
                      <%}else{%>
                      <OPTION VALUE='<%=countrycode[c]%>'><%=countryname[c]%></OPTION>
                      <%		
								}
					
							}
						}
						catch(Exception e)
						{
							System.out.println("Error list contry:"+e);
						}
					%>
                    </SELECT> </td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Poskod<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td class="normaltext"><input name="postcode_cur" type="text" id="nama336" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" size="20"> 
                    <font size="1">contoh : 25505 </font></td>
                </tr>
                <tr> 
                  <td valign="top" nowrap class=normaltext style='border-top:none'><strong>Telefon<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td width="100%" class="normaltext"> <table width="100%" border="0" cellpadding="2" cellspacing="1" class='style2'>
                      <tr> 
                        <td width="13%"><strong>Pejabat/Rumah </strong></td>
                        <td width="87%"><input name="phone" type="text" id="phone" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" size="15"> 
                          <font size="1"> contoh : 095492190</font></td>
                      </tr>
                      <tr> 
                        <td><strong>Bimbit </strong></td>
                        <td><input name="hphone" type="text" id="hphone2" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" size="15"> 
                          <font size="1"> contoh : 0133333335</font></td>
                      </tr>
                    </table></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Email<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td class="normaltext"><input name="email" type="text" id="email" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" size="40" maxlength="100"> 
                    <font size="1">contoh : norhazarina@ump.edu.my</font></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Pemegang 
                    Biasiswa JPA<font color="#FF0000">*</font></strong></td>
                  <td>&nbsp;</td>
                  <td class="normaltext"><span style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10px;"> 
                    <select name="jpa" class="normaltext" id="select4" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                      <option value="">Sila Pilih</option>
                      <option value="Ya">Ya</option>
                      <option value="Tidak">Tidak</option>
                    </select>
                    </span></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Lesen 
                    Kenderaan </strong></td>
                  <td>&nbsp;</td>
                  <td width="100%" class="normaltext"><table width="100%" border="0" class='style2'>
                      <tr> 
                        <td width="10%" valign="middle"> <input name="A" type="checkbox" id="A" value="A">
                          A</td>
                        <td width="10%" valign="middle"> <input name="B" type="checkbox" id="B" value="B">
                          B</td>
                        <td width="10%" valign="middle"> <input name="B1" type="checkbox" id="B1" value="B1">
                          B1</td>
                        <td width="10%" valign="middle"> <input name="B2" type="checkbox" id="B2" value="B2">
                          B2</td>
                        <td width="10%" valign="middle"> <input name="C" type="checkbox" id="C" value="C">
                          C</td>
                        <td width="10%" valign="middle"> <input name="D" type="checkbox" id="D" value="D">
                          D</td>
                        <td width="10%" valign="middle"> <input name="E" type="checkbox" id="E" value="E">
                          E</td>
                        <td colspan="6">&nbsp; </td>
                      </tr>
                      <tr> 
                        <td valign="middle"> <input name="E1" type="checkbox" id="E1" value="E1">
                          E1</td>
                        <td valign="middle"> <input name="E2" type="checkbox" id="E2" value="E2">
                          E2</td>
                        <td valign="middle"> <input name="F" type="checkbox" id="F" value="F">
                          F</td>
                        <td valign="middle"> <input name="G" type="checkbox" id="G" value="G">
                          G</td>
                        <td valign="middle"> <input name="H" type="checkbox" id="H" value="H">
                          H</td>
                        <td valign="middle"> <input name="I" type="checkbox" id="I" value="I">
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
                  <td nowrap class=normaltext style='border-top:none'><input name="school_name" type="text" id="school_name" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" size="50" maxlength="100"></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Tahun 
                    Tamat Persekolahan<font color="#FF0000">*</font></strong></td>
                  <td nowrap class=normaltext style='border-top:none'>&nbsp;</td>
                  <td nowrap class=normaltext style='border-top:none'><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                    <script>yearDispFromSchool();</script>
                    </font></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Nama 
                    Sijil (UPSR/PMR/SPM)<font color="#FF0000">*</font></strong></td>
                  <td nowrap class=normaltext style='border-top:none'>&nbsp;</td>
                  <td nowrap class=normaltext style='border-top:none'><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                    <select name="school_qual" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                      <option selected >Sila Pilih</option>
                      <option value="16">UPSR</option>
                      <option value="15">PMR </option>
                      <option value="06">SRP</option>
                      <option value="05">SPM </option>
                    </select>
                    </font></font></td>
                </tr>
                <tr> 
                  <td valign="top" nowrap class=normaltext style='border-top:none'><strong>Pencapaian<font color="#FF0000">*</font></strong></td>
                  <td nowrap class=normaltext style='border-top:none'>&nbsp;</td>
                  <td nowrap class=normaltext style='border-top:none'><table width="100%" border="0" cellspacing="1" class='style2'>
                      <tr> 
                        <td width="23%">Bahasa Melayu</td>
                        <td width="77%"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                          <select name="school_bm" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" >
                            <!--<option selected >...</option>-->
                            <option value="A1">A1</option>
                            <option value="A2">A2 </option>
                            <option value="B3">B3</option>
                            <option value="B4">B4 </option>
                            <option value="C5">C5</option>
                            <option value="C6">C6 </option>
                            <option value="P7">P7</option>
                            <option value="P8">P8 </option>
                            <option value="F9">F9 </option>
                          </select>
                          </font></td>
                      </tr>
                      <tr> 
                        <td>Bahasa Inggeris</td>
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                          <select name="school_bi" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                            <!--<option selected >...</option>-->
                            <option value="A1">A1</option>
                            <option value="A2">A2 </option>
                            <option value="B3">B3</option>
                            <option value="B4">B4 </option>
                            <option value="C5">C5</option>
                            <option value="C6">C6 </option>
                            <option value="P7">P7</option>
                            <option value="P8">P8 </option>
                            <option value="F9">F9 </option>
                          </select>
                          </font></td>
                      </tr>
                      <tr> 
                        <td>Matematik</td>
                        <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                          <select name="school_mate" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                            <!--<option selected >...</option>-->
                            <option value="A1">A1</option>
                            <option value="A2">A2 </option>
                            <option value="B3">B3</option>
                            <option value="B4">B4 </option>
                           <option value="C5">C5</option>
                            <option value="C6">C6 </option>
                            <option value="P7">P7</option>
                            <option value="P8">P8 </option>
                            <option value="F9">F9 </option>
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
                    <input type="text" name="insti_name"  value="" size="40" maxlength="100" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                    </font></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Tahun 
                    Mula</strong></td>
                  <td>&nbsp;</td>
                  <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                    <script>yearDispFrom();</script>
                    </font></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Tahun 
                    Akhir</strong></td>
                  <td>&nbsp;</td>
                  <td class=normaltext><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                    <script>yearDispTo(); </script>
                    </font></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Sijil/Diploma/Ijazah</strong></td>
                  <td>&nbsp;</td>
                  <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                    <input type="text" name="insti_qual"  value="" size="40" maxlength="100" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                    </font></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Kelas 
                    Kepujian (CGPA@CPA)</strong></td>
                  <td>&nbsp;</td>
                  <td> <input name="insti_class" type="text" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" size="10" maxlength="10"> 
                    <font size="1">contoh : 3.76</font></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Bidang 
                    Pengkhususan</strong></td>
                  <td>&nbsp;</td>
                  <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                    <input type="text" name="clasify"  value="" size="20" maxlength="100" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                    </font></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>CGPA@CPA 
                    diperingkat<br>
                    Ijazah Sarjana Muda</strong></td>
                  <td>&nbsp;</td>
                  <td class=normaltext> <input name="insti_cgpa_degree" type="text" id="insti_cgpa_degree" size="10" maxlength="10" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;"> 
                    <font size="1">contoh : 3.76 </font></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Kelas</strong></td>
                  <td>&nbsp;</td>
                  <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                    <select name="insti_class_degree" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                      <option value="">Sila Pilih</option>
                      <option value="KELAS1">Kelas Pertama</option>
                      <option value="KELAS2ATAS">Kelas II Atas</option>
                      <option value="KELAS2BAWAH">Kelas II Bawah</option>
                      <option value="KELAS3">Kelas III</option>
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
                  <td class="normaltext"><textarea name="extra" cols="50" id="extra" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" onKeyPress="return taLimit()" onKeyUp="return taCount(myCounter)" maxlength="1000"></textarea> 
                  </td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Kegiatan 
                    Sukan Semasa Di<br>
                    (Sekolah/Universiti)</strong></td>
                  <td>&nbsp;</td>
                  <td class="normaltext"> <textarea name="sport" cols="50" id="sport" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" onKeyPress="return taLimit()" onKeyUp="return taCount(myCounter)" maxlength="1000"></textarea></td>
                </tr>
                <tr> 
                  <td colspan="3" nowrap bgcolor="#666666" class=normaltext style='border-top:none'><strong><font color="#FFFFFF">Maklumat 
                    Pengalaman Terkini</font></strong></td>
                </tr>
                <tr> 
                  <td nowrap class=normaltext style='border-top:none'><strong>Pengalaman 
                    Terkini? </strong></td>
                  <td>&nbsp;</td>
                  <td> <p> 
                      <input type="radio" name="pengalaman" onclick="toggle_sub('no_pengalaman', 'open')" />
                      Ada<br>
                      <input type="radio" name="pengalaman" checked="no" onclick="toggle_sub('no_pengalaman', 'close')" />
                      Tiada</p></td>
                </tr>
                <tr> 
                  <td colspan="3" nowrap class=normaltext style='border-top:none'> 
                    <div id="no_pengalaman" style="display: none;"> 
                      <table width="100%" border="0" cellpadding="0" cellspacing="0">
                        <tr bgcolor="#FFFFFF" class="style2"> 
                          <td width="34%" height="30" nowrap class=normaltext style='border-top:none'> 
                            <strong>Nama Majikan</strong></td>
                          <td width="1%" height="30">&nbsp;</td>
                          <td width="65%" height="30"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                            <input type="text" name="employer_name"  value="" size="20" maxlength="50"style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                            </font></td>
                        </tr>
                        <tr bgcolor="#FFFFFF" class="style2"> 
                          <td height="20" nowrap class=normaltext style='border-top:none'><strong>Alamat 
                            Majikan</strong></td>
                          <td height="20">&nbsp;</td>
                          <td height="20" class="normaltext"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                            <textarea name="employer_address" value='' style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" cols="50"></textarea>
                            </font></td>
                        </tr>
                        <tr bgcolor="#FFFFFF" class="style2"> 
                          <td height="30" nowrap class=normaltext style='border-top:none'><strong>Tarikh 
                            Mula</strong></td>
                          <td height="30">&nbsp;</td>
                          <td height="30"> <input type="text" name="t_mula"  value="" size="12" maxlength="14" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" readonly>
                            <img src='cms/eRecruitment/images/calendar.jpg' title='Klik disini' alt='Klik disini' onClick="scwShow(scwID('t_mula'),event);" /><font size="1">&nbsp; 
                            </font></td>
                        </tr>
                        <tr bgcolor="#FFFFFF" class="style2"> 
                          <td height="30" nowrap class=normaltext style='border-top:none'><strong>Jawatan</strong></td>
                          <td height="30">&nbsp;</td>
                          <td height="30"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                            <input type="text" name="post"  value="" size="20" maxlength="100" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
                            </font></td>
                        </tr>
                        <tr bgcolor="#FFFFFF" class="style2"> 
                          <td height="30" nowrap class=normaltext style='border-top:none'><strong>Gaji 
                            pokok sebulan </strong></td>
                          <td height="30">&nbsp;</td>
                          <td height="30"> <input type="text" name="salary"  value="" size="20" maxlength="255" onKeyPress="return isNumberKey(event)" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;"> 
                            <font size="1">contoh : 1200</font></td>
                        </tr>
                        <tr bgcolor="#FFFFFF" class="style2"> 
                          <td height="30" nowrap class=normaltext style='border-top:none'><strong>Jumlah 
                            Tahun Bekerja <br>
                            Termasuk Pengalaman Terkini</strong></td>
                          <td height="30">&nbsp;</td>
                          <td height="30"> <input type="text" name="jum_tahun"  value="0" size="10" onKeyPress="return isNumberKey(event)" maxlength="15" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;"> 
                            <font size="1">contoh : 12</font></td>
                        </tr>
                      </table>
                    </div></td>
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
                      <option value="Y">Ya 
                      <option value="N">Tidak </option>
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
                                <input name="nama_penjamin1" type="text" id="nama_penjamin1"style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;"  value="" size="20" maxlength="50">
                                </font></td>
                            </tr>
                            <tr bgcolor="#FFFFFF"> 
                              <td nowrap class=normaltext style='border-top:none'><strong>Alamat<font color="#FF0000">*</font></strong></td>
                              <td class="normaltext"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                                <textarea name="alamat_penjamin1" cols="25" id="alamat_penjamin1" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" value=''></textarea>
                                </font></td>
                            </tr>
                            <tr bgcolor="#FFFFFF"> 
                              <td nowrap class=normaltext style='border-top:none'><strong>Pekerjaan<font color="#FF0000">*</font> 
                                </strong></td>
                              <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                                <input name="pekerjaan_penjamin1" type="text" id="pekerjaan_penjamin1" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;"  value="" size="25" maxlength="100">
                                </font> </td>
                            </tr>
                            <tr bgcolor="#FFFFFF"> 
                              <td nowrap class=normaltext style='border-top:none'><strong>Telefon<font color="#FF0000">*</font></strong></td>
                              <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                                <input name="tel_penjamin1" type="text" id="tel_penjamin1" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;"  value="" size="20" maxlength="100">
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
                                <input name="nama_penjamin2" type="text" id="nama_penjamin2"style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;"  value="" size="20" maxlength="50">
                                </font></td>
                            </tr>
                            <tr> 
                              <td nowrap class=normaltext style='border-top:none'><strong>Alamat<font color="#FF0000">*</font></strong></td>
                              <td class="normaltext"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                                <textarea name="alamat_penjamin2" cols="25" id="alamat_penjamin2" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;" value=''></textarea>
                                </font></td>
                            </tr>
                            <tr> 
                              <td nowrap class=normaltext style='border-top:none'><strong>Pekerjaan<font color="#FF0000">*</font> 
                                </strong></td>
                              <td> <font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                                <input name="pekerjaan_penjamin2" type="text" id="pekerjaan_penjamin2" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;"  value="" size="25" maxlength="100">
                                </font> </td>
                            </tr>
                            <tr> 
                              <td nowrap class=normaltext style='border-top:none'><strong>Telefon<font color="#FF0000">*</font></strong></td>
                              <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
                                <input name="tel_penjamin2" type="text" id="tel_penjamin2" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;"  value="" size="20" maxlength="100">
                                </font></td>
                            </tr>
                          </table></td>
                      </tr>
                    </table></td>
                </tr>
                <tr align="right" valign="middle"> 
                  <td colspan="3" nowrap bgcolor="#CCCCCC" class=normaltext style='border-top:none'>Sila 
                    pastikan segala maklumat yg diisi adalah tepat dan lengkap. 
                    <A HREF="javascript:validateForm();" onMouseOver="window.status='Hantar';return true;"><IMG SRC="cms/eRecruitment/images/ic_hantar.gif" BORDER="0" ALT="Hantar"></A> 
                    &nbsp;</td>
                </tr>
              </table></td>
          </tr>
        </table></td>
    </tr>
  </table>
</form>
			</body>
<%} else {%><table width="90%" class="style2" align="center"><tr><td><div align="center">Anda 
        telah membuat permohonan sebelum ini. Sila kemaskini maklumat anda. Terima 
        Kasih</div></td></tr></table>
<%}%>
</html>
<% if (conn != null) conn.close();%>