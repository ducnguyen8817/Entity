function getAccounts(temp){
		reset(temp);
		var value ="";
		url = "account.jsp";
		if(accounts.length==0){
			var posting = $.post(url,value);
			posting.done(function(res){
				accounts = JSON.parse(res);
				accounts = sortJSON(accounts,'loginId');
				$.each(accounts, function(key, value){
					$(temp).append($("<option></option>")
									.attr("value",value.accountId)
									.text(value.loginId));
				})
			});
				
			posting.fail(function(err){
				console.log(err);
			});
		} else {
				$.each(accounts, function(key, value){
					$(temp).append($("<option></option>")
									.attr("value",value.accountId)
									.text(value.loginId));
				})
		}
}