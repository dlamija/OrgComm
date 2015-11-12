function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}

function getCookieVal (offset) {  
  var endstr = document.cookie.indexOf (";", offset);  
  if (endstr == -1)    
    endstr = document.cookie.length;  
  return unescape(document.cookie.substring(offset, endstr));
}

function GetCookie (name) {
  var uid = "<%= TvoContextManager.getSessionAttribute(request, "Login.userID") %>";
  name = uid + name;
  var arg = name + "=";  
  var alen = arg.length;  
  var clen = document.cookie.length;  
  var i = 0;  
  while (i < clen) {    
    var j = i + alen;    
    if (document.cookie.substring(i, j) == arg)      
      return getCookieVal (j);    
    i = document.cookie.indexOf(" ", i) + 1;    
    if (i == 0) break;   
  }  
  return null;
}

function toggleBlock(b) {
  if(navigator.appName != "Microsoft Internet Explorer")
    return false;
    
  if(document.all[b].style.display == "block" || document.all[b].style.display == "")
    hideBlock(b);
  else
    showBlock(b);

  saveBox(b);
}

function hideBlock(b) {
  document.all[b].style.display = "none";
}

function showBlock(b) {
  document.all[b].style.display = "block";
}

function saveBox(b) {
  var uid = "<%= TvoContextManager.getSessionAttribute(request, "Login.userID") %>";
  var cookieStr = "";
  var expDays = 3650;
  var exp = new Date(); 
  exp.setTime(exp.getTime() + (expDays*24*60*60*1000));
  
  cookieStr = uid + b + "=" + document.all[b].style.display + "; expires=" + exp.toGMTString();
  document.cookie = cookieStr;
}

function loadBox(b) {
  if (GetCookie(b) == "block" || GetCookie(b) == "" || GetCookie(b) == null)
    showBlock(b);
  else
    hideBlock(b);
}

function test()
{
	alert("tes");
}
