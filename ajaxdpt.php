<?php

require_once(".htconnect.php");
require_once("errorHandler.php");

$error = new errorHandler;

if(isset($_GET['val'])){ //new user form -> ajax response
    $id = $_GET['val'];    
    if($id != 0){
        $sql = "SELECT institute_name FROM institute, department WHERE institute_id = department_inst AND department_id = $id";
        $res = mysql_query($sql) or die ($error->sqlError(mysql_error(), mysql_errno(), $sql, '', ''));
        $row = mysql_fetch_row($res);
        echo $row[0];
    } else {
        //do nothing
    }
}

if(isset($_GET['user'])){
    $login = $_GET['user'];
    $login = strtok($login,"@");
    $firstname = $_GET['fn'];
    $lastname = $_GET['ln'];
    $sql = "SELECT * FROM user WHERE lower(user_firstname)=lower('$firstname') AND lower(user_lastname)=lower('$lastname') AND lower(user_login)=lower('$login')";
    $res = mysql_query($sql) or die ($error->sqlError(mysql_error(), mysql_errno(), $sql, '', ''));
    $nrows = mysql_num_rows($res);
    if($nrows == 0){ //not yet registered
        echo "OK";
    } else { //already registered
    }
}

?>