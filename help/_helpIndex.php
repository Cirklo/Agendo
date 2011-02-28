<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 
<link href="collapser.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="jquery.collapser.js"></script>
<script type="text/javascript" src="helpFunctions.js"></script>
<script type="text/javascript">
	var previousElement = '';
	
	// Code for css change when pressing buttons
	function toggle(element){
		if(element != previousElement){
			$(element).toggleClass("hButtonSelected");
			if(previousElement != '')
				$(previousElement).toggleClass("hButtonSelected");
		}
		previousElement = element;
	}
	
	// Created so its possible to have toggle isolated and to change Iframe url
	function toggleAndIframeHref(element, helpId){
		toggle(element+helpId);
//		if(helpId == '_helpCreation')
//			helpIFHowTo.location.href = helpId + '.php';
//		else
			helpIFHowTo.location.href = 'howto.php?section=\"'+helpId+'\"';
	}
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

//	$hasPermission = true;
	echo "<table id='helpSections'>";
		echo "<tr align='center'>";
			echo "<td colspan=2>";
				foreach (getHelpEntries() as $row){
						// echo "<button type='button' class='hButton' onclick=\"helpIFHowTo.location.href='howto.php?section=".$row['help_id']."';\" >".$row['help_name']."</button>";
						echo "<button type='button' title='".$row['help_text']."' id='button".$row['help_id']."' class='hButton' onclick=\"toggleAndIframeHref('#button',".$row['help_id'].")\">".$row['help_name']."</button>";
				}
//				if($hasPermission)
//					echo "<button type='button' id='button_helpCreation' class='hButton' onclick=\"toggleAndIframeHref('#button','_helpCreation')\">HelpEdit</button>";
			echo "</td>";
		echo "</tr>";

		echo "<tr align='center'>";
			echo "<td style='vertical-align:top'>";
				// Iframe with help content
				echo "<IFRAME id='helpIFHowTo' class='iframeHowTo' name='helpIFHowTo' SRC='howto.php'>";
					echo "If you can see this, your browser doesn't ";
					echo "understand IFRAME.";
					echo "However, we'll still ";
					echo "<A HREF='howto.php'>link</A> ";
					echo "you to the file.";
				echo "</IFRAME>";
			echo "</td>";
		echo "</tr>";
	echo "<table>";
	
	$marginW = 35;
	$marginH = 80;
	// Javascript to resize the Iframe to fit screen without a certain margin
	echo "<script type='text/javascript'>";
		echo "setElementSize('helpIFHowTo',".$marginW.",".$marginH.",800,600);";
		echo "window.onresize = function (){setElementSize('helpIFHowTo',".$marginW.",".$marginH.",800,600);}";
	echo "</script>";
	
?>