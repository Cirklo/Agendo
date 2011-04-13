<?php
//session_start();
// error_reporting(0);
// require_once(".htconnect.php");
// require_once("permClass.php");


// if (isset($_GET['resource'])){
    // $check = new permClass;
    // $user_id=$_POST['user_idm'];
    // $pwd=$_POST['user_passwd'];
    // $resource=$_GET['resource'];
    // if (!$check->setPermission($user_id,1,$pwd)){
        // echo "<h1>Wrong Login!</h1>";
        // exit;
    // }
    // $_SESSION['user_id'] = $user_id;
// }

// $user_id = $_SESSION['user_id'];

// require_once("notlogged.php");

	// This file was altered by Pedro Pires (The chosen two)
    // $user_id=$_POST['user_idm'];
    // $pwd=$_POST['user_passwd'];
    // $resource=$_GET['resource'];
    // $logOff=$_GET['logOff'];
    //session_start();
	require_once("commonCode.php");
	// logIn($resource, $user_id, $pwd, $logOff, true);
	initSession(true);	
	$user_id = $_SESSION['user_id'];
?>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/CalendarControl.css" rel="stylesheet" type="text/css">
<link href="css/admin.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="css/autosuggest_inquisitor.css" type="text/css" media="screen" charset="utf-8" />
<script type="text/javascript" src="js/bsn.AutoSuggest_2.1.3.js" charset="utf-8"></script>
<script type="text/javascript" src="js/cal.js"></script>
<script type="text/javascript" src="js/datefunc.js"></script>
<script type="text/javascript" src="js/autoFill.js"></script>
<script type="text/javascript" src="js/checkfields.js"></script>
<script type="text/javascript">

function postvars(type, table, i)
{
   if(type == 0){ //user submit
       objForm = eval("document." + table);
       var i, action;
       var nrows = 20;
       var order = 'ASC';
       action = 'manager.php?table='+ table + '&nrows=' + nrows + '&order=' + order + '&type=' + type;
   }else{ //administrator submit
       var i, action, nrows, order;
       objForm = eval("document." + table);
       nrows = eval("document.nrows" + table + ".nrows" + i + ".value");
       order = 'ASC';
       action = 'manager.php?table='+ table + '&nrows=' + nrows + '&order=' + order;
   }
   objForm.action=action;
   objForm.submit();
}

function calendar(week, year){
   var CurForm = eval("document.calform");
   var user = document.getElementById('usercalendar').value;
   CurForm.action = "calendar.php?user=" + user + "&week=" + week + "&year=" + year;
   CurForm.submit();
}

</script>

<?php

/**
   * @author João Lagarto
   * @copyright 2010 João Lagarto
   * @license Distributed under the European Public License (EUPL)
   * @version 1.0
   * @abstract: Script for administration process
*/
require_once("restrictions.php");
require_once("functions.php");
require_once("disptables.php");
require_once("errorHandler.php");

$error = new errorHandler;

$db = dbHelp::database2(1);

//initialize arrays
$arr_table = array();

//only occurs with basket (purchases database)
if($db == 'requisitions'){
   create_basket($user_id);
}

//Searches available tables for the specific user //Doesnt give problems in postgrsql
$sql = "SELECT admin_table FROM admin WHERE admin_user = '".$user_id."' GROUP BY admin_table ORDER BY admin_table ASC";
$result = dbHelp::mysql_query2($sql);
$num_rows = dbHelp::mysql_numrows2($result);
$i = 0;
while($line = dbHelp::mysql_fetch_array2($result)){
   $arr_table[$i] = $line[0];
   $i++;
}
//Header
echo "<h1 align=left>Admin Area</h1>";
$sql = "SELECT * from ".dbHelp::getSchemaName().".user WHERE user_id = ".$user_id;
$res = dbHelp::mysql_query2($sql);
$nfields = mysql_num_fields($res);
$row = dbHelp::mysql_fetch_array2($res);
echo "Welcome to your admininstration area, ".$row['user_firstname']." ".$row['user_lastname']."!";
echo "<br /><br />";

echo "<table border=0>";
// if($db == "labcal")    echo "<td></td><td></td><td><a href=main.php target='_blank' style='font-size:12px'>Monitor</a></td>";
if($db == "requisitions"){
   echo "<td></td><td></td><td><a href=list.php style='font-size:12px'>Basket</a></td>";
         echo "<td></td><td></td><td><a href=history.php style='font-size:12px'>Active Baskets</a></td>";
       echo "<td></td><td></td><td><a href='history.php?hist=1' style='font-size:12px'>History</a></td>";
       if($row['user_level'] == 1){
           echo "<td></td><td></td><td><a href=# onclick=\"javascript:window.open('projects.php','_blank','directories=yes,status=yes,menubar=yes,location=yes,resizable=yes,scrollbars=yes,width=825,height=500')\" style='font-size:12px'>Projects</a></td>";
       }
}
echo "<td></td><td></td><td><a href=agendo.php style='font-size:12px'>Help</a></td>";
echo "<td></td><td></td><td><a href='http://www.cirklo.org' style='font-size:12px'>About Cirklo</a></td>";
echo "<td></td><td></td><td><a href='mailto:info@cirklo.org' style='font-size:12px'>Contact us</a></td>";
echo "<td></td><td></td><td><a href='index.php' style='font-size:12px'>Reservations</a></td>";
echo "<td></td><td></td><td><a href=logout.php style='font-size:12px'>Logout</a></td>";
echo "<td width=100px></td><td></td><td width=250 align=left><a href=# onclick=\"javascript:showhide('announcements');\">Click here to view all announcements</a>";
echo "<div id=announcements name=announcements style='position:absolute;z-index:99;background-color:#FFFF99;border-style:solid;border-width:1px;padding:3px;display:none;'>";
echo "<table border=0>";
echo "<tr>";
$sql = "SELECT announcement_date, announcement_title, announcement_message, announcement_end_date, resource_name FROM announcement, resource WHERE announcement_object=resource_id AND announcement_end_date > now() ORDER BY announcement_end_date ASC";
$res = dbHelp::mysql_query2($sql) or die ($sql); //mysql_error().$sql);
if(dbHelp::mysql_numrows2($res) != 0){
   while ($row = dbHelp::mysql_fetch_array2($res)){
       echo "<b>".$row[0]." - ".$row[4]."</b>: ".$row[1]."<br>";
       echo $row[2]."<br>";
       echo "<b>Available until</b>: ".$row[3]."<br><br>";
       // setting variables for announcement display
       $title = $row[1];
       $date = $row[0];
       $vendor = $row[4];
       $msg = $row[2];
   }
} else {
   echo "No announcements available!";
}
echo "</tr>";
echo "</table>";
echo "</div>";
echo "</td>";
if($vendor){
   echo "<td style='background-color:#FFFF00'><b> $date</b> $vendor - $title: $msg</td>";
}
echo "</tr>";
echo "</table>";
echo "<hr>";

//specific code for animal house
if($db == 'animalhouse'){
   echo "<form name=calform method=post>";
   echo "Calendar access: ";
   echo "<select name=usercalendar id=usercalendar>";
   $sql = "SELECT user_id, user_login from ".dbHelp::getSchemaName().".user";
   $res = dbHelp::mysql_query2($sql) or die ($sql); //$error->sqlError(mysql_error(), mysql_errno(), $sql, '', $user_id));
   while($row = dbHelp::mysql_fetch_array2($res)){
   echo "<option value=".$row[0].">".$row[1]."</option>";
   }
   echo "</select>";
   echo "<input type=button value='View calendar' onclick=\"javascript:calendar('".date('W')."','".date('Y')."');\">";
   echo "</form>";
}

//code for displaying tables
echo "<table><td valign=top>";
echo "<table border=0 cellspacing='5' width=500px>";
echo "<tr><td align=center width=150px><h2>Base tables</h2></td><td></td></tr>";

//loop all base tables
for($i = 0; $i < $num_rows; $i++){
   $table = tables($arr_table[$i],'tables',$i);
}

echo "</table></td>";
echo "<td></td><td></td><td></td><td></td>";
echo "<td valign=top>";
echo "<table border=0 cellspacing='5' width=400px>";
echo "<tr><td align=center width=150px><h2>Views</h2></td><td></td></tr>";
//loop all views
for($i = 0; $i < $num_rows; $i++){
   $table = tables($arr_table[$i],'views', $i);
}
echo "</table></td>";
echo "<td></td><td></td><td></td><td></td>";
echo "<td valign=top>";
echo "<table border=0 cellspacing='5' width=400px>";
echo "<tr><td align=center width=150px><h2>Reports</h2></td><td></td></tr>";
//display tables associated with stored procedures
try {
   if (isset($_POST['show']))
       procedures($_POST['proc_name'], $_POST['nrows'], $_POST['order'], $user_id, 'show', $db); //Redirect page for manager.php after show button is clicked
   else
       procedures($_POST['proc_name'], $_POST['nrows'], $_POST['order'], $user_id, '', $db);
} catch (Exception $e){
   echo "No reports available";
}
echo "</td></tr>";
echo "</table></td>";
echo "</table>";



?>