define("app/jsp/user/security/securitycenter", function(require, exports, module) {
	var $ = require('jquery'), Widget = require('arale-widget/1.2.0/widget'),
	Dialog = require("optDialog/src/dialog"),
	AjaxController = require('opt-ajax/1.0.0/index');
	// 实例化AJAX控制处理对象
	var ajaxController = new AjaxController();
	// 定义页面组件类
	var secXXXPager = Widget.extend({
		/* 事件代理 */
		events : {
//			"click #refreshVerificationCode" : "_refreshVerificationCode"
		},
		/* 重写父类 */
		setup : function() {
			secXXXPager.superclass.setup.call(this);
			this._setSecSettingList();
            },
            _setSecSettingList : function () {
            	if(isexistemail == "true") {
            		$("#login_email_icon").attr("class","icon-ok-sign");
            		$("#login_email_icon_color").attr("class","green");
            		var userEmailWithStart = this._getEmailWithStart(userEmail)
            		$("#login_email_text").html("您绑定邮箱：" + userEmailWithStart );
            	}
            	if(isexistphone == "true") {
            		$("#login_phone_icon").attr("class","icon-ok-sign");
            		$("#login_phone_icon_color").attr("class","green");
            		$("#login_phone_text").html("您已绑定手机");
            	}
            	if(isexistpaypassword == "true") {
            		$("#pay_password_icon").attr("class","icon-ok-sign");
            		$("#pay_password_icon_color").attr("class","green");
            		$("#pay_password_text").html("您已经设置支付密码");
            	}
            },
            _getEmailWithStart : function (orginalEmail) {
            	var emailPart = orginalEmail.split("@");
            	var partone = emailPart[0].substring(0,1);
            	var parttwo = "******";
            	var StartEmail = partone + parttwo + "@" + emailPart[1];
            	return StartEmail;
            }
	 });
	module.exports = secXXXPager;
});