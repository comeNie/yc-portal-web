//导航下拉
$(function () {
    var st = 100;
    $('.cloud-breadcrumb ul .user .yonh').mouseenter(function () {
		$('.show').show(1);
		 $(this).children('i').rotate({animateTo:180});
    })
		$(".show").click(function () {
                $(this).hide(1);
            });
	$('.cloud-breadcrumb .show').mouseleave(function () {
        $('.show').hide(1);
    });	
		$('.cloud-breadcrumb ul .user .yonh').mouseleave(function () {
        $(this).children('i').rotate({animateTo:0});
    });	
    
  });
 
//左侧菜单关闭
$(function(){
$(".left-tplist i").click(function () {
	$(this).parent('.left-tplist').hide();
	});
	}); 
	
//我的订单 点击展开
$(function () {
    $(".query-order ul .right p .is").click(function () {
		$(this).children('i').toggleClass("icon-angle-down  icon-angle-up");
		$(this).parent().parent().parent().parent().parent().children('.order-hiddn').slideToggle(100);
    });
});	

//我的订单 table
$(function(){
$(".oder-table ul li a").click(function () {
                $(".oder-table ul li a").each(function () {
                    $(this).removeClass("current");
                });
                $(this).addClass("current");
            });
$('.oder-table ul li a').click(function(){
  var index=$('.oder-table ul li a').index(this);
     if(index==0){
     $('#table-da1').show();
  	 $('#table-da2').hide();
  	 $('#table-da3').hide();
  	 $('#table-da4').hide();
  	 $('#table-da5').hide();
   }
   if(index==1){
   $('#table-da2').show();
   $('#table-da1').hide();
   $('#table-da3').hide();
   $('#table-da4').hide();
   $('#table-da5').hide();
   }
   if(index==2){
   $('#table-da3').show();
   $('#table-da2').hide();
   $('#table-da1').hide();
   $('#table-da4').hide();
   $('#table-da5').hide();
   }
   if(index==3){
   $('#table-da4').show();
   $('#table-da3').hide();
   $('#table-da2').hide();
   $('#table-da1').hide();
   $('#table-da5').hide();
   }
   if(index==4){
   $('#table-da5').show();
   $('#table-da3').hide();
   $('#table-da2').hide();
   $('#table-da1').hide();
   $('#table-da4').hide();
   }
  }); 
});

//我的订单 table
$(function(){
$(".oder-table ul li a").click(function () {
                $(".oder-table ul li a").each(function () {
                    $(this).removeClass("current");
                });
                $(this).addClass("current");
            });
$('.oder-table ul li a').click(function(){
  var index=$('.oder-table ul li a').index(this);
     if(index==0){
     $('#translate1').show();
  	 $('#translate2').hide();
   }
   if(index==1){
   $('#translate2').show();
   $('#translate1').hide();
   }
  }); 
});

//订单大厅
$(function () {
    var st = 100;
    $('.right-list-table .dinda').mouseenter(function () {
		$('.table-show').show(1);
    })
		$(".table-show").click(function () {
                $(this).hide(1);
            });
			
		$('.right-list-table').mouseleave(function () {
        $('.table-show').hide(1);
    });	
 }); 
 
//设置密码
$(function(){
  $("#next-bt1").click(function(){
  $(this).hide();
  $("#next2").show();
  });
  $("#next-bt2").click(function(){
  $("#next2").hide();
  $("#next3").show();
  });
  $("#next-bt4").click(function(){
  $("#next4").hide();
  $("#next5").show();
  });
  $("#next-bt5").click(function(){
  $("#next5").hide();
  $("#next6").show();
  });
  $("#fy-btn").click(function(){
  $("#fy1").hide();
  $("#fy2").show();
  });
  $("#fy-btn1").click(function(){
  $("#fy2").hide();
  $("#fy1").show();
  });
  $("#back-btn").click(function(){
  $("#back-pass").hide();
  $("#back-pass1").show();
  });
});


//设置密码 table
$(function(){
$(".set-up a").click(function () {
                $(".set-up a").each(function () {
                    $(this).removeClass("current");
                });
                $(this).addClass("current");
            });
$('.set-up a').click(function(){
  var index=$('.set-up a').index(this);
     if(index==0){
     $('#set-table1').show();
  	 $('#set-table2').hide();
   }
   if(index==1){
   $('#set-table2').show();
   $('#set-table1').hide();
   }
  }); 
});
//翻译 table
$(function(){
$(".prompt-center-title ul li a").click(function () {
                $(".prompt-center-title ul li a").each(function () {
                    $(this).removeClass("current");
                });
                $(this).addClass("current");
            });
$('.prompt-center-title ul li a').click(function(){
  var index=$('.prompt-center-title ul li a').index(this);
     if(index==0){
     $('#tran-tab1').show();
  	 $('#tran-tab2').hide();
  	 $('#tran-tab3').hide();
   }
   if(index==1){
   $('#tran-tab2').show();
   $('#tran-tab1').hide();
   $('#tran-tab3').hide();
   }
   if(index==2){
   $('#tran-tab3').show();
   $('#tran-tab2').hide();
   $('#tran-tab1').hide();
   }
  }); 
});

/**翻译下单去掉最后的线条**/
$(function () {
$(".attachment  ul:last").css("border-bottom","none");
});
//翻译下单关闭附件
$(function(){
$(".attachment ul li i").click(function () {
	$(this).parent().parent('ul').hide();
	});
	}); 
	
//下单
$(function(){
  $("#st1-btn").click(function(){
  $("#st1").hide();
  $("#st2").show();
  });
  $("#st1-btn1").click(function(){
  $("#st2").hide();
  $("#st3").show();
  });
  $("#st1-btn2").click(function(){
  $("#st3").hide();
  $("#st4").show();
  });
  $("#textarea-empty").click(function(){
  $("#empty").show();
  });
  $("#empty").click(function(){
  $(this).hide();
  });
  
});
//协议tba
//我的订单 table
$(function(){
$(".subnav-left ul li a").click(function () {
                $(".subnav-left ul li a").each(function () {
                    $(this).removeClass("current");
                });
                $(this).addClass("current");
            });
$('.subnav-left ul li a').click(function(){
  var index=$('.subnav-left ul li a').index(this);
    if(index==0){
     $('#tab-xy1').show();
  	 $('#tab-xy2').hide();
  	 $('#tab-xy3').hide();
  	 $('#tab-xy4').hide();
  	 $('#tab-xy5').hide();
  	 $('#tab-xy6').hide();
  	 $('#tab-xy7').hide();
  	 $('#tab-xy8').hide();
  	 $('#tab-xy9').hide();
  	 $('#tab-xy10').hide();
   }
   if(index==1){
  	 $('#tab-xy2').show();
  	 $('#tab-xy1').hide();
  	 $('#tab-xy3').hide();
  	 $('#tab-xy4').hide();
  	 $('#tab-xy5').hide();
  	 $('#tab-xy6').hide();
  	 $('#tab-xy7').hide();
  	 $('#tab-xy8').hide();
  	 $('#tab-xy9').hide();
  	 $('#tab-xy10').hide();
   }
   if(index==2){
   	 $('#tab-xy3').show();
  	 $('#tab-xy2').hide();
  	 $('#tab-xy1').hide();
  	 $('#tab-xy4').hide();
  	 $('#tab-xy5').hide();
  	 $('#tab-xy6').hide();
  	 $('#tab-xy7').hide();
  	 $('#tab-xy8').hide();
  	 $('#tab-xy9').hide();
  	 $('#tab-xy10').hide();
   }
   if(index==3){
   	 $('#tab-xy4').show();
  	 $('#tab-xy3').hide();
  	 $('#tab-xy2').hide();
  	 $('#tab-xy1').hide();
  	 $('#tab-xy5').hide();
  	 $('#tab-xy6').hide();
  	 $('#tab-xy7').hide();
  	 $('#tab-xy8').hide();
  	 $('#tab-xy9').hide();
  	 $('#tab-xy10').hide();
   }
   if(index==4){
   	 $('#tab-xy5').show();
  	 $('#tab-xy3').hide();
  	 $('#tab-xy2').hide();
  	 $('#tab-xy1').hide();
  	 $('#tab-xy4').hide();
  	 $('#tab-xy6').hide();
  	 $('#tab-xy7').hide();
  	 $('#tab-xy8').hide();
  	 $('#tab-xy9').hide();
  	 $('#tab-xy10').hide();
   }
   if(index==5){
   	 $('#tab-xy6').show();
  	 $('#tab-xy3').hide();
  	 $('#tab-xy2').hide();
  	 $('#tab-xy1').hide();
  	 $('#tab-xy4').hide();
  	 $('#tab-xy5').hide();
  	 $('#tab-xy7').hide();
  	 $('#tab-xy8').hide();
  	 $('#tab-xy9').hide();
  	 $('#tab-xy10').hide();
   }
   if(index==6){
   	 $('#tab-xy7').show();
  	 $('#tab-xy3').hide();
  	 $('#tab-xy2').hide();
  	 $('#tab-xy1').hide();
  	 $('#tab-xy4').hide();
  	 $('#tab-xy5').hide();
  	 $('#tab-xy6').hide();
  	 $('#tab-xy8').hide();
  	 $('#tab-xy9').hide();
  	 $('#tab-xy10').hide();
   }
   if(index==7){
   	 $('#tab-xy8').show();
  	 $('#tab-xy3').hide();
  	 $('#tab-xy2').hide();
  	 $('#tab-xy1').hide();
  	 $('#tab-xy4').hide();
  	 $('#tab-xy5').hide();
  	 $('#tab-xy7').hide();
  	 $('#tab-xy6').hide();
  	 $('#tab-xy9').hide();
  	 $('#tab-xy10').hide();
   }
   if(index==8){
   	 $('#tab-xy9').show();
  	 $('#tab-xy3').hide();
  	 $('#tab-xy2').hide();
  	 $('#tab-xy1').hide();
  	 $('#tab-xy4').hide();
  	 $('#tab-xy5').hide();
  	 $('#tab-xy7').hide();
  	 $('#tab-xy6').hide();
  	 $('#tab-xy8').hide();
  	 $('#tab-xy10').hide();
   }
   if(index==9){
   	 $('#tab-xy10').show();
  	 $('#tab-xy3').hide();
  	 $('#tab-xy2').hide();
  	 $('#tab-xy1').hide();
  	 $('#tab-xy4').hide();
  	 $('#tab-xy5').hide();
  	 $('#tab-xy7').hide();
  	 $('#tab-xy6').hide();
  	 $('#tab-xy8').hide();
  	 $('#tab-xy9').hide();
   }
  }); 
});


//译者咨询
$(function () {
    $(".consultation-list ul li a").click(function () {
		$(this).children('i').toggleClass("icon-angle-down  icon-angle-up");
		$(this).css("color","#2965e6");
		$(this).parent().parent().parent().parent().children('.consultation-show').slideToggle(100);
		
    });
});	




////旋转
//$(document).ready(function(){
//$("#icon1").rotate({ 
// bind: 
//   { 
//      mouseover : function() { 
//          $(this).rotate({animateTo:180});
//      },
//      mouseout : function() { 
//          $(this).rotate({animateTo:0});
//      }
//   } 
// 
//});
//$("#icon2").rotate({ 
// bind: 
//   { 
//      mouseover : function() { 
//          $(this).rotate({animateTo:180});
//      },
//      mouseout : function() { 
//          $(this).rotate({animateTo:0});
//      }
//   } 
// 
//});
//});
//$(document).ready(function(){
//$(".static-tab ul li a").click(function(){
// $(this).children("#tab-icon2").show();
// $(this).children("#tab-icon1").hide();
//});
//});