define('app/jsp/home', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
        Widget = require('arale-widget/1.2.0/widget'),
        AjaxController = require('opt-ajax/1.0.0/index');
    require("jsviews/jsrender.min");

    require("jquery-validation/1.15.1/jquery.validate");
    require("app/util/aiopt-validate-ext");
    var SendMessageUtil = require("app/util/sendMessage");

    //实例化AJAX控制处理对象
    var ajaxController = new AjaxController();

    var homePage = Widget.extend({
        //属性，使用时由类的构造函数传入
        attrs: {
            clickId:""
        },

        //事件代理
        events: {
            "click #recharge-popo":"_addOralOrderTemp",
            "click #toCreateOrder":"_toCreateOrder",
            "click #trante": "_mt",
            "click #playControl": "_text2audio",
			"click #humanTranBtn":"_goTextOrder"
        },

        //重写父类
        setup: function () {
            homePage.superclass.setup.call(this);
        },
		//人工翻译,跳转到笔译订单
       	_goTextOrder:function(){
			window.location.href=_base+"/written";
		},

        //翻译
        _mt:function() {
        	var from;
        	$("#showa option").each(function() {
        		var txt = $(this).text();
        		if (txt == $(".dropdown .selected").eq(0).html())
        			from = $(this).val();

            });
        	
        	var to;
        	$("#showb option").each(function() {
        		if ($(this).text() == $(".dropdown .selected").eq(1).html())
        			to = $(this).val();

            });
        	ajaxController.ajax({
				type: "post",
				url: _base + "/mt",
				data: {
					from: from,
					to: to,
					text: $("#int-before").val()
				},
				success: function (data) {
					$("#transRes").val(data.data.text);
				}
			});
        },
        
        //文本转音频
        _text2audio:function() {
        	var to;
			//获取目标语言编码
        	$("#showb option").each(function() {
        		if ($(this).text() == $(".dropdown .selected").eq(1).html())
        			to = $(this).val();

            });
        	
        	var myAudio = document.getElementById('audioPlay');
	    	if(myAudio.paused){
		        var itostr = $.trim($("#transRes").val());
		        if(itostr != null){
	        		 var playUrl = _base + '/Hcicloud/text2audio?lan='+to+'&text='+itostr;
	        		
	        		 $("#audioPlay").attr("src", playUrl);
	        		 console.log(playUrl);
	        		 myAudio.play();
		        }
	        }else{
	            myAudio.pause();
	        }
        },
        
        //检测语言
        _verifyTranslateLan:function() {
        	ajaxController.ajax({
				type: "post",
				url: _base + "/translateLan",
				data: {
					text: $("#int-before").val(),
				},
				success: function (data) {
					if ("1" === data.statusCode) {
						console.log(data.data);
						//alert("保存成功");
						//保存成功,回退到进入的列表页
//						window.history.go(-1)
					}
				}
			});
        }
        
    });

    module.exports = homePage;
});
