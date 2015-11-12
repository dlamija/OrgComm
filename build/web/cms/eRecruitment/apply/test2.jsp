<% //String tarikhlahir = request.getParameter("tarikhlahir");
String tarikhlahir_Year_ID = request.getParameter("tarikhlahir_Year_ID");
String tarikhlahir_Month_ID = request.getParameter("tarikhlahir_Month_ID");
String tarikhlahir_Day_ID = request.getParameter("tarikhlahir_Day_ID");
String tarikhlahir = tarikhlahir_Day_ID + "/" + tarikhlahir_Month_ID + "/" + tarikhlahir_Year_ID;

%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
tarikh : <%=tarikhlahir%>
<%=tarikhlahir_Day_ID%>
<body>

</body>
</html>
