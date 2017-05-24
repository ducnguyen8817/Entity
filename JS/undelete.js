function unDelete(){
	var value =$('#deleteStatus').serializeArray();
	url = 'undelete.jsp';
	$("#box").css("display","block");
	var confirmBox = $("#confirmBox");
	confirmBox.find(".message").text("Are you sure that you want to change the selected years'status ?");
	confirmBox.find(".yes,.no").unbind().click(function(){
		confirmBox.hide();
	});
	
	confirmBox.find(".yes").click(function(){
		$("#box").css("display","none");
		var posting = $.post(url, value);
		
		posting.done(function(res){
			$("#result").html(res);
			setTimeout(function(){ $("#result").html("");},2000);
			getCurrentStatus("#account_d","#entity_d","#deleteStatus");
		});
		
		posting.fail(function(err){
			console.log(err);
		});
	});
	
	confirmBox.find(".no").click(function(){
		$("#box").css("display","none");
	});
	
	
	confirmBox.show();
}

function resetUndeleteForm(){
	$("#deleteStatus")[0].reset();
	reset('#entity_d');
	$('#status tr td').remove();
}