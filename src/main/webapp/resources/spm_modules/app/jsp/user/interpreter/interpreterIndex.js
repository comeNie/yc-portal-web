define("app/jsp/user/interpreter/interpreterIndex",function(require, exports, module) {
	var $ = require('jquery'), 
	Widget = require('arale-widget/1.2.0/widget'), 
	Dialog = require("optDialog/src/dialog"), 
	AjaxController = require('opt-ajax/1.0.0/index');
	require("jsviews/jsrender.min");
	require("jsviews/jsviews.min");
	require("app/util/jsviews-ext");
	// 实例化AJAX控制处理对象
	var ajaxController = new AjaxController();
	// 定义页面组件类
	var interpreterIndexPager = Widget
			.extend({
				/* 事件代理 */
				events : {
					 
				},
				/* 初始化 */
				_init:function(){
					this._orderStatusCount();
				},
				/* 获取订单数量 */
				_orderStatusCount:function(){
					ajaxController.ajax({
						 type:"post",
		    				url:_base+"/p/security/orderStatusCount",
		    				data:{'statusList':'21,23'},
		    		        success: function(data) {
		    		        	//data = {"21":3,"23":4};
		    		        	$("#receiveCount").html(data['21']);
		    		        	$("#translateCount").html(data['23']);
		    		        }
		    		});
				},
				/* 重写父类 */
				setup : function() {
					interpreterIndexPager.superclass.setup.call(this);
					this._init();
				}
			});
	module.exports = interpreterIndexPager;
});