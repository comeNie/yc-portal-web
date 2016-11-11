define('app/jsp/order/payOrder', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
	    Widget = require('arale-widget/1.2.0/widget'),
	    AjaxController = require('opt-ajax/1.0.0/index');
    require("jsviews/jsrender.min");

    require("jquery-validation/1.15.1/jquery.validate");
	//require("app/util/aiopt-validate-ext");
    var CountWordsUtil = require("app/util/countWords");
    
    //实例化AJAX控制处理对象
    var ajaxController = new AjaxController();
    
    var payOrderPager = Widget.extend({
    	
    	//事件代理
    	events: {
			"click #recharge-popo":"_payOrder",
			"click #payment-method ul":"_changePayType"
           	},
            
    	//重写父类
    	setup: function () {
			payOrderPager.superclass.setup.call(this);
			this._changePayType();
    	},
		//支付订单
		_payOrder:function(){
			//获取支付方式
			var payType = $("#payment-method .current").eq(0).attr("payType");
			//当前地址
			var merchantUrl = "";
			$("#payType").val(payType);
			$("#merchantUrl").val(window.location.href);
			//提交
			$("#toPayForm").submit();
		},
		//变更支付方式
		_changePayType:function(){
			var _this = this;
			$("#payment-method ul").each(function () {
				$(this).click(function () {
					$(this).children('label').remove();
					$(this).addClass("current");
					$(this).append('<label><i class="icon iconfont">&#xe617;</i></label>');

					$($(this).siblings()).removeClass("current");
					$($(this).siblings()).children('label').remove();
				});
			})
		}
		
    });
    
    module.exports = payOrderPager;
});