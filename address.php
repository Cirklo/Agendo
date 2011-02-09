<?php 

$value = $_GET['amt'];

$dbConn = mysql_connect("localhost", "root", "equip!admin") or die ('Error connecting to mysql');

mysql_select_db('labcal') or die (mysql_error());

if($value != '0')
{
	
	$query_add = "SELECT board_address
		FROM board, equip
		WHERE board_id = equip_boardid
		AND equip_resourceid = '".$value."'
		GROUP BY board_id";
	
	$res_add = mysql_query($query_add);
	$row_add = mysql_fetch_array($res_add);
	
	echo "<br /><strong>Board Address: </strong>\t".$row_add['board_address']."<br />";
	
	/*$query_equip = "SELECT equip_desc 
		FROM equip
		WHERE equip_resourceid = '".$value."'";
		
	$res_equip = mysql_query($query_equip);
	
	while($row_equip = mysql_fetch_array($res_equip))
	{
		//echo $row_equip['equip_desc'];
	}*/
	
}
else
{
	echo "";
}



?>
