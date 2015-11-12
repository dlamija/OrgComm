<%@page import="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="javax.naming.*" %>
<%@include file="/cms/announcement/header.jsp"%>

<html>
<head>
<script>
function insert_data ()
{
	if(document.form1.nama.value=='')
          {
           alert("Please Select Name");
           document.form1.nama.focus();
		    return;
          } 
	else
	{
			document.form1.action="announcement.jsp?action=insert_mpp";
			document.form1.submit();
	}
}
function delete_data (action)
{
if (document.form1.student_id == null)
        {
          return;
        }
        
        var ok = 0;
        if (document.form1.student_id[1] != null)
        {
          for(var c=0; c < document.form1.student_id.length; c++)
          {
            if(document.form1.student_id[c].checked)
            {
			  document.form1.action="announcement.jsp?action=delete_mpp";
		      document.form1.submit();
              ok = 1;
              break;
            }
          }
        }
        else if (document.form1.student_id.checked)
        {
          ok = 1;
        }
        if(ok == 0)
        {
          alert("You must select at least one...!");
          return;
        }    	
	}
</script>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<%
Connection conn = null;
String action=request.getParameter("action");
ResultSet rs_all2= null;
PreparedStatement pstmt3 = null;
PreparedStatement pstmt4 = null;
String nama = request.getParameter("nama");
String sid= (String)session.getAttribute("staffid");
String student_id[] = request.getParameterValues("student_id");

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
<% if(conn !=null && action!=null && action.equals("insert_mpp"))
{

String sql_inst = "INSERT INTO CMSADMIN.ANNOUNCEMENT_MPP_AUTHORIZE AMA (AMA.AMA_STUDENT_ID,AMA.AMA_ENTER_BY,AMA.AMA_ENTER_DATE)"+
                  "VALUES"+
				  "(?,?,SYSDATE) ";

	try
	{
		pstmt3 = conn.prepareStatement(sql_inst);
		pstmt3.setString(1, nama);
		pstmt3.setString(2, sid);
		pstmt3.executeUpdate();
        pstmt3.close ();
	}
     	catch (SQLException e)
        	{out.println (e.toString ());   }
		finally {
  try {
      if (conn != null) 
	  conn.close();    
	  pstmt3.close ();
  }
  catch (Exception e) { }
  }
		}
%>
<% if(conn !=null && action!=null && action.equals("delete_mpp"))
{

String sql_inst = "DELETE FROM CMSADMIN.ANNOUNCEMENT_MPP_AUTHORIZE AMA "+
	              "WHERE AMA.AMA_STUDENT_ID = ? ";

				  
for (int a=0; a<student_id.length; a++)
	{
	try
	{
		pstmt4 = conn.prepareStatement(sql_inst);
		pstmt4.setString(1, student_id[a]);
		pstmt4.executeUpdate();
        pstmt4.close ();
	}
     	catch (SQLException e)
        	{out.println (e.toString ());   }
		finally {
  try {
      if (conn != null) 
	  conn.close();    
	  pstmt4.close ();
  }
  catch (Exception e) { }
  }
		}
}		
%>


<body>
<form name="form1" method="post" action="">
  <table width="100%" border="0" cellspacing="1" bgcolor="#999999" class='contentBgColor'>
    <tr bgcolor="#999999"> 
      <td colspan="2"><strong>MPP Authorization</strong></td>
    </tr>
    <tr> 
      <td width="17%" bgcolor="#CCCCCC" class='contentBgColor'><strong>Student 
        Name :</strong></td>
      <td width="83%" bgcolor="#FFFFFF"><span style="font-family: Arial; font-size: 10px;"><b><font face="Geneva, Arial, Helvetica, san-serif">
        <%
			String sqlq = "SELECT SM.SM_STUDENT_ID,SM.SM_STUDENT_NAME "+
						  "FROM CMSADMIN.STUDENT_MAIN SM WHERE SM.SM_STATUS='ACTIVE' AND SM.SM_PROGRAM IN ('01','02') ORDER BY SM_STUDENT_ID";						
						try{
							Statement stmt = conn.createStatement();
							ResultSet rset = stmt.executeQuery( sqlq );
							if (rset.isBeforeFirst()) {
								%>
        <select name="nama" class="smallfont" id="sid" style="font-family: Verdana, sans-serif; font-size: 11px;  8px;" >
          <%while( rset.next() ){ %>
          <option <% if (request.getParameter("nama")!=null&&request.getParameter("nama").toString().equals(rset.getString(1))) { %> selected<% } %> value="<%= rset.getString( 1 ) %>"> 
          <b><font face="Geneva, Arial, Helvetica, san-serif"><%=rset.getString( 1 )%> - <%=rset.getString( 2 )%></font></b></option>
          <%}%>
        </select>
        </font></b><b><font face="Geneva, Arial, Helvetica, san-serif"> 
        <%
		  
							}
							rset.close();
							stmt.close();
						}catch( SQLException sqle ){
						}
				%>
        </font></b><b><font face="Geneva, Arial, Helvetica, san-serif"> </font></b></span></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td colspan="2"> <div align="right"><A HREF="javascript:insert_data();" onMouseOver="window.status='Add';return true;"><IMG SRC="images/system/ic_add.gif" BORDER="0" ALT="Add"></A> 
        </div></td>
    </tr>
  </table>

  <%
	if(conn!=null)
	{
		String sql2 = null;
			sql2	= 	"SELECT AMA.AMA_STUDENT_ID,SM.SM_STUDENT_NAME,DM.DM_DEPT_CODE,DM.DM_DEPT_DESC "+
						"FROM CMSADMIN.STUDENT_MAIN SM,CMSADMIN.DEPARTMENT_MAIN DM,CMSADMIN.ANNOUNCEMENT_MPP_AUTHORIZE AMA "+
						"WHERE SM.SM_STUDENT_ID = AMA.AMA_STUDENT_ID AND SM.SM_FACULTY_CODE = DM.DM_DEPT_CODE ORDER BY AMA_STUDENT_ID ";

		try
		{
			//System.out.println(sql2);
			PreparedStatement pstmt2 = conn.prepareStatement(sql2);
			rs_all2 = pstmt2.executeQuery ();
%>
  <br>
  <table width="100%" border="0" align="center" cellspacing="1" bgcolor="#999999" class='contentBgColor'>
    <tr bgcolor="#999999"> 
      <td width="3%"> <div align="center"><strong>Bil</strong></div></td>
      <td width="48%"> <div align="center"><strong>Name</strong></div></td>
      <td width="46%"> <div align="center"><strong>Faculty</strong></div></td>
      <td width="3%">&nbsp;</td>
    </tr>
    <%
	if (rs_all2.isBeforeFirst ())  
			{
		while (rs_all2.next())
			{
    %>
    <tr> 
      <td bgcolor="#FFFFFF"> <div align="center"><%=rs_all2.getRow()%></div></td>
      <td bgcolor="#FFFFFF"><table width="100%" border="0" cellspacing="0" class='contentBgColor'>
          <tr bgcolor="#FFFFFF"> 
            <td width="18%"><%=rs_all2.getString(1)%></td>
            <td width="2%">-</td>
            <td width="80%"><%=rs_all2.getString(2)%></td>
          </tr>
        </table>
        
      </td>
      <td bgcolor="#FFFFFF"> <div align="left"><%=rs_all2.getString(4)%></div></td>
      <td bgcolor="#FFFFFF"><input name="student_id" type="checkbox" id="student_id" value="<%=rs_all2.getString(1)%>"></td>
    </tr>
    <%
			}
		}
		else
		{
			
%>
    <tr class='contentBgColorAlternate'> 
      <td colspan="11" valign="middle" bgcolor="#FFFFFF"> <em>No Record</em></td>
      <%
  }
	pstmt2.close ();
	//rs_all.close ();	
	}
	catch(Exception e)
	{
		System.out.println(e);
	}
	
%>
      <%
	}
%>
    <tr bgcolor="#FFFFFF"> 
      <td colspan="11" valign="middle"> <div align="right"><A HREF="javascript:delete_data();" onMouseOver="window.status='Delete';return true;"><IMG SRC="images/system/ic_delete.gif" BORDER="0" ALT="Delete"></A> 
        </div></td>

  </table>
</form>
<p><br>
</p>
</body>
</html>
<% conn.close(); %>
