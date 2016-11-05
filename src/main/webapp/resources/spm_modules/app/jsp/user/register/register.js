define(
		"app/jsp/user/register/register",
		function(require, exports, module) {
			var $ = require('jquery'), Widget = require('arale-widget/1.2.0/widget'), Dialog = require("optDialog/src/dialog"), AjaxController = require('opt-ajax/1.0.0/index');
			// 实例化AJAX控制处理对象
			var ajaxController = new AjaxController();
			var zh_cn_msg = {
					"email_empty":"请输入邮箱",
					"email_error":"请输入正确的邮箱",
					"password_empty":"请输入密码",
					"password_error":"请输入6~16位数字和字母",
					"confirm_password_empty":"请输入密码",
					"confirm_password_error":"两次密码不一致",
					"verify_code_img_empty":"请输入验证码",
					"verify_code_img_error":"验证码错误",
					"agreement":"您还未接受翻译条款"
			};
			var registerMsg = zh_cn_msg;
			// 定义页面组件类
			var registerPager = Widget
					.extend({
						/* 事件代理 */
						events : {
							"click #refreshVerificationCode" : "_refreshVerificationCode",
							"click #change_register_type" : "_changeRegisterType",
							"blur #verifyCodeImg":"_checkImageCode",
							"click #regsiterBtn" : "_submitRegsiter",
							"blur #phone":"_checkPhoneOrEmail",
							"blur #email":"_checkPhoneOrEmail"
						},
						/* 重写父类 */
						setup : function() {
							registerPager.superclass.setup.call(this);

						},
						/* 切换注册方式 */
						_changeRegisterType : function() {
							var a = $("#change_register_type");
							var register_type = a.attr("register_type");
							var phone_container = $("#li_register_phone_container");
							var phone_code_container = $("#li_register_phone_code_container");
							var email_container = $("#li_register_email_container");
							if ("phone" == register_type) {// 切换到email
								a.attr("register_type", "email");
								a
										.html('<i class="icon iconfont">&#xe613;</i>手机注册');
								phone_container.hide();
								phone_code_container.hide();
								email_container.show();
							} else if ("email" == register_type) {// 切换到手机
								a.attr("register_type", "phone");
								a
										.html('<i class="icon iconfont">&#xe614;</i>邮箱注册');
								phone_container.show();
								phone_code_container.show();
								email_container.hide();
							}
						},
						/* 刷新验证码 */
						_refreshVerificationCode : function() {
							var _img = $("#refreshVerificationCode");
							var url = _img.attr("src");
							var versionStr = "?version=";
							var index = url.indexOf(versionStr);
							if (index > 0) {
								url = url.substring(0, index);
							}
							url = url + versionStr + new Date().getTime();
							_img.attr("src", url);

						},
						/* 展示校验信息 */
						_showCheckMsg : function(msg) {
							$("#regsiterMsg").html(msg)
						},
						/* 校验注册 */
						_checkRegsiter : function() {
							var register_type = $("#change_register_type")
									.attr("register_type");
							if ("phone" == register_type) {// 手机注册

							} else if ("email" == register_type) {// 邮箱注册
								var email = $("#email");
								var emailVal = email.val();
								if ($.trim(emailVal) == "") {
									this._showCheckMsg(registerMsg.email_empty);
									email.focus();
									return false;
								}
								if (!/^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/
										.test(emailVal)) {
									this._showCheckMsg(registerMsg.email_error);
									email.focus();
									return false;
								}
							}
							// 密码校验
							var password = $("#password");
							var passwordVal = password.val();
							if ($.trim(passwordVal) == "") {
								this._showCheckMsg(registerMsg.password_empty);
								password.focus();
								return false;
							}

							if (!/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,16}$/
									.test(passwordVal)) {
								this._showCheckMsg(registerMsg.password_error);
								password.focus();
								return false;
							}
							// 确认密码
							var confirmPassword = $("#confirmPassword");
							var confirmPasswordVal = confirmPassword.val();
							if ($.trim(confirmPasswordVal) == "") {
								this._showCheckMsg(registerMsg.confirm_password_empty);
								confirmPassword.focus();
								return false;
							}
							if (confirmPasswordVal != passwordVal) {
								this._showCheckMsg(registerMsg.confirm_password_error);
								confirmPassword.focus();
								return false;
							}
							var verifyCodeImg = $("#verifyCodeImg");
							var verifyCodeImgVal = verifyCodeImg.val();
							if ($.trim(verifyCodeImgVal) == "") {
								this._showCheckMsg(registerMsg.verify_code_img_empty);
								verifyCodeImg.focus();
								return false;
							}
							if($("[id='agreement']:checked").length<1){
								this._showCheckMsg(registerMsg.agreement);
								return false;
							}
							this._showCheckMsg('');
							return true;
						},
						/* 提交注册 */
						_submitRegsiter : function() {
							var regsiterBtn = $("#regsiterBtn");
							if(regsiterBtn.hasClass("biu-btn")){
								return;
							}
							var falg = this._checkRegsiter();
							if(falg){
								var _this =this;
								var sendData = {};
								var a = $("#regsiterForm").serializeArray();
								$.each(a, function () {
								if (sendData[this.name] !== undefined) {
								if (!sendData[this.name].push) {
								sendData[this.name] = [sendData[this.name]];
								}
								sendData[this.name].push(this.value || '');
								} else {
								sendData[this.name] = this.value || '';
								}
								});
								var register_type = $("#change_register_type").attr("register_type");
								if ("phone" == register_type) {
									sendData.email='';
								} else if ("email" == register_type) {
									sendData.phone='';
								}
								regsiterBtn.removeClass("btn-blue").addClass("biu-btn").attr("style","color:#fff;");
								ajaxController.ajax({
									type: "post",
									processing: false,
									message: "保存中，请等待...",
									url: _base + "/reg/submitRegister",
									data: sendData,
									success: function (json) {
										regsiterBtn.removeClass("biu-btn").addClass("btn-blue");
										if(!json.data){
											_this._showCheckMsg(json.statusInfo);
										}else{
											 if ("email" == register_type) {
												 location.href= _base + "/reg/toEmail?email="+sendData.email;
											 }else{
												 location.href= _base + "/reg/toSuccess"; 
											 }
										}
									}
								});
							}
						},
						/*异步校验图形验证码*/
						_checkImageCode:function(){
							var imgCode = $("#verifyCodeImg");
							var imgCodeVal = imgCode.val();
							if($.trim(imgCodeVal).length<4){
								return;
							}
							var _this =this;
							ajaxController.ajax({
								type: "post",
								processing: false,
								message: "保存中，请等待...",
								url: _base + "/reg/checkImageVerifyCode",
								data: {'imgCode': imgCodeVal},
								success: function (json) {
									if(!json.data){
										imgCode.focus();
										_this._showCheckMsg(json.statusInfo);
									}
								}
							});
						},
						/*异步校验邮箱或手机*/
						_checkPhoneOrEmail:function(){
							var register_type = $("#change_register_type").attr("register_type");
							var checkVal = $("#phone").val();
							var checkType = "phone";
							if("email"==register_type){//邮箱校验
								checkVal = $("#email").val();
								checkType = "email";
							}
							
							if($.trim(checkVal).length<5){
								return;
							}
							var _this =this;
							ajaxController.ajax({
								type: "post",
								processing: false,
								message: "保存中，请等待...",
								url: _base + "/reg/checkPhoneOrEmail",
								data: {'checkType': checkType,"checkVal":checkVal},
								success: function (json) {
									if(!json.data){
										_this._showCheckMsg(json.statusInfo);
									}
								}
							});
						}
					});
			module.exports = registerPager;
		});