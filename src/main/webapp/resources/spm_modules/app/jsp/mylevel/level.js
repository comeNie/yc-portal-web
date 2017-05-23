define('app/jsp/mylevel/level', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
	    Widget = require('arale-widget/1.2.0/widget'),
	    AjaxController = require('opt-ajax/1.0.0/index');
    require("jsviews/jsrender.min");
    require("jsviews/jsviews.min");
    require("app/util/jsviews-ext");
	require("opt-paging/aiopt.simplePagination");
	require('jquery-i18n/1.2.2/jquery.i18n.properties.min');
    var griwthListPage = Widget.extend({
    	//属性，使用时由类的构造函数传入
    	attrs: {
    		clickId:""
    	},
    	
    	Statics: {
    		DEFAULT_PAGE_SIZE: 10
    	},
      	//重写父类
    	setup: function () {
			griwthListPage.superclass.setup.call(this);
    		this._getGriwthList();
    	},
		
        //查询成长值列表
		_getGriwthList:function() {
        	var _this = this;
          	$("#pagination-ul").runnerPagination({
	 			url: _base+"/p/level/griwthList",
	 			method: "POST",
	 			dataType: "json",
	 			renderId:"searchLevelData",
	 			messageId:"showGriwthDiv",
	 			// data: $("#accountQuery").serializeArray(),
	           	pageSize: griwthListPage.DEFAULT_PAGE_SIZE,
	           	visiblePages:5,
	            render: function (data) {
					if(window.console){
						console.log(data);
					}
	            	if(data != null && data != 'undefined' && data.length>0){
						var template = $.templates("#searchGriwthTemple");
						var htmlOutput = template.render(data);
						$("#searchLevelData").html(htmlOutput);
	            	}
	            }
    		});
        }
		
    });
    module.exports = griwthListPage;
});