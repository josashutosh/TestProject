

// JScript File
//Ashok Mhatre
//Date: 27/11/2009
String.prototype.trim = function() { return this.replace(/^\s+|\s+$/, ''); };
//Selects item in list
function select(ctlName,strToShow){    
    if(ctlName)
    {
        for (var i = 0; i <ctlName.length; i++)
        {
            if(ctlName.options[i].value==strToShow){ ctlName.options[i].selected=true; break;}
        }
    }
}

function checkDigit(e){
    var k =(e.which)? e.which : e.keyCode;
	if((k < 47 && k !=8) || k > 57 )	
	    return false;
    else
        return true;
}

function checkDigits_(e)
{
    var k =(e.which)? e.which : e.keyCode;
	if(((k!=8 || k!=37 || k!=39) && (k < 46))||(k>57))
	    return false;
    else
        return true;
}

function CheckChar(e){//Allows Alphabets only 

    var key_code =(e.which)? e.which : e.keyCode;  
    if((key_code > 64 && key_code < 91) || (key_code > 96 && key_code < 123) || (key_code==8) )
        return true;
    else
	    return false;	
}

function CheckCharSpace(ctlid,e){//Allows Alphabets and space only 
    var key_code =(e.which)? e.which : e.keyCode; 
      var ctl = document.getElementById(ctlid);
    k =(e.which)? e.which : e.keyCode;   
    
    if((ctl.value.lastIndexOf(' ') == ctl.value.length - 1) && k == 32)
        return false;
      
    else if((key_code > 64 && key_code < 91) || (key_code > 96 && key_code < 123) || (key_code==32) ||(keyCode==8))
        return true;
    else
	    return false;	
}
function CheckAlphaNumeric(e){

    if(CheckChar(e) || checkDigit(e))
        return true
    else
        return false;
}
function checkForFirstSpace(ctlid, e)//Allows no first space and consecutive spaces...
{
    var ctl = document.getElementById(ctlid);
    k =(e.which)? e.which : e.keyCode;   
    
    if((ctl.value.lastIndexOf(' ') == ctl.value.length - 1) && k == 32)
        return false;
    else
        return true;        
}

function ExtraCheck(e)//Allows only ",", ".", ";", "/", "-", "'"
{ 
    var keyCode =(e.which)? e.which : e.keyCode;
    
    if(keyCode == 44 || keyCode == 45 || keyCode == 46 || keyCode == 47 || keyCode == 59 || keyCode == 39 || keyCode==8)
        return true;
    return false;
}

function AllowDash(e)//Allows "-" only ... Added By Ashok
{
    var keyCode =(e.which)? e.which : e.keyCode;
    if(keyCode == 45 || keyCode==8)
        return true;
    else
        return false;
}
function Alphanumeric(objVal,strError)//Check for AlphaNumeric values 
{
    objValue=document.getElementById(objVal);
    var charpos = objValue.value.search("[^A-Za-z0-9]");     
    if(objValue.value.length > 0 &&  charpos >= 0) 
    { 
        if(!strError || strError.length ==0) 
        { 
            strError = objValue.name+": Only digits allowed "; 
        }
        alert(strError);
        objValue.focus();
        return false;
    }
    return true;
}
function numeric(objVal,strError, Flag)//Check for Numeric values 
{
    objValue=document.getElementById(objVal);
    var charpos = objValue.value.search("[^0-9]"); 
    if(Flag != null && Flag == 1)
        charpos = objValue.value.search("[^0-9\.]"); 
    if(objValue.value.length > 0 &&  charpos >= 0) 
    { 
        if(!strError || strError.length ==0) 
        { 
            strError = objValue.name+": Only digits allowed "; 
        }
        alert(strError);
        objValue.focus();
        return false;
    }
    return true;
}
function ChangeDateFormat(date, currentformat, currentformatCharacter, newformat, newformatCharacter)//To Change DateFormat
{
    if(currentformat == newformat)
        return date;
    
    if(currentformatCharacter == newformatCharacter)
        return date;
    
    if(!(date == null || date == ""))
    {
        var datemembers = date.split(currentformatCharacter);
        
        var currentFormat = currentformat.split(currentformatCharacter);
        var newFormat = newformat.split(newformatCharacter);
        
        var length = currentFormat.length;
        
        var newDate = "";
        for(var i = 0; i < length; i++)
        {
            for(var j = 0; j < length; j++)
            {
                if(currentFormat[j] == newFormat[i])
                {
                    if(i == (length - 1))
                        newDate = newDate + datemembers[j]
                    else
                        newDate = newDate + datemembers[j] + newformatCharacter;
                }
            }
        }
        
        return newDate;
    }
    
    return date;
}
function checkDigitDot(e)//Allows digits and dot only
{         
    var kcode =(e.which)? e.which : e.keyCode;        
   
    var isdigit = checkDigits_(e);     
       
    if(isdigit || kcode == 46 || kcode == 8)
        return true;
    else
        return false;
} 
function checkOneDotAndDigits(ctlvalue, e)//Allows digits and only one dot...New made by ashok
{
    var kcode =(e.which)? e.which : e.keyCode;        
    if(ctlvalue.length > 0)
    {
        if(kcode == 46){
        
        if((ctlvalue.split(".").length - 1) > 0)
            return false;}
    }    
    return checkDigitDot(e); 
}
function CompareValues(ctlMin, ctlMax, strError){
    var objMin = document.getElementById(ctlMin);
    var objMax = document.getElementById(ctlMax);    
    if(eval(parseFloat(objMin.value.trim())) > eval(parseFloat(objMax.value.trim()))){
        if(!strError || strError.length ==0){
            alert(objMin.name + " : Contains value greater than " + objMax.name); objMin.focus();  
            return false;         
        }
        alert(strError); objMin.focus();
        return false;
    }
    return true;
}
/*below is function for checking required field.(Required field validation). This function has 3 parameters.
1  parameter is control name and other(2nd) is the error to be fired and 
3 Third parameter 'isZero' is newly added to check for nozero value. Pass 1 in this parameter to check for nonzero value as well as Numeric Data else pass only first two parameters */
      
 function required(objVal,strError, isZero){
    var objValue=document.getElementById(objVal);    
     if(eval(objValue.value.trim().length) == 0 ){
         if(!strError || strError.length ==0){
            alert(objValue.name + " : Required Field"); objValue.focus();  
            return false;         
         }      
         alert(strError); objValue.focus(); 
         return false;            
     }
     if(isZero != null){
        if(isZero == 1){
            if(!numeric(objVal, "Please enter Numeric Data only.", 1))
                return false;
            if(!CheckForZero(objValue))
                return false;            
        }
     }
     return true; 
 }
function CheckForZero(ctlobj){    
    if(eval(parseFloat(ctlobj.value.trim())) == 0 || ctlobj.value.trim() == '.'){
        alert("Please enter valid Data");  ctlobj.focus(); 
        return false;            
    }   
    return true; 
}

/*below is function for checking required field.(Required field validation). This function has 3 parameters.
1  parameter is control name and other(2nd) is the error to be fired and 
3 [Note: Modified to take zero] Third parameter 'isZero' is newly added to check for nozero value [including zero]. Pass 1 in this parameter to check for nonzero value [including zero] as well as Numeric Data else pass only first two parameters */
      
 function requiredAT(objVal,strError, isZero){
    var objValue=document.getElementById(objVal);    
     if(eval(objValue.value.trim().length) == 0 ){
         if(!strError || strError.length ==0){
            alert(objValue.name + " : Required Field"); objValue.focus();  
            return false;         
         }      
         alert(strError); objValue.focus(); 
         return false;            
     }
     if(isZero != null){
        if(isZero == 1){
            if(!numeric(objVal, "Please enter Numeric Data only.", 1))
                return false;
            if(!CheckForZeroAT(objValue))
                return false;            
        }
     }
     return true; 
 }
function CheckForZeroAT(ctlobj){    
    if(ctlobj.value.trim() == '.'){
        alert("Please enter valid Data");  ctlobj.focus(); 
        return false;            
    }   
    return true; 
}

 /*below is function to restrict user from selecting specified number of data in dropdown. This function has 3 parameters.
1  parameter is control name, 2 one is index number in dropdown and 3rd one is the error to be fired. */
         
 function dontselect(objVal,indexNo,strError){
    var objValue=document.getElementById(objVal);
    var finalerr="";
    if(!objValue) {alert("Control with id " + objVal + " not found"); return;}
    if(objValue.selectedIndex == null) 
        finalerr="BUG: dontselect command for non-select Item";
    
    if(objValue.selectedIndex == eval(indexNo)){ 
        if(!strError || strError.length ==0) 
            strError = objValue.name+": Please Select one option "; 
        finalerr=strError;                
    }
    if(finalerr.length != 0){
        alert(finalerr); objValue.focus();  
        return false;
    }
    return true; 
}
/****************************************************/
//Added to get total window hieght and width; required for transparent layer to display;
//Also Contains the function to hide all page dropdown;

//For window hieght and width:
function getHeightWidth(){
	var d= document.documentElement;
	var b= document.body;
	var who= d.offsetHeight? d: b;//alert(who.scrollHeight);alert(who.offsetHeight);alert(who.scrollHeight - who.offsetHeight);
	return [Math.max(who.scrollWidth,who.offsetWidth), Math.max(who.scrollHeight,who.offsetHeight)];
}
function getPageSizeWithScroll(){//New one
	if (window.innerHeight && window.scrollMaxY) {// Firefox
		yWithScroll = window.innerHeight + window.scrollMaxY;
		xWithScroll = window.innerWidth + window.scrollMaxX;
	} else if (document.body.scrollHeight > document.body.offsetHeight){ // all but Explorer Mac
		yWithScroll = document.body.scrollHeight;
		xWithScroll = document.body.scrollWidth;
	} else { // works in Explorer 6 Strict, Mozilla (not FF) and Safari
		yWithScroll = document.body.offsetHeight;
		xWithScroll = document.body.offsetWidth;
  	}
	//arrayPageSizeWithScroll = new Array(xWithScroll,yWithScroll);
	//alert( 'The height is ' + yWithScroll + ' and the width is ' + xWithScroll );
	return { X : xWithScroll, Y : yWithScroll};
}

function GetWindowtSize() {
  var myWidth = 0, myHeight = 0;
  try{
      if( typeof( window.innerWidth ) == 'number' ) {
        //Non-IE
        myWidth = window.innerWidth;
        myHeight = window.innerHeight;
      } else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {
        //IE 6+ in 'standards compliant mode'
        myWidth = document.documentElement.clientWidth;
        myHeight = document.documentElement.clientHeight;
      } else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) ) {
        //IE 4 compatible
        myWidth = document.body.clientWidth;
        myHeight = document.body.clientHeight;
      }
      //window.alert( 'Width = ' + myWidth );
      //window.alert( 'Height = ' + myHeight );
  }catch(e){alert("Error is here");}
  var ScrollXY = getScrollXY();
  var WHeightWidth = getHeightWidth();//alert(ScrollXY[1]);
  return { X : eval("ScrollXY[0] != 0 ? Math.min(myWidth + ScrollXY[0], WHeightWidth[0]) : WHeightWidth[0]") , Y: eval("ScrollXY[1] != 0 ? Math.min(myHeight + ScrollXY[1], WHeightWidth[1]) : WHeightWidth[1]") };
}
function getScrollXY() {
    var scrOfX = 0, scrOfY = 0;
    try{      
      if( typeof( window.pageYOffset ) == 'number' ) {
        //Netscape compliant
        scrOfY = window.pageYOffset;
        scrOfX = window.pageXOffset;
      } else if( document.body && ( document.body.scrollLeft || document.body.scrollTop ) ) {
        //DOM compliant
        scrOfY = document.body.scrollTop;
        scrOfX = document.body.scrollLeft;
      } else if( document.documentElement && ( document.documentElement.scrollLeft || document.documentElement.scrollTop ) ) {
        //IE6 standards compliant mode
        scrOfY = document.documentElement.scrollTop;
        scrOfX = document.documentElement.scrollLeft;
      }
  }catch(e){alert("Error is here");}
  return [ scrOfX, scrOfY ];
}

//to hide all page dropdown
function getDIvAbsolutePos(el) {//alert(el);
    var r;
    try{
	    var SL = 0, ST = 0;
	    var is_div = /^div$/i.test(el.tagName);
	    if (is_div && el.scrollLeft)
		    SL = el.scrollLeft;
	    if (is_div && el.scrollTop)
		    ST = el.scrollTop;
	    r = { x: el.offsetLeft - SL, y: el.offsetTop - ST };
	    if (el.offsetParent) {
		    var tmp = this.getDIvAbsolutePos(el.offsetParent);
		    r.x += tmp.x;
		    r.y += tmp.y;
	    }
	}catch(e){alert("Error is here");}
	return r;
}

function hideShowDropCovered(hideFlag, ContentWindow){
	var self = document.getElementById('dimmer');
	self.hidden = hideFlag;
	var iskhtml = false;
	//alert(self);
	try{
	    _continuation_for_the_khtml_browser(self,false, ContentWindow);
	}catch(ex){alert("Error");}
	
	return;
}
function _continuation_for_the_khtml_browser(self,iskhtml, _document) {
	var tags = new Array("applet", "iframe", "select");
	var el = self;
    
	for (var k = tags.length; k > 0; ) {
		var ar = _document.getElementsByTagName(tags[--k]);
		var cc = null;
        
        if(ar.length > 0){
		    for (var i = ar.length; i > 0;) {
			    cc = ar[--i];			    
		        if (self.hidden){
			        if (!cc.__msh_save_visibility) {
				        cc.__msh_save_visibility = getVisibility(cc, iskhtml);
			        }					
			        cc.style.visibility = cc.__msh_save_visibility;
    				
		        } else {
			        if (!cc.__msh_save_visibility) {
				        cc.__msh_save_visibility = getVisibility(cc, iskhtml);
			        }					
			        cc.style.visibility = "hidden";				
		        }			    
		    }
		}
	}
	return;
}
function getVisibility(obj, iskhtml){    
	var value = obj.style.visibility;
	try{
	    if (!value) 
	    {
		    if (document.defaultView && typeof (document.defaultView.getComputedStyle) == "function") { // Gecko, W3C
			    if (!iskhtml)
				    value = document.defaultView.
					    getComputedStyle(obj, "").getPropertyValue("visibility");
			    else
				    value = '';
		    } else if (obj.currentStyle) {// IE
			    value = obj.currentStyle.visibility;
		    } else
			    value = '';
	    }
	}catch(e){alert("Error is here");}
	return value;
}
/****************************************************/
function RemoveListBoxItem(ctlID, ItemIndex){
    var ctl = document.getElementById(ctlID);
    if(ctl.options.remove) ctl.options.remove(ItemIndex);
    else ctl.remove(ItemIndex);
}

/******************* Date Function *****************************/
    function _AddDate(_Date, DaysToAdd, MonthstoAdd, YearstoAdd)
    {
        if(_Date != null)
        {
            var Original_Date = _Date; 
            _Date = AddYears(_Date, YearstoAdd);//alert(_Date);
            _Date = AddMonths(_Date, MonthstoAdd);//alert(_Date);
            _Date = isLeapYear(Original_Date, _Date);
            _Date = AddDays(_Date, DaysToAdd);//alert(_Date);            
        }
        return _Date;
    }    
    function AddYears(_YDate, YeartoAdd)
    {
        var nullFlag = (YeartoAdd == null || YeartoAdd == "" || parseInt(YeartoAdd) == 0);
        
        if(!nullFlag){
            var new_Date = new Date(_YDate);
            new_Date.setFullYear(parseInt(new_Date.getFullYear()) + parseInt(YeartoAdd)); 
            _YDate = new_Date;            
        }        
        return _YDate;
    }
    function AddMonths(_MDate, MonthtoAdd)
    {
        var nullFlag = (MonthtoAdd == null || MonthtoAdd == "" || parseInt(MonthtoAdd) == 0); 
        
        if(!nullFlag && parseInt(MonthtoAdd) >= 12)
        {
            _MDate = AddYears(_MDate, parseInt(MonthtoAdd)/12);
            MonthtoAdd = parseInt(MonthtoAdd) % 12;
        }
        var _month = _MDate.getMonth();
        if(!nullFlag && MonthtoAdd != 0)
        {
            _MDate = new Date(new Date(_MDate).setMonth(_MDate.getMonth() + parseInt(MonthtoAdd)));
        }
        return _MDate;
    }
    function AddDays(_DDate, DaytoAdd)
    {
        var nullFlag = (DaytoAdd == null || DaytoAdd == "" || parseInt(DaytoAdd) == 0);
        var Original_Date = _DDate;       
        
        if(!nullFlag){
            var _Day = _DDate.getDate();
            var _DaysInMonth = daysInMonth(_DDate.getMonth(), _DDate.getFullYear());     
            _DDate = new Date(new Date(_DDate).setDate(_DDate.getDate() + DaytoAdd));            
        }
        return _DDate;
    }
    function isLeapYear(_OriginalDate, _NewDate){
        if(parseInt(_OriginalDate.getMonth()) == 1 && parseInt(_OriginalDate.getDate()) == 29 && (_OriginalDate != _NewDate))
            if(daysInMonth(1, _OriginalDate.getFullYear()) == 29 && daysInMonth(1, _NewDate.getFullYear()) == 28)
                _NewDate = AddDays(_NewDate, 1);
        return _NewDate;
    }
    function Days_InMonth(iMonth, iYear){//Giving wrong value for June; for this just subtract 1 from iMonth;
	    return 32 - new Date(iYear, iMonth -1, 32).getDate();
    }
    function daysInMonth(month,year) {//Added on 23/12/2009
		var m = [31,28,31,30,31,30,31,31,30,31,30,31];
		if (month != 2) return m[month - 1];
		if (year%4 != 0) return m[1];
		if (year%100 == 0 && year%400 != 0) return m[1];
		return m[1] + 1;
	}  
/******************* End of Date Function *****************************/

/******************************************************************************************************/
/*
 * Accepts a date, a mask, or a date and a mask.
 * Returns a formatted version of the given date.
 * The date defaults to the current date/time.
 * The mask defaults to dateFormat.masks.default.
 */

var dateFormat = function () {
	var	token = /d{1,4}|m{1,4}|yy(?:yy)?|([HhMsTt])\1?|[LloSZ]|"[^"]*"|'[^']*'/g,
		timezone = /\b(?:[PMCEA][SDP]T|(?:Pacific|Mountain|Central|Eastern|Atlantic) (?:Standard|Daylight|Prevailing) Time|(?:GMT|UTC)(?:[-+]\d{4})?)\b/g,
		timezoneClip = /[^-+\dA-Z]/g,
		pad = function (val, len) {
			val = String(val);
			len = len || 2;
			while (val.length < len) val = "0" + val;
			return val;
		};

	// Regexes and supporting functions are cached through closure
	return function (date, mask, utc) {
		var dF = dateFormat;

		// You can't provide utc if you skip other args (use the "UTC:" mask prefix)
		if (arguments.length == 1 && Object.prototype.toString.call(date) == "[object String]" && !/\d/.test(date)) {
			mask = date;
			date = undefined;
		}

		// Passing date through Date applies Date.parse, if necessary
		date = date ? new Date(date) : new Date;
		if (isNaN(date)) throw SyntaxError("invalid date");

		mask = String(dF.masks[mask] || mask || dF.masks["default"]);

		// Allow setting the utc argument via the mask
		if (mask.slice(0, 4) == "UTC:") {
			mask = mask.slice(4);
			utc = true;
		}

		var	_ = utc ? "getUTC" : "get",
			d = date[_ + "Date"](),
			D = date[_ + "Day"](),
			m = date[_ + "Month"](),
			y = date[_ + "FullYear"](),
			H = date[_ + "Hours"](),
			M = date[_ + "Minutes"](),
			s = date[_ + "Seconds"](),
			L = date[_ + "Milliseconds"](),
			o = utc ? 0 : date.getTimezoneOffset(),
			flags = {
				d:    d,
				dd:   pad(d),
				ddd:  dF.i18n.dayNames[D],
				dddd: dF.i18n.dayNames[D + 7],
				m:    m + 1,
				mm:   pad(m + 1),
				mmm:  dF.i18n.monthNames[m],
				mmmm: dF.i18n.monthNames[m + 12],
				yy:   String(y).slice(2),
				yyyy: y,
				h:    H % 12 || 12,
				hh:   pad(H % 12 || 12),
				H:    H,
				HH:   pad(H),
				M:    M,
				MM:   pad(M),
				s:    s,
				ss:   pad(s),
				l:    pad(L, 3),
				L:    pad(L > 99 ? Math.round(L / 10) : L),
				t:    H < 12 ? "a"  : "p",
				tt:   H < 12 ? "am" : "pm",
				T:    H < 12 ? "A"  : "P",
				TT:   H < 12 ? "AM" : "PM",
				Z:    utc ? "UTC" : (String(date).match(timezone) || [""]).pop().replace(timezoneClip, ""),
				o:    (o > 0 ? "-" : "+") + pad(Math.floor(Math.abs(o) / 60) * 100 + Math.abs(o) % 60, 4),
				S:    ["th", "st", "nd", "rd"][d % 10 > 3 ? 0 : (d % 100 - d % 10 != 10) * d % 10]
			};

		return mask.replace(token, function ($0) {
			return $0 in flags ? flags[$0] : $0.slice(1, $0.length - 1);
		});
	};
}();

// Some common format strings
dateFormat.masks = {
	"default":      "ddd mmm dd yyyy HH:MM:ss",
	shortDate:      "m/d/yy",
	mediumDate:     "mmm d, yyyy",
	longDate:       "mmmm d, yyyy",
	fullDate:       "dddd, mmmm d, yyyy",
	shortTime:      "h:MM TT",
	mediumTime:     "h:MM:ss TT",
	longTime:       "h:MM:ss TT Z",
	isoDate:        "yyyy-mm-dd",
	isoTime:        "HH:MM:ss",
	isoDateTime:    "yyyy-mm-dd'T'HH:MM:ss",
	isoUtcDateTime: "UTC:yyyy-mm-dd'T'HH:MM:ss'Z'"
};

// Internationalization strings
dateFormat.i18n = {
	dayNames: [
		"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat",
		"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
	],
	monthNames: [
		"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
		"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"
	]
};

// For convenience...
Date.prototype.format = function (mask, utc) {
	return dateFormat(this, mask, utc);
};
/**************************************************************************************/

/**************************** Function TO scroll page ***********************************/

var scrollcount = 0, scroll = null, _MAX_Scroll = 0, _scroll_Displacement = 0, _pagescrollDelay = 0;
function pageScroll() {
	if(scrollcount != _MAX_Scroll){scrollcount += _scroll_Displacement; 
	    window.scrollBy(0, _scroll_Displacement); // horizontal and vertical scroll increments
	    scroll = setTimeout('pageScroll()', _pagescrollDelay); // scrolls every _pagescrollDelay milliseconds
	}else stopScroll();
} 
function stopScroll() {
	clearTimeout(scroll);
}
function Scroll_Page(MAX_Scoll, scroll_Displacement, pagescrollDelay){
    _MAX_Scroll = MAX_Scoll; _scroll_Displacement = scroll_Displacement; _pagescrollDelay = pagescrollDelay;
    pageScroll();//setTimeout('stopScroll()', (MAX_Scoll * pagescrollDelay) / scroll_Displacement + pagescrollDelay);
}

/***************************End of Function TO scroll page***********************/

function ClearContol(ctlId){
    var ctl = document.getElementById(ctlId);        
    if(ctl.type && ctl.type != "text"){ ctl.length = 0; var newElement = new Option("Select", "", false, false); ctl[0] = newElement; }
    else{ if(ctl.value) ctl.value = ""; else ctl.innerText = "";}
}