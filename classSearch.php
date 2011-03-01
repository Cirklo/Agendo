<?php

class quickSearch {

   function checkSearch($table,$i){
       $sql = "SELECT search_query FROM search WHERE search_table LIKE '$table'";
       $res = dbHelp::mysql_query2($sql) or die ($sql); //mysql_error());
       $nrows = dbHelp::mysql_numrows2($res);
       if($nrows == 0){ //no search query
           //do nothing
       } else {
           echo "<b>Search</b>&nbsp;&nbsp;";
           echo "<form name=qsearchform$i method=post>";
           echo "<input type=text class=reg name=qsearch id=qsearch>&nbsp;&nbsp;<input type=image src=pics/magnifier.png onclick=\"javascript:quicksearch('$table',$i);\">";
           echo "</form>";
       }
   }
}


?>