function getSavePoints(entity,field){
	$(entity).change(function(){
		var data = $('#savePoint').serializeArray();
		url = "savePoint.jsp";
		$("#restoreButton").prop('disabled',true);
		if(restorePoints.length==0){
			posting = $.post(url,data);
			posting.done(function(res){
				$("label[for='savepoint']").remove();
				$("input:radio").remove();
				reset($(field));
				$('.restoreValue').remove();
				$("#modal-content").css("display","none");
				$('#savePoint #point').append("");
				restorePoints= JSON.parse(res);
				$.each(restorePoints, function(key, value){
					if(data[0].value == value.accountId && data[1].value == value.entityId){
						$('#savePoint #point').append("<div><input id='savepoint'  name='savepoint' type='radio' value="+value.name+">"+"<label id= 'time' for=savepoint>"+value.timeStamp+"</label></input></div>");
					}
				});
			
				radioButton();
				getFieldName($('input[name=savepoint]'),field);
				$("#savePoint input[name=savepoint]").click(function(){
					savePointDetail();
					console.log($("#savePoint input[name=savepoint]").is(':checked'));
					
				});
			});
			
			posting.fail(function(err){
				console.fail(res);
			})
		} else {
			reset($(field));
			$("input:radio").remove();
			$("label[for='savepoint']").remove();
			$('.restoreValue').remove();
			$("#modal-content").css("display","none");
			$.each(restorePoints, function(key, value){
				if(data[0].value == value.accountId && data[1].value == value.entityId){
					$('#savePoint #point').append("<div><input id='savepoint'  name='savepoint' type='radio' value="+value.name+">"+"<label for=savepoint>"+value.timeStamp+"</label></input></div>");
				}
			});
			
			radioButton();
			getFieldName($('input[name=savepoint]'),field);

			$("#savePoint input[name=savepoint]").click(function(){
				savePointDetail();
			});
		}
	});
	
	$(field).change(function(){
		$("#confirmBox").css("display","none");
		if($("input[name=savepoint]:checked").val()){
			savePointDetail();
		}
	})
};

function savePointDetail(){
	$("#modal-content").css("display","none");
	$('#restoreValue').remove();
	readFile($("input[name=savepoint]:checked"));
	$("#modal-content").css("display","inline-block");
	$("#modal-content").draggable();
}

function radioButton(){
	var radio = $('#savePoint #point input[name=savepoint]');
	(radio).change(function(){
		$("#restoreButton").prop('enabled',radio.filter(':checked').length > 0);
		$("#restoreButton").prop('disabled',radio.filter(':checked').length < 1);
		$(this).closest("div").addClass("Checked")
		.siblings("div.Checked").removeClass("Checked");
	})
}

function getFieldName(path, field){
	var data = path;
	url = "readFile.jsp";
	posting = $.post(url,data);
	
	posting.done(function(res){
		reset($(field));
		var fields = JSON.parse(res);
		fields = sortJSON(fields,'fieldName')
		$.each(fields, function(key, value){
			$('#field').append($("<option></option>")
						.attr("value",value.fieldName)
						.text(value.fieldName));
		});
	});
	
	posting.fail(function(err){
		console.log(err);
	});
}

function readFile(path){
	var data = path;
	url = "readFile.jsp";
	posting = $.post(url,data);
	
	posting.done(function(res){
		$('#stable tr').remove();
		var fields = JSON.parse(res);
		fields = sortJSON(fields,'fieldName');
		$('.modal-body #stable').append("<tr><th>Field Name</th><th>Value</th></tr>");
		$.each(fields, function(key, value){
			$('#savePoint').append("<input  style='display:none' name ='fieldNames' value="+value.fieldName+"></input>");
			$('#savePoint').append("<input  style='display:none' name ='restoreValues' value="+value.value+"></input>");
			
			if($('#field').val()==""){
				$('.modal-body #stable').append("<tr><td>"+value.fieldName+"</td><td>"+value.value+"</td></tr>");
			}
			if(value.fieldName==$('#field').val()){
				$('.modal-body #stable').append("<tr><td>"+value.fieldName+"</td><td>"+value.value+"</td></tr>");
				$('#savePoint').append("<input class='restoreValue' name='restoreValue' style='display:none' value="+value.value+"></input>");

			}
		})
	});
	
	posting.fail(function(err){
		console.log(err);
	});
}

function close(){
	$('.close').click(function(){
		$("#modal-content").css("display","none");
	});
}