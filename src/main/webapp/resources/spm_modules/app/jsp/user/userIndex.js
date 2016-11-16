define("app/jsp/user/userIndex",function(require, exports, module) {
	var $ = require('jquery'), 
	Widget = require('arale-widget/1.2.0/widget'), 
	Dialog = require("optDialog/src/dialog"), 
	AjaxController = require('opt-ajax/1.0.0/index');
	// 实例化AJAX控制处理对象
	var ajaxController = new AjaxController();
	// 定义页面组件类
	var userIndexPager = Widget
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
		    				data:{},
		    		        success: function(data) {
		    		        	for(var key in data)
		    		        	{
		    		        	    $("#"+key).html(data[key])
		    		        	}
		    		        }
		    		});
				},
				/* 重写父类 */
				setup : function() {
					userIndexPager.superclass.setup.call(this);
					this._init();
				}
			});
	module.exports = userIndexPager;
});