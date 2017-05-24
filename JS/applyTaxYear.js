function button(){
	$('#year').change(function(){
				console.log($('#year').val());
				$('#applyYearButton').prop('enabled',$('#year').val()!="");
				$('#applyYearButton').prop('disabled',$('#year').val()=="");
					
				
			});
}
function apply(){
		$("#box").css("display","block");
		var confirmBox = $('#confirmBox');
		confirmBox.find(".message").text("Are you sure that you want to apply the selected tax year ?");
		confirmBox.find(".yes,.no").unbind().click(function(){
			confirmBox.hide();
		});
		value = $('#applyTaxYear').serialize();
		console.log(value);
		url = "applyTaxYear.jsp";
		confirmBox.find(".yes").click(function(){
			$("#box").css("display","none");
			var posting = $.post( url, value);
			
			
			posting.done(function(res){
				
				$('#result').html(res);
				setTimeout(function(){ $('#result').html("");},2000);
			});
			
			posting.fail(function(err){
				console.log(err);
				$('#result').html(err);
			});
		});
		confirmBox.find(".no").click(function(){
			$("#box").css("display","none");

		});
		confirmBox.show();
}