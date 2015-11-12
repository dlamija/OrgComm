<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>UMP Books</title>



<script type="text/javascript">
/*==================================================
  $Id: tabber.js,v 1.9 2006/04/27 20:51:51 pat Exp $
  tabber.js by Patrick Fitzgerald pat@barelyfitz.com

  Documentation can be found at the following URL:
  http://www.barelyfitz.com/projects/tabber/

  License (http://www.opensource.org/licenses/mit-license.php)

  Copyright (c) 2006 Patrick Fitzgerald

  Permission is hereby granted, free of charge, to any person
  obtaining a copy of this software and associated documentation files
  (the "Software"), to deal in the Software without restriction,
  including without limitation the rights to use, copy, modify, merge,
  publish, distribute, sublicense, and/or sell copies of the Software,
  and to permit persons to whom the Software is furnished to do so,
  subject to the following conditions:

  The above copyright notice and this permission notice shall be
  included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
  ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
  ==================================================*/

function tabberObj(argsObj)
{
  var arg; /* name of an argument to override */

  /* Element for the main tabber div. If you supply this in argsObj,
     then the init() method will be called.
  */
  this.div = null;

  /* Class of the main tabber div */
  this.classMain = "tabber";

  /* Rename classMain to classMainLive after tabifying
     (so a different style can be applied)
  */
  this.classMainLive = "tabberlive";

  /* Class of each DIV that contains a tab */
  this.classTab = "tabbertab";

  /* Class to indicate which tab should be active on startup */
  this.classTabDefault = "tabbertabdefault";

  /* Class for the navigation UL */
  this.classNav = "tabbernav";

  /* When a tab is to be hidden, instead of setting display='none', we
     set the class of the div to classTabHide. In your screen
     stylesheet you should set classTabHide to display:none.  In your
     print stylesheet you should set display:block to ensure that all
     the information is printed.
  */
  this.classTabHide = "tabbertabhide";

  /* Class to set the navigation LI when the tab is active, so you can
     use a different style on the active tab.
  */
  this.classNavActive = "tabberactive";

  /* Elements that might contain the title for the tab, only used if a
     title is not specified in the TITLE attribute of DIV classTab.
  */
  this.titleElements = ['h2','h3','h4','h5','h6'];

  /* Should we strip out the HTML from the innerHTML of the title elements?
     This should usually be true.
  */
  this.titleElementsStripHTML = true;

  /* If the user specified the tab names using a TITLE attribute on
     the DIV, then the browser will display a tooltip whenever the
     mouse is over the DIV. To prevent this tooltip, we can remove the
     TITLE attribute after getting the tab name.
  */
  this.removeTitle = true;

  /* If you want to add an id to each link set this to true */
  this.addLinkId = false;

  /* If addIds==true, then you can set a format for the ids.
     <tabberid> will be replaced with the id of the main tabber div.
     <tabnumberzero> will be replaced with the tab number
       (tab numbers starting at zero)
     <tabnumberone> will be replaced with the tab number
       (tab numbers starting at one)
     <tabtitle> will be replaced by the tab title
       (with all non-alphanumeric characters removed)
   */
  this.linkIdFormat = '<tabberid>nav<tabnumberone>';

  /* You can override the defaults listed above by passing in an object:
     var mytab = new tabber({property:value,property:value});
  */
  for (arg in argsObj) { this[arg] = argsObj[arg]; }

  /* Create regular expressions for the class names; Note: if you
     change the class names after a new object is created you must
     also change these regular expressions.
  */
  this.REclassMain = new RegExp('\\b' + this.classMain + '\\b', 'gi');
  this.REclassMainLive = new RegExp('\\b' + this.classMainLive + '\\b', 'gi');
  this.REclassTab = new RegExp('\\b' + this.classTab + '\\b', 'gi');
  this.REclassTabDefault = new RegExp('\\b' + this.classTabDefault + '\\b', 'gi');
  this.REclassTabHide = new RegExp('\\b' + this.classTabHide + '\\b', 'gi');

  /* Array of objects holding info about each tab */
  this.tabs = new Array();

  /* If the main tabber div was specified, call init() now */
  if (this.div) {

    this.init(this.div);

    /* We don't need the main div anymore, and to prevent a memory leak
       in IE, we must remove the circular reference between the div
       and the tabber object. */
    this.div = null;
  }
}


/*--------------------------------------------------
  Methods for tabberObj
  --------------------------------------------------*/


tabberObj.prototype.init = function(e)
{
  /* Set up the tabber interface.

     e = element (the main containing div)

     Example:
     init(document.getElementById('mytabberdiv'))
   */

  var
  childNodes, /* child nodes of the tabber div */
  i, i2, /* loop indices */
  t, /* object to store info about a single tab */
  defaultTab=0, /* which tab to select by default */
  DOM_ul, /* tabbernav list */
  DOM_li, /* tabbernav list item */
  DOM_a, /* tabbernav link */
  aId, /* A unique id for DOM_a */
  headingElement; /* searching for text to use in the tab */

  /* Verify that the browser supports DOM scripting */
  if (!document.getElementsByTagName) { return false; }

  /* If the main DIV has an ID then save it. */
  if (e.id) {
    this.id = e.id;
  }

  /* Clear the tabs array (but it should normally be empty) */
  this.tabs.length = 0;

  /* Loop through an array of all the child nodes within our tabber element. */
  childNodes = e.childNodes;
  for(i=0; i < childNodes.length; i++) {

    /* Find the nodes where class="tabbertab" */
    if(childNodes[i].className &&
       childNodes[i].className.match(this.REclassTab)) {
      
      /* Create a new object to save info about this tab */
      t = new Object();
      
      /* Save a pointer to the div for this tab */
      t.div = childNodes[i];
      
      /* Add the new object to the array of tabs */
      this.tabs[this.tabs.length] = t;

      /* If the class name contains classTabDefault,
	 then select this tab by default.
      */
      if (childNodes[i].className.match(this.REclassTabDefault)) {
	defaultTab = this.tabs.length-1;
      }
    }
  }

  /* Create a new UL list to hold the tab headings */
  DOM_ul = document.createElement("ul");
  DOM_ul.className = this.classNav;
  
  /* Loop through each tab we found */
  for (i=0; i < this.tabs.length; i++) {

    t = this.tabs[i];

    /* Get the label to use for this tab:
       From the title attribute on the DIV,
       Or from one of the this.titleElements[] elements,
       Or use an automatically generated number.
     */
    t.headingText = t.div.title;

    /* Remove the title attribute to prevent a tooltip from appearing */
    if (this.removeTitle) { t.div.title = ''; }

    if (!t.headingText) {

      /* Title was not defined in the title of the DIV,
	 So try to get the title from an element within the DIV.
	 Go through the list of elements in this.titleElements
	 (typically heading elements ['h2','h3','h4'])
      */
      for (i2=0; i2<this.titleElements.length; i2++) {
	headingElement = t.div.getElementsByTagName(this.titleElements[i2])[0];
	if (headingElement) {
	  t.headingText = headingElement.innerHTML;
	  if (this.titleElementsStripHTML) {
	    t.headingText.replace(/<br>/gi," ");
	    t.headingText = t.headingText.replace(/<[^>]+>/g,"");
	  }
	  break;
	}
      }
    }

    if (!t.headingText) {
      /* Title was not found (or is blank) so automatically generate a
         number for the tab.
      */
      t.headingText = i + 1;
    }

    /* Create a list element for the tab */
    DOM_li = document.createElement("li");

    /* Save a reference to this list item so we can later change it to
       the "active" class */
    t.li = DOM_li;

    /* Create a link to activate the tab */
    DOM_a = document.createElement("a");
    DOM_a.appendChild(document.createTextNode(t.headingText));
    DOM_a.href = "javascript:void(null);";
    DOM_a.title = t.headingText;
    DOM_a.onclick = this.navClick;

    /* Add some properties to the link so we can identify which tab
       was clicked. Later the navClick method will need this.
    */
    DOM_a.tabber = this;
    DOM_a.tabberIndex = i;

    /* Do we need to add an id to DOM_a? */
    if (this.addLinkId && this.linkIdFormat) {

      /* Determine the id name */
      aId = this.linkIdFormat;
      aId = aId.replace(/<tabberid>/gi, this.id);
      aId = aId.replace(/<tabnumberzero>/gi, i);
      aId = aId.replace(/<tabnumberone>/gi, i+1);
      aId = aId.replace(/<tabtitle>/gi, t.headingText.replace(/[^a-zA-Z0-9\-]/gi, ''));

      DOM_a.id = aId;
    }

    /* Add the link to the list element */
    DOM_li.appendChild(DOM_a);

    /* Add the list element to the list */
    DOM_ul.appendChild(DOM_li);
  }

  /* Add the UL list to the beginning of the tabber div */
  e.insertBefore(DOM_ul, e.firstChild);

  /* Make the tabber div "live" so different CSS can be applied */
  e.className = e.className.replace(this.REclassMain, this.classMainLive);

  /* Activate the default tab, and do not call the onclick handler */
  this.tabShow(defaultTab);

  /* If the user specified an onLoad function, call it now. */
  if (typeof this.onLoad == 'function') {
    this.onLoad({tabber:this});
  }

  return this;
};


tabberObj.prototype.navClick = function(event)
{
  /* This method should only be called by the onClick event of an <A>
     element, in which case we will determine which tab was clicked by
     examining a property that we previously attached to the <A>
     element.

     Since this was triggered from an onClick event, the variable
     "this" refers to the <A> element that triggered the onClick
     event (and not to the tabberObj).

     When tabberObj was initialized, we added some extra properties
     to the <A> element, for the purpose of retrieving them now. Get
     the tabberObj object, plus the tab number that was clicked.
  */

  var
  rVal, /* Return value from the user onclick function */
  a, /* element that triggered the onclick event */
  self, /* the tabber object */
  tabberIndex, /* index of the tab that triggered the event */
  onClickArgs; /* args to send the onclick function */

  a = this;
  if (!a.tabber) { return false; }

  self = a.tabber;
  tabberIndex = a.tabberIndex;

  /* Remove focus from the link because it looks ugly.
     I don't know if this is a good idea...
  */
  a.blur();

  /* If the user specified an onClick function, call it now.
     If the function returns false then do not continue.
  */
  if (typeof self.onClick == 'function') {

    onClickArgs = {'tabber':self, 'index':tabberIndex, 'event':event};

    /* IE uses a different way to access the event object */
    if (!event) { onClickArgs.event = window.event; }

    rVal = self.onClick(onClickArgs);
    if (rVal === false) { return false; }
  }

  self.tabShow(tabberIndex);

  return false;
};


tabberObj.prototype.tabHideAll = function()
{
  var i; /* counter */

  /* Hide all tabs and make all navigation links inactive */
  for (i = 0; i < this.tabs.length; i++) {
    this.tabHide(i);
  }
};


tabberObj.prototype.tabHide = function(tabberIndex)
{
  var div;

  if (!this.tabs[tabberIndex]) { return false; }

  /* Hide a single tab and make its navigation link inactive */
  div = this.tabs[tabberIndex].div;

  /* Hide the tab contents by adding classTabHide to the div */
  if (!div.className.match(this.REclassTabHide)) {
    div.className += ' ' + this.classTabHide;
  }
  this.navClearActive(tabberIndex);

  return this;
};


tabberObj.prototype.tabShow = function(tabberIndex)
{
  /* Show the tabberIndex tab and hide all the other tabs */

  var div;

  if (!this.tabs[tabberIndex]) { return false; }

  /* Hide all the tabs first */
  this.tabHideAll();

  /* Get the div that holds this tab */
  div = this.tabs[tabberIndex].div;

  /* Remove classTabHide from the div */
  div.className = div.className.replace(this.REclassTabHide, '');

  /* Mark this tab navigation link as "active" */
  this.navSetActive(tabberIndex);

  /* If the user specified an onTabDisplay function, call it now. */
  if (typeof this.onTabDisplay == 'function') {
    this.onTabDisplay({'tabber':this, 'index':tabberIndex});
  }

  return this;
};

tabberObj.prototype.navSetActive = function(tabberIndex)
{
  /* Note: this method does *not* enforce the rule
     that only one nav item can be active at a time.
  */

  /* Set classNavActive for the navigation list item */
  this.tabs[tabberIndex].li.className = this.classNavActive;

  return this;
};


tabberObj.prototype.navClearActive = function(tabberIndex)
{
  /* Note: this method does *not* enforce the rule
     that one nav should always be active.
  */

  /* Remove classNavActive from the navigation list item */
  this.tabs[tabberIndex].li.className = '';

  return this;
};


/*==================================================*/


function tabberAutomatic(tabberArgs)
{
  /* This function finds all DIV elements in the document where
     class=tabber.classMain, then converts them to use the tabber
     interface.

     tabberArgs = an object to send to "new tabber()"
  */
  var
    tempObj, /* Temporary tabber object */
    divs, /* Array of all divs on the page */
    i; /* Loop index */

  if (!tabberArgs) { tabberArgs = {}; }

  /* Create a tabber object so we can get the value of classMain */
  tempObj = new tabberObj(tabberArgs);

  /* Find all DIV elements in the document that have class=tabber */

  /* First get an array of all DIV elements and loop through them */
  divs = document.getElementsByTagName("div");
  for (i=0; i < divs.length; i++) {
    
    /* Is this DIV the correct class? */
    if (divs[i].className &&
	divs[i].className.match(tempObj.REclassMain)) {
      
      /* Now tabify the DIV */
      tabberArgs.div = divs[i];
      divs[i].tabber = new tabberObj(tabberArgs);
    }
  }
  
  return this;
}


/*==================================================*/


function tabberAutomaticOnLoad(tabberArgs)
{
  /* This function adds tabberAutomatic to the window.onload event,
     so it will run after the document has finished loading.
  */
  var oldOnLoad;

  if (!tabberArgs) { tabberArgs = {}; }

  /* Taken from: http://simon.incutio.com/archive/2004/05/26/addLoadEvent */

  oldOnLoad = window.onload;
  if (typeof window.onload != 'function') {
    window.onload = function() {
      tabberAutomatic(tabberArgs);
    };
  } else {
    window.onload = function() {
      oldOnLoad();
      tabberAutomatic(tabberArgs);
    };
  }
}


/*==================================================*/


/* Run tabberAutomaticOnload() unless the "manualStartup" option was specified */

if (typeof tabberOptions == 'undefined') {

    tabberAutomaticOnLoad();

} else {

  if (!tabberOptions['manualStartup']) {
    tabberAutomaticOnLoad(tabberOptions);
  }

}

</script>

<script type="text/javascript">

/* Optional: Temporarily hide the "tabber" class so it does not "flash"
   on the page as plain HTML. After tabber runs, the class is changed
   to "tabberlive" and it will appear. */

document.write('<style type="text/css">.tabber{display:none;}<\/style>');
</script>

<style type="text/css">
/* $Id: example.css,v 1.5 2006/03/27 02:44:36 pat Exp $ */

/*--------------------------------------------------
  REQUIRED to hide the non-active tab content.
  But do not hide them in the print stylesheet!
  --------------------------------------------------*/
.tabberlive .tabbertabhide {
 display:none;
}

/*--------------------------------------------------
  .tabber = before the tabber interface is set up
  .tabberlive = after the tabber interface is set up
  --------------------------------------------------*/
.tabber {
}
.tabberlive {
 margin-top:1em;
}

/*--------------------------------------------------
  ul.tabbernav = the tab navigation list
  li.tabberactive = the active tab
  --------------------------------------------------*/
ul.tabbernav
{
 margin:0;
 padding: 3px 0;
 border-bottom: 1px solid #778;
 font: bold 12px Verdana, sans-serif;
}

ul.tabbernav li
{
 list-style: none;
 margin: 0;
 display: inline;
}

ul.tabbernav li a
{
 padding: 3px 0.5em;
 margin-left: 3px;
 border: 1px solid #778;
 border-bottom: none;
 background: #DDE;
 text-decoration: none;
}

ul.tabbernav li a:link { color: #448; }
ul.tabbernav li a:visited { color: #667; }

ul.tabbernav li a:hover
{
 color: #000;
 background: #AAE;
 border-color: #227;
}

ul.tabbernav li.tabberactive a
{
 background-color: #fff;
 border-bottom: 1px solid #fff;
}

ul.tabbernav li.tabberactive a:hover
{
 color: #000;
 background: white;
 border-bottom: 1px solid white;
}

/*--------------------------------------------------
  .tabbertab = the tab content
  Add style only after the tabber interface is set up (.tabberlive)
  --------------------------------------------------*/
.tabberlive .tabbertab {
 padding:5px;
 border:1px solid #aaa;
 border-top:0;

 /* If you don't want the tab size changing whenever a tab is changed
    you can set a fixed height */

 /* height:200px; */

 /* If you set a fix height set overflow to auto and you will get a
    scrollbar when necessary */

 /* overflow:auto; */
}

/* If desired, hide the heading since a heading is provided by the tab */
.tabberlive .tabbertab h2 {
 display:none;
}
.tabberlive .tabbertab h3 {
 display:none;
}

/* Example of using an ID to set different styles for the tabs on the page */
.tabberlive#tab1 {
}
.tabberlive#tab2 {
}
.tabberlive#tab2 .tabbertab {
 height:200px;
 overflow:auto;
}

<!--
.style10 {color: #FF0000}
.style12 {font-family: Arial, Helvetica, sans-serif; font-size: 14px; font-weight: bold; }
.style13 {font-family: Arial, Helvetica, sans-serif; font-size: 16px; font-weight: bold; }
.style15 {color: #000099}
.style16 {color: #009900}
.style1 {	font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
}
.style17 {
	color: #0000FF;
	font-weight: bold;
}
.style2 {font-family: Arial, Helvetica, sans-serif; font-size: 11px; font-weight: bold; }
.style6 {	font-family: Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight: bold;
	color: #FF6600;
}
.style7 {	font-family: Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight: bold;
	color: #660099;
}
.style20 {font-family: Arial, Helvetica, sans-serif; font-size: 11px; font-weight: bold; color: #000000; }
.style21 {font-family: Arial, Helvetica, sans-serif; font-size: 14px; font-weight: bold; color: #000000; }
.style25 {color: #000000; font-weight: bold;}
.tabber .tabbertab table tr .style2 {
	text-align: center;
}
-->
</style>
</head>
<body>

<p align="center" class="style13"><img src="http://community.ump.edu.my/ecommstaff/images/promoumpbooks.png" width="600" height="180"></p>
<!--<p align="center" class="style13">BUKU-BUKU TERBITAN <span class="style10">TERKINI</span> UMP<br />
    <span class="style16">PENERBIT UMP</span> (<span class="style15">UMP BOOKS</span>)</p>
<p align="center"><span class="style12">Buku-buku dijual dengan  potongan harga <span class="style10">10% - 40%</span> mengikut kuantiti yg ingin dibeli.</span></p>-->
<div align="center"></div>
<h1 align="center">&nbsp;</h1>
<div class="tabber">
  <div class="tabbertab">
  <h2>2010</h2>
	  <p align="center"><span class="style21">BOOKS</span></p>
	  <table width="100%%" border="1" cellpadding="3" cellspacing="0">
        <tr>
          <td width="3%" bgcolor="#99CCFF" class="style20">NO.</td>
          <td width="69%" bgcolor="#99CCFF" class="style20"><div align="left">TITLE</div></td>
          <td width="9%" bgcolor="#99CCFF" class="style20"><div align="center">LANGUAGE</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">1.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="398">
            <tr height="38">
              <td height="22" width="99">Title</td>
              <td width="16" height="22">:</td>
              <td width="381" height="22"><strong>Assessment Of Direct Writing In    Malaysian Secondary Schools</strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="398">Normah Othman</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="398">978-967-5080-79-1</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="398">RM 35.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="398">222</td>
            </tr>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">2.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="398">
            <tr height="22">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="398"><strong>Compressibility Behavior Of    Tropical Peat Vol. 1</strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="398">Youventharan Duraisamy</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="398">978-967-5080-82-1</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="398">RM 51.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="398">128</td>
            </tr>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">3.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="398">
            <tr height="22">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="398"><strong>Compressibility Behavior Of    Tropical Peat Vol. 2</strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="398">Youventharan Duraisamy</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="398">978-967-5080-84-5</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="398">RM 51.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="398">120</td>
            </tr>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">4.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="398">
            <tr height="22">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="398"><strong>Database System</strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="398">Abdullah Embong</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="398">978-967-5080-40-1</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="398">RM 60.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="398">370</td>
            </tr>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">5.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="398">
            <TR height="38">
              <TD width="99" height="22">Title</TD>
              <TD width="16" height="22">:</TD>
              <TD width="398" height="22"><STRONG>Isu-isu Negara   Bangsa Abad Ke-21</STRONG><STRONG><BR>
              </STRONG></TD>
            </TR>
            <TR height="22">
              <TD height="22">Author</TD>
              <TD>:</TD>
              <TD>Hasnah Hussin</TD>
            </TR>
            <TR height="22">
              <TD height="22">No ISBN</TD>
              <TD>:</TD>
              <TD>978-967-5080-78-4 (2010)</TD>
            </TR>
            <TR height="22">
              <TD height="22">Price</TD>
              <TD>:</TD>
              <TD>RM 33.00</TD>
            </TR>
            <TR height="23">
              <TD height="23">Pages</TD>
              <TD>:</TD>
              <TD>100</TD>
            </TR>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">Malay</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">6.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="398">
            <TR height="22">
              <TD width="99" height="22">Title</TD>
              <TD width="16">:</TD>
              <TD width="398"><STRONG>Sejarah, Isu dan   Dimensi</STRONG><STRONG><BR>
              </STRONG></TD>
            </TR>
            <TR height="22">
              <TD height="22">Author</TD>
              <TD>:</TD>
              <TD>Hasnah Hussin</TD>
            </TR>
            <TR height="22">
              <TD height="22">No ISBN</TD>
              <TD>:</TD>
              <TD>978-967-5080-55-5 (2010)</TD>
            </TR>
            <TR height="22">
              <TD height="22">Price</TD>
              <TD>:</TD>
              <TD>RM 35.00</TD>
            </TR>
            <TR height="23">
              <TD height="23">Pages</TD>
              <TD>:</TD>
              <TD>125</TD>
            </TR>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">Malay</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">7.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="398">
            <TR height="22">
              <TD width="99" height="22">Title</TD>
              <TD width="16">:</TD>
              <TD width="398"><STRONG>Professorial Lecture :   Alternative for Tomorrow Core Delelopment in The Near   Future</STRONG><STRONG><BR>
              </STRONG></TD>
            </TR>
            <TR height="22">
              <TD height="22">Author</TD>
              <TD>:</TD>
              <TD>Rosli Abu Bakar</TD>
            </TR>
            <TR height="22">
              <TD height="22">No ISBN</TD>
              <TD>:</TD>
              <TD>978-967-5080-84-2 (2010)</TD>
            </TR>
            <TR height="22">
              <TD height="22">Price</TD>
              <TD>:</TD>
              <TD>RM 30.00</TD>
            </TR>
            <TR height="23">
              <TD height="23">Pages</TD>
              <TD>:</TD>
              <TD>58</TD>
            </TR>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">8.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="398">
            <TR height="22">
              <TD width="99" height="22">Title</TD>
              <TD width="16">:</TD>
              <TD width="398"><STRONG>Joomla   Berinternet</STRONG><STRONG><BR>
              </STRONG></TD>
            </TR>
            <TR height="22">
              <TD height="22">Author</TD>
              <TD>:</TD>
              <TD>Wan Azlee Wan Abdullah</TD>
            </TR>
            <TR height="22">
              <TD height="22">No ISBN</TD>
              <TD>:</TD>
              <TD>&nbsp;978-967-5080-92-0 (2010)</TD>
            </TR>
            <TR height="22">
              <TD height="22">Price</TD>
              <TD>:</TD>
              <TD>&nbsp;RM 35.00</TD>
            </TR>
            <TR height="23">
              <TD height="23">Pages</TD>
              <TD>:</TD>
              <TD>&nbsp;147</TD>
            </TR>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">Malay</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">9.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="398">
            <TR height="38">
              <TD width="99" height="22">Title</TD>
              <TD width="16" height="22">:</TD>
              <TD width="398" height="22"><DIV><STRONG><strong><SPAN lang="EN-US" gothic="gothic">Handbook For Establishing Electronis   Systems</SPAN></strong></STRONG></DIV>
                <DIV><STRONG><strong><SPAN lang="EN-US" gothic="gothic">In Organization</SPAN></strong></STRONG> <STRONG><BR>
                </STRONG></DIV></TD>
            </TR>
            <TR height="22">
              <TD height="22"><DIV>Author</DIV></TD>
              <TD>:</TD>
              <TD><DIV><SPAN lang="EN-US" gothic="gothic">Wan Maseri,   Ahmed N. Abdalla, Ahmad Othman &amp;</SPAN></DIV>
                <DIV><SPAN lang="EN-US" gothic="gothic">Liu   Yao</SPAN></DIV></TD>
            </TR>
            <TR height="22">
              <TD height="22"><DIV>No ISBN</DIV></TD>
              <TD>:</TD>
              <TD><SPAN lang="EN-US" gothic="gothic">978-967-5080-69-2 (2010)</SPAN></TD>
            </TR>
            <TR height="22">
              <TD height="22">Price</TD>
              <TD>:</TD>
              <TD>RM 45.00</TD>
            </TR>
            <TR height="23">
              <TD height="23">Pages</TD>
              <TD>:</TD>
              <TD>112</TD>
            </TR>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">10.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="398">
            <TR height="22">
              <TD width="99" height="22">Title</TD>
              <TD width="16">:</TD>
              <TD width="398"><STRONG>
                <p><strong><SPAN lang="EN-US">Human Capital Development : National   &amp; Organizational </SPAN></strong><strong><SPAN lang="EN-US">Perspectives<BR>
                </SPAN></strong></p>
              </STRONG></TD>
            </TR>
            <TR height="22">
              <TD height="22">Author</TD>
              <TD>:</TD>
              <TD>Normah Othman, Ahmad Othman, Abdullah Ibrahim &amp; Mohd Ridzuan Nordin</TD>
            </TR>
            <TR height="22">
              <TD height="22">No ISBN</TD>
              <TD>:</TD>
              <TD>978-967-5080-91-3 (2010)</TD>
            </TR>
            <TR height="22">
              <TD height="22">Price</TD>
              <TD>:</TD>
              <TD>RM 147.00</TD>
            </TR>
            <TR height="23">
              <TD height="23">Pages</TD>
              <TD>:</TD>
              <TD>667</TD>
            </TR>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">11.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="398">
            <TR height="22">
              <TD width="99" height="22">Title</TD>
              <TD width="16">:</TD>
              <td width="398"><strong>Environmental    Engineering</strong></td>
            </TR>
            <TR height="22">
              <TD height="22">Author</TD>
              <TD>:</TD>
              <td width="412">Anwar    Ahmad &amp; Zularisam Abd Wahid</td>
            </TR>
            <TR height="22">
              <TD height="22">No ISBN</TD>
              <TD>:</TD>
              <td width="412">978-967-5080-86-9</td>
            </TR>
            <TR height="22">
              <TD height="22">Price</TD>
              <TD>:</TD>
              <td width="412">RM 40.00</td>
            </TR>
            <TR height="23">
              <TD height="23">Pages</TD>
              <TD>:</TD>
              <td width="412">220</td>
            </TR>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">12.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="398">
            <TR height="22">
              <TD width="99" height="22">Title</TD>
              <TD width="16">:</TD>
              <td width="398"><strong>Perkauman    &amp; Keagamaan Dalam Islam</strong></td>
            </TR>
            <TR height="22">
              <TD height="22">Author</TD>
              <TD>:</TD>
              <td width="412">Asar    Abdul Karim</td>
            </TR>
            <TR height="22">
              <TD height="22">No ISBN</TD>
              <TD>:</TD>
              <td width="412">978-967-5080-87-6</td>
            </TR>
            <TR height="22">
              <TD height="22">Price</TD>
              <TD>:</TD>
              <td width="412">RM 35.00</td>
            </TR>
            <TR height="23">
              <TD height="23">Pages</TD>
              <TD>:</TD>
              <td width="412">197</td>
            </TR>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">Malay</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">13.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="398">
            <TR height="22">
              <TD width="99" height="22">Title</TD>
              <TD width="16">:</TD>
              <td width="398"><strong>Membudayakan    Minda Lestari Dalam Pengurusan Alam Sekitar</strong></td>
            </TR>
            <TR height="22">
              <TD height="22">Author</TD>
              <TD>:</TD>
              <td width="412">Azizan    Ramli</td>
            </TR>
            <TR height="22">
              <TD height="22">No ISBN</TD>
              <TD>:</TD>
              <td width="412">978-967-5080-98-2</td>
            </TR>
            <TR height="22">
              <TD height="22">Price</TD>
              <TD>:</TD>
              <td width="412">RM 33.00</td>
            </TR>
            <TR height="23">
              <TD height="23">Pages</TD>
              <TD>:</TD>
              <td width="412">130</td>
            </TR>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">Malay</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">14.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="398">
            <TR height="22">
              <TD width="99" height="22">Title</TD>
              <TD width="16">:</TD>
              <td width="398"><strong>Melangkah Gagah Urus Kerjaya Anda</strong></td>
            </TR>
            <TR height="22">
              <TD height="22">Author</TD>
              <TD>:</TD>
              <td width="412">Ida Rizyani Tahir &amp; Zuraina Ali</td>
            </TR>
            <TR height="22">
              <TD height="22">No ISBN</TD>
              <TD>:</TD>
              <td width="412">978-967-5080-99-9</td>
            </TR>
            <TR height="22">
              <TD height="22">Price</TD>
              <TD>:</TD>
              <td width="412">RM 45.00</td>
            </TR>
            <TR height="23">
              <TD height="23">Pages</TD>
              <TD>:</TD>
              <td width="412">139</td>
            </TR>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">Malay</div></td>
        </tr>
      </table>
	  <p>&nbsp;</p>
  </div>
     
     
     
     <div class="tabbertab">
	  <h2>2009</h2>
	  <span class="style1"><span class="style10"><strong><br>
	  </strong></span></span>
	  <p align="center" class="style21">BOOKS</p>
	  <table width="100%%" border="1" cellpadding="3" cellspacing="0">
        <tr>
          <td width="3%" bgcolor="#99CCFF" class="style20">NO.</td>
          <td width="69%" bgcolor="#99CCFF" class="style20"><div align="left">TITLE</div></td>
          <td width="9%" bgcolor="#99CCFF" class="style20"><div align="center">LANGUAGE</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">1.</td>
          <td bgcolor="#FFFFFF" class="style1"><div align="left">
            <table width="100%" cellpadding="0" cellspacing="0">
              <col width="99">
              <col width="16">
              <col width="381">
              <tr height="22">
                <td height="22" width="99">Title</td>
                <td width="16">:</td>
                <td width="381"><strong>Kecerdasan Emosi</strong></td>
              </tr>
              <tr height="22">
                <td height="22">Author</td>
                <td>:</td>
                <td width="381">Dzull Zabarrod Ahmad</td>
              </tr>
              <tr height="22">
                <td height="22">No ISBN</td>
                <td>:</td>
                <td width="381">978-967-5080-46-3</td>
              </tr>
              <tr height="22">
                <td height="22">Price</td>
                <td>:</td>
                <td width="381">RM 22.50</td>
              </tr>
              <tr height="23">
                <td height="23">Pages</td>
                <td>:</td>
                <td width="381">44 pages</td>
              </tr>
                      </table>
          </div></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">Malay</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">2.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
           
            <tr height="22">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="381"><strong>Industri Perbankan &amp;    Kewangan Islam<img src="http://www.ump.edu.my/images/new_baru.gif" /></strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="381">Abdul Jalil Borham</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="381">978-967-5080-38-8</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="381">RM 35.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="381">193 pages</td>
            </tr>
          </table>          </td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">Malay</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">3.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="381">
            <tr height="22">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="381"><strong>The Lost Diamond: An Anthology    Of Poems</strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="381">Normah Othman</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="381">978-967-5080-48-7</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="381">RM 18.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="381">55 pages</td>
            </tr>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">4.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="381">
            <tr height="22">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="381"><strong>Artikel Kenegaraan<img src="http://www.ump.edu.my/images/new_baru.gif" /></strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="381">Hasnah Hussiin</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="381">978-967-5080-68-5</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="381">RM 48.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="381">268 pages</td>
            </tr>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">Malay</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">5.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="381">
            <tr height="38">
              <td height="21" width="99">Title</td>
              <td width="16">:</td>
              <td width="381" height="22"><strong>An Integrated Fuzzy Approach To    Students' Assessment</strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="381">Badrul Hisham Abdullah</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="381">978-967-5080-58-6</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="381">RM 28.50</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="381">72 pages</td>
            </tr>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">6.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="381">
            <tr height="38">
              <td height="17" width="99">Title</td>
              <td width="16">:</td>
              <td width="381" height="22"><strong>Engineers &amp; Society For    First Year Engineering Students</strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="381">Syaiful Nizam Hassan</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="381">978-967-5080-60-9</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="381">RM 33.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="381">74 pages</td>
            </tr>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">7.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="381">
            <tr height="22">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="381"><strong>Introduction To Pile Foundations<img src="http://www.ump.edu.my/images/new_baru.gif" /></strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="381">Youventharan a/l Duraisamy</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="381">978-967-5080-63-0</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="381">RM 45.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="381">117 pages</td>
            </tr>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td class="style1">8.</td>
          <td class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="381">
            <tr height="38">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="381" height="22"><strong>Geophysics Method&nbsp; In Geological Engineering<img src="http://www.ump.edu.my/images/new_baru.gif" /></strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="381">Youventharan a/l Duraisamy</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="381">978-967-5080-66-1</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="381">RM 45.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="381">102 pages</td>
            </tr>
          </table></td>
          <td class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td class="style1">9.</td>
          <td class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="381">
            <tr height="38">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="381" height="22"><strong>Computational Inteligence    Aplications For Power Systems<img src="http://www.ump.edu.my/images/new_baru.gif" /></strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="381">Ahmed Mohamed Ahmed Haidar</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="381">978-967-5080-62-3</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="381">RM 55.50</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="381">191 pages</td>
            </tr>
          </table></td>
          <td class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td class="style1">10.</td>
          <td class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="381">
            <tr height="22">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="381"><strong>Membrane For Surface Water    Treatment<img src="http://www.ump.edu.my/images/new_baru.gif" /></strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="381">Zularisam Ab Wahid &amp; Mimi    Sakinah Abd Munaim</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="381">978-967-5080-74-6</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="381">RM 48.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="381">76 pages</td>
            </tr>
          </table></td>
          <td class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td class="style1">11.</td>
          <td class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="381">
            <tr height="38">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="381" height="22"><strong>The Implementation Of Skills    Training In Malaysia Between 1970's &amp; 1990's<img src="http://www.ump.edu.my/images/new_baru.gif" /></strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="381">Ahmad Othman</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="381">978-967-5080-72-2</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="381">RM 48.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="381">175 pages</td>
            </tr>
          </table></td>
          <td class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td class="style1">12.</td>
          <td class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="381">
            <tr height="38">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="381" height="22"><strong>Human Resource Development:    Attitudinal &amp; Behavioral Outcomes<img src="http://www.ump.edu.my/images/new_baru.gif" /></strong></td>
            </tr>
            <tr height="44">
              <td height="22">Author</td>
              <td>:</td>
              <td width="381">Mohammad Affendy Omardin, Azman    Ismail &amp; Noraziah Ahmad</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="381">978-967-5080-76-0</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="381">RM 36.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="381">73 pages</td>
            </tr>
          </table></td>
          <td class="style1"><div align="center">English</div></td>
        </tr>
      </table>
	  <p align="center" class="style21"><br>
       MODULES</p>
	  <table width="100%%" border="1" cellpadding="3" cellspacing="0">
        <tr>
          <td width="3%" bgcolor="#99CCFF" class="style20">NO.</td>
          <td width="69%" bgcolor="#99CCFF" class="style20"><div align="left">TITLE</div></td>
          <td width="9%" bgcolor="#99CCFF" class="style20"><div align="center">LANGUAGE</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">1.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
          
            <tr height="22">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="381"><strong>Developing Language Proficiency    Skills</strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="381">Lecturers of CMLHS</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="381">978-967-5080-54-8</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="381">-</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="381">98 pages</td>
            </tr>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">2.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            
            <tr height="22">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="381"><strong>Developing Delivery Skills</strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="381">Lecturers of CMLHS</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="381">978-967-5080-52-4</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="381">-</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="381">92 pages</td>
            </tr>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">3.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <tr height="22">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="381"><strong>Developing Effective    CommunicationsSkills</strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="381">Lecturers of CMLHS</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="381">978-967-5080-53-1</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="381">-</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="381">63 pages</td>
            </tr>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">4.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="381">
            <tr height="22">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="381"><strong>DIY Satellite TV</strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="381">Zulkeflee Khalidin</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="381">978-967-5080-46-3</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="381">RM 33.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="381">56 pages</td>
            </tr>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">5.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
          
            <tr height="22">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="381"><strong>Soil Mechanics Laboratory Manual</strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="381">Youventharan Duraisamy</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="381">978-967-5080-49-4</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="381">RM 20.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="381">131 pages</td>
            </tr>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">6.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="381">
            <tr height="38">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="381"><strong>Teaching Handbook For Institute    Of Higher Learning</strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="381">Abdullah Ibrahim</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="381">978-967-5080-39-5</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="381">-</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="381">62 pages</td>
            </tr>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">7.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="381">
            <tr height="22">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="381" height="22"><strong>Calculus For Science &amp;    Engineering</strong></td>
            </tr>
            <tr height="44">
              <td height="22">Author</td>
              <td>:</td>
              <td width="381">Siti Zanariah Satari, Mohd Nizam    Mohmad Kahar, Norazaliza Mohd Jamil</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="381">978-967-5080-61-6</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="381">RM 45.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="381">283 pages</td>
            </tr>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td class="style1">8.</td>
          <td class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="381">
            <tr height="22">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="381"><strong>Teaching Module: Electrical    Power Quality<img src="http://www.ump.edu.my/images/new_baru.gif" /></strong></td>
            </tr>
            <tr height="44">
              <td height="22">Author</td>
              <td>:</td>
              <td width="381">Ruhaizad Ishak, Mohd Shawal    Jadin, Mohd Redzuan Ahmad</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="381">978-967-5080-64-7</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="381">RM 25.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="381">100 pages</td>
            </tr>
          </table>          </td>
          <td class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td class="style1">9.</td>
          <td class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="381">
            <tr height="22">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="381"><strong>English For General    Communication UHL 1312</strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="381">Lecturers of CMLHS</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="381">978-967-5080-64-8</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="381">RM 33.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="381">122 pages</td>
            </tr>
          </table></td>
          <td class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td class="style1">10.</td>
          <td class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="381">
            <tr height="22">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="381"><strong>Technical English UHL 2312</strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="381">Lecturers of CMLHS</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="381">978-967-5080-67-8</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="381">RM 24.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="381">110 pages</td>
            </tr>
          </table></td>
          <td class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td class="style1">11.</td>
          <td class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="381">
            <tr height="22">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="381"><strong>Intermediate Mandarin</strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="381">Chong Ah Kow</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="381">978-967-5080-43-2</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="381">RM 42.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="381">187 pages</td>
            </tr>
          </table></td>
          <td class="style1"><div align="center">English</div></td>
        </tr>
      </table>
	  <p class="style6">&nbsp;</p>
	  <p align="center" class="style21">JOURNALS</p>
	  <table width="100%%" border="1" cellpadding="3" cellspacing="0">
        <tr>
          <td width="3%" bgcolor="#99CCFF" class="style20">NO.</td>
          <td width="69%" bgcolor="#99CCFF" class="style20"><div align="left">TITLE</div></td>
          <td width="9%" bgcolor="#99CCFF" class="style20"><div align="center">LANGUAGE</div></td>
        </tr>
        <tr>
          <td class="style1">1.</td>
          <td class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="381">
            <tr height="38">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="381" height="22"><strong>Jurnal UMP - Sains Sosial &amp;    Pengurusan Teknologi</strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="381">Universiti Malaysia Pahang</td>
            </tr>
            <tr height="22">
              <td height="22">No ISSN</td>
              <td>:</td>
              <td width="381">ISSN 1985-8957</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="381">RM 35.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="381">126 pages</td>
            </tr>
          </table></td>
          <td class="style1"><div align="center">English / Malay</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">2.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="381">
            <tr height="38">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="381" height="22"><strong>Jurnal UMP - Kejuruteraan &amp;    Teknologi Komputer<span class="style2"><img src="http://www.ump.edu.my/images/new_baru.gif" /></span></strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="381">Universiti Malaysia Pahang</td>
            </tr>
            <tr height="22">
              <td height="22">No ISSN</td>
              <td>:</td>
              <td width="381">ISSN 1985-5176</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="381">RM 34.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="381">127 pages</td>
            </tr>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">English</div></td>
        </tr>
      </table>
	  <p class="style7">&nbsp;</p>
	  <p align="center" class="style21">COFFEE TABLE BOOKS</p>
	  <table width="100%%" border="1" cellpadding="3" cellspacing="0">
        <tr>
          <td width="3%" bgcolor="#99CCFF" class="style20">NO.</td>
          <td width="69%" bgcolor="#99CCFF" class="style20"><div align="left">TITLE</div></td>
          <td width="9%" bgcolor="#99CCFF" class="style20"><div align="center">LANGUAGE</div></td>
        </tr>
        <tr>
          <td class="style1">1.</td>
          <td class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="381">
            <tr height="22">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="381"><strong>HAKNUK - Orang Kita <span class="style2">(Limited Edition)<img src="http://www.ump.edu.my/images/new_baru.gif" /></span></strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="381">Universiti Malaysia Pahang</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="381">978-967-5080-56-2</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="381">RM 120.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="381">90 muka surat</td>
            </tr>
          </table></td>
          <td class="style1"><div align="center">English / Malay</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">2.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="381">
            <tr height="22">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="381"><strong>Sultan Ahmad Shah: The Ruler, The Builder, The    Engineer</strong> <span class="style2"> (Limited Edition)<img src="http://www.ump.edu.my/images/new_baru.gif" /></span></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="381">Universiti Malaysia Pahang</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="381">978-967-5080-73-9</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="381">RM 250.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="381">91 pages</td>
            </tr>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">Malay</div></td>
        </tr>
      </table>
	  <p align="center" class="style21">&nbsp;</p>
	  <p class="style1"></p>
	  <p>&nbsp;</p>
  </div>


<div class="tabbertab">
	  <h2>2008</h2>
	  <p align="center" class="style21">BOOKS</p>
<table width="100%%" border="1" cellpadding="3" cellspacing="0">
        <tr>
          <td width="3%" bgcolor="#99CCFF" class="style20">NO.</td>
          <td width="69%" bgcolor="#99CCFF" class="style20"><div align="left">TITLE</div></td>
          <td width="9%" bgcolor="#99CCFF" class="style20"><div align="center">LANGUAGE</div></td>
        </tr>
        <tr>
          <td class="style1">1.</td>
          <td class="style1"><table width="100%" cellpadding="0" cellspacing="0">
              <col width="99">
              <col width="16">
              <col width="398">
              <tr height="22">
                <td height="22" width="99">Title</td>
                <td width="16">:</td>
                <td width="398"><strong>Asas Pembangunan Modal Insan</strong></td>
              </tr>
              <tr height="22">
                <td height="22">Author</td>
                <td>:</td>
                <td width="398">Abdul Jalil Borham</td>
              </tr>
              <tr height="22">
                <td height="22">No ISBN</td>
                <td>:</td>
                <td width="398">978-967-5080-10-4</td>
              </tr>
              <tr height="22">
                <td height="22">Price</td>
                <td>:</td>
                <td width="398">RM 13.00</td>
              </tr>
              <tr height="23">
                <td height="23">Pages</td>
                <td>:</td>
                <td width="398">117 pages</td>
              </tr>
          </table></td>
          <td class="style1"><div align="center">Malay</div></td>
        </tr>
        <tr>
          <td class="style1">2.</td>
          <td class="style1"><table width="100%" cellpadding="0" cellspacing="0">
              <col width="99">
              <col width="16">
              <col width="398">
              <tr height="22">
                <td height="22" width="99">Title</td>
                <td width="16">:</td>
                <td width="398"><strong>Institusi Islam</strong></td>
              </tr>
              <tr height="22">
                <td height="22">Author</td>
                <td>:</td>
                <td width="398">(Penyusun) Hassan Ahmad</td>
              </tr>
              <tr height="22">
                <td height="22">No ISBN</td>
                <td>:</td>
                <td width="398">978-967-5080-15-9</td>
              </tr>
              <tr height="22">
                <td height="22">Price</td>
                <td>:</td>
                <td width="398">RM 13.00</td>
              </tr>
              <tr height="23">
                <td height="23">Pages</td>
                <td>:</td>
                <td width="398">230 pages</td>
              </tr>
          </table></td>
          <td class="style1"><div align="center">Malay</div></td>
        </tr>
        <tr>
          <td class="style1">3.</td>
          <td class="style1"><table width="100%" cellpadding="0" cellspacing="0">
              <col width="99">
              <col width="16">
              <col width="398">
              <tr height="22">
                <td height="22" width="99">Title</td>
                <td width="16">:</td>
                <td width="398"><strong>50 Kesilapan Usahawan</strong></td>
              </tr>
              <tr height="22">
                <td height="22">Author</td>
                <td>:</td>
                <td width="398">Roselan Tahar</td>
              </tr>
              <tr height="22">
                <td height="22">No ISBN</td>
                <td>:</td>
                <td width="398">978-967-5080-21-0</td>
              </tr>
              <tr height="22">
                <td height="22">Price</td>
                <td>:</td>
                <td width="398">RM 10.00</td>
              </tr>
              <tr height="23">
                <td height="23">Pages</td>
                <td>:</td>
                <td width="398">74 pages</td>
              </tr>
          </table></td>
          <td class="style1"><div align="center">Malay</div></td>
        </tr>
        <tr>
          <td class="style1">4.</td>
          <td class="style1"><table width="100%" cellpadding="0" cellspacing="0">
              <col width="99">
              <col width="16">
              <col width="398">
              <tr height="22">
                <td height="22" width="99">Title</td>
                <td width="16">:</td>
                <td width="398"><strong>Research Methodology For Social Science</strong></td>
              </tr>
              <tr height="44">
                <td height="22">Author</td>
                <td>:</td>
                <td width="398">Mohd Ghani Awang, Suriya Kumar Sinnadurai, Siti Zanariah Satari &amp; Balan Kunjambu</td>
              </tr>
              <tr height="22">
                <td height="22">No ISBN</td>
                <td>:</td>
                <td width="398">978-967-5080-00-5</td>
              </tr>
              <tr height="22">
                <td height="22">Price</td>
                <td>:</td>
                <td width="398">RM 13.00</td>
              </tr>
              <tr height="23">
                <td height="23">Pages</td>
                <td>:</td>
                <td width="398">124 pages</td>
              </tr>
          </table></td>
          <td class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td class="style1">5.</td>
          <td class="style1"><table width="100%" cellpadding="0" cellspacing="0">
              <col width="99">
              <col width="16">
              <col width="398">
              <tr height="38">
                <td height="22" width="99">Title</td>
                <td width="16">:</td>
                <td width="398" height="22"><strong>Pembangunan Modal Insan: Pendekatan Personaliti Kontemporari</strong></td>
              </tr>
              <tr height="22">
                <td height="22">Author</td>
                <td>:</td>
                <td width="398">Muhammad Nubli Abdul Wahab</td>
              </tr>
              <tr height="22">
                <td height="22">No ISBN</td>
                <td>:</td>
                <td width="398">978-967-5080-17-3</td>
              </tr>
              <tr height="22">
                <td height="22">Price</td>
                <td>:</td>
                <td width="398">RM 13.00</td>
              </tr>
              <tr height="23">
                <td height="23">Pages</td>
                <td>:</td>
                <td width="398">114 pages</td>
              </tr>
          </table></td>
          <td class="style1"><div align="center">Malay</div></td>
        </tr>
        <tr>
          <td class="style1">6.</td>
          <td class="style1"><table width="100%" cellpadding="0" cellspacing="0">
              <col width="99">
              <col width="16">
              <col width="398">
              <tr height="22">
                <td height="22" width="99">Title</td>
                <td width="16">:</td>
                <td width="398"><strong>Study Orientation In Action</strong></td>
              </tr>
              <tr height="22">
                <td height="22">Author</td>
                <td>:</td>
                <td width="398">Mohd Ghani Awang, Suriya Kumar Sinnadurai</td>
              </tr>
              <tr height="22">
                <td height="22">No ISBN</td>
                <td>:</td>
                <td width="398">978-983-42632-6-3</td>
              </tr>
              <tr height="22">
                <td height="22">Price</td>
                <td>:</td>
                <td width="398">RM 16.00</td>
              </tr>
              <tr height="23">
                <td height="23">Pages</td>
                <td>:</td>
                <td width="398">95 pages</td>
              </tr>
          </table></td>
          <td class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td class="style1">7.</td>
          <td class="style1"><table width="100%" cellpadding="0" cellspacing="0">
              <col width="99">
              <col width="16">
              <col width="398">
              <tr height="22">
                <td height="22" width="99">Title</td>
                <td width="16">:</td>
                <td width="398"><strong>Tazkirah</strong></td>
              </tr>
              <tr height="22">
                <td height="22">Author</td>
                <td>:</td>
                <td width="398">Zuridan Mohd Daud</td>
              </tr>
              <tr height="22">
                <td height="22">No ISBN</td>
                <td>:</td>
                <td width="398">978-967-5080-05-0</td>
              </tr>
              <tr height="22">
                <td height="22">Price</td>
                <td>:</td>
                <td width="398">RM 13.00</td>
              </tr>
              <tr height="23">
                <td height="23">Pages</td>
                <td>:</td>
                <td width="398">169 pages</td>
              </tr>
          </table></td>
          <td class="style1"><div align="center">Malay</div></td>
        </tr>
        <tr>
          <td class="style1">8.</td>
          <td class="style1"><table width="100%" cellpadding="0" cellspacing="0">
              <col width="99">
              <col width="16">
              <col width="398">
              <tr height="22">
                <td height="22" width="99">Title</td>
                <td width="16">:</td>
                <td width="398"><strong>Kecemerlangan Tamadun Islam Masa Kini</strong></td>
              </tr>
              <tr height="22">
                <td height="22">Author</td>
                <td>:</td>
                <td width="398">Asar Abdul Karim</td>
              </tr>
              <tr height="22">
                <td height="22">No ISBN</td>
                <td>:</td>
                <td width="398">978-967-5080-09-8</td>
              </tr>
              <tr height="22">
                <td height="22">Price</td>
                <td>:</td>
                <td width="398">RM 15.00</td>
              </tr>
              <tr height="23">
                <td height="23">Pages</td>
                <td>:</td>
                <td width="398">270 pages</td>
              </tr>
          </table></td>
          <td class="style1"><div align="center">Malay</div></td>
        </tr>
        <tr>
          <td class="style1">9.</td>
          <td class="style1"><table width="100%" cellpadding="0" cellspacing="0">
              <col width="99">
              <col width="16">
              <col width="398">
              <tr height="38">
                <td height="22" width="99">Title</td>
                <td width="16">:</td>
                <td width="398" height="22"><strong>Kemahiran Insaniah : &ldquo;Meneroka Metodologi Rasulullah&rdquo;&nbsp;</strong></td>
              </tr>
              <tr height="22">
                <td height="22">Author</td>
                <td>:</td>
                <td width="398">Rashidi Abbas</td>
              </tr>
              <tr height="22">
                <td height="22">No ISBN</td>
                <td>:</td>
                <td width="398">978-967-5080-16-6</td>
              </tr>
              <tr height="22">
                <td height="22">Price</td>
                <td>:</td>
                <td width="398">RM 13.00</td>
              </tr>
              <tr height="23">
                <td height="23">Pages</td>
                <td>:</td>
                <td width="398">152 pages</td>
              </tr>
          </table></td>
          <td class="style1"><div align="center">Malay</div></td>
        </tr>
        <tr>
          <td class="style1">10.</td>
          <td class="style1"><table width="100%" cellpadding="0" cellspacing="0">
              <col width="99">
              <col width="16">
              <col width="398">
              <tr height="22">
                <td height="22" width="99">Title</td>
                <td width="16">:</td>
                <td width="398"><strong>Friday Wisdom: Handbook Untuk Wanita</strong></td>
              </tr>
              <tr height="22">
                <td height="22">Author</td>
                <td>:</td>
                <td width="398">(Penyelenggara) Anita Abdul Rani</td>
              </tr>
              <tr height="22">
                <td height="22">No ISBN</td>
                <td>:</td>
                <td width="398">978-967-5080-07-4</td>
              </tr>
              <tr height="22">
                <td height="22">Price</td>
                <td>:</td>
                <td width="398">RM 10.00</td>
              </tr>
              <tr height="23">
                <td height="23">Pages</td>
                <td>:</td>
                <td width="398">148 pages</td>
              </tr>
          </table></td>
          <td class="style1"><div align="center">Malay</div></td>
        </tr>
        <tr>
          <td class="style1">11.</td>
          <td class="style1"><table width="100%" cellpadding="0" cellspacing="0">
              <col width="99">
              <col width="16">
              <col width="398">
              <tr height="22">
                <td height="22" width="99">Title</td>
                <td width="16">:</td>
                <td width="398"><strong>Bahasa Arab Untuk Semua</strong></td>
              </tr>
              <tr height="22">
                <td height="22">Author</td>
                <td>:</td>
                <td width="398">Asar Abdul Karim</td>
              </tr>
              <tr height="22">
                <td height="22">No ISBN</td>
                <td>:</td>
                <td width="398">978-967-5080-36-4</td>
              </tr>
              <tr height="22">
                <td height="22">Price</td>
                <td>:</td>
                <td width="398">RM 18.00</td>
              </tr>
              <tr height="23">
                <td height="23">Pages</td>
                <td>:</td>
                <td width="398">374 pages</td>
              </tr>
          </table></td>
          <td class="style1"><div align="center">Malay</div></td>
        </tr>
        <tr>
          <td class="style1">12.</td>
          <td class="style1"><table width="100%" cellpadding="0" cellspacing="0">
              <col width="99">
              <col width="16">
              <col width="398">
              <tr height="57">
                <td height="22" width="99"><strong>Title</strong></td>
                <td width="16"><strong>:</strong></td>
                <td width="398" height="22"><strong>Modal Insan &ndash; Konsep, Aplikasi &amp; Isu-Isu Kontemporari Dalam Cabaran Pemerkasaan Tamadun Islam</strong></td>
              </tr>
              <tr height="44">
                <td height="22">Author</td>
                <td>:</td>
                <td width="398" height="22">(Penyelenggara) Mohd Fazullah Zainal Abidin, Jamal Rizal Razali &amp; Hasnah Hussin</td>
              </tr>
              <tr height="22">
                <td height="22">No ISBN</td>
                <td>:</td>
                <td width="398">978-967-5080-32-6</td>
              </tr>
              <tr height="22">
                <td height="22">Price</td>
                <td>:</td>
                <td width="398">RM 17.00</td>
              </tr>
              <tr height="23">
                <td height="23">Pages</td>
                <td>:</td>
                <td width="398">308 pages</td>
              </tr>
          </table></td>
          <td class="style1"><div align="center">Malay</div></td>
        </tr>
      </table>
	  <p align="center" class="style21"></p>
	  <p align="center" class="style21">MODULES</p>
	  <table width="100%%" border="1" cellpadding="3" cellspacing="0">
        <tr>
          <td width="3%" bgcolor="#99CCFF" class="style20">NO.</td>
          <td width="69%" bgcolor="#99CCFF" class="style20"><div align="left">TITLE</div></td>
          <td width="9%" bgcolor="#99CCFF" class="style20"><div align="center">LANGUAGE</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">1.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="398">
            <tr height="22">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="398"><strong>Effective Reading Workbook</strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="398">Ahmad Nasaruddin Sulaiman, Asiah    Kassim</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="398">978-967-5080-33-3</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="398">RM 13.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="398">72 pages</td>
            </tr>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">2.</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="398">
            <tr height="22">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="398"><strong>Asas Bahasa Jepun 1</strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="398">Mohd Iszuani Mohd Hassan</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="398">978-967-5080-18-0</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="398">RM 13.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="398">107 pages</td>
            </tr>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1"><div align="center">Malay</div></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">&nbsp;</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="398">
            <tr height="22">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="398"><strong>English Dynamics 3 UHL 3002</strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="398">Lecturers of CMLHS</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="398">978-967-5080-25-8</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="398">RM 13.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="398">99 pages</td>
            </tr>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1">&nbsp;</td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">&nbsp;</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="398">
            <tr height="22">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="398"><strong>English Orientation Skills Kit</strong></td>
            </tr>
            <tr height="66">
              <td height="22">Author</td>
              <td>:</td>
              <td width="398">Mohd Ghani Awang, Muhammad Nubli    Abdul Wahab, Zamzam Ahmad, Nor Suhardi Liyana Sahar, Suriya Kumar Sinnadurai</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="398">978-967-5080-11-1</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="398">RM 16.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="398">78 pages</td>
            </tr>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1">&nbsp;</td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF" class="style1">&nbsp;</td>
          <td bgcolor="#FFFFFF" class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="398">
            <tr height="38">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="398" height="22"><strong>Modul Meningkatkan Prestasi Diri    - Pendekatan Personaliti Kontemporari</strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="398">Muhammad Nubli Abdul Wahab</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="398">978-967-5080-37-1</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="398">RM 13.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="398">116 pages</td>
            </tr>
          </table></td>
          <td bgcolor="#FFFFFF" class="style1">&nbsp;</td>
        </tr>
      </table>
	  <p>&nbsp;</p>
  </div>


     <div class="tabbertab">
	  <h2>2007</h2>
	  <p align="center" class="style21">BOOKS</p>
	  <table width="100%%" border="1" cellpadding="3" cellspacing="0">
        <tr>
          <td width="3%" bgcolor="#99CCFF" class="style20">NO.</td>
          <td width="69%" bgcolor="#99CCFF" class="style20"><div align="left">TITLE</div></td>
          <td width="9%" bgcolor="#99CCFF" class="style20"><div align="center">LANGUAGE</div></td>
        </tr>
        <tr>
          <td class="style1">1.</td>
          <td class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="398">
            <tr height="22">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="398"><strong>PCB Design &amp; Fabrication For    Beginners</strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="398">Mohammad Fadhil Abas</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="398">978-983-42632-2-8</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="398">RM 16.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="398">118 pages</td>
            </tr>
          </table></td>
          <td class="style1"><div align="center">English</div></td>
        </tr>
        <tr>
          <td class="style1">2.</td>
          <td class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="398">
            <tr height="38">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="398" height="22"><strong>Kecemerlangan Pengurusan    Organisasi Dalam Islam Siri 1</strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="398">Muhammad Nubli Abdul Wahab</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="398">978-983-42632-7-0</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="398">RM 14.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="398">83 pages</td>
            </tr>
          </table></td>
          <td class="style1"><div align="center">Malay</div></td>
        </tr>
        <tr>
          <td class="style1">3.</td>
          <td class="style1"><table width="100%" cellpadding="0" cellspacing="0">
            <col width="99">
            <col width="16">
            <col width="398">
            <tr height="38">
              <td height="22" width="99">Title</td>
              <td width="16">:</td>
              <td width="398" height="22"><strong>Kecemerlangan Pengurusan    Organisasi Dalam Islam Siri 2</strong></td>
            </tr>
            <tr height="22">
              <td height="22">Author</td>
              <td>:</td>
              <td width="398">Muhammad Nubli Abdul Wahab</td>
            </tr>
            <tr height="22">
              <td height="22">No ISBN</td>
              <td>:</td>
              <td width="398">978-983-42632-8-7</td>
            </tr>
            <tr height="22">
              <td height="22">Price</td>
              <td>:</td>
              <td width="398">RM 14.00</td>
            </tr>
            <tr height="23">
              <td height="23">Pages</td>
              <td>:</td>
              <td width="398">110 pages</td>
            </tr>
          </table></td>
          <td class="style1"><div align="center">Malay</div></td>
        </tr>
      </table>
	  <p>&nbsp;</p>
  </div>
     
     


 <div class="tabbertab">
	  <h2>Statistik</h2>
	  <p><span class="style1"><span class="style10"><strong>Statistics:</strong></span><br>
      </span> </p>
      <table width="434" border="1" cellspacing="0" cellpadding="3">
        <tr>
          <td bgcolor="#99CCFF" class="style1"><strong>CATEGORY</strong></td>
          <td bgcolor="#99CCFF" class="style1">&nbsp;</td>
          <td bgcolor="#99CCFF" class="style2">2009</td>
          <td bgcolor="#99CCFF" class="style2">2008</td>
          <td bgcolor="#99CCFF" class="style2">2007</td>
        </tr>
        <tr>
          <td width="172" class="style1"><span class="style25">BOOKS</span></td>
          <td width="8" class="style1">:</td>
          <td class="style2"><div align="center">12</div></td>
          <td class="style2"><div align="center">12</div></td>
          <td class="style2"><div align="center">3</div></td>
        </tr>
        <tr>
          <td class="style1"><span class="style25">MODULES</span></td>
          <td class="style1">:</td>
          <td class="style2"><div align="center">11</div></td>
          <td class="style2"><div align="center">5</div></td>
          <td class="style2"><div align="center">-</div></td>
        </tr>
        <tr>
          <td class="style1"><span class="style25">JOURNALS</span></td>
          <td class="style1">:</td>
          <td class="style2"><div align="center">2</div></td>
          <td class="style2"><div align="center">-</div></td>
          <td class="style2"><div align="center">-</div></td>
        </tr>
        <tr>
          <td class="style1"><span class="style25">COFFEE TABLE BOOKS</span></td>
          <td class="style1">:</td>
          <td class="style2"><div align="center">2</div></td>
          <td class="style2"><div align="center">-</div></td>
          <td class="style2"><div align="center">-</div></td>
        </tr>
      </table>
      <br>
 </div>
     


<div class="tabbertab">
	  <h2>Hubungi Kami</h2>
	  <table width="60%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td valign="top"><span class="style1"><span class="style17">Untuk Pesanan sila hubungi:</span><br />
              <br />
              <strong>Muhammad Azli Bin Shukri</strong><br />
Pegawai Penerbitan<br />
09-5492625<br />
<br />
atau<br />
<strong><br />
Noraini Binti Hussin</strong><br />
Pen. Pegawai Penerbitan (Sales &amp; Marketing)<br />
09-5493318</span></td>
          <td valign="top"><span class="style1"><span class="style17">Hubungi talian umum Penerbit UMP</span>:<br />
              <br />
              <strong>Fadhilah Binti Abdul Ghaffar</strong><br />
09-5493320<br />
<br />
atau <br />
<br />
<strong>Faks pesanan ke</strong><br />
09-5493381</span></td>
          <td valign="top"><span class="style1"><span class="style17">Poskan pesanan pembelian (PO) ke alamat:</span><br />
              <br />
              <strong>PENERBIT</strong><br />
UNIVERSITI MALAYSIA PAHANG<br />
LEBUHRAYA TUN RAZAK<br />
26300 GAMBANG, KUANTAN<br />
PAHANG</span></td>
        </tr>
      </table>
	  <p>Website: <a href="http://publisher.ump.edu.my/" target="_blank">http://publisher.ump.edu.my/</a></p>
  </div>
  
  
  
</div>



</body>
</html>
