<?php
    $res_id=$_GET['resourceStatus'];
    // 5 year cookie
    setcookie('resourceStatus',5,time()+157680000,'/');
	// remove cookie
    // setcookie('resourceStatus','',time()-3600,'/');
	echo "Cookie is set";
?>
