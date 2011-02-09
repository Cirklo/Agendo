<?php
	//session_start();	
	// This file was altered by Pedro Pires (The chosen two)
	require_once("commonCode.php");
	logIn();
?>

<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
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
require_once(".htconnect.php");
require_once("functions.php");

$extra='';
// Shows a specific resource
if (isset($_GET['class'])) {
    $class=clean_input($_GET['class']);
    $sql="SELECT sum(entry_slots) e,resource_name, resource_id from entry, resource where resource_id=entry_resource and entry_status in (1,2) group by resource_name order by e desc";

    if ($class==0) {
        $sql="select 1,resource_name,resource_id from resource order by resource_name";
    }
    $extra='resource_type='. $class . ' and';
    $limit='';
    $datefilter='';
// Shows most used resources filtered by a month of use
} else {
    $class='';
    $sql="SELECT sum(entry_slots) e,resource_name, resource_id from entry, resource where resource_id=entry_resource and entry_status in (1,2) group by resource_name order by e desc limit 10";
	// To show the same results uncomment this line and comment the one after
    // $datefilter='';
    $datefilter=' and entry_datetime between date_sub(now(),interval 1 month) and now()';
}
$resResource=mysql_query($sql);

echo "<div id='logo' class=logo>";
	echo "<table border=0>";
		echo "<tr>";
			echo "<td style='font-size:11px;text-align:center'>";
				echo "<img style='cursor:pointer' id=agendo title='agendo' src=pics/agendo.png onmouseover=\"this.src='pics/agendo_.png'\" onmouseout=\"this.src='pics/agendo.png'\" onclick=\"javascript:window.open('http://www.cirklo.org','_blank','directories=yes,status=yes,menubar=yes,location=yes,resizable=yes,scrollbars=yes,width=1024,height=768')\"";
			echo "</td>";
			//echo "<br><font color=#f4c337>circlo.org</td>";
			echo "<td width=100% rowspan=3 align=right>";
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
		echo "<td class=title_>Most Used Resources</td>";
		echo "<td class=title_>Groups</td><td class=title_ >share</td>";
	echo "</tr>";
	for ($i=0;$i<mysql_num_rows($resResource);$i++) {
		mysql_data_seek($resResource,$i);
		$arrResource=mysql_fetch_array($resResource);
		$sql="SELECT sum(entry_slots) e,department_name from entry, resource, department, user where $extra entry_user=user_id and user_dep=department_id and department_id<>17 and resource_id=entry_resource and entry_status in (1,2) $datefilter and resource_id=" . $arrResource[2] . " group by department_name order by e desc limit 3";

		$res=mysql_query($sql) or die ($sql);
		if ($class=='0' ) {
			echo "<th><a href=weekview.php?resource=" . $arrResource[2]. ">" . $arrResource[1] .  "</a></th>\n";
			echo "<td></td>\n";
			echo "<td style='height:18px;'></td>\n";
			echo "</tr>\n";
		} else {
			for ($j=0;$j<mysql_num_rows($res);$j++) {
				mysql_data_seek($res,$j);
				$arr=mysql_fetch_array($res);
				if ($j==0) $max =$arr[0];
				echo "<tr>";
					if ($j==0)
						echo "<th rowspan=" . mysql_num_rows($res) . "><a href=weekview.php?resource=" . $arrResource[2]. ">" . $arrResource[1] .  "</a></th>\n";
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