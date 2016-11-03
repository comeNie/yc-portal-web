define("user/register/register",function(require, exports, module){
	 var $=require('jquery'),
	    Widget = require('arale-widget/1.2.0/widget'),
	    Dialog = require("optDialog/src/dialog"),
	    AjaxController = require('opt-ajax/1.0.0/index');
	 //实例化AJAX控制处理对象
	 var ajaxController = new AjaxController();
	 //定义页面组件类
	 var registerPager = Widget.extend({
		/*事件代理*/
    	events: {
			"click #refreshVerificationCode":"_refreshVerificationCode",
			"click #change_register_type":"_changeRegisterType"
            },
            /*重写父类*/
        	setup: function () {
        		registerPager.superclass.setup.call(this);
    			
        	},
        	/*切换注册方式*/
        	_changeRegisterType:function(){
        		var a = $("#change_register_type");
        		var register_type = a.attr("register_type");
        		var phone_container = $("#li_register_phone_container");
        		var phone_code_container = $("#li_register_phone_code_container");
        		var email_container = $("#li_register_email_container");
        		if("phone"==register_type){//切换到email
        			a.attr("register_type","email");
        			a.html('<i class="icon iconfont">&#xe613;</i>手机注册');
        			phone_container.hide();
        			phone_code_container.hide();
        			email_container.show();
        		}else if("email"==register_type){//切换到手机
        			a.attr("register_type","phone");
        			a.html('<i class="icon iconfont">&#xe614;</i>邮箱注册');
        			phone_container.show();
        			phone_code_container.show();
        			email_container.hide();
        		}
        	},
        	/*刷新验证码*/
        	_refreshVerificationCode:function(){
        		var _img = $("#refreshVerificationCode");
        		var url = _img.attr("src");
        		var versionStr = "?version=";
        		var index = url.indexOf(versionStr);
        		if(index>0){
        			url = url.substring(0,index);
        		}
        		url = url+versionStr+ new Date().getTime();
        		_img.attr("src",url);
        		
        	},
        	/*校验密码*/
        	_checkPassword:function(){
        		// /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,18}$/.test(password);
        	} 
	});
	module.exports = registerPager;
});