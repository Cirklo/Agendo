<?php
	session_start();
	$_SESSION['path']='../calendar';
	require_once("commonCode.php");


?>
<script type='text/javascript' src='js/jquery-1.5.2.min.js'></script>

<script type="text/javascript" src="js/commonCode.js"></script>
<script type="text/javascript">
// $(document).ready(function() {
window.onload = function (){resizeMe();}

window.onresize = function (){resizeMe();}

	function resizeMe() {
		var element = document.getElementById('all');
		// var height = String(window.innerHeight-5) + 'px';
		var height = String(document.body.offsetHeight-10) + 'px';
		// var width = String(window.innerWidth-5) + 'px';
		var width = String(document.body.offsetWidth-10) + 'px';
		element.style.height = height;
		element.style.width = width;
	}

// });
	function ajaxTest(url, value){
		// value = 'received' + value;
		// $.post(	'teste.php', 
				// {vari:'teste'},
				// function(){
					// alert(value);
				// });
		// url = url + "'" + value + "'";
		// alert(url);
		alert(ajaxSend(url+value));
		// alert(getAjaxResult());
	}

	function dostuff(){
		document.getElementById('bla').checked=!document.getElementById('bla').checked;
	}
	function checkRadioButtons(elementId){
		// var children = document.getElementById(elementId).childNodes;
		var children = document.getElementById(elementId).getElementsByTagName('*');
		for(i=0;i<children.length;i++){
			if(children[i].type == 'radio')
			alert(children[i].id+'----'+children.length);
		}
	}
	
	function addRadio(divName, addToName){
		// var newdiv = document.createElement('div');
		// newdiv.innerHTML = "<input type='radio' name="+divName+" id="+divName+addToName+">"+divName+addToName;
		// var newdiv = document.createTextNode ("<input type='radio' name="+divName+" id="+divName+addToName+">"+divName+addToName);
		// document.getElementById(divName).appendChild(newdiv);
		// document.getElementById(divName).appendChild(bla);
		document.getElementById(divName).innerHTML = document.getElementById(divName).innerHTML + "<tr><td><input type='radio' name="+divName+" id="+divName+addToName+"></td><td>"+divName+addToName + "</td></tr>";
	}
</script>
<?php
	// $time1 = microtime(true);
	// $sql2 = "select date_format(entry_datetime, '%w') from entry where entry_id=611";
	// echo $sql2."<br></br>";
	// $res2 = dbHelp::mysql_query2($sql2);
	// $arr2 = dbHelp::mysql_fetch_row2($res2);
	// echo $arr2[0]."<br></br>";
		
	echo metaphone('klansy');
	echo "-";
	echo metaphone('clansy');
	echo "</br>";
	echo soundex('klansy');
	echo "-";
	echo soundex('clansy');
	echo "<br></br>";
	echo metaphone('moeno');
	echo "-";
	echo metaphone('moreno');
	echo "</br>";
	echo soundex('moeno');
	echo "-";
	echo soundex('moreno');
	echo "<br></br>";
	
	echo "<a href='android/AccellValues.apk'>file</a>";
	
	echo str_replace('asdasdasd', '123123', 'qweqweqwe');
	
	echo $_SERVER['REMOTE_ADDR']; 
	echo "<br/>".date('l jS \of F Y h:i:s A');
	addGoggleSearch();

	
	function addGoggleSearch(){
		echo("<!-- Use of this code assumes agreement with the Google Custom Search Terms of Service. -->");
		echo("<!-- The terms of service are available at http://www.google.com/cse/docs/tos.html -->");
		echo("<form name='cse' id='searchbox_demo' action='http://www.google.com/cse'>");
		echo("<input type='hidden' name='cref' value='' />");
		echo("<input type='hidden' name='ie' value='utf-8' />");
		echo("<input type='hidden' name='hl' value='' />");
		echo("<input name='q' type='text' size='40' />");
		echo("<input type='submit' name='sa' value='Search' />");
		echo("</form>");
		echo("<script type='text/javascript' src='http://www.google.com/cse/tools/onthefly?form=searchbox_demo&lang='></script>");
	}

	$arr = explode(";","treta;");
	echo "result->".sizeof($arr);
	echo "<input lang=send type=checkbox onkeypress='return noenter()' id='bla' name='bla' checked/>";
	echo "<input id='bla2' type=button value='bla' onclick='dostuff()'/>";
	
	echo "<table id='testeDiv'></div>";
	
	echo "<script type='text/javascript'>";
	for($i=0;$i<5;$i++)
		echo "addRadio('testeDiv','".$i."');";
		echo "alert(document.getElementById('testeDiv0').checked);";
	echo "</script>";
	echo "<input id='bla3' type=button value='bla3' onclick=\"checkRadioButtons('testeDiv')\"/>";

?>