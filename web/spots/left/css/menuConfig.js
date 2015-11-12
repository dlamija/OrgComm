var listMenu = new FSMenu('listMenu', true, 'visibility', 'visible', 'hidden');			// Main Menu

//listMenu.showDelay = 0;
//listMenu.switchDelay = 125;
//listMenu.hideDelay = 500;
listMenu.cssLitClass = 'highlighted';

function animClipDown(ref, counter)
{
 var cP = Math.pow(Math.sin(Math.PI*counter/200),0.75);
 ref.style.clip = (counter==100 ?
  ((window.opera || navigator.userAgent.indexOf('KHTML') > -1) ? '':
   'rect(auto, auto, auto, auto)') :
    'rect(0, ' + ref.offsetWidth + 'px, '+(ref.offsetHeight*cP)+'px, 0)');
};

function animFade(ref, counter)
{
 var f = ref.filters, done = (counter==100);
 if (f)
 {
  if (!done && ref.style.filter.indexOf("alpha") == -1)
   ref.style.filter += ' alpha(opacity=' + counter + ')';
  else if (f.length && f.alpha) with (f.alpha)
  {
   if (done) enabled = false;
   else { opacity = counter; enabled=true }
  }
 }
 else ref.style.opacity = ref.style.MozOpacity = counter/100.1;
};

/*
var detect = navigator.userAgent.toLowerCase();
if (checkStr('netscape'))
{
	listMenu.animations[listMenu.animations.length] = animFade; 
	/*listMenu.animations[listMenu.animations.length] = animClipDown; * /
	listMenu.animSpeed = 99;
}
*/

var arrow = null;
if (document.createElement && document.documentElement)
{
	arrow = document.createElement('img');
	arrow.src = arrowImg;
	arrow.style.borderWidth = '0';
	arrow.className = 'subind';
}
addEvent(window, 'load', new Function('listMenu.activateMenu("listMenuRoot", arrow)'));// Main Menu


function checkStr(string)
{
	place = detect.indexOf(string) + 1;
	thestring = string;
	return place;
}