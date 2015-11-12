<html>
  <head>
    <title>Staff Assessment Mark By Year: Print</title>
  </head>

<script>
function printReport() {
	document.form1.submit();
}
</script>
<body onLoad="printReport()">
<form name="form1" action="servlet/assessmentReportPrint?&Year=<%=request.getParameter("Year")%>"
	method="post" target="_top">
	
</form>
      
</body>
</html>