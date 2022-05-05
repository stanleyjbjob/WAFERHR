
function doPageUp(){
	var d =document.getElementById("MyDataGrid");
	if(d==null){
	   return false;
	}
	var r=d.rows[0];
              if(r==null){
	   return false;
	}
	var c= r.cells[0];
	var elem= c.childNodes[0];// Hard-coded for this page
	if(elem==null){
	   return false;
	}
	if(elem.nodeName.toUpperCase() !="A")
	   return false;
	var s=elem.href;
	 s=s.substring(s.indexOf("__doPostBack"));
	 eval(s);
	return false;
}

function doPageDown(){
	var d =document.getElementById("MyDataGrid");
	if(d==null){
	   return true;
	}
	var r=d.rows[0];
              if(r==null){
	   return true;
	}
	var c= r.cells[0];
	var elem= c.childNodes[2]; // Hard-coded for this page
	if(elem==null){
	   return true;
	}
	if(elem.nodeName.toUpperCase() !="A")
	   return true;
	var s=elem.href;
	 s=s.substring(s.indexOf("__doPostBack"));
	 eval(s);
	return false;
}

function qs(ref_table,id_column,name_column){
	var w=window.open("qs_"+ref_table+".aspx?id_column="+id_column+"&name_column="+name_column,"QSWindow","toolbar=no,menubar=no,resizable=yes,scrollbars=yes,width=500,height=400",false);
	w.focus();
	return false;
}

function qs_s(ref_table,id_column,name_column,name_column1,name_column2){
	var w=window.open("qs_"+ref_table+".aspx?id_column="+id_column+"&name_column="+name_column+"&name_column1="+name_column1+"&name_column2="+name_column2,"QSWindow","toolbar=no,menubar=no,resizable=yes,scrollbars=yes,width=500,height=400",false);
	w.focus();
	return false;
}

function qs_ss(ref_table,id_column,name_column,name_column1,name_column2,value_name,value){
	var w=window.open("qs_"+ref_table+".aspx?id_column="+id_column+"&name_column="+name_column+"&name_column1="+name_column1+"&name_column2="+name_column2+"&"+value_name+"="+value,"QSWindow","toolbar=no,menubar=no,resizable=yes,scrollbars=yes,width=500,height=400",false);
	w.focus();
	return false;
}

function qs_sss(ref_table,id_column,name_column,name_column1,name_column2,name_column3,value_name,value){
	var w=window.open("qs_"+ref_table+".aspx?id_column="+id_column+"&name_column="+name_column+"&name_column1="+name_column1+"&name_column2="+name_column2+"&name_column3="+name_column3+"&"+value_name+"="+value,"QSWindow","toolbar=no,menubar=no,resizable=yes,scrollbars=yes,width=500,height=400",false);
	w.focus();
	return false;
}

function qs_onblur(ref_table,id_column,name_column,evt){
	evt =(evt) ? evt : ((window.event) ? event : null);
	var elem = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement: null);
	var charCode=(evt.charCode) ? evt.charCode:((evt.which) ? evt.which : evt.keyCode);
	
	var qs_column = document.getElementById(id_column);
	if(qs_column==null)
	   return true;	
	if(qs_column.value ==""){ 
	   return true;
	}
	var s=getRefData(ref_table,id_column,name_column,qs_column.value);
	if(name_column !="" && document.getElementById(name_column) != null){
	   document.getElementById(name_column).innerHTML =s;  
	}

}



function qs_onblur_s(ref_table,id_column,name_column,name_column1,name_column2,evt){
	evt =(evt) ? evt : ((window.event) ? event : null);
	var elem = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement: null);
	var charCode=(evt.charCode) ? evt.charCode:((evt.which) ? evt.which : evt.keyCode);
	
	var qs_column = document.getElementById(id_column);
	if(qs_column==null)
	   return true;	
	if(qs_column.value ==""){ 
	   return true;
	}
	
    var s=getRefData(ref_table,id_column,name_column,qs_column.value);
	var spStr = s.split(",");
	
	if(name_column !="" && document.getElementById(name_column) != null){
	   document.getElementById(name_column).innerHTML =spStr[0];  
	}
	
	if(name_column1 !="" && document.getElementById(name_column1) != null){
	   document.getElementById(name_column1).innerHTML =spStr[1];  
	}
    if(name_column2 !="" && document.getElementById(name_column2) != null){
	   document.getElementById(name_column2).innerHTML =spStr[2];  
	}
	
}

function qs_onblur_ss(ref_table,id_column,name_column,name_column1,name_column2,name_column3,evt){
	evt =(evt) ? evt : ((window.event) ? event : null);
	var elem = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement: null);
	var charCode=(evt.charCode) ? evt.charCode:((evt.which) ? evt.which : evt.keyCode);
	
	var qs_column = document.getElementById(id_column);
	if(qs_column==null)
	   return true;	
	if(qs_column.value ==""){ 
	   return true;
	}
	
    var s=getRefData(ref_table,id_column,name_column,qs_column.value);
	var spStr = s.split(",");
	
	if(name_column !="" && document.getElementById(name_column) != null){
	   document.getElementById(name_column).innerHTML =spStr[0];  
	}
	
	if(name_column1 !="" && document.getElementById(name_column1) != null){
	   document.getElementById(name_column1).innerHTML =spStr[1];  
	}
	
    if(name_column2 !="" && document.getElementById(name_column2) != null){
	   document.getElementById(name_column2).innerHTML =spStr[2];  
	}
	
	if(name_column3 !="" && document.getElementById(name_column3) != null){
	   document.getElementById(name_column3).innerHTML =spStr[3];  
	}
	
}



function getRefData(ref_table,id_column,name_column,value){
	var x = new ActiveXObject("Microsoft.XMLHTTP"); 
	x.Open("GET","qs_blur_"+ref_table+".aspx?value="+value+"",0); 
	x.Send(); 
	var s=x.responseText;
	return s;
}