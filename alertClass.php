<?php

require_once("alert/class.phpmailer.php");
// require_once("commonCode.php");

/**
  * @author Nuno Moreno
  * @copyright 2009-2010 Nuno Moreno
  * @license http://www.gnu.org/copyleft/lesser.html Distributed under the Lesser General Public License (LGPL)
  * @version 1.0
  * @abstract Uses the phpmailer package for sending email warnings depending on several situations. Depending on the user configuration it cal also
  * generate a remote open. This remote computer is/should be running the python script alert/webserver.py which recieves the request and process
  * the info to gnokii for connecting to a GSM device and send an SMS
*/
class alert extends PHPMailer{
private $UserEmail;
private $UserFullName;
private $UserMobile;
private $Slots;
private $LastEntry;

private $User;
private $AlertType;

private $Resource;
private $ResourceResolution;
private $ResourceName;

private $RespName;
private $RespEmail;
private $RespMobile;
private $ResourceResp;
private $RespAlert;

/**
  * @method noreturn sets the sender email configuration
  * @
*/

function __construct($resource=0) {
    
    $sql = "SELECT mainconfig_host, mainconfig_port, mainconfig_password, mainconfig_email, mainconfig_smtpsecure, mainconfig_smtpauth FROM mainconfig WHERE mainconfig_id = 1";
    $res = dbHelp::mysql_query2($sql) or die ("Error while making the query -> " . $sql);;
    $row = dbHelp::mysql_fetch_row2($res);
   $this->IsSMTP(); // telling the class to use SMTP
    $this->SMTPDebug  = 1;                     // enables SMTP debug information (for testing)
    $this->SMTPAuth   = $row[5];                  // enable SMTP authentication
    $this->SMTPSecure = $row[4];                 // sets the prefix to the servier
    $this->Port       = $row[1];                   // set the SMTP port for the GMAIL server   
    
   //$this->Host       = "smtp.gmail.com";      // sets GMAIL as the SMTP server
 
   // $this->Username   = "calserviceigc@gmail.com";  // GMAIL username
   // $this->Password   = "uic!admin";            // GMAIL password
   //$this->SetFrom('calserviceigc@gmail.com', 'Calendar Admin');
   //$this->AddReplyTo("calserviceigc@gmail.com","Calendar Admin");
    
    $this->Host       = $row[0];      // sets GMAIL as the SMTP server
    $this->Username   = $row[3];  // GMAIL username
    $this->Password   = $row[2];            // GMAIL password
    $this->SetFrom($row[3], 'Calendar Admin');
    $this->AddReplyTo($row[3],"Calendar Admin");
  
    $this->Resource=$resource;
    
    // $sql="select user_id,user_email,user_mobile, concat(user_firstname,' ',user_lastname) name,user_alert,resource_name,resource_resolution from ".dbHelp::getSchemaName().".user,resource where resource_resp=user_id and resource_id=". $this->Resource;
    $sql="select user_id,user_email,user_mobile, user_firstname,user_lastname,user_alert,resource_name,resource_resolution from ".dbHelp::getSchemaName().".user,resource where resource_resp=user_id and resource_id=". $this->Resource;
    
    $res=dbHelp::mysql_query2($sql);
    
    $arr=dbHelp::mysql_fetch_row2($res);
    
    // $this->ResourceResp=$arr[0];
    // $this->RespEmail=$arr[1];
    // $this->RespMobile=$arr[2];
    // $this->RespName=$arr[3];
    // $this->RespAlert=$arr[4];
    // $this->ResourceName=$arr[5];
    // $this->ResourceResolution=$arr[6];
    $this->ResourceResp=$arr[0];
    $this->RespEmail=$arr[1];
    $this->RespMobile=$arr[2];
    $this->RespName=$arr[3]." ".$arr[4];
    $this->RespAlert=$arr[5];
    $this->ResourceName=$arr[6];
    $this->ResourceResolution=$arr[7];
    
	// ??
    // $res=dbHelp::mysql_query2($sql);
    // $arr=dbHelp::mysql_fetch_array2($res);
}
/**
   * Sets user info: email and full name
   * @param integer $user_id

*/

function setUser($user_id){
    
    // $sql="select concat(user_firstname,' ',user_lastname) name,user_email,user_mobile,user_alert from ".dbHelp::getSchemaName().".user where user_id=". $user_id;
    $sql="select user_firstname,user_lastname,user_email,user_mobile,user_alert from ".dbHelp::getSchemaName().".user where user_id=". $user_id;
    $res=dbHelp::mysql_query2($sql);
    $arruser=dbHelp::mysql_fetch_row2($res);
    // $this->UserFullName=$arruser[0];
    // $this->UserEmail=$arruser[1];
    // $this->UserMobile=$arruser[2];
    // $this->AlertType=$arruser[3];
    $this->UserFullName=$arruser[0]." ".$arruser[1];
    $this->UserEmail=$arruser[2];
    $this->UserMobile=$arruser[3];
    $this->AlertType=$arruser[4];
    $this->User=$user_id;
}

function setSlots($Slots){
    $this->Slots=$Slots;
}

function setEntry($entry){
    $this->LastEntry=$entry;
}

function getResourceResp(){
    return $this->ResourceResp;
}
/**
   * In the case of an entry it triggers one warning event.
   * @param integer entry

*/
function toWaitList($type){
    
    // $sql="select @edt:=entry_datetime,@res:=entry_resource from entry where entry_id=". $this->LastEntry;
    // $res=dbHelp::mysql_query2($sql);
    // $sql="select user_mobile,user_email,date_format(entry_datetime,'%d, %M %Y') d, date_format(entry_datetime,'%H:%i') t,resource_name, user_alert from entry,".dbHelp::getSchemaName().".user,resource where entry_resource=resource_id and entry_user=user_id and entry_status=4 and entry_datetime=@edt and entry_resource=@res order by entry_id";
    $sql="select user_mobile,user_email,".dbHelp::getFromDate('entry_datetime','%d, %M %Y')." as d, ".dbHelp::getFromDate('entry_datetime','%H:%i')." as t,resource_name, user_alert from entry,".dbHelp::getSchemaName().".user,resource where entry_resource=resource_id and entry_user=user_id and entry_status=4 and (entry_datetime, entry_resource) in (select entry_datetime,entry_resource from entry where entry_id=". $this->LastEntry.") order by entry_id";
    $res=dbHelp::mysql_query2($sql);
    $arrStatus=dbHelp::mysql_fetch_array2($res);
        
    if (dbHelp::mysql_numrows2($res)>0) {
        switch ($type) {
            case 'delete':
                $msg="You are booked for using " . $this->ResourceName . "  at " . $arrStatus['t'] . " on the " .   $arrStatus['d'] . ". Confirm and update on website. ";
            break;
            case 'update':
                  $msg="Due to an entry update your monitored entry was delete from ". $this->Resource . " at " . $arrStatus['t']  . " on the " .  $arrStatus['d'] . ". Visite the calendar for there might be free spots.";
            break;
        }
        switch ($arrStatus['user_alert']) {
        case 2:
            try {
                $url="http://192.168.52.35:8888/send?phone=". $arrStatus['user_mobile'] . "&msg=" . str_replace(' ','%20',$msg);
                $handle = fopen($url, "r");
            } catch (HttpException $ex) {
                echo $ex;
            }
        break;
        case 1:
            $this->Subject="Calendar waiting list";
            $this->Body=$msg;
            $address = $arrStatus['user_email'];
            $this->AddAddress($address, "");
            if(!$this->Send()) {
                echo "Mailer Error: " . $this->ErrorInfo;
            } else {
                //echo "Message sent!";
            }
            break;
            case 0:
            break;
        }
    }
}
/**
   * Depending on the configuration resource managers can have a msg evertime there is an entry
   * @param string datetime with the format yyyymmddhhii
   * @param integer resource (resource id)

*/

function toAdmin($datetime,$extra,$type,$comment=''){
    if ($this->ResourceResp==$this->User) return;
    $extrainfo='';
    
    $year=substr($datetime,0,4);
    $month=substr($datetime,4,2);
    $day=substr($datetime,6,2);
    $hour=substr($datetime,8,2);
    $min=substr($datetime,10,2);

    if ($extra!='') // fields for new or update entry
        foreach ($extra as $key => $value) {
        $extrainfo.= $key. ":".$value ."\\n";
        }
        $extrainfo=substr($extrainfo,0,strlen($extrainfo)-2);
        
   // $m=($type=='delete')?'METHOD:CANCEL':'';
   // $s=($type=='delete')?'STATUS:CANCELLED':'';

$att = "BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//Cirklo Agendo
BEGIN:VEVENT
UID:". $this->LastEntry . "@agendo
DTSTAMP:" . $year.$month.$day."T".$hour.$min."00"."
DTSTART:" . $year.$month.$day."T".$hour.$min."00"."
DTEND:" . $year.$month.$day."T". date("Hi",mktime($hour,$this->Slots*$this->ResourceResolution)) ."00
SUMMARY: ". $this->UserFullName . " " . $this->ResourceName . "
DESCRIPTION:" . $extrainfo . "
END:VEVENT
END:VCALENDAR";

    //Your entry on " . $arr['resource_name'] . " at ". $arr['t'] . " on the ". $arr['d'] . " 
    switch ($type) {
        case 'newentry':
            $this->AddStringAttachment($att,'agendo.ics');
            $msg="New entry on ". $this->ResourceName . " at ". $hour . ":". $min ." on the " . "$year-$month-$day from user " . $this->UserFullName;
            break;
        case 'comment':
            $msg="Comment added  on ". $this->ResourceName . ":" . $comment;
            break;
        case 'assistance':
            $this->AddStringAttachment($att,'agendo.ics');
            $msg="Assistance requested for " . $this->ResourceName  . " at $hour:$min on the $year-$month-$day";
            break;
        case 'update':
		
			$sql="select xfields_label, xfieldsval_value from xfields, xfieldsval where xfieldsval_entry = ".$this->LastEntry." and xfieldsval_field = xfields_id";
			$res=dbHelp::mysql_query2($sql);
			$fields = '';
			while ($arr = dbHelp::mysql_fetch_row2($res)){
				$fields = " with field ".$arr[0]." = ".$arr[1].",";
			}
			if($fields != '')
				$fields=substr($fields,0,strlen($fields)-1);

				$this->AddStringAttachment($att,'agendo.ics');
            $msg="Update on ".$this->ResourceName." at ".$hour.":".$min." on "."$year-$month-$day from user ".$this->UserFullName.$fields.".";
            break;
          case 'delete':
            $this->AddStringAttachment($att,'agendo.ics');
            $msg="Delete on ". $this->ResourceName  . " at ". $hour . ":". $min ." on " . "$year-$month-$day from user " . $this->UserFullName;
            break;
    }

    switch ($this->RespAlert) {
		case 2:
			try {
				$url="http://192.168.52.35:8888/send?phone=". $this->RespMobile . "&msg=" . str_replace(' ','%20',$msg);
					$handle = fopen($url, "r");
				} catch (HttpException $ex) {
					echo $ex;
				}
			break;
			
        case 1:
            $this->Subject=strtoupper($type)." on " . $this->ResourceName ;
            $this->AddReplyTo($this->UserEmail,$this->UserFullName);
            $this->Body=$msg . "\n email:". $this->UserEmail ."\nmobile:".$this->UserMobile ."\n". $extrainfo ;
            $address = $this->RespEmail;
            $this->AddAddress($address, "");
            if(!$this->Send()) {
                //echo "Mailer Error: " . $this->ErrorInfo;
            } else {
                //echo "Message sent!";
            }
            break;
			
		case 0:
            break;
        }
}

/**
   * Method for password recover. It generates a 8 character pwd alternating a consonant and a vowel and sends it for the user
   * @param integer user_id (user unique id)

*/

function recover($user_id){
    // $sql="select user_email,user_mobile, concat(user_firstname,' ',user_lastname) name,user_alert from ".dbHelp::getSchemaName().".user where user_id=". $user_id;
    $sql="select user_email,user_mobile,user_alert from ".dbHelp::getSchemaName().".user where user_login='". $user_id."'";
    $res=dbHelp::mysql_query2($sql);
    $arr=dbHelp::mysql_fetch_array2($res);
    $vowels="aeiyou";
    $consonants="bcdfghjklmnpqrstvwxz";
    $pwd='';
    for ($i = 0; $i < 8; $i++) {
        if ($i%2==0) {
            $pwd.=$consonants[rand(0,strlen($consonants)-1)];
        } else {
            $pwd.=$vowels[rand(0,strlen($vowels)-1)];
        }
    }
    // $sql="update user set user_passwd = password('$pwd') where user_id=". $user_id;
    $sql="update user set user_passwd = '".cryptPassword($pwd)."' where user_login='". $user_id."'";
    $res=dbHelp::mysql_query2($sql) or die('Password not updated');
    switch ($arr['user_alert']) {
    case 2:
        try {
            $msg="Your%20password%20is%20now%20$pwd";
            $url="http://192.168.52.35:8888/send?phone=". $arr['user_mobile'] . "&msg=" . $msg;
            $handle = fopen($url, "r");
        } catch (HttpException $ex) {
            echo $ex;
        }
        break;
        case 1:
            $this->Subject="New password request";
            $this->AddReplyTo($this->UserEmail,$this->UserFullName);
            $this->Body="Your randomly generated password is now $pwd";
            $address = $arr['user_email'];
            $this->AddAddress($address, "");
            if(!$this->Send()) {
                //echo "Mailer Error: " . $this->ErrorInfo;
            } else {
                //echo "Message sent!";
            }
        break;
        case 0:
            break;
    }
echo "Password updated";
}

function nonconf(){
    
    // $sql="select user_email,user_mobile,user_alert,resource_name,(select user_email from ".dbHelp::getSchemaName().".user where user_id=resource_resp) as resp,(select user_alert from ".dbHelp::getSchemaName().".user where user_id=resource_resp) as resp_alert,entry_id,date_format(entry_datetime,'%d %M at %H:%i') as date from ".dbHelp::getSchemaName().".user,entry,resource where entry_status=2 and date_add(entry_datetime, interval resource_resolution*entry_slots+resource_confirmtol*resource_resolution+60 minute) between now() and date_add(now(),interval 60 minute) and entry_user=user_id and entry_resource=resource_id and resource_status<>4";
    $sql="select user_email,user_mobile,user_alert,resource_name,(select user_email from ".dbHelp::getSchemaName().".user where user_id=resource_resp) as resp,(select user_alert from ".dbHelp::getSchemaName().".user where user_id=resource_resp) as resp_alert,entry_id,".dbHelp::getFromDate('entry_datetime','%d %M at %H:%i')." as date from ".dbHelp::getSchemaName().".user,entry,resource where entry_status=2 and ".dbHelp::date_add('entry_datetime', 'resource_resolution*entry_slots+resource_confirmtol*resource_resolution+60','minute')." between now() and ".dbHelp::date_add('now()','60', 'minute')." and entry_user=user_id and entry_resource=resource_id and resource_status<>4";
    $res=dbHelp::mysql_query2($sql) or die($sql);
    for ($i=0;$i<dbHelp::mysql_numrows2($res);$i++) {
        // mysql_data_seek($res,$i);
        $arr=dbHelp::mysql_fetch_array2($res);      
        $msg="You did not confirm your entry on " . $arr['resource_name'] . ". Please justify to ". $arr['resp'];
        switch ($arr['user_alert']) {
        case 2:
            try {
                $msg=str_replace(' ','%20',$msg);
                echo $msg;
                $url="http://192.168.52.35:8888/send?phone=". $arr['user_mobile'] . "&msg=" . $msg;
                $handle = fopen($url, "r");
            } catch (HttpException $ex) {
                echo $ex;
            }
        break;
        case 1:
                $this->Subject="No confirmation on ". $arr['date'] ;
                $this->AddReplyTo($this->UserEmail,$this->UserFullName);
                $this->Body=$msg;
                $address = $arr['user_email'];
                $this->AddAddress($address, "");
                echo $msg;
                if(!$this->Send()) {
                    echo "Mailer Error: " . $this->ErrorInfo;
                } else {
                    //echo "Message sent!";
                }
        break;
        case 0:
            break;
        }
    }
    
} // end function





function fromAdmin($type,$extra=''){    
        if ($this->ResourceResp==$this->User) return;
        $extrainfo='';
        if ($extra!='') // fields for new or update entry
            foreach ($extra as $key => $value) {
            $extrainfo.= $key. ":".$value .";";
        }
        
        $sql="select user_id,user_email,".dbHelp::getFromDate('entry_datetime','%d, %M %Y')." as d, ".dbHelp::getFromDate('entry_datetime','%H:%i')." as t,user_mobile, user_alert, entry_comments from entry,".dbHelp::getSchemaName().".user,resource where entry_user=user_id and entry_id=". $this->LastEntry;
        $res=dbHelp::mysql_query2($sql);
        $arr=dbHelp::mysql_fetch_array2($res);
        //if ($arr['user_id']==$this->ResourceResp) exit;
        switch ($type) {
        case 'update':
            $msg="Entry on " . $this->ResourceName . " updated by resource administrator. New entry time " . $arr['t'] . " on the ". $arr['d'] . ". Visit calendar for further details";
            break;
        case 'confirm':
			if(isset($arr['entry_comments']))
				$msg="Entry on " . $this->ResourceName  . " at ". $arr['t'] . " on the ". $arr['d'] . " confirmed by administrator with the following comment:\n".$arr['entry_comments']."\n. Visit calendar for further details";
			else
				$msg="Entry on " . $this->ResourceName  . " at ". $arr['t'] . " on the ". $arr['d'] . " confirmed by administrator. Visit calendar for further details";
            break;    
        case 'delete':
            $msg="Your/some entry(ies) on  " . $this->ResourceName  . " was/were deleted by administrator";
            break;
        }
		
        switch ($arr['user_alert']) {
        case 2:
            try {
                $msg.="Do not reply to this SMS";
                $url="http://192.168.52.35:8888/send?phone=". $arr['user_mobile'] . "&msg=" .  $msg=str_replace(' ','%20',$msg);;
                $handle = fopen($url, "r");
            } catch (HttpException $ex) {
                echo $ex;
            }
        break;
        case 1:
            $this->Subject="Calendar administrator warning";
            $msg.=". $extrainfo Do not reply to this email";
            $this->Body=$msg;
            $address = $arr['user_email'];
            $this->AddAddress($address, "");
            if(!$this->Send()) {
                echo "Mailer Error: " . $this->ErrorInfo;
            } else {
                //echo "Message sent!";
            }
            break;
            case 0:
            break;
        }
    
}//end function



} // end class
?>