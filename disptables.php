<?php

// require_once(".htconnect.php");
require_once("classSearch.php");
//display tables or views
function tables($table, $type, $i){
      
    dbHelp::mysql_select_db2('information_schema');
    $sql = "SELECT * FROM TABLES WHERE TABLE_NAME = '".$table."' AND TABLE_TYPE = 'view'";
    $res = dbHelp::mysql_query2($sql);
    $nview = dbHelp::mysql_numrows2($res);
    if($type == 'tables'){//tables
        if($nview == 0){
	    showtables($table, $type, $i);
	    return $table;
	}
    }else{//views
        if($nview != 0){
	    showtables($table, $type, $i);
	    return $table;
	}
    }
}

//display tables associated with stored procedures
function procedures($param, $nrows, $order, $user_id, $show, $db){
    dbHelp::mysql_select_db2($db);
    $proc = "SELECT * FROM proc";
    $resproc = dbHelp::mysql_query2($proc) or die($sql); //mysql_error());
    $procrows = dbHelp::mysql_numrows2($resproc);
    while($rowpr = dbHelp::mysql_fetch_row2($resproc)) {
        //Finds parameters for each procedures
        $proc_param = "SELECT * FROM param WHERE param_proc = '".$rowpr[0]."'";
        $res_param = dbHelp::mysql_query2($proc_param);
        //Displays a form for each procedures
	echo '<form action="admin.php" method="post">';
        echo "<tr><td valign=top align=center><input type='submit' name='show' style='width:150px' value='" . strtoupper(substr($rowpr[0],5,strlen($rowpr[0])-5)) ."'></td>";
        //Form
        echo "<td valign=top>Results per page <input type=text value=20 id=nrows name=nrows size=1></td></tr>";
        echo "<tr><td colspan=2 valign=top align=left width=200px>";
        while ($plist = dbHelp::mysql_fetch_row2($res_param)) {
            echo $plist[2]." ";
            make_form($plist[3], $plist[2].$rowpr[0]);
        }
        echo '<input type="hidden" name="proc_name" value=' . $rowpr[0] . ' />';
        echo '</td></tr>';
	$comment = get_comment(substr($rowpr[0],5,strlen($rowpr[0])-5));
        $comment = strtok($comment,";");
        if(strpos($comment,"InnoDB") === false){//do nothing
        } else
	    $comment = "No description";
	if($comment == '') $comment = "No description";
	echo "<tr><td colspan=2 align=left><strong>Description</strong>: <font color=#AA7777>".$comment."</font></td><tr>";
        echo '</form></tr>';
    }
    if ($show == 'show') {
	$proc_param = "SELECT * FROM param WHERE param_proc = '".$param."'";
	$res_param = dbHelp::mysql_query2($proc_param);
	//Creation of the parameters array
	$j = 0;
	while ($plist = dbHelp::mysql_fetch_row2($res_param)) {
		$params[$j] = $_POST[$plist[2].$param];
		$j++;
	}
	if (filled($params, $j)) {
		//Creates the argument string
		$args = '\'' . $params[0] . '\'';
		for ($k = 1; $k < $j; $k++) {
			$args = $args . ', \'' . $params[$k] . '\'';
		}
		$args = $args . ', ' . $user_id;	
		//Calls the procedure
		
		$call_query = 'CALL ' . $param . '(' . $args . ')';
		$call_proc = dbHelp::mysql_query2($call_query);
		//Displays the result
		echo '<meta http-equiv="refresh" content=";URL=\'manager.php?table=' . substr($param, 5, strlen($param) - 5) . '&nrows=' . $nrows . '&order=' . $order . '&userid=' . $user_id . '\'>';
	}
	else{
		echo "<script type='text/javascript'>";
		echo "alert('Please enter all parameters for ".substr($param, 5, strlen($param) - 5)."');";
		echo "</script>";
	}
    }   
}

function showtables($table, $type,$i){
   $db = dbHelp::database2(1);
   $search = new quickSearch;
   try{
   echo "<form name=nrows".$table. " id=nrows".$table. ">";
   echo "<tr><td align=center><input type='button' style='width:150px' onclick=\"postvars(1,'".$table."',$i)\" value='".strtoupper($table)."'></td>";
   echo "<td width=150px>Results per page <input type=text value=20 id=nrows$i name=nrows$i size=1></td></form>";
   echo "<td width=200px>";
   dbHelp::mysql_select_db2($db);
   $search->checkSearch($table,$i);
   echo "</td></tr>";
   if($type == 'tables'){
       $comment = get_comment($table);
       $comment = strtok($comment,";");
       if(strpos($comment,"InnoDB") === false){//do nothing
       } else
       $comment = "No description";
   } else
       $comment = "No description";
   echo "<tr><td colspan=2 align=left><strong>Description</strong>: <font color=#AA7777>".$comment."</font></td><tr>";
   echo "<form method=post name=". $table ." id=" . $table . ">";
   }
   catch (Exception $e){}
   echo "</form>";

}


//function to create forms
function make_form($type, $name){
    if (strtolower($type) == "date" or strtolower($type) == "datetime") {
	echo '<br><input type=text style="width:100px" name=' . $name . ' id=' . $name . ' readonly=readonly>';
	echo '<script type="text/javascript">Calendar.setup({inputField	 : ' . $name. ',baseField    : "element_2",button: ' . $name . ',ifFormat: "%Y %e, %D",onSelect: selectDate});</script></br>';
    }
    else
	echo '<br><input type="text" name=' . $name . '> </br>';
}
	
//Checks if all the form is filled
function filled($array, $size){
    $filled = 1;
    for ($i = 0; $i < $size; $i++) {
	if (!$array[$i])
	    $filled = 0;
	}
    return $filled;
}

function get_comment($table){
    dbHelp::mysql_select_db2("information_schema");
    $db = dbHelp::database2(1);
    $sql = "SELECT TABLE_COMMENT FROM TABLES WHERE TABLE_NAME = '".$table."' AND TABLE_SCHEMA = '".$db."'";
    $res = dbHelp::mysql_query2($sql) or die ($sql); //mysql_error().$sql);
    $row = dbHelp::mysql_fetch_row2($res);
    dbHelp::mysql_select_db2($db);
    return $row[0];
}

?>