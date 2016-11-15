define('app/jsp/transOrder/taskCenter', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
	    Widget = require('arale-widget/1.2.0/widget'),
	    AjaxController = require('opt-ajax/1.0.0/index');
    require("jsviews/jsrender.min");
    require("jsviews/jsviews.min");
    require("app/util/jsviews-ext");
	require("opt-paging/aiopt.pagination");
	require("my97DatePicker/WdatePicker");
    
    var taskCenterPage = Widget.extend({
    	//属性，使用时由类的构造函数传入
    	attrs: {
    		clickId:""
    	},
    	
    	Statics: {
    		DEFAULT_PAGE_SIZE: 10
    	},
    	
    	//事件代理
    	events: {
			"click #searchBtn":"_getOrderList",
			"change #fieldCode":"_getOrderList",
			"change #useCode":"_getOrderList"
    	},
    	
      	//重写父类
    	setup: function () {
			taskCenterPage.superclass.setup.call(this);
    		this._getOrderList();
    	},
        
        //查询订单
        _getOrderList:function() {
        	var _this = this;
			if(window.console)
				console.log("quer list");
          	$("#pagination-ul").runnerPagination({
	 			url: _base+"/p/taskcenter/list",
	 			method: "POST",
	 			dataType: "json",
	 			renderId:"orderInfoTable",
	 			messageId:"showMessageDiv",
//	 			 $('#orderQuery').serialize()
	 			data: $("#orderQuery").serializeArray(),
	           	pageSize: taskCenterPage.DEFAULT_PAGE_SIZE,
	           	visiblePages:5,
	            render: function (data) {
	            	if(data != null && data != 'undefined' && data.length>0){
	            		var template = $.templates("#searchOrderTemple");
	            	    var htmlOutput = template.render(data);
	            	    $("#orderInfoTable").html(htmlOutput);
	            	}
	            }
    		});
        }
    });
    module.exports = taskCenterPage;
});