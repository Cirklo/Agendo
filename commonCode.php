<?php
/*
  @author Pedro Pires or the Chosen Two
  @copyright 2010-2011 Pedro Pires
  @license http://www.gnu.org/copyleft/lesser.html Distributed under the Lesser General Public License (LGPL)
  @version 1.0
  @Code used in lots of places and all joined in an artistic way to avoid copy pasting same methods in different places
*/

	session_start();
	// session_destroy();
	if(!isset($_SESSION['path']) || $_SESSION['path'] == ''){
		echo "No path defined";
		exit;
	}
		
	require_once("__dbHelp.php");
	
	function importJs(){
		echo "<script type='text/javascript' src='../agendo/js/jquery-1.5.2.min.js'></script>";
		echo "<script type='text/javascript' src='../agendo/js/commonCode.js'></script>";
		echo "<link type='text/css' href='../agendo/css/jquery.jnotify.css' rel='stylesheet' media='all' />";
		echo "<script type='text/javascript' src='../agendo/js/jquery.jnotify.js'></script>";
	}

	// function showError($errorMessage, $import = false){
		// if($import)
			// importJs();
		
	// }

	// if(isset($_GET['checkUserAndPass'])){
		// validUserAndPass($_GET['user'], $_GET['pass']);
		// exit;
	// }
		
	// Initializes the session, checks if it timesOut and if needsToBeLogged it doesnt allow the page where 
	// this function is to be entered without a user being logged in
	function initSession($needsToBeLogged=false){
		error_reporting(0);
		require_once("permClass.php");
        $maxNoActivity = 10*60; // Seconds of session duration of no activity
		$difference = (time() - $_SESSION['activeTime']);
		if(isset($_SESSION['user_id']) && $difference > $maxNoActivity && isset($_SESSION['activeTime'])){
			logOff();
		}
		else
			$_SESSION['activeTime'] = time();
			
		if($needsToBeLogged && (!isset($_SESSION['user_id']) || $_SESSION['user_id'] == ''))
			echo "<meta HTTP-EQUIV='REFRESH' content='0; url=./'>";
	}

	function logIn(){
		initSession();

		// $user=$_POST['user_idm'];
		$userLogin=$_POST['user_idm'];
		$pass=$_POST['user_passwd'];
		
		$resource=$_GET['resource'];
		$logOff=$_GET['logOff'];

		if(isset($logOff) && $logOff)
			logOff();


		if(isset($_SESSION['user_id']) && $_SESSION['user_id']!=''){
			
				if($_SESSION['database'] != dbHelp::getSchemaName()){
					logOff();
				}
					
				$sql= "select user_firstname, user_lastname, user_passwd from ".dbHelp::getSchemaName().".user where user_id = ".$_SESSION['user_id'];
				$res=dbHelp::mysql_query2($sql) or die ($sql);
				$arr=dbHelp::mysql_fetch_row2($res);
				$_SESSION['user_name'] = $arr[0];
				$_SESSION['user_lastName'] = $arr[1];
				
				if(!isset($_SESSION['user_pass']) || $_SESSION['user_pass']==''){
					$_SESSION['user_pass'] = $arr[2];
				}
			
				$pass = $_SESSION['user_pass'];
				$user = $_SESSION['user_id'];
			// }
		}
		else if (isset($userLogin) && isset($pass) && $pass !=''){
			$pass = cryptPassword($pass);
			$_SESSION['user_pass'] = $pass;
			$sql= "select user_firstname, user_lastname, user_id from ".dbHelp::getSchemaName().".user where user_login = '".$userLogin."'";
			$res=dbHelp::mysql_query2($sql) or die ($sql);
			$arr=dbHelp::mysql_fetch_row2($res);
			$_SESSION['user_name'] = $arr[0];
			$_SESSION['user_lastName'] = $arr[1];
			$_SESSION['user_id'] = $user = $arr[2];
			$_SESSION['database'] = dbHelp::getSchemaName();
		}
		else{
			return;
		}

		if (isset($resource)){
			$check = new permClass;
			if (!$check->setPermission($user,$resource,$pass)){
				logOff();
				echo "<h1>Wrong Login!</h1>";
				exit;
			}
			$_SESSION['logOff'] = null;
		}
		// exit;
		return;
	}

	function loggedInAs($phpFile, $resource){
		if(isset($_SESSION['user_name']) && $_SESSION['user_name']!=''){
			$textColor = 'white';
			$textColorHover = '#F7C439';
			$textSize = '12px';
			echo "<div align='right' valign='bottom'>";
			echo "<label style='background:;'><label style='font-size:".$textSize.";color:".$textColor."'>&nbsp;You are logged as </label><label style='font-size:".$textSize.";color:".$textColor."'>".$_SESSION['user_name']." ".$_SESSION['user_lastName']." | </label></label>";
			echo "<a style='font-size:".$textSize.";cursor:pointer;color:".$textColor."' onmouseover=\"this.style.color='".$textColorHover."'\" onmouseout=\"this.style.color='".$textColor."'\" title='Click here to logoff' onclick=logOff('".$phpFile."',".$resource.")> Logoff</a>";
			// echo "&nbsp;<input type='button' style='font-size:11px' value='LogOff' onclick=logOff('".$phpFile."',".$resource.")></input>";
			echo "</div>";
		}
	}
	
	function validUserAndPass($user, $pass, $passCrypted = false){
		if(!$passCrypted)
			$pass = cryptPassword($pass);

		$sql= "select user_id from ".dbHelp::getSchemaName().".user where user_login = '".$user."' and user_passwd = '".$pass."'";
		$res=dbHelp::mysql_query2($sql) or die ($sql);
		if(dbHelp::mysql_numrows2($res) <= 0)
			echo "Wrong Login";
		else{
			$arr=dbHelp::mysql_fetch_row2($res);
			$_SESSION['user_id'] = $arr[0];
			$_SESSION['user_pass'] = $pass;
			$_SESSION['database'] = dbHelp::getSchemaName();
			echo "";
		}
	}

	function logOff(){
		session_start();
		echo "<meta HTTP-EQUIV='REFRESH' content='0; url=./'>";
		session_destroy();
	}
	
	function cryptPassword($uncryptedPass){
	//admin
	//*B3580074E39C5F3D8A640E21295E2DC1098387F1
		// Current encrypting method
		// $sql="select password('". $uncryptedPass ."')";
		// $res=dbHelp::mysql_query2($sql);
		// $arrcheck=dbHelp::mysql_fetch_row2($res);
		// return $arrcheck[0];
		
	//admin
	//2127f97535023818d7add4a3c2428e06d382160daab440a9183690f18e285010
		// The future way to encrypt the password
		return hash('sha256', $uncryptedPass);
	}
	
	// Buttons for help, videos, resources and user/management
	function echoUserVideosResourceHelpLinks(){
		echo "<div id='linksImages'>";
			echo "<img style='cursor:pointer' width=30px id=help title='help' src=pics/ask.png onclick=\"javascript:window.open('https://github.com/Cirklo/Datumo-2.0/wiki/_pages','_blank','directories=no,status=no,menubar=yes,location=yes,resizable=yes,scrollbars=no,width=800,height=600')\" align='right'>";
			echo "<img style='cursor:pointer' width=30px id=video title='feature videos' src=pics/video.png onclick=go(this) align='right'>";
			echo "<img style='cursor:pointer' width=30px id=resources title='resource type' src=pics/resource.png onclick=go(this) align='right'>";
			echo "<img style='cursor:pointer' width=30px id=user title='user area' src=pics/user.png onclick=go(this) align='right'>";
		echo "</div>";
	}
	
	// Videos div
	function echoVideosDiv(){
		echo "<div id=videodiv align='center' style='cursor:pointer;padding:5px;display:none;position:absolute;width:150px;color:#444444;background-color:#FFFFFF;opacity:0.9;'>";
			$sql= "select media_name, media_link, media_description from media order by media_name";
			$res=dbHelp::mysql_query2($sql) or die ($sql);
			$vidWidth = 640;
			$vidHeight = 480;
			for ($i=0;$i<dbHelp::mysql_numrows2($res);$i++) {
				$arr=dbHelp::mysql_fetch_row2($res);
				echo "<a title='".$arr[2]."' onclick=\"javascript:window.open('".$arr[1]."','_blank','directories=no,status=no,menubar=yes,location=yes,resizable=yes,scrollbars=no,width=".$vidWidth.",height=".$vidHeight."')\">".$arr[0]."</a><br>";
			}
		echo "</div>";		
	}
	
	// Resources div
	function echoResourcesDiv(){
		echo "<div id=resourcesdiv  align='center' style='padding:5px;display:none;position:absolute;left:540px;width:250px;color:#444444;background-color:#FFFFFF;opacity:0.9'>\n";
			echo "<a href=index.php?class=0>All Resources</a><br>";
			echo "<a href=index.php>Most used</a>";
			echo "<hr>";
			$sql= "select * from resourcetype order by resourcetype_name";
			$res=dbHelp::mysql_query2($sql) or die ($sql);
			for ($i=0;$i<dbHelp::mysql_numrows2($res);$i++) {
				$arr=dbHelp::mysql_fetch_row2($res);
				echo "<a href=index.php?class=" .$arr[0] . ">" . $arr[1] . "</a><br>";
			}
		echo "</div>";
	}
	
	// User/management div
	function echoUserDiv($phpFile, $resource){
		// echo "<script type='text/javascript' src='../agendo/js/jquery-1.5.2.min.js'></script>";
		// echo "<script type='text/javascript' src='../agendo/js/commonCode.js'></script>";

		
		// Used only for the horrible patch/hack of the checkfields function in the weekview.js, more details on that file
		if($phpFile=='weekview')
			echo "<script type='text/javascript'> setUsingSession(false) </script>";
		// end
		
		$display = "table";
		echo "<div id=userdiv align='center' style='display:none;width:auto;position:absolute;color:#444444;background-color:#FFFFFF;opacity:0.9;padding:5px'>";
			echo "<form name=edituser id=edituser method=post>";
				if(isset($_SESSION['user_id'])){
					$display = "none";
					
					$sql= "select user_login, user_firstname, user_lastname, user_passwd from user where user_id = ".$_SESSION['user_id'];
					$res=dbHelp::mysql_query2($sql) or die ($sql);
					$arr=dbHelp::mysql_fetch_row2($res);
					$user_login = $arr[0];
					$user_firstname = $arr[1];
					$user_lastname = $arr[2];
					$user_pass = $_SESSION['user_pass'] = $arr[3];

					// Used only for the horrible patch/hack of the checkfields function in the weekview.js, more details on that file
					if($phpFile=='weekview')
						echo "<script type='text/javascript'> setUsingSession(true) </script>";
					// end
					
					echo "<table>";
						echo "<tr>";
							echo "<td><label>Logged as: \"".$_SESSION['user_name']." ".$_SESSION['user_lastName']."\"</label></td>";
							echo "<td style='text-align:right'>";
								echo "<input type=button style='font-size:11px' onclick=logOff('".$phpFile."',".$resource.") value='LogOff' />";
							echo "</td>";
						echo "</tr>";
						echo "<tr>";
							echo "<td colspan=2 style='text-align:center'>";
								echo "<input type=button style='font-size:11px' onclick=submitUser('../datumo/session',".$resource.",'".$user_login."','".$user_pass."',1) value='AdminArea' />";
							echo "</td>";
						echo "</tr>";
					echo "</table>";
				}
				echo "<table style='display:".$display."'>";
					echo "<tr>";
						echo "<td><label>User Name</label></td>";
						echo "<td><input style='font-size:11px;' name=user_idm id=user_idm value='' onblur=ajaxUser(this) /></td>";
					echo "</tr>";
					
					echo "<tr>";
						echo "<td><label>Password</label></td>";
						echo "<td><input type=password style='font-size:11px' id=user_passwd name=user_passwd value='' /></td>";
					echo "</tr>";
					
					echo "<tr>";
						echo "<td colspan=2 style='text-align:center'>";
							echo "<input type=button style='font-size:11px' onclick=submitUser('".$phpFile."',".$resource.",null,null,0) value='Login' />";
							echo "<input type=button style='font-size:11px' onclick=submitUser('../datumo/session',".$resource.",null,null,1) value='AdminArea' />";
						echo "</td>";
					echo "</tr>";

					echo "<tr>";
						echo "<td align=center colspan=2>";
						echo "<input type=button style='font-size:11px' onclick=ajaxRecoverPWD() value='Recover Password' />";
						echo "</td>";
					echo "</tr>";
				echo "</table>";

				echo "<table>";
					echo "<tr>";
						echo "<td align=center colspan=2>";
						echo "<hr />";
						echo "</td>";
					echo "</tr>";
				
					echo "<tr>";
						echo "<td align=center colspan=2>";
						echo "<input type=button style='font-size:11px' value='New User' onclick=\"javascript:window.open('../agendo/application.php','_blank','directories=no,status=no,menubar=yes,location=yes,resizable=no,scrollbars=no,width=600,height=475')\" />";
						echo "<input type=button style='font-size:11px' value='New Permission' onclick=\"javascript:window.open('../agendo/newperm.php','_blank','directories=no,status=no,menubar=yes,location=yes,resizable=no,scrollbars=no,width=400,height=275')\" />";
						echo "</td>";
					echo "<tr>";
				echo "</table>";
			echo "</form>";
		echo "</div>";
	}	
// End of buttons for help, videos, resources and user/management
	
	// wtf = "write to file", not "what the fu..dge" 
	function wtf($string, $mode = "w", $path = "c:/a.txt"){
		$fh = fopen($path, $mode) or die("Can't open file!");
		fwrite($fh, $string."\n");
		fclose($fh);
	}
?>