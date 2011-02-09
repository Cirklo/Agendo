<?php
header("Content-type: application/vnd.ms-excel");
header("Content-Disposition: attachment; filename='export-to-excel.xls'");

require_once(".htconnect.php");

set_time_limit(0); //sets unlimited timerange (no timeout)

//database select
$db = database(1);
mysql_select_db($db);

//http variables
$table = $_GET['table'];
$userid = $_GET['userid'];

//initialize variables
$query = "";
$Fkeys = array();

//show fields from table to export
$sql = "show fields from $table";
$res = mysql_query($sql) or die (mysql_error());
while($row = mysql_fetch_array($res)){
   mysql_select_db("information_schema");
   $sql2 = "SELECT REFERENCED_TABLE_NAME FROM KEY_COLUMN_USAGE WHERE COLUMN_NAME='".$row[0]."' AND TABLE_NAME='$table' AND TABLE_SCHEMA='$db' AND CONSTRAINT_NAME<>'PRIMARY'";
   $res2 = mysql_query($sql2) or die (mysql_error());
   $row2 = mysql_fetch_row($res2);
   $nrows = mysql_num_rows($res2);
   $Fkeys[] = $row2[0];
}

//main query
mysql_select_db($db);
if($userid == '')    $sql = "SELECT * FROM $table";
else $sql = "SELECT * FROM $table AND ".$table."_userid=$userid";
$res = mysql_query($sql) or die (mysql_error());
$nrows = mysql_num_rows($res);
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
   mysql_data_seek($res,$j);
   $arr = mysql_fetch_row($res);
   for ($i = 0; $i < $nfields; $i++) {
       if ($Fkeys[$i] <> '') { //Is it foreign key?
           $sql2 = "show fields from $Fkeys[$i]";
           $res2 = mysql_query($sql2) or die (mysql_error());
           $data1 = mysql_data_seek($res2, 0);
           $field1 = mysql_fetch_array($res2);
           $data2 = mysql_data_seek($res2, 1);
           $field2 = mysql_fetch_array($res2);
           $sql3 = "SELECT $field2[0] FROM $Fkeys[$i] WHERE $field1[0]=$arr[$i]";
           $res3 = mysql_query($sql3) or die (mysql_error());
           $row3 = mysql_fetch_row($res3);
           echo $row3[0]."\t";
       } else     {
           echo $arr[$i]."\t";
       }
   }
   echo "\n";
}
/*
$tsv = array();

while($row = mysql_fetch_row($res)){
   $tsv[] = implode("\t", $row);
}

$tsv = implode("\n\t", $tsv);

echo "\n";
echo "\t".$tsv;*/
?>