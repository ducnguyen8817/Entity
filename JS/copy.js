function copy(){
	$('#account_from').val($('#account_c_from').val());
	$('#entity_from').val($('#entity_c_from').val());
	$('#year_from').val($('#year_c_from').val());
	
	$('#account_to').val($('#account_c_to').val());
	$('#entity_to').val($('#entity_c_to').val());
	$('#year_to').val($('#year_c_to').val());
	
	value = $('#temp').serialize();
	
	$("#box").css("display","block");
	var confirmBox = $("#confirmBox");
	confirmBox.find(".message").text("Are you sure that you want to copy ?");
	confirmBox.find(".yes,.no").unbind().click(function(){
		confirmBox.hide();
	});
	confirmBox.find(".yes").click(function(){
		$("#box").css("display","none");
		if( !currentYearAvailable && $('#year_to').val() == getCurrentYear()){
			url = "insertEntity.jsp";
		} else {
			url = "copyEntity.jsp";
		}
		
		var posting = $.post(url,value);
		posting.done(function(res){

		$('#temp')[0].reset();
		$('#copy_from')[0].reset();
		$('#copy_to')[0].reset();
		reset('#entity_c_from');
		reset('#entity_c_to');
		reset('#entityId_c_from');
		reset('#entityId_c_to');
		reset('#year_c_from');
		reset('#year_c_to');
		$("#result").html(res);
		setTimeout(function(){ $("#result").html("");},2000);
		});
		
		posting.fail(function(err){
			console.log(err);
		});
	})
	
	confirmBox.find(".no").click(function(){
		$("#box").css("display","none");
	})
	
	
	confirmBox.show();
}