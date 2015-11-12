<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Cross-Browser Rich Text Editor</title>

	<script language="JavaScript" type="text/javascript" src="html2xhtml.js"></script>
	<!-- To decrease bandwidth, use richtext_compressed.js instead of richtext.js //-->
	<script language="JavaScript" type="text/javascript" src="richtext_compressed.js"></script>
</head>
<body>

<h2>&nbsp;</h2>


<!-- START Demo Code -->
<form name="RTEDemo" action="demo.htm" method="post" onsubmit="return submitForm();">
<script language="JavaScript" type="text/javascript">
<!--
function submitForm() {
	//make sure hidden and iframe values are in sync before submitting form
	//to sync only 1 rte, use updateRTE(rte)
	//to sync all rtes, use updateRTEs
	updateRTE('rte1');
	//updateRTEs();
	alert("rte1 = " + document.RTEDemo.rte1.value);
	
	//change the following line to true to submit form
	return false;
}

//Usage: initRTE(imagesPath, includesPath, cssFile, genXHTML)
initRTE("images/", "", "", true);
//-->
</script>
<noscript><p><b>Javascript must be enabled to use this form.</b></p></noscript>

<script language="JavaScript" type="text/javascript">
<!--
//Usage: writeRichText(fieldname, html, width, height, buttons, readOnly)
writeRichText('rte1', 'here&#39;s the "<em>preloaded</em> <b>content</b>"', 400, 200, true, false);
//-->
</script>
<p>&nbsp;</p>
<p><input type="submit" name="submit" value="Submit"></p>
</form>
<!-- END Demo Code -->

</body>
</html>
