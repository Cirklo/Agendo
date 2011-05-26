<?php

// require_once(".htconnect.php");
// require_once("__dbHelp.php");
require_once("commonCode.php");
require_once("errorHandler.php");
$db = dbHelp::getDatabase();
$error = new errorHandler;

$table = $_GET['table'];
$id = $_GET['id'];
$value = $_GET['value'];
// require_once('commonCode.php');
// wtf($table."-".$id."-".$value);

$sql = "SHOW FIELDS FROM $table";
$res = dbHelp::mysql_query2($sql) or die ($sql); //$error->sqlError(mysql_error(), mysql_errno(), $sql, '', ''));
$nfields = dbHelp::mysql_numrows2($res);
$arr = array();
while ($row = dbHelp::mysql_fetch_row2($res)){
    $arr[] = $row[0];
}

dbHelp::mysql_select_db2('information_schema');
$sql = "SELECT COLUMN_NAME,REFERENCED_TABLE_NAME,REFERENCED_COLUMN_NAME FROM KEY_COLUMN_USAGE where REFERENCED_TABLE_NAME <> 'null' AND TABLE_SCHEMA LIKE '".$db."'";
$resf = dbHelp::mysql_query2($sql);

$Fkeys = array($nfields);
$FkeysTable = array($nfields);

while ($row = dbHelp::mysql_fetch_row2($resf)){
    $Fkeys[$row[0]] = $row[2];
    $FkeysTable[$row[0]] = $row[1];
}

dbHelp::mysql_select_db2($db);

$sql = "SELECT * FROM $table WHERE ".$arr[0]."=".$value;
$res = dbHelp::mysql_query2($sql) or die($sql); //$error->sqlError(mysql_error(), mysql_errno(), $sql, '', ''));
$row = dbHelp::mysql_fetch_row2($res);
echo "<table border=0>";
for($i = 0; $i < $nfields; $i++){
    if($Fkeys[$arr[$i]] <> ''){
        $sql = "SHOW FIELDS FROM ".$FkeysTable[$arr[$i]];
        $res = dbHelp::mysql_query2($sql) or die ($sql);
        // $data1 = mysql_data_seek($res, 0);
        $field1 = dbHelp::mysql_fetch_row2($res);
        // $data2 = mysql_data_seek($res, 1);
        $field2 = dbHelp::mysql_fetch_row2($res);

        $sql = "SELECT ".$field2[0]." FROM ".$FkeysTable[$arr[$i]]." WHERE ".$field1[0]."=".$row[$i];
        $res = dbHelp::mysql_query2($sql) or die ($sql); //mysql_error().$sql);
        $fkrow = dbHelp::mysql_fetch_row2($res);
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