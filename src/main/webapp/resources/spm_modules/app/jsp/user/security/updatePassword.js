define("app/jsp/user/security/updatePassword", function(require, exports, module) {
	var $ = require('jquery'), Widget = require('arale-widget/1.2.0/widget'),
	Dialog = require("optDialog/src/dialog"),
	AjaxController = require('opt-ajax/1.0.0/index');
	// 实例化AJAX控制处理对象
	var ajaxController = new AjaxController();
	// 定义页面组件类
	var updatePasswordPager = Widget.extend({
		/* 事件代理 */
		events : {
			"click #refreshVerificationCode" : "_refreshVerificationCode"
		},
		/* 重写父类 */
		setup : function() {
			updatePasswordPager.superclass.setup.call(this);
			
            },
	 });
	module.exports = updatePasswordPager;
});