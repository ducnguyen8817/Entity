function restore(){
	value = $('#savePoint').serialize();
	url= "restore.jsp";
	$("#box").css("display","block");
	var confirmBox = $("#confirmBox");
	confirmBox.find(".message").text("Are you sure that you want to restore ?");
	confirmBox.find(".yes,.no").unbind().click(function(){
		confirmBox.hide();
	});
	confirmBox.find(".yes").click(function(){
		$("#box").css("display","none");
		var posting = $.post(url,value);
		posting.done(function(res){
			$("#modal-content").css("display","none");
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

