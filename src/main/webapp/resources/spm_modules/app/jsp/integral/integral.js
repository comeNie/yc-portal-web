define('app/jsp/integral/integral', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
	    Widget = require('arale-widget/1.2.0/widget'),
	    AjaxController = require('opt-ajax/1.0.0/index');
    require("jsviews/jsrender.min");
    require("jsviews/jsviews.min");
    require("app/util/jsviews-ext");
	require("opt-paging/aiopt.simplePagination");
	require('jquery-i18n/1.2.2/jquery.i18n.properties.min');

    var integralListPage = Widget.extend({
    	//属性，使用时由类的构造函数传入
    	attrs: {
    		clickId:""
    	},
    	
    	Statics: {
    		DEFAULT_PAGE_SIZE: 10
    	},
    	
    	//事件代理
    	events: {
			"click #detai":"_incomeList",
			"click #out":"_incomeList",
			"click #income":"_incomeList"
		},
    	
      	//重写父类
    	setup: function () {
			integralListPage.superclass.setup.call(this);
			$.i18n.properties({//加载资浏览器语言对应的资源文件
				name: ["myaccount","commonRes"], //资源文件名称，可以是数组
				path: _i18n_res, //资源文件路径
				mode: 'both',
                cache: true,
				language: currentLan,
                checkAvailableLanguages: true,
				async: false
			});

    		this._incomeList();
    	},

		_getSearchParams:function(){
			var flag="";
			flag = $('#flag').val();
			return {
				"flag":flag,
			}
		},
    	
        //表单查询收支列表
		_incomeList:function() {
        	var _this = this;
			_this._getIncomerList();
        },
		
        //查询收支列表
		_getIncomerList:function() {
        	var _this = this;
			var queryData = this._getSearchParams();
			$("#pagination-ul").runnerPagination({
	 			url: _base+"/p/integral/integralsList",
	 			method: "POST",
	 			dataType: "json",
	 			renderId:"searchIntegralData",
	 			messageId:"showIntegralDiv",
	 			data: queryData,
	           	pageSize: integralListPage.DEFAULT_PAGE_SIZE,
	           	visiblePages:5,
	            render: function (data) {
					if(window.console){
						console.log(data);
					}
	            	if(data != null && data != 'undefined' && data.length>0){
						var template = $.templates("#searchIntegralTemple");
						var htmlOut = template.render(data);
						$("#searchIntegralData").html(htmlOut);
	            	}
	            }
    		});
        }
		
    });
    module.exports = integralListPage;
});