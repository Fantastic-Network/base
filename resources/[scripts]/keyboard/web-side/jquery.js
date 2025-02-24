var Rows = [];
var saved = "";
var RowsData = [];
// ---------------------------------------------------------------------------------------------
const OpenMenu = (data) => {
	$(".Keyboard-Wrapper").fadeIn(200);
	AddRow(data.rows);
}
// ---------------------------------------------------------------------------------------------
const CloseMenu = () => {
	$(".Keyboard-Wrapper").fadeOut(200)
	$(saved).remove();
	
	for (var i = 0; i < RowsData.length; i++){
		var id = RowsData[i].id
		$(Rows[id]).remove();
	}

	RowsData = [];
	saved = "";
	Rows = [];
	$(this).dequeue();
}
// ---------------------------------------------------------------------------------------------
function AddRow(data){
	RowsData = data

	for (var i = 0; i < RowsData.length; i++){
		var message = RowsData[i]["txt"]
		var Copy = RowsData[i]["copy"]
		var Area = RowsData[i]["area"]
		var Word = RowsData[i]["word"]
		var id = RowsData[i]["id"]
		var element

		if (Copy == "undefined"){
			if (Area == "undefined"){
				if (Word == "undefined"){
					element = $('<label for="usr">' + message + '</label><input type="text" placeholder="Preencha o campo." id="' + id + '" />');
				} else {
					element = $('<label for="usr">' + message + '</label><input type="password" placeholder="Preencha o campo." id="' + id + '" />');
				}
			} else {
				element = $('<label for="usr">' + message + '</label><textarea type="text" placeholder="Preencha o campo." maxlength="500" id="' + id + '" /></textarea>');
			}
		} else {
			if (Area == "undefined"){
				element = $('<label for="usr">' + message + '</label><input type="text" placeholder="Preencha o campo." value='+ Copy +' id="' + id + '" />');
			} else {
				element = $('<label for="usr">' + message + '</label><textarea type="text" placeholder="Preencha o campo." maxlength="500" value='+ Copy +' id="' + id + '" /></textarea>');
			}
		}

		$(".body").append(element);
		Rows[id] = element
	}

	var firstInput = document.getElementsByTagName("input")[0];
	if (firstInput){
		firstInput.focus();
	} else {
		firstInput = document.getElementsByTagName("textarea")[0];
		if (firstInput){
			firstInput.focus();
		}
	}

	if (firstInput.value != "") {
		firstInput.select();
	}
}
// ---------------------------------------------------------------------------------------------
function SubmitData(){
	const returnData = [];

	for (var i = 0; i < RowsData.length; i++){
		var id = RowsData[i].id
		var data = document.getElementById(id)
		if (data.value){
			returnData.push({
				_id: id,
				input: data.value
			});
		} else {
			returnData.push({
				_id: id,
				input: null
			});
		}

		$(Rows[id]).remove();
	}

	PostData({ data: returnData })
	CloseMenu();
}
// ---------------------------------------------------------------------------------------------
const PostData = (data) => {
	return $.post("https://keyboard/success",JSON.stringify(data))
}
// ---------------------------------------------------------------------------------------------
const CancelMenu = () => {
	CloseMenu()

	$.post("https://keyboard/failure")
}

$(() => {
	$("#submit").on("click",() => {
		SubmitData();
	})
})

// ---------------------------------------------------------------------------------------------
window.addEventListener("message",(evt) => {
	const data = evt.data
	const info = data.data
	const action = data.action

	switch (action){
		case "OPEN_MENU":
			return OpenMenu(info);

		case "CLOSE_MENU":
			return CloseMenu();

		default:
			return;
	}
})
// ---------------------------------------------------------------------------------------------
document.onkeyup = function(event){
	event = event || window.event;
	var charCode = event.keyCode || event.which;

	if (charCode == 27){
		CancelMenu();
	} else if (charCode == 13){
		SubmitData()
	}
};

loadTheme((theme) => {
	
})