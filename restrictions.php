<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><link href="admin.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="js/checkfields.js"></script>

<?php

require_once("genObjClass.php");
require_once(".htconnect.php");

function showRestrictions($user_id, $table, $j, $nrows, $userid, $order, $page, $limit, $value){
   $sql = "SELECT admin_permission FROM admin WHERE admin_table LIKE '".$table."' AND admin_user = '".$user_id."' ORDER BY admin_permission ASC";
   $res = mysql_query($sql);
   $n = mysql_num_rows($res);
   $row = mysql_fetch_array($res);

   if($n == 0 and $table == 'user')
       $row[0] = 1;
   elseif($n == 0 and $table != 'user')
       $row[0] = 0;

   //initialize variables
   $update = false;
   $delete = false;
   $add = false;
   $request = false;

   switch ($row[0])
   {
   case 0: //only view
       break;
   case 1:
       $update = true;
       break;
   case 2:
       $delete = true;
       break;
   case 3:
       $update = true;
       $delete = true;
       break;
   case 4:
       $add = true;
       break;
   case 5:
       $update = true;
       $add = true;
       break;
   case 6:
       $delete = true;
       $add = true;
       break;
   case 7:
       $update = true;
       $delete = true;
       $add = true;
       break;
   case 8:
       $request = true;
       break;
   case 9:
       $update = true;
       $request = true;
       break;
   case 10:
       $delete = true;
       $request = true;
       break;
   case 11:
       $update = true;
       $delete = true;
       $request = true;
       break;
   case 12:
       $request = true;
       $add = true;
       break;
   case 13:
       $update = true;
       $request = true;
       $add = true;
       break;
   case 14:
       $delete = true;
       $request = true;
       $add = true;
       break;
   case 15:
       $update = true;
       $delete = true;
       $request = true;
       $add = true;
       break;
   }

   $action = array();
   $action[0] = $update;
   $action[1] = $delete;
   $action[2] = $add;
   $action[3] = $request;
   $count = 0;
   for($i=0; $i < sizeof($action); $i++){
       if($action[$i] == false) $count++;
   }

   if($count == 1) echo "<td></td>";
   if($count == 2) echo "<td></td><td></td>";
   if($count == 3) echo "<td></td><td></td><td></td>";
   if($count == 4) echo "<td></td><td></td><td></td><td></td>";


   if($add == true){//show copy button
       echo "<td width=25px align=center valign=top><a href=# onclick=\"javascript:copy($j);\"><img src=pics/copy.png border=0 title='copy row'></a></td>";
   }
   if($update == true){//show update button
       echo "<td width=25px align=center valign=top><a href=\"javascript:checkFill('$j','update','$table',$nrows, '$userid', '$order', $page, $limit);\"><img src=pics/update.png border=0 title='update row'>\t</a></td>";
   }
   if($delete == true){//show delete button
       echo "<td width=25px align=center valign=top><a href=\"javascript:checkFill('$j','delete','$table',$nrows, '$userid', '$order', $page, $limit);\"><img src=pics/delete.png border=0 title='delete row'>\t</a></td>";
   }
   if($request == true){//show shopping cart
       echo "<td align=center valign=top><div style='width:85px'><a href=# style='text-decoration:none;' onclick=\"javascript:basket('sum','quantity$j');\"><font size=2px>+</font>&nbsp;</a><a href=# style='text-decoration:none;'onclick=\"javascript:basket('sub','quantity$j');\">&nbsp;<font size=3px>-</font>&nbsp;</a><input type=text class=reg id='quantity$j' name='quantity$j' value=1 size=2><a href=# style='text-decoration:none' onclick=\"javascript:addtobasket('add','quantity$j', $value, $user_id,'$table');\">&nbsp;<img src=pics/request.png border=0 title='add to basket'></a></div></td>";
       echo "<td></td>";
   } else {
       //echo "<td></td>";
       if($update == true or $delete == true)
           echo "<td valign=top align=center><input type=checkbox name='checkbox_$j' id='checkbox_$j'></td>";
       else
           echo "<td></td>";
   }
   if($add == true){//New fields for insert
       return 'add';
   }

}
?>
