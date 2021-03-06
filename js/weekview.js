// This class was altered by Pedro Pires (The chosen two)
var bgcolor1,bgcolor2 ;
var mousedown=0,mousedownTimeout;
var curDate=new Date();
var res_status=1;
var res_maxslots;
var fadeConstant=1300;
var showingMsg = false;
var fadeCount;
// variable used for a patch in the checkfields function
var usingSession;
var detectedUser;

//bgcolor2='document..backgroundColor; // just to set bgcolor2 at the beggining

  
    document.onmousedown= function () {
        mousedown=0;
        window.clearInterval(mousedownTimeout);
        mousedownTimeout = window.setInterval(function() { mousedown += 5 }, 5);
        document.getElementById('calendar').style.MozUserSelect="none";
        document.body.onselectstart=function(){return false};
        document.getElementById('calendar').onselectstart==function(){return false};    
    }
    document.onmouseup= function () {
        mousedown = 0;
        window.clearInterval(mousedownTimeout);
        
    }
	
// sets the usingSession global variable with the isUsing value (boolean)
function setUsingSession(isUsing){
	usingSession = isUsing;
}
    
function noenter() {
  return !(window.event && window.event.keyCode == 13); }
  
function button_visibility(add,del,monitor,update,confirm) {
    document.getElementById('delButton').disabled=del;
    document.getElementById('addButton').disabled=add;
    document.getElementById('monitorButton').disabled=monitor;
    document.getElementById('updateButton').disabled=update;
    if (res_status>2 || document.getElementById('update').value!=0){ // in the case there is no need for confirmation button
        document.getElementById('confirmButton').disabled=confirm ;
    } else {
        //alert(confirm); 
        document.getElementById('confirmButton').disabled=true; 
    }
    
    
}

function swapColor(obj,tag,action){
    //document.getElementById('datefield').selection.empty();
    objStyle=obj.style;
    oUpdVal=document.getElementById('update');
    oUpdBut=document.getElementById('updateButton');
    if ((mousedown<10) && (tag==0))return;
    if (objStyle.backgroundColor!=bgcolor1) {
        table=document.getElementById('caltable');
        tablesize=table.rows.length;
        // for checking span use table.rows[i].cells[j].rowSpan;
        
        if (action==1) { // select an existing entry
            if (oUpdVal.value!=0) exit;
            clear_table(table);
            document.getElementById('addButton').value='All';
            button_visibility(false,false,false,false,false);
			if (window.XMLHttpRequest){
				xmlhttp=new XMLHttpRequest();
			} else {
				alert("Your browser does not support XMLHTTP!");
				exit;
			}
			url='ajax.php?entry=' +   obj.title + "&type=DisplayEntryInfo" ;
			xmlhttp.open('GET', url , true);
			xmlhttp.send(null);
			xmlhttp.onreadystatechange = function () {
				if(xmlhttp.readyState==4) {
				eval(xmlhttp.responseText);
				//alert(xmlhttp.responseText);         
				}
			}
        } else {
            document.getElementById('addButton').value='Add';
			for (i=1;i<tablesize;i++)
				for (j=1;j<table.rows[i].cells.length;j++)
					if (table.rows[i].cells[j].innerHTML!='')
						table.rows[i].cells[j].style.backgroundColor=table.rows[i].cells[j].lang;
			if (document.getElementById('update').value==0)
				button_visibility(false,true,true,true,true);
        }
        objStyle.backgroundColor='#aaaaaa';
        bgcolor1=objStyle.backgroundColor;
        bgcolor2=bgcolor1;
        
        //alert(bgcolor2);
        
    } else {
        objStyle.backgroundColor=obj.lang;
        //bgcolor2=objStyle.backgroundColor;
        if (action==1) button_visibility(true,true,true,true,true);
        //alert(bgcolor2);
    }
    document.getElementById('entry').value=0;
    
}

// this function enables and disables end date for repetitions
function activate_date(objInp){ objInp.disabled=(objInp.disabled^ true );}


function hide_divs(div1,div2,div3) {
    document.getElementById(div1).style.visibility='hidden';
    document.getElementById(div2).style.visibility='hidden';
    document.getElementById(div3).style.visibility='visible';
}
function clear_table(table,cleartitle){
    var i,j,bg;
    bg='#ffffff';
    tablesize=table.rows.length;
    for (i=1;i<tablesize;i++)
        for (j=1;j<table.rows[i].cells.length;j++) {
            if (table.rows[i].cells[j].innerHTML=='' && cleartitle) table.rows[i].cells[j].title=0;
        //    if (table.rows[i].cells[j].style.backgroundColor!=bgcolor2) bg=table.rows[i].cells[j].style.backgroundColor;
            if (!cleartitle && table.rows[i].cells[j].style.backgroundColor) table.rows[i].cells[j].style.backgroundColor=table.rows[i].cells[j].lang;
        }
}


function ManageEntries(action,ttime,tresolution) {
    var i,j,k=0,seed=0,add=0,tdatetime,tstartime;
    var bgcolor;
    var code;
    table=document.getElementById('caltable');
    tablesize=table.rows.length;
	
    //code serves for eliminating javascript cache and to add multiple entries
    code=Math.random();
    document.getElementById('code').value=code;
    
    //getting values from hidden input boxes
    document.getElementById('action').value=action;
    entry=document.getElementById('entry').value;
    tdate=document.getElementById('tdate').value;
    resource=document.getElementById('resource').value;
    document.getElementById('action').value=action;
    update=document.getElementById('update').value;
   
    // this is a hack to get a color object
    document.getElementById('code').style.backgroundColor='#aaaaaa';
    bgcolor=document.getElementById('code').style.backgroundColor;    
    
    
    switch(action) {
        case 'del':
			detectedUser = true;
            for (i=1;i<tablesize;i++) {
                for (j=1;j<table.rows[i].cells.length;j++) {
                    cell=table.rows[i].cells[j];
                    if (cell.title!='0' && (cell.style.backgroundColor==bgcolor)) {
                        //alert(cell.style.backgroundColor);
                        document.getElementById('entry').value=cell.title;
                        ajaxEntries('GET','process.php?deleteall=0&resource=' + resource ,true);
                        //alert ("No entries were selected");
                    }
                }
                //alert(table.rows[i].cells.length);
            }
			if(!detectedUser){
				document.getElementById('entry').value = '0';
			}
            if (entry!='0') {
            // if (entry!='0' && detectedUser) {
                var resp=confirm('All associated entries will be deleted!');
                if (!(resp)) return;
                ajaxEntries('GET','process.php?deleteall=1&resource=' + resource,true);
                clear_table(table,false);
            }
        break;
        case 'add':
            var arr=new Array(); // creates an array to define cells with rowspan>1
            if (update>0) document.getElementById('entry').value=update; // for the update it has to send the entry
            //alert(update);
            for (i=1;i<=tablesize;i++) {
                arr[i]= new Array();
                for (j=1;j<8;j++) arr[i][j]=0; // fills the array
            }
            for (i=1;i<tablesize;i++) {
                for (j=1;j<table.rows[i].cells.length;j++) {
                    span=table.rows[i].cells[j].rowSpan;
                    for (x=1;x<=(j+add);x++) add=arr[i][x]+add;
                    if (span>1) for (k=i+1 ;k<i+span;k++) arr[k][j+add]=1; // sets to 1 the fields without
                    add=0; 
                }
                k=0;
            }
            for (i=1;i<tablesize;i++) {
                ncells=table.rows[i].cells.length;
                for (j=1;j<8;j++) {
                    add=0;
                    for (x=1;x<=j;x++) add=arr[i][x]+add; // for checking where grow
                    cell=table.rows[i].cells[j-add];
                    if (cell.style.backgroundColor==bgcolor && cell.title=='0') {
                        while (table.rows[i+k].cells[j-add].style.backgroundColor==bgcolor && ((i+k) < tablesize)){
                                //alert(table.rows[i+k].cells[j-add].style.backgroundColor);
                            add=0;
                            seed=seed+1;
                            for (x=1;x<=j;x++) add=arr[i+k][x]+add; // for checking where grow
                            table.rows[i+k].cells[j-add].title=seed; // due to rowspan
                            //table.rows[i+k].cells[j-add].innerHTML=seed;
                            k=k+1;
                            if ((i+k)==tablesize) break;
                            add=0;  
                            for (x=1;x<=j;x++) add=arr[i+k][x]+add; // for checking where grow
                        }
                        if (res_maxslots<seed) {
                            var resp=confirm('Exceeding daily maximum slots. Only reasonable in off peak time! Continue?');
                            if (!(resp)) {
                                window.location.href='weekview.php?resource=' + resource + '&date=' + tdate;
                                return;
                            }
                            
                        }   
                        tstarttime= parseInt(ttime)+(i-1)*(tresolution);
                        //t=Date.UTC(parseInt(tdate.substring(0,4)),parseInt(tdate.substring(4,6),10)-1,parseInt(tdate.substring(6,8),10)+j,Math.floor(tstarttime),(tstarttime-Math.floor(tstarttime))*60);
                        //entryDate.setTime(t);
                        if (seed==0) exit;
                        var entryDate = new Date(tdate.substring(0,4),parseInt(tdate.substring(4,6),10)-1,parseInt(tdate.substring(6,8),10)+j,Math.floor(tstarttime),Math.ceil((tstarttime-Math.floor(tstarttime))*60),'00');
                        // alert(formatDate(entryDate,"yyyyMMddHHmm"));
                        ajaxEntries('GET','process.php?' + 'slots=' + seed + '&datetime=' + formatDate(entryDate,"yyyyMMddHHmm") + '&resource=' + resource,true);
                        seed=0;
                        k=0;
                    } else if(cell.title!='0' && document.getElementById('addButton').value=='All' && cell.style.backgroundColor==bgcolor2 )  {
                        window.location.href='weekview.php?resource=' + resource + '&entry=' + cell.title;
                    }
                    
                 }
            }// end loop all
        
        break;
        case 'update':
            if (update!=0) {
                ManageEntries('add',ttime,tresolution);
            } else {
                for (i=1;i<tablesize;i++) {
                    for (j=1;j<table.rows[i].cells.length;j++) {
                        cell=table.rows[i].cells[j];
                        if (cell.title!='0' && (cell.style.backgroundColor==bgcolor)) {
                            //alert(cell.style.backgroundColor);          
                                window.location.href='weekview.php?resource=' + resource +'&update=' + cell.title +'&date=' + tdate;
                        }
                    }
                }
            }
        break;
        case 'monitor':
            for (i=1;i<tablesize;i++) {
                //alert(bgcolor2);
                for (j=1;j<table.rows[i].cells.length;j++) {
                    cell=table.rows[i].cells[j];
                    if (cell.title!='0' && (cell.style.backgroundColor==bgcolor)) {
                        //alert(cell.style.backgroundColor);
                            document.getElementById('entry').value=cell.title;
                            ajaxEntries('GET','process.php?&resource=' + resource,true);
                            clear_table(table,false);                 
                    } else {
                       //alert ("No entries were selected");
                    }
                }
                //alert(table.rows[i].cells.length);
            }
        break;
        case 'confirm':
        	
            if (update!=0) { // in real its a cancel
                window.location.href='weekview.php?resource=' + resource + '&date=' + tdate;
               exit();
            }
            objForm=document.getElementById('entrymanage');
            if (checkfield(objForm['user_id'])) exit;
            if (checkfield(objForm['user_passwd'])) exit;
            for (i=1;i<tablesize;i++) {
                //alert(bgcolor2);
                for (j=1;j<table.rows[i].cells.length;j++) {
                    cell=table.rows[i].cells[j];
                    if (cell.title!='0' && (cell.style.backgroundColor==bgcolor)) {
                        //alert(cell.style.backgroundColor);
                        objForm=document.getElementById('entrymanage');
                        
                            document.getElementById('entry').value=cell.title;
                            myDiv=document.getElementById('InputComments');
                            AssignPosition(myDiv);
                            myDiv.style.display = "block";                
                            //ajaxEntries('GET','process.php?&resource=' + resource,true,resource,tdate);
                            //clear_table(table,false);                 
                    } else {
                       //alert ("No entries were selected");
                    }
                }
                //alert(table.rows[i].cells.length);
            }
            
        break;

    } //
  //  
}
function addcomments(entry) {
    
    
    if (entry==0){
        if (window.XMLHttpRequest){
            xmlhttp=new XMLHttpRequest();
        } else {
            alert("Your browser does not support XMLHTTP!");
            exit;
        }
        entry=document.getElementById('entry').value;
        resource=document.getElementById('resource').value;
        user_id=document.getElementById('user_id').title;
        myForm=document.getElementById('entrycomments');
        if (myForm[0].value!='') {
            var re = /\'/g;
            myForm[0].value=myForm[0].value.replace(re," ");
            //alert(myForm[0].value);
            url='process.php?resource=' + resource +'&entry=' + entry + '&user_id=' + user_id + '&action=addcomments&comments='+ myForm[0].value;
            xmlhttp.open('GET', url , true);
            xmlhttp.send(null);
        }
    }
    
    ajaxEntries('GET','process.php?resource=' + resource,true);
    clear_table(table,false); 
    myForm.style.display = "none";

}

// Checks if a field is empty, returns true if it is
function checkfield(field) {  
	// this is a horrible, horrible patch but still brilliant (the chosen two has done it again)
	// its purpose is to be able to ignore the login fields that are empty when the user and pass are as session variables
    if(usingSession && (field.name == 'user_id' || field.name == 'user_passwd')){
		return false;
	}
    if (field.value=='') {
        field.focus();
        //alert ("Field " + field.name + " required!");
        if (document.getElementById('msg').innerHTML != "Field " + field.name + " required!")
			document.getElementById('msg').innerHTML = "Field " + field.name + " required!";
        // showfade('msg',1000);
        showfade('msg',fadeConstant);
        //window.location.reload();
        clear_table(document.getElementById('caltable'),true);
        // exit;
        return true;
    }
    return false;
    
}

function ajaxEntries(method,url,nosync){
    
    document.body.style.cursor='wait';
    
    var nelements,par='',objForm;
    action=document.getElementById('action').value;
    objForm=document.getElementById('entrymanage');
    date=document.getElementById('tdate').value;
    resource=document.getElementById('resource').value;
    if (window.XMLHttpRequest){
        xmlhttp=new XMLHttpRequest();
    } else {
        alert("Your browser does not support XMLHTTP!");  
    }
    switch(action) {
    case 'add':
        for (nelements=0;nelements<objForm.length;nelements++){
            if (checkfield(objForm[nelements])) return;
        }
    break;
    case 'update':
        for (nelements=0;nelements<objForm.length;nelements++){
            if (checkfield(objForm[nelements])) return;
            
        }
    break;
    case 'del':
        if (checkfield(objForm['user_id'])){detectedUser = false; return;}
        if (checkfield(objForm['user_passwd'])){detectedUser = false; return;}
    break;
    case 'monitor':
    // alert (par);
        for (nelements=0;nelements<objForm.length;nelements++){
            if (checkfield(objForm[nelements])) return;
        }
        // if (checkfield(objForm['user_id']))return;
        // if (checkfield(objForm['user_passwd']))return;
    break;
    case 'confirm':
        
    break;
    }
    objForm.user_id.value=objForm.user_id.title;
    
    // builds post string
    for (nelements=0;nelements<objForm.length;nelements++){
        if (objForm[nelements].lang=='send') {
			if (objForm[nelements].type=='checkbox') {
				par=par+ objForm[nelements].name + '=' + objForm[nelements].checked + "&";
			} else {
				par=par+ objForm[nelements].name + '=' + objForm[nelements].value + "&";
			}
		}
    }
	// par has username and pass
	// alert(url + '&' + par);
    xmlhttp.open(method, url + '&' + par, nosync);
    xmlhttp.send(null);
    xmlhttp.onreadystatechange = function () {
        if(xmlhttp.readyState==4) {
            code=document.getElementById('code').value;
            // alert(xmlhttp.responseText);         
            window.location.href='weekview.php?resource=' + resource + '&date=' + date+ '&code=' + code + '&msg=' + xmlhttp.responseText;
        }
    }
}   

function filljscombo(tagname,start,end,resolution,selection,entry) {
    var i=0,sel='',dis=true;
    if (entry!=0) dis=false;
    document.write("<select lang=send id=" + tagname + " name=" + tagname + " disabled=" + dis + ">");
    while (start<end) {
        if (start==selection) sel='selected';
        document.write("<option " + sel + " value=" +i + ">"+ start + "</option>");
        i++;
        sel='';
        start=start+resolution;
    }
    document.write("</select>");
    document.getElementById(tagname).disabled=dis;
}

function showfade(element,count) {
	fadeCount = count;
	if(!showingMsg){
		obj=document.getElementById('msg');
		if (obj.innerHTML != "") {
			obj.style.color = 773333;
			obj.style.fontSize = 25;
			obj.style.visibility = 'visible';
			showingMsg = true;
			showFadeAux(element, fadeCount)
		}
	}
} 

function showFadeAux(element, count){
	if(fadeCount > 0){
		obj=document.getElementById(element);
		try {
			obj.filters.alpha.opacity=fadeCount/10; // for ie
		} catch (err) {
			obj.style.opacity=fadeCount/1000;
		}
		fadeCount = fadeCount - 20;
		timerID = setTimeout("showFadeAux('" + element + "'," + fadeCount + ")", 100);
	}
	else{
		obj.style.visibility = 'hidden';
		obj.value='';
		showingMsg = false;
	    document.body.style.cursor='default';
	}
}

function init(s,m){
    document.getElementById('enddate').value=formatDate(curDate,"yyyy-M-dd");
    if (document.getElementById('entry').value!='0') {
        if (document.getElementById('update').value!='0') {
			table=document.getElementById('caltable');
			clear_table(table);
			document.getElementById('updateButton').value='Change';
            document.getElementById('confirmButton').value='Cancel';
            button_visibility(true,true,true,false,false);
        } else {
            button_visibility(true,false,true,true,true);
        }
        
        
    } else {
        button_visibility(true,true,true,true,true);
    }
	document.getElementById('msg').style.visibility='hidden';
	showfade('msg', fadeConstant);
    //The behavior will depend on this
    res_status=s;
    res_maxslots=m;
}

function submitUser(resource) {
    formObj=document.getElementById('edituser');
    if (checkfield(formObj.user_idm)) return;
    if (checkfield(formObj.user_passwd)) return;
    formObj.user_idm.value=formObj.user_idm.title;
    formObj.action='admin.php?resource=' + resource;
    formObj.submit();
}
