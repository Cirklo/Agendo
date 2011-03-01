<link href="topic.css" rel="stylesheet" type="text/css" />

<?php
	/*
	  @author Pedro Pires or the Chosen Two
	  @copyright 2010-2011 Pedro Pires
	  @license Distributed under the European Public License (EUPL)
	  @version 1.0
	  @Help file
	*/

	// Gets the section/howto/topics from the database
	function getHelpEntries($idParent = '0', $mustHaveChildren = true){
		$hasChildren = '';
		if($mustHaveChildren)
				$hasChildren = ' and help_id in (select help_parentid from help)';
				
		$sql="select * from help where help_parentid = ".$idParent.$hasChildren." order by help_showorder";
		$connection = new dbConnection();
		// $prepSql = $connection->prepare($sql);
		// $connection->execute($prepSql);
		return $connection->query($sql);
	}
	
	// Sets the media type to show
	function mediaType($name, $mediaUrl, $type){
		switch($type){
			case 1:// IMAGE
				echo "<img title='".$name."' src='".$mediaUrl."'></img>";
			break;
			case 2:// VIDEO
				$videoWidth = '800';
				$videoHeight = '600';
				echo "<a class='link' href='' title='".$name."' onclick=\"javascript:window.open('".$mediaUrl."','_blank','directories=no,status=no,menubar=yes,location=yes,resizable=yes,scrollbars=no,width=".$videoWidth.",height=".$videoHeight."')\">Video</link>";
				$scaleType = 'DEFAULT';
			break;
			// case 3:// AUDIO
				// $mediaType='';
			// break;
		}
	}
	
	// Media's position in relation to the text
	// Order is : 1 = Up, 2 = Down, 3 = Left, 4 = Right. And the the order should correspond to what is in the database.
	function mediaPosition($name, $text, $url, $type, $position){
		switch($position){
			case 1:// UP
				echo "<tr>";
					echo "<td align=center colspan=2>";
						echo mediaType($name, $url, $type);
					echo "</td>";
				echo "</tr>";
				echo "<tr>";
					echo "<td align=center colspan=2>";
						echo $text;
					echo "</td>";
				echo "</tr>";
			break;
			case 2:// DOWN
				echo "<tr>";
					echo "<td align=center colspan=2>";
						echo $text;
					echo "</td>";
				echo "</tr>";
				echo "<tr>";
					echo "<td align=center colspan=2>";
						echo mediaType($name, $url, $type);
					echo "</td>";
				echo "</tr>";
			break;
			case 3:// LEFT
				echo "<tr>";
					echo "<td align=right>";
						echo mediaType($name, $url, $type);
					echo "</td>";
					echo "<td>";
						echo $text;
					echo "</td>";
				echo "</tr>";
			break;
			case 4:// RIGHT
				echo "<tr>";
					echo "<td>";
						echo $text;
					echo "</td>";
					echo "<td align=left>";
						echo mediaType($name, $url, $type);
					echo "</td>";
				echo "</tr>";
			break;
		}
	}
	
	// Echoes media, text or both
	function showTextAndMedia($name, $text, $mediaUrl, $mediaType, $mediaPosition){
		if(isset($mediaUrl) && isset($text)){
				mediaPosition($name, $text, $mediaUrl, $mediaType, $mediaPosition);
		}
		else if(isset($mediaUrl)){
				echo mediaType($name, $mediaUrl, $mediaType);
		}
		else if(isset($text)){
			echo "<td align=center colspan=2>";
				echo $text;
			echo "</td>";
		}
	}
?>
