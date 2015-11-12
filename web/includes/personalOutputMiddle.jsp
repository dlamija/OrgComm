<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.text.*" %>
<%@ page import="javax.sql.*" %>
<%@ include file="/includes/import.jsp" %>
<%
    

    String contentTitleFont = "contentTitleFont";
    if (language.equals("zh") || language.equals("ja"))
        contentTitleFont = "contentTitleGlyphFont";


    if ( language.equals("en"))		
        showIcon = true;



%>


<head>

<style type="text/css">
body {
	text-align: center;
	margin:0 auto;
	padding:0;
	background: transparent;
	font-size:11px;
	line-height:13px;
	color:#424242;
	font-family: tahoma;
	margin-left: 0px;
	margin-right: 0px;
}
body > div {text-align:center; margin-right:auto; margin-left:auto;font-family: tahoma;} 
div,form,ul,ol,li,span,p {margin: 0; padding: 0; border: 0;font-family: tahoma;}
img,a img{border:0; margin:0; padding:0;}
h1,h2,h3,h4,h5,h6 { margin:0; padding:0;font-weight:normal;font-family:Arial}
ul,ol,li {list-style:none;font-size:11px}
table,td,input {font-size:11px}
HR{display: none;}
UL{margin: 0px auto;margin /**/:0px;}
TD{line-height:16px;font-size:11px;font-family:tahoma;vertical-align: top;}

a {color: #424242;text-decoration:none}
a:hover {text-decoration:underline;color:#004AAF}

.c2,.c3,.c4,.c5 {width:100%;text-align:center;margin:0 auto;padding:0;border:0}
.c2 div,.c2 li,.c2 P {width:49.9%;float:left}	
.c3 div,.c3 li,.c3 P {width:33%;float:left;}	
.c4 div,.c4 li,.c4 P {width:24.9%;float:left;}	
.c5 div,.c5 li,.c5 P {width:19.9%;float:left;}	

.Area{width:100%;clear:both;height:auto;margin:0px auto;background:#fff;}
.foot{float:center;width:1024px}
.mArea{width:100%px;float:left}
.mArea .topbg1 { top repeat-x #fff;}
.mArea .topbg1 P{color:#FF7801;font-family:tahoma;text-align:right;width:1024px;padding:8px 142px 8px 60px}
.mArea .topbg1 P SPAN{font-weight:bold;float:left;}
<!--.mArea .topbg1 P IMG{margin-left:6px}->

.mArea .tag{repeat-x #fff bottom;width:100%;height:24px;}
<!--.mArea .tag UL{margin-left:10px;height:22px !important;height:23px;float:left;font-family:tahoma;font-size:11px;color:#0070B9;font-weight: bold;}-->
<!--.mArea .tag LI{float:left;margin-right:5px;width:110px;background:url(images/libg.gif);height:18px;padding-top:4px;border:1px #D3D3D3 solid;border-bottom:1px #B2D4EA solid;}-->
<!--.mArea .tag .other{height:19px;border:1px #B3D4EB solid;;border-bottom:none;background:url(images/tagbg1.gif) repeat-x #E4F3FD bottom;}-->
.mArea .tag LI SPAN{padding:0px 10px;display:block}
<!--.mArea .tag LI A{color:#0070B9;font-weight: bold;}-->

.mArea .cont{width:650px;margin:0px auto;border:0px #B3D4EB solid;border-top:none}    <!---border=1>
.mArea .cont UL{;margin:0px auto;padding:0px 9px;text-align:left;color:#000;}
.mArea .cont LI {line-height:15px;padding:1px 0px;line-height:22px;}
.mArea .cont LI A{color:#000}
<!--.mArea .cont LI SPAN{color:#0070B9}-->
.mArea .cont .flag{margin:0px 5px }
<!--.mArea .affiche UL{width:490px;margin:5px auto;background:url(images/li_bg.gif) bottom repeat-x;border:}-->
.mArea .affiche LI{text-indent:-35px;width:800px;padding-left:40px;}


.mArea .cont .more{text-align:left;margin:5px 9px}
<!--.mArea .cont .more span{float:right;color:#0070B9}-->
<!--.mArea .cont .more span A{color:#0070B9}-->
.mArea .cont .more img{margin:0px 3px}

<!--.mArea .h14{background:url(images/topbg2.gif);height:14px;}-->
<!--.mArea .topbg2 {background:url(images/topbg2.gif) top repeat-x #fff;}-->
<!--.mArea .topbg2 TABLE{background:#B0E8F5;}-->
.mArea .topbg2 TD{background:#E1F3F8;line-height:20px;color:#000;font-size:12px;padding-top:3px;font-family:arial;text-align:left}
.mArea .topbg2 TD A{color:#000}
.mArea .topbg2 .tdbg{background:#F2FCFF;font-weight: bold;}
.mArea .topbg2 .right .pl5{padding-center:5px;text-align:left;}
.mArea .topbg2 .right .pl5 img{	margin-right: 5px;}
.mArea .topbg2 .left {margin-left:1px;width:260px;display:inline;}
.mArea .topbg2 .left .title TD SPAN{float:right;padding-right:5px;font-weight: normal;}
.mArea .topbg2 .left .title TD SPAN A{color:#fff;font-weight: normal;}
<!--.mArea .topbg2 .title TD{color:#fff;background:url(images/tablebg1.gif);line-height:22px;text-align:left;font-family:tahoma;padding-top:2px;height:20px;font-weight: bold;}-->
.mArea .topbg2 .title IMG{margin:0px 4px}
<!--.mArea .topbg2 .tstyle1 TD{height:49px;*height:42px;_padding:3px;padding-left:10px}-->
.mArea .topbg2 .tstyle2 TD{height:23px;padding-left:10px}
.mArea .topbg2 .tstyle2 img{	margin-right:5px;}
.mArea .topbg2 .right TD{text-align:center}
.mArea .topbg2 .right .more{background:#fff;text-align:right;color:#0070B9}
<!--.mArea .topbg2 .right .more A{color:#0070B9;padding-right:5px}-->
.left { float: left;}
.right { float: right;}
.clear { clear: both; font-size:1px; width:1px; visibility: hidden;margin-top:0px !important;margin-top:-2px;background:none;}
.clear:after{content: ".";	display: block;height: 0;clear: both;}
.verticalMiddle { vertical-align: middle;}
.fb{font-weight: bold;}
.flagImg{padding-right:3px}
.blank8_w {height:8px;font-size:1px;clear:both;line-height:1px}
</style>

<style type="text/css">
.TabbedPanels {
	CLEAR: none; PADDING-RIGHT: 0px; MARGIN-TOP: 10px; PADDING-LEFT: 0px; FLOAT: left; PADDING-BOTTOM: 0px; WIDTH: 100%; PADDING-TOP: 0px
}
.TabbedPanelsTabGroup {
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN-LEFT: 15px; PADDING-TOP: 0px
}
.TabbedPanelsTab {
	PADDING-RIGHT: 10px; PADDING-LEFT: 10px; FONT-SIZE: 12px; FLOAT: left; PADDING-BOTTOM: 4px; MARGIN: 0px 2px -2px 0px; CURSOR: pointer; COLOR: #fff; PADDING-TOP: 4px; LIST-STYLE-TYPE: none; POSITION: relative; TOP: 1px; BACKGROUND-COLOR: #326aa5; -moz-user-select: none; -khtml-user-select: none
}
.TabbedPanelsTabSelected {
	BORDER-RIGHT: #326aa5 1px solid; BORDER-TOP: #326aa5 1px solid; BORDER-LEFT: #326aa5 1px solid; COLOR: #000; BACKGROUND-COLOR: #fff
}
.TabbedPanelsTab A {
	COLOR: black; TEXT-DECORATION: none
}
.TabbedPanelsContentGroup {
	CLEAR: both; PADDING-RIGHT: 0px; BORDER-TOP: #326aa5 3px solid; PADDING-LEFT: 0px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px
}
.TabbedPanelsContent {
	PADDING-RIGHT: 4px; PADDING-LEFT: 4px; PADDING-BOTTOM: 4px; PADDING-TOP: 4px
}
.TabbedPanelsContentVisible {
	
}
.VTabbedPanels .TabbedPanelsTabGroup {
	BORDER-RIGHT: #999 1px solid; BORDER-TOP: #999 1px solid; FLOAT: left; BORDER-LEFT: #ccc 1px solid; WIDTH: 10em; BORDER-BOTTOM: #ccc 1px solid; POSITION: relative; HEIGHT: 20em; BACKGROUND-COLOR: #eee
}
.VTabbedPanels .TabbedPanelsTab {
	FLOAT: none; MARGIN: 0px; BORDER-TOP-STYLE: none; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none
}
.VTabbedPanels .TabbedPanelsTabSelected {
	BORDER-BOTTOM: #999 1px solid; BACKGROUND-COLOR: #eee
}
.VTabbedPanels .TabbedPanelsContentGroup {
	CLEAR: none; PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FLOAT: left; PADDING-BOTTOM: 0px; WIDTH: 30em; PADDING-TOP: 0px; HEIGHT: 20em
}

H1 {
	FONT-SIZE: 18px; PADDING-BOTTOM: 5px; MARGIN: 15px 0px 10px; COLOR: #326aa5; BORDER-BOTTOM: #ccc 1px solid
}
H2 {
	FONT-SIZE: 10px; PADDING-BOTTOM: 5px; MARGIN: 15px 0px 10px; COLOR: #326aa5; BORDER-BOTTOM: #ccc 1px solid
}
#fa

.style1 {font-size: 10px}
.style1 {
	font-size: 10px;
	color: #000000;
}


</style>


<script type="text/javascript">
/* SpryTabbedPanels.js - Revision: Spry Preview Release 1.4 */

// Copyright (c) 2006. Adobe Systems Incorporated.
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
//   * Redistributions of source code must retain the above copyright notice,
//     this list of conditions and the following disclaimer.
//   * Redistributions in binary form must reproduce the above copyright notice,
//     this list of conditions and the following disclaimer in the documentation
//     and/or other materials provided with the distribution.
//   * Neither the name of Adobe Systems Incorporated nor the names of its
//     contributors may be used to endorse or promote products derived from this
//     software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

var Spry;
if (!Spry) Spry = {};
if (!Spry.Widget) Spry.Widget = {};

Spry.Widget.TabbedPanels = function(element, opts)
{
	this.element = this.getElement(element);
	this.defaultTab = 0; // Show the first panel by default.
	this.bindings = [];
	this.tabSelectedClass = "TabbedPanelsTabSelected";
	this.tabHoverClass = "TabbedPanelsTabHover";
	this.tabFocusedClass = "TabbedPanelsTabFocused";
	this.panelVisibleClass = "TabbedPanelsContentVisible";
	this.focusElement = null;
	this.hasFocus = false;
	this.currentTabIndex = 0;
	this.enableKeyboardNavigation = true;

	Spry.Widget.TabbedPanels.setOptions(this, opts);

	// If the defaultTab is expressed as a number/index, convert
	// it to an element.

	if (typeof (this.defaultTab) == "number")
	{
		if (this.defaultTab < 0)
			this.defaultTab = 0;
		else
		{
			var count = this.getTabbedPanelCount();
			if (this.defaultTab >= count)
				this.defaultTab = (count > 1) ? (count - 1) : 0;
		}

		this.defaultTab = this.getTabs()[this.defaultTab];
	}

	// The defaultTab property is supposed to be the tab element for the tab content
	// to show by default. The caller is allowed to pass in the element itself or the
	// element's id, so we need to convert the current value to an element if necessary.

	if (this.defaultTab)
		this.defaultTab = this.getElement(this.defaultTab);

	this.attachBehaviors();
};

Spry.Widget.TabbedPanels.prototype.getElement = function(ele)
{
	if (ele && typeof ele == "string")
		return document.getElementById(ele);
	return ele;
}

Spry.Widget.TabbedPanels.prototype.getElementChildren = function(element)
{
	var children = [];
	var child = element.firstChild;
	while (child)
	{
		if (child.nodeType == 1 /* Node.ELEMENT_NODE */)
			children.push(child);
		child = child.nextSibling;
	}
	return children;
};

Spry.Widget.TabbedPanels.prototype.addClassName = function(ele, className)
{
	if (!ele || !className || (ele.className && ele.className.search(new RegExp("\\b" + className + "\\b")) != -1))
		return;
	ele.className += (ele.className ? " " : "") + className;
};

Spry.Widget.TabbedPanels.prototype.removeClassName = function(ele, className)
{
	if (!ele || !className || (ele.className && ele.className.search(new RegExp("\\b" + className + "\\b")) == -1))
		return;
	ele.className = ele.className.replace(new RegExp("\\s*\\b" + className + "\\b", "g"), "");
};

Spry.Widget.TabbedPanels.setOptions = function(obj, optionsObj, ignoreUndefinedProps)
{
	if (!optionsObj)
		return;
	for (var optionName in optionsObj)
	{
		if (ignoreUndefinedProps && optionsObj[optionName] == undefined)
			continue;
		obj[optionName] = optionsObj[optionName];
	}
};

Spry.Widget.TabbedPanels.prototype.getTabGroup = function()
{
	if (this.element)
	{
		var children = this.getElementChildren(this.element);
		if (children.length)
			return children[0];
	}
	return null;
};

Spry.Widget.TabbedPanels.prototype.getTabs = function()
{
	var tabs = [];
	var tg = this.getTabGroup();
	if (tg)
		tabs = this.getElementChildren(tg);
	return tabs;
};

Spry.Widget.TabbedPanels.prototype.getContentPanelGroup = function()
{
	if (this.element)
	{
		var children = this.getElementChildren(this.element);
		if (children.length > 1)
			return children[1];
	}
	return null;
};

Spry.Widget.TabbedPanels.prototype.getContentPanels = function()
{
	var panels = [];
	var pg = this.getContentPanelGroup();
	if (pg)
		panels = this.getElementChildren(pg);
	return panels;
};

Spry.Widget.TabbedPanels.prototype.getIndex = function(ele, arr)
{
	ele = this.getElement(ele);
	if (ele && arr && arr.length)
	{
		for (var i = 0; i < arr.length; i++)
		{
			if (ele == arr[i])
				return i;
		}
	}
	return -1;
};

Spry.Widget.TabbedPanels.prototype.getTabIndex = function(ele)
{
	var i = this.getIndex(ele, this.getTabs());
	if (i < 0)
		i = this.getIndex(ele, this.getContentPanels());
	return i;
};

Spry.Widget.TabbedPanels.prototype.getCurrentTabIndex = function()
{
	return this.currentTabIndex;
};

Spry.Widget.TabbedPanels.prototype.getTabbedPanelCount = function(ele)
{
	return Math.min(this.getTabs().length, this.getContentPanels().length);
};

Spry.Widget.TabbedPanels.addEventListener = function(element, eventType, handler, capture)
{
	try
	{
		if (element.addEventListener)
			element.addEventListener(eventType, handler, capture);
		else if (element.attachEvent)
			element.attachEvent("on" + eventType, handler);
	}
	catch (e) {}
};

Spry.Widget.TabbedPanels.prototype.onTabClick = function(e, tab)
{
	this.showPanel(tab);
};

Spry.Widget.TabbedPanels.prototype.onTabMouseOver = function(e, tab)
{
	this.addClassName(tab, this.tabHoverClass);
};

Spry.Widget.TabbedPanels.prototype.onTabMouseOut = function(e, tab)
{
	this.removeClassName(tab, this.tabHoverClass);
};

Spry.Widget.TabbedPanels.prototype.onTabFocus = function(e, tab)
{
	this.hasFocus = true;
	this.addClassName(this.element, this.tabFocusedClass);
};

Spry.Widget.TabbedPanels.prototype.onTabBlur = function(e, tab)
{
	this.hasFocus = false;
	this.removeClassName(this.element, this.tabFocusedClass);
};

Spry.Widget.TabbedPanels.ENTER_KEY = 13;
Spry.Widget.TabbedPanels.SPACE_KEY = 32;

Spry.Widget.TabbedPanels.prototype.onTabKeyDown = function(e, tab)
{
	var key = e.keyCode;
	if (!this.hasFocus || (key != Spry.Widget.TabbedPanels.ENTER_KEY && key != Spry.Widget.TabbedPanels.SPACE_KEY))
		return true;

	this.showPanel(tab);

	if (e.stopPropagation)
		e.stopPropagation();
	if (e.preventDefault)
		e.preventDefault();

	return false;
};

Spry.Widget.TabbedPanels.prototype.preorderTraversal = function(root, func)
{
	var stopTraversal = false;
	if (root)
	{
		stopTraversal = func(root);
		if (root.hasChildNodes())
		{
			var child = root.firstChild;
			while (!stopTraversal && child)
			{
				stopTraversal = this.preorderTraversal(child, func);
				try { child = child.nextSibling; } catch (e) { child = null; }
			}
		}
	}
	return stopTraversal;
};

Spry.Widget.TabbedPanels.prototype.addPanelEventListeners = function(tab, panel)
{
	var self = this;
	Spry.Widget.TabbedPanels.addEventListener(tab, "mouseover", function(e) { return self.onTabClick(e, tab); }, false);
	Spry.Widget.TabbedPanels.addEventListener(tab, "mouseover", function(e) { return self.onTabMouseOver(e, tab); }, false);
	Spry.Widget.TabbedPanels.addEventListener(tab, "mouseout", function(e) { return self.onTabMouseOut(e, tab); }, false);

	if (this.enableKeyboardNavigation)
	{
		// XXX: IE doesn't allow the setting of tabindex dynamically. This means we can't
		// rely on adding the tabindex attribute if it is missing to enable keyboard navigation
		// by default.

		// Find the first element within the tab container that has a tabindex or the first
		// anchor tag.
		
		var tabIndexEle = null;
		var tabAnchorEle = null;

		this.preorderTraversal(tab, function(node) {
			if (node.nodeType == 1 /* NODE.ELEMENT_NODE */)
			{
				var tabIndexAttr = tab.attributes.getNamedItem("tabindex");
				if (tabIndexAttr)
				{
					tabIndexEle = node;
					return true;
				}
				if (!tabAnchorEle && node.nodeName.toLowerCase() == "a")
					tabAnchorEle = node;
			}
			return false;
		});

		if (tabIndexEle)
			this.focusElement = tabIndexEle;
		else if (tabAnchorEle)
			this.focusElement = tabAnchorEle;

		if (this.focusElement)
		{
			Spry.Widget.TabbedPanels.addEventListener(this.focusElement, "focus", function(e) { return self.onTabFocus(e, tab); }, false);
			Spry.Widget.TabbedPanels.addEventListener(this.focusElement, "blur", function(e) { return self.onTabBlur(e, tab); }, false);
			Spry.Widget.TabbedPanels.addEventListener(this.focusElement, "keydown", function(e) { return self.onTabKeyDown(e, tab); }, false);
		}
	}
};

Spry.Widget.TabbedPanels.prototype.showPanel = function(elementOrIndex)
{
	var tpIndex = -1;
	
	if (typeof elementOrIndex == "number")
		tpIndex = elementOrIndex;
	else // Must be the element for the tab or content panel.
		tpIndex = this.getTabIndex(elementOrIndex);
	
	if (!tpIndex < 0 || tpIndex >= this.getTabbedPanelCount())
		return;

	var tabs = this.getTabs();
	var panels = this.getContentPanels();

	var numTabbedPanels = Math.max(tabs.length, panels.length);

	for (var i = 0; i < numTabbedPanels; i++)
	{
		if (i != tpIndex)
		{
			if (tabs[i])
				this.removeClassName(tabs[i], this.tabSelectedClass);
			if (panels[i])
			{
				this.removeClassName(panels[i], this.panelVisibleClass);
				panels[i].style.display = "none";
			}
		}
	}

	this.addClassName(tabs[tpIndex], this.tabSelectedClass);
	this.addClassName(panels[tpIndex], this.panelVisibleClass);
	panels[tpIndex].style.display = "block";

	this.currentTabIndex = tpIndex;
};

Spry.Widget.TabbedPanels.prototype.attachBehaviors = function(element)
{
	var tabs = this.getTabs();
	var panels = this.getContentPanels();
	var panelCount = this.getTabbedPanelCount();

	for (var i = 0; i < panelCount; i++)
		this.addPanelEventListeners(tabs[i], panels[i]);

	this.showPanel(this.defaultTab);
};

</script>

<script type="text/javascript">
<!--
function changebg(k) {
	for(i=1;i<=4;i++){
		if(i==k){
			getObject('ss'+i).className='other';
			getObject('find'+i).style.display='';
		}
		else{
			getObject('ss'+i).className='';
			getObject('find'+i).style.display='none';
		}
	}
}

function getObject(objectId) {
    if(document.getElementById && document.getElementById(objectId)) {
	// W3C DOM
	return document.getElementById(objectId);
    } else if (document.all && document.all(objectId)) {
	// MSIE 4 DOM
	return document.all(objectId);
 //   } else if (document.layers && document.layers[objectId]) {
	// NN 4 DOM.. note: this won't find nested layers
	//return document.layers[objectId];
    } else {
	return false;
    }	
}

//-->
</script>
<script language="JavaScript" type="text/javascript">
<!-- Copyright 2003, Sandeep Gangadharan -->
<!-- For more free scripts go to http://sivamdesign.com/scripts/ -->
<!--
var y1 = 20;   // change the # on the left to adjuct the Y co-ordinate
(document.getElementById) ? dom = true : dom = false;

function hideIt() {
  if (dom) {document.getElementById("divTopLeft").style.visibility='hidden';}
}
function hideIt2() {
  if (dom) {document.getElementById("divTopLeft2").style.visibility='hidden';}
}
function showIt() {
  if (dom) {document.getElementById("divTopLeft").style.visibility='visible';}
}

function placeIt() {
  if (dom && !document.all) {document.getElementById("divTopLeft").style.top = window.pageYOffset + (window.innerHeight - (window.innerHeight-y1)) + "px";}
  if (document.all) {document.all["divTopLeft"].style.top = document.documentElement.scrollTop + (document.documentElement.clientHeight - (document.documentElement.clientHeight-y1)) + "px";}
  window.setTimeout("placeIt()", 10); }
// -->
</script>



<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"></HEAD>

<!--<body class=body OnLoad="window.open('http://www.ump.edu.my/', 'Pengumuman', 'toolbar=0, location=0, directories=0, menuBar=0, scrollbars=1, resizable=0, width=530, height=500')">-->



<!--body background="template/default/image2_files/top.png"-->
<body>
<jsp:useBean class="cms.staff.StaffValidator" id="cmsStaffValidatorHR" scope="page"/>

<!--%

	Connection conn=null;
	String staffid = (String)session.getAttribute("staffid");
	
	try
	{
		Context initCtx = new InitialContext();
	    Context envCtx  = (Context) initCtx.lookup( "java:comp/env" );
    	DataSource ds   = (DataSource)envCtx.lookup( "jdbc/cmsdb" );
    	conn = ds.getConnection();

    	cmsStaffValidatorHR.setDBConnection(conn);
    	cmsStaffValidatorHR.setStaffId(staffid);
    	boolean staffProfile = cmsStaffValidatorHR.isStaffProfile();
		boolean staffSpouse = cmsStaffValidatorHR.isSpouseProfile();
		boolean qualification = cmsStaffValidatorHR.isQualification();


    	if(staffProfile == true || staffSpouse == true || qualification == true)

    	{

%>
<div id="divTopLeft" style="position:absolute; width: 525px; height: 252px; left: 50px; top: 300px;"> 
<span style="float:canter; background-color:gray; color:white; text-decoration:none; font-weight:bold; width='8px'; text-align:center; cursor:pointer" onClick="javascript:hideIt()" title="Close"> 
&nbsp;&nbsp;Close&nbsp;&nbsp;</span> 
<table width="50%" border="0" cellspacing="1">
  <tr>
    <th width="520" height="257" scope="row"><img src="images/system/staff3.gif" width="520" height="257" border="0" usemap="#Map"></th>
  </tr>
</table>
<map name="Map">
  <area shape="rect" coords="182,99,500,123" href="StaffProfile.jsp?action=ViewEditStaff1" alt="Personal Detail">
  <area shape="rect" coords="163,124,500,146" href="StaffProfile.jsp?action=viewEditSpouse" alt="Spouse Information">
  <area shape="rect" coords="136,145,499,172" href="expertise.jsp" alt="Qualification Information">
</map>

</div>
<!-%

    	}
	}
	catch(Exception e)
	{
		System.out.println("Error Checking Staff Profile:"+e);
	}
	finally
	{
		conn.close();
	}

% -->
<!-- announcement HRMIS -->
<!--div id="divTopLeft2" style="position:absolute; width: 525px; height: 450px; left: 150px; top: 340px;"> 
<span style="float:center; background-color:red; color:white; text-decoration:none; font-weight:bold; width='20px'; text-align:center; cursor:pointer" onClick="javascript:hideIt2()" title="Close"> 
&nbsp;&nbsp;<font size="+1">Close&nbsp;&nbsp;</font></span> 
<table width="50%" border="0" cellspacing="1">
  <tr>
    <th width="520" height="257" scope="row"><IFRAME bgcolor="B3D4EB" framespacing="0" marginheight="0" marginwidth="0" src="umum3.htm" width=680  height=525 scrolling="no" vspale="0" frameborder="0"></IFRAME></th>
  </tr>
</table>

</div>
<!-- end announce HRMIS -->
<p></p>
<p></p>


<!--<marquee onMouseOver="this.setAttribute('scrollamount', 0, 0);" onMouseOut="this.setAttribute('scrollamount', 6, 0);">-->



<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>
	
  <H1>&nbsp;&nbsp;&nbsp;Announcement Board&nbsp;<a href="announcement.jsp?action=add"><img src="images/add.gif" width="16" height="16" alt="Add Announcement"></a></H1>
  <!--  <H2>Use announcements for effective communication and reminders.</H2>-->
    <link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/announcement/style.css" rel="stylesheet">
  <div class="row">
                    <div class="col-lg-12">
					     <div>
                           
                            <div class="portlet-body">
                            	<div class="btn-group btn-group-justified">
                                    <a href="?act=official" class="<% if (request.getParameter("act") == null || (request.getParameter("act")!=null && request.getParameter("act").equals("official"))){%>btn btn-default<%}else {%>btn btn-white<%}%>" role="button"><font color="<% if (request.getParameter("act") == null || (request.getParameter("act")!=null && request.getParameter("act").equals("official"))){%>#FFFFFF<%}else {%>#000000<%}%>">OFFICIAL</font></a>
                                    <a href="?act=unofficial" class="<% if (request.getParameter("act")!=null && request.getParameter("act").equals("unofficial")){%>btn btn-default<%}else {%>btn btn-white<%}%>" role="button"><font color="<% if (request.getParameter("act")!=null && request.getParameter("act").equals("unofficial")){%>#FFFFFF<%}else {%>#000000<%}%>">UNOFFICIAL</font></a>
                                    <a href="?act=training" class="<% if (request.getParameter("act")!=null && request.getParameter("act").equals("training")){%>btn btn-default<%}else {%>btn btn-white<%}%>" role="button"><font color="<% if (request.getParameter("act")!=null && request.getParameter("act").equals("training")){%>#FFFFFF<%}else {%>#000000<%}%>">TRAINING</font></a>
                                    <a href="?act=mpp" class="<% if (request.getParameter("act")!=null && request.getParameter("act").equals("mpp")){%>btn btn-default<%}else {%>btn btn-white<%}%>" role="button"><font color="<% if (request.getParameter("act")!=null && request.getParameter("act").equals("mpp")){%>#FFFFFF<%}else {%>#000000<%}%>">MPP</font></a>
                                    <a href="?act=newstaff" class="<% if (request.getParameter("act")!=null && request.getParameter("act").equals("newstaff")){%>btn btn-default<%}else {%>btn btn-white<%}%>" role="button"><font color="<% if (request.getParameter("act")!=null && request.getParameter("act").equals("newstaff")){%>#FFFFFF<%}else {%>#000000<%}%>">NEW STAFF</font></a>
                                     <a href="?act=newappt" class="<% if (request.getParameter("act")!=null && request.getParameter("act").equals("newappt")){%>btn btn-default<%}else {%>btn btn-white<%}%>" role="button"><font color="<% if (request.getParameter("act")!=null && request.getParameter("act").equals("newappt")){%>#FFFFFF<%}else {%>#000000<%}%>">NEW APPOINTMENT</font></a>
                                    <a href="?act=birthday" class="<% if (request.getParameter("act")!=null && request.getParameter("act").equals("birthday")){%>btn btn-default<%}else {%>btn btn-white<%}%>" role="button"><font color="<% if (request.getParameter("act")!=null && request.getParameter("act").equals("birthday")){%>#FFFFFF<%}else {%>#000000<%}%>">E-BIRTHDAY GREETING</font></a>
                                   </div>
                              <br>
                            </div>
                       
                        </div>
                      
                    </div>
                   
                </div>

<DIV class="TabbedPanelsContentGroup"></DIV>

<% if (request.getParameter("act") == null || (request.getParameter("act")!=null && request.getParameter("act").equals("official"))){%>

<DIV class="TabbedPanelsContent">

  
  <IFRAME bgcolor="B3D4EB" framespacing="0" marginheight="0" marginwidth="0" src="cms/announcement/call2.jsp?action=Y" 
				width="98%"  height="400" scrolling="auto" vspale="0" frameborder="0"></IFRAME>
  </DIV>
<%}else if (request.getParameter("act")!=null && request.getParameter("act").equals("unofficial")){%>

<DIV class="TabbedPanelsContent">

<IFRAME framespacing="0" marginheight="0" marginwidth="0" src="cms/announcement/call2.jsp?action=N" 
				width="98%"  height="400" scrolling="auto" vspale="0" frameborder="0"></IFRAME>
</DIV>
<%}else if (request.getParameter("act")!=null && request.getParameter("act").equals("training")){%>

<DIV class="TabbedPanelsContent">

<IFRAME framespacing="0" marginheight="0" marginwidth="0" src="cms/training_internal/form/kursus_all_announcement.jsp" 
				width="98%"  height="400" scrolling="auto" vspale="0" frameborder="0"></IFRAME>


</DIV>
<%}else if (request.getParameter("act")!=null && request.getParameter("act").equals("mpp")){%>


<DIV class="TabbedPanelsContent">

<IFRAME framespacing="0" marginheight="0" marginwidth="0" src="cms/announcement/call2.jsp?action=MP" 
				width="98%"  height="400" scrolling="auto" vspale="0" frameborder="0"></IFRAME>
</DIV>

<%}else if (request.getParameter("act")!=null && request.getParameter("act").equals("newappt")){%>

<DIV class="TabbedPanelsContent">

 <IFRAME framespacing="0" marginheight="0" marginwidth="0" src="cms/announcement/newappt.jsp" 
				width=98%  height=400 scrolling="auto" vspale="0" frameborder="0"></IFRAME>
</DIV>
<%}else if (request.getParameter("act")!=null && request.getParameter("act").equals("newstaff")){%>

<DIV class="TabbedPanelsContent">

 <IFRAME framespacing="0" marginheight="0" marginwidth="0" src="cms/announcement/newstaff.jsp" 
				width=98%  height=400 scrolling="auto" vspale="0" frameborder="0"></IFRAME>
</DIV>

<%}else if (request.getParameter("act")!=null && request.getParameter("act").equals("birthday")){%>

<DIV class=TabbedPanelsContent>

 <IFRAME framespacing="0" marginheight="0" marginwidth="0" src="cms/announcement/birthdaystaff.jsp" 
				width=98%  height=400 scrolling="auto" vspale="0" frameborder="0"></IFRAME>
</DIV>

<%}%>

<!--<DIV class=TabbedPanelsContent>

 <IFRAME framespacing="0" marginheight="0" marginwidth="0" src="cms/announcement/book.jsp" 
				width=98%  height=400 scrolling="auto" vspale="0" frameborder="0"></IFRAME>
</DIV>-->



<!--/DIV></DIV></DIV-->

<!--SCRIPT type=text/javascript>
    <!--
    var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1");
    //-->
<!--SCRIPT--></td>
  </tr>
 
</table>


</body>