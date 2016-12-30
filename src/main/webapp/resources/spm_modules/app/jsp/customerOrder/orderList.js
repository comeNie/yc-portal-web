define('app/jsp/customerOrder/orderList', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
	    Widget = require('arale-widget/1.2.0/widget'),
		Dialog = require("optDialog/src/dialog"),
	    AjaxController = require('opt-ajax/1.0.0/index');
    require("jsviews/jsrender.min");
    require("jsviews/jsviews.min");
    require("app/util/jsviews-ext");
	require("opt-paging/aiopt.simplePagination");
	require('jquery-i18n/1.2.2/jquery.i18n.properties.min');

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
			"change #displayFlag":"_change",
			"change #translateType":"_orderList"
    	},
    	
      	//重写父类
    	setup: function () {
    		orderListPage.superclass.setup.call(this);
			$.i18n.properties({//加载资浏览器语言对应的资源文件
				name: ["commonRes","orderInfo"], //资源文件名称，可以是数组
				path: _i18n_res, //资源文件路径
				mode: 'both',
				language: currentLan,
                checkAvailableLanguages: true,
				async: true
			});
			this._initPage();
    	},

		//页面初始化查询
		_initPage:function() {
			var displayFlag = $("#displayFlagP").val();
			if (displayFlag == '') {
				this._orderList();
			} else {
				this._orderListByType(displayFlag);
			}
		},

		//时间查询
		_timesearch:function () {
			if ($("#orderTimeStart").val() != '' && $("#orderTimeEnd").val() !='')
				this._getOrderList();
		},
    	
    	//改变状态并查询
    	_change:function() {
    		$(".oder-table a").removeClass('current');
    		$(".oder-table a").eq(0).addClass('current');
    		this._getOrderList();
    	},
    	
        //表单查询订单列表
        _orderList:function() {
        	this._getOrderList();
        },
        
        //根据状态查询订单
        _orderListByType:function(displayFlag) {
        	var req = {'displayFlag': displayFlag,
        					'userId': $("#userId").val()
        	};
        	$("#displayFlag").val(displayFlag);
        	this._getOrderList(req);
        },
        
        //查询订单 reqdata不传时，表单数据序列化
        _getOrderList:function(reqdatadf) {
        	var _this = this;
        	var data;
        	if (reqdatadf == undefined)
        		data = $('#orderQuery').serializeArray();
        	else
        		data = reqdatadf;
        	
          	$("#pagination-ul").runnerPagination({
	 			url: _base+"/p/customer/order/orderList",
	 			method: "POST",
	 			dataType: "json",
	 			renderId:"searchOrderData",
	 			messageId:"showMessageDiv",
//	 			 $('#orderQuery').serializeArray()
	 			data:  data,
	           	pageSize: orderListPage.DEFAULT_PAGE_SIZE,
	           	visiblePages:5,
	            render: function (data) {
	            	if(data != null && data != 'undefined' && data.length>0){
	            		//把返回结果转换
		            	for(var i=0;i<data.length;i++){
		            		//确认截止时间转为 剩余x天x小时x分
		            		var remainingTime = _this.ftimeDHS(data[i].endChgTime - new Date().getTime());
		            		data[i].confirmTakeDays = remainingTime.days;
		            		data[i].confirmTakeHours = remainingTime.hours;
		            		data[i].confirmTakeMinutes =  remainingTime.minutes;
		            		
		            		//支付截止时间转为 剩余x天x小时x分
		            		var payRemTime = _this.ftimeDHS(data[i].endChgTime - new Date().getTime());
		            	    data[i].payTakeDays = payRemTime.days;
		            	    data[i].payTakeHours = payRemTime.hours;
		            	    data[i].payTakeMinutes = payRemTime.minutes;
		            		
		            		data[i].currentLan = currentLan; //当前语言
		            	}
	            		var template = $.templates("#searchOrderTemple");
	            	    var htmlOutput = template.render(data);
	            	    $("#searchOrderData").html(htmlOutput);
	            	}
	            }
    		});
        },
        
        //把毫秒数转为 x天x小时x分钟x秒
        ftimeDHS:function(ts) {
        	var res = {};
        	res.days = parseInt( ts / (1000 * 60 * 60 * 24) );
        	res.hours = parseInt( (ts % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60) );
        	res.minutes = parseInt( (ts % (1000 * 60 * 60)) / (1000 * 60) );
        	res.seconds = parseInt( (ts % (1000 * 60)) / 1000 );
        	
        	return res;
        }
    });
    module.exports = orderListPage;
});