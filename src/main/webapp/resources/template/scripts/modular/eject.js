//提示弹出框 
jQuery(document).ready(function($) {
	$('#recharge-popo').click(function(){
	$('#eject-mask').fadeIn(100);
	$('#rechargepop').slideDown(100);
	})
	$('#completed').click(function(){
	$('#eject-mask').fadeOut(200);
	$('#rechargepop').slideUp(200);
	})
	$('#close-completed').click(function(){
	$('#eject-mask').fadeOut(200);
	$('#rechargepop').slideUp(200);
	})
})

//译员弹出框 
jQuery(document).ready(function($) {
	$('#tran-popo').click(function(){
	$('#eject-mask').fadeIn(100);
	$('#tran').slideDown(100);
	})
	$('#tran-determine').click(function(){
	$('#eject-mask').fadeOut(200);
	$('#tran').slideUp(200);
	})
	$('#tran-close').click(function(){
	$('#eject-mask').fadeOut(200);
	$('#tran').slideUp(200);
	})
})