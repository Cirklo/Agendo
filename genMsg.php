<?php


class genMsg {
	
	function announcement ($resource){
		$sql = "SELECT announcement_date, announcement_title, announcement_message, announcement_end_date FROM announcement WHERE announcement_object=$resource AND announcement_end_date>now()";
		$res = mysql_query($sql) or die (mysql_error().$sql);
		if(mysql_num_rows($res) > 0){
			while($row = mysql_fetch_array($res)){
				echo "<b>".$row[0]."</b>: ".$row[1]."<br>";
				echo $row[2]."<br>";
				echo "<b>Available until: </b>".$row[3]."<br><br>";
			}
		} else {
			echo "No announcements for this resource!";
		}
	}

}


?>