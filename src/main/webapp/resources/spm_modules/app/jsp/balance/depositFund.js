define('app/jsp/balance/depositFund', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
	    Widget = require('arale-widget/1.2.0/widget');

	require('jquery-i18n/1.2.2/jquery.i18n.properties.min');
    var depositFundPager = Widget.extend({
    	
    	//事件代理
    	events: {
			"click #recharge-popo":"_payOrder",
			"click #completed":"_payRe"
           	},
            
    	//重写父类
    	setup: function () {
			depositFundPager.superclass.setup.call(this);
    	},
		//支付订单
		_payOrder:function(){
			//当前地址
			var merchantUrl = "";
			var orderAmount = $("#orderAmount").val();
			if (orderAmount==""){
				$("#tishi1").html("请输入充值金额");
				return false;
			}
			if (isNaN(orderAmount)) {
				$("#tishi1").html("请输入正确的充值金额");
				return false;
			}
			if (orderAmount<=0){
				$("#tishi1").html("请输入正确的充值金额");
				return;
			}
				$('#eject-mask').fadeIn(100);
				$('#rechargepop').slideDown(100);

			$('#close-completed').click(function(){
				$('#eject-mask').fadeOut(200);
				$('#rechargepop').slideUp(200);
			})
			$("#merchantUrl").val(window.location.href);
				//提交
			$("#toPayForm").submit();

		},
		_payRe:function () {
			$('#eject-mask').fadeOut(200);
			$('#rechargepop').slideUp(200);
		}
    });
    
    module.exports = depositFundPager;
});