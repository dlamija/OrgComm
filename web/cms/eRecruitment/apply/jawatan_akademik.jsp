  <table width="100%" border="0" cellspacing="0" class='style2'>
    <tr> 
      <td width="15%"><div align="right">Fakulti :</div></td>
      <td width="85%"><b><font face="Geneva, Arial, Helvetica, san-serif">
        <select name="fakulti" size="1" id="fakulti"  value="" onChange = 'document.applForm.action="eRecruitment.jsp?action=borangpermohonan";document.applForm.submit();' style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px;">
          <option>Pilih Fakulti 
          <%
    try
	{
	    Statement stmt=conn.createStatement();
	    String sql=		"SELECT dm_dept_code, dm_dept_desc " +
				 		"FROM DEPARTMENT_MAIN " +
						"WHERE DM_LEVEL='1' " +
				 		"and DM_TYPE ='ACADEMIC' "+
				 		"ORDER BY dm_dept_desc";

	    ResultSet rset=stmt.executeQuery(sql);
		while(rset.next())
		{
			String title = rset.getString(2);
			String refid = rset.getString(1);

			if(fakulti!=null && fakulti.equals(refid))
			{
%>
          <option selected value='<%=refid%>'><%=refid%> - <%=title%> 
          <%}else{
%>
          <option value='<%=refid%>'><%=refid%> - <%=title%> 
          <%
			}
		}
		stmt.close ();
		rset.close ();
	}
	catch(Exception e)
	{
		System.out.println("Error in select fakulti:"+e);
	}
	conn.close();
%>
        </select>
        </font></b></td>
    </tr>
    <tr> 
      <td><div align="right">Jawatan :</div></td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td><div align="right">Bidang :</div></td>
      <td>&nbsp;</td>
    </tr>
  </table>