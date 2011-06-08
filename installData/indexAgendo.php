<?php
	//session_start();	
	// This file was altered by Pedro Pires (The chosen two)
	session_start();
	$pathOfIndex = explode('\\',getcwd());
	$_SESSION['path'] = "../".$pathOfIndex[sizeof($pathOfIndex)-1];
	require_once("../agendo/commonCode.php");
	require_once("../agendo/functions.php");
	logIn();
	importJs();
?>

<head>
<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1" />
<link href="../agendo/css/intro.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="../agendo/js/ajax.js"></script>
<script type="text/javascript">
function noenter() {
  return !(window.event && window.event.keyCode == 13);
}

// Checks if a field is filled, if its empty returns true
function checkfield(field) {   
    if (field.value=='') {
        field.focus();
        alert("Field " + field.name + " required!");
        //window.location.reload();
        // exit;
        return true;
    }
    return false;
}

function seeResourceAlert(message){
	alert(message);
}
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<body>
<?php

$extra = '';
$class = '';
// Shows a specific resource
if (isset($_GET['class'])) {
    $class=clean_input($_GET['class']);
    // $sql="SELECT sum(entry_slots*resource_resolution) e,resource_name, resource_id from entry, resource where resource_id=entry_resource and entry_status in (1,2) group by resource_name,resource_id order by e desc";
	$sql="select resource_name,resourcetype_name, resstatus_name, resource_id from resource, resstatus, resourcetype where resource_type = resourcetype_id and resource_status = resstatus_id and resource_type=".$class." order by resource_name";
    if ($class==0){
        // $sql="select 1,resource_name,resource_id from resource order by resource_name";
        $sql="select resource_name,resourcetype_name, resstatus_name, resource_id from resource, resstatus, resourcetype where resource_type = resourcetype_id and resource_status = resstatus_id order by resource_name";
	}
    $extra='resource_type='. $class . ' and';
    $limit='';
    $datefilter='';
// Shows most used resources filtered by a month of use
} else {
    $sql="SELECT sum(entry_slots*resource_resolution) e,resource_name, resource_id from entry, resource where resource_id=entry_resource and entry_status in (1,2) group by resource_name,resource_id order by e desc limit 10";
    // $datefilter=' and entry_datetime between date_sub(now(),interval 1 month) and now()';
    $datefilter=" and entry_datetime between ".dbHelp::date_sub('now()', '1', 'month')." and now()";
}

// echo "<div id='logo' class='logo' style='background:url(".$_SESSION['path']."/pics/header.png) no-repeat left top;'>";
// agendo Resource Schedule
// echo "<div id='logo' class='logo'>";
echo "<table id='master' style='width:800' align=center>";
	echo "<tr><td>";
		echo "<table class='logo' style='height:100%'>";
			echo "<tr>";
				$imgWidth=200;
				echo "<td style='font-size:11px;text-align:left;padding:0px;margin:0px' width='".$imgWidth."'>";
				echo "<img width='".$imgWidth."' style='cursor:pointer;' id=agendo title='agendo' src=pics/agendo.png onmouseover=\"this.src='pics/agendo_.png'\" onmouseout=\"this.src='pics/agendo.png'\" onclick=\"javascript:window.open('http://www.cirklo.org','_blank','directories=yes,status=yes,menubar=yes,location=yes,resizable=yes,scrollbars=yes,width=1024,height=768')\" />";
				echo "</td>";
				
				echo "<td align='right' >";
				echo "<table style='height:100%;width:100%'>";
					echo "<tr valign='top'>";
						echo "<td align='right'>";
						loggedInAs('index', 0);
						echo "</td>";
					echo "</tr>";
					
					echo "<tr>";
						echo "<td align='left' style='padding:20px'>";	
						echo "<font size='6px' style='color:#F7C439'>Resource Scheduler</font>";
						echo "</td>";	
					echo "</tr>";
				echo "</table>";
				echo "</td>";	
			echo "</tr>";
			
			echo "<tr>";
				echo "<td align='center'>";
				echo "<a href=http://www.mozilla-europe.org style='text-decoration:none'><font color=#FFFFFF size=1.5px>Optimized for Mozilla Firefox v4.0</font></a>";
				echo "</td>";
				
				echo "<td align='right'>";
				echoUserVideosResourceHelpLinks();
				echo "</td>";
			echo "</tr>";
		echo "</table>";
			
		// echo "</td></tr>";
	// echo "</div>";

	// Videos div
	echoVideosDiv();

	// Resources div
	echoResourcesDiv();

	// User/management div
	echoUserDiv('index', 0);

	// echo "<div class=logo>";
	echo "<table class=equilist>";
		if($class == ''){
			echo "<tr>";
				echo "<td class=title_>Most Used Resources</td>";
				echo "<td class=title_ >Share</td>";
			echo "</tr>";
			$sql="SELECT sum(entry_slots*resource_resolution) e, resource_name, resource_id from entry, resource where resource_id = entry_resource and entry_status in (1,2) ".$datefilter." group by resource_name order by e desc";
			$res=dbHelp::mysql_query2($sql) or die ($sql);
			$numberRows = dbHelp::mysql_numrows2($res);
			for($i=0;$arr=dbHelp::mysql_fetch_row2($res);$i++){
				if ($i==0) $max = $arr[0];
				echo "<tr>";
					
					$varFlag = "href=weekview.php?resource=" . $arr[2];
					// $sqlFlag = "select mainconfig_secureResources from mainconfig";
					$sqlFlag = "select configparams_value from configparams where configparams_name ='secureresources'";
					try{
						$resFlag=dbHelp::mysql_query2($sqlFlag);
						// while($arrFlag=dbHelp::mysql_fetch_row2($resFlag));
						$arrFlag=dbHelp::mysql_fetch_row2($resFlag);
						if($arrFlag[0] == '1'){
							$sqlFlag = "select allowedips_iprange from allowedips where allowedips_id = 1";
							$resFlag=dbHelp::mysql_query2($sqlFlag);
							$arrFlag=dbHelp::mysql_fetch_row2($resFlag);
							$ip = $_SERVER['REMOTE_ADDR'];
							$ip = substr($ip, 0, strripos($ip, '.'));
							if($arrFlag[0] != $ip){
								$varFlag = "style='cursor:pointer' onclick='$.jnotify(\"You are not allowed to access resources from this ip.\")'";
							}
							else if(!isset($_SESSION['user_name']) || $_SESSION['user_name'] == ''){
								$varFlag = "style='cursor:pointer' onclick='$.jnotify(\"Please sign in to be able to access resources.\")'";
							}
							else{
								$varFlag = "href=weekview.php?resource=" . $arr[2];
								break;
							}
						}
					}
					catch(Exception $e){
						echo $e;
					}
					
					echo "<th ><a ".$varFlag." class='asd'>".$arr[1]."</a></th>";
					echo "<td style='height:18px;'>";
					echo "<img src=pics/scale.gif height=100% width=".($arr[0]/$max*100)."%'/>";
					echo "</td>";
				echo "</tr>";
			}
		}
		else {
			echo "<tr>";
				echo "<td class=title_>All Resources</td>";
				echo "<td class=title_>Resource Type</td><td class=title_ >Permission Type</td>";
			echo "</tr>";
			$resResource=dbHelp::mysql_query2($sql);
			for ($i=0;$i<dbHelp::mysql_numrows2($resResource);$i++) {
				$arrResource=dbHelp::mysql_fetch_row2($resResource);
					echo "<th><a href=weekview.php?resource=" . $arrResource[3]. " class='asd'>" . $arrResource[0] .  "</a></th>\n";
					echo "<td>".$arrResource[1]."</td>\n";
					echo "<td style='height:18px;'>".$arrResource[2]."</td>\n";
					echo "</tr>";
			}
		}
	echo "</table>";//</div>";

		echo "<table style='width:100%'>";
			echo "<tr>";
				echo "<td align=left valign=top>";
					echo "<a href='http://www.facebook.com/pages/Cirklo/152674671417637?ref=ts'>";
						echo "<img src=pics/facebook_logo.png border=0>";
					echo "</a>";
					echo "<a href='http://twitter.com/cirklo2010'>";
						echo "<img src=pics/twitter_logo.png border=0>";
					echo "</a>";
				echo "</td>";
				echo "<td>";
					echo "<p style='text-align:right'>A user cannot damage any resource or, through his/her inaction, allow somebody else to damage it<br>";
					echo "A user must follow any given instructions from the staff, except if such instructions conflicts with the First Law<br>";
					echo "A user must take care of her/his project related items unless this conflicts with the First and Second Laws";
					echo "<p>Adapted from \"I, Robot\" (Isaac Asimov)";
				echo "</td>";
			echo "</tr>";
		echo "</table>";

	echo "</td></tr>";
echo "</table>";
?>