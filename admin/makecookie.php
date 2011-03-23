<?php
//foreach ($_SERVER as $key => $value) {
//     echo "Key: $key; Value: $value<br />\n";
//}
    $res_id=$_GET['resource_ip'];
    //cookie for 5 year
    setcookie('resource_ip',$res_id,time()+157680000,'/');
	echo "Cookie is set";
?>
