<?php
require_once("commonCode.php");

// Gets from javascript
$pin = $_GET['pin'];
$resource = $_GET['resource'];
if(!isset($resource)){
	echo "<meta HTTP-EQUIV='REFRESH' content='0; url=./'>";
}
else
	$_SESSION['tablet_entry_resource'] = $resource;

if(isset($pin)){
	if($pin != '')
		getUserName($pin);
	else
		userExit();
}
//***********************


$signedIn = false;
function getUserName($pin){
	$sql = "select user_firstname, user_lastname from ".dbHelp::getSchemaName().".user where user_id = '".$pin."'";
	$res = dbHelp::mysql_query2($sql);
	$arr = dbHelp::mysql_fetch_row2($res);
	if(isset($arr[0])){
		echo "true\n";
		echo $arr[0]." ".$arr[1]." is using this resource";
		$_SESSION['tablet_entry_user'] = $pin;
		$_SESSION['tablet_entry_dateenter'] = $currentTime;
		$currentTime = dbHelp::convertDateStringToTimeStamp(date("YmdHi", time()),'%Y%m%d%H%i');
		$resource = $_SESSION['tablet_entry_resource'];
		// creates a random number(int) for the reperition table
		$randNumber = rand();
		$sql = "insert into repetition(repetition_code) values ('".$randNumber."')";
		$res = dbHelp::mysql_query2($sql) or die ($sql);
		// gets the id from repetition for the entry table
		$sql = "select repetition_id from repetition where repetition_code = '".$randNumber."'";
		$res = dbHelp::mysql_query2($sql) or die ($sql);
		$arr = dbHelp::mysql_fetch_row2($res);
		$repId = $arr[0];
		// converts date to sqlformat
		$sql = "select ".$currentTime;
		$res = dbHelp::mysql_query2($sql) or die ($sql);
		$arr = dbHelp::mysql_fetch_row2($res);
		// inserts in entry all values
		$sql = "insert into entry(entry_user, entry_datetime, entry_slots, entry_assistance, entry_repeat, entry_status, entry_resource, entry_action) values (".$pin.",'".$arr[0]."',1,0,".$repId.",1,".$resource.",'".$arr[0]."')";
		$res = dbHelp::mysql_query2($sql) or die ($sql);
		// gets the entry number and puts it in session
		$sql = "select entry_id from entry where entry_user = ".$pin." and entry_datetime = ".$currentTime." and entry_slots = 1 and entry_assistance = 0 and entry_repeat = ".$repId." and entry_status = 1 and entry_resource = ".$resource;
		$res = dbHelp::mysql_query2($sql) or die ($sql);
		$arr = dbHelp::mysql_fetch_row2($res);
		$_SESSION['tablet_entry'] = $arr[0];
	}
	else{
		echo "false\n";
		echo "Can't find any user with this pin";
		signOff();
	}
	exit;
}

function userExit(){
		if(isset($_SESSION['tablet_entry_user'])){
			
			$sql = "select resource_resolution from resource where resource_id = ".$_SESSION['tablet_entry_resource'];
			$res = dbHelp::mysql_query2($sql) or die ($sql);
			$arr = dbHelp::mysql_fetch_row2($res);
			
			$currentTime = time();
			$slots = (time()+60 - time($_SESSION['tablet_entry_dateenter'])) / 60 / $arr[0];
			$slots = ceil($slots);
			$currentTime = dbHelp::convertDateStringToTimeStamp(date("YmdHi", time()),'%Y%m%d%H%i');
			// $sql = "update tablet_entry set tablet_entry_dateexit = ".$currentTime." where tablet_entry_user = ".$_SESSION['tablet_entry_user']." and tablet_entry_resource = ".$_SESSION['tablet_entry_resource']." and tablet_entry_dateenter = ".$_SESSION['tablet_entry_dateenter'];
			$sql = "update entry set entry_action = ".$currentTime.", entry_slots = ".$slots." where entry_id = ".$_SESSION['tablet_entry'];
			$res = dbHelp::mysql_query2($sql);
		}
		echo "false\n";
		echo "No user is using this resource now";
		signOff();
	exit;
}

function signOff(){
	$_SESSION['tablet_entry_user'] = null;
	$_SESSION['tablet_entry_resource'] = null;
	$_SESSION['tablet_entry_dateenter'] = null;
}

echo "<link href='css/tablet.css' rel='stylesheet' type='text/css'>";
useJquery('js/jquery-1.5.2.min.js');
?>

<script type="text/javascript" src="js/commonCode.js"></script>
<script type="text/javascript">
window.onload = function (){resizeMe();}

window.onresize = function (){resizeMe();}

function resizeMe() {
	var element = document.getElementById('all');
	var height = String(window.innerHeight-5) + 'px';
	// var height = String(document.body.offsetHeight) + 'px';
	var width = String(window.innerWidth-5) + 'px';
	// var width = String(document.body.offsetWidth) + 'px';
	element.style.height = height;
	element.style.width = width;
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

function returnButton(buttonId){
	var currentInput = document.getElementById('pin');
	currentInput.value += buttonId;
}

function clearPin(){
	document.getElementById('pin').value = '';
	document.getElementById('userLabel').value = 'No user is using this resource now';
	resizeMe();
}

function userEnter(resource){
	var bigButtonClass;
	var stateClass;
	var enterButtonValue;
	// var message = ajaxRequest("tablet.php?pin=" + document.getElementById('pin').value + '&resource=' + resource).split('\n');
	var url = "tablet.php?pin=" + document.getElementById('pin').value + '&resource=' + resource;
	// var message = ajaxSend("tablet.php?pin=" + document.getElementById('pin').value + '&resource=' + resource).split('\n');
	// alert(text);
	// var message = ajaxSend(url);
	// var message = getAjaxResult();
	// alert(message);
	// var messageArray = message.split('\n')
	// alert(messageArray[0]);
		$.get(url, {}, function(data){enterOrExit(data)});
	// if(message[0] == 'true'){
		// enterButtonValue = 'Exit';
		// clearPin();
		// bigButtonClass = 'redBigButton';
		// stateClass = 'redStateMessage';
		// enableDisableButtons(true);
	// }
	// else{
		// enterButtonValue = 'Enter';
		// bigButtonClass = 'bigButton';
		// stateClass = 'stateMessage';
		// enableDisableButtons(false);
	// }
	// clearPin();
	// document.getElementById('enterExit').className = bigButtonClass;
	// document.getElementById('enterExit').value = enterButtonValue;
	// document.getElementById('userLabel').className = stateClass;
	// document.getElementById('userLabel').value = message[1];
}

function enableDisableButtons(trueOrFalse){
	for(i=0;i<10;i++)
		document.getElementById(String(i)).disabled = trueOrFalse;
	document.getElementById('clearButton').disabled = trueOrFalse;
}

function enterOrExit(data){
	var message = data.split('\n')

	if(message[0] == 'true'){
		enterButtonValue = 'Exit';
		clearPin();
		bigButtonClass = 'redBigButton';
		stateClass = 'redStateMessage';
		enableDisableButtons(true);
	}
	else{
		enterButtonValue = 'Enter';
		bigButtonClass = 'bigButton';
		stateClass = 'stateMessage';
		enableDisableButtons(false);
	}

	clearPin();
	document.getElementById('enterExit').className = bigButtonClass;
	document.getElementById('enterExit').value = enterButtonValue;
	document.getElementById('userLabel').className = stateClass;
	document.getElementById('userLabel').value = message[1];
}
</script>

<?php

echo "<table id='all'>";
	echo "<tr align='center'>";
		echo "<td>";
			echo "<table id='idButtons'>";
				$buttonId = 0;
				for($line = 0; $line<3; $line++){
					echo "<tr align='center'>";
					for($column = 0; $column<3; $column++){
						$buttonId++;
						echo "<td><input id='".$buttonId."' type='button' value='".$buttonId."' class='normalButton'onclick=returnButton(".$buttonId.")></input></td>";
					}
					echo "</tr>";
				}
				echo "<tr align='center'>";
					echo "<td><input id='0' class='normalButton' type='button' value='0' onclick=returnButton(".$buttonId.")></button></td>";
					echo "<td colspan='2'><input id = 'clearButton' class='bigButton' onclick=clearPin() type='button' value='Clear'></input></td>";
				echo "</tr>";
			echo "</table>";
		echo "</td>";

		echo "<td>";
			echo "<table>";
				echo "<tr align='center'><td><input type='password' id='pin' width='50' style='text-align:center;' disabled></td></tr>";
				echo "<tr></tr>";
				echo "<tr align='center'><td><input id='enterExit' class='bigButton' onclick=userEnter(".$resource.") type='button' value='Enter'></input></td></tr>";
			echo "</table>";
		echo "</td>";
	echo "</tr>";
	echo "<tr align='center'><td colspan = 2><input type='text' class='stateMessage' id='userLabel' value ='No user is using this resource now' disabled></input></td></tr>";
echo "</table>";
?>