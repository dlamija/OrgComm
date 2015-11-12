<style type="text/css">
<!--
.style1 {
	font-family: Arial;
	font-weight: bold;
	font-size: 10px;
	color: #FFFFFF;
}
.style4 {font-family: Arial; font-size: 10px; }
-->
</style>
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
  <tr bgcolor="#0000FF">
       
    <td height="20" colspan="2"><span class="style1">Staff's Profile</span></td>
  </tr>
    
  <tr bgcolor="#ADC5EF" valign="middle" class="smallfont"> 
    <td width="17%" height="23"><span class="style4">Staff ID & Name </span></span></td>
    <td width="83%"><span class="style4"><%= staff_id %>-<%= staff_name %>&nbsp;</span></td>
  </tr>
  <tr bgcolor="#ADC5EF" valign="middle" class="smallfont"> 
    <td height="23"><span class="style4">Position</span></span></td>
    <td><span class="style4"><%= staff_jawatan %>-<%=staff_descjwtn %></span></td>
  </tr>
   
  <tr bgcolor="#ADC5EF" valign="middle" class="smallfont"> 
    <td height="23"><span class="style4">Department</span></span></td>
    <td><span class="style4"><%= staff_dept %>-<%=staff_dept_desc %></span></td>
  </tr>
</table>
