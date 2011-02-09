<?php
/**
  * @author Nuno Moreno
  * @copyright 2009-2010 Nuno Moreno
  * @license http://www.gnu.org/copyleft/lesser.html Distributed under the Lesser General Public License (LGPL)
  * @version 1.0
  * @abstract function for displaying inputboxes depending on mix characteristics
  * @param $val -> value in input box
  * @param $name -> id for input box
  * @param $len -> relative value for box size
  * @param $flag -> the container for mysql tags, ex auto_increment
  * @param $type -> validator for javascript: string, real, etc
 */ 
function dispInput($val,$name,$len,$flag,$type,$j){
    ($type=='string')?$size=$len/6:$size=$len;
    ($type=='string')?$msize=$len/3:$msize=$len;
    
    echo "<input name=$name ";
    $strsize=strlen($name);
    //if (($val!='') and (substr($name, $strsize-3,3)=='_id')) {echo 'disabled';};
    
    if (strpos($flag,'auto_increment') || (strpos($flag,'primary_key') && ($val!=''))) {
        echo 'disabled';$flag='';
    } 
    echo " lang='$flag' class=reg title=$type size=$size maxlength=$msize value='$val' onchange=\"javascript:selectRow('tableman$j');\">\n";
}
/**
  * @author Nuno Moreno
  * @copyright 2009-2010 Nuno Moreno
  * @license http://www.gnu.org/copyleft/lesser.html Distributed under the Lesser General Public License (LGPL)
  * @version 1.0
  * @abstract function for filling drop down menus
  * @param $table -> mysql table to be explored
  * @param $selection -> item to be selected
  * @param $name -> id for html tag
  * @param $extra -> extra restriction on mysql query
  * @param $extraecho -> a non database option(s)
 */ 

function autoComplete ($table,$selection,$name, $flag, $user_id, $j)
{
    $sql = "show fields from ".$table;
    $res = mysql_query($sql);
    $data1 = mysql_data_seek($res, 0);
    $field1 = mysql_fetch_array($res);
    $data2 = mysql_data_seek($res, 1);
    $field2 = mysql_fetch_array($res);

    $sql = "SELECT ".$field2[0]." FROM ".$table;
    $res = mysql_query($sql);
    $nrows = mysql_num_rows($res);
    $sql = "SELECT ".$field2[0]." FROM ".$table." WHERE ".$field1[0]."=".$selection;
    $res = mysql_query($sql);
 

    if($nrows > 15)
    {
		$sel = mysql_fetch_array($res);
		$str = $sel[0];
		
		echo "<input type=text class=ek name=$name id=$name onkeypress=autoFill(this,'".$table."',event,$user_id) value='$str' lang='__extkey$flag' onchange=\"javascript:selectRow('tableman$j');\">";
    }
    else
    {
		fillCombos($table,$selection,$name,$extra='',$extraecho='', $user_id, $j);
    }    
}
 
function fillCombos ($table,$selection,$name,$extra='',$extraecho='', $user_id,$j)
{
    echo "<select class=$name id=$name name=$name $extra onchange=\"javascript:selectRow('tableman$j');\">";
    echo $extraecho;
    $sql = "select distinct * from $table order by '" . $table . "_id'";
    $res=mysql_query ($sql) or die ($sql);
    //echo $sql;
    for ($k=0;$k< mysql_num_rows($res);$k++) {
	mysql_data_seek($res,$k);
	$arr= mysql_fetch_row($res);
	if ($arr[0]==$selection) {
            $sel='Selected';
	} else {
            $sel='';
	}
	echo "<option value='".$arr[0]."' $sel >".$arr[1]."</option>\n";
    }
    echo "</select>";
}

//$linkID is the link ID of the connection to the MySQL database
function clean_input($input)
{
    
    if(get_magic_quotes_gpc())
    {
        //Remove slashes that were used to escape characters in post.
        $input = stripslashes($input);
    }
    //Remove ALL HTML tags to prevent XSS and abuse of the system.
    $input = strip_tags($input);
    //Escape the string for insertion into a MySQL query, and return it.
    return mysql_real_escape_string($input);
}

function restrict_access($table, $user_id){
    $db = database(1);
    $sql = "SELECT resaccess_column, resaccess_value, resaccess_table FROM resaccess WHERE resaccess_user = $user_id";
    $res = mysql_query($sql) or die (mysql_error().$sql);
    $nres = mysql_num_rows($res);
    
    if($nres != 0){ //user has restriction for this table
	    while($row = mysql_fetch_array($res)){
		    if($table == $row[2]){
			    $row[1] = str_replace(",","','",$row[1]);
			    $having .= $row[0]." IN ('".$row[1]."') AND ";
		    } else {
			    mysql_select_db("information_schema");
			    $sql = "SELECT table_name, column_name FROM KEY_COLUMN_USAGE WHERE CONSTRAINT_SCHEMA = '".$db."' AND REFERENCED_TABLE_NAME = '".$row[2]."'";
			    $res2 = mysql_query($sql) or die(mysql_error().$sql);
			    while ($fkrow = mysql_fetch_array($res2)){
				    if($table == $fkrow[0]){
					    $row[1] = str_replace(",","','",$row[1]);
					    $having .= $fkrow[1]." IN ('".$row[1]."') AND ";
				    } else {} //do nothing
			    }
			    mysql_select_db($db);
		    }
	    }
	    $having = substr($having, 0, strlen($having)-4);
    } else {
	    $having = '';
    }
    if($having != '') $havclause = " HAVING ".$having;
    return $havclause;
}


?>