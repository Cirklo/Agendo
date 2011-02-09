<?php


/*
  @author Joao Lagarto
  @copyright 2009-2010 Joao Lagarto
  @license http://www.gnu.org/copyleft/lesser.html Distributed under the Lesser General Public License (LGPL)
  @version 1.0
  @ auto-populate dropdown 
*/

$link = mysql_connect("localhost", "root", "equip!admin") or die("not connected");
mysql_select_db('bugworkers') or die("Could not select database");


/*
note:

the returned xml has the following structure
<results>
	<rs>foo</rs>
	<rs>bar</rs>
</results>
*/

$table = $_GET['table'];
$input = $_GET['input'];
$user_id = $_GET['user'];

$sql = "SELECT resaccess_column, resaccess_value FROM resaccess WHERE resaccess_user = $user_id AND resaccess_table = '$table'";
$res = mysql_query($sql) or die (mysql_error().$sql);
$nres = mysql_num_rows($res);
if($nres != 0){ //user has restriction for this table
	$having = " HAVING ";
	while($row = mysql_fetch_array($res)){
		$row[1] = str_replace(",","','",$row[1]);
		$having .= $row[0]." IN ('".$row[1]."') AND ";
	}
	$having = substr($having, 0, strlen($having)-4);
} else {
	$having = '';
}

$sql = "show fields from $table";
$res = mysql_query($sql);
$data1 = mysql_data_seek($res, 0);
$field1 = mysql_fetch_array($res);
$data2 = mysql_data_seek($res, 1);
$field2 = mysql_fetch_array($res);

$sql = "SELECT ".$field2[0].",".$field1[0]." FROM ".$table." WHERE LOWER(".$field2[0].") regexp LOWER('".$input."') $having";
$res = mysql_query($sql);
$i = 0;
$arr = array();


while($row = mysql_fetch_array($res))
{ 
	$arr[] = $row[0];
}
	$len = strlen($input);

	$aResults = array();
	
	if ($len)
	{
		for ($i = 0; $i < count($arr); $i++)
		{
			if (strtolower(substr($arr[$i], 0, $len)) == $input or substr($arr[$i], 0, $len) == $input)
			{
				//$aResults[] = $arr[$i];
				$aResults[] = array( "id"=>($i+1) ,"value"=> $arr[$i] );
			}				
				
		}
	}
	
	header("Content-Type: text/xml");
	
	echo "<?xml version='1.0' encoding='UTF-8'?>
<results>";
	for ($i = 0; $i < count($aResults); $i++)
		//echo"<rs>".utf8_encode($aResults[$i])."</rs>\n";
		echo "<rs id=\"".$aResults[$i]['id']."\" info=''>".utf8_encode($aResults[$i]['value'])."</rs>";
	echo "</results>";
?>
