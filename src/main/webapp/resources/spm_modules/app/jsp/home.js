define('app/jsp/home', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
        Widget = require('arale-widget/1.2.0/widget'),
        AjaxController = require('opt-ajax/1.0.0/index');
    require("jsviews/jsrender.min");
	require("zeroclipboard/ZeroClipboard.min");
    require("jquery-validation/1.15.1/jquery.validate");
    require("app/util/aiopt-validate-ext");
	require('jquery-i18n/1.2.2/jquery.i18n.properties.min');	
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
			"click #humanTranBtn":"_goTextOrder",
			"click .change": "_change",
			"click #error-oc": "_saveText",
			"click #preser-close": "_cancelSave",
			"click #error": "_transError",
        },

        //重写父类
        setup: function () {
            homePage.superclass.setup.call(this);
            
        	//初始化国际化
			$.i18n.properties({//加载资浏览器语言对应的资源文件
				name: ["home"], //资源文件名称，可以是数组
				path: _i18n_res, //资源文件路径
				mode: 'both',
				language: currentLan,
			});
			
			// 定义一个新的复制对象
			var clip = new ZeroClipboard( document.getElementById("copyText"), {
				moviePath: "ZeroClipboard.swf"
			});

			// 复制内容到剪贴板成功后的操作
			clip.on( 'complete', function(client, args) {
				// alert("复制成功，复制内容为："+ args.text);
			} );
        },
		//人工翻译,跳转到笔译订单
       	_goTextOrder:function(){
			window.location.href=_base+"/written";
		},

        //翻译
        _mt:function() {
        	var from = $(".dropdown .selected").eq(0).attr("value");
        	var to = $(".dropdown .selected").eq(1).attr("value");
			if (Window.console){
				console.log("from:"+from+",to:"+to);
			}
        	ajaxController.ajax({
				type: "post",
				url: _base + "/mt",
				data: {
					from: from,
					to: to,
					text: $("#int-before").val()
				},
				success: function (data) {
					if("OK" === data.statusInfo) {
						$("#transRes").val(data.data);
						$("#transResBak").val(data.data);

						//翻译后的文字超过1000，隐藏播放喇叭
						if ($("#transRes").val().length > 1000)
							$("#playControl").hide();
						else
							$("#playControl").show();
					} else {
						alert($.i18n.prop("home.error.trans"));
					}
					
				}
			});
        },
        
        _change:function() {
        	var srcValue = $(".selected").eq(0).attr('value');
        	var srcText = $(".selected").eq(0).html();
        	var disValue = $(".selected").eq(1).attr('value');
        	var disText = $(".selected").eq(1).html();
        	
        	if ($(".selected").eq(0).attr('value') == 'auto') {
        		$("#showb option").each(function() {
        			if ($(this).attr('value') != disValue) {
        				srcValue = $(this).val();
        				srcText = $(this).text();
        				return false;
        			}
        		});
        	}
        		
        	$(".selected").eq(0).attr('value', disValue);
        	$(".selected").eq(0).html(disText);
        	$(".selected").eq(1).attr('value', srcValue);
        	$(".selected").eq(1).html(srcText);
        	
        },
        //文本转音频
        _text2audio:function() {
			//获取目标语言编码
			var to =$(".dropdown .selected").eq(1).attr("value");

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
        
        //保存
        _saveText:function() {
        	$("#transRes").attr("readonly","readonly");
        },
        
        //取消
        _cancelSave:function() {
        	$("#transRes").val($("#transResBak").val());
        	$("#transRes").attr("readonly","readonly");
        },
        
        //翻译有误
        _transError:function() {
        	$("#transRes").removeAttr("readonly");
        }
        
    });

    module.exports = homePage;
});
