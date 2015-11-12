<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-us">
<head>
	<title>jGlideMenu - Static Menu</title>
	<style  type="text/css">
		body { font-family: verdana, arial, sans-serif; color: #535353; font-size: .62em;  background: #f3f8f0; }
                #launch
                { font-family: tahoma,sans-serif; }
                a#launch
                { text-decoration: none; color: #535353; }
                a#launch:HOVER
                { text-decoration: underline; color: #f90; }
		.ifM_header
		{ cursor: Move; }
		#overview a { color: darkgreen; text-decoration: none; }
		#overview a:HOVER { color: #f90; }
		#jGlide_001 { top: 100px; left: 10px; display: none; /* Hide Menu Until Ready(Optional) */ }
	</style>
	<link rel="stylesheet" type="text/css" href="css/jGlideMenu.css" />
	<!-- Current Release of jQuery - at time of build -->
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
	<!-- Remove the following line to disabled dragging-dropping / Also Edit CSS to Remove cursor:move from .jGM_header -->
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.1/jquery-ui.min.js"></script>
	<script type="text/javascript" src="js/jQuery.jGlideMenu.067.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			// Initialize Menu
			$('#jGlide_001').jGlideMenu({
				tileSource	: '.jGlide_001_tiles' , 
				demoMode	: true 
			}).show();

			// Connect "Toggle" Link	
			$('#switch').click(function(){$(this).jGlideMenuToggle();});
		});
	</script>
</head>
<body>


<!-- Menu Holder -->
<div class="jGM_box" id="jGlide_001">

		This is Example One

		<!-- Tiles for Menu -->
		<ul id="tile_001" class="jGlide_001_tiles" title="Tile One" alt="Description for tile number one">
			<li rel="tile_002">Link No Satu</li>
			<li rel="tile_003">Link Two</li>
			<li rel="tile_004">Link Three</li>
			<li><a href="http://www.google.com">Link to Google 1</a></li>
			<li><a href="http://www.google.com">Link to Google 2</a></li>
			<li><a href="http://www.google.com">Link to Google 3</a></li>
			<li><a href="http://www.google.com">Link to Google 4</a></li>
			<li><a href="http://www.google.com">Link to Google 5</a></li>
			<li><a href="http://www.google.com">Link to Google 6</a></li>
			<li><a href="http://www.google.com">Link to Google 7</a></li>
			<li><a href="http://www.google.com">Link to Google 8</a></li>
		</ul>
		<ul id="tile_002" class="jGlide_001_tiles" title="Tile Two" alt="Another Tile in This Example">
			<li rel="tile_005">Click Here</li>
			<li><a href="http://www.google.com">Link to Google</a></li>
		</ul>
		<ul id="tile_003" class="jGlide_001_tiles" title="Tile Three" alt="Third Tile is loaded up">
			<li><a href="http://www.google.com">Link to Google</a></li>
		</ul>
		<ul id="tile_004" class="jGlide_001_tiles" title="Search Engines" alt="Find your favorite search engine">
                        <li><a href="http://www.google.com">Link to Google</a></li>
			<li><a href="http://www.yahoo.com">Link to Yahoo!</a></li>
			<li><a href="http://www.ask.com">Link to Ask.com</a></li>
                </ul>
		<ul id="tile_005" class="jGlide_001_tiles" title="Tile Five" alt="Active Spot Light Link">
                        <li><a href="http://www.active8media.com">Link to ASL</a></li>
                </ul>
		<!-- Tiles for Menu -->
</div>
<!-- Menu Holder -->
</body>
<script type="text/javascript" src="/resources/js/plugins/google/analytics/gatag.js"></script>
<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-7365212-1");
pageTracker._trackPageview();
} catch(err) {}</script>
</html>
