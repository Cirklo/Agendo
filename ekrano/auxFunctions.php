<?php 

require_once ".htconnect.php";

if(isset($_GET['type'])){
	$type=$_GET['type'];
	switch($type){
		case 0:
			resourceDisplay();
			break;
		case 1:
			$ld=loadInfo($_GET['equip'], $_GET['resource'], $_GET['time']);
			echo $ld;
			break;
	}
}


function resourceDisplay(){
	$conn=new dbConnection();
	
	//url variables
	if(isset($_GET['resource']))	$resource_id=$_GET['resource'];
	$query="SELECT board_address, user_login
	FROM board, resource, user, equip 
	WHERE user_id=equip_user 
	AND equip_boardid=board_id 
	AND equip_resourceid=resource_id 
	AND resource_id='$resource_id' 
	GROUP BY board_address";
	$sql=$conn->query($query);
	$row=$sql->fetch();
	echo "<table class=display cellpadding=3px>";
	echo "<tr><td><b>Board Address</td><td>$row[0]</td></tr>";
	echo "<tr><td><b>Responsible</b></td><td>$row[1]</td></tr>";
	echo "</table>";
	monitoredParams($resource_id);
}

function monitoredParams($resource_id){
	$conn=new dbConnection();
	$query="SELECT equip_id, parameter_type, equip_desc, parameter_bool
	FROM resource, parameter, equip 
	WHERE equip_para=parameter_id
	AND equip_resourceid=resource_id 
	AND resource_id='$resource_id'";	
	$sql=$conn->query($query);
	echo "<table class=display cellpadding=3px>";
	//set the number of plots into a variable
	$noPlots=$sql->rowCount();
	for($i=0;$row=$sql->fetch();$i++){
		//Parameters to check
		if($row[3]){
			$check="checked";
		} else {
			$check="";
		}
		echo "<tr>";
		echo "<td><input type=checkbox name=".($i+1)." id=".($i+1)." $check onclick=getValuesToPlot()></td>";
		echo "<td>$row[1]</td>";
		echo "<td><input type=text class=params name=tag_".($i+1)." id=tag_".($i+1)." value='$row[2]' readonly></td>";
		echo "</tr>";
	}
	echo "</table>";
	drawPlots($noPlots);
}

function drawPlots($noPlots){
	echo "<div class=plots_holder>";
	//echo "<table border=1><tr>";
	//increment counter to draw all plots
	for($i=0;$i<$noPlots;$i++){
		echo "<div id=plot_".($i+1)." class=plots_div></div>";
	}
	//echo "</tr></table>";
	echo "</div>";	
}

function loadInfo($parameter_id, $resource_id, $tm){	
	//call database class
	$conn=new dbConnection();
	
	//initialize local variables
	$calc = 288 * $tm;		
	
	$query="SELECT measure_value, measure_date, equip_calibration 
		FROM measure, equip, parameter 
		WHERE measure_equip = equip_id 
		AND parameter_id = equip_para 
		AND equip_resourceid = '".$resource_id."'
		AND parameter_id = '".$parameter_id."' AND measure_date > NOW() - INTERVAL '".$tm."' DAY 
		ORDER BY measure_id DESC"; 
	$sql=$conn->query($query);
	for($i=0;$row=$sql->fetch();$i++){				
		$time = $row[1];
		$year = (int)$time[0].$time[1].$time[2].$time[3];
		$month = (int)$time[5].$time[6];
		$day = (int)$time[8].$time[9];
		$hour = (int)$time[11].$time[12];
		$minute = (int)$time[14].$time[15];
		$sec = (int)$time[17].$time[18];
		// first correct the timestamps - they are recorded as the daily
		// midnights in UTC+0100, but Flot always displays dates in UTC
		// so we have to add one hour to hit the midnights in the plot
		$value = $row[0];
		$cval = $row[2];
		eval ("\$var = ".str_replace(':','$',$cval).";");
		
		$timestamp = mktime($hour,$minute,$day,$month,$day,$year);
		$measure[] = array($timestamp*1000, $var);
	}
	$str = json_encode($measure);
	return $str;
}





?>