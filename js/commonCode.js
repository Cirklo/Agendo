function go (objIMG) {
    
    s=objIMG.src;
    objDIV=document.getElementById(objIMG.id + 'div');
    
    
    if (s.substring(s.length-5,s.length)!="_.png"){
        document.getElementById('video').src='pics/video.png';
        document.getElementById('help').src='pics/ask.png';
        document.getElementById('resources').src='pics/resource.png';
        document.getElementById('user').src='pics/user.png';
        objIMG.src=s.substring(0,s.length-4) + "_.png";
        
        document.getElementById('userdiv').style.display='none';
        document.getElementById('resourcesdiv').style.display='none';
        document.getElementById('videodiv').style.display='none';
        objDIV.style.display = "block";   

    } else {
        objIMG.src=s.substring(0,s.length-5) + ".png";
        objDIV.style.display = "none";   
    }
}

function submitUser(phpFile,resource,user,pass,loginToDatumo) {
    formObj=document.getElementById('edituser');
	if(user==null){
		if (checkfield(formObj.user_idm)) return;
		if (checkfield(formObj.user_passwd)) return;
		formObj.user_idm.value=formObj.user_idm.title;
	}
	else{
		formObj.user_idm.value = user;
		formObj.user_passwd = pass;
	}
	if(loginToDatumo == 1){
		url="commonCode.php?checkUserAndPass&user="+formObj.user_idm.value+"&pass="+formObj.user_passwd.value;
		var result = ajaxRequest(url);
		if(result != ''){ //wrong login
			alert(result);
			//clean all fields
			// formObj.user_idm.value = "";
			// formObj.user_passwd.value = "";
			return;
		}
	}
		
	formObj.action= phpFile + '.php?resource=' + resource;
    formObj.submit();
}

function logOff(phpFile,resource){
    formObj=document.getElementById('edituser');
    formObj.action = phpFile + '.php?logOff=true&resource=' + resource;
    formObj.submit();
}

function ajaxRequest(url){
	if (window.XMLHttpRequest){ 
        xmlhttp=new XMLHttpRequest();
    } else {
        alert("Your browser does not support XMLHTTP!");
        exit;
    }
	xmlhttp.open("GET",url,false);
    xmlhttp.send(null);
    var str=xmlhttp.responseText;
    return str;
}

