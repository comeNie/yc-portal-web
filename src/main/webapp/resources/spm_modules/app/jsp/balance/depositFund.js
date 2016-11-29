define('app/jsp/balance/depositFund', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
	    Widget = require('arale-widget/1.2.0/widget');

	require('jquery-i18n/1.2.2/jquery.i18n.properties.min');
    var depositFundPager = Widget.extend({
    	
    	//事件代理
    	events: {
			"click #recharge-popo":"_payOrder",
           	},
            
    	//重写父类
    	setup: function () {
			depositFundPager.superclass.setup.call(this);
    	},
		//支付订单
		_payOrder:function(){
			//当前地址
			var merchantUrl = "";
			
			$("#merchantUrl").val(window.location.href);
				//提交
			$("#toPayForm").submit();

		},
    });
    
    module.exports = depositFundPager;
});