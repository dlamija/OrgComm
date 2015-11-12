<%@ page session="true" %>
<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="javax.naming.*" %>
<jsp:useBean id="currency" scope="request" class="ims.DisplayBean" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
.style9 {font-size: small}
.style14 {
	font-size: small;
	color: #FFFFFF;
	font-weight: bold;
}
.style15 {
	color: #FFFFFF;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
}
.style17 {
	font-size: 12px;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-weight: bold;
}
.style20 {font-size: 14px; font-family: Verdana, Arial, Helvetica, sans-serif; font-weight: bold; }
.style22 {font-size: 12px; color: #FFFFFF; font-weight: bold; font-family: Verdana, Arial, Helvetica, sans-serif; }
.style23 {font-family: Verdana, Arial, Helvetica, sans-serif}
.style24 {font-size: 12px}
.style27 {font-size: 12px; font-family: Geneva, Arial, Helvetica, sans-serif; font-weight: bold; }
.style28 {
	font-family: Geneva, Arial, Helvetica, sans-serif;
	font-size: 12px;
}
.style29 {
	font-size: 12px;
	font-family: Verdana, Arial, Helvetica, sans-serif;
}
.style30 {font-family: Geneva, Arial, Helvetica, sans-serif; font-size: 12; }
-->
</style>
</head>


<%
Connection conn = null;
	String staff = request.getParameter("staff");
	String sid= (String)session.getAttribute("staffid");
	String staffid = request.getParameter("staffid");
	String year_sah = request.getParameter("year_sah");
	String assessment_grouping=request.getParameter("assessment_grouping");
	String evaluator1 ="";
	String evaluator2 ="";
	String cetak = "";
	String kriteria3 = "";
	String kriteria4 = "";
	String kriteria5 = "";
	String kriteria6 = "";
	String staff_id = "";
	String staff_name = "";
	String ic_no = "";
	String job_code = "";
	String job_desc = "";
	String dept_code = "";
	String dept_desc = "";

	double mark1 = 0;
	double mark2 = 0;
	double mark3 = 0;
	double mark4 = 0;
	double mark5 = 0;
	double mark6 = 0;
	double mark7 = 0;
	double mark8 = 0;
	double mark9 = 0;
	double mark10 = 0;
	double mark11 = 0;
	double mark12 = 0;
	double mark13 = 0;
	double mark14 = 0;
	double mark15 = 0;
	double mark16 = 0;
	double mark17 = 0;
	double mark18 = 0;
	double mark19 = 0;
	double mark20 = 0;
	double mark21 = 0;
	double mark22 = 0;
	double mark23 = 0;
	double mark24 = 0;
	double mark_3 = 0;
	double mark_4 = 0;
	double mark_5 = 0;
	double mark_6 = 0;
	double ppp_mark = 0;
	double ppk_mark = 0;
	double final_mark = 0;

try
	{
    	Context initCtx = new InitialContext();
    	Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
    	DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
	conn = ds.getConnection();
	}
catch( Exception e )
	{ out.println (e.toString()); }
%>

 <%
if (conn!=null)
	{
	String sqlq	= " SELECT SM_STAFF_ID, SM_STAFF_NAME, SM_IC_NO, SM_JOB_CODE, UPPER(SS_SERVICE_DESC), SM_DEPT_CODE, UPPER(DM_DEPT_DESC) "+
				" FROM STAFF_MAIN, SERVICE_SCHEME, DEPARTMENT_MAIN "+
				" WHERE SM_JOB_CODE=SS_SERVICE_CODE "+
				"AND SM_DEPT_CODE=DM_DEPT_CODE "+
				" AND SM_STAFF_ID='"+staff+"' ";
				
	
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sqlq);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			staff_id = rset.getString (1);
			staff_name = rset.getString (2);
			ic_no = rset.getString (3);
			job_code = rset.getString (4);
			job_desc = rset.getString (5);
			dept_code = rset.getString (6);
			dept_desc = rset.getString (7);
			}
		pstmt.close ();
		rset.close ();
		}


	catch (SQLException e)
		{ out.println ("Error : " + e.toString () + "/n" + sqlq); }
	}	
%>

 <%
if (conn!=null)
	{
	String sqlq	= " SELECT sm_staff_name, SAH_EVALUATOR1_MARK, SAH_EVALUATOR2_MARK, SAH_FINAL_MARK "+
				" FROM STAFF_ASSESSMENT_HEAD, staff_main "+
				" WHERE SAH_EVALUATOR1= sm_staff_id "+
				" AND SAH_STAFF_ID='"+staff+"' and sah_year='"+year_sah+"' ";
				
	%><%=sqlq%><%
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sqlq);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			evaluator1 = rset.getString (1);
			ppp_mark = rset.getDouble (2);
			ppk_mark = rset.getDouble (3);
			final_mark = rset.getDouble (4);
			}
		pstmt.close ();
		rset.close ();
		}


	catch (SQLException e)
		{ out.println ("Error : " + e.toString () + "/n" + sqlq); }
	}	
%>


 <%
if (conn!=null)
	{
	String sqlq	= " SELECT sm_staff_name "+
				" FROM STAFF_ASSESSMENT_HEAD, staff_main "+
				" WHERE SAH_EVALUATOR2 = sm_staff_id "+
				" AND SAH_STAFF_ID='"+staff+"' and sah_year='"+year_sah+"' ";
	
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sqlq);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			evaluator2 = rset.getString (1);
			}
		pstmt.close ();
		rset.close ();
		}


	catch (SQLException e)
		{ out.println ("Error : " + e.toString () + "/n" + sqlq); }
	}	
%> 

<%
if (conn!=null)
	{
	String sqlq	= " SELECT SS_ASSESSMENT_CATEGORY "+
				" FROM service_scheme, staff_main "+
				" WHERE SS_SERVICE_CODE=sm_job_code "+
				" AND SM_STAFF_ID='"+staff+"' ";
	
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sqlq);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			assessment_grouping = rset.getString (1);
			}
		pstmt.close ();
		rset.close ();
		}


	catch (SQLException e)
		{ out.println ("Error : " + e.toString () + "/n" + sqlq); }
	}	
%>

<%
if (conn!=null)
	{
	String sqlq	= " SELECT AGH_MAX_MARK, AGH_CRITERIA "+
				" FROM ASSESSMENT_GRADING_HEAD "+
				" WHERE AGH_CATEGORY='3' "+
				" AND AGH_CLASSIFICATION='"+assessment_grouping+"' ";
	
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sqlq);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			mark_3 = rset.getDouble (1);
			kriteria3 = rset.getString (2);
			}
		pstmt.close ();
		rset.close ();
		}


	catch (SQLException e)
		{ out.println ("Error : " + e.toString () + "/n" + sqlq); }
	}	
%>

<%
if (conn!=null)
	{
	String sqlq	= " SELECT AGH_MAX_MARK, AGH_CRITERIA "+
				" FROM ASSESSMENT_GRADING_HEAD "+
				" WHERE AGH_CATEGORY='4' "+
				" AND AGH_CLASSIFICATION='"+assessment_grouping+"' ";
	
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sqlq);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			mark_4 = rset.getDouble (1);
			kriteria4 = rset.getString (2);
			}
		pstmt.close ();
		rset.close ();
		}


	catch (SQLException e)
		{ out.println ("Error : " + e.toString () + "/n" + sqlq); }
	}	
%>

<%
if (conn!=null)
	{
	String sqlq	= " SELECT AGH_MAX_MARK, AGH_CRITERIA "+
				" FROM ASSESSMENT_GRADING_HEAD "+
				" WHERE AGH_CATEGORY='5' "+
				" AND AGH_CLASSIFICATION='"+assessment_grouping+"' ";
	
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sqlq);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			mark_5 = rset.getDouble (1);
			kriteria5 = rset.getString (2);
			}
		pstmt.close ();
		rset.close ();
		}


	catch (SQLException e)
		{ out.println ("Error : " + e.toString () + "/n" + sqlq); }
	}	
%>

<%
if (conn!=null)
	{
	String sqlq	= " SELECT AGH_MAX_MARK, AGH_CRITERIA "+
				" FROM ASSESSMENT_GRADING_HEAD "+
				" WHERE AGH_CATEGORY='6' "+
				" AND AGH_CLASSIFICATION='"+assessment_grouping+"' ";
	
	try
		{
		PreparedStatement pstmt = conn.prepareStatement(sqlq);
		ResultSet rset = pstmt.executeQuery ();
		if (rset.next())
			{
			mark_6 = rset.getDouble (1);
			kriteria6 = rset.getString (2);
			}
		pstmt.close ();
		rset.close ();
		}


	catch (SQLException e)
		{ out.println ("Error : " + e.toString () + "/n" + sqlq); }
	}	
%>

<body>
<table width="100%" BORDER="0" align="center" CELLPADDING="3" CELLSPACING="1">
<tr bordercolor="#000000" align="center"> 
    <td colspan="7"><span class="style20">PENILAIAN PRESTASI TAHUN - <%=year_sah%></span></td>
  </tr>
</table>
<br>

<table width="100%" BORDER="0" align="center" CELLPADDING="3" CELLSPACING="1">
<tr bordercolor="#000000" align="left"> 
    <td colspan="7"><span class="style17">BAHAGIAN I - MAKLUMAT PEGAWAI </span></td>
  </tr>
</table>

<table width="100%" align="center" BORDER="0" CELLSPACING="1" CELLPADDING="3" bgcolor="#CCCCCC">
<tr bordercolor="#000000" bgcolor="#0033FF" align="left"> 
       <td colspan="7"><span class="style22">MAKLUMAT PEGAWAI</span></td>
  </tr>
<tr bordercolor="#000000" bgcolor="#FFFFFF"> 
       <td width="20%" align="left" CLASS="contentBgColor style23 style24">Nama </td>
       <td width="80%" class='contentBgColor style23 style24'>: <%=staff_name%></td>
  </tr>
  <tr bordercolor="#000000" bgcolor="#FFFFFF">
	   <td width="20%" align="left" CLASS="contentBgColor style23 style24">No Kad Pengenalan </td>
    <td width="80%" class='contentBgColor style23 style24'>
		: <%=ic_no%>
	</td>
  </tr>
  <tr bordercolor="#000000" bgcolor="#FFFFFF">
	   <td width="20%" align="left" CLASS="contentBgColor style23 style24">Gred & Jawatan </td>
    <td width="80%" class='contentBgColor style23 style24'>
		: <%=job_code%> - <%=job_desc%>
	</td>
  </tr>
  <tr bordercolor="#000000" bgcolor="#FFFFFF">
	   <td width="20%" align="left" CLASS="contentBgColor style23 style24">Jabatan/ Fakulti </td>
    <td width="80%" class='contentBgColor style23 style24'>
		: <%=dept_desc%>
	</td>
  </tr>
</table>
<br>
<table width="100%" align="center" BORDER="0" CELLSPACING="1" CELLPADDING="3" bgcolor="#CCCCCC">
<tr bordercolor="#000000" bgcolor="#0033FF" align="left"> 
    <td colspan="7"><span class="style22">MAKLUMAT PEGAWAI PENILAI </span></td>
  </tr>
<tr bordercolor="#000000" bgcolor="#FFFFFF"> 
       <td width="20%" align="left" CLASS="contentBgColor style23 style24">Peg. Penilai Pertama</td>
    <td width="80%" class='contentBgColor style23 style24'>: <%=evaluator1%></td>
  </tr><tr bordercolor="#000000" bgcolor="#FFFFFF">
	   <td width="20%" align="left" CLASS="contentBgColor style23 style24">Peg. Penilai Kedua</td>
    <td width="80%" class='contentBgColor style23 style24'>
	
	<%
	if (evaluator2.equals(""))
	cetak = "TIADA";
	else
	cetak = evaluator2;
	%>
	
	: <%=cetak%>
	
	</td>
    </tr>
</table>

<BR><BR>
<table width="100%" BORDER="0" align="center" CELLPADDING="3" CELLSPACING="1">
<tr bordercolor="#000000" align="left"> 
    <td colspan="7"><span class="style27">BAHAGIAN II - KEGIATAN & SUMBANGAN DILUAR TUGAS RASMI/ LATIHAN </span></td>
  </tr>
<tr bordercolor="#000000" align="left"> 
    <td colspan="7"><span class="style27">1. KEGIATAN & SUMBANGAN DILUAR TUGAS RASMI </span></td>
  </tr>
</table>



<%
if ( conn!=null )
	{
	
	String sql=" SELECT SAA_ACTIVITY, SAA_LEVEL FROM STAFF_ASSESSMENT_ACTIVITY "+
				" WHERE SAA_STAFF_ID='"+staff+"' AND SAA_YEAR='"+year_sah+"' ";
	try
		{
		PreparedStatement pstmt=conn.prepareStatement(sql);
		ResultSet rset=pstmt.executeQuery();
		//if(rset.isBeforeFirst()){
		%>
		

	<TABLE WIDTH="100%" BORDER="1" CELLSPACING="0" CELLPADDING="3" bgcolor="#CCCCCC">
		<tr valign="top" bordercolor="#333333" bgcolor="#0033FF" class="smallbold" CELLSPACING="1">
		  <td width="70%" class="contentStrapColor"><div align="center" class="style9 style15"><b>Senarai Kegiatan/ Aktiviti/ Sumbangan </b></div></td>
		  <td width="30%" class="contentStrapColor"><div align="center" class="style14 style28 style29">Peringkat</div></td>
	  </tr>
		
    <%
		if(rset.isBeforeFirst())
		{
		
		 while(rset.next()){
		  %>

		<tr valign="top" bordercolor="#333333" bgcolor="#FFFFFF" class="smallfont">
		  <td class="contentBgColor"><div class="style30"><%=rset.getString(1)%></div></td>
		  <td class="contentBgColor"><div align="left" class="style30"><%=rset.getString(2)%></div></td>
	  </tr>
		<%}%>
	
<%}
			rset.close();
			pstmt.close();
			}
		catch( Exception e )
			{ out.println(e.toString());}
		}
%>			</table>


<br>
<table width="100%" BORDER="0" align="center" CELLPADDING="3" CELLSPACING="1">
<tr bordercolor="#000000" align="left"> 
    <td colspan="7"><span class="style17">2. LATIHAN </span></td>
  </tr>
</table>

<%
if ( conn!=null )
	{
	
	String sql=" SELECT SAT_TRAINING_NAME, SAT_DATE_INTERVAL, SAT_VENUE FROM STAFF_ASSESSMENT_TRAINING "+
				" WHERE SAT_STAFF_ID='"+staff+"' AND SAT_YEAR='"+year_sah+"' ";
	try
		{
		PreparedStatement pstmt=conn.prepareStatement(sql);
		ResultSet rset=pstmt.executeQuery();
		//if(rset.isBeforeFirst()){
		%>
		

	<TABLE WIDTH="100%" BORDER="1" CELLSPACING="0" CELLPADDING="3" bgcolor="#CCCCCC">
		<tr valign="top" bordercolor="#333333" bgcolor="#0033FF" class="smallbold" CELLSPACING="1">
		  <td width="55%" class="contentStrapColor"><div align="center" class="style22">Nama </div></td>
		  <td width="15%" class="contentStrapColor"><div align="center" class="style22">Tarikh/ Tempoh</div></td>
		  <td width="30%" class="contentStrapColor"><div align="center" class="style22">Tempat</div></td>
	  </tr>
		
    <%
		if(rset.isBeforeFirst())
		{
		
		 while(rset.next()){
		  %>

		<tr valign="top" bordercolor="#333333" bgcolor="#FFFFFF" class="smallfont">
		  <td class="contentBgColor"><div class="style29"><%=rset.getString(1)%></div></td>
		  <td class="contentBgColor"><div align="left" class="style29"><%=rset.getString(2)%></div></td>
		  <td class="contentBgColor"><div align="left" class="style29"><%=rset.getString(3)%></div></td>
	  </tr>
		<%}%>
	
<%}
			rset.close();
			pstmt.close();
			}
		catch( Exception e )
			{ out.println(e.toString());}
		}
%>			</table>

<BR>

<%
if ( conn!=null )
	{
	
	String sql=" SELECT SAT2_TRAINING, SAT2_REASON FROM STAFF_ASSESSMENT_TNA "+
				" WHERE SAT2_STAFF_ID='"+staff+"' AND SAT2_YEAR='"+year_sah+"' ";
	try
		{
		PreparedStatement pstmt=conn.prepareStatement(sql);
		ResultSet rset=pstmt.executeQuery();
		//if(rset.isBeforeFirst()){
		%>
		

	<TABLE WIDTH="100%" BORDER="1" CELLSPACING="0" CELLPADDING="3" bgcolor="#CCCCCC">
		<tr valign="top" bordercolor="#333333" bgcolor="#0033FF" class="smallbold" CELLSPACING="1">
		  <td width="60%" class="contentStrapColor"><div align="center" class="style22">Nama Bidang Latihan</div></td>
		  <td width="40%" class="contentStrapColor"><div align="center" class="style22">Sebab Diperlukan</div></td>
	  </tr>
		
    <%
		if(rset.isBeforeFirst())
		{
		
		 while(rset.next()){
		  %>

		<tr valign="top" bordercolor="#333333" bgcolor="#FFFFFF" class="smallfont">
		  <td class="contentBgColor"><div class="style29"><%=rset.getString(1)%></div></td>
		  <td class="contentBgColor"><div align="left" class="style29"><%=rset.getString(2)%></div></td>
	  </tr>
		<%}%>
	
<%}
			rset.close();
			pstmt.close();
			}
		catch( Exception e )
			{ out.println(e.toString());}
		}
%>			</table>

<BR><BR>
<table width="100%" BORDER="0" align="center" CELLPADDING="3" CELLSPACING="1">
<tr bordercolor="#000000" align="left"> 
    <td colspan="7"><span class="style17">BAHAGIAN III - <%=kriteria3%> WAJARAN - <%=mark_3%>% </span></td>
  </tr>
</table>

<%
if ( conn!=null )
	{
	
	String sql="SELECT SAM_REFID,NVL(SAM_EVALUATOR1_MARK,0),NVL(SAM_EVALUATOR2_MARK,0),AGH_CRITERIA,AGQ_MAX_MARK,AGH_MAX_MARK,AGQ_QUESTION "+
				" FROM STAFF_ASSESSMENT_MISC, ASSESSMENT_GRADING_QUESTION, ASSESSMENT_GRADING_HEAD "+
				"WHERE SAM_STAFF_ID='"+staff+"' AND TO_NUMBER(SAM_YEAR)='"+year_sah+"' and SAM_REFID=AGQ_REFID and AGH_CATEGORY = SAM_CATEGORY "+
				" and AGQ_CLASSIFICATION = AGH_CLASSIFICATION and SAM_CATEGORY=AGQ_CATEGORY AND SAM_CATEGORY='3' and AGH_CLASSIFICATION='"+assessment_grouping+"' ";
	try
		{
		PreparedStatement pstmt=conn.prepareStatement(sql);
		ResultSet rset=pstmt.executeQuery();
		//if(rset.isBeforeFirst()){
		%>
		

	<TABLE WIDTH="100%" BORDER="1" CELLSPACING="0" CELLPADDING="3" bgcolor="#CCCCCC">
		<tr valign="top" bordercolor="#333333" bgcolor="#0033FF" class="smallbold" CELLSPACING="1">
		  <td width="60%" class="contentStrapColor"><div align="center" class="style22">Kriteria (Dinilai Melalui SKT) </div></td>
		  <td width="20%" class="contentStrapColor"><div align="center" class="style22">Markah PPP</div></td>
		  <td width="20%" class="contentStrapColor"><div align="center" class="style22">Markah PPK</div></td>
	  </tr>
		
    <%
		if(rset.isBeforeFirst())
		{
		
		 while(rset.next()){
		mark1 += rset.getDouble( 2 );
		mark2 += rset.getDouble( 3 );
		mark3 += rset.getDouble( 5 );
		mark4 = rset.getDouble( 6 );
		mark5 = mark1 / mark3 * mark4;
		mark6 = mark2 / mark3 * mark4;
		  %>

		<tr valign="top" bordercolor="#333333" bgcolor="#FFFFFF" class="smallfont">
		  <td class="contentBgColor"><div class="style29"><%=rset.getString(7)%></div></td>
		  <td class="contentBgColor"><div align="center" class="style29"><%=rset.getString(2)%></div></td>
		  <td class="contentBgColor"><div align="center" class="style29"><%=rset.getString(3)%></div></td>
	  </tr>
		<%}%>
		<tr valign="top" bordercolor="#333333" bgcolor="#FFFFFF" class="smallfont">
		  <td class="contentBgColor"><div class="style29">Jumlah Markah Mengikut Wajaran</div></td>
			<td class="contentBgColor"><div align="left" class="style29"><strong>
			<%=currency.FormatCurrency(mark1)%> x <%=currency.FormatCurrency(mark4)%> = <%=currency.FormatCurrency(mark5)%>
        	<br>
    	---------------
    	<br>
    	<%=mark3%></strong></div></td>
			<td class="contentBgColor"><div align="left" class="style29"><strong>
			<%=mark2%> x <%=mark4%> = <%=currency.FormatCurrency(mark6)%>
        	<br>
    	--------------
    	<br>
    	<%=mark3%>			</strong></div></td>
	  </tr>
	
<%}
			rset.close();
			pstmt.close();
			}
		catch( Exception e )
			{ out.println(e.toString());}
		}
%>			</table>

<br><BR>
<table width="100%" BORDER="0" align="center" CELLPADDING="3" CELLSPACING="1">
<tr bordercolor="#000000" align="left"> 
    <td colspan="7"><span class="style29"><strong>BAHAGIAN IV - <%=kriteria4%> WAJARAN - <%=mark_4%>% </strong></span></td>
  </tr>
</table>

<%
if ( conn!=null )
	{
	
	String sql="SELECT SAM_REFID,NVL(SAM_EVALUATOR1_MARK,0),NVL(SAM_EVALUATOR2_MARK,0),AGH_CRITERIA,AGQ_MAX_MARK,AGH_MAX_MARK,AGQ_QUESTION "+
				" FROM STAFF_ASSESSMENT_MISC, ASSESSMENT_GRADING_QUESTION, ASSESSMENT_GRADING_HEAD "+
				"WHERE SAM_STAFF_ID='"+staff+"' AND TO_NUMBER(SAM_YEAR)='"+year_sah+"' and SAM_REFID=AGQ_REFID and AGH_CATEGORY = SAM_CATEGORY "+
				" and AGQ_CLASSIFICATION = AGH_CLASSIFICATION and SAM_CATEGORY=AGQ_CATEGORY AND SAM_CATEGORY='4' and AGH_CLASSIFICATION='"+assessment_grouping+"' ";
	try
		{
		PreparedStatement pstmt=conn.prepareStatement(sql);
		ResultSet rset=pstmt.executeQuery();
		//if(rset.isBeforeFirst()){
		%>
		

	<TABLE WIDTH="100%" BORDER="1" CELLSPACING="0" CELLPADDING="3" bgcolor="#CCCCCC">
		<tr valign="top" bordercolor="#666666" bgcolor="#0033FF" class="smallbold" CELLSPACING="1">
		  <td width="60%" class="contentStrapColor"><div align="center" class="style22">Kriteria (Dinilai Melalui SKT) </div></td>
		  <td width="20%" class="contentStrapColor"><div align="center" class="style22">Markah PPP</div></td>
		  <td width="20%" class="contentStrapColor"><div align="center" class="style22">Markah PPK</div></td>
	  </tr>
		
    <%
		if(rset.isBeforeFirst())
		{
		
		 while(rset.next()){
		mark7 += rset.getDouble( 2 );
		mark8 += rset.getDouble( 3 );
		mark9 += rset.getDouble( 5 );
		mark10 = rset.getDouble( 6 );
		mark11 = mark7 / mark9 * mark10;
		mark12 = mark8 / mark9 * mark10;
		  %>

		<tr valign="top" bordercolor="#666666" bgcolor="#FFFFFF" class="smallfont">
		  <td class="contentBgColor"><div class="style29"><%=rset.getString(7)%></div></td>
		  <td class="contentBgColor"><div align="center" class="style29"><%=rset.getString(2)%></div></td>
		  <td class="contentBgColor"><div align="center" class="style29"><%=rset.getString(3)%></div></td>
		</tr>
		<%}%>
		<tr valign="top" bordercolor="#666666" bgcolor="#FFFFFF" class="smallfont">
		  <td class="contentBgColor"><div class="style29">Jumlah Markah Mengikut Wajaran</div></td>
			<td class="contentBgColor"><div align="left" class="style29"><strong>
			<%=mark7%> x <%=mark10%> = <%=currency.FormatCurrency(mark11)%>
        	<br>
    	--------------
    	<br>
    	<%=mark10%></strong></div></td>
			<td class="contentBgColor"><div align="left" class="style29"><strong>
			<%=mark8%> x <%=mark10%> = <%=currency.FormatCurrency(mark12)%>
        	<br>
    	-------------
    	<br>
    	<%=mark10%>			</strong></div></td>
		</tr>
	
<%}
			rset.close();
			pstmt.close();
			}
		catch( Exception e )
			{ out.println(e.toString());}
		}
%>			</table>

<br><BR>
<table width="100%" BORDER="0" align="center" CELLPADDING="3" CELLSPACING="1">
<tr bordercolor="#000000" align="left"> 
    <td colspan="7"><span class="style17">BAHAGIAN V - <%=kriteria5%> WAJARAN - <%=mark_5%>% </span></td>
  </tr>
</table>

<%
if ( conn!=null )
	{
	
	String sql="SELECT SAM_REFID,NVL(SAM_EVALUATOR1_MARK,0),NVL(SAM_EVALUATOR2_MARK,0),AGH_CRITERIA,AGQ_MAX_MARK,AGH_MAX_MARK,AGQ_QUESTION "+
				" FROM STAFF_ASSESSMENT_MISC, ASSESSMENT_GRADING_QUESTION, ASSESSMENT_GRADING_HEAD "+
				"WHERE SAM_STAFF_ID='"+staff+"' AND TO_NUMBER(SAM_YEAR)='"+year_sah+"' and SAM_REFID=AGQ_REFID and AGH_CATEGORY = SAM_CATEGORY "+
				" and AGQ_CLASSIFICATION = AGH_CLASSIFICATION and SAM_CATEGORY=AGQ_CATEGORY AND SAM_CATEGORY='5' and AGH_CLASSIFICATION='"+assessment_grouping+"' ";
	try
		{
		PreparedStatement pstmt=conn.prepareStatement(sql);
		ResultSet rset=pstmt.executeQuery();
		//if(rset.isBeforeFirst()){
		%>
		

	<TABLE WIDTH="100%" BORDER="1" CELLSPACING="0" CELLPADDING="3" bgcolor="#CCCCCC">
		<tr valign="top" bordercolor="#666666" bgcolor="#0033FF" class="smallbold" CELLSPACING="1">
		  <td width="60%" class="contentStrapColor"><div align="center" class="style22">Kriteria (Dinilai Melalui SKT) </div></td>
		  <td width="20%" class="contentStrapColor"><div align="center" class="style22">Markah PPP</div></td>
		  <td width="20%" class="contentStrapColor"><div align="center" class="style22">Markah PPK</div></td>
	  </tr>
		
    <%
		if(rset.isBeforeFirst())
		{
		
		 while(rset.next()){
		mark13 += rset.getDouble( 2 );
		mark14 += rset.getDouble( 3 );
		mark15 += rset.getDouble( 5 );
		mark16 = rset.getDouble( 6 );
		mark17 = mark13 / mark15 * mark16;
		mark18 = mark14 / mark15 * mark16;
		  %>

		<tr valign="top" bordercolor="#666666" bgcolor="#FFFFFF" class="smallfont">
		  <td class="contentBgColor"><div class="style29"><%=rset.getString(7)%></div></td>
		  <td class="contentBgColor"><div align="center" class="style29"><%=rset.getString(2)%></div></td>
		  <td class="contentBgColor"><div align="center" class="style29"><%=rset.getString(3)%></div></td>
		</tr>
		<%}%>
		<tr valign="top" bordercolor="#666666" bgcolor="#FFFFFF" class="smallfont">
		  <td class="contentBgColor"><div class="style29">Jumlah Markah Mengikut Wajaran</div></td>
			<td class="contentBgColor"><div align="left" class="style29"><strong>
			<%=mark13%> x <%=mark16%> = <%=currency.FormatCurrency(mark17)%>
        	<br>
    	---------------
    	<br>
    	<%=mark15%></strong></div></td>
			<td class="contentBgColor"><div align="left" class="style29"><strong>
			<%=mark14%> x <%=mark16%> = <%=currency.FormatCurrency(mark18)%>
        	<br>
    	--------------
    	<br>
    	<%=mark15%>			</strong></div></td>
		</tr>
	
<%}
			rset.close();
			pstmt.close();
			}
		catch( Exception e )
			{ out.println(e.toString());}
		}
%>			</table>

<br><BR>
<table width="100%" BORDER="0" align="center" CELLPADDING="3" CELLSPACING="1">
<tr bordercolor="#000000" align="left"> 
    <td colspan="7"><span class="style29"><strong>BAHAGIAN VI - <%=kriteria6%> WAJARAN - <%=mark_6%>% </strong></span></td>
  </tr>
</table>


<%
if ( conn!=null )
	{
	
	String sql="SELECT SAM_REFID,NVL(SAM_EVALUATOR1_MARK,0),NVL(SAM_EVALUATOR2_MARK,0),AGH_CRITERIA,AGQ_MAX_MARK,AGH_MAX_MARK,AGQ_QUESTION "+
				" FROM STAFF_ASSESSMENT_MISC, ASSESSMENT_GRADING_QUESTION, ASSESSMENT_GRADING_HEAD "+
				"WHERE SAM_STAFF_ID='"+staff+"' AND TO_NUMBER(SAM_YEAR)='"+year_sah+"' and SAM_REFID=AGQ_REFID and AGH_CATEGORY = SAM_CATEGORY "+
				" and AGQ_CLASSIFICATION = AGH_CLASSIFICATION and SAM_CATEGORY=AGQ_CATEGORY AND SAM_CATEGORY='6' and AGH_CLASSIFICATION='"+assessment_grouping+"' ";
	try
		{
		PreparedStatement pstmt=conn.prepareStatement(sql);
		ResultSet rset=pstmt.executeQuery();
		//if(rset.isBeforeFirst()){
		%>
		

	<TABLE WIDTH="100%" BORDER="1" CELLSPACING="0" CELLPADDING="3" bgcolor="#CCCCCC">
		<tr valign="top" bordercolor="#666666" bgcolor="#0033FF" class="smallbold" CELLSPACING="1">
		  <td width="60%" class="contentStrapColor"><div align="center" class="style22">Kriteria (Dinilai Melalui SKT) </div></td>
		  <td width="20%" class="contentStrapColor"><div align="center" class="style22">Markah PPP</div></td>
		  <td width="20%" class="contentStrapColor"><div align="center" class="style22">Markah PPK</div></td>
	  </tr>
		
    <%
		if(rset.isBeforeFirst())
		{
		
		 while(rset.next()){
		mark19 += rset.getDouble( 2 );
		mark20 += rset.getDouble( 3 );
		mark21 += rset.getDouble( 5 );
		mark22 = rset.getDouble( 6 );
		mark23 = mark19 / mark21 * mark22;
		mark24 = mark20 / mark21 * mark22;
		  %>

		<tr valign="top" bordercolor="#666666" bgcolor="#FFFFFF" class="smallfont">
		  <td class="contentBgColor"><div class="style29"><%=rset.getString(7)%></div></td>
		  <td class="contentBgColor"><div align="center" class="style29"><%=rset.getString(2)%></div></td>
		  <td class="contentBgColor"><div align="center" class="style29"><%=rset.getString(3)%></div></td>
		</tr>
		<%}%>
		<tr valign="top" bordercolor="#666666" bgcolor="#FFFFFF" class="smallfont">
		  <td class="contentBgColor"><div class="style29">Jumlah Markah Mengikut Wajaran</div></td>
			<td class="contentBgColor"><div align="left" class="style29"><strong>
			<%=mark19%> x <%=mark22%> = <%=currency.FormatCurrency(mark23)%>
        	<br>
    	------------
    	<br>
    	<%=mark21%></strong></div></td>
			<td class="contentBgColor"><div align="left" class="style29"><strong>
			<%=mark20%> x <%=mark22%> = <%=currency.FormatCurrency(mark24)%>
        	<br>
    	-----------
    	<br>
    	<%=mark21%>			</strong></div></td>
		</tr>
	
<%}
			rset.close();
			pstmt.close();
			}
		catch( Exception e )
			{ out.println(e.toString());}
		}
%>			</table>

<br>
<table width="100%" BORDER="0" align="center" CELLPADDING="3" CELLSPACING="1">
<tr bordercolor="#000000" align="left"> 
    <td colspan="7"><span class="style29"><strong>BAHAGIAN VII - JUMLAH MARKAH KESELURUHAN </strong></span></td>
  </tr>
</table>
	<TABLE WIDTH="100%" BORDER="1" CELLSPACING="0" CELLPADDING="3" bgcolor="#CCCCCC">
		<tr valign="top" bordercolor="#666666" bgcolor="#0033FF" class="smallbold" CELLSPACING="1">
		  <td width="33%" class="contentStrapColor"><div align="center" class="style22">Markah PPP (%) </div></td>
		  <td width="33%" class="contentStrapColor"><div align="center" class="style22">Markah PPK (%)</div></td>
		  <td width="34%" class="contentStrapColor"><div align="center" class="style22">Markah PPSM (%) 
	        <br>
	        (Untuk Diisi Oleh Urusetia PPSM)
		  </div></td>
	  </tr>
		<tr valign="top" bordercolor="#666666" bgcolor="#FFFFFF" class="smallfont">
		  <td class="contentBgColor"><div align="center" class="style29"><%=currency.FormatCurrency(ppp_mark)%></div></td>
		  <td class="contentBgColor"><div align="center" class="style29"><%=currency.FormatCurrency(ppk_mark)%></div></td>
		  <td class="contentBgColor"><div align="center" class="style29"><%=currency.FormatCurrency(final_mark)%></div></td>
		</tr>
</TABLE>

<br>
<br>
  <div align="center"><br>
    <input type="button" name="Button" value="Print" onClick="window.print()">
    <input type="button" name="Submit2" value="Close" onClick="window.close()">
  </div>

<% conn.close ();%>

</body>
</html>
