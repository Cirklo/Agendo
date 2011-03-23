<?php
require_once("session.php");
$user_id = startSession();
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<link rel='stylesheet' type='text/css' href='css/fullcalendar.css' />
<script type='text/javascript' src='js/jquery-1.4.4.js'></script>
<script type='text/javascript' src='js/jquery-ui-1.8.9.custom.min.js'></script>
<script type='text/javascript' src='js/fullcalendar.js'></script>
<script type='text/javascript'>

	$(document).ready(function() {
	
		$('#calendar').fullCalendar({
			editable: false,
			events: "calendar_feed.php",
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,agendaWeek,agendaDay'

			},
			
			loading: function(bool) {
				if (bool) $('#loading').show();
				else $('#loading').hide();
			}
			
		});
		
	});

</script>
<style type='text/css'>

	body {
		font-family:Verdana, Geneva, sans-serif; 
		font-size:12px; 
		line-height:20px; 
		color:#545353;
		text-align:center;
		}
		
	#loading {
		position: absolute;
		top: 5px;
		right: 5px;
		}

	#calendar {
		width: 900px;
		margin: 0 auto;
		}

</style>
</head>
<body>
<?php 

echo "<a href=admin.php>Return to main menu</a>";
echo "<div id='loading' style='display:none'>loading...</div>";
echo "<div id='calendar'></div>";

?>
</body>
</html>
