<!--

var validated=true;  // global

// call this from onchange
function valid(vl,errm) // varying number of arguments
{
	var i;
	var arrTypo = new Array();
	validated=true;
	// error message for typo error
	typoErrMsg="WARNING: Your email address might not be valid because it contains a spelling error. Please check again";

	// Regular expression for typo errors
	arrTypo[0] = "[\\w-\\.]{1,}\\@[\\w-\\.\\@]{0,}(rediff|htomail|htomil|htomai|htomal|htomial|hotmil)s*.co[m]{0,1}[\\w\\.\\@]{0,}"
	arrTypo[1] = "[\\w-\\.]{1,}\\@[\\w-\\.]{1,}(rediff|rediffmail|hotmail|hotm[ail]s?).com[\\w-\\.\\@]{0,}"
	arrTypo[2] = "[\\w-\\.]{1,}\\@[\\w-\\.]{1,}(rediffmail|hotmail|hotm[ail]s?)[\\w-\\.]{1,}.com[\\w\\.\\@]{0,}"
	arrTypo[3] = "[\\w-\\.]{1,}\\@(rediffmail|hotmail)[\\w-\\.]{1,}.co[m]{0,1}[\\w-\\.\\@]{0,}"
	arrTypo[4] = "[\\w-\\.]{1,}\\@(rediffmail|hotmail).com[\\w-\\.\\@]{1,}"
	arrTypo[5] = "[\\w-\\.]{1,}\\@[\\w-\\.\\@]{1,}yahoo[\\w\\.]{1,}.(com|co.uk|co.in)"
	arrTypo[6] = "[\\w-\\.]{1,}\\@[\\w-\\.\\@]{1,}yahoo.(com|co.uk|co.in)"
	arrTypo[7] = "[\\w\\.\\@]{1,}\\@yahoo[\\w-\\.]{1,}.(com|co.uk|co.in)"
	arrTypo[8] = "[\\w-\\.]{1,}\\@[\\w-\\.\\@]{0,}yahoo[\\w]{0,}.com.in"
	arrTypo[9] = "[\\w-\\.]{1,}\\@[\\w-\\.\\@]{0,}yahoo[\\w]{0,}.com.uk"
	arrTypo[10] = "[\\w-\\.]{1,}\\@[\\w-\\.\\@]{0,}y(o|a)*ho{3,}[\\w]{0,}.(com|co.uk|co.in)"
	arrTypo[11] = "[\\w-\\.]{1,}\\@[\\w-\\.\\@]{0,}yahoo.uk.co[\\w-\\.]{0,}"
	arrTypo[12] = "[\\w-\\.]{1,}\\@[\\w-\\.\\@]{1,}tm[.,]net[.,]my[\\w]{1,}"
	arrTypo[13] = "[\\w-\\.]{1,}\\@[\\w-\\.\\@]{1,}tm[.,]net[.,]my"
	arrTypo[14] = "[\\w-\\.]{1,}\\@tm[.,]net[.,]my[\\w]{1,}"
	arrTypo[15] = "[\\w-\\.]{1,}\\@[\\w-\\.\\@]{0,}tm[.,]com[.,my][\\w]{0,}"
	arrTypo[16] = "[\\w-\\.]{1,}\\@usa[.,]net[\\w-\\.\\@]{1,}"
	arrTypo[17] = "[\\w-\\.\\@]{1,}\\@[\\w-\\.\\@]{1,}usa[.,]net[\\w-\\.\\@]{1,}"
	arrTypo[18] = "[\\w-\\.\\@]{1,}\\@[\\w-\\.\\@]{1,}usa[.,]net"
	arrTypo[19] = "[\\w-\\.]{1,}\\@pacific[.,]net[.,]sg[\\w-\\.\\@]{1,}"
	arrTypo[20] = "[\\w-\\.]{1,}\\@[\\w-\\.\\@]{1,}pacific[.,]net[.,]sg"
	arrTypo[21] = "[\\w-\\.]{1,}\\@[\\w-\\.\\@]{1,}pacific[.,]net[.,]sg[\\w-\\.\\@]{1,}"
	arrTypo[22] = "[\\w-\\.\\@]{0,}www.[\\w-\\.\\@]{0,}"

	// check email format
	//rx=new RegExp("[\\w-_]+(\\.[\\w-_]+)*\\@+[\\w-_]+(\\.[\\w-_]+)+");
	for (i=2;i<valid.arguments.length;i++) 
	    rx=new RegExp(valid.arguments[i]);

	if ((a=rx.exec(vl))!=null && a[0].length==vl.length)
	{
		validated=true;
	}
	else{
		// return false once it finds any format error
		alert(errm)
		validated=false;
		return false;
	}

	// if the email don't have any format error
	// check for any typo error
	// the loop will exit once it found any typo error
	if (validated)
	{
		for (i=0;i<arrTypo.length;i++) 
		{
			var rx;
			//alert(arrTypo[i]);
			rx=new RegExp(arrTypo[i]);
			if ((a=rx.exec(vl))!=null && a[0].length==vl.length) {
				alert(typoErrMsg);
				validated=false;
				return false; 
			}
		}

		return validated;
	}

}

function ValidateOneEmail(ctl)
{
    var vl =ctl.value;
	var validErr = true;
	
	// scan for typo errors for the following domains:
	//	 - hotmail.com
	//   - yahoo.com, yahoo.co.uk, yahoo.co.in
	//   - rediffmail.com
	//   - tm.net.my
	validErr=valid(vl,"Invalid email. Please enter a valid email address.","[\\w-_]+(\\.[\\w-_]+)*\\@+[\\w-_]+(\\.[\\w-_]+)+");

	if (!validErr) {
      ctl.focus();
    }
	
    if (vl.indexOf('@jobstreet.com') > 0) {
	   alert ("WARNING: Please change your email address. If you use an email address with the JobStreet.com name, you will not receive any email from the employers. You can open an email address with any of the free web-based email providers (www.hotmail.com or www.yahoo.com) before you create a MyJobStreet account.");
	   ctl.focus();
    } 
	else{
		return validErr;
	}
}

function isConfirm(msg) {
	var reply;
	
	reply = confirm(msg);
	if (reply)
		return true;
	else
		return false;	
}

function checkSpecializationLimit(objSpecialization)
{
	intTotalSpecialization = 0;
	for(i=0;i<objSpecialization.length;i++)
	{
		if(objSpecialization[i].checked)
			intTotalSpecialization++;
	}
	if(intTotalSpecialization > 30)
	{
		alert("You cannot select more than 30 \"Preferred Job specialization\" at one time. Please revise your selection.");
		return false;
	}
	else
		return true;
}

function Trim(str) {
	var res = /^\s+/ig;
	var ree = /\s+$/ig;
	var out = str.replace(res,"").replace(ree,"");
    return out;
}

function ValidatePassword(ctlPassowrd, ctlConfirmPassword) {
	if (ctlPassowrd.value.length < 6) {
    		alert('Your password should contain at least 6 characters for security reasons.');
    		ctlPassowrd.focus();
    		validated = false;
    		return false;
  	}	
 	
  	if (ctlPassowrd.value == ctlConfirmPassword.value) {
		validated = true;
		return true;
	} else {
		alert('Your password confirmation does not match, please re-enter your password');
		ctlConfirmPassword.focus();
		validated = false;
		return false;
	}
}

function CountPassword(ctl) {
	if(ctl.value.length > 10 ) {	
		alert('Your password has exceeded 10 characters. Please keep to 6 to 10 characters.');
		ctl.focus();
		return false;
	}
	
}

function ValidateText(ctl,msg) {
	var temp_str = Trim(ctl.value);

	if (temp_str == "") {
		ctl.value = "";
	  	alert(msg);
	  	ctl.focus();
	  	validated = false;
	  	return false;
	} else {
		ctl.value = temp_str;
		validated = true;
		return true;
	}
}

function ValidateCtl(ctl, msg, compulsory) {

//alert(GetValueFromCtl(ctl));

	if (GetValueFromCtl(ctl) == "" && compulsory=="1") {
		alert(msg);
		ctl.focus();
		validated = false;
		return false;
	} else {
		validated = true;
		return true;
	}
}

function ValidateList(ctl,msg,ctlfocus) {
	var temp_str = Trim(ctl.value);
	
	if (temp_str == "") {
	  alert(msg);
	  ctlfocus.focus();
	  validated = false;
	  return false;
	}
	else {
	  ctl.value = temp_str;
	  validated = true;
	  return true;
	}
}





function GetValueFromCtl (ctl) {
	for (var i=0; i < ctl.options.length; i++) {		
		if(ctl.options[i].selected ) {
			if (ctl.options[i].value == "" || ctl.options[i].value == "0" || ctl.options[i].value == "-" || ctl.options[i].value == "00" || ctl.options[i].value == "000") {
				return "";
			} else
				return ctl.options[i].value;
		}
	}
	return "";
}



function ValidateSkill(clt,drp,req){


	if(req=="1"){
		if (Trim(clt.value)==""){
			alert("Please enter your top 3 skills.");
			validated = false;
			return false;
		}
		else{
			if(GetValueFromCtl(drp) == ""){
				alert("Please select the Years of Experience.");
				drp.focus();
				validated = false;
				return false;
			}
		}
	}
	else{	

		if(Trim(clt.value)!=""){
			if(GetValueFromCtl(drp) == ""){
				alert("Please select the Years of Experience.");
				drp.focus();
				validated = false;
				return false;
			}
		}
		else{
			if(GetValueFromCtl(drp) != ""){
				alert("Please enter the Skill.");
				clt.focus();
				validated = false;
				return false;
			}
		}

	}

}

function ValidateDup(frm,clt,drp){

	var err=0;
	var arrSkill = new Array();
	arrSkill[0] = frm.skill1.value;
	arrSkill[1] = frm.skill2.value;
	arrSkill[2] = frm.skill3.value;
	arrSkill[3] = frm.skill4.value;
	arrSkill[4] = frm.skill5.value;

	if(Trim(clt.value)!=""){
		if(GetValueFromCtl(drp) == ""){
			alert("Please select the Years of Experience.");
			drp.focus();
			validated = false;
			return false;
		}
	}
	else{
		if(GetValueFromCtl(drp) != ""){
			alert("Please enter the Skill.");
			clt.focus();
			validated = false;
			return false;
		}
	}

	for(var i=0;i<5;i++){
		for(var j=0;j<5;j++){
			if(arrSkill[i] == arrSkill[j] && arrSkill[i] != "" && arrSkill[j] != "" && i!=j){
				err=1;
			}
		}		
	}

	if (err==1) {
		alert("You have entered one or more duplicate skills. Please enter another Skill.");
		frm.skill1.focus();
		validated = false;
		return false;
	}	
	
}

function GetTextFromCtl (ctl) {
	for (var i=0; i < ctl.options.length; i++) {
		if(ctl.options[i].selected ) {
			return ctl.options[i].text;
		}
	}
	return "";
}

function ValidateDate(aday,amonth,ayear,maxyear,intType,msg,compulsory) {
	var tempDate; //= aday.value + amonth.value + ayear.value;
	var tempDay;
	var tempMonth;
	var tempYear;

	if (intType & 1)
		tempDay	= GetValueFromCtl(aday);
	else
		tempDay	= 1;


	if (intType & 2)
		tempMonth = GetValueFromCtl(amonth);
	else
		tempMonth = 1;

	if (intType & 4)
		tempYear = ayear.value;
	else
		tempYear = 1900;

	if (maxyear == 0)
		maxyear = 2999;

	tempDate = tempDay + tempMonth + tempYear;

	if (tempYear != '' && tempYear < 1900  || tempYear > maxyear) 
		validated = false;
	else 
	{
		var test = new Date(tempYear,tempMonth-1,tempDay);
    		if ((test.getFullYear() == tempYear) && (tempMonth - 1 == test.getMonth()) && (tempDay == test.getDate()))
        			validated = true;
    		else
			validated = false;
	}    

	if (compulsory == '0' && tempDate == '')
		validated = true;

	if (validated == false) {
		alert(msg);
		if (tempDay =="0" && (intType & 1)) {
			aday.focus();
		} else if (tempMonth =="0" && (intType & 2)) {
			amonth.focus();
		} else {
			ayear.focus();
		}
	}
	return validated;
}

	
function ValidateNumber(ctl, min_val, max_val, msg, compulsory) {
    var temp_num = Trim(ctl.value);
    if (compulsory == "0" && temp_num.length == 0) {
          ctl.value = temp_num;
          validated = true;
          return true;
    }
    else {
      if (isReal(temp_num) && temp_num.length > 0) {
         if ((temp_num < min_val) || (temp_num > max_val)) {
  		    alert(msg + " within the range of " + min_val + " to " + max_val + ".");
            ctl.focus();
	        validated = false;
	        return false;
         }
         else {
		    ctl.value = temp_num;
	        validated = true;
            return true;
         }
       }
       else {
	  	    alert(msg + ". Your entry was invalid.");
	        ctl.focus();
	        validated = false;
	        return false;
       }
     }
}


function isInt(string) {
    for (var i=0;i < string.length;i++)
        if ((string.substring(i,i+1) < '0') || (string.substring(i,i+1) > '9') )
            return false;
	return true;
}

function isReal(string) {
    var decimal_found = false;
    var ws;

    for (var i=0;i < string.length;i++)
      if ((string.substring(i,i+1) < '0' || string.substring(i,i+1) > '9') && string.substring(i,i+1) != '.') {
            return false;
      }
      else {
        if (string.substring(i,i+1) == '.') {
          if (decimal_found == true) {
            return false;
          }
          else {
            decimal_found = true;
          }
        }   
      }
    return true;      
}

/// EXPERIENCE SECTION ///
function ExperienceChecked(frm) {
	if (frm.freshgrad[0].checked == true) {
		frm.years_worked.value = "";
		frm.qualification_id1.focus();
		this.document.location.assign('#skip');
	} else {
		frm.years_worked.focus();
	}
}


function ValidateExperienceCtl(frm,ctl,msg) {

	if (typeof(frm.freshgrad) == 'undefined'  && GetValueFromCtl(ctl) == "") {
		alert(msg);
		ctl.focus();
		validated = false;
		return false;
	} else {
		if (frm.freshgrad[1].checked == true && GetValueFromCtl(ctl) == "") {
			alert(msg);
			ctl.focus();
			validated = false;
			return false;
		} else {
			validated = true;
			return true;
		}
	}
}

function ValidateExperienceNumber(frm,ctl,min_val,max_val,msg) {

	if (frm.freshgrad[0].checked == false && frm.freshgrad[1].checked == false){
		alert("Please select whether you are a fresh graduate or you have working experience");
		validated = false;
		return false;
	} else {

		if (typeof(frm.freshgrad) == 'undefined') {
			ValidateNumber(ctl,min_val,max_val,msg,'1');
		} else {
			if (frm.freshgrad[1].checked == true) {
				ValidateNumber(ctl,min_val,max_val,msg,'1');
			}
		}
	}
}

function ValidateExperienceText(frm,ctl,msg) {
	var res = /^\s+/ig;
	var ree = /\s+$/ig;
	var temp_str = ctl.value.replace(res,"").replace(ree,"");

	if (typeof(frm.freshgrad) == 'undefined' && temp_str == "") {
		alert(msg);
		ctl.focus();
		validated = false;
		return false;
	} else {
		if (frm.freshgrad[1].checked == true && temp_str == "") {
			alert(msg);
			ctl.focus();
			validated = false;
			return false;
		} else {
			ctl.value = temp_str;
			validated = true;
			return true;
		}
	}
}

function ValidateExperienceDate(frm,aday,amonth,ayear,maxyear,intType,msg) {

	if (frm.freshgrad[0].checked == false && frm.freshgrad[1].checked == false){
		alert("Please select whether you are a fresh graduate or you have working experience");
		validated = false;
		return false;
	} else {

		if (typeof(frm.freshgrad) == 'undefined') {
			ValidateDate(aday,amonth,ayear,maxyear,intType,msg,1);
		} else {
			if (frm.freshgrad[1].checked == true) {
				ValidateDate(aday,amonth,ayear,maxyear,intType,msg,1);
			}
		}
	}
}
/// EXPERIENCE SECTION ///

/// Job Specialization Section ///
function addOption(frm,frObj,toObj) {

	var optionRank = toObj.options.length
	var str='';
	str = frm.specialization.value;
	if (toObj.options.length == 0) { str = ""; }
	var optionObject = new Option('','')
	for (var i=0;i<frObj.options.length;i++){
	   if (frObj.options[i].selected){
			if (str.indexOf(frObj.options[i].value)== -1){
			optionObject = new Option( frObj.options[i].text, frObj.options[i].value)			
			toObj.options[optionRank] = optionObject;           
			str=(str!='') ? str + ', '+ frObj.options[i].value : frObj.options[i].value;	   	
			optionRank = optionRank + 1;
	    }
	   }		
	}
    frm.specialization.value = str;
}

function deleteOption(frm,toObj) {

	var optionObject = new Option('','')	
	var j=0;	
	var str='';
	var sel='';
	
	for (var i=0;i<toObj.options.length;i++){	   
	   if (toObj.options[i].selected){
			toObj.options[i]=null;
			i = i - 1;
	   }
	   else{
			str=(str!='') ? str + ', '+ toObj.options[i].value : toObj.options[i].value;	   				
	   }
	}
	
    frm.specialization.value = str;
}

function ValidateJPList(ctl,msg) {

	if (ctl.length == 0) {
	  	alert(msg);
	  	ctl.focus();
	  	validated = false;
	  	return false;
	} else {		
		validated = true;
		return true;
	}
}

/// Job Specialization Section ///


// This scans all the onchanged routines
function onFrmSubmit(frm) {
	// force validation of all fields			  		
	var i;
	validated = true;	
	var NS4 = (document.layers) ? true : false;	
	
	for (i=0;i<frm.elements.length && validated;i++) {
		if (frm.elements[i].onchange!=null) {
			if (!NS4) {
				if (frm.elements[i].style.visibility != 'hidden') {
					frm.elements[i].onchange();  // force fire onchange event
				}
			}
		}
	}
	
	if (validated==true) {	  
	  frm.submit();
	}
}

function validateOption(ctl,msg) {
	var v = false;
	for (var i=0; i<ctl.length; i++) {            
		if (ctl[i].checked) {
			v = true;
		        break;
		}
	}
	if ((!v) && (msg!="")) {alert(msg);}
	return v;
}
		
function warnOnlinePayment(pm) {
	var v = true;
	v = validateOption(pm,"Please select your payment method.");
	if ((v) && (pm[0].checked)) 
		return confirm("IMPORTANT: \n\nIn order to provide the best security for your online purchase, details of this payment transaction is logged by JobStreet.com, including your IP address, and the date and time of this transaction. \n\nYou are required to use your own credit card to make the purchase. Fraudulent usage of credit cards is an offence and JobStreet.com is obliged to work with the authorities if fraudulent usage is suspected. \n\nSubscribers are fully advised to make their own informed decision before they subscribe to any of these services. Refunds will be given at the sole discretion of JobStreet.com if a subscribed member decides later to unsubscribe from these services. \n\nClick OK to proceed to make your payment.")
	else
		return v;
}		


// -->