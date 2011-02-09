<?php
require_once(".htconnect.php");

	//Displays a form depending on the parameter type : 
	function make_form($type, $name)
	{
		if (strtolower($type) == "date") {
			echo '<input type=text style="width:70px" name=' . $name . ' id=' . $name . ' readonly=readonly>';
			echo '<script type="text/javascript">Calendar.setup({inputField	 : ' . $name. ',baseField    : "element_2",button: ' . $name . ',ifFormat: "%Y %e, %D",onSelect: selectDate});</script></br>';
		}
		else
			echo '<input type="text" name=' . $name . '> </br>';
	}
	
	//Checks if all the form is filled
	function filled($array, $size)
	{
		$filled = 1;
		for ($i = 0; $i < $size; $i++) {
			if (!$array[$i])
				$filled = 0;
		}
		return $filled;
	}

	try
	{
		
		//Finds view procedures
		$proc = "SELECT * FROM proc";
		$res = mysql_query($proc);
		$num_rows = mysql_num_rows($res);
		echo $num_rows."teste";
		for ($i = 1; $i <= $num_rows; $i++) {
			$row = $mysql_fetch_array($res);
			echo $row[0];
	/*			
			//Finds parameters for each procedures
			$proc_param = "SELECT * FROM param WHERE param_proc = '"$row[0]."'";
			$res_param = mysql_query($proc_param);
			$i_proc = mysql_fetch_row($res_param);
			//Displays a form for each procedures
			echo '<tr><td valign=top class=tables><strong>' . strtoupper($i_proc[0]) . '</strong></br>';
			echo '<form action="admin.php" method="post">';
			echo '<p>';

			//Optional form
			echo 'Results per page <input type=text value=20 id=nrows name=nrows size=1><br/><br/';
			echo '<input type=radio value="ASC" name=order checked>Ascending order<br /><input type=radio value="DESC" name=order>Descending order<br/><br/>';
			echo '</td><td class=fields>';
			while ($plist = mysql_fetch_array($res_param)) {
				echo $plist['param_name'] . ' : ';
				make_form($plist['param_type'], $plist['param_name']);
			}
			echo '<input type="hidden" name="proc_name" value=' . $i_proc['name'] . ' />';
			echo '<input type="submit" value="Show" name="show"/></td>';
			echo '</td>';
			echo '</p>';
			echo '</form></tr>';	
		}
	
		//When "Show" is clicked for a procedure 
		if (isset($_POST['show'])) {
			$proc_param = "SELECT * FROM param WHERE param_proc = '"$row[0]."'";
			$res_param = mysql_query($proc_param);
			//Creation of the parameters array
			$j = 0;
			while ($plist = mysql_fetch_array($res_param) {
				$params[$j] = $_POST[$plist['param_name']];
				$j++;
			}
			if (filled($params, $j)) {
	
				//Creates the argument string
				$args = '\'' . $params[0] . '\'';
				for ($k = 1; $k < $j; $k++) {
					$args = $args . ', \'' . $params[$k] . '\'';
				}
				$args = $args . ', ' . $user_id;	
				//Calls the procedure
				$call_query = 'CALL ' . $_POST['proc_name'] . '(' . $args . ')';
				$call_proc = mysql_query($call_query);
				
				//Displays the result
				echo '<meta http-equiv="refresh" content=";URL=\'manager.php?table=' . substr($_POST['proc_name'], 5, strlen($_POST['proc_name']) - 5) . '&nrows=' . $_POST['nrows'] . '&order=' . $_POST['order'] . '&calc=1&userid=' . $user_id . '\'>';
			}
			else
				echo 'Please enter all parameters for ' . $_POST['proc_name'] . '</br>';
		}*/
		}
	}

	catch (exception $e)
	{
		die('Error : ' . mysql_error());
	}

?>
