function getCurrentYear(){
	return new Date().getFullYear();
}


function reset(id){
	$(id).children().remove().end();
	$(id).append('<option selected value="">Select</option>');
}
	
function display(id1, id2, id3, id4, id5){
	$(id1).show();
	$(id2).hide();
	$(id3).hide();
	$(id4).hide();
	$(id5).hide();
}
	
function sortJSON(data, key) {
	return data.sort(function (a, b) {
		var x = a[key];
		var y = b[key];
		return ((x < y) ? -1 : ((x > y) ? 1 : 0));
	});
}

function enableButton(button){
	$(button).prop('disabled',false);
}

function disableButton(button){
	$(button).prop('disabled',true);
}
