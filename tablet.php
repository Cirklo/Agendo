<?php
require_once("commonCode.php");

// Gets and Posts
$resource = $_GET['resource'];
if(!isset($resource)){
	echo "<meta HTTP-EQUIV='REFRESH' content='0; url=./'>";
}

$pin = $_POST['pin'];
if(isset($pin)){
	if($pin != '')
		getUserName($pin, $resource);
	else
		userExit($pin, $resource, $_POST['dateenter'], $_POST['entry']);
}
//***********************


$signedIn = false;
function getUserName($pin, $resource){
	$sql = "select user_firstname, user_lastname from ".dbHelp::getSchemaName().".user where user_id = '".$pin."'";
	$res = dbHelp::mysql_query2($sql) or die ($sql);
	$arr = dbHelp::mysql_fetch_row2($res);
	if(isset($arr[0])){
		echo "true\n"; // sends to javascript that the user entered, arrayPosition = 0
		echo $arr[0]." ".$arr[1]." is using this resource\n"; // sends the entering message to javascript, arrayPosition = 1
		
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
		$currentTime = dbHelp::convertDateStringToTimeStamp(date("YmdHi", time()),'%Y%m%d%H%i');
		$sql = "select ".$currentTime;
		$res = dbHelp::mysql_query2($sql) or die ($sql);
		$arr = dbHelp::mysql_fetch_row2($res);
		echo $arr[0]."\n"; // sends the current time to javascript, arrayPosition = 2
		
		// inserts in entry all values
		$sql = "insert into entry(entry_user, entry_datetime, entry_slots, entry_assistance, entry_repeat, entry_status, entry_resource, entry_action, entry_comments) values (".$pin.",'".$arr[0]."',1,0,".$repId.",1,".$resource.",'".$arr[0]."', null)";
		$res = dbHelp::mysql_query2($sql) or die ($sql);
		
		// gets the entry number and puts it in session
		$sql = "select entry_id from entry where entry_user = ".$pin." and entry_datetime = ".$currentTime." and entry_slots = 1 and entry_assistance = 0 and entry_repeat = ".$repId." and entry_status = 1 and entry_resource = ".$resource;
		$res = dbHelp::mysql_query2($sql) or die ($sql);
		$arr = dbHelp::mysql_fetch_row2($res);
		echo $arr[0]; // sends the entry id to the javascript, arrayPosition = 3
	}
	else{
		echo "false\n";
		echo "Can't find any user with this pin";
	}
	exit;
}

function userExit($pin, $resource, $dateenter, $entry){
	if(isset($dateenter) && isset($entry)){
		$sql = "select resource_resolution from resource where resource_id = ".$resource;
		$res = dbHelp::mysql_query2($sql) or die ($sql);
		$arr = dbHelp::mysql_fetch_row2($res);
		
		$slots = ceil(((time() - strtotime($dateenter)) / 60.0) / $arr[0]);
		$currentTime = dbHelp::convertDateStringToTimeStamp(date("YmdHi", time()),'%Y%m%d%H%i');
		// $sql = "update tablet_entry set tablet_entry_dateexit = ".$currentTime." where tablet_entry_user = ".$_SESSION['tablet_entry_user']." and tablet_entry_resource = ".$_SESSION['tablet_entry_resource']." and tablet_entry_dateenter = ".$_SESSION['tablet_entry_dateenter'];
		$sql = "update entry set entry_action = ".$currentTime.", entry_slots = ".$slots." where entry_id = ".$entry;
		$res = dbHelp::mysql_query2($sql) or die ($sql);
	}
	echo "false\n"; // sends to javascript that the user exited, arrayPosition = 0
	echo "No user is using this resource now"; // sends the exiting message to javascript, arrayPosition = 1
	exit;
}

echo "<script type='text/javascript' src='js/jquery-1.5.2.min.js'></script>";
echo "<link href='css/tablet.css' rel='stylesheet' type='text/css'>";
echo "<script type='text/javascript' src='js/commonCode.js'></script>";
echo "<script type='text/javascript' src='js/tablet.js'></script>";

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