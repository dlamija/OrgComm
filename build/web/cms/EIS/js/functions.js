
<!--
function popup_win( loc, wd, hg ) {
   var remote = null;
   var xpos = screen.availWidth/2 - wd/2; 
   var ypos = screen.availHeight/2 - hg/2; 
   remote = window.open('','','width=' + wd + ',height=' + hg + ',resizable=0,scrollbars=1,screenX=0,screenY=0,top='+ypos+',left='+xpos);
   if (remote != null) {
      if (remote.opener == null) {
         remote.opener = self;
      }
      remote.location.href = loc;
      remote.focus();
   } 
   else { 
      self.close(); 
   }
}

function popup_win2( loc, wd, hg ) {
   var remote = null;
   var xpos = screen.availWidth/2 - wd/2; 
   var ypos = screen.availHeight/2 - hg/2; 
   remote = window.open('','','width=' + wd + ',height=' + hg + ',resizable=1,scrollbars=1,toolbar=1,menubar=1,screenX=0,screenY=0,top='+ypos+',left='+xpos);
   if (remote != null) {
      if (remote.opener == null) {
         remote.opener = self;
      }
      remote.location.href = loc;
      remote.focus();
   } 
   else { 
      self.close(); 
   }
}

function popup_win3( loc ) {
   var remote = null;
   var wd = 680;
   var hg = screen.availHeight * 0.8;
   var xpos = screen.availWidth/2 - wd/2; 
   var ypos = (screen.availHeight/2 - hg/2) - 64; 
   remote = window.open(loc, "newwindow", "toolbar=1,menubar=0,scrollbars=1,resizable=1,location=top,status=0,width="+wd+",height="+hg+",screenX=0,screenY=0,top="+ypos+",left="+xpos);
   if (remote != null) {
      if (remote.opener == null) {
         remote.opener = self;
      }
      remote.location.href = loc;
      remote.focus();
   } 
   else { 
      self.close(); 
   }
}

function open_url(url, x) {
   if ((x==1) && (window.opener!=null)) {
      window.self.close();
      window.opener.focus();
      window.opener.location.href = url;
   }
   else {
      var w = window.open(url, '_new');
      w.focus();
      w.opener = self;
   }
}
// -->
