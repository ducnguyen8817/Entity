function getDeleteStatus(account,entity,form){
	$(account).change(function(){
		$('#status #statusRow').remove();
	})
	$(entity).change(function(){
		getCurrentStatus(account,entity,form)
	})
	
}

function getCurrentStatus(account,entity,form){
	var value =$(form).serialize();
	url = 'deleteStatus.jsp';
	$("#changeStatusButton").prop('disabled',true);
	posting = $.post(url, value);
		
	posting.done(function(res){
		$('#status #statusRow').remove();
		var statuses = JSON.parse(res);
		$.each(statuses, function(key, value){
			if((value.status)=='Y') 
			{
				$('#status').append("<tr id ='statusRow'><td>"+value.year+"</td><td></td><td style='color:#008000'>"+'&#10004;'+"</td><td><input  type='checkbox'  name='dStatus' value="
							+value.year+',Y'+"></input></td></tr>");
			} else {
				$('#status').append("<tr id ='statusRow'><td>"+value.year+"</td><td style='color:#008000'>"+'&#10004;'+"</td><td></td><td><input type='checkbox'  name='dStatus' value="
							+value.year+',N'+"></input></td></tr>");
			}
		})
		var checkBoxes = $("#status input[name=dStatus]");
		$(":checkbox").change(function() {
			$(this).closest("tr").toggleClass("checked", this.checked);
			$(this).closest("tr").toggleClass("unchecked", !this.checked);
			$("#changeStatusButton").prop('disabled',checkBoxes.filter(':checked').length < 1);
			$("#changeStatusButton").prop('enabled',checkBoxes.filter(':checked').length > 0);
		});
	});
					
	posting.fail(function(err){
		console.log(err);
	});

}