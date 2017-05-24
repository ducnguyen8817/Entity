function getYears(entityId, year, form) {
	$(entityId).change(function(){
		$("#copyButton").prop('disabled',true);
		var value = $(form).serialize();
		url = "year.jsp";
		var posting = $.post(url,value);
			
		posting.done(function(res){
			reset(year);
			var years = JSON.parse(res);
			$.each(years, function(key, value){
				$(year).append($("<option></option>")
						.attr("value",value.year)
						.text(value.year));
			})
			getMaxYear(entityId,year,form)
		});
			
		posting.fail(function(err){
			console.log(err);
		});
	});
	
	
	$(year).change(function(){
		$("#confirmBox").css("display","none");
		console.log($(year).val()!="")
		if($("#year_c_from").val()!="" && $("#year_c_to").val()!="" ){
			$("#copyButton").prop('disabled',false);
		} else {
			$("#copyButton").prop('disabled',true);
		} 
	})
	

}


function getMaxYear(entityId,year,form){
		var value = $(form).serialize();
		console.log(value);
		url = "maxYear.jsp";
		var posting = $.post(url,value);
		var maxYear = null;
	
		posting.done(function(res){
			if(year=="#year_c_to"){
				console.log(res);
				if(res < getCurrentYear()){
					currentYearAvailable = false;
					$(year).append($("<option></option>")
						.attr("value",getCurrentYear())
						.text(getCurrentYear()));
					
				}
				console.log(currentYearAvailable);
			}
			
		});
		
		posting.fail(function(err){
			console.log(err);
		});
}