define('app/jsp/customerOrder/orderInfo', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
	    Widget = require('arale-widget/1.2.0/widget'),
	    AjaxController = require('opt-ajax/1.0.0/index');
    
    
    var orderInfoPage = Widget.extend({
    	
    	//事件代理
    	events: {
			"click #payOrder":"_orderPay",
    	},
    	
    	//跳转支付
    	_orderPay:function() {
    		window.location.href="${_base}/p/customer/order/payOrder/"+$("#orderId").val()+"?unit="+$("#unit").val();
    	},
        
    });
    module.exports = orderInfoPage;
});