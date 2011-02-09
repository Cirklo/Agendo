<?php
//session_start();
// error_reporting(0);
	// This file was altered by Pedro Pires (The chosen two)
	require_once("commonCode.php");
	initSession(true);
?>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/CalendarControl.css" rel="stylesheet" type="text/css">
<link href="css/admin.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="css/autosuggest_inquisitor.css" type="text/css" media="screen" charset="utf-8" />
<script type="text/javascript" src="js/bsn.AutoSuggest_2.1.3.js" charset="utf-8"></script>
<script type="text/javascript" src="js/autoFill.js"></script>
<script type="text/javascript" src="js/checkfields.js"></script>
<script type="text/javascript" src="js/cal.js"></script>
<script type="text/javascript" src="js/datefunc.js"></script>
<script type="text/javascript" src="js/cloneFieldset.js"></script>
<script type="text/javascript" src="js/basket.js"></script>

<script type="text/javascript">

function getValues(table, order, col, page, limit, user_id){
    var i, action, nrows;
    objForm = eval("document." + table);
    nrows = eval("document.nrows" + table + ".nrows.value");
    var type = '';
    var xmlhttp,url;
    for (i = 0; i < objForm.length; i++){
        var size = objForm.elements[i].id.length;
            var elmts = objForm.elements[i].id.substr(size - 5, size);
            if((elmts == '_beg_' || elmts == '_end_' || elmts == '_add_' || elmts == '_sel_') && objForm.elements[i].value != '')
            {
                type = 'date';
            }
            else
            {
                type = '';
            }
        var str = objForm.elements[i].lang;
        if (objForm.elements[i].value != '' && str.indexOf("__extkey") != -1)
        {
            if (objForm.elements[i].value == '') return;
            if (window.XMLHttpRequest)
            {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp=new XMLHttpRequest();
            }
            else
            {// code for IE6, IE5
                xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
            }
            url="response.php?val=" + objForm.elements[i].value + "&id=" + objForm.elements[i].id;
            xmlhttp.open("GET", url, false);
            xmlhttp.send(null);
            
            var str = xmlhttp.responseText;
            objForm.elements[i].value = str;
        }
    }
        if(page == '' && limit == '')
            action = 'manager.php?table='+ table + '&nrows=' + nrows + '&order=' + order + '&col=' + col + '&userid=' + user_id;
        else
            action = 'manager.php?table='+ table + '&nrows=' + nrows + '&order=' + order + '&col=' + col + '&page=' + page + '&limit=' + limit + '&userid=' + user_id;

        objForm.action=action;
    objForm.submit();    
}

function copy(id){
    var CurForm=eval("document.tableman"+id);
    var targerForm=eval("document.tableman");
    for (var i = 2; i < CurForm.length; i++){
        targerForm.elements[i].value = CurForm.elements[i].value;
    }
}

function selectRow(id){
    var CurForm = eval("document." + id);
    CurForm.elements[0].checked = true;
}

function clean(form){
    var filterForm = eval("document." + form);
    for (var i = 0; i < filterForm.length-1; i++){
        filterForm[i].value = '';
    }
}

function changecheck(id){
    var box = document.getElementById(id);
    var changedRows = new Array();
    for(var i = 0; i < document.forms.length; i++){
        var CurForm = document.forms[i];
        var FormName = CurForm.name;
        if(FormName.substring(0,8) == 'tableman' && FormName.length > 8){
            if(box.checked == true){
                CurForm.elements[0].checked = true;
            }
            else{
                CurForm.elements[0].checked = false;
            }
        }
    }
}

function checknew(type, id){
    if(type == 'sum'){
        var val = document.getElementById('multiple').value++;
        cloneMe(id, val);
    } else {
        //var val = document.getElementById('multiple').value--;
        deleteMe(id);
    }
    
}

function check(table, nrows, userid, order, page, limit, nfields){
    var val = document.getElementById('multiple').value;
    if (val == 1){
        clickit('','add',table, nrows, userid, order, page, limit, '');
    } else {
        clickit('','multiple',table, nrows, userid, order, page, limit, val);
    }
}

function getdetails(table, val, id){
	showhide(id);
	if (window.XMLHttpRequest)
	{// code for IE7+, Firefox, Chrome, Opera, Safari
	    xmlhttp=new XMLHttpRequest();
	}
	else
	{// code for IE6, IE5
	    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	url="details.php?table=" + table + "&value=" + val + "&id=" + id;
	xmlhttp.open("GET", url, false);
	xmlhttp.send(null);
		    
	var str = xmlhttp.responseText;
	document.getElementById(id).innerHTML = str;
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

require_once(".htconnect.php");
require_once("genObjClass.php");
require_once("functions.php");
require_once("restrictions.php");
require_once("filter.php");
// require_once("notlogged.php");
require_once("errorHandler.php");
require_once("classSearch.php");

// print_r($_POST);
//database configuration
$db = database(1);

//call classes
$search = new quickSearch;
$error = new errorHandler();

//Query for setting the user as an administrator or not
$user_id = $_SESSION['user_id'];
$sql = "SELECT admin_table FROM admin WHERE admin_user = '".$user_id."' GROUP BY admin_table ORDER BY admin_table ASC";
$result = mysql_query($sql) or die ($error->sqlError(mysql_error(), mysql_errno(), $sql, '', $user_id));
$num_rows = mysql_num_rows($result);

//Paths and filenames
$picsPath = 'pics/';
$tip = 'interrogation.png';

//getting variables
if(isset($_GET['table'])){
    $table = $_GET['table'];
}

$having = restrict_access($table, $user_id);

if(isset($_GET['order'])){    
    if(isset($_GET['col'])){
        $col = $_GET['col'];
    }else{
        $col = $table."_id";
    }
    $order = "ORDER BY ".$col." ".$_GET['order'];
} else
    $order = '';

if(isset($_GET['limit'])){
    $limit = $_GET['limit'];
    if($limit == '')
    $limit = 20;    
} else {
    $limit = $_GET['nrows'];
}

if(isset($_GET['page'])){
    $page = $_GET['page'];
} else {
    $page = 0;
}

if(isset($_GET['n'])){
    $n = $_GET['n'];
}

if(isset($_GET['id'])){
    $id = $_GET['id'];
}

if(isset($_GET['userid'])){
    $userid = $_GET['userid'];
} else {
    $userid = "";
}

if (isset($_GET['action'])){
    $Fields= new genObj;

    foreach ($_POST as $key=>$value) {
        if (substr($key,0,2) != '__') $Fields->__set($key,$value);
    }
    switch ($_GET['action']) {
    case 'add':
        $Fields->add($table, $user_id);
        break;
    case 'delete':
        $Fields->delete($table, $user_id);
        break;
    case 'update':
        $Fields->update($table, $user_id, $id);  
        break;
    case 'multiple':
        $Fields->multiple($table, $n, $user_id);  
        break;
    }
}

//Header
echo "<table border=0 align=center>";
echo "<tr><td><h1>".strtoupper($table)." Management </h1></td></tr>";
echo "</table>";
echo "<table border=0>";
echo "<tr valign=bottom><td><a href=admin.php style='font-size:12px'>Admin area</a></td>";
// if($db == "labcal")    echo "<td></td><td></td><td><a href=main.php target='_blank' style='font-size:12px'>Monitor</a></td>";
if($db == "requisitions"){
    echo "<td></td><td></td><td><a href=list.php style='font-size:12px'>Basket</a></td>";
          echo "<td></td><td></td><td><a href=history.php style='font-size:12px'>Active Baskets</a></td>";
        echo "<td></td><td></td><td><a href='history.php?hist=1' style='font-size:12px'>History</a></td>";
}
echo "<td></td><td></td><td><a href=excel.php?table=".$table."&userid=$userid style='font-size:12px'>Export to excel</a></td>";
echo "<td></td><td></td><td><a href=agendo.php style='font-size:12px'>Help</a></td>";
echo "<td></td><td></td><td><a href='http://www.cirklo.org' style='font-size:12px'>About Cirklo</a></td>";
echo "<td></td><td></td><td><a href='mailto:info@cirklo.org' style='font-size:12px'>Contact us</a></td>";
echo "<td></td><td></td><td><a href='index.php' style='font-size:12px'>Reservations</a></td>";
echo "<td></td><td></td><td><a href=logout.php style='font-size:12px'>Logout</a></td>";
echo "<td width=100px align=center><input type=submit onclick=\"javascript:showhide('filter')\" value=Filter></td>";
/*
echo "<td width=50px></td>";
echo "<td><img src=".$picsPath."add.png border=0></td><td>Insert new row</td>";
echo "<td><img src=".$picsPath."delete.png border=0></td><td>Delete selected rows</td>";
echo "<td><img src=".$picsPath."update.png border=0></td><td>Save changes</td>";
echo "<td><img src=".$picsPath."copy.png border=0></td><td>Copy data</td>";
echo "<td><img src=".$picsPath."multiple.png border=0></td><td>Clone row (multiple insert)</td>";*/
$sql = "SELECT user_login FROM user WHERE user_id=$user_id";
$res = mysql_query($sql) or die ($error->sqlError(mysql_error(), mysql_errno(), $sql, '', $user_id));
$row = mysql_fetch_row($res);
echo "<td align=right>You are logged in as ".$row[0]."! <a href=logout.php>Sign out</a></td>";
echo "</tr>";
echo "</table>";
echo "<hr>";
echo "<table align=center><tr><td>";
echo "<table border=0 align=center>";
echo "<tr valign=bottom><td></td><td></td>";

mysql_select_db('information_schema');
$sql = "SELECT COLUMN_NAME,REFERENCED_TABLE_NAME,REFERENCED_COLUMN_NAME FROM KEY_COLUMN_USAGE where REFERENCED_TABLE_NAME <> 'null' AND CONSTRAINT_SCHEMA LIKE '".$db."'";
$resf = mysql_query($sql) or die ($error->sqlError(mysql_error(), mysql_errno(), $sql, $table, $user_id));


echo "<form id=dummy method=post>";
//building WHERE clause
$where = '';
$preValue = 0;
$flag = 0;
//datetime variables
$keydate = array();
$date1 = array();
$date2 = array();
//where clause from filter
foreach($_POST as $key=>$value){
    $str = (substr($key, strlen($key)-5, strlen($key)));
    if(substr($key,0,2) != '__'){ //don't fill filter fields if there is action
        if(isset($_GET['action'])) break;
    } //do nothing
    if($value != ''){
        if($str != '_beg_' and $str != '_end_'){
            if(substr($key,0,2) == '__'){//Where clause for Foreign Keys
        $key = substr($key, 2, strlen($key)-2);
        $where .= $key."='".$value."' AND ";
        } else {// Where clause for other fields
        $where .= "LOWER($key) REGEXP LOWER('".$value."') AND ";
        }
        } else { //queries with datetime inputs - ERROR WHEN THERE ARE 2 DATETIME INPUTS IN ONE TABLE
        if ($preValue != 0) //when the 2 fields are filled (for a time interval)
            $where = $where . substr($key, 0, strlen($key)-5) ." BETWEEN '".$preValue." 00:00:00' AND '".$value." 00:00:00' AND ";
        else //When only one field is filled (for a time range since the chosen date)
            $where = $where . substr($key, 0, strlen($key)-5) ." BETWEEN '".$value." 00:00:00' AND NOW() AND ";
        $date1[substr($key, 0, strlen($key)-5)] = $preValue;
        $date2[substr($key, 0, strlen($key)-5)] = $value;
        $preValue = $value;
        $keydate[substr($key, 0, strlen($key)-5)] = $key;
        $flag++;
        if($flag == 2){
            $preValue = 0;
            $flag = 0;
        }
        
        }
    echo "<input type=text style='visibility:hidden' name=$key value='$value'>";
    }
}
echo "</form>";

//WHERE Clause
if($where != '') $where = " WHERE ".substr($where, 0, strlen($where)-4);
else $where = '';

//WHERE clause if its a regular user (EMPTY WHERE CLAUSE AS REGULAR USERS CANNOT USE FILTERS)
if(isset($_GET['action'])){
    if($num_rows == 0 && $table == 'user'){
        $where = " WHERE user_id=$user_id";
    }
}
//Check for foreign keys
$comment = new genObj;
$FKtable = $comment->check_foreign_key($col);
if($FKtable != ''){
    $fields = $comment->table_fields($table);
    $FKorder = $comment->order_by_FK($FKtable);
}

mysql_select_db($db);
//query for displaying the number of pages available
if($_GET['userid'] == ''){
    if($FKtable == '')
    $sql = "SELECT * FROM ".$table.$where.$having." ".$order;
    else
    if($where == '')
        $sql = "SELECT ".$fields." FROM ".$table.",".$FKtable." WHERE ".$FKtable."_id = ".$col.$having." ORDER BY ".$FKorder." ".$_GET['order'];
    else
        $sql = "SELECT ".$fields." FROM ".$table.",".$FKtable.$where." AND ".$FKtable."_id = ".$col." ORDER BY ".$FKorder." ".$_GET['order'];
} else {
    if($where == ''){
    if($FKtable == '')
        $sql = "SELECT * FROM ".$table." WHERE ".$table."_userid = ".$_GET['userid'].$having." ".$order;
    else
        $sql = "SELECT ".$fields." FROM ".$table.",".$FKtable." WHERE ".$FKtable."_id = ".$col." AND ".$table."_userid = ".$_GET['userid'].$having." ORDER BY ".$FKorder." ".$_GET['order'];
    }else{
    if($FKtable == '')
        $sql = "SELECT * FROM ".$table.$where." AND ".$table."_userid = ".$_GET['userid'].$having." ".$order;
    else
        $sql = "SELECT ".$fields." FROM ".$table.",".$FKtable.$where." AND ".$FKtable."_id = ".$col." AND ".$table."_userid = ".$_GET['userid'].$having." ORDER BY ".$FKorder." ".$_GET['order'];

    }
}
if(!isset($_GET['search'])){
    $ros = mysql_query($sql) or die ($error->sqlError(mysql_error(), mysql_errno(), $sql, '', $user_id));
    $numrows = mysql_num_rows($ros);
}

//display query
if($_GET['userid'] == ''){
    if($FKtable == '')
        $sql = "SELECT * FROM ".$table.$where.$having." ".$order." LIMIT ".$page.",".$limit;
    else
        if($where == '')
            $sql = "SELECT ".$fields." FROM ".$table.",".$FKtable." WHERE ".$FKtable."_id = ".$col.$having." ORDER BY ".$FKorder." ".$_GET['order']." LIMIT ".$page.",".$limit;
        else
            $sql = "SELECT ".$fields." FROM ".$table.",".$FKtable.$where." AND ".$FKtable."_id = ".$col.$having." ORDER BY ".$FKorder." ".$_GET['order']." LIMIT ".$page.",".$limit;

} else {
    if($where == ''){
    if($FKtable == '')
        $sql = "SELECT * FROM ".$table." WHERE ".$table."_userid = ".$_GET['userid'].$having." ".$order." LIMIT ".$page.",".$limit;
    else
        $sql = "SELECT ".$fields." FROM ".$table.",".$FKtable." WHERE ".$FKtable."_id = ".$col." AND ".$table."_userid = ".$_GET['userid'].$having." ORDER BY ".$FKorder." ".$_GET['order']." LIMIT ".$page.",".$limit;
    }else{
    if($FKtable == '')
        $sql = "SELECT * FROM ".$table.$where." AND ".$table."_userid = ".$_GET['userid'].$having." ".$order." LIMIT ".$page.",".$limit;
    else
        $sql = "SELECT ".$fields." FROM ".$table.",".$FKtable.$where." AND ".$FKtable."_id = ".$col." AND ".$table."_userid = ".$_GET['userid'].$having." ORDER BY ".$FKorder." ".$_GET['order']." LIMIT ".$page.",".$limit;
    }
}

//check for quick search
if(isset($_GET['search'])){
    $sql = "SELECT search_query FROM search WHERE search_table='$table'";
    $res = mysql_query($sql) or die ($error->sqlError(mysql_error(), mysql_errno(), $sql, $table, $user_id));
    $row = mysql_fetch_row($res);
    $sql = $row[0];
    $keyword = $_POST['qsearch'];
    $sql .= " lower('".$keyword."') $having ORDER BY 1";
    $res = mysql_query($sql) or die ($error->sqlError(mysql_error(), mysql_errno(), $sql, $table, $user_id));
    $numrows = mysql_num_rows($res);
    if($numrows > $limit){
        echo "<script type='text/javascript'>alert('Too many results to be displayed! Please refine your search or use the filter.');";
        echo "window.location='admin.php';";
        echo "</script>";
    }
    if($numrows == 0){
        echo "<script type='text/javascript'>alert('No results to be displayed!');";
        echo "window.location='admin.php';";
        echo "</script>";
    }
}
// echo $sql;
$res = mysql_query($sql) or die ($error->sqlError(mysql_error(), mysql_errno(), $sql, $table, $user_id));
$nfields = mysql_num_fields($res);
$nrows = mysql_num_rows($res);
$Fkeys = array($nfields);
$FkeysTable = array($nfields);
$len = array();
$name = array();
$flags = array();
echo "<td></td><td></td>";
echo "<td><input type=checkbox name=checkall id=checkall onchange=\"javascript:changecheck(this.id);\" title='Select/unselect all'></td>";
for($k = 0; $k < $nfields; $k++){
    $len[$k] = mysql_field_len($res,$k);
    $name[$k] = mysql_field_name($res,$k);
    $flags[$k] = mysql_field_flags($res,$k);
    $type[$k] = mysql_field_type($res,$k);
    $Fkeys[$name[$k]] = '';

        $c = $comment->check_field_comment($name[$k], $table, $user_id);

    //write column headers ---> Link to ascending or descending order
        $column = substr($name[$k], strlen($table."_"), strlen($name[$k])-strlen($table."_"));
        echo "<td align=center>";
    echo strtoupper($column);
    if($c != ''){
        echo "<a href=\"javascript:showhide('".$name[$k]."div')\"><img src='".$picsPath.$tip."' border=0></a>";
        //Comment div for displaying information
        echo "<div id=".$name[$k]."div style='text-align:left;width:150px;display:none;position:absolute;z-index:80;border-style:solid;border-width:1px;padding: 3px;background-color:#FFFF99; opacity:0.9;'>";
        echo $c;
        echo "<table width=100%><tr><td style='text-align:right;padding:0px'><a href=# style='text-decoration:none;' onclick=\"document.getElementById('".$name[$k]."div').style.display='none'\" >x</a></td></tr></table>";
        echo "</div>";
    }
    echo "<br><a href=# onclick=\"javascript:getValues('".$table."', 'ASC','".$name[$k]."','','', '".$_GET['userid']."')\"><img src='".$picsPath."asc.gif' border=0 title='Ascending order'></a>    <a href=# onclick=\"javascript:getValues('".$table."', 'DESC','".$name[$k]."','','','".$_GET['userid']."')\"><img src='".$picsPath."desc.gif' border=0 title='Descending order'></a></td>";
}


while ($row = mysql_fetch_array($resf)){
    $Fkeys[$row[0]] = $row[2];
    $FkeysTable[$row[0]] = $row[1];
}
echo "</tr>";

//display results of the query
for($j = 0; $j < $nrows; $j++){
    echo "<tr style='white-space:nowrap'>";
    echo "<form method=post name=tableman$j>";
    mysql_data_seek($res,$j);
    $arr = mysql_fetch_row($res);
    $var = showRestrictions($user_id, $table, $j, $_GET['nrows'], $_GET['userid'], $_GET['order'], $page, $limit, $arr[0]);
    for ($i = 0; $i < $nfields; $i++) {
    echo "<td valign=top align=center>";
    if ($Fkeys[$name[$i]] <> '') { //Is it foreign key?
        autoComplete($FkeysTable[$name[$i]],$arr[$i],$name[$i], $flags[$i], $user_id, $j);
        //div for displaying the total list of FK values
        echo "<div id='list_".$name[$i].$j."' style='overflow:auto;max-height:160px;min-width:90px;text-align:justify;margin-left:121px;margin-top:-19px;display:none;position:absolute;border-style:solid;border-width:1px;background-color:#FFFF99;z-index:99;padding:3px;'>";
        echo "</div>";
        //div for displaying FK value details
        echo "<a href=# onclick=\"javascript:getdetails('".$FkeysTable[$name[$i]]."','".$arr[$i]."', '".$name[$i].$j."');\"><img src='".$picsPath."details.png' border=0 width=8px height=8px></a>";
        echo "<div id='".$name[$i].$j."' style='display:none;position:absolute;border-style:solid;border-width:1px;background-color:#FFFF99;z-index:99;padding:3px;'>";
        echo "</div>";
    } else     {
        if(datetime($name[$i]) == 'datetime'){ // I don't know why this doesn't work!!! JAVASCRIPT???
            echo "<input type=text style='width:70px' class=reg name=".$name[$i].$j."_sel_ id=".$name[$i].$j."_sel_ lang='".$flags[$i]."' value='".$arr[$i]."' onchange=\"javascript:selectRow('tableman$j');\">";
            echo "<script type='text/javascript'>Calendar.setup({inputField     : '".$name[$i].$j."_sel_',baseField    : 'element_2',button: '".$name[$i].$j."_sel_',ifFormat: '%Y %e, %D',onSelect: selectDate});    </script>";
        }
        else
            dispInput($arr[$i],$name[$i],$len[$i],$flags[$i],$type[$i],$j);
        }
        echo "</td>";
    }
    echo "</tr></form>";
}
if($nrows == 0){
    echo "</tr><tr>";
    $var = showRestrictions($user_id, $table, $j, $_GET['nrows'], $_GET['userid'], $_GET['order'], $page, $limit);
}
echo "<tr><td colspan=".($nfields+5)." align=center><hr></td></tr>";
echo "</table>";
echo "</td></tr>";
echo "<tr><td>";

//fields for insert queries
if($var == 'add'){
    echo "<form method=post name=tableman id=tableman>";
    echo "<table border=0 align=center id='main'>";
    echo "<tr>";
    echo "<td colspan=4></td>";
    for($k = 0; $k < $nfields; $k++){
        $c = $comment->check_field_comment($name[$k], $table, $user_id);
        $column = substr($name[$k], strlen($table."_"), strlen($name[$k])-strlen($table."_"));
        echo "<td align=center>".strtoupper($column);
        if($c != ''){
            echo "<a href=\"javascript:showhide('".$name[$k]."div_insert')\"><img src='".$picsPath."interrogation.png' border=0></a>";
            //Comment div for displaying information
            echo "<div id=".$name[$k]."div_insert style='text-align:left;width:150px;display:none;position:absolute;z-index:80;border-style:solid;border-width:1px;padding: 3px;background-color:#FFFF99; opacity:0.9;'>";
            echo $c;
            echo "<table width=100%><tr><td style='text-align:right;padding:0px'><a href=# style='text-decoration:none;' onclick=\"document.getElementById('".$name[$k]."div').style.display='none'\" >x</a></td></tr></table>";
            echo "</div>";
        }
        echo "</td>";
    }
    echo "</tr>";
    echo "<tr>";
    echo "<td colspan=1 width=25px align=center><a href=# style='text-decoration:none' class=cloneMe onclick=\"javascript:checknew('sum', this);\" title='clone row'><img src='".$picsPath."multiple.png' border=0></a></td>";
    echo "<td colspan=1 width=25px align=center><a href=# style='text-decoration:none' class=deleteMe onclick=\"javascript:checknew('subtract', this);\" title='cancel row'><img src='".$picsPath."delete.png' border=0></a></td>";
    echo "<td colspan=1 width=25px align=center><a href=# class=cloneMe onclick=\"javascript:check('".$table."',".$_GET['nrows'].", '".$_GET['userid']."','".$_GET['order']."', $page, $limit, $nfields);\"><img src='".$picsPath."add.png' title='add new row' border=0></a></td>";
    echo "<td><input type=checkbox style='visibility:hidden;'></td>";
    for($i = 0; $i < $nfields; $i++){
        echo "<td align=center>";
        if ($Fkeys[$name[$i]]<>''){
            autoComplete($FkeysTable[$name[$i]],"",$name[$i], $flags[$i], $user_id, '');
            echo "<div id='list_".$name[$i]."' style='overflow:auto;max-height:160px;min-width:90px;text-align:justify;margin-left:121px;margin-top:-20px;display:none;position:absolute;border-style:solid;border-width:1px;background-color:#FFFF99;z-index:99;padding:3px;'>";
            echo "</div>";
        } else {
            if(datetime($name[$i]) == 'date' or datetime($name[$i]) == 'datetime'){
                echo "<input type=text style='width:70px' class=reg name=".$name[$i]."_add_ id=".$name[$i]."_add_ lang='".$flags[$i]."'>";
                echo "<script type='text/javascript'>Calendar.setup({inputField     : '".$name[$i]."_add_',baseField    : 'element_2',button: '".$name[$i]."_add_',ifFormat: '%Y %e, %D',onSelect: selectDate});    </script>";
            }
            else
                dispInput("",$name[$i],$len[$i],$flags[$i],$type[$i]);
        }
        echo "</td>";
    }
    echo "</tr>";
    echo "</table>";
    echo "</form>";
}
echo "</td></tr></table>";
//Call function for displaying page selector
pages($numrows, $_GET['nrows'], $limit, $_GET['order'], $table, $page, $col, $_GET['userid']);

//filter routine ---> POST values ----> GET values to build query
echo "<div id=filter name=filter style='position:absolute;left:450px;top:75;background-color:#FFFF99;border-style:solid;border-width:1px;padding:3px;display:none;opacity:0.92;'>";
echo "<table border=0>";
echo "<tr><td colspan=2 align=right><a href='http://www.regular-expressions.info/reference.html' target='_blank'><img src='".$picsPath."interrogation.png' border=0 title='How to use regular expressions?'></a></td></tr>";
if($num_rows!=0){
    echo "<form method=post id=".$table." name=".$table.">";
    for ($i = 0; $i < $nfields; $i++){
        $z = substr($keydate[$name[$i]],0 ,strlen($keydate[$name[$i]])-5);
        if(isset($_GET['action'])){
        if($FkeysTable[$name[$i]] == ''){ //NOT FOREIGN KEYS
            if(datetime($name[$i]) == 'date' or datetime($name[$i]) == 'datetime'){
                if($name[$i] == substr($keydate[$name[$i]],0 ,strlen($keydate[$name[$i]])-5)){
                    filter($table, $name[$i],'', '',$date1[$z],$date2[$z],$user_id);
                } else {
                    filter($table, $name[$i],'', '','','',$user_id);
                }
            }else{
                filter($table, $name[$i],'', '','','',$user_id);
            }
        }
        else{ //FOREIGN KEY
            filter($table, $name[$i], '', $FkeysTable[$name[$i]],'','',$user_id);
        }
        } else {
         if($FkeysTable[$name[$i]] == ''){ //NOT FOREIGN KEYS
            if(datetime($name[$i]) == 'date' or datetime($name[$i]) == 'datetime'){
                if($name[$i] == substr($keydate[$name[$i]],0 ,strlen($keydate[$name[$i]])-5)){
                    filter($table, $name[$i], $_POST[$name[$i]], '',$date1[$z],$date2[$z],$user_id);
                } else {
                    filter($table, $name[$i], $_POST[$name[$i]], '','','',$user_id);
                }
            } else {
                filter($table, $name[$i], $_POST[$name[$i]], '','','',$user_id);
            }
        }
        else{ //FOREIGN KEY
            filter($table, $name[$i], $_POST["__".$name[$i]], $FkeysTable[$name[$i]],'','',$user_id);
        }        
        }
    }
    echo "<tr><td></td><td align=left><input type=submit value='Apply filter' onclick=\"javascript:getValues('".$table."','ASC','".$table."_id','','','".$_GET['userid']."')\"></td></tr>";
    echo "</form>";
    echo "<tr><td></td><td align left><input type='button' value='Clean all fields' onclick=\"javascript:clean('".$table."');\"></td></tr>";
    echo "<form name=nrows".$table. " id=nrows".$table. ">";
    echo "<tr><td><a href=# onclick=\"javascript:showhide('filter')\">Hide</a></td><td align=left>Results per page <input type=text value=".$_GET['nrows']." id=nrows name=nrows size=1></td></tr>"; //Display the number of rows the user sees
    echo "</form>";
}else{
    echo "You don't have permissions to this feature!";
}
echo "</table>";
echo "</div>";

//multiple rows conter
echo "<input type='hidden' name='multiple' id='multiple' value=1>";

//specific code for requisitions database
echo "<div id=qtt name=qtt style='position:absolute;left:100px;top:75;background-color:#FFFF99;border-style:solid;border-width:1px;padding:3px;display:none;'>";
echo "</div>";

//hidden content
echo "<div id=legend name=legend style='position:absolute;left:-8px;top:100px;width:1px;height:120px;overflow:auto;background-color:#FFFF99;border-style:solid;border-width:1px;padding:1px;display:block;' onmouseover=\"javacript:document.getElementById('legend').style.width='180px';\" onmouseout=\"javacript:document.getElementById('legend').style.width='1px';\">";
echo "<table border=0>";
echo "<tr><td><img src='".$picsPath."add.png' border=0></td><td>Insert new row</td></tr>";
echo "<tr><td><img src='".$picsPath."delete.png' border=0></td><td>Delete selected rows</td></tr>";
echo "<tr><td><img src='".$picsPath."update.png' border=0></td><td>Save changes</td></tr>";
echo "<tr><td><img src='".$picsPath."copy.png' border=0></td><td>Copy data</td></tr>";
echo "<tr><td><img src='".$picsPath."multiple.png' border=0></td><td>Clone row (multiple insert)</td></tr>";
if($db == "purchases") echo "<tr><td><img src='".$picsPath."duplicate.png' border=0></td><td>Duplicate basket</td></tr>";
echo "</table>";
echo "</div>";


?> 