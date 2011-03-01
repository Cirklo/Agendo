<?php
	// require_once("commonCode.php");
	
	// $connect = new dbConnection();
	

	// $sql="select 1,resource_name,resource_id from resource order by resource_name";
	// $sql="select * from ".dbHelp::getSchemaName()."user";
	// $result = $connect->query($sql);
	// foreach($result as $row){
		// echo $row['resource_name'];
		// echo "<br></br>";
	// }
	
	// echo "<br></br>";
	
	// $prepSql = $connect->prepare($sql);
	// $exec = $prepSql->execute();
	// $count = $prepSql->rowCount();
	// for($i = 0; $i<$count; $i++){
		// $res = $prepSql->fetch(PDO::FETCH_NUM);
		// echo $res[1]."-".$count."-".$exec;
		// echo "<br></br>";
	// }
	// $db = dbHelp::database2(1);
	// dbHelp::mysql_select_db2("information_schema");
	// $sql = "SELECT table_name, column_name FROM KEY_COLUMN_USAGE WHERE TABLE_SCHEMA = '".$db."' AND REFERENCED_TABLE_NAME = '".$row[2]."'";
	// $sql = "insert into media values ('', 'bla', 'bla', 'bla')";
	// $sql = "SELECT EXTRACT(CENTURY FROM TIMESTAMP '2000-12-16 12:21:13')";
	// $res=dbHelp::mysql_query2($sql) or die ($sql);
	// for ($j=0;$j<dbHelp::mysql_numrows2($res);$j++) {
		// $arr=dbHelp::mysql_fetch_row2($res);
		// echo $arr[1];
		// echo "<br></br>";
	// }

	// $sql =  "select ".dbHelp::getFromDate('2011-02-17 15:34:34', '%H:%i');
	// "select date_format(entry_datetime,'%Y%m%d%H%i') date, entry_datetime,entry_slots,entry_user  from entry";
	// $sql = "select ".dbHelp::getFromDate('entry_datetime','%Y%m%d%H')." date, entry_datetime,entry_slots,entry_user  from entry";
	// $sql = "select ".dbHelp::getFromDate('entry_datetime','%Y%m%d%H%i')." date, entry_datetime,entry_slots,entry_user  from entry where entry_id=1";
	// $sql = "select ".dbHelp::getFromDate(dbHelp::date_sub('now()','1','day'),'%Y%m%d')." as date";
	
	// select date_format(entry_datetime,'%H')+ date_format(entry_datetime,'%i')/60 as time from
	// $sql = "select ".dbHelp::date_add(dbHelp::getFromDate('entry_datetime','%H', true), '2', 'hour')." from entry where entry_id = 1";
	
	// $sql = "select @d:= date_format(date_sub(entry_datetime,interval 1 day),'%Y%m%d'),  @wd:=date_format(@d,'%w'), date_format(date_sub(@d, interval @wd day),'%Y%m%d') as date, date_format(entry_datetime,'%h') + date_format(entry_datetime,'%i')/60 as starttime from entry where entry_id=1";
	
	// $sql = "select ".dbHelp::getFromDate('now()','%w');
	// echo $sql."<br></br>";
	// $res = dbHelp::mysql_query2($sql);
	// $arr = dbHelp::mysql_fetch_row2($res);

	// $sql = "select ".dbHelp::date_sub(dbHelp::convertDateStringToTimeStamp('198102101750','%Y%m%d%H%i'),'1','day');
	// $sql = "select ".dbHelp::date_sub('now()',$arr[0],'day');
	// $sql = "select entry_id from entry where ".dbHelp::getFromDate('entry_datetime','%H')." = '16'"; // funciona
	
	// $sql = "select ".dbHelp::getFromDate('now()','%Y%m%d')." = ".dbHelp::getFromDate('now()','%Y%m%d');
	// require_once("commonCode.php");
	require_once("__dbHelp.php");
	// require_once("__dbHelp2.php");
	// require_once(".htconnect.php");
				$time1 = microtime(true);
	// $connect = new dbConnection();
	// $sql = "select user_login,entry_id,entry_user,entry_repeat, entry_status,entry_slots from entry,dbtest.user where entry_status<>3 and entry_resource=1 and user_id=entry_user and to_char(entry_datetime, 'YYYYMMDD')='20110221' and to_char(entry_datetime, 'HH24MI')='1130' order by entry_id";
	// $sql = "select user_login,entry_id,entry_user,entry_repeat, entry_status,entry_slots from entry,dbtest.user where entry_status<>3 and entry_resource=1 and user_id=entry_user and date_format(entry_datetime, '%Y%m%d')='20110227' and date_format(entry_datetime, '%H%i')='2130' order by entry_id";
	// echo $sql."<br></br>";
	// $res = dbHelp::mysql_query2($sql);
	// $arr = dbHelp::mysql_fetch_row2($res);
				// echo microtime(true)-$time1."<br></br>";
				// $time1 = microtime(true);
	// $sql = "select user_login,entry_id,entry_user,entry_repeat, entry_status,entry_slots from entry,dbtest.user where entry_status<>3 and entry_resource=1 and user_id=entry_user and to_char(entry_datetime, 'YYYYMMDD')='20110221' and to_char(entry_datetime, 'HH24MI')='1130' order by entry_id";
	// echo $sql."<br></br>";
	// $res = dbHelp::mysql_query2($sql);
	// $arr = dbHelp::mysql_fetch_row2($res);
				// echo microtime(true)-$time1."<br></br>";
	// $res = $connect->query($sql);
	// $arr = $res->fetch();
	// $res = query($sql);
	// $arr = fetch($res);
	
	$sql2 = "select date_format(entry_datetime, '%w') from entry where entry_id=611";
	echo $sql2."<br></br>";
	$res2 = dbHelp::mysql_query2($sql2);
	$arr2 = dbHelp::mysql_fetch_row2($res2);
	echo $arr2[0]."<br></br>";
	
?>