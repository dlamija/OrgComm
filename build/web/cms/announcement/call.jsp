<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>

<%
	 	String sqlchk2 = null;
		String respone = "";
		//String parent = request.getParameter("agenda_parent");

	    if (access != null)

				sqlchk2	=  "SELECT am_ref,am_category,am_title,am_message,TO_CHAR(am_date,'DD-MON-YY'),sm_staff_name,UPPER(DM_DEPT_DESC),am_access "+
        	               "FROM announcement_main,staff_main,DEPARTMENT_MAIN "+
						   "where am_posted_by=sm_staff_id and SM_DEPT_CODE=DM_DEPT_CODE  and to_char(am_date,'MON-YYYY')='"+tarikh+"' and am_category = '"+category+"' "+
						   "and am_access = '"+access+"' "+
						   "order by TO_CHAR(AM_DATE,'DD-MON-YY') DESC ";
					 				 
		try
		{
			PreparedStatement pstmtchk2 = conn.prepareStatement(sqlchk2);
			ResultSet rsetchk2 = pstmtchk2.executeQuery ();
%>
<%
			if (rsetchk2.isBeforeFirst ())  
			{
			while (rsetchk2.next())
			{
							respone = rsetchk2.getString(1);
							String tarikh2= rsetchk2.getString(5);
%>
<table  width="100%" border="0" cellpadding="0">
  <tr class='contentBgColor'> 
      <td><div align="right"><b></b></div></td>
      <td width="42%"><strong><font size="1" face="Arial"> 
        </font></b><a href="javascript:void(window.open('entry/view.jsp?ref=<%=rsetchk2.getString(1)%>','view', 'height=500,width=600,menubar=no,toolbar=no,scrollbars=yes'))"><font size="1" color=blue face="Arial"><b><%=rsetchk2.getString(3)%></b></font></a></font> </font> 
        <% if (tarikh3.equals(tarikh2)) { %><img src="images/new_baru.gif" width="31" height="12"> <% }%></strong></td>
      <td width="55%" colspan="2">&nbsp;</td>
    </tr>
    <tr class='contentBgColor'> 
      <td width="3%"><div align="center"></div></td>
      
  <td colspan="5"> <strong><font size="1" face="Arial">posted 
    by </font></strong>- <font color=black size="1" face="Arial"><%=rsetchk2.getString(6)%>, 
    <%=rsetchk2.getString(7)%>; <strong><br>
    Date</strong>:<%=rsetchk2.getString(5)%><br>
    <div align="center"> </div>
    </font> </td> 

  <% } 
	}else
		{ 
%>

<%
	  	    }
			rsetchk2.close();
			pstmtchk2.close();
	    }

     catch (SQLException e)
     { out.println ("Error! : " + e.toString ()); }

%>
  <% conn.close(); %>
</table>