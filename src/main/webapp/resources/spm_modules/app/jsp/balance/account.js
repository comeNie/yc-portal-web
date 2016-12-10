define('app/jsp/balance/account', function (require, exports, module) {
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
    
    var accountListPage = Widget.extend({
    	//属性，使用时由类的构造函数传入
    	attrs: {
    		clickId:""
    	},
    	
    	Statics: {
    		DEFAULT_PAGE_SIZE: 10
    	},
    	
    	//事件代理
    	events: {
			"click #all":"_incomeList",
			"click #allType":"_incomeList",
			"click #shouru":"_incomeList",
			"click #zhichu":"_incomeList",
			"click #chongzhi":"_incomeList",
			"click #tixian":"_incomeList",
			"click #xiadan":"_incomeList",
			"click #tuikuan":"_incomeList",
			"click #today":"_incomeList",
			"click #oneMonth":"_incomeList",
			"click #threeMonth":"_incomeList",
			"click #oneyear":"_incomeList"

		},
    	
      	//重写父类
    	setup: function () {
			accountListPage.superclass.setup.call(this);
			$.i18n.properties({//加载资浏览器语言对应的资源文件
				name: ["myaccount"], //资源文件名称，可以是数组
				path: _i18n_res, //资源文件路径
				mode: 'both',
				language: currentLan,
				async: false
			});

    		this._incomeList();
    	},
    	
        //表单查询收支列表
		_incomeList:function() {
        	var _this = this;
			_this._getIncomerList();
        },
		
        //查询收支列表
		_getIncomerList:function() {
        	var _this = this;
          	$("#pagination-ul").runnerPagination({
	 			url: _base+"/p/balance/accountList",
	 			method: "POST",
	 			dataType: "json",
	 			renderId:"searchAccountData",
	 			messageId:"showAccountDiv",
//	 			 $('#orderQuery').serialize()
	 			data: $("#accountQuery").serializeArray(),
	           	pageSize: accountListPage.DEFAULT_PAGE_SIZE,
	           	visiblePages:5,
	            render: function (data) {
	            	console.log(data);
	            	if(data != null && data != 'undefined' && data.length>0){
						// for(var i=0;i<data.length;i++) {
						var currencyUnit = data[0].currencyUnit;
						var incomeBalance =  data[0].incomeBalance;
						var outBalance =  data[0].outBalance;
						if (currencyUnit==0){
							var yuan = $.i18n.prop('account.tag.dollar');
						}else {
							var yuan = $.i18n.prop('account.tag.yuan');
						}
						$("#income").html(incomeBalance/1000+yuan);
						$("#out").html(outBalance/1000+yuan);
						if (data[0].payTime!=null){
							var template = $.templates("#searchAccountTemple");
							var htmlOutput = template.render(data);
							$("#searchAccountData").html(htmlOutput);
						}else {
							document.getElementById("showAccountDiv").innerHTML = "<li class='dialog-icon-notquery'></li><li>抱歉没有查询到相关数据</li>";
							document.getElementById("showAccountDiv").className = "not-query pt-20 pb-20";						}
	            	}
	            }
    		});
        },
		
    });
    module.exports = accountListPage;
});