<?php
	//session_start();	
	// This file was altered by Pedro Pires (The chosen two)
	require_once("commonCode.php");
	logIn();
?>

<head>
<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1" />
<link href="css/intro.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="js/ajax.js"></script>
<script type="text/javascript" src="js/commonCode.js"></script>
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

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<body>
<?php
// require_once(".htconnect.php"); $connect = new dbConnection();
require_once("functions.php");

$extra = '';
$class = '';
// Shows a specific resource
if (isset($_GET['class'])) {
    $class=clean_input($_GET['class']);
    // $sql="SELECT sum(entry_slots) e,resource_name, resource_id from entry, resource where resource_id=entry_resource and entry_status in (1,2) group by resource_name order by e desc";
    $sql="SELECT sum(entry_slots*resource_resolution) e,resource_name, resource_id from entry, resource where resource_id=entry_resource and entry_status in (1,2) group by resource_name,resource_id order by e desc";
    if ($class==0){
        // $sql="select 1,resource_name,resource_id from resource order by resource_name";
        $sql="select resource_name,type_name, resstatus_name, resource_id from resource, resstatus, type where resource_type = type_id and resource_status = resstatus_id order by resource_name";
	}
    $extra='resource_type='. $class . ' and';
    $limit='';
    $datefilter='';
// Shows most used resources filtered by a month of use
} else {
    $class='';
    $sql="SELECT sum(entry_slots*resource_resolution) e,resource_name, resource_id from entry, resource where resource_id=entry_resource and entry_status in (1,2) group by resource_name,resource_id order by e desc limit 10";
    // $datefilter=' and entry_datetime between date_sub(now(),interval 1 month) and now()';
    $datefilter=" and entry_datetime between ".dbHelp::date_sub('now()', '1', 'month')." and now()";
}

echo "<div id='logo' class='logo'>";
	echo "<table border=0>";
		echo "<tr>";
			echo "<td style='font-size:11px;text-align:center'>";
				echo "<img style='cursor:pointer' id=agendo title='agendo' src=pics/agendo.png onmouseover=\"this.src='pics/agendo_.png'\" onmouseout=\"this.src='pics/agendo.png'\" onclick=\"javascript:window.open('http://www.cirklo.org','_blank','directories=yes,status=yes,menubar=yes,location=yes,resizable=yes,scrollbars=yes,width=1024,height=768')\"";
			echo "</td>";
			//echo "<br><font color=#f4c337>circlo.org</td>";
			echo "<td width=100% rowspan=3 align=right>";
				echo "<a href=http://www.mozilla-europe.org style='text-decoration:none'><font color=#FFFFFF size=1.5px>Optimized for Mozilla Firefox v4.0</font></a>";
				echo "<br><br><br><br><br>";
				echoUserVideosResourceHelpLinks('index', 0);
			echo "</td>";
		echo "</tr>";
	echo "</table>";
echo "</div>";

// Videos div
echoVideosDiv();

// Resources div
echoResourcesDiv();

// User/management div
echoUserDiv('index', 0);

echo "<div class=table>";
echo "<table class=equilist>";
	echo "<tr>";
		if($class != '0'){
			echo "<td class=title_>Most Used Resources</td>";
			echo "<td class=title_>Groups</td><td class=title_ >Share</td>";
		}
		else {
			echo "<td class=title_>All Resources</td>";
			echo "<td class=title_>Resource Type</td><td class=title_ >Permission Type</td>";
		}
	echo "</tr>";
	
	// $resResource=$connect->query($sql) or die ($sql);
	$resResource=dbHelp::mysql_query2($sql);
	
	// for ($i=0;$i<dbHelp::mysql_numrows2($resResource);$i++) {
		// mysql_data_seek($resResource,$i);
		// $arrResource=dbHelp::mysql_fetch_array2($resResource);
	for ($i=0;$i<dbHelp::mysql_numrows2($resResource);$i++) {
		$arrResource=dbHelp::mysql_fetch_row2($resResource);
		if ($class=='0' ) {
			// echo "<th><a href=weekview.php?resource=" . $arrResource[2]. ">" . $arrResource[1] .  "</a></th>\n";
			 // resource_name,type_name, resstatus_name, resource_id
			echo "<th><a href=weekview.php?resource=" . $arrResource[3]. " class='asd'>" . $arrResource[0] .  "</a></th>\n";
			echo "<td>".$arrResource[1]."</td>\n";
			echo "<td style='height:18px;'>".$arrResource[2]."</td>\n";
			echo "</tr>\n";
		} else {
			$sql="SELECT sum(entry_slots*resource_resolution) e,department_name from entry, resource, department, ".dbHelp::getSchemaName().".user where $extra entry_user=user_id and user_dep=department_id and department_id<>17 and resource_id=entry_resource and entry_status in (1,2) $datefilter and resource_id=" . $arrResource[2] . " group by department_name order by e desc limit 3";
			// $res=dbHelp::mysql_query2($sql) or die ($sql);
			// $res=$connect->query($sql) or die ($sql);
			$res=dbHelp::mysql_query2($sql) or die ($sql);
			// for ($j=0;$j<dbHelp::mysql_numrows2($res);$j++) {
				// mysql_data_seek($res,$j);
				// $arr=dbHelp::mysql_fetch_array2($res);
			// foreach($res as $arr){
			for ($j=0;$j<dbHelp::mysql_numrows2($res);$j++) {
				$arr=dbHelp::mysql_fetch_row2($res);
				if ($j==0) $max =$arr[0];
				echo "<tr>";
					if ($j==0)
						echo "<th rowspan=" . dbHelp::mysql_numrows2($res) . "><a href=weekview.php?resource=" . $arrResource[2]. " class='asd'>" . $arrResource[1] .  "</a></th>\n";
					echo "<td>" . $arr[1] . "</td>\n";
					echo "<td style='height:18px;'><img src=pics/scale.gif height=18px width=". $arr[0]/$max*250 . "px'</td>\n";
				echo "</tr>\n";
			}
		}
	}
echo "</table></div>";

echo "<div style='width:752px'>";
	echo "<table border=0 style='width:100%'>";
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
echo "</div>";
?>