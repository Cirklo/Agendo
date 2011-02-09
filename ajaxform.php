<script type="text/javascript">

function checklogin(type){
    alert("Invalid " + type + "! Please try again.");
    window.location = "newperm.php";
}

</script>

<?php

require_once(".htconnect.php");
require_once("errorHandler.php");
require_once("alert/class.phpmailer.php");

$error = new errorHandler;
$mail = new PHPMailer;

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
} else { //new permissions form
    $user_login = $_POST['user_login'];
    $pwd = $_POST['pwd'];
    $resource = $_POST['Resource'];
    $train = $_POST['assistance'];
    if($train == 'on') $train = "yes";
    else $train = "no";
    
    $sql = "SELECT password('$pwd')";
    $res = mysql_query($sql) or die($error->sqlError(mysql_error(), mysql_errno(), $sql, '', ''));
    $row = mysql_fetch_row($res);
    $pwd = $row[0];
    $sql = "SELECT user_passwd, CONCAT(user_firstname,' ',user_lastname),user_email FROM user WHERE user_login = '".$user_login."'";
    $res = mysql_query($sql) or die($error->sqlError(mysql_error(), mysql_errno(), $sql, '', ''));
    $row = mysql_fetch_row($res);
    $nrows = mysql_num_rows($res);
    $user_name = $row[1];
    $user_email = $row[2];
    
    if($nrows == 0){
        echo "<script type='text/javascript'>checklogin('user name');</script>";
        exit();
    }
    if($pwd != $row[0]){
        echo "<script type='text/javascript'>checklogin('password');</script>";
        exit();
    }
    
    $sql = "SELECT permissions_resource FROM permissions WHERE permissions_user IN (SELECT user_id FROM user WHERE user_login='$user_login') AND permissions_resource = $resource";
    $res = mysql_query($sql) or die($error->sqlError(mysql_error(), mysql_errno(), $sql, '', ''));
    if(mysql_num_rows($res) != 0){
        echo "<script type='text/javascript'>";
        echo "alert('You already have permissions to use this resource. Please contact the equipment administrator for more information!');";
        echo "window.close();";
        echo "</script>";
        exit();
    }
    
    $sql = "SELECT user_email, resource_name FROM user, resource WHERE user_id = resource_resp AND resource_id = ".$resource;
    $res = mysql_query($sql) or die ($error->sqlError(mysql_error(), mysql_errno(), $sql, '', ''));
    $row = mysql_fetch_row($res);
    
    $resp = $row[0];
    $resource = $row[1];
    
    //Send email both to the user and to the administrator
    $sql = "SELECT mainconfig_host, mainconfig_port, mainconfig_password, mainconfig_email, mainconfig_SMTPSecure, mainconfig_SMTPAuth FROM mainconfig WHERE mainconfig_id = 1";
    $res = mysql_query($sql) or die ($error->sqlError(mysql_error(), mysql_errno(), $sql, '', ''));
    $row = mysql_fetch_row($res);
    
    $mail->IsSMTP(); // telling the class to use SMTP
    $mail->SMTPDebug  = 1;                     // enables SMTP debug information (for testing)
    $mail->SMTPAuth   = $row[5];                  // enable SMTP authentication
    $mail->SMTPSecure = $row[4];                 // sets the prefix to the servier
    $mail->Port       = $row[1];                   // set the SMTP port for the GMAIL server   
    $mail->Host       = $row[0];      // sets GMAIL as the SMTP server
    $mail->Username   = $row[3];  // GMAIL username
    $mail->Password   = $row[2];            // GMAIL password
    $mail->SetFrom($row[3], "Calendar administration");
    $mail->AddReplyTo($row[3],"Calendar administration");   
    
    $msg = "The user $user_name is requesting permission to use $resource.\n\n";
    $msg .= "login: $user_login\n";
    $msg .= "email: $user_email\n";
    $msg .= "resource: $resource\n";
    $msg .= "training request: $train\n\n";
    $msg .= "Please confirm the permission to the requesting user.\n\n";
    $msg .= "This is an automatic generated email. Do not reply!";
    
    $mail->Subject = "Calendar administration: Permission requested";
    $mail->Body = $msg;
    
    //$mail->AddAddress($resp, "");
    $mail->AddAddress($resp, "");
    $mail->AddAddress("rpdias@fc.ul.pt", "");

    if(!$mail->Send()) {
        echo "<table border=0>";
        echo "<tr><td><br>Error on sending request!<br></td></tr>";
        echo "<tr><td>If the problem persists please contact the administration!<br><br></td></tr>";
        echo "<tr><td><a href=# class=new onclick=\"javascript:window.open('newperm.php','_blank','directories=no,status=no,menubar=yes,location=yes,resizable=no,scrollbars=no,width=350,height=275')\">New permission</a>";
        echo "&nbsp;&nbsp;&nbsp;";
        echo "<tr><td><a href=# onclick='window.close()'>Exit</a></td></tr>";
        echo "</table>";
        
    } else {
        echo "<table border=0>";
        echo "<tr><td>Your request has been successfully sent to the equipment administrator. Please wait for confirmation!<br><br></td></tr>";
        echo "<tr><td><a href=# onclick='window.close()'>Exit</a></td></tr>";
        echo "</table>";
    }
}
   
    

?>