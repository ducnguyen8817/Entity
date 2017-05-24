function getEntities(account, entity, form, button){
	$(account).change(function(){
		currentYearAvailable = true;
		var value = $(account);
		url = "entity.jsp";
		var posting = $.post(url,value);
		posting.done(function(res){
			resetForm(entity,button);
			var entities = JSON.parse(res);
			entities = sortJSON(entities,'name');
			$.each(entities, function(key, value){
				$(entity).append($("<option></option>")
						.attr("value",value.entityId)
						.text(value.name+" - "+value.entityId));
				})
			});
			
			posting.fail(function(err){
				console.log(err);
			});
	});
}

function resetForm(entity, button){
	reset(entity);
	reset($('#field'));
	$('input:radio').remove();
	$("label[for='savepoint']").remove();
	$("#modal-content").css("display","none");
	$("#confirmBox").css("display","none");
	$(button).prop('disabled',true);
}