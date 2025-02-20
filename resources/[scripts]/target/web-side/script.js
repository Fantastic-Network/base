$(document).ready(function() {
  loadTheme((theme) => {
		
	})

  document.onkeyup = function(event) {
    switch (event["key"]) {
      case "Escape":
        $(".Text").html("");
        $(".Eye").removeClass("red-color-transition").css("color", "#fff");
        $(".Target").css("display", "none");
        $.post("http://target/Close");
        break;
    }
  };
});

window.addEventListener("message", function(event) {
  switch (event["data"]["Action"]) {
    case "Open":
      $(".Text").html("");
      $(".Target").css("display", "flex");
      $(".Eye").removeClass("red-color-transition").css("color", "#fff");
      break;

    case "Close":
      $(".Text").html("");
      $(".Eye").removeClass("red-color-transition").css("color", "#fff");
      $(".Target").css("display", "none");
      break;

    case "Valid":
      $(".Text").html("");
      $(".Eye").addClass("red-color-transition").css("color", "var(--color-main-500)");

      $.each(event["data"]["data"], function(index, item) {
        $(".Text").append(
          "<div class='black' id='Target-" +
            index +
            "'<li>" +
            item["label"] +
            "</li></div>"
        );

        $("#Target-" + index).data("Target", item["event"]);
        $("#Target-" + index).data("Tunnel", item["tunnel"]);
        $("#Target-" + index).data("Service", item["service"]);
      });
      break;

    case "Left":
      $(".Text").html("");
      $(".Eye").removeClass("red-color-transition").css("color", "#fff");
      $(".Target").css("display", "none");
      $.post("http://target/Close");
      break;
  }
});

$(document).on("mousedown", (event) => {
  if (event["target"]["id"].split("-")[0] === "Target") {
    let Target = $("#" + event["target"]["id"]).data("Target");
    let Tunnel = $("#" + event["target"]["id"]).data("Tunnel");
    let Service = $("#" + event["target"]["id"]).data("Service");

    $.post(
      "http://target/Select",
      JSON.stringify({ event: Target, tunnel: Tunnel, service: Service })
    );

    $(".Text").html("");
    $(".Eye").removeClass("red-color-transition").css("color", "#fff");
    $(".Target").css("display", "none");
  }
});
