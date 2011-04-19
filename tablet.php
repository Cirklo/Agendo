<?php
require_once("commonCode.php");

$pin = $_GET['pin'];
if(isset($pin)){
	if($pin != '')
		getUserName($pin);
	else
		userExit();
}

$signedIn = false;
function getUserName($pin){
	$sql = "select user_firstname, user_lastname from ".dbHelp::getSchemaName().".user where user_id = '".$pin."'";
	$res = dbHelp::mysql_query2($sql);
	$arr = dbHelp::mysql_fetch_row2($res);
	// $signedIn = true;
	if(isset($arr[0])){
		// $entering = true;
		echo "true\n";
		echo $arr[0]." ".$arr[1]." is using this resource";
		$_SESSION['tablet_entry_user'] = $pin;
		$_SESSION['tablet_entry_resource'] = '1';
		$currentTime = dbHelp::convertDateStringToTimeStamp(date("YmdHi", time()),'%Y%m%d%H%i');
		$_SESSION['tablet_entry_dateenter'] = $currentTime;
		$sql = "insert into tablet_entry(tablet_entry_user, tablet_entry_resource, tablet_entry_dateenter) values (".$pin.",1, ".$currentTime.")";
		$res = dbHelp::mysql_query2($sql);
	}
	else{
		// $entering = false;
		echo "false\n";
		echo "Can't find any user with this pin";
		signOff();
	}
	exit;
}

function userExit(){
	// $entering = false;
	// if($signedIn){
		// echo "false\n";
		// echo "Can't find any user with this pin";
	// }
	// else{
		// $signedIn = false;
		if(isset($_SESSION['tablet_entry_user'])){
			$currentTime = dbHelp::convertDateStringToTimeStamp(date("YmdHi", time()),'%Y%m%d%H%i');
			$sql = "update tablet_entry set tablet_entry_dateexit = ".$currentTime." where tablet_entry_user = ".$_SESSION['tablet_entry_user']." and tablet_entry_resource = ".$_SESSION['tablet_entry_resource']." and tablet_entry_dateenter = ".$_SESSION['tablet_entry_dateenter'];
			$res = dbHelp::mysql_query2($sql);
		}
		echo "false\n";
		echo "No user is using this resource now";
		signOff();
	// }
	exit;
}

function signOff(){
	$_SESSION['tablet_entry_user'] = null;
	$_SESSION['tablet_entry_resource'] = null;
	$_SESSION['tablet_entry_dateenter'] = null;
}

echo "<link href='css/tablet.css' rel='stylesheet' type='text/css'>";
?>

<script type="text/javascript">
window.onload = function (){resizeMe();}

window.onresize = function (){resizeMe();}

function resizeMe() {
	var element = document.getElementById('all');
	var height = String(window.innerHeight-5) + 'px';
	// var height = String(document.body.offsetHeight) + 'px';
	var width = String(window.innerWidth-5) + 'px';
	// var width = String(document.body.offsetWidth) + 'px';
	// alert(height+'-'+width);
	element.style.height = height;
	element.style.width = width;
	// document.body.offsetWidth
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

function userEnter(){
	var bigButtonClass;
	var stateClass;
	var enterButtonValue;
	var message = ajaxRequest("tablet.php?pin=" + document.getElementById('pin').value).split('\n');

	if(message[0] == 'true'){
		enterButtonValue = 'Exit';
		clearPin();
		bigButtonClass = 'redBigButton';
		stateClass = 'redStateMessage';
		enableDisableButtons(true);
		clearPin();
	}
	else{
		enterButtonValue = 'Enter';
		bigButtonClass = 'bigButton';
		stateClass = 'stateMessage';
		enableDisableButtons(false);
		clearPin();
	}
	document.getElementById('enterExit').className = bigButtonClass;
	document.getElementById('enterExit').value = enterButtonValue;
	document.getElementById('userLabel').className = stateClass;
	document.getElementById('userLabel').value = message[1];
}

function enableDisableButtons(trueOrFalse){
	for(i=0;i<10;i++)
		document.getElementById(String(i)).disabled = trueOrFalse;
	document.getElementById('clearButton').disabled = trueOrFalse;
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
				echo "<tr align='center'><td><input id='enterExit' class='bigButton' onclick=userEnter() type='button' value='Enter'></input></td></tr>";
			echo "</table>";
		echo "</td>";
	echo "</tr>";
	echo "<tr align='center'><td colspan = 2><input type='text' class='stateMessage' id='userLabel' value ='No user is using this resource now' disabled></input></td></tr>";
echo "</table>";
?>