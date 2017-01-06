$(function(){
	var bannerHeight;
	if($(window).height() <= 691){
		bannerHeight = 691;
	}else{
		bannerHeight = $(window).height(); 
	}
	$('#rollbanner,#rollbanner .r_banner').height(bannerHeight);
	$("#appCopyright").hide();
	unrollBanner1();
	unrollBanner2();
	unrollBanner3();
	$('#rollbanner .r_banner').pagepiling({
		sectionSelector:'.rb_public',
		navigation:{
            textColor:'#ffffff',
            bulletsColor:'#ffffff'
         },
		//滚动前的回调函数
		onLeave: function(index, nextIndex, direction){
			switch(index)
		    {
		    case 2:
		    	unrollBanner1();
		    	break;
		    case 3:
		    	unrollBanner2();
			    break;
		    case 4:
		    	unrollBanner3();
			    break;
		    }
		},
		//滚动后的回调函数
		afterLoad: function(anchorLink, index){
			switch(index)
		    {
		    case 2:
		    	rollBanner1();
		    	break;
		    case 3:
			    rollBanner2();
			    break;
		    case 4:
			    rollBanner3();
			    $.fn.pagepiling.setAllowScrolling(false);
			    $(document).scroll(function(){
			    	if($(document).scrollTop() == 0){
			    		$.fn.pagepiling.setAllowScrolling(true);
			    	}
			    });
			    break;
		    }
		}
	});
	//roll banner 1 connect
	  function rollBanner1(){
	    var imgLeft = new Array(240,710,380,868);
	    var imgTop = new Array(206,150,380,360);
	    var imgWidth = new Array(154,171,126,126);
	    var imgHeight = new Array(164,166,126,120);
	    $("#rbCon1").show();
	    $("#rbCon1 .rbcd_txt").fadeIn(1200);
	    for(var i=0;i<4;i++){
	      $("#rbCon1 .rbcd_img").children("img").eq(i).css({"width":0,"top":imgTop[i]+"px","left":imgLeft[i]+"px"});
	      $("#rbCon1 .rbcd_img").children("img").eq(i).animate({"width":(imgWidth[i]+30)+"px","top":(imgTop[i]-(imgHeight[i]+30)/2)+"px","left":(imgLeft[i]-(imgWidth[i]+30)/2)+"px"},((i+1)*400));
	      $("#rbCon1 .rbcd_img").children("img").eq(i).animate({"width":imgWidth[i]+"px","top":(imgTop[i]-imgHeight[i]/2)+"px","left":(imgLeft[i]-imgWidth[i]/2)+"px"},30);
	    }
	  }
	//roll banner 1 reset
	  function unrollBanner1(){
	    $("#rbCon1").hide();
	    $("#rbCon1 .rbcd_txt").hide();
	  } 
	//roll banner 2 connect
	  function rollBanner2(){
	    var imgLeft = new Array(30,30,160);
	    var imgTop = new Array(130,240,334);
	    $("#rbCon2 .rbcd_txt").fadeIn(1000);
	    $("#rbCon2 .rbcd_img").children("img").eq(0).show(300);
	    $("#rbCon2 .rbcd_img").children("img").eq(1).delay(300).show(300).animate({"top":imgTop[1]+"px"},300);
	    $("#rbCon2 .rbcd_img").children("img").eq(2).delay(600).show(600).animate({"top":imgTop[2]+"px","left":imgLeft[2]+"px"},300);
	  }
	//roll banner 2 reset
	  function unrollBanner2(){
	    $("#rbCon2 .rbcd_txt").hide();
	    $("#rbCon2 .rbcd_img").children("img").eq(2).css({"display":"none","top":140+"px","left":90+"px"}).siblings().css({"display":"none","top":130+"px","left":30+"px"});
	  }
	//roll banner 3 connect
	  function rollBanner3(){
	    var imgTop = new Array(170,444,226);
	    $("#rbCon3 .rbcd_img").show(500);
	    for(var i=1;i<3;i++){
	      $("#rbCon3 .rbcd_img").children("img").eq(i).animate({"width":37+"px","top":imgTop[i]+"px"},i*500);
	      $("#rbCon3 .rbcd_img").children("img").eq(i).animate({"margin-top":-10+"px"},100);
	      $("#rbCon3 .rbcd_img").children("img").eq(i).animate({"margin-top":0+"px"},100);
	      $("#rbCon3 .rbcd_img").children("img").eq(i).animate({"margin-top":-5+"px"},100);
	      $("#rbCon3 .rbcd_img").children("img").eq(i).animate({"margin-top":0+"px"},100);
	    }
	    $("#appCopyright").show();
	  }
	//roll banner 3 reset
	  function unrollBanner3(){
		$("#appCopyright").hide();
	    $("#rbCon3 .rbcd_img").hide(500);
	    $("#rbCon3 .rbcd_img").children("img").eq(1).css({"width":"90px","top":"0px"});
	    $("#rbCon3 .rbcd_img").children("img").eq(2).css({"width":"90px","top":"0px"});
	  }
})