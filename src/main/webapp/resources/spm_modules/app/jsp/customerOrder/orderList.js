define('app/jsp/customerOrder/orderList', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
	    Widget = require('arale-widget/1.2.0/widget'),
	    AjaxController = require('opt-ajax/1.0.0/index');
    require("jsviews/jsrender.min");
    require("jsviews/jsviews.min");
    require("app/util/jsviews-ext");
	require("opt-paging/aiopt.pagination");
    
    //实例化AJAX控制处理对象
    var ajaxController = new AjaxController();
    
    var orderListPage = Widget.extend({
    	//属性，使用时由类的构造函数传入
    	attrs: {
    		clickId:""
    	},
    	
    	Statics: {
    		DEFAULT_PAGE_SIZE: 10
    	},
    	
    	//事件代理
    	events: {
			"click #submitQuery":"_orderList",
    	},
    	
      	//重写父类
    	setup: function () {
    		orderListPage.superclass.setup.call(this);
    		this._orderList();
    	},
    	
        //表单查询订单列表
        _orderList:function() {
        	var _this = this;
        	var displayFlag = $('#displayFlag option:selected').val();
        	var translateType  = $('#translateType option:selected').val();
        	var translateName  = $('#translateName').val();
        	var orderTimeStart = $("#orderTimeStart").val();
        	var stateChgTimeEnd = $("#stateChgTimeEnd").val();
        	
        	if(translateName.length > 50) {
        		alert("不能超过50个字");
        	}
        	
        	var reqdata = {
 				'displayFlag': displayFlag,
 				'translateType': translateType,
 				'translateName': translateName,
 				'orderTimeStart': orderTimeStart,
 				'stateChgTimeEnd': stateChgTimeEnd,
 				'disFlag': translateName
 				}
        	_this._getOrderList(reqdata);
        },
        
        //根据状态查询订单
        _orderListByType:function(displayFlag) {
        	var reqdata = {'displayFlag': displayFlag}
        	this._getOrderList(reqdata);
        },
        
        //查询订单
        _getOrderList:function(reqdata) {
          	$("#pagination-ul").runnerPagination({
	 			url: _base+"/p/customer/order/orderList",
	 			method: "POST",
	 			dataType: "json",
	 			renderId:"searchOrderData",
	 			messageId:"showMessageDiv",
//	 			 $('#orderQuery').serialize()
	 			data: reqdata,
	           	pageSize: orderListPage.DEFAULT_PAGE_SIZE,
	           	visiblePages:5,
	            render: function (data) {
	            	console.log(data);
	            	if(data != null && data != 'undefined' && data.length>0){
	            		var template = $.templates("#searchOrderTemple");
	            	    var htmlOutput = template.render(data);
	            	    $("#searchOrderData").html(htmlOutput);
	            	}
	            }
    		});
        },
        
        //取消订单
        _cancelOrder:function(orderId) {
        	ajaxController.ajax({
				type: "post",
				url: _base+"/p/customer/order/orderList/cancelOrder",
				data: {'orderId': orderId},
				success: function(data){
					//取消成功
					if("1"===data.statusCode){
					}
				}
			});
        },
    });
    module.exports = orderListPage;
});