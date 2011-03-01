<link href="topic.css" rel="stylesheet" type="text/css" />
<?php
	/*
	  @author Pedro Pires or the Chosen Two
	  @copyright 2010-2011 Pedro Pires
	  @license Distributed under the European Public License (EUPL)
	  @version 1.0
	  @Help file
	*/
	require_once("../.htconnect.php");
	require_once("helpFunctions.php");

	$topicId = $_GET['topic'];
	echo "<table id='helpTopic' class='tableText' width=100% >";
		if(isset($topicId)){
			foreach (getHelpEntries($topicId, false) as $rowTopic){
				// Line break
				echo "<tr>"; echo "<td colspan=2>"; echo "<hr>"; echo "</td>";	echo "</tr>";
				
				echo "<tr>";
					// Show text or text and media or media
					showTextAndMedia($rowTopic['help_name'], $rowTopic['help_text'], $rowTopic['help_mediaurl'], $rowTopic['help_mediatype'], $rowTopic['help_mediaposition']);
				echo "</tr>";
			}
		}
		else{
			// Line break
			echo "<tr>"; echo "<td colspan=2>"; echo "<hr>"; echo "</td>";	echo "</tr>";
			
			echo "<tr>";
				echo "<td align=center >";
					echo "Welcome to help section, please select a help topic.";
				echo "</td>";
			echo "</tr>";
		}
		echo "<tr>";
			echo "<td colspan=2>";
				echo "<hr></hr>";
			echo "</td>";
		echo "</tr>";
	echo "<table>";
?>