define('app/jsp/customerOrder/orderInfo', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
	    Widget = require('arale-widget/1.2.0/widget'),
	    AjaxController = require('opt-ajax/1.0.0/index');
    
    //实例化AJAX控制处理对象
    var ajaxController = new AjaxController();
    
    var orderInfoPage = Widget.extend({
    	
    	//事件代理
    	events: {
			"click #payOrder":"_orderPay",
			"click #confirmOrder":"_confirm"
    	},
    	
    	//跳转支付
    	_orderPay:function() {
    		window.location.href=_base+"/p/customer/order/payOrder/"+$("#orderId").val()+"?unit="+$("#unit").val();
    	},
    	
//    	下载文件
    	_downLoad:function(fileId, fileName) {
    		window.open(_base + "/p/customer/order/download?fileId="+fileId+"&fileName="+fileName);
    	},

		//确认订单
		_confirm:function() {
			ajaxController.ajax({
				type: "post",
				url: _base + "/p/trans/order/updateState",
				data: {
					orderId: $("#orderId").val(),
					state: "90",
					displayFlag: "90",
				},
				success: function (data) {
					if ("1" === data.statusCode) {
						//成功
						//刷新页面
						window.location.reload();
					}
				}
			});
		},

		//提交订单
		_orderSubmit:function(orderId) {
			ajaxController.ajax({
				type: "post",
				url: _base + "/p/trans/order/save",
				data: {
					orderId: orderId,
				},
				success: function (data) {
					if ("1" === data.statusCode) {
						//提交成功
						window.location.reload();
					}
				}
			});
		},
        
    });
    module.exports = orderInfoPage;
});