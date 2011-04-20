<?php
//foreach ($_SERVER as $key => $value) {
//     echo "Key: $key; Value: $value<br />\n";
//}
    $res_id=$_GET['resourceStatus'];
    //cookie for 5 year
    setcookie('resourceStatus',5,time()+157680000,'/');
	echo "Cookie is set";
?>
