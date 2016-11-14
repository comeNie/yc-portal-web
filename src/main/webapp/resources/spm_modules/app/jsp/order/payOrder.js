define('app/jsp/order/payOrder', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
	    Widget = require('arale-widget/1.2.0/widget');
    var payOrderPager = Widget.extend({
    	
    	//事件代理
    	events: {
			"click #recharge-popo":"_payOrder",
			"click #payment-method ul":"_changePayType",
			"click #completed":"_submitYEpay",//余额支付确认
			"click #close-completed":"_closeCompleted"//余额支付取消
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
			//若为余额支付,则进行余额支付流程
			if("YE" != payType){
				$("#merchantUrl").val(window.location.href);
				//提交
				$("#toPayForm").submit();
			}//余额支付,需要密码
			else if("YE" === payType && needPayPass==="1"){
				$("#payPass").val("");
				$('#eject-mask').fadeIn(100);
				$('#rechargepop').slideDown(100);
			}//余额支付不需要密码
			else if("YE" === payType){
				$("#yePayForm").submit();
			}

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
			});
		},
		//关闭支付密码弹出框
		_closeCompleted:function(){
			$('#eject-mask').fadeOut(200);
			$('#rechargepop').slideUp(200);
		},
		//提交余额支付
		_submitYEpay:function(){
			var payPass=$("#payPass").val();
			$("#balancePass").val(payPass);
			//提交
			$("#yePayForm").submit();
		}
		
    });
    
    module.exports = payOrderPager;
});