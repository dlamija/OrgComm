<html>
  <head>
    <title>Staff Attendance Report (Late) By Month-Year: Print</title>
  </head>

<script>
function printReport() {
	document.form1.submit();
}
</script>
<body onLoad="printReport()">
<form name="form1" action="servlet/attendanceReportPrint?&Month=<%=request.getParameter("Month")%>"
	method="post" target="_top">
	
</form>
      
</body>
</html>