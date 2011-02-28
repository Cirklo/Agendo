<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 
<link href="collapser.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="jquery.collapser.js"></script>
<script type="text/javascript" src="helpFunctions.js"></script>

<script type="text/javascript">
	//Collapser code for help buttons
	$(document).ready(
		function(){
			$('.hPanel').hide();
			
			$('.hCollapseButton').collapser({
				target: 'next',
				targetOnly: null,
				effect: 'slide',
				changeText: 0,
				// expandHtml: 'Expand',
				// collapseHtml: 'Collapse',
				expandClass: '',
				collapseClass: ''
			}, function(){
				//$('.hPanel').slideUp();
			});
		}
	);
</script>

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
			
	$section = $_GET['section'];
	if(isset($section)){
		// HowTo buttons generation in a div
		echo "<table id='helpTable'";
			echo "<tr>";
				echo "<td style='vertical-align:top'>";
				$i = 0;
				// Generates the buttons
				foreach (getHelpEntries($section) as $rowNames){
					echo "<h4 id='helpHowTo".$i."' class='hCollapseButton' >".$rowNames['help_name']."</h4>";
					echo "<div id='helpHowToText".$i."' class='hPanel' >";
					$howtoId = $rowNames['help_id'];
					// Generates the content showed by pressing the buttons
					foreach (getHelpEntries($howtoId, false) as $rowTopics){
						echo "<A class='howToText' title='".$row['help_text']."' HREF='topic.php?topic=".$rowTopics['help_id']."' target='helpIfContent'>".$rowTopics['help_name']."</A> ";
						echo "<br></br>";
					}
					echo "</div>";
					$i++;
				}
				echo "</td>";

				// Iframe with help content
				echo "<td style='vertical-align:top'>";
					echo "<IFRAME id='helpIfContent' class='iframeTopic' name='helpIfContent' SRC='topic.php'>";
						echo "If you can see this, your browser doesn't ";
						echo "understand IFRAME.";
						echo "However, we'll still ";
						echo "<A HREF='topic.php'>link</A> ";
						echo "you to the file.";
					echo "</IFRAME>";
				echo "</td>";
			echo "</tr>";
		echo "</table>";

		$marginW = 265;
		$marginH = 27;
		// Javascript to resize the Iframe to fit screen without a certain margin
		echo "<script type='text/javascript'>";
			echo "setElementSize('helpIfContent',".$marginW.",".$marginH.",0,0);";
			echo "window.onresize = function (){setElementSize('helpIfContent',".$marginW.",".$marginH.",0,0);}";
		echo "</script>";
	}
?>

