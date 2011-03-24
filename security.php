<meta http-equiv="refresh" content="60" > 
<?php

$dbConn = mysql_connect("localhost", "root", "luigi336") or die ('Error connecting to mysql');
mysql_select_db('labcal') or die ($sql); //mysql_error());
//require_once("errorHandler.php");

$board = $_GET['board'];

$sql = "SELECT DISTINCT resource_name, resource_id
    FROM resource, equip, board
    WHERE equip_resourceid = resource_id
    AND equip_boardid = board_id
    AND board_parent IN (SELECT board_id FROM board WHERE board_address = '".$board."')";
$res = mysql_query($sql) or die ($error->sqlError(mysql_error(), mysql_errno(), $sql, '', ''));
echo "<table border=0 width=100%>";
$i = 0;
while ($row = mysql_fetch_array($res)){
    if($i == 4 or $i == 8) echo "<tr>";
    echo "<td valign=top>";
    $sql2 = "SELECT measure_value, measure_date, equip_calibration, equip_desc, equip_min, equip_max
    FROM measure, equip 
    WHERE measure_equip = equip_id 
    AND measure_date > '".date('Y-m-d H:i:s',time())."' - INTERVAL 12 MINUTE
    AND equip_resourceid = ".$row[1]."
    AND equip_desc <> 'NA'";
    $res2 = mysql_query($sql2) or die ($error->sqlError(mysql_error(), mysql_errno(), $sql, '', ''));
    echo "<table border=1>";
    echo "<tr><td colspan=3 align=center><h1>".$row[0]."</h1></td>";
    echo "<td><a href='http://calendar.igc.gulbenkian.pt/monitor.php' style='text-decoration:none'><input type=button value='View' style='height:50px;width:50px'></a></td></tr>";
    echo "<tr><td><b>Reading</b></td><td><b>Datetime</b></td><td><b>Measure</b></td><td><b>State</b></td></tr>";
 
    while($arr = mysql_fetch_row($res2)){
	$value = $arr[0];
        $meas = $arr[2];
        eval ("\$var = ".str_replace(':','$',$meas).";");
        echo "<tr><td><strong>".$arr[3]."</strong></td><td>".$arr[1]."</td><td>".round($var)."</td>";
        if ($arr[0] < $arr[4] or $arr[0] > $arr[5]){
            echo "<td style='background-color:#FF0000'><b> ALARM </b></td>";
        } else {
            echo "<td><b> OK </b></td>";
        }
        echo "</tr>";
    }
    echo "</table>";
    echo "<br>";
    echo "</td>";
    if($i == 4 or $i == 8) echo "</tr>";
    $i++;
}
echo "</table>";			


?>