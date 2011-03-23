<?php

require_once ".htconnect.php";
//get user id so specific query can be built
require_once "session.php";
$user_id=startSession();
	
//call database class
$conn=new dbConnection();
	
//initialize variables
try{
	/*$query="SELECT task_id, action_name, task_description, task_date, user_login
  	FROM task, action, user
  	WHERE action_id=task_action
  	AND task_user=user_id";*/
	$query="SELECT entry_id, resource_name, entry_datetime, DATE_ADD( entry_datetime, INTERVAL entry_slots * resource_resolution MINUTE ) AS entry_time, user_login
		FROM entry, resource, user
		WHERE entry_user=user_id
		AND entry_resource=resource_id
		AND entry_status IN (1,2)
		AND (entry_user=$user_id 
		OR resource_resp=$user_id)";
  	$sql=$conn->query($query);
	//loop through all results
	for($i=0;$row=$sql->fetch();$i++) {
	   	//build message to be displayed
	   	$json[$i]["id"]=$i+1;
	   	$json[$i]["title"]=$row[1];
	   	$json[$i]["start"]=$row[2];//$row[3];
	   	$json[$i]["end"]=$row[3];//$row[3];
	   	$json[$i]["allDay"]=false;
	}
} catch(Exception $e){
   	echo $e->getMessage();
}

//need to print to json format
//print_r($ret);
echo json_encode($json);




?>

