<?php
require_once("commonCode.php");

header("Content-type: application/vnd.ms-excel");
header("Content-Disposition: attachment; filename='export-to-excel.xls'");

// require_once(".htconnect.php");
// require_once("__dbHelp.php");

set_time_limit(0); //sets unlimited timerange (no timeout)

//database select
$db = dbHelp::getDatabase();
dbHelp::mysql_select_db2($db);

//http variables
$table = $_GET['table'];
$userid = $_GET['userid'];

//initialize variables
$query = "";
$Fkeys = array();

//show fields from table to export
$sql = "show fields from $table";
$res = dbHelp::mysql_query2($sql) or die ($sql); //mysql_error());
while($row = dbHelp::mysql_fetch_row2($res)){
   dbHelp::mysql_select_db2("information_schema");
   $sql2 = "SELECT REFERENCED_TABLE_NAME FROM KEY_COLUMN_USAGE WHERE COLUMN_NAME='".$row[0]."' AND TABLE_NAME='$table' AND TABLE_SCHEMA='$db' AND CONSTRAINT_NAME<>'PRIMARY'";
   $res2 = dbHelp::mysql_query2($sql2) or die ($sql); //mysql_error());
   $row2 = dbHelp::mysql_fetch_row2($res2);
   $nrows = dbHelp::mysql_numrows2($res2);
   $Fkeys[] = $row2[0];
}

//main query
dbHelp::mysql_select_db2($db);
if($userid == '')    $sql = "SELECT * FROM $table";
else $sql = "SELECT * FROM ".dbHelp::getSchemaName().".".$table." AND ".dbHelp::getSchemaName().".".$table."_userid=$userid";
$res = dbHelp::mysql_query2($sql) or die ($sql); //mysql_error());
$nrows = dbHelp::mysql_numrows2($res);
$nfields = mysql_num_fields($res);
//print fields' name
for($i = 0; $i < $nfields; $i++){
   $field[$i] = mysql_field_name($res, $i);
   echo $field[$i]."\t";

}
echo "\n";
//print result to spreadsheet
for($j = 0; $j < $nrows; $j++){
   echo "\t";
   // mysql_data_seek($res,$j);
   $arr = dbHelp::mysql_fetch_row2($res);
   for ($i = 0; $i < $nfields; $i++) {
       if ($Fkeys[$i] <> '') { //Is it foreign key?
           $sql2 = "show fields from $Fkeys[$i]";
           $res2 = dbHelp::mysql_query2($sql2) or die ($sql); //mysql_error());
           // $data1 = mysql_data_seek($res2, 0);
           $field1 = dbHelp::mysql_fetch_row2($res2);
           // $data2 = mysql_data_seek($res2, 1);
           $field2 = dbHelp::mysql_fetch_row2($res2);
           $sql3 = "SELECT $field2[0] FROM $Fkeys[$i] WHERE $field1[0]=$arr[$i]";
           $res3 = dbHelp::mysql_query2($sql3) or die ($sql); //mysql_error());
           $row3 = dbHelp::mysql_fetch_row2($res3);
           echo $row3[0]."\t";
       } else     {
           echo $arr[$i]."\t";
       }
   }
   echo "\n";
}
/*
$tsv = array();

while($row = dbHelp::mysql_fetch_row2($res)){
   $tsv[] = implode("\t", $row);
}

$tsv = implode("\n\t", $tsv);

echo "\n";
echo "\t".$tsv;*/
?>