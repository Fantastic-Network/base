$(document).ready(function(){
	window.addEventListener("message",function(event){
        window.invokeNative('openUrl', event['data']['url']);
	});
});