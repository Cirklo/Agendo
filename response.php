<?php

/*
  @author Nuno Moreno/João Lagarto
  @copyright 2009-2010 Nuno Moreno/João Lagarto
  @license http://www.gnu.org/copyleft/lesser.html Distributed under the Lesser General Public License (LGPL)
  @version 1.1
  @ ajax request handler
*/

require_once(".htconnect.php");
require_once("functions.php");
$db = database(1);
mysql_select_db('information_schema');

$id = $_GET['id'];
$value = clean_input($_GET['val']);

$sql = "SELECT REFERENCED_TABLE_NAME FROM KEY_COLUMN_USAGE where REFERENCED_TABLE_NAME <> 'null' AND COLUMN_NAME = '".$id."' AND CONSTRAINT_SCHEMA LIKE '".$db."'";
$resf = mysql_query($sql);
while($row = mysql_fetch_array($resf))
{
	$table = $row[0];
	
}

mysql_select_db($db);

$sql = "show fields from ".$table;
$res = mysql_query($sql) or die ($sql);
mysql_data_seek($res,0);
$field1 = mysql_fetch_row($res);
mysql_data_seek($res,1);
$field2 = mysql_fetch_row($res); 

$sql="select " . $field2[0] . ",". $field1[0] . " from $table where lower(" . $field2[0] . ") like lower('" . $value . "%')";
$res = mysql_query($sql) or die ($sql);
$arr = mysql_fetch_row($res);
echo $arr[1];

?>
