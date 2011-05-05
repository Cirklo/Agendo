function resourceSelect(id){
	//alert(item);

	//set url for ajax request
	url="auxFunctions.php"; 
	//ajax request
	$.get(url,{
		type:0,
		resource:$("#"+id).val()},
		function(data){
			//return the data
			//alert(data);
			$("#resource_display").html(data);
			getValuesToPlot(id);
		});
	
	
}

function getValuesToPlot(){
	//get values from drowpdowns
	var val=$("#resource").val();
	var time=$("#time").val();
	var counter=0; //counter for debug
	//initialize json array
	var json=new Array();
	//go through all checkboxes to create plots
	$("input[type=checkbox]").each(function(){
		var parameter_id=$(this).attr("id"); //store checkbox id (equip_id)
		//define link to create JSON object
		if(this.checked){
			var url="auxFunctions.php?type=1&";
			var urlParams="resource="+val+"&time="+time+"&equip="+parameter_id;
			$.getJSON(url,urlParams, function(data){
				json=data;			
				plotValues(json, "#plot_"+parameter_id,"#tag_"+parameter_id);
			});
		} else {
			plotValues([], "#plot_"+parameter_id,"#tag_"+parameter_id);
		}
		
		
	});
	
}


function plotValues(data, div, parameter){
	//get tag from each checkbox that is checked
	var tag=$(parameter).val();
	//draw plot
	$.plot($(div), [{data: data, label: tag}], {
		//yaxis: { min: 2000, max: 3000 },
		xaxis: { mode: "time", timeformat: "%y-%m-%d %H:%M"},
		selection: { mode: "x" },
		legend: {position: "sw"}		
	});
	
	var options = {
		xaxis: { mode: "time", timeformat: "%d/%m %H:%M"},
		selection: { mode: "x" }
	};
		
	$(div).bind("plotselected", function (event, ranges) {
		// do the zooming
		plot = $.plot($(div), [{data: data, label: equip}],
		      $.extend(true, {}, options, {
			  xaxis: { min: ranges.xaxis.from, max: ranges.xaxis.to },
			  legend: {position: "sw"}
	      }));	
				// don't fire event on the overview to prevent eternal loop
				//overview.setSelection(ranges, true);
	});
		
	$(div).dblclick(function(){
		$.plot($(div), [{data: data, label: tag}], {
			//yaxis: { autoscaleMargin: null },
			xaxis: { mode: "time", timeformat: "%y-%m-%d %H:%M"},
			selection: { mode: "x" },
			legend: {position: "sw"}		
		});
					
	});
}
