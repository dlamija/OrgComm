//////////////////////////////////////////////////////////////////////////////////////////////////
// Misc Variables
	var timer;       			// holds the current timer value
	Menu_Over = null 			// Menu currently highlighted 
	MouseOver_bgColor ="#ffff66"// Color of the cell when mouse is over it
	OffsetMenuTop = 15 			// Offset Menu Top the height of the cell so it's top is at the cell bottom
//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
// This is the bit that does it all.
function ShowMenu(elem,HTML){
	if(Menu_Over!=null){if(!document.layers){Menu_Over.className='DropDownHeader'}}
	Menu_Over = elem
	if(!document.layers){elem.className='DropDownHeaderOver'}

	var HTMLCode = ''
	HTMLelem = eval(HTML)
	if(HTMLelem.length>0){
		HTMLCode += '<table cellpadding="1" cellspacing="0" border="0" class="DropDownOutBox"><tr><td>'
		HTMLCode += '<table cellpadding="3" cellspacing="0" border="0" class="DropDownSubBox">'
				for(i=0;i<HTMLelem.length;i++){
						if (HTMLelem[i][2]=='_blank'){
							URLCode = "window.open('"+ HTMLelem[i][1] +"');void('');";
						}else{
							URLCode   = HTMLelem[i][2]+".location.href='" + HTMLelem[i][1] + "'";
						}
						clearTimeout(timer)
						HTMLCode += '<tr><td class="DropDownSubText" onmouseover="javascript:style.background=\'' +
						    MouseOver_bgColor + '\'\;  clearTimeout(timer); " onclick="'+URLCode+'" onmouseout=\"javascript:style.background=\'transparent\'; timer=setTimeout(\'HideDiv()\',500); ">'
						HTMLCode += '<nobr>'+ HTMLelem[i][0] +'</nobr><br></td></tr>'
				}
		HTMLCode += '</table></td></tr></table>'

	}
		if(document.layers){
			document.OptionListDiv.left = findPosX(elem) 
			document.OptionListDiv.top = findPosY(elem)  + OffsetMenuTop 
			document.OptionListDiv.document.write(HTMLCode); document.layers['OptionListDiv'].document.close();
		}
		if(document.all){
			OptionListDiv.style.left = findPosX(elem)
			OptionListDiv.style.top = findPosY(elem) + OffsetMenuTop 
			OptionListDiv.innerHTML = HTMLCode
		}
		if(!document.all && document.getElementById){
			document.getElementById('OptionListDiv').style.left = findPosX(elem)
			document.getElementById('OptionListDiv').style.top = findPosY(elem) + OffsetMenuTop 
			document.getElementById('OptionListDiv').innerHTML = HTMLCode
		}

}

//////////////////////////////////////////////////////////////////////////////////////////////////
// find the Left position
function findPosX(obj){
	var curleft=0;
		if(document.getElementById||document.all){while(obj.offsetParent){curleft+=obj.offsetLeft;obj=obj.offsetParent;}}
		else if(document.layers){curleft+=obj.x;}
	return curleft;
}

//////////////////////////////////////////////////////////////////////////////////////////////////
// find the top position
function findPosY(obj){
	var curtop=0;
		if(document.getElementById||document.all){while(obj.offsetParent){curtop+=obj.offsetTop;obj=obj.offsetParent;}}
		else if(document.layers){curtop+=obj.y;}
	return curtop;
}

//////////////////////////////////////////////////////////////////////////////////////////////////
// set the mouse click mouseup event
if(document.layers)document.captureEvents(Event.MOUSEMOVE);document.onmouseup=HideDiv;

//////////////////////////////////////////////////////////////////////////////////////////////////
// hide the menu
function HideDiv(){
	if(Menu_Over!=null){
		if(!document.layers){Menu_Over.className='DropDownHeader'}
	}
	if(document.layers){document.OptionListDiv.top = -999}
	if(document.all){OptionListDiv.style.top = -999}
	if(!document.all && document.getElementById){document.getElementById('OptionListDiv').style.top = -999}
}
//////////////////////////////////////////////////////////////////////////////////////////////////