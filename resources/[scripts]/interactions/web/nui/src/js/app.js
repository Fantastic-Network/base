$(document).ready(function () {
  loadTheme((theme) => {
		
	})
  window.addEventListener("message", function (event) {
    switch (event.data.action) {
      case "show":
        $('body').show();
      break;
      case "hide":
        $('body').hide();
        break;
      case "updateData":
        $(".key").html(event.data.key)  
        $("#desc").html(event.data.desc)
        $("#action").html(event.data.label)
        break;
      case "updatePos":
        hudPosition(event.data.sX, event.data.sY, event.data.zoom, event.data.camRotZ, event.data.pedRotZ)
        break;
    }
  });
});

function hudPosition(x, y, zoom, camRot, pedRot){
  if(x && y) {
    let width = $( window ).width();
    let height = $( window ).height();
    if (x == -1) {
        $('.menu').css('left', '50%');
        $('.menu').css('top', '50%');
    }
    if (  x*1000.0+width> 710.0 ) {
        x = x*100.0;
        y = y*100.0;

        if( zoom == 4 ) {
            $('.menu').fadeOut(100);    
        } else {
            $('.menu').css('left', x+'%');
            $('.menu').css('top', y+'%');
            $('.menu').fadeIn(100);    
        }
    }
    let rotation = pedRot - camRot;
    if ( rotation < -20.0 ) {
        rotation = -20.0;
    } else if ( rotation > 20.0 ) {
        rotation = 20.0;
    }
    $('.menu').css('transform', 'rotateY('+rotation+'deg)')
    if ( zoom == 0) {
        $('.menu').css('transform', 'scale(0.6)')
    } else if ( zoom == 1 ) {
        $('.menu').css('transform', 'scale(0.7)')
    } else if ( zoom == 2) {
        $('.menu').css('transform', 'scale(0.8)')
    }
  }   
}
