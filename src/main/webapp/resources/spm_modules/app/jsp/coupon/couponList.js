define('app/jsp/coupon/couponList', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
	    Widget = require('arale-widget/1.2.0/widget'),
	    AjaxController = require('opt-ajax/1.0.0/index');
    require("jsviews/jsrender.min");
    require("jsviews/jsviews.min");
    require("app/util/jsviews-ext");
	require("opt-paging/aiopt.simplePagination");
	require('jquery-i18n/1.2.2/jquery.i18n.properties.min');
    //实例化AJAX控制处理对象
    var ajaxController = new AjaxController();
    
    var couponListPage = Widget.extend({
    	//属性，使用时由类的构造函数传入
    	attrs: {
    		clickId:""
    	},
    	
    	Statics: {
    		DEFAULT_PAGE_SIZE: 10
    	},
    	
    	//事件代理
    	events: {
    	},
    	
      	//重写父类
    	setup: function () {
    		couponListPage.superclass.setup.call(this);
    		// 初始化执行搜索
    		this._searchCouponList();
    	},
    	_searchCouponList:function(status) {
        	var _this = this;
        	if(status==undefined){
        		var status = $("#statusN").val();
        	}
          	$("#pagination-ul").runnerPagination({
	 			url: _base+"/p/coupon/queryCouponList",
	 			method: "POST",
	 			dataType: "json",
	 			renderId:"searchCouponData",
	 			messageId:"showMessageDiv",
	 			data:{status:status},
	           	pageSize: couponListPage.DEFAULT_PAGE_SIZE,
	           	visiblePages:5,
	            render: function (data) {
	            	if(data != null && data != 'undefined' && data.length>0){
	            		var template = $.templates("#searchCouponTemple");
	            	    var htmlOutput = template.render(data);
	            	    $("#searchCouponData").html(htmlOutput);
	            	}
	            }
    		});
        }
    });
    module.exports = couponListPage;
});