$(document).ready(function(){
  $("#int-before").click(function(){
    $(".index-wrapper").animate({top:'150px'},400);
  });
});

//
$(function () {
    $(".banner-hover p").click(function () {
		$(this).children('i').toggleClass(" icon-angle-down   icon-angle-up");
		$(this).parents().parent().children('.banner-sm').slideToggle(50);
    });
});	
//图标遮罩
$(function(){
	$(".item2").hover(
		function(){
			var that=this;
			item2Timer=setTimeout(function(){
				$(that).find('.caption').slideDown(300);
				$(that).find('.item2-txt').fadeOut(200);
			},100);
			
		},
		function(){
			var that=this;
			clearTimeout(item2Timer);
			$(that).find('.caption').slideUp(300);
			$(that).find('.item2-txt').fadeIn(200);
		}
	);
});
//设置密码
$(function(){
  $("#error").click(function(){
  $("#error").hide();
  $("#error-oc").show();
  });
  $("#preser-btn").click(function(){
  $("#error-oc").hide();
  $("#error").show();
  });
  $("#preser-close").click(function(){
  $("#error-oc").hide();
  $("#error").show();
  });
});