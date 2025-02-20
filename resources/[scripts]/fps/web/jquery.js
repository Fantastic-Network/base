var Rows = [];
var saved = "";
var RowsData = [];
// ---------------------------------------------------------------------------------------------
const OpenMenu = (data) => {
	$(".Keyboard-Wrapper").fadeIn(200);

	$("#range").val(data.range);

	$("#switch-1-box").prop("checked", data.switch1);
	$("#switch-1").html(data.switch1Title);

	$("#switch-2-box").prop("checked", data.switch2);
	$("#switch-2").html(data.switch2Title);
}


// ---------------------------------------------------------------------------------------------
const CloseMenu = () => {
  console.log("Closing Menu")
  console.log(saved + " saved")
	$(".Keyboard-Wrapper").fadeOut(200)
	$(saved).remove();

	$(this).dequeue();
}
// ---------------------------------------------------------------------------------------------
function SubmitData(){
	var range = $("#range").val();
	var switch1 = $("#switch-1-box").prop("checked");
	var switch2 = $("#switch-2-box").prop("checked");

	var returnData = {
		range: range,
		switch1: switch1,
		switch2: switch2,
	}

	console.log(returnData)

	PostData({ data: returnData })
  console.log("Data Posted")
	CloseMenu();
}
// ---------------------------------------------------------------------------------------------
const PostData = (data) => {
	return $.post("https://fps/success",JSON.stringify(data))
}
// ---------------------------------------------------------------------------------------------
const CancelMenu = () => {
	CloseMenu()

  console.log("Menu Cancelled")
	$.post("https://fps/failure")
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
      console.log("Closing Menu")
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
    console.log("Escape Pressed")
		CancelMenu();
	}
};

loadTheme((theme) => {})
