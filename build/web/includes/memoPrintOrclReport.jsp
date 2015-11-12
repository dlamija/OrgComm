<html>
  <head>
    <title>Memo : Print</title>
  </head>

<script>
function printReport() {
	document.form1.submit();
}
</script>
<body onLoad="printReport()">
<form name="form1" action="memoOrclReport?view=memo&memoid=<%=request.getParameter("memoid")%>&subject=<%=request.getParameter("subject")%>" 
	method="post" target="_top">
	
</form>
      
</body>
</html>

