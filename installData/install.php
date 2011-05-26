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
	$subString = getBetween($all, $begin, $end);
	
	$begin = '<td class="v">';
	$end = "</td></tr>";
	$pdoMySqlVersion = getBetween($subString, $begin, $end);
	// phpinfo();
	
	$begin = 'PDO Driver for PostgreSQL';
	$end = "</table>";
	$subString = getBetween($all, $begin, $end);
	
	$begin = '<td class="v">';
	$end = "</td></tr>";
	$pdoPostgreSqlVersion = getBetween($subString, $begin, $end);
	// *************************************************************

	$fail = false;
	// htconnect data	
	echo "<table id='htConnectTable'>";
	
	if (!is_readable(getcwd()) || !is_writable(getcwd())) {
		echo "Don't have the proper read/write file permissions!'";
		exit;
	}
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
				
			// labelInputText('dbEngine', 'Engine', 'mysql');
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
			$disabledCode = '';
				if($fail)
					$disabledCode = 'disabled';
				echo "<input id='makeHtConnect' type='button' 	value='MakeHtconnect' ".$disabledCode." onclick=postMe(this.id)></input>";
			echo "</td>";
		echo "</tr>";
		
		echo "<tr>";
			echo "<td align='center' colspan=2>";
				echo "<input id='makeDB'		type='checkbox' checked >Check to create database<P>";
			echo "</td>";
		echo "</tr>";
		
	echo "</table>";


	// data to put in the database
	echo "<table id='databaseData' style='display:none'>";
	
		echo "<tr>";
			labelInputText('adminId', 'Administrator\'s login: ', 'adminId');
		echo "</tr>";

		echo "<tr>";
			labelInputText('adminPass', 'Administrator\'s password: ', 'adminPass');
		echo "</tr>";

		echo "<tr>";
			labelInputText('adminFirst', 'Administrator\'s first name: ', 'adminFirst');
		echo "</tr>";

		echo "<tr>";
			labelInputText('adminLast', 'Administrator\'s last name: ', 'adminLast');
		echo "</tr>";

		echo "<tr>";
			labelInputText('adminPhone', 'Administrator\'s phone number: ', 'adminPhone');
		echo "</tr>";

		echo "<tr>";
			labelInputText('adminExt', 'Administrator\'s phone extension: ', 'adminExt');
		echo "</tr>";

		echo "<tr>";
			labelInputText('adminMobile', 'Administrator\'s mobile phone: ', 'adminMobile');
		echo "</tr>";

		echo "<tr>";
			labelInputText('adminMail', 'Administrator\'s email: ', 'adminMail');
		echo "</tr>";

		// institute data
		echo "<tr>";
			labelInputText('institute', 'Institute\'s name: ', 'institute');
		echo "</tr>";

		echo "<tr>";
			labelInputText('instituteShort', 'Institute\'s short name: ', 'instituteShort');
		echo "</tr>";

		echo "<tr>";
			labelInputText('instituteUrl', 'Institute\'s url: ', 'instituteUrl');
		echo "</tr>";

		echo "<tr>";
			labelInputText('instituteMail', 'Institute\'s email: ', 'instituteMail');
		echo "</tr>";

		echo "<tr>";
			labelInputText('institutePass', 'Institute\'s email password: ', 'institutePass');
		echo "</tr>";

		echo "<tr>";
			labelInputText('instituteHost', 'Institute\'s email host: ', 'instituteHost');
		echo "</tr>";

		echo "<tr>";
			labelInputText('institutePort', 'Institute\'s email port: ', 'institutePort');
		echo "</tr>";

		echo "<tr>";
			echo "<td colspan=2>";
				echo "<label id='successError'>Success or error messages here.</label>";
			echo "</td>";
		echo "</tr>";

		echo "<tr>";
			echo "<td align='center'>";
				echo "<input id='applySql'			type='button'	value='Apply Sql'	onclick=postMe(this.id)></input>";
			echo "</td>";
			
			echo "<td align='center'>";
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
		for($i = 1; $i< sizeof($fullPath)-1; $i++)
			$path = $path.'/'.$fullPath[$i];
		
		$dbEngine = $dataArray[0];
		$dbName = 	$dataArray[1];
		$dbUser = 	$dataArray[2];
		$dbPass =	$dataArray[3];
		$path = $path.'/'.$dataArray[4];

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
			$path = $path.'/.htconnect.php';
			if(!file_put_contents($path, $fileData)){
				$msg = "false\nCouldn't create the file '".$path."'.";
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
		$fullPath = explode('\\',getcwd());
		$path = $fullPath[0];
		for($i = 1; $i< sizeof($fullPath)-1; $i++)
			$path = $path.'/'.$fullPath[$i];
		
		$dataArray = $_POST['data'];
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

		$applySql = 	$dataArray[15];
		$makeDB = 		(boolean)$dataArray[16];
		$dbName = 		$dataArray[17];
		
		$_SESSION['path'] = $dataArray[18];
		require_once("../commonCode.php");

		dbHelp::setConnect($makeDB);

		if(($sql = file_get_contents(getcwd().'/_dbtestMySqlCreation.sql')) != false){
			
			// Admin data
			$sql = str_replace('adminMarker',$adminId,$sql);
			wtlog('Admin marker replaced successfully','a');
			$sql = str_replace('adminPassMarker',cryptPassword($adminPass),$sql);
			wtlog("Admin's pass marker replaced successfully",'a');
			$sql = str_replace('adminFirstMarker',$adminFirst,$sql);
			wtlog('Admin first name marker replaced successfully','a');
			$sql = str_replace('adminLastMarker',$adminLast,$sql);
			wtlog('Admin last name marker replaced successfully','a');
			$sql = str_replace('adminPhoneMarker',$adminPhone,$sql);
			wtlog('Admin phone marker replaced successfully','a');
			$sql = str_replace('adminExtMarker',$adminExt,$sql);
			wtlog('Admin extension marker replaced successfully','a');
			$sql = str_replace('adminMobileMarker',$adminMobile,$sql);
			wtlog('Admin mobile marker replaced successfully','a');
			$sql = str_replace('adminMailMarker',$adminMail,$sql);
			wtlog('Admin email marker replaced successfully','a');

			// Institute data
			$sql = str_replace('instituteMarker',$institute,$sql);
			wtlog('Institute marker replaced successfully','a');
			$sql = str_replace('instituteShortMarker',$instituteShort,$sql);
			wtlog('Institute short name marker replaced successfully','a');
			$sql = str_replace('instituteUrlMarker',$instituteUrl,$sql);
			wtlog('Institute URL marker replaced successfully','a');
			$sql = str_replace('instituteMailMarker',$instituteMail,$sql);
			wtlog('Institute mail marker replaced successfully','a');
			$sql = str_replace('institutePassMarker',$institutePass,$sql);
			wtlog('Institute mail password marker replaced successfully','a');
			$sql = str_replace('instituteHostMarker',$instituteHost,$sql);
			wtlog('Institute mail host marker replaced successfully','a');
			$sql = str_replace('institutePortMarker',(int)$institutePort,$sql);
			wtlog('Institute mail port marker replaced successfully','a');

			$sqlTables = dbHelp::getTablesFromScript($sql, 'CREATE TABLE IF NOT EXISTS', '(');
			
			$tableAlreadyExists = false;
			for($i = 0; $i<sizeOf($sqlTables); $i++){
				try{
					dbHelp::mysql_query2("select * from ".$sqlTables[$i]);
					$tableAlreadyExists = true;
					break;
				}
				catch(PDOException $e){
					$msg =  $e;
				}
			}
			
			if(!$tableAlreadyExists)
				$msg = dbHelp::scriptRead($sql, "Successfully imported the database settings.");
			else
				$msg = "Tables already exist.";
		}
		else
			$msg = "Wasn't able to open '_dbtestMySqlCreation.sql'.";
			
		echo $msg;
		wtlog($msg,'a');
	}
	
	function getBetween($all, $begin, $end = ''){
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
?>