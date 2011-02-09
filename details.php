<?php

require_once(".htconnect.php");
require_once("errorHandler.php");
$db = database(1);
$error = new errorHandler;

$table = $_GET['table'];
$id = $_GET['id'];
$value = $_GET['value'];
// require_once('commonCode.php');
// wtf($table."-".$id."-".$value);

$sql = "SHOW FIELDS FROM $table";
$res = mysql_query($sql) or die ($error->sqlError(mysql_error(), mysql_errno(), $sql, '', ''));
$nfields = mysql_num_rows($res);
$arr = array();
while ($row = mysql_fetch_array($res)){
    $arr[] = $row[0];
}

mysql_select_db('information_schema');
$sql = "SELECT COLUMN_NAME,REFERENCED_TABLE_NAME,REFERENCED_COLUMN_NAME FROM KEY_COLUMN_USAGE where REFERENCED_TABLE_NAME <> 'null' AND CONSTRAINT_SCHEMA LIKE '".$db."'";
$resf = mysql_query($sql);

$Fkeys = array($nfields);
$FkeysTable = array($nfields);

while ($row = mysql_fetch_array($resf)){
    $Fkeys[$row[0]] = $row[2];
    $FkeysTable[$row[0]] = $row[1];
}

mysql_select_db($db);

$sql = "SELECT * FROM $table WHERE ".$arr[0]."=".$value;
$res = mysql_query($sql) or die($error->sqlError(mysql_error(), mysql_errno(), $sql, '', ''));
$row = mysql_fetch_row($res);
echo "<table border=0>";
for($i = 0; $i < $nfields; $i++){
    if($Fkeys[$arr[$i]] <> ''){
        $sql = "SHOW FIELDS FROM ".$FkeysTable[$arr[$i]];
        $res = mysql_query($sql) or die ($sql);
        $data1 = mysql_data_seek($res, 0);
        $field1 = mysql_fetch_array($res);
        $data2 = mysql_data_seek($res, 1);
        $field2 = mysql_fetch_array($res);

        $sql = "SELECT ".$field2[0]." FROM ".$FkeysTable[$arr[$i]]." WHERE ".$field1[0]."=".$row[$i];
        $res = mysql_query($sql) or die (mysql_error().$sql);
        $fkrow = mysql_fetch_row($res);
        $column = substr($arr[$i], strlen($table."_"), strlen($arr[$i])-strlen($table."_"));
        echo "<tr><td><strong>".$column."</strong></td><td>".$fkrow[0]."</td></tr>";
    } else {
        $column = substr($arr[$i], strlen($table."_"), strlen($arr[$i])-strlen($table."_"));
        echo "<tr><td><strong>".$column."</strong></td><td>".$row[$i]."</td></tr>";
    }
}
echo "<tr><td></td><td align=right><a href=# style='text-decoration:none;' onclick=\"javascript:showhide('".$id."');\">x</a></td></tr>";
echo "</table>";



?>