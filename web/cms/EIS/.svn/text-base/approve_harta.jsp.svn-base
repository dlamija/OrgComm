<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="/includes/import.jsp" %>
<html>

<head>

<SCRIPT LANGUAGE="JavaScript">
	function checkAll(field)
	{
	for (i = 0; i < field.length; i++)
		field[i].checked = true ;
	}

	function uncheckAll(field)
	{
	for (i = 0; i < field.length; i++)
		field[i].checked = false ;
	}

</script>




</head>
<%
	Connection conn = null;
	String sid= (String)session.getAttribute("staffid");
	String action = request.getParameter("action");

	String status1="APPROVED";
	String status2="REJECTED";



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

<body>
<!--
<a href="detailapproved.jsp"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">[ Home ]</font></a><font size="2" face="Verdana, Arial, Helvetica, sans-serif">&nbsp;&nbsp;| 
<a href="viewapprovedtop.jsp">[ List of Approved ]</a>&nbsp;&nbsp;| &nbsp;&nbsp;<a href="viewrejectedtop.jsp">[ 
List of Rejected ]</a>&nbsp;&nbsp;| &nbsp;&nbsp;</font>-->
<input type="button" value="Home" onClick="javascript:window.location.href='detailapproved.jsp';">
<input type="button" value="List of Approved" onClick="javascript:window.location.href='viewapprovedtop.jsp';">
<input type="button" value="List of Rejected" onClick="javascript:window.location.href='viewrejectedtop.jsp';">
<input type="button" value="Close Screen" onClick="window.close()"> 
<input name="button" type="button" onClick="window.print()" value="Print">
<hr>
<div align="center">
<font size="2" color="black" face="Arial, Helvetica, sans-serif">
<b>KOLEJ UNIVERSITI KEJURUTERAAN & TEKNOLOGI MALAYSIA<BR>
Ringkasan Laporan Pengisytiharan Harta <br>
Staff KUKTEM</b>
</font>
</div>

<hr>

<form name="form1" action="../harta/topapproved.jsp" method="post" >
  <!-----and SAD_STATUS_TOP IS NULL "ORDER BY SM_STAFF_NAME ";-->
  <p>
    <%
if (conn!=null)
	{
	// Display lists of waiting applications
	String sql	=  "SELECT  ADM_STAFF_ID,SM_STAFF_NAME,ADM_JUMLAH_PENDAPATAN_A1, "+
	               "ADM_PINJAMRUMAH_SUAMI,ADM_PINJAMKENDERAAN_SUAMI,ADM_PINJAMCUKAI_SUAMI,ADM_PINJAMKOPERASI_SUAMI, "+
                   "ADM_PINJAMLAIN1_SUAMI,ADM_PINJAMLAIN2_SUAMI,ADM_PINJAMLAIN3_SUAMI,ADM_PINJAMLAIN4_SUAMI,ADM_PINJAMLAIN5_SUAMI, "+
                   "ADM_JUMLAH_PENDAPATAN_A2, "+
				   "ADM_PINJAMRUMAH_ISTERI,ADM_PINJAMKENDERAAN_ISTERI,ADM_PINJAMCUKAI_ISTERI,ADM_PINJAMKOPERASI_ISTERI, "+
                   "ADM_PINJAMLAIN1_ISTERI,ADM_PINJAMLAIN2_ISTERI,ADM_PINJAMLAIN3_ISTERI,ADM_PINJAMLAIN4_ISTERI,ADM_PINJAMLAIN5_ISTERI, "+
				   "ADM_NILAI_PEROLEH1,ADM_NILAI_PEROLEH2,ADM_NILAI_PEROLEH3,ADM_NILAI_PEROLEH4,ADM_NILAI_PEROLEH5, "+
				   "ADM_NILAI_PEROLEH6,ADM_NILAI_PEROLEH7,ADM_NILAI_PEROLEH8,ADM_NILAI_PEROLEH9,ADM_NILAI_PEROLEH10, "+
			        "dm_dept_desc,SM_JOB_CODE,SS_SERVICE_DESC "+
				   "FROM ASSET_DECLARE_MAIN,STAFF_MAIN,STAFF_ASSET_DECLARE,department_main,SERVICE_SCHEME "+
				   "WHERE ADM_STAFF_ID=SM_STAFF_ID AND ADM_STAFF_ID=SAD_STAFF_ID and SM_DEPT_CODE=DM_DEPT_CODE AND SM_JOB_CODE=SS_SERVICE_CODE "+
				   "AND SAD_STATUS='VERIFIED' and SM_STAFF_TYPE='STAFF' AND SM_STAFF_STATUS='ACTIVE' "+
                   "and sm_job_code in ('DA41','DG41','DS45','F41','J41','J41A','N41','N41A','Q41','S41','S41A','S41C','U41','W41', "+
				   "'W41A','DS51','DS53','DS54','J48','N48','N54','S48','S54','VK7','VU5-A','VU6-B','W48') "+
				   "ORDER BY SM_STAFF_NAME ";

		try
			{
			PreparedStatement pstmt = conn.prepareStatement(sql);


			ResultSet rset = pstmt.executeQuery ();
			if (rset.isBeforeFirst ()) { %>
      <font size="2" color="black" face="Arial, Helvetica, sans-serif">
  <b>URUSETIA</b><br>
      </font><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Berikut adalah ringkasan Pengistiharan Harta untuk pertimbangan dan perakuan Lembaga Tatatertib</font></p>
  <p align="right">
  
  <input name="Check All" type="button" value="Check All" onClick="checkAll(document.form1.refid)" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;  font-weight: bold">
          <input name="Uncheck All" type="button" value="Uncheck all" onClick="uncheckAll(document.form1.refid)" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;  font-weight: bold">
  <!----------------mula di sini--------------->
    
</p>
  <TABLE width="100%" cellspacing="1" border="0" cellpadding="3" bgcolor="lightGray">
  <br>
  <tr valign="top" bgcolor="blue" class="smallbold"> 
    <td class = "contentStrapColor">&nbsp;</td>
    <td class = "contentStrapColor"><font size="-1" color="white" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
    <td class = "contentStrapColor" colspan="2" align="center"><font size="-1" color="white" face="Arial, Helvetica, sans-serif"><b>PEGAWAI</b></font></td>
    <td class = "contentStrapColor" colspan="2" align="center"><font size="-1" color="white" face="Arial, Helvetica, sans-serif"><b>PASANGAN</b></font></td>
    <td colspan="2" align="center" class = "contentStrapColor"><font size="-1" color="white" face="Arial, Helvetica, sans-serif"><b>PERINCIAN 
      HARTA</b></font><font size="-1" color="white" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
    <td class = "contentStrapColor"><div align="center"><font size="-1" color="white" face="Arial, Helvetica, sans-serif"><b>KEPUTUSAN</b></font></div></td>
  </tr>
  <tr valign="top" bgcolor="#91b8e7" class="smallbold"> 
    <td class = "contentStrapColor">&nbsp;</td>
    <td class = "contentStrapColor" align="center"><font size="-1" color="white" face="Arial, Helvetica, sans-serif"><b>Nama 
      Staf</b></font></td>
    <td class = "contentStrapColor" align="center"><font size="-1" color="white" face="Arial, Helvetica, sans-serif"><b>Pendapatan 
      Keseluruhan (RM)</b></font></td>
    <td class = "contentStrapColor" align="center"><font size="-1" color="white" face="Arial, Helvetica, sans-serif"><b>Tanggungan 
      Keseluruhan (RM) </b></font></td>
    <td class = "contentStrapColor" align="center"><font size="-1" color="white" face="Arial, Helvetica, sans-serif"><b>Pendapatan 
      Keseluruhan (RM)</b></font></td>
    <td class = "contentStrapColor" align="center"><font size="-1" color="white" face="Arial, Helvetica, sans-serif"><b>Tanggungan 
      Keseluruhan (RM)</b></font></td>
    <td align="center" class = "contentStrapColor"><font size="-1" color="white" face="Arial, Helvetica, sans-serif"><b>Jumlah 
      Nilai Perolehan (RM)</b></font><font size="-1" color="white" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
    <td class = "contentStrapColor" align="center"><font size="-1" color="white" face="Arial, Helvetica, sans-serif">&nbsp;</font></td>
	<td class = "contentStrapColor" align="center"><table width="100%" border="0">
        <tr>
          <td bgcolor="#3300FF"><font size="-1" color="white" face="Arial, Helvetica, sans-serif"><strong>Approve</strong></font></td>
          <td><font size="-1" color="#FF0000" face="Arial, Helvetica, sans-serif"><strong>Reject</strong></font></td>
        </tr>
      </table>
      
    </td>
  </tr>
  <%
            float jum=0;
			float total = 0;
		    float jum2=0;
		    float total2 = 0;
			float jum3=0;
		    float total3 = 0;


		while (rset.next ())
     		{
		jum = rset.getFloat( 4 ) + rset.getFloat( 5 ) + rset.getFloat( 6 ) + rset.getFloat( 7 )
		      + rset.getFloat( 8 ) + rset.getFloat( 9 ) + rset.getFloat( 10 ) + rset.getFloat( 11 )
			  + rset.getFloat( 12 );

	    jum2 = rset.getFloat( 14 ) + rset.getFloat( 15 ) + rset.getFloat( 16 ) + rset.getFloat( 17 )
		      + rset.getFloat( 18 ) + rset.getFloat( 19 ) + rset.getFloat( 20 ) + rset.getFloat( 21 )
			  + rset.getFloat( 22 );

		jum3 = rset.getFloat( 23 ) + rset.getFloat( 24 ) + rset.getFloat( 25 ) + rset.getFloat( 26 )
		      + rset.getFloat( 27 ) + rset.getFloat( 28 ) + rset.getFloat( 29 ) + rset.getFloat( 30 )
			  + rset.getFloat( 31 ) + rset.getFloat( 32 );


		total= jum;
		total2= jum2;
		total3= jum3;

		%>
  <tr valign="top" bgcolor="#FFFFFF" class="smallfont"> 
    <td height="24" class = "contentBgColor"><font size="-1" color="black" face="Arial, Helvetica, sans-serif"><%=rset.getRow()%></font></td>
    <td class = "contentBgColor"><font size="-1" color="black" face="Arial, Helvetica, sans-serif"><strong><%=rset.getString(2)%> &nbsp;</strong>(<font size="-1" color="black" face="Arial, Helvetica, sans-serif"><%=rset.getString(1)%></font>)<strong><br>
      </strong>      <font size="-1" color="black" face="Arial, Helvetica, sans-serif"><font size="-1" color="black" face="Arial, Helvetica, sans-serif"><font size="-1" color="black" face="Arial, Helvetica, sans-serif"><%=rset.getString(34)%></font></font>-<font size="-1" color="black" face="Arial, Helvetica, sans-serif"><font size="-1" color="black" face="Arial, Helvetica, sans-serif"><%=rset.getString(35)%></font></font><br>
      <%=rset.getString(33)%></font>    </font></td>
    <td class = "contentBgColor"><font size="-1" color="black" face="Arial, Helvetica, sans-serif"> 
      <div align="right"><%=( ( rset.getString(3) ==null)?"-":rset.getString(3) )%></div>
      </font></td>
    <td class = "contentBgColor"><font size="-1" color="black" face="Arial, Helvetica, sans-serif"> 
      <div align="right"><%=total%></div>
      </font></td>
    <td class = "contentBgColor"><font size="-1" color="black" face="Arial, Helvetica, sans-serif"> 
      <div align="right"><%=( ( rset.getString(13) ==null)?"-":rset.getString(13) )%></div>
      </font></td>
    <td class = "contentBgColor"><font size="-1" color="black" face="Arial, Helvetica, sans-serif"> 
      <div align="right"><%=total2%></div>
      </font></td>
    <td class = "contentBgColor"><font size="-1" color="black" face="Arial, Helvetica, sans-serif">
      <div align="right"><font size="-1" color="black" face="Arial, Helvetica, sans-serif"><%=total3%></font> 
      </div>
      <div align="right"></div> <div align="right"></div>
      </td>
    <td class = "contentBgColor"><font size="-1" color="black" face="Arial, Helvetica, sans-serif"><a href="../harta/sah/bahagian1_dato.jsp?id=<%=rset.getString(1)%>">Detail</a></font></td>
    <td class = "contentBgColor"><font size="-1" color="black" face="Arial, Helvetica, sans-serif"> 
      <div align="center">
        <table width="100%" border="0">
          <tr> 
            <td bgcolor="#0000FF"> 
              <div align="center"> 
                <input type="checkbox" name="refid" id="refid" value="<%= rset.getString(1)%><%= status1%>">
              </div></td>
            <td bgcolor="#FF0000"><div align="center"> 
                <input type="checkbox" name="refid2" id="refid2"  value="<%= rset.getString(1)%><%= status2%>">
              </div></td>
          </tr>
        </table>
          </div>
      </font></td>
  </tr>
  <% } %>
</table>
    </td>
  </tr>
</table>
<div align="right">
  <input name="Check All2" type="button" value="Check All" onClick="checkAll(document.form1.refid)" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;  font-weight: bold">
  <input name="Uncheck All2" type="button" value="Uncheck all" onClick="uncheckAll(document.form1.refid)" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;  font-weight: bold">
</div>
<hr>
<div align="right">
<!--Choose:
<select name="status">
    <option>...</option>
	<option value="APPROVE">APPROVE</option>
	<option value="REJECT">REJECT</option>-->
         </select><input type="submit" value="Save"></div>
</form>
<p>
<!-----tambah record-->
<!--<a href="ProgressReport.jsp?action=add"><img src="cms/ProgressReport/images/add.gif" width="30" height="18" border="0"></a>
<a href="ProgressReport.jsp?action=viewprevious"><IMG SRC ="cms/ProgressReport/images/ic_viewall.gif" BORDER="0" ALT="View Previous"></a>&nbsp;-->
       <%  } else { %><p>
<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFF">
  <tr>
    <td colspan="11">No record available </td>
  </tr>

</table>
<p>

        <% }

			rset.close ();
			pstmt.close ();
			}
	catch( Exception e )
		{ out.println (e.toString()); }
	}
conn.close ();
%>







<!--------------------------------------------->







<% conn.close(); %>
</body>

</html>
