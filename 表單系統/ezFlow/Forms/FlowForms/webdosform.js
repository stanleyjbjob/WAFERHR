/**
* webdosform.js 
* This file contain javascript event handlers and functions that
* make web form input behave as DOS form input.
* In a DOS form input, a user use keyboard as his primary input device instead of mouse. 
* It is much faster for a heavy data-entry user to use keyboard as their primary input device.
* This JavaScript library simulates DOS form input behavior, you can do all key-in use just one hand 
* and use keyboard only.
*
* 模擬DOS, 完全用Keyboard單手操作方式:
  o Page Load 時自動 Focus 在第一個輸入欄位.
  o 按<b> ENTER </b>鍵: 移至下一個欄位. 若已經到最後一個欄位, 自動循環至第一個欄位.
  o 按<b> DOWN </b>鍵: 移至下一個欄位. 若已經到最後一個欄位, 自動循環至第一個欄位.
  o 按<b> UP </b>鍵: 移至上一個欄位. 若已經到第一個欄位, 自動循環至最後一個欄位.
  o 按<b> LEFT </b>鍵: 如果目前停留在DropdownList, 自動選定上一個選項.  若已經到第一個選項, 自動循環至最後一個選項.
  o 按<b> RIGHT </b>鍵: 如果目前停留在DropdownList, 自動選定下一個選項.  若已經到最後個選項, 自動循環至第一個選項.
  o 按<b> SPACE </b>鍵: 如果目前停留在按鈕, 自動submit.
  o 按<b> PAGE UP </b>鍵: 呼叫doPageUp function. 如果你在此頁有定義此function,此function將會被呼叫!!
  o 按<b> PAGE DOWN </b>鍵: 呼叫doPageDown function. 如果你在此頁有定義此function,此function將會被呼叫!!
  o 當<b>輸入欄位的值得長度</b>等於欄位的<b>MaxLength</b>屬性時, 自動跳至下一個欄位.
  o 當<b>欄位編審失敗時</b>自動跳至第一個編審失敗欄位.
  o 設定<b>輸入遮罩 (Input Mask)</b> : 自訂輸入遮罩<br>
         o <b>c 或 C</b> : 表示此位置只能輸入英文字母(a-z A-Z )
         o <b>9</b> : 表示此位置只能輸入數字(0-9)
         o <b>@, $, %, (, ), -, {, }, [, ], ;, :, ', ", , (comma), ., /, _, =, +, 以及 space </b>: 特殊字元, 表示此位置只能輸入此特殊字元
  o 設定<b>輸入遮罩 (Input Mask)</b> : 特定輸入遮罩<br>
          o <b>INTEGER</b> : 表示此欄位只能輸整數(0-9 )
          o <b>REAL</b> : 表示此位置只能輸入實數(0-9 與小數點)
          o <b>CURRENCY</b> : 表示此位置只能輸入實數(0-9 與小數點) 而且在Form Load, onFocus 時會自動format. 而submit , onBlur 時會自動unformat 
*
* @author miles sun,  tony@jbjob.com.tw
* @version Revision: 1.0 Created: 2004-3-5  Modified: 2004-3-16	 	
*/

   // mForm is a array that contains managed elements in a HTML form.
   // The types this library managed including text,textare,select-one,submit element
   var mForm= new Array();
   // This library intercept submit event, it save the original submit event handler in mOriginalSubmit variable
   var mOriginalSubmit=null;


    /************    Event Handlers  *******/

    /**
     * In order to use webdosfrom JavaScript library, this function HAS TO be called after document is loaded.
     * You can achive this by calling this function in body tag eg:
     *                <body onload="webdosform_init(true);" >
     * or in a script eg:
     *                <script>document.onload=webdosform_init(true);</script> 
     *
     * If you want to use both input mask and DOS Form key,  pass true as the parameter.
     * Otherwise, you can only use input mask without DOS Form key
     */
     
    
     
   function webdosform_init(bDOSForm){
	var f=document.forms[0];
	reFillMForm();
	// mouseDown
	 document.onmousedown = mouseDown;
	// processKeyDown  event handler control input mask	
	document.onkeypress=processKeyPress;
	// the processKeyPress event handler control ENETR,SPACE,UP,DOWN,LEFT,RIGHT,PAGE UP,PAGE DWON
	if(bDOSForm==true) {
	   document.onkeydown=processKeyDown;
	}
	// webwinform_submit event handler unformat all currency elements and set the focus to the first validation-failed element
	mOriginalSubmit =f.onsubmit;
	f.onsubmit=webwinform_submit;
	//initialize the managed enviroment

	formatAllCurrencyElement();
	focusFirstInputElement();
	return true;
   }

   function webwinform_submit(){
	var retValue =true;
	if(typeof Page_BlockSubmit !="undefined"  ){
	   retValue=!Page_BlockSubmit ;
	}
	if(retValue){
	   unformatAllCurrencyElement();
	} else{
	   if (typeof(Page_ValidationVer) != "undefined") { // ASP.NET Validation
	      unformatAllCurrencyElement();
	      for (var i = 0; i < Page_Validators.length; i++) {
	         if (!Page_Validators[i].isvalid) {
	            var elem=document.getElementById(Page_Validators[i].controltovalidate);
	            var index=getElementIndex(elem);
                          setTimeout("setFocusByIndex("+index+")",0);
	            break;
	         }
	      }
	   }
	} 
	return retValue;
   } 
   
   	function  mouseDown()
	{
		//alert(_index+" : "+event.srcElement.type);
		cleanCss();
		//alert(event.srcElement.id+" : "+event.srcElement.type);
		if(event.srcElement.type == "text" || event.srcElement.type=="select-one" || event.srcElement.type == "button")
		{
			
			event.srcElement.className = "onFoucs";
		}
		
	
	}

   function processKeyDown(evt) {
	evt =(evt) ? evt : ((window.event) ? event : null);
	var elem = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement: null);
	var charCode=(evt.charCode) ? evt.charCode:((evt.which) ? evt.which : evt.keyCode);
	if(isManagedType(elem.type)==false)
	   return true;
	switch (charCode){
	   case 13: // ENTER
	      return doFocusNext(elem);
	      break;
	   case 32: // SPACE BAR
	      if(isButtonType(elem.type)){
	         emptySelection();
	      }
	      return true;
	      break;
	   case 37: // LEFT
 	      if(isButtonType(elem.type)){
	            return doFocusPrevious(elem);
	      }
	      if(elem.type=="select-one"){
	         if(elem.selectedIndex!=null){
	            if(elem.selectedIndex==0)
	               elem.selectedIndex=elem.options.length-1;
	            else
	               elem.selectedIndex-=1;
	         } else {
	            elem.selectedIndex=0;
	         }
	      }
	      break;
	   case 38: // UP
	      return doFocusPrevious(elem);
	      break;
	   case 39: // RIGHT
	       if(isButtonType(elem.type)){
	            return doFocusNext(elem);
	      }
	      if(elem.type=="select-one"){
	         if(elem.selectedIndex!=null){
	            if(elem.selectedIndex==(elem.options.length-1)){
	               elem.selectedIndex=0;
	            }else{
	               elem.selectedIndex+=1;
	            } 
	         } else {
	            elem.selectedIndex=0;
	         }
	      }
	      break;
	   case 40: // DOWN
	           return doFocusNext(elem);
	      break;
	   case 33: // PAGE UP
	           if(typeof doPageUp !="undefined" && typeof doPageUp=="function"){
	               return doPageUp();
	           }
	           return true; 
	      break;
	   case 34: // PAGE DOWN
	           if(typeof doPageDown=="function"){
	               return doPageDown();
	           }
	           return true; 
	      break;
	   case 118: // F7 SUBMIT
	      var submitButton= getFirstSubmitButton();
	      doPostBack(submitButton.name,"");
	      break; 
	   default:

	      break; 
	}
	return true;
   }

   function processKeyPress(evt) {
	evt =(evt) ? evt : ((window.event) ? event : null);
	var elem = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement: null);
	var charCode=(evt.charCode) ? evt.charCode:((evt.which) ? evt.which : evt.keyCode);

	if(isManagedType(elem.type)==false)
	   return true;
	if(document.selection != null) {
	   if(document.selection.createRange().text != '')
	      document.selection.clear();
	}
	var retValue=true;
	if(elem.mask){
	   retValue=doMask(elem,charCode);	
	}
               if(elem.type=="text" && elem.value.length==elem.maxLength-1){
	   var index=getElementIndex(elem);
	   var nextIndex=index+1;
	   if(index==mForm.length-1){
	      nextIndex=0;
	   }	
	   setTimeout("setFocusByIndex("+nextIndex+")",0);	
	}
	return retValue;
   }

   function processFocus(evt) {
	evt =(evt) ? evt : ((window.event) ? event : null);
	var elem = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement: null);
	var charCode=(evt.charCode) ? evt.charCode:((evt.which) ? evt.which : evt.keyCode);
	if(isManagedType(elem.type)==false)
	   return true;
	if(elem.mask.toUpperCase()=="CURRENCY"){
	   unformatCurrencyElement(elem);
	}
	return doFocusMask(elem) ;
   }

   function processBlur(evt) {
	evt =(evt) ? evt : ((window.event) ? event : null);
	var elem = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement: null);
	var charCode=(evt.charCode) ? evt.charCode:((evt.which) ? evt.which : evt.keyCode);
	if(isManagedType(elem.type)==false)
	   return true;
	if(elem.mask.toUpperCase()=="CURRENCY"){
	   formatCurrencyElement(elem);
	}
	return true;
   }

/**
* do Functions. Those functions are called directly in event handler, the function HAS TO
* return true or false to indicate the default behavior should proceed or not.
*
*/
   
   function doFocusNext(elem) { 
	emptySelection();
	if(canBlur(elem)==false){
	   return true; 
	}
	var index=getElementIndex(elem);
	var nextIndex=index+1;
	if(index==mForm.length-1){
	   nextIndex=0;
	}	
	setTimeout("setFocusByIndex("+nextIndex+")",0);
	return false;
    }

   function doFocusPrevious(elem) { 
	emptySelection();
	if(canBlur(elem)==false){
	   return true; 
	}
	var index=getElementIndex(elem);
	var nextIndex=index-1;
	if(index==0){
	   nextIndex=mForm.length-1;
	}	
	setTimeout("setFocusByIndex("+nextIndex+")",0);	
	return false;
    }

   function doMask(elem,keyCode) {

	var mask = elem.mask;
	if(mask == null || mask.length == 0  )
	   return true;
	if(mask.toUpperCase()=="INTEGER" ||mask.toUpperCase()=="REAL" || mask.toUpperCase()=="CURRENCY" ) {
	   return doNumericMask(elem,keyCode);
	}
	var val = elem.value;
	var retValue = false;
	
	var maskChar = mask.substr(val.length, 1);
	var nextMaskChar = '';
	if((val.length + 1) <= mask.length) {
	   nextMaskChar = mask.substr(val.length + 1, 1);
	}
	//charCode 57='9' 99='c'
	if ((maskChar.charCodeAt(0) == 57) && (keyCode >= 48) && (keyCode <= 57)) // digit
	   retValue = true;
	else if((maskChar.toLowerCase().charCodeAt(0) == 99) && (((keyCode >= 65) && (keyCode <=90)) || ((keyCode >= 97) && (keyCode <= 122)))) //&& (((keyCode >= 65) && (keyCode <= 90)) || ((keyCode >= 99) && (keyCode <= 122))))
 	   retValue = true;
	else if(maskChar == String.fromCharCode(keyCode)) // special
	   retValue = true;
	else
	   retValue = false;
	if(retValue) {
	   var i=1;
	   var addedKey = false;
	   while(nextMaskChar != '') {
	      if((val.length + i) <= mask.length)
	         nextMaskChar = mask.substr(val.length + i, 1);
	      if(nextMaskChar.toLowerCase() == '9' || nextMaskChar.toLowerCase() == 'c')
	         nextMaskChar = '';
	      var charCode = nextMaskChar.toLowerCase().charCodeAt(0);
	      if((charCode != 57) && ((charCode < 48) || (charCode > 57)) && (charCode != 99)) {
	         if(!addedKey) {
	            elem.value = elem.value + String.fromCharCode(keyCode) + nextMaskChar;
	            addedKey = true;
	         } else
	            elem.value = elem.value + nextMaskChar;
	         retValue = false;
	      }
	      i++;
	   }
	}
	return retValue;
   }


   function doNumericMask(elem,keyCode) {
	if(document.selection != null) {
	   if(document.selection.createRange().text != '')
	      document.selection.clear();
	}
	var mask = elem.mask;
	if(mask == null)
	   return true;
	var decSign = ".";
	var decPlaces =-1;
	var placesBeforeDec = -1;
	var isReal = false;
	if(mask.toUpperCase()=="REAL" || mask.toUpperCase()=="CURRENCY") {
	   isReal=true;
	   decPlaces=2;
	}
	var isPos = true;
	
	if((keyCode >= 48 && keyCode <= 57) ) {
	   if(decPlaces == -1 || isReal == false ) { //INTEGER
	      var tempVal = elem.value;
	      if(tempVal.indexOf('.', 0) == -1) {
	         if(tempVal.length < placesBeforeDec || placesBeforeDec == -1)
	            return true;
	         else
	            return false;
	      } else {
	         return true;
	      }
	   } else {  // REAL
	      var tempVal = elem.value;
	      if(tempVal.indexOf('.', 0) == -1) { // the current input value has no decimal part
	         if(tempVal.length < placesBeforeDec || placesBeforeDec == -1)
	            return true;
	         else
	            return false;
	      } else {
	         if((tempVal.length - tempVal.indexOf(decSign, 0)) <= decPlaces)
	            return true;
	         else
	            return false;
	      }
	   }
	} else if (keyCode == 45 || keyCode == 46 ) {
	   if(keyCode == 45) {  // -
	      var tempVal = elem.value + "-";
	      if(tempVal.indexOf("-") == 0 && tempVal.indexOf("-", 1) == -1) {
	         if(isPos == true)
	            return false;
	         else
	            return true;
	      } else
	         return false;
	   } else if(keyCode == 46 && decSign == "."){ // .
	      var tempVal = elem.value;
	      if(tempVal.indexOf(".", 0) == -1) {
	         if(isReal == true)
	            return true;
	         else
	            return false;
	      } else
	            return false;
	   } else
	      return false;
	} else
	   return false;
   }


   function doFocusMask(elem) {
	if(elem.value !='')
	   return true;
	var i=1;
	var mask = elem.mask;
	if(mask == null)
	   return true;
	var maskChar = mask.substr(0, 1);
	var charCode = maskChar.toLowerCase().charCodeAt(0);
	while((charCode != 57) && ((charCode < 48) || (charCode > 57)) && (charCode != 99)) {
	   elem.value = elem.value + maskChar;
	   maskChar = mask.substr(i, 1);
	   charCode = maskChar.toLowerCase().charCodeAt(0);
	   i++;
	}
	if(elem.createTextRange) {
	   var range = elem.createTextRange();
	   range.moveStart('character', event.srcElement.value.length);
	   range.collapse();
	   range.select();
	}
   }


 /************    help functions  *******/
 
   function reFillMForm(){
	var f =document.forms[0];
	mForm= new Array();
	for(var i=0; i < f.elements.length;i++){
	   var elem=f.elements[i];
	   if(elem.disabled==true)
                     continue;
	   if(isManagedType(elem.type)){
	      mForm[mForm.length]=elem;
	      if(elem.mask != null && elem.mask.toUpperCase()=="CURRENCY"){
	         elem.onfocus=processFocus;
	         elem.onblur=processBlur;
	      }	      	     
	   }
	} 
   }

  function debug_showform(){
   	var f=mForm;
	var s="";
	for(var i=0; i < f.length;i++){
	   var elem=f[i];
	   s+=elem.name +" type=[" +elem.type +"] value=["+elem.value+"]\n";
	}
	alert (s);  
   }

   function focusFirstInputElement() { 
	var f=mForm;
	for(var i=0; i < f.length;i++){
	   var elem=f[i];
	   if(elem.type=="text" || elem.type=="textarea" || elem.type=="select-one" ){      
	      break;	
	   }       
	}   
	elem.focus();
	if(elem.type!="select-one"){
	   elem.select();
	}	
	elem.className ="onFoucs";
   }

   function isManagedType(type){
	if(type && (type=="text" || type=="textarea" || type=="select-one" || type=="submit" || type=="button" || type=="reset" || type=="password"    )) {         
	   return true;	
	} else {
	   return false;
	}       
   }

   function isTextBoxType(type){
	if(type && ( type=="text" || type=="textarea"  || type=="password"   )) {         
	   return true;	
	} else {
	   return false;
	}       
   }

   function isButtonType(type){
	if(type && ( type=="submit" || type=="button" || type=="reset"   )) {         
	   return true;	
	} else {
	   return false;
	}       
   }

   function getElementIndex(element){
	var f=mForm;
	var index=0;	
	for(var i=0; i < f.length;i++){
	   var elem=f[i];
	   if(elem.name==element.name && isManagedType(elem.type)) {         
	      index= i;
	      break;	
	   }       
	}   
	return index;
   }

   function getElementIndexByName(element_name){
	var f=mForm;
	var index=0;	
	for(var i=0; i < f.length;i++){
	   var elem=f[i];
	   if(elem.name==element_name && isManagedType(elem.type)) {         
	      index= i;
	      break;	
	   }       
	}   
	return index;
   }

   function canBlur(elem){
	var retValue=true;
	if(elem.type=="textarea"){
	   var re=new RegExp("\n","g");
	   var result = elem.value.match(re);
	   if(result==null) {
	       retValue= false;
	   } else {
	      var rows=(elem.rows) ? elem.rows :  5 ;
	      if(result.length < elem.rows){
	        retValue=false;
	      }
	   }
	}
	return retValue;
   } 

   function emptySelection(){
	if(document.selection != null) {
	   if(document.selection.createRange().text != '')
	      document.selection.empty();
	}
   }
   
   function cleanCss()
   {
        for(j = 0; j<document.forms[0].elements.length; j++)
        {
				if(isManagedType(document.forms[0].elements[j].type))
		        {
				  document.forms[0].elements[j].className ="";
				}
        }
   }

   function setFocusByIndex(index){
	var elem=mForm[index];
	elem.focus();
	cleanCss();
	elem.className ="onFoucs";
	if(elem.type !="select-one" && elem.type !="textarea" ){ // select does not has select() method
	   elem.select();
	}
   }

   function setFocusByName(elem_name){
	var index=getElementIndexByName(elem_name);
	var elem=mForm[index];
	elem.focus();
	cleanCss();
	elem.className ="onFoucs";
	if(elem.type !="select-one"  && elem.type !="textarea"){  // select does not has select() method
	   elem.select();
	}
   }

   function unformatCurrency(value) {
	var dollarSign="NT$"; 
	var commaSign=",";
	var currentValue = value;
	var newValue = currentValue;
	while(newValue.indexOf(dollarSign) > -1)
	   newValue = newValue.replace(dollarSign, '');
	while(newValue.indexOf(commaSign) > -1)
	   newValue = newValue.replace(commaSign, '');
	return newValue;
   }

 function formatCurrency(currentValue) {
	var dollarSign="NT$"; 
	var commaSign=",";
	var decimalSign=".";
	var parseValue = '';
	var newValue = '';
	var getDecimal = false;
	var addNegative = false;
	if(currentValue.indexOf(dollarSign) > -1)
	   return;
	if(currentValue.indexOf('-') >= 0) {
	   addNegative = true;
	   currentValue = currentValue.replace('-', '');
	}
	if(currentValue != '' && currentValue.indexOf(decimalSign) > 0) {
	   parseValue = currentValue.substr(0, currentValue.indexOf(decimalSign));
	   getDecimal = true;
	} else {
	   parseValue = currentValue;
	   getDecimal = false;
	}
	var rotations = parseInt(parseValue.length / 3);
	if(parseValue.length % 3 == 0)
	   rotations--;
	for(var i=0; i<rotations; i++)
	   newValue = commaSign + parseValue.substr(parseValue.length - ((i + 1) * 3), 3) + newValue;
	newValue = parseValue.substr(0, parseValue.length - ((rotations) * 3)) + newValue;		
	if(getDecimal)
	   newValue = newValue + currentValue.substr(currentValue.indexOf(decimalSign));
	if(newValue.length > 0) {
	   if(addNegative)
	      newValue = dollarSign + '-' + newValue;
	   else
	      newValue = dollarSign + newValue;
	}
	return newValue;
   }

   function formatCurrencyElement(elem) {
	
	elem.value = formatCurrency(elem.value);
   }

   function unformatCurrencyElement(elem) {
	elem.value = unformatCurrency(elem.value);
	elem.select();
   }

   function formatAllCurrencyElement(){
	var f =mForm;
	for(var i=0; i < f.length;i++){
	   var elem=f[i];
	   if(elem.type=="text" || elem.type=="textarea"){
	       if(elem.mask != null && elem.mask.toUpperCase()=="CURRENCY"){
	          formatCurrencyElement(elem);
	      }
	   }
	} 
   }

    function unformatAllCurrencyElement(){
	   var f=mForm;
	   for(var i=0; i < f.length;i++){
	      var elem=f[i];
	      if(elem.mask && elem.mask.toUpperCase()=="CURRENCY") {         
	         unformatCurrencyElement(elem);	
	      }       
	   } 
   }

   function getFirstSubmitButton() { 
	var f=document.forms[0];	
	for(var i=0; i < f.elements.length;i++){
	   var elem=f.elements[i];
	   if(elem.type=="submit")
	     return elem;    
	}   
   }

   function preparePostBack(eventTarget, eventArgument){
	var theform = document.forms[0];
	if(!theform.__EVENTTARGET){
 	   theform.insertAdjacentHTML("afterBegin","<input name='__EVENTTARGET' type='hidden'>");
	   theform.__EVENTTARGET.value = eventTarget;
	}
	if(!theform.__EVENTARGUMENT){
	   theform.insertAdjacentHTML("afterBegin","<input name='__EVENTARGUMENT' type='hidden'>");
	   theform.__EVENTARGUMENT.value = eventArgument;
	} 
	var f=mForm;
	for(var i=0; i < f.length;i++){
	   var elem=f[i];
	   if(elem.mask && elem.mask.toUpperCase()=="CURRENCY") {         
	      unformatCurrencyElement(elem);	
	   }       
	}  
   }
   function doPostBackCauseValidation(eventTarget, eventArgument) {
	preparePostBack(eventTarget, eventArgument);
	var theform = document.forms[0];
	if(typeof ValidatorOnSubmit !="undefined"){
	   if(ValidatorOnSubmit()){
	      theform.submit();
	   }
	} else {
	   theform.submit();
	}
   }
   function doPostBack(eventTarget, eventArgument) {
	preparePostBack(eventTarget, eventArgument);
	var theform = document.forms[0];
	theform.submit();
   }
