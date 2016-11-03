define('app/order/createTextOrder', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
	    Widget = require('arale-widget/1.2.0/widget'),
	    AjaxController = require('opt-ajax/1.0.0/index');
    require("jsviews/jsrender.min");

    var SendMessageUtil = require("app/util/sendMessage");
    
    //实例化AJAX控制处理对象
    var ajaxController = new AjaxController();
    
    var textOrderAddPager = Widget.extend({
    	attrs: {
    		clickId:""
    	},
    	
    	//事件代理
    	events: {
			"click #recharge-popo":"_addTextOrderTemp",
			"click #toCreateOrder":"_toCreateOrder"
            },
            
    	//提交文本订单
		_addTextOrderTemp:function(){
			$("#textOrderPage").hide();
			$("#contactPage").css('display','block'); 
		},
		
		_toCreateOrder:function(){
			$("#textOrderPage").show();
			$("#contactPage").hide();
		}
    });
    
    module.exports = textOrderAddPager;
});