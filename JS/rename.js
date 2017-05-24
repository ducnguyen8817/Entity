function updateEntity(){
	$('#entity_r').change(function(){
		if($('#entity_r').val()!=""){
			$('#newEntityName').css("display","inline");
		} else {
			$('#newEntityName').css("display","none");
		}
	});
	
	$('#newEntityName').blur(function(){
		if($('#newEntityName').val()!=""){
			$("#updateButton").prop('disabled',false);
		} else {
			$("#updateButton").prop('disabled',true);
		}
	});
	$("#rename").submit(function(event){
			value = $(this).serialize();
			event.preventDefault();
			url = $(this).attr('action');
			$("#box").css("display","block");
			var confirmBox = $("#confirmBox");
			confirmBox.find(".message").text("Are you sure that you want to update ?");
			confirmBox.find(".yes,.no").unbind().click(function(){
				confirmBox.hide();
			});
			confirmBox.find(".yes").click(function(){
				$("#box").css("display","none");
				var posting = $.post(url, value);
			
				posting.done(function(res){
					reset($('#entity_r'));
					$("#rename")[0].reset();
					$("#result").html(res);
					setTimeout(function(){ $("#result").html("");},2000);
				});
			
				posting.fail(function(err){
					$("#result").html(err);
				});
			});
			confirmBox.find(".no").click(function(){
				$("#box").css("display","none");
			});
			confirmBox.show();
			
		});
}