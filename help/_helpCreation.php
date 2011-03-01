<script type="text/javascript">
	function showHowTo(helpId){
		alert(helpId);
	}

	function showNewInput(){
		alert('shows');
		newDiv.style.display=none';
	}

</script>

<?php
	require_once("../.htconnect.php");
	require_once("helpFunctions.php");

	echo "<table>";
		echo "<tr>";
			echo "<td>";
				echo "<select>";
					echo "<option selected onclick='showNewInput()' title='Create a new help section' id='sectionDefault'>New Help Section</option>";
					foreach (getHelpEntries(0,false) as $row){
						echo "<option onclick='showHowTo(".$row['help_id'].")' title='".$row['help_text']."' id='section".$row['help_id']."'>".$row['help_name']."</option>";
					}
				echo "</select>";
			echo "</td>";
			echo "<td>";
				echo "<input type='text' name='fname' />";
				echo "<input type='submit' value='Submit' onclick=''/>";
			echo "</td>";
		echo "</tr>";
	echo "</table>";
?>