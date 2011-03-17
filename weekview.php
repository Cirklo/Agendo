<?php
//session_start();
// This file was altered by Pedro Pires (The chosen two)
	require_once("commonCode.php");
	logIn($resource, $user_id, $pwd, $logOff);
?>

<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" /> 
<title>IGC Reservations</title> 
<META HTTP-EQUIV="REFRESH" CONTENT="180">
<meta name="keywords" content="" />
<meta name="description" content="" /> 
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/CalendarControl.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="js/cal.js"></script>
<script type="text/javascript" src="js/ajax.js"></script>
<script type="text/javascript" src="js/datefunc.js"></script>
<script type="text/javascript" src="js/overdiv.js"></script>
<script type="text/javascript" src="js/weekview.js"></script>
<script type="text/javascript" src="js/commonCode.js"></script>

<?php
error_reporting(1);
require_once("commonCode.php");
require_once("calClass.php");
// require_once(".htconnect.php");
require_once("functions.php");
require_once("genMsg.php");

$resource=clean_input($_GET['resource']);
// $resource=$_GET['resource'];

if (isset($_GET['update'])) {$update=clean_input($_GET['update']);$entry=clean_input($_GET['update']);} else {$update=0;} ;
//instatiation for calendar
$calendar=new cal($resource,$update);
$message=new genMsg;

//getting the variables 
if (isset($_GET['action'])) {$action =$_GET['action'];} else {$action =0;} ;
if (isset($_GET['msg'])) {$msg =$_GET['msg'];} else {$msg ='';} ;
 
//html body starts Here
//##############################################
echo "<body onload=init(" . $calendar->getStatus() . "," . $calendar->getMaxSlots() . ")>";
// for displaying user info
echo "<div id=DisplayUserInfo style='display:none;position:absolute;border-style:solid;border-width:1px;background-color: white;z-index:99;padding:3px;'></div>";
//for displaying user confirmation comments
echo "<div id=InputComments style='display:none;position:absolute;border-style:solid;border-width:1px;background-color: white;z-index:99;padding:3px;'>";
    echo "<form name=entrycomments id=entrycomments>";
    echo "<textarea name=txtcomments id=txtcomments rows=3 cols=25></textarea>";
    echo "</form>";
    echo "<center><a href=\"javascript:addcomments(0)\">add comment</a>&nbsp;&nbsp;&nbsp;";
    echo "<a href=\"javascript:addcomments()\">everything ok!</a>";
echo "</div>";
//for displaying help
echo "<div id=help style='display:none;position:absolute;border-style:solid;border-width:1px;background-color: white;z-index:99;padding:3px;'>";
echo "<p style='text-align:center'>Equipment status: " . $calendar->getStatusName();
echo "<p style='text-align:center'>Equipment Responsible: <a href=mailto:" . $calendar->getRespEmail() . ">". $calendar->getRespName() . "</a>";
echo "<p style='text-align:center'>Delete Tolerance: " . $calendar->getDelTolerance(). " hour(s)";
echo "<p style='text-align:center'>Daily Maximum Slot Number: " . $calendar->getMaxSlots();
echo "<p style='text-align:center'>External Price without support:"  . ($calendar->getPrice())*3 . " Euros/hour + VAT";
if ($calendar->getStatus()==3) echo "<p style='text-align:center'>Tolerance for confirmation " . $calendar->getConfTolerance()*$calendar->getResolution()/60 . " hours(s) before or after entry";
echo "<p style='text-align:center'>Further info: <a href="  . $calendar->getLink() . ">" .$calendar->getLink() . "</a>" ;
echo "<hr><table><tr>";
echo "<td bgcolor=". cal::RegCellColorOff . ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>Confirmed</td>";
echo "<td bgcolor=". cal::PreCellColorOff . ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>To be confirmed</td>";
echo "<td bgcolor=". cal::ErrCellColorOff . ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>Unconfirmed</td>";
echo "<td bgcolor=". cal::MonCellColorOff . ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>Monitored</td>";
echo "</tr></table>";
if ($calendar->getLink()!='') echo "<hr><p style='text-align:center'>More info <a href='" . $calendar->getLink() . "' target=_blank>here</a>";
echo "<p style='text-align:right'><a href=# onclick=\"javascript:d=document.getElementById('help');d.style.display ='none'\">close</a>";
echo "</div>";

//for displaying calendar
$sql = "SELECT mainconfig_institute, mainconfig_shortname, mainconfig_url FROM mainconfig WHERE mainconfig_id = 1";
$res = dbHelp::mysql_query2($sql);
$institute = dbHelp::mysql_fetch_row2($res);

echo "<div id=calendar class='calendar'> ";
	echo "<table border=0 class=logo id='logo' width=\"100%\">";
		echo "<tr>";
			echo "<td style='font-size:11px;text-align:left' >";
				echo "<h1><a href=index.php>".$institute[1]." Reservations</a></h1>";
				echo "<h3><a href='http://".$institute[2]."'>".$institute[0]."</a></h3>";
				echo "<h2>" . date ("D,d M Y"). "</h2>";
				
				// Links for help, videos, resources and user/management
				echoUserVideosResourceHelpLinks("weekview", $calendar->getResource());

			echo "</td>";
		echo "</tr>";
	echo "</table>";

	// Videos div
	echoVideosDiv();
	
	// Resources div
	echoResourcesDiv();
	
	// User/management div
	echoUserDiv("weekview", $calendar->getResource());
	
    //This is where msgs are displayed (changed)
    echo "<div id='msg' style=\"top:200;left:178px;width:574px;height:50;filter:alpha(opacity=0);line-height:50px;\" class=msg >";
		echo $msg;
	echo "</div>";

    if (isset($_GET['date'])){
        $calendar->setStartDate($_GET['date']);
    } else {        
        $calendar->setStartDate(date("Ymd",mktime(0,0,0, date("m"), date("d")-date("N"),date("Y"))));
    }
   if ($calendar->getStatus()==0 or $calendar->getStatus()==2) { //inactive or invisible
        echo "<h1 style='color:#cc8888'>".$calendar->getResourceName()." not available for reservations</h1>";
        $sql ="SELECT user_firstname,user_lastname,user_email from ".dbHelp::getSchemaName()."user,resource where user_id=resource_resp";
        $res = dbHelp::mysql_query2($sql);
        $arr = dbHelp::mysql_fetch_array2($res);
        echo "<h2>Please contact " . $arr['user_firstname'] . " ".$arr['user_lastname'] . "</h2>";
        echo "<a href=weekview.php?resource=" . ($calendar->getResource() -1) . "&date=" . $calendar->getStartDate() . "><img border=0 src=pics/resminus.png></a>";
        echo "<a href=weekview.php?resource=" . ($calendar->getResource() +1) . "&date=" . $calendar->getStartDate() . "><img border=0 src=pics/resplus.png></a>";
        exit;
    }
    if (isset($_POST['action'])) call_user_func($_POST['action']);
    if (isset($_GET['entry'])){
        $entry=clean_input($_GET['entry']);
        $calendar->setEntry($entry);
        $sql ="SELECT xfields_name,xfieldsval_value, xfields_label from xfields , resxfields,xfieldsval where xfieldsval_field= xfields_id and xfields_id=resxfields_field and resxfields_resource=" . $calendar->getResource(). " and xfieldsval_entry=".$calendar->getEntry();
		
		// $sqlWeekDay = "select ".dbHelp::getFromDate('entry_datetime','%w')." from entry where entry_id=".$calendar->getEntry();
		// $res = dbHelp::mysql_query2($sqlWeekDay);
		// $arr = dbHelp::mysql_fetch_row2($res);
        // $sqle="select entry_user, entry_repeat, ".dbHelp::getFromDate(dbHelp::date_sub('entry_datetime',$arr[0],'day'),'%Y%m%d')." as date, ".dbHelp::getFromDate('entry_datetime','%h')." as dateHour, ".dbHelp::getFromDate('entry_datetime','%i')." as dateMinutes, entry_slots from entry where entry_id=".$calendar->getEntry();
        // $sqle="select entry_user, entry_repeat, @d:= date_format(date_sub(entry_datetime,interval 1 day),'%Y%m%d'),  @wd:=date_format(@d,'%w'), date_format(date_sub(@d, interval @wd day),'%Y%m%d') as date, date_format(entry_datetime,'%h') + date_format(entry_datetime,'%i')/60 as starttime, entry_slots from entry where entry_id=".$calendar->getEntry();
		
		$sqlWeekDay = "select ".dbHelp::date_sub(dbHelp::getFromDate('entry_datetime','%Y%m%d'),'1','day')." from entry where entry_id=".$calendar->getEntry();
		$res = dbHelp::mysql_query2($sqlWeekDay);
		$arr1 = dbHelp::mysql_fetch_row2($res);
		$sqlWeekNumber = "select ".dbHelp::getFromDate("'".$arr1[0]."'",'%w');
		$res = dbHelp::mysql_query2($sqlWeekNumber);
		$arr2 = dbHelp::mysql_fetch_row2($res);
        $sqle="select entry_user, entry_repeat, ".dbHelp::getFromDate(dbHelp::date_sub("'".$arr1[0]."'",$arr2[0],'day'),'%Y%m%d')." as date, ".dbHelp::getFromDate('entry_datetime','%h')." as dateHour, ".dbHelp::getFromDate('entry_datetime','%i')." as dateMinutes, entry_slots from entry where entry_id=".$calendar->getEntry();
		
        // $sqle="select entry_user, entry_repeat, @d:= date_format(entry_datetime,'%Y%m%d') -1,  @d- date_format(@d,'%w')  as date, date_format(entry_datetime,'%h') + date_format(entry_datetime,'%i')/60 as starttime, entry_slots from entry where entry_id=".$calendar->getEntry();
        $rese=dbHelp::mysql_query2($sqle);
        $arre= dbHelp::mysql_fetch_array2($rese);
        $calendar->setStartDate($arre['date']);
        $calendar->setCalRepeat($arre['entry_repeat']);
        $user=$arre['entry_user'];
        $nslots=$arre['entry_slots'];
        // $entrystart=$arre['starttime'];
        $entrystart= $arre['dateHour'] + $arre['dateMinutes']/60;
        
        //
        // this is not working!!
        //I should not make this sql query for everything should be in the collection. This is a hack!
        //____________________________________
        //$entrystart=$calendar->item($calendar->getEntry()).getStartTime();
        //$nslots=$calendar->item($calendar->getEntry()).getNslots();
        //$user=$calendar->item($calendar->getEntry()).getUser();
        // I should try unset($node_obj) before new calCell;
        
    } elseif ($update!=0) {
        $calendar->setEntry($update);
        $sql ="SELECT xfields_name,xfieldsval_value, xfields_label from xfields , resxfields,xfieldsval where xfieldsval_field= xfields_id and xfields_id=resxfields_field and resxfields_resource=" . $calendar->getResource(). " and xfieldsval_entry=".$calendar->getEntry();
		
        // $sqle="select entry_user, entry_repeat, @d:= date_format(date_sub(entry_datetime,interval 1 day),'%Y%m%d'),  @wd:=date_format(@d,'%w'), date_format(date_sub(@d, interval @wd day),'%Y%m%d') as date, date_format(entry_datetime,'%h') + date_format(entry_datetime,'%i')/60 as starttime, entry_slots from entry where entry_id=".$calendar->getEntry();
		$sqlWeekDay = "select ".dbHelp::date_sub(dbHelp::getFromDate('entry_datetime','%Y%m%d'),'1','day')." from entry where entry_id=".$calendar->getEntry();
		$res = dbHelp::mysql_query2($sqlWeekDay);
		$arr1 = dbHelp::mysql_fetch_row2($res);
		$sqlWeekNumber = "select ".dbHelp::getFromDate("'".$arr1[0]."'",'%w');
		$res = dbHelp::mysql_query2($sqlWeekNumber);
		$arr2 = dbHelp::mysql_fetch_row2($res);
        $sqle="select entry_user, entry_repeat, ".dbHelp::getFromDate(dbHelp::date_sub("'".$arr1[0]."'",$arr2[0],'day'),'%Y%m%d')." as date, ".dbHelp::getFromDate('entry_datetime','%h')." as dateHour, ".dbHelp::getFromDate('entry_datetime','%i')." as dateMinutes, entry_slots from entry where entry_id=".$calendar->getEntry();
        // $sqle="select entry_user, entry_repeat, @d:= date_format(entry_datetime,'%Y%m%d') -1,  @d- date_format(@d,'%w')  as date, date_format(entry_datetime,'%h') + date_format(entry_datetime,'%i')/60 as starttime, entry_slots from entry where entry_id=".$calendar->getEntry();
        $rese=dbHelp::mysql_query2($sqle);
        $arre= dbHelp::mysql_fetch_array2($rese);
        $calendar->setStartDate($arre['date']);
        $calendar->setCalRepeat($arre['entry_repeat']);
        $user=$arre['entry_user'];
        $nslots=$arre['entry_slots'];
        // $entrystart=$arre['starttime'];
        $entrystart=$arre['starttime'];
		$entrystart= $arre['dateHour'] + $arre['dateMinutes']/60;
    } else {
            $calendar->setEntry(0);
            $entrystart=0;
            $nslots=1;
            $user='';
            $sql ="SELECT xfields_name,xfields_label from xfields, resxfields where  xfields_id=resxfields_field and resxfields_resource=". $calendar->getResource();
    }
    // calling method for design weekview
    $calendar->draw_week();
echo "</div>";

$table='entry';
$res=dbHelp::mysql_query2($sql);
$nxfields=dbHelp::mysql_numrows2($res);

//entries menu
//############
echo "<div id=entrydiv class=entrydiv>";
echo "<form name=entrymanage id=entrymanage >";

// Changed to have this the same way it is in the index screen
// echo "<table class=entry border=1><tr><td class=alink>Entries</td>";
// echo "<td class=mlink><a href=\"javascript:hide_divs('entrydiv','managementdiv','resourcediv')\">Resources</a></td>";
// echo "<td class=mlink><a href=\"javascript:hide_divs('entrydiv','resourcediv','managementdiv')\">Management</a></td></tr>";
// ******************

echo "<tr><td colspan=3>";
echo "<center><table id=entryinner class=entryinner>";
echo "<tr><td colspan=2>";
echo "<table style='width:160px;padding:0px;'><tr><td>";

$sql="select resource_status,resource_id from resource where resource_status not in (0,2) order by resource_name";
$resResources=dbHelp::mysql_query2($sql);
$nextDetected = false;
$currentDetected = false;
// Loop that finds the previous and next "line" composed of resourceStatus and resourceId of the $calendar->getResource() id
while($resArray = dbHelp::mysql_fetch_row2($resResources)){
	$currentId = $resArray[1];
	if($calendar->getResource()!=$currentId){
		if(!$currentDetected){
			$arrprev=$resArray;
		}
		else if(!$nextDetected){
			$arrnext = $resArray;
			$nextDetected = true;
		}
	}
	else
		$currentDetected = true;
}

//// checking next resource (old version ordered by id)
// $sql="select resource_status,resource_id from resource where resource_status not in (0,2) and resource_id<". ($calendar->getResource() ) . " order by resource_id desc";
// $resprev=dbHelp::mysql_query2($sql);

// $sql="select resource_status,resource_id from resource where resource_status not in (0,2) and resource_id>". ($calendar->getResource() ) . " order by resource_id";
// $resnext=dbHelp::mysql_query2($sql);


// $arrprev=dbHelp::mysql_fetch_row2($resprev);
// $arrnext=dbHelp::mysql_fetch_row2($resnext);

$n=0;

// Old version
// if (dbHelp::mysql_numrows2($resprev)>0) {
if (sizeof($arrprev)!=0) {
	echo "<a href=weekview.php?resource=" . $arrprev[1] . "&date=" . $calendar->getStartDate() . "><img border=0 src=pics/resminus.png></a>"; 
} else {
    echo "<img border=0 src=pics/resminus.png>"; 
}

echo "</td><td style='width:140px;vertical-align:middle;text-align:center'><a style='font-size:20px' href=\"javascript:d=document.getElementById('help');d.style.display ='block';AssignPosition(d)\">";
echo "<img height=64 src=pics/resource" . $calendar->getResource() .".gif border=0 size=64></a>";
echo "<td/><td>";
$n=0;

//Old version
// if (dbHelp::mysql_numrows2($resnext)>0) {
if (sizeof($arrnext)!=0) {
		// Part of the old version, didn't seem to be working
        //while  (($arrnext[0]=='0' or $arrnext[0]=='2') and dbHelp::mysql_fetch_row2($resprev)) { $n=$n+1;myqs_dataseek($resprev,$n);}
	echo "<a href=weekview.php?resource=" . $arrnext[1] . "&date=" . $calendar->getStartDate() . "><img border=0 src=pics/resplus.png></a>";
} else {
    echo "<img border=0 src=pics/resplus.png>"; 
}
echo "</td></tr></table>";

//echo "<img height=64 src=pics/resource" . $calendar->getResource() .".gif border=0 size=64>&nbsp;&nbsp;&nbsp;<a style='font-size:20px' href=\"javascript:d=document.getElementById('help');d.style.display ='block';AssignPosition(d)\">?</a>";
echo "<h2 align=center>". $calendar->getResourceName() ."</h2><hr></td></tr>";
echo "<tr>";
	echo "<td colspan=2>Repeat Week Pattern</td>";
	echo "<tr>";
		echo "<td><center><input lang=send type=checkbox onkeypress='return noenter()' onclick=\"activate_date(document.entrymanage.enddate);\" id=repeat name=repeat value=1></td><td><input style='width:70px' class=inpbox name='enddate' lang=send id='enddate' size=9 disabled=true type=textbox value=''></td>";
	echo "</tr>\n";
	echo "<tr>";
		echo "<td><center><input  lang=send type=checkbox onkeypress='return noenter()' name=assistance value=1></td><td>Assistance</td>";
	echo "</tr>\n";
	//echo "<tr><td>Start Time<br>";
	//echo "<script type='text/javascript'>filljscombo('starttime'," . $calendar->getStarttime() . ",". $calendar->getEndTime() . "," . $calendar->getResolution() . "," . $entrystart ."," . $calendar->getEntry() . ")</script></td>\n";
	//echo "<td>Duration<br>";
	//echo "<script type='text/javascript'>filljscombo('slots'," . $calendar->getResolution() . ",". ($calendar->getMaxSlots()+ $calendar->getResolution()) . "," . $calendar->getResolution() . "," . $nslots  ."," . $calendar->getEntry() . ")</script>\n";
	echo "<tr><td colspan=2><hr></td></tr>";
	echo "<script type='text/javascript'>Calendar.setup({inputField	 : 'enddate',baseField    : 'element_2',button: 'enddate',ifFormat: '%Y %e, %D',onSelect: selectDate});	</script></td>";
echo "</tr>\n";
for ($i=0;$i<$nxfields;$i++){
    // mysql_data_seek($res,$i);
    $arrxfields= dbHelp::mysql_fetch_array2($res);
    echo "<tr><td colspan=2>". $arrxfields['xfields_label']. "<br><input lang=send onkeypress='return noenter()' class=inpbox  id='". $arrxfields['xfields_name'].  "'  name='". $arrxfields['xfields_name'].  "' ";
		if ($calendar->getEntry()!=0) echo "value='" . $arrxfields['xfieldsval_value']. "'";
    echo "></td></tr>\n";
}

// Wont be dislayed if theres an active user session
$display = 'table-cell';
if(isset($_SESSION['user_name']) && $_SESSION['user_name']!='')
	$display = 'none';
echo "<tr><td style='display:".$display."' colspan=2>User Name<br>";
echo "<input name=user_id class=inpbox onkeypress='return noenter()' id=user_id lang=send title='' value=''  onblur=ajaxUser(this)>";
echo "</td></tr>\n";
echo "<tr><td style='display:".$display."' colspan=2>Password<br><input class=inpbox onkeypress='return noenter()' lang=send type=password name=user_passwd value=''></td></tr>\n";


echo "<tr><td colspan=3 class=di></td></tr>\n";
echo "<tr><td colspan=3 align=jusfify>\n";
echo "<input type=button style='width:40px' onkeypress='return noenter()' id=delButton class=bu  value='Del' onClick=\"ManageEntries('del');\">";
echo "<input type=button style='width:60px' onkeypress='return noenter()'  id=monitorButton class=bu value='WaitList' onClick=\"ManageEntries('monitor');\">";
echo "<input type=button style='width:40px' onkeypress='return noenter()' id=addButton class=bu value='Add' onClick=\"ManageEntries('add','" . $calendar->getStartTime(). "','" . cal::getResolution()/60 . "');\"><br>";
echo "<input type=button style='width:70px' onkeypress='return noenter()'  id=updateButton  class=bu value='Update' onClick=\"ManageEntries('update','" . $calendar->getStartTime(). "','" . cal::getResolution()/60 . "');\">";
echo "<input type=button style='width:70px' onkeypress='return noenter()' id=confirmButton class=bu value='Confirm' onClick=\"ManageEntries('confirm');\">";
echo "<tr><td colspan=2><hr></td></tr>";
echo "</table>";
echo "</td></tr></table>";
echo "<input name=action lang=send style='visibility:hidden;font-size:0px' value='' id=action>";
//echo "<input name=maxslots  style='visibility:hidden;font-size:0px' value='' id=maxslots>";
echo "<input name=code lang=send style='visibility:hidden;font-size:0px' value='' id=code>";
echo "<input name=resource lang=send style='visibility:hidden;font-size:0px' value=". $calendar->getResource() . " id=resource>";
echo "<input name=entry lang=send style='visibility:hidden;font-size:0px' value=". $calendar->getEntry(). " id=entry>";
echo "<input name=update lang=send style='visibility:hidden;font-size:0px' value=". $update. " id=update>";
echo "<input name=tdate style='visibility:hidden;font-size:0px' value=". $calendar->getStartDate() . " id=tdate>";
echo "</form>";
//GET announcements

echo "<table border=0 align=left>";
echo "<tr><td><b>Announcements</b></td></tr>";
echo "<tr><td>";
$message->announcement($resource);
echo "</td></tr>";
echo "</table>";
echo "</div>";

// Changed to have this the same way it is in the index screen
//resources menu
//############
// echo "<div id=resourcediv class=resourcediv>";
// echo "<table class=entry border=1><tr><td class=mlink><a href=\"javascript:hide_divs('resourcediv','managementdiv','entrydiv')\">Entries</a></td>";
// echo "<td class=alink>Resources</td>";
// echo "<td class=mlink><a href=\"javascript:hide_divs('entrydiv','resourcediv','managementdiv')\">Management</a></td></tr>";
// echo "<tr><td colspan=3>";
// echo "<center><table class=entryinner>";
// echo "<tr><td><center><br><h2>Resource Class</h2><br>";
// fillCombos("type","","resclass","onChange=\"ajaxEquiDD(this,'resourceDD')\"","<option></option>",'','');
////fillCombos("type","","resclass","onChange=\"alert('33')\"","<option></option>");
// echo "</td></tr>";
// echo "<tr><td><br><center><h2>Resource</h2><br>";
// echo "<select id=resourceDD name=resourceDD onChange=\"location.replace('weekview.php?resource=' + this.value)\"></select>";
// echo "</td></tr>";
// echo "<tr><td><br><br>";
// echo "</table>";
// echo "</td></tr></table>";
// echo "</div>";

// Changed to have this the same way it is in the index screen
//Management menu
//############
// echo "<div name=managementdiv id=managementdiv class=managediv>";
// echo "<table class=entry border=1><tr><td class=mlink><a href=\"javascript:hide_divs('resourcediv','managementdiv','entrydiv')\">Entries</a></td>";
// echo "<td class=mlink><a href=\"javascript:hide_divs('entrydiv','managementdiv','resourcediv')\">Resources</td>";
// echo "<td class=alink>Management</td></tr>";
// echo "<tr><td colspan=3>";
// echo "<center><table class=entryinner>";
// echo "<form name=edituser id=edituser method=post>";
// echo "<tr><td colspan=2><br>User Name<br>";
////fillCombos('user',$user,'user_id');
// echo "<input class=inpbox name=user_idm id=user_idm value='' size=15  onblur=ajaxUser(this)>";
// echo "</td></tr>";
// echo "<tr><td>Password<br><input type=password class=inpbox id=user_passwd name=user_passwd value=''></td></tr>";
// echo "<tr><td><br><input type=button onclick=submitUser(" . $calendar->getResource() . ") class=bu value='Edit Profile'></td></tr>";
// echo "<tr><td><hr><input type=button onclick=ajaxRecoverPWD() class=bu value='Recover Passwd'></td></tr>";

// echo "</table>";
// echo "</td></tr></table>";
// echo "</div>";

echo "</body></html>";

?>
