<?php

function filter($table, $key, $value, $type, $date1, $date2, $user_id){
    //is it foreign key??
    echo "<tr><td>".str_replace($table."_","",$key)."</td>";
    echo "<td>";
    //echo $table."___".$key."___".$value."___".$type."____".$date1."___".$date2;
    if($type){ //Foreign keys
        if($value != 0) $var = findek($type, $value);
        else $var = '';
        echo "<input class=ek type=text name=__".$key." id=".$key." value='".$var."' lang=__extkey onkeypress=autoFill(this,'".$type."',event,$user_id)>";
    }else{
        if(datetime($key) == 'date' or datetime($key) == 'datetime'){
            echo "<input type=text style='width:70px' name=".$key."_beg_ id=".$key."_beg_ readonly=readonly value='$date1'> To <input type=text style='width:70px' name=".$key."_end_ id=".$key."_end_ readonly=readonly value='$date2'>";
	    echo "<script type='text/javascript'>Calendar.setup({inputField	 : '".$key."_beg_',baseField    : 'element_2',button: '".$key."_beg_',ifFormat: '%Y %e, %D',onSelect: selectDate});	</script>";
            echo "<script type='text/javascript'>Calendar.setup({inputField	 : '".$key."_end_',baseField    : 'element_2',button: '".$key."_end_',ifFormat: '%Y %e, %D',onSelect: selectDate});	</script>";              
        } else {
            echo "<input class=reg type=text name=".$key." id=".$key." value='".$value."'>";
        }
    }
    echo "</td></tr>";
}

function findek($table, $value){
    $sql = "SELECT * FROM ".$table." WHERE ".$table."_id = ".$value;
    $res = dbHelp::mysql_query2($sql) or die ($sql); //mysql_error().$sql);
    $row = dbHelp::mysql_fetch_row2($res);
    return $row[1];
}

function datetime($field){
    $db = dbHelp::getDatabase();
    dbHelp::mysql_select_db2('information_schema');
    $sql = "SELECT data_type FROM columns WHERE (data_type LIKE 'datetime' OR data_type LIKE 'date') AND column_name = '".$field."' AND table_schema='".$db."'";
    $res = dbHelp::mysql_query2($sql);
    $row = dbHelp::mysql_fetch_row2($res);
    dbHelp::mysql_select_db2($db);
    return $row[0];   
}

function pages($numrows, $n, $limit, $order, $table, $page, $col, $user_id){
    $pages = intval($numrows / $n); //total number of pages
    
    if ($numrows % $n) {
    $pages++;} // has remainder so add one page
    
    if (!($page)){
         $page = 0;} // Default page value.
    
    $current = ($page/$n) + 1; // Current page number
    
    if (($pages < 1) || ($pages == 0)) { // If $pages is less than one or equal to 0, total pages is 1
        $total = 1;
    } else { // Else total pages is $pages value
        $total = $pages;
    } 
    
    $first = $page + 1; // The first result.
    
    if (!((($page + $n) / $n) >= $pages) && $pages != 1) {//If not last results page, last result equals $page plus $limit.
        $last = $page + $n;
    } else{ // If last results page, last result equals total number of results.
        $last = $numrows;
    } 
    
    echo "<table align=center border=0 cellspacing='25'>";
    echo "<tr><td align=left>";
    echo "Results ".$first." - ".$last." of ".$numrows;
    echo "</td>";
    echo "<td>";
    if ($page != 0) { // Don't show back link if current page is first page.
        $back_page = $page - $limit;
        echo("<a href=# onclick=\"javascript:getValues('".$table."','".$order."','".$col."', '".$back_page."', '".$limit."', '".$_GET['userid']."')\">back</a>    \n");
    }
    
    if($pages > 20){
	for ($i=1; $i <= 3; $i++){ // loop through each page and give link to it.
	 $ppage = $n*($i - 1);
	 if ($ppage == $page){
	 echo("<b>$i</b>\n");} // If current page don't give link, just text.
	 else{
	 echo("<a href=# onclick=\"javascript:getValues('".$table."','".$order."','".$col."', '".$ppage."', '".$limit."', '".$_GET['userid']."')\">$i</a> \n");}
	}
	echo "... ";
	for($i=4; $i <= $pages-3; $i++){
	    $ppage = $n*($i - 1);
	    if ($ppage == $page){// If current page don't give link, just text.
		echo("<b>$i</b>\n");
		echo " ... ";
	    } 
	    else{
	    }
	}
	
	for ($i=$pages-2; $i <= $pages; $i++){ // loop through each page and give link to it.
	 $ppage = $n*($i - 1);
	 if ($ppage == $page){
	 echo("<b>$i</b>\n");} // If current page don't give link, just text.
	 else{
	 echo("<a href=# onclick=\"javascript:getValues('".$table."','".$order."','".$col."', '".$ppage."', '".$limit."', '".$_GET['userid']."')\">$i</a> \n");}
	}
    }else{
	for ($i=1; $i <= $pages; $i++){ // loop through each page and give link to it.
	    $ppage = $n*($i - 1);
	    if ($ppage == $page){
	    echo("<b>$i</b>\n");} // If current page don't give link, just text.
	    else{
	    echo("<a href=# onclick=\"javascript:getValues('".$table."','".$order."','".$col."', '".$ppage."', '".$limit."', '".$_GET['userid']."')\">$i</a> \n");}
	}
	
    }
    if (!((($page+$n) / $n) >= $pages) && $pages != 1) { // If last page don't give next link.
    $next_page = $page + $n;
    echo("    <a href=# onclick=\"javascript:getValues('".$table."','".$order."','".$col."', '".$next_page."', '".$limit."', '".$_GET['userid']."')\">next</a>");}
    
    echo "</td>";
    echo "<td align=center>Page ".$current." of ".$total;
    echo "</td>";
    echo "</tr>";
    echo "</table>";

}



?>