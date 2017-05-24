<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<script src ="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src ="JS/account.js"></script>
<script src ="JS/entity.js"></script>
<script src ="JS/year.js"></script>
<script src ="JS/rename.js"></script>
<script src ="JS/copy.js"></script>
<script src ="JS/savePoint.js"></script>
<script src ="JS/utility.js"></script>
<script src ="JS/restore.js"></script>
<script src ="JS/deleteStatus.js"></script>
<script src ="JS/undelete.js"></script>
<script src ="JS/applyTaxYear.js"></script>
<link rel="stylesheet" type="text/css" href="CSS/style.css">
</head>
<body>
<div class="container">
	<div>
		<label>Operation: </label>
		<select id ="operation" name ="operation">
			<option value ="">Select</option>
			<option value ="apply">ApplySelectedTaxYear</option>
			<option value ="rename">RenameEntity</option>
			<option value ="copy">CopyEntity</option>
			<option value ="un-delete">Un-DeleteEntity</option>
			<option value ="list">ListRecentChanges</option>
		</select>
	</div>
	<div>
		<div id="apply" style="display:none">
			<form id="applyTaxYear">
				<label for ="year">Year:</label>
				<select id="year" name="year">
					<option value="">Select</option>
					<option value="2011">2011</option>
					<option value="2012">2012</option>
					<option value="2013">2013</option>
					<option value="2014">2014</option>
					<option value="2015">2015</option>
					<option value="2016">2016</option>
					<option value="2017">2017</option>
					<option value="2018">2018</option>
					<option value="2019">2019</option>
					<option value="2020">2020</option>
				</select>
				<br><br>
			</form>
			<button class = 'btn btn-primary' id = "applyYearButton" disabled ="disabled" onclick ="apply()">Apply</button>
		</div>
		
		<div>
			<form id ="rename" style ="display:none" action ="renameEntity.jsp">
				<br>
				<label for ="account">Account:</label>
					<select id ="account_r" name ="account">
						<option value="">Select</option>
					</select>
				<label for ="entity" >Entity:</label>
				<select id ="entity_r" name ="entity">
					<option value="">Select</option>
				</select>
				<br><br>
				<label for="newEntityName">New Entity Name :</label>
				<input id ="newEntityName" name ="newEntityName" style="display:none" placeholder ="New entity name here"></input>
				<br><br>
				<button class="btn btn-primary" id ="updateButton" disabled ="disabled" type ="submit">Rename</button>
			</form>
		</div>
		
		<div id="copy" style="display:none">
			<div >
				<form id="copy_from">
					<Strong>Please select account, entity, year which data are copied from</Strong>
					<br><br>
					<label for="account">Account:</label>
						<select id ="account_c_from" name ="account">
							<option value="">Select</option>
						</select>
					<label for="entity">Entity:</label>
					<select id ="entity_c_from" name ="entity">
						<option value="">Select</option>
					</select>
					<label for="year">Year:</label>
					<select id ="year_c_from" name ="year">
						<option>Select</option>
					</select>
				</form>
				<form id="copy_to">
					<Strong>Please select account, entity, year which data will be copied to</Strong>
					<br><br>
					<label for="account">Account:</label>
						<select id ="account_c_to" name ="account">
							<option value="">Select</option>
						</select>
					<label for="entity">Entity:</label>
					<select id ="entity_c_to" name ="entity">
						<option value="">Select</option>
					</select>
					<label for="year">Year:</label>
					<select id ="year_c_to" name ="year">
						<option>Select</option>
					</select>
					<br><br>
				</form>
			</div>
			<button class="btn btn-primary" id = "copyButton" disabled = "disabled" onclick="copy()">Copy</button>
		</div>
		<div style = "display:none">
			<form id= "temp" >
				<input id ="account_from" name ="account_from"></input>
				<input id ="entity_from" name ="entity_from"></input>
				<input id ="year_from" name ="year_from"></input>
				<input id ="account_to" name ="account_to"></input>
				<input id ="entity_to" name ="entity_to"></input>
				<input id ="year_to" name ="year_to"></input>
			</form>
		</div>
	</div>
	
	<div id ="listChanges" style ="display:none">
		<div>
			<form id="savePoint">
				<label for="account">Account:</label>
				<select id ="account_l" name ="account">
					<option value="">Select</option>
				</select>
				<label for="entity">Entity:</label>
				<select id ="entity_l" name ="entity">
					<option value="">Select</option>
				</select>
				<br>
				<label for="field">Field:</label>
				<select id ="field" name ="field">
					<option value="">Select</option>
				</select>
				<br><br>
				<label>Available Worksheet Saves:</label>
				<br>
				<table>
					<tr>
						<td><div id="point"></div></td>
						<td><div id="modal-content" class = "modal-content">
								<div class="modal-header">
									<span class="close" onclick="close()">&times;</span>
									<h2>SavePoint</h2>
								</div>
								<div class="modal-body">
									<table id = "stable"></table>
								</div>
						</div></td>
					<tr>
				</table>
			</form>
		</div>
		<button class="btn btn-primary" id="restoreButton" disabled = "disabled" onclick="restore()">Restore</button>
	</div>
		
	<div id ="delete" style ="display:none">
		<div>
			<form id="deleteStatus">
				<label for="account">Account:</label>
				<select id ="account_d" name ="account">
					<option value="">Select</option>
				</select>
				<label for="entity">Entity:</label>
				<select id ="entity_d" name ="entity">
					<option value="">Select</option>
				</select>
				<table id = "status">
				<tr>
					<th>Year</th>
					<th>Active</th>
					<th>Inactive</th>
				</tr>
				</table>
				<input id="temp" name = "temp" style="display:none"></input>
			</form>
		</div>
		<button class="btn btn-primary" id="changeStatusButton" disabled="disabled" onclick = "unDelete()">Change Selected Years Status</button>
	</div>
	<div id="box">
		<div id ="confirmBox">
			<div class="message" style="text-align:center"></div>
			<button class="yes">Yes</button>
			<button class="no">No</button>
		</div>
	</div>
	
	<p id="result" style="text-align:center;color:red"></p>
</div>
	
<script>
$(document).ready(function(){
	restorePoints=[];
	accounts=[];
	currentYearAvailable = true;
	
	$('#operation').change(function(){
		if($('#operation').val()==''){
			$('#apply').hide();
			$('#rename').hide();
			$('#copy').hide();
			$('#listChanges').hide();
			$('#delete').hide();
			$("#rename")[0].reset();
		}
		if($('#operation').val()=='apply'){
			display('#apply','#rename','#copy','#listChanges','#delete');
			$('#year').prop('selectedIndex',0);
			button();
		}
		if($('#operation').val()=='rename'){
			display('#rename','#copy','#listChanges','#delete','#apply');
			$("#rename")[0].reset();
			reset('#entity_r');
			getAccounts("#account_r");
			getEntities("#account_r","#entity_r","#rename","#updateButton");
			updateEntity();
		}
		if($('#operation').val()=='copy'){
			display('#copy','#rename','#listChanges','#delete','#apply');
			currentYearAvailable = true;
			reset('#account_c_from');
			reset('#account_c_to');
			reset('#entity_c_from');
			reset('#entity_c_to');
			reset('#entityId_c_from');
			reset('#entityId_c_to');
			reset('#year_c_from');
			reset('#year_c_to');
			getAccounts("#account_c_from");
			getAccounts("#account_c_to");
			getEntities("#account_c_from","#entity_c_from","#copy_from","#copyButton");
			getEntities("#account_c_to","#entity_c_to","#copy_to","#copyButton");
			getYears("#entity_c_from","#year_c_from","#copy_from");
			getYears("#entity_c_to","#year_c_to","#copy_to");
			console.log(currentYearAvailable);
		}
		if($('#operation').val()=="list"){
			display('#listChanges','#copy','#rename','#delete','#apply');
			reset('#account_l');
			reset('#entity_l');
			reset('#restorePoint');
			reset('#entityId_l');
			reset($('#field'));
			$('input:radio').remove();
			$("label[for='savepoint']").remove();
			$("#modal-content").css("display","none");
			getAccounts("#account_l");
			getEntities("#account_l","#entity_l","#savePoint","#restoreButton");
			getSavePoints("#entity_l","#field");
			close();
		}
		if($('#operation').val()=="un-delete"){
			display('#delete','#copy','#listChanges','#rename','#apply');
			reset('#account_d');
			reset('#entity_d');
			reset('#entityId_d');
			$('#status tr td').remove();
			getAccounts("#account_d");
			getEntities("#account_d","#entity_d","#deleteStatus","#changeStatusButton");
			getDeleteStatus("#account_d","#entity_d","#deleteStatus");
		}
	})
});
</script>
</body>
</html>