<html>
  <head>
    <title>Staff Overtime By Month-Year: Print</title>
  </head>

<script>
function printReport() {
	document.form1.submit();
}
</script>
<body onLoad="printReport()">
<form name="form1" action="servlet/overtimeReportPrint?&Month=<%=request.getParameter("Month")%>"
	method="post" target="_top">
	
</form>
      
</body>
</html>