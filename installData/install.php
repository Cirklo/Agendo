<?php
	session_start();

	if(isset($_POST['functionName'])){
		call_user_func($_POST['functionName']);
		exit;
	}

	echo "<script type='text/javascript' src='../js/jquery-1.5.2.min.js'></script>";
	echo "<script type='text/javascript' src='install.js'></script>";
	echo "<link href='install.css' rel='stylesheet' type='text/css'>";

	// ************************* Get pdo_mysql version ************************************
	ob_start ();
	phpinfo();
	$all = trim(ob_get_contents());
	ob_end_clean();

	$begin = 'PDO Driver for MySQL';
	$end = "</table>";
	$subString = getInBetweenText($all, $begin, $end);
	
	$begin = '<td class="v">';
	$end = "</td></tr>";
	$pdoMySqlVersion = getInBetweenText($subString, $begin, $end);
	// phpinfo();
	
	$begin = 'PDO Driver for PostgreSQL';
	$end = "</table>";
	$subString = getInBetweenText($all, $begin, $end);
	
	$begin = '<td class="v">';
	$end = "</td></tr>";
	$pdoPostgreSqlVersion = getInBetweenText($subString, $begin, $end);
	// *************************************************************

	if (!is_readable(getcwd()) || !is_writable(getcwd())) {
		echo "You don't have the proper read/write file permissions!'";
		exit;
	}
	echo "<table id='software'>";
		echo "<tr>";
			echo "<td align='center' valign='bottom'>";
			echo "<label>";
				echo "<img width=200 src='agendo.png' />";
				echo "<br><input type='radio' name='package' id='agendo' />";
			echo "</label>";
			echo "</td>";

			echo "<td align='center' valign='bottom'>";
			echo "<label>";
				echo "<img height=150 src='datumo.png' />";
				echo "<br><input type='radio' name='package' id='datumo' />";
			echo "</label>";
			echo "</td>";
		echo "</tr>";
	echo "</table>";
	
	$fail = false;
	// htconnect data	
	echo "<table id='htConnectTable'>";
		echo "<tr>";
			echo "<td colspan=2>";
			echo "<label id='readAndWrite'>Reading and writting permissions</label>";
			echo "</td>";
			$readAndWriteCheck = is_readable(getcwd()) && is_writable(getcwd());
			checkOrCross('readAndWrite', $readAndWriteCheck, 'Don\'t have read and write permissions.');
			if(!$readAndWriteCheck){
				$fail = true;
			}
		echo "</tr>";
	
		echo "<tr>";
			echo "<td>";
			echo "<label id='phpVersionLabel'>Php version is: </label>";
			echo "</td>";
			
			echo "<td >";
			echo "<label id='phpVersionLabelNumber'>".phpversion()."</label>";
			echo "</td >";
			
			$phpChecks = version_compare(phpversion(), '5.3.1', '>=');
			checkOrCross('phpVersion',$phpChecks, 'Need a more recent version to proceed');
			if(!$phpChecks){
				$fail = true;
			}
		echo "</tr>";
	
		echo "<tr>";
			echo "<td>";
			echo "<label id='pdoMysqlVersionLabel'>Pdo Mysql version is: </label>";
			echo "</td>";
			
			echo "<td>";
			echo "<label id='pdoMysqlVersionLabelNumber'>".$pdoMySqlVersion."</label>";
			echo "</td>";
			
			$mysqlChecks = version_compare($pdoMySqlVersion, '5.1.41', '>=');
			checkOrCross('pdoMysqlVersion', $mysqlChecks, 'Wrong Version');
			if($mysqlChecks){
				$engineArray[] = 'MySql';
			}
		echo "</tr>";

		echo "<tr>";
			echo "<td>";
			echo "<label id='pdoPostgreVersionLabel'>Pdo Postgre version is: </label>";
			echo "</td>";
			
			echo "<td>";
			echo "<label id='pdoPostgreVersionLabelNumber'>".$pdoPostgreSqlVersion."</label>";
			echo "</td>";
			
			$postgreChecks = version_compare($pdoPostgreSqlVersion, '8.4.1', '>=');
			checkOrCross('pdoPostgreVersion', $postgreChecks, 'Wrong Version');
			if($postgreChecks){
				$engineArray[] = 'PgSql';
			}
		echo "</tr>";

		echo "<tr>";
			if(sizeOf($engineArray) > 0){
				echo "<td>";
				echo "<label id='dbEngineLabel'>Database engine:</label>";
				echo "</td>";
				
				echo "<td>";
				echo "<select id='dbEngine'>";
				foreach($engineArray as $engineItem){
					echo "<option value='".strtolower($engineItem)."'>".$engineItem."</option>";
				}
				echo "</select>";
				echo "</td>";
			}
			else{
				echo "<td>";
				echo "No available database engine detected.";
				$fail = true;
				echo "<td>";
				exit;
			}
		echo "</tr>";
		
		echo "<tr>";
			labelInputText('dbName', 'Database name:', 'delmeplz');
		echo "</tr>";
		
		echo "<tr>";
			labelInputText('dbUser', 'Database username:', 'root');
		echo "</tr>";
		
		echo "<tr>";
			labelInputText('dbPass', 'Database password:', '');
		echo "</tr>";
		
		echo "<tr>";
			labelInputText('path', 'Destination path:', 'path');
		echo "</tr>";
		
		echo "<tr>";
			echo "<td align='center' colspan=2>";
				echo "<input id='makeDB'		type='checkbox' checked >Check to create database<P>";
			echo "</td>";
		echo "</tr>";
		
		echo "<tr>";
			echo "<td align='center' colspan=2>";
			$disabledCode = '';
				if($fail)
					$disabledCode = 'disabled';
				echo "<input id='makeHtConnect' type='button' 	value='MakeHtconnect' ".$disabledCode." onclick=postMe(this.id)></input>";
			echo "</td>";
		echo "</tr>";
		
	echo "</table>";


	// data to put in the database
	echo "<table id='databaseData' style='display:none'>";
		echo "<tr>";
			labelInputText('institute', 'Institute\'s name: ', 'institute');
			labelInputText('adminId', 'Administrator\'s login: ', 'adminId');
		echo "</tr>";

		echo "<tr>";
			labelInputText('instituteShort', 'Institute\'s short name: ', 'instituteShort');
			labelInputText('adminPass', 'Administrator\'s password: ', 'adminPass');
		echo "</tr>";

		echo "<tr>";
			labelInputText('instituteUrl', 'Institute\'s url: ', 'instituteUrl');
			labelInputText('adminFirst', 'Administrator\'s first name: ', 'adminFirst');
		echo "</tr>";

		echo "<tr>";
			labelInputText('instituteMail', 'Institute\'s email: ', 'instituteMail');
			labelInputText('adminLast', 'Administrator\'s last name: ', 'adminLast');
		echo "</tr>";

		echo "<tr>";
			labelInputText('institutePass', 'Institute\'s email password: ', 'institutePass');
			labelInputText('adminPhone', 'Administrator\'s phone number: ', 'adminPhone');
		echo "</tr>";

		echo "<tr>";
			labelInputText('instituteHost', 'Institute\'s email host: ', 'instituteHost');
			labelInputText('adminExt', 'Administrator\'s phone extension: ', 'adminExt');
		echo "</tr>";

		echo "<tr>";
			labelInputText('institutePort', 'Institute\'s email port: ', 'institutePort');
			labelInputText('adminMobile', 'Administrator\'s mobile phone: ', 'adminMobile');
		echo "</tr>";

		echo "<tr>";
			echo "<td>";
			echo "<label>Institute's country: </label>";
			echo "</td>";
			
			echo "<td>";
			echo "<select id='countries' onclick='getCountry(this.value)'>";
			echo "</select>";
			echo "</td>";
			labelInputText('adminMail', 'Administrator\'s email: ', 'adminMail');
		echo "</tr>";

		echo "<tr>";
			labelInputText('instituteAddress', 'Institute\'s adress: ', 'instituteAddress');
		echo "</tr>";
		
		echo "<tr>";
			labelInputText('institutePhone', 'Institute\'s phone number: ', 123123);
		echo "</tr>";

		echo "<tr>";
			labelInputText('instituteVat', 'Institute\'s Vat: ', 20);
		echo "</tr>";
		
		echo "<tr>";
			labelInputText('department', 'Department: ', 'department');
		echo "</tr>";
		
		echo "<tr>";
			echo "<td align='center' colspan=4>";
				echo "<label id='successError'>Success or error messages here.</label>";
			echo "</td>";
		echo "</tr>";

		echo "<tr>";
			echo "<td align='center' colspan=2>";
				echo "<input id='applySql'			type='button'	value='Apply Sql'	onclick=postMe(this.id)></input>";
			echo "</td>";
			
			echo "<td align='center' colspan=2>";
				echo "<input id='back'				type='button'	value='Back' 		onclick=back()></input>";
			echo "</td>";
		echo "</tr>";
	echo "</table>";

	// Gets current path and adds the previous path to create the htconnect file
	function makeHtConnect(){
		$msg = "true\nSuccessfully created the '.htconnect.php' file.";
		$dataArray = $_POST['data'];
		
		// getting upper level path
		$fullPath = explode('\\',getcwd());
		$path = $fullPath[0];
		for($i = 1; $i< sizeof($fullPath)-2; $i++)
			$path = $path.'/'.$fullPath[$i];
		
		$dbEngine =		$dataArray[0];
		$dbName = 		$dataArray[1];
		$dbUser = 		$dataArray[2];
		$dbPass =		$dataArray[3];
		$path = 		$path.'/'.$dataArray[4];
		$makeDB = 		(boolean)$dataArray[5];

		if(!is_dir($path) && !mkdir($path)){
			$msg = "false\nWasn't able to create '".$path."' folder.";
		}
		else if(($fileData = file_get_contents(getcwd().'/.htconnect.php')) != false){
			$fileData = str_replace('engineMarker',$dbEngine,$fileData);
			wtlog('Engine marker replaced successfully');
			$fileData = str_replace('databaseMarker',$dbName,$fileData);
			wtlog('Database marker replaced successfully','a');
			$fileData = str_replace('usernameMarker',$dbUser,$fileData);
			wtlog('Username marker replaced successfully','a');
			$fileData = str_replace('passwordMarker',$dbPass,$fileData);
			wtlog('Password marker replaced successfully','a');
			$fileData = str_replace('schemaMarker',$dbName,$fileData);
			wtlog('Schema marker replaced successfully','a');
	
			// create the .htconnect file and use it to connect
			$filename = '.htconnect.php';
			if(!file_put_contents($path."/".$filename, $fileData) || !copy(($filename = 'indexDatumo.php'), $path."/index.php")){
				$msg = "false\nCouldn't create the ".$filename." file in '".$path."'.";
			}
			else{
				try{
					$_SESSION['path'] = $path;
					require_once("../commonCode.php");
					
					dbHelp::setConnect($makeDB);
					if(($sql = file_get_contents(getcwd().'/DatumoBase.sql')) != false){
						$tableMsg = tablesAlreadyExist($sql, "");
						if($tableMsg == ''){
							// imports part of the database
							dbHelp::scriptRead($sql, "Successfully created the '.htconnect.php' file.");
							// gets the data in countries table and sends it to javascript via msg
							$sql = "select country_id, country_name from country";
							$res = dbHelp::mysql_query2($sql);
							while($arr = dbHelp::mysql_fetch_row2($res))
								$msg = $msg."\n".$arr[0]."\n".$arr[1];
						}
						else
							$msg = "false\nTable ".$tableMsg." already exists.";
					}
					else
						$msg = "false\Wasn't able to open 'DatumoBase.sql'.";
				}
				catch(Exception $e){
					$msg = "false\n".$e;
				}
			}
		}
		else{
			$msg = "false\nWasn't able to create/find the '.htconnect.php'";
		}
		echo $msg;
		$log = explode('\n',$msg);
		wtlog($log[1],'a');
	}
	
	// apply the sql script
	function applySql(){
		$dataArray = $_POST['data'];
		if(!isset($dataArray[21])){
			$adminId = 		$dataArray[0];
			$adminPass = 	$dataArray[1];
			$adminFirst = 	$dataArray[2];
			$adminLast = 	$dataArray[3];
			$adminPhone = 	$dataArray[4];
			$adminExt = 	$dataArray[5];
			$adminMobile = 	$dataArray[6];
			$adminMail = 	$dataArray[7];
			
			$institute = 		$dataArray[8];
			$instituteShort = 	$dataArray[9];
			$instituteUrl = 	$dataArray[10];
			$instituteMail = 	$dataArray[11];
			$institutePass = 	$dataArray[12];
			$instituteHost = 	$dataArray[13];
			$institutePort = 	$dataArray[14];
			$instituteAdress = 	$dataArray[15];
			$institutePhone = 	$dataArray[16];
			$instituteVat = 	$dataArray[17];
			$instituteCountry = $dataArray[18];
			$department = 		$dataArray[19];

			$software =		$dataArray[20]; // fazer algo com esta var
			// $applySql = 	$dataArray[15];
			// $makeDB = 		(boolean)$dataArray[16];
			// $dbName = 		$dataArray[17];
			
			// $_SESSION['path'] = $dataArray[18];
			require_once("../commonCode.php");
			$datumoConstraintsFile = 'DatumoConstraints.sql';
			$datumoTriggersFile = 'DatumoTriggers.sql';
			$currentFile = $datumoConstraintsFile;
			$finishedSuccess = "Successfully imported all database settings.";
			if(($sqlDatumoConstraints = file_get_contents(getcwd().'/'.$currentFile)) != false && ($sqlDatumoTriggers = file_get_contents(getcwd().'/'.($currentFile = $datumoTriggersFile))) != false){
				try{
					$sql = "INSERT INTO `user` (`user_id`, `user_login`, `user_passwd`, `user_firstname`, `user_lastname`, `user_dep`, `user_phone`, `user_phonext`, `user_mobile`, `user_email`, `user_alert`, `user_level`) VALUES
							(1, '".$adminId."', '".cryptPassword($adminPass)."', '".$adminFirst."', '".$adminLast."', 1, '".$adminPhone."', '".$adminExt."', '".$adminMobile."', '".$adminMail."', 1, 0)";
					dbHelp::mysql_query2($sql);	
					
					$sql = "INSERT INTO `institute` (`institute_id`, `institute_name`, `institute_address`, `institute_phone`, `institute_country`, `institute_vat`) VALUES
							(1, '".$institute."', '".$instituteAdress."', ".$institutePhone.", ".$instituteCountry.", ".$instituteVat.")";
					dbHelp::mysql_query2($sql);	
					
					$sql = "INSERT INTO `department` (`department_id`, `department_name`, `department_inst`, `department_manager`) VALUES
							(1, '".$department."', 1, 1)";
					dbHelp::mysql_query2($sql);	
					
					$sql = "INSERT INTO `configparams` (`configParams_id`, `configParams_name`, `configParams_value`) VALUES
							(0, 'institute', '".$institute."'),
							(1, 'shortname', '".$instituteShort."'),
							(2, 'url', '".$instituteUrl."'),
							(3, 'secureresources', '0'),
							(4, 'host', '".$instituteHost."'),
							(5, 'port', '".(int)$institutePort."'),
							(6, 'password', '".$institutePass."'),
							(7, 'email', '".$instituteMail."'),
							(8, 'smtpsecure', 'stmp'),
							(9, 'smtpauth', '1')";
					dbHelp::mysql_query2($sql);	
				}
				catch(Exception $e){
					echo $e;
					wtlog($e,'a');
					return;
				}
				
				$datumoError = "Failed to import Datumo constraint settings.";
				if(($msg = loadTriggers($sqlDatumoTriggers, $finishedSuccess)) == '' && ($msg = dbHelp::scriptRead($sqlDatumoConstraints, $finishedSuccess, $datumoError)) == '')
					$msg = $finishedSuccess;

				if(!copy(($filename = 'indexAgendo.php'), $_SESSION['path']."/index.php"))
					$msg = "Couldn't create the index.php file in '".$_SESSION['path']."'.";
					
				$msg = copyFolderTo('pics', $_SESSION['path']."/pics", $finishedSuccess, "Couldn't copy the pics folder.");
					
				if($msg == $finishedSuccess && $software == "agendo"){
					$agendoBaseFile = 'AgendoBase.sql';
					$agendoConstraintsFile = 'AgendoConstraints.sql';
					$agendoTriggersFile = 'AgendoTriggers.sql';
					$currentFile = $agendoBaseFile;
					if(($sqlAgendo = file_get_contents(getcwd()."/".$currentFile)) != false && 
						($sqlAgendoContraints = file_get_contents(getcwd()."/".($currentFile = $agendoConstraintsFile))) != false &&
						($sqlAgendoTriggers = file_get_contents(getcwd()."/".($currentFile = $agendoTriggersFile))) != false){
						// if($sqlAgendoContraints = file_get_contents(getcwd().'/AgendoConstraints.sql')){
							$msg = tablesAlreadyExist($sqlAgendo, $finishedSuccess);
							if($msg == $finishedSuccess){
								$msg = dbHelp::scriptRead($sqlAgendo, $finishedSuccess, "Failed to import Agendo base settings.");
								if($msg == $finishedSuccess)
									$msg = dbHelp::scriptRead($sqlAgendoContraints, $finishedSuccess, "Failed to import Agendo constraint settings.");
								if($msg == $finishedSuccess)
									$msg = loadTriggers($sqlAgendoTriggers, $finishedSuccess, "Failed to import Agendo trigger settings.");
							}
							else
								$msg = "Table ".$msg." already exists.";
						// }
						// else
							// $msg = "Failed to open AgendoConstraints.sql";
					}
					else
						$msg = "Failed to open ".$currentFile.".";
				}
			}
			else
				$msg = "Failed to open ".$currentFile.".";
		}
		else
			$msg = "Please fill all fields.";
		
		if($msg == $finishedSuccess){
			$fullPath = explode('/',$_SESSION['path']);
			$path = $fullPath[sizeOf($fullPath)-1];
			$msg = $msg."<br><a href='../../".$path."/index.php?class=0'>Your page</a>";
		}
		echo $msg;
		wtlog($msg,'a');
	}
	
	function checkOrCross($id, $isChecked, $errorMsg, $imageSize=20, $errorMsgWidth=300){
		echo "<td style='width:".$imageSize."px'>";
			if ($isChecked) {
				echo "<img id='".$id."Img' src='checked.png' 	width='".$imageSize."px' alt='Checks' />";
			}
			else{
				echo "<img id='".$id."Img' src='cross.png' 		width='".$imageSize."px' alt='Error' />";
				echo "</td>";
				
				echo "<td align='center' style='width:".$errorMsgWidth."'>";
				echo $errorMsg;
			}
		echo "</td>";
	}
	
	function labelInputText($id, $label, $defaultText){
			echo "<td>";
			echo "<label id='".$id."Label'>".$label."</label>";
			echo "</td>";
			
			echo "<td>";
			echo "<input id='".$id."' type='text' value='".$defaultText."' ></input>";
			echo "</td>";
	}
	
	function wtlog($string, $mode = "w"){
		$fh = fopen(getcwd().'/log.txt', $mode) or die("Can't open/create file!");
		fwrite($fh, $string."\n");
		fclose($fh);
	}
	
	function tablesAlreadyExist($sql, $success = "success"){
		$msg = $success;
		$sqlTables = getBetweenArray($sql, 'CREATE TABLE IF NOT EXISTS', '(');
		for($i = 0; $i<sizeOf($sqlTables); $i++){
			try{
				dbHelp::mysql_query2("select * from ".$sqlTables[$i]);
				return $sqlTables[$i];
			}
			catch(PDOException $e){
				// $msg =  $e;
			}
		}
		return $msg;
	}
	
	function getInBetweenText($all, $begin, $end = ''){
		if(($positionBegin = stripos($all, $begin)) !== false){
			$positionBegin = $positionBegin + strlen($begin);
			if($end != ''){
				if(($positionEnd = stripos($all, $end, $positionBegin)) !== false){
					return trim(substr($all, $positionBegin, $positionEnd-$positionBegin));
				}
			}
			else
				return trim(substr($all, $positionBegin));
		}
		return false;
	}

	// drops and inserts triggers from the text of a script
	// doesnt need to have the drop trigger command in that script
	function loadTriggers($sql, $success = "success", $error = "error"){
		$msg = $success;
		
		try{
			$triggers = getBetweenArray($sql, "DELIMITER //", "//", 'IRSEPARATOR');
			for($i=0;$i<sizeOf($triggers);$i++){
				$trigerName = getBetweenText($triggers[$i], 'CREATE TRIGGER ', ' AFTER INSERT ON');
				// drops current trigger
				dbHelp::mysql_query2("DROP TRIGGER IF EXISTS ".$trigerName);
				// inserts current trigger
				dbHelp::mysql_query2($triggers[$i]);
			}
		}
		catch(Exception $e){
			$msg = $error."\n".$e;
		}
		
		return $msg;
	}
	
	function copyFolderTo($sourceFolder, $destinationFolder, $success = "success", $error = "error"){
		$msg = $success;

		if(!is_dir($sourceFolder))
			$msg = "Source directory doesn't exist.";
		else if(!is_dir($destinationFolder) && !mkdir($destinationFolder))
			$msg = $error;
		else{
			$dir = dir($sourceFolder);
			//List files in images directory
			while (($file = $dir->read()) !== false)
			{
				if($file == '.' || $file == '..')
					continue;
				copy($sourceFolder."/".$file, $destinationFolder."/".$file );
			}
			$dir->close();
		}
		
		return $msg;
	}
	
?>