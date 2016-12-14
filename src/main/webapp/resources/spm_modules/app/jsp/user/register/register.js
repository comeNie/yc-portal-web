define(
		"app/jsp/user/register/register",
		function(require, exports, module) {
			var smsObj; // timer变量，控制时间
			var count = 120; // 间隔函数
			var curCount;// 当前剩余秒数
			var $ = require('jquery'), Widget = require('arale-widget/1.2.0/widget'), Dialog = require("optDialog/src/dialog"), AjaxController = require('opt-ajax/1.0.0/index');
			// 实例化AJAX控制处理对象
			var ajaxController = new AjaxController();
			// 定义页面组件类
			var registerPager = Widget
					.extend({
						/* 事件代理 */
						events : {
							"click #refreshVerificationCode" : "_refreshVerificationCode",
							"click #send_dynamicode_btn" : "_sendDynamiCode",
							"click #change_register_type" : "_changeRegisterType",
							"blur #verifyCodeImg" : "_checkImageCode",
							"click #regsiterBtn" : "_submitRegsiter",
							"blur #phone" : "_checkPhoneOrEmail",
							"blur #email" : "_checkPhoneOrEmail",
							"blur #password":"_checkPassword",
							"blur #confirmPassword":"_checkConfirmPassword",
							"blur #smsCode":"_checkSmsCode"
							
						},
						/* 重写父类 */
						setup : function() {
							registerPager.superclass.setup.call(this);
							this._loadCountry();

						},
						/* 加载国家 */
						_loadCountry : function() {
							ajaxController.ajax({
								type : "post",
								processing : false,
								message : "保存中，请等待...",
								url : _base + "/userCommon/loadCountry",
								data : {},
								success : function(json) {
									var data = json.data;
									console.log(currentLan);
									if (json.statusCode == "1" && data) {
										var html = [];
										for (var i = 0; i < data.length; i++) {
											var t = data[i];
											var _code = t.countryCode;
											var name = t.countryNameCn;
											if ("zh_CN" != currentLan) {
												name = t.countryNameEn;
											}
											html.push('<option country_value="'+t.countryValue+'" reg="'
													+ t.regularExpression
													+ '" value="' + _code
													+ '" >' + name + '+'
													+ _code + '</option>');
										}
										$("#country").html(html.join(""));
									}
								}
							});
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
								a.html('<i class="icon iconfont">&#xe613;</i>'
										+ registerMsg.phone_registered);
								phone_container.hide();
								phone_code_container.hide();
								email_container.show();
							} else if ("email" == register_type) {// 切换到手机
								a.attr("register_type", "phone");
								a.html('<i class="icon iconfont">&#xe614;</i>'
										+ registerMsg.email_registered);
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
							$("#regsiterMsg").html(msg);
						},
						/* 获取校验信息 */
						_getCheckMsg : function() {
							return $("#regsiterMsg").html();
						},
						/* 手机格式校验 */
						_checkPhone : function() {
							var country = $("#country").find("option:selected");
							var reg = country.attr("reg");
							var countryCode = country.val();
							var phone = $("#phone");
							var phoneVal = phone.val();
							if ($.trim(phoneVal) == "") {
								this._showCheckMsg(registerMsg.account_phone_empty);
								//phone.focus();
								return false;
							}
							phoneVal =countryCode+phoneVal;
							reg = eval('/' + reg + '/');
							if (!reg.test(phoneVal)) {
								this._showCheckMsg(registerMsg.account_phone_error);
								//phone.focus();
								return false;
							}
							return true;
						},
						/* 邮箱校验 */
						_checkEmail : function() {
							var email = $("#email");
							var emailVal = email.val();
							if ($.trim(emailVal) == "") {
								this._showCheckMsg(registerMsg.account_email_empty);
								//email.focus();
								return false;
							}
							if (!/^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/
									.test(emailVal)) {
								this._showCheckMsg(registerMsg.account_email_error);
								//email.focus();
								return false;
							}
							return true;
						},
						/* 校验密码 */
						_checkPassword:function(){
							// 密码校验
							var _this = this;
							var password = $("#password");
							var passwordVal = password.val();
							if ($.trim(passwordVal) == "") {
								this._showCheckMsg(registerMsg.password_empty);
								//password.focus();
								return false;
							}
							var errMsg = _this._getCheckMsg();
							if(errMsg==registerMsg.password_empty){
								_this._showCheckMsg("");
							}
							if (!/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,16}$/
									.test(passwordVal)) {
								this._showCheckMsg(registerMsg.password_error);
								//password.focus();
								return false;
							}
							errMsg = _this._getCheckMsg();
							if(errMsg==registerMsg.password_error){
								_this._showCheckMsg("");
							}
							return true;
						},
						_checkConfirmPassword:function(){
							var _this = this;
							var password = $("#password");
							var passwordVal = password.val();
							// 确认密码
							var confirmPassword = $("#confirmPassword");
							var confirmPasswordVal = confirmPassword.val();
							if ($.trim(confirmPasswordVal) == "") {
								this
										._showCheckMsg(registerMsg.confirm_password_empty);
								//confirmPassword.focus();
								return false;
							}
							var errMsg = _this._getCheckMsg();
							if(errMsg==registerMsg.confirm_password_empty){
								_this._showCheckMsg("");
							}
							if (confirmPasswordVal != passwordVal) {
								this
										._showCheckMsg(registerMsg.confirm_password_error);
								//confirmPassword.focus();
								return false;
							}
							errMsg = _this._getCheckMsg();
							if(errMsg==registerMsg.confirm_password_error){
								_this._showCheckMsg("");
							}
							return true;
						},
						/*短信验证码*/
						_checkSmsCode:function(){
							var smsCode = $("#smsCode");
							var smsCodeVal = smsCode.val();
							if ($.trim(smsCodeVal) == "") {
								this._showCheckMsg(registerMsg.sms_code_empty);
								return false;
							}
							var errMsg = this._getCheckMsg();
							if(errMsg==registerMsg.sms_code_empty){
								this._showCheckMsg("");
							}
							return true;
						},
						/* 校验图片验证码 */
						_checkVerifyCodeImg:function(){
							var verifyCodeImg = $("#verifyCodeImg");
							var verifyCodeImgVal = verifyCodeImg.val();
							if ($.trim(verifyCodeImgVal) == "") {
								this
										._showCheckMsg(registerMsg.verify_code_img_empty);
								//verifyCodeImg.focus();
								return false;
							}
							var errMsg = this._getCheckMsg();
							if(errMsg==registerMsg.verify_code_img_empty){
								this._showCheckMsg("");
							}
							return true;
						},
						/* 校验注册 */
						_checkRegsiter : function() {
							var register_type = $("#change_register_type")
									.attr("register_type");
							var checkFalg = true;
							if ("phone" == register_type) {// 手机注册
								checkFalg = this._checkPhone();
							} else if ("email" == register_type) {// 邮箱注册
								checkFalg = this._checkEmail();
							}
							if (!checkFalg) {
								return false;
							}
							checkFalg = this._checkPassword();
							if (!checkFalg) {
								return false;
							}
							checkFalg = this._checkConfirmPassword();
							if (!checkFalg) {
								return false;
							}
							checkFalg =this._checkVerifyCodeImg();
							if (!checkFalg) {
								return false;
							}
							if ("phone" == register_type) {// 手机注册
								checkFalg = this._checkSmsCode();
								if (!checkFalg) {
									return false;
								}
							}
							
							if ($("[id='agreement']:checked").length < 1) {
								this._showCheckMsg(registerMsg.agreement);
								return false;
							}
							this._showCheckMsg('');
							return true;
						},
						/* 提交注册 */
						_submitRegsiter : function() {
							var regsiterBtn = $("#regsiterBtn");
							if (regsiterBtn.hasClass("biu-btn")) {
								return;
							}
							var falg = this._checkRegsiter();
							if (!falg) {
								return;
							}
								var _this = this;
								var register_type = $("#change_register_type")
										.attr("register_type");
								if ("phone" == register_type) {
									$("#email").val("");
								} else if ("email" == register_type) {
									$("#phone").val("");
								}
								regsiterBtn.removeClass("btn-blue").addClass(
										"biu-btn").attr("style", "color:#fff;");
								ajaxController
										.ajax({
											type : "post",
											processing : false,
											message : " ",
											url : _base + "/reg/submitRegister",
											data : $("#regsiterForm")
													.serializeArray(),
											success : function(json) {
												regsiterBtn.removeClass(
														"biu-btn").addClass(
														"btn-blue");
												if (!json.data) {
													_this
															._showCheckMsg(json.statusInfo);
												} else {
													if ("email" == register_type) {
														location.href = _base
																+ "/reg/toEmail?email="+ $("#email").val();
													} else {
														location.href = _base+ "/reg/toSuccess";
													}
												}
											}
										});
						},
						/* 异步校验图形验证码 */
						_checkImageCode : function() {
							var imgCode = $("#verifyCodeImg");
							var imgCodeVal = imgCode.val();
							if (!this._checkVerifyCodeImg()) {
								return;
							}
							var _this = this;
							ajaxController.ajax({
								type : "post",
								processing : false,
								message : " ",
								url : _base + "/userCommon/checkImageVerifyCode",
								data : {
									'imgCode' : imgCodeVal
								},
								success : function(json) {
									if (!json.data) {
										//imgCode.focus();
										_this._showCheckMsg(json.statusInfo);
									}else{
										//清除帐号校验错误信息
										var errMsg = _this._getCheckMsg();
										if(errMsg==registerMsg.verify_code_img_empty||
										  errMsg==registerMsg.verify_code_img_error){
											_this._showCheckMsg("");
										}
									
									}
								}
							});
						},
						/* 异步校验邮箱或手机 */
						_checkPhoneOrEmail : function() {
							var register_type = $("#change_register_type")
									.attr("register_type");
							var checkVal = '';
							var checkType = '';
							var checkFalg = true;
							if ("email" == register_type) {// 邮箱校验
								checkVal = $("#email").val();
								checkType = "email";
								checkFalg = this._checkEmail();
							} else if ("phone" == register_type) {// 手机
								checkVal = $("#phone").val();
								checkType = "phone";
								checkFalg = this._checkPhone();
							}
							if (!checkFalg) {
								return;
							}

							var _this = this;
							ajaxController.ajax({
								type : "post",
								processing : false,
								message : " ",
								url : _base + "/reg/checkPhoneOrEmail",
								data : {
									'checkType' : checkType,
									"checkVal" : checkVal
								},
								success : function(json) {
									if (!json.data) {
										_this._showCheckMsg(json.statusInfo);
									}else{//清除帐号校验错误信息
										var errMsg = _this._getCheckMsg();
										if(errMsg==registerMsg.account_email_empty||
										  errMsg==registerMsg.account_phone_empty||
										  errMsg==registerMsg.account_email_error ||
										  errMsg==registerMsg.account_phone_error||
										  errMsg==registerMsg.account_exists){
											_this._showCheckMsg("");
										}
									}
								}
							});
						},
						
						/* 发送验证码 */
						_sendDynamiCode : function() {
							if (this._checkPhone()) {
								var _this = this;
								if(!this._checkImageCode()){
									return;
								}
								var btn = $("#send_dynamicode_btn");
								if (btn.hasClass("biu-btn")) {
									return;
								}
								curCount = count;
								var country = $("#country").find("option:selected");
								var countryCode = country.val();
								var country_value = country.attr("country_value");
								var phone_value =$("#phone").val();
								var sendPhoneVal ="+"+countryCode+phone_value; 
								ajaxController
										.ajax({
											type : "post",
											processing : false,
											message : " ",
											url : _base + "/userCommon/sendSmsCode",
											data : {
												'phone' :phone_value,
												'fullPhone' :sendPhoneVal,
												'domainName':country_value,
												'type':'1'
											},
											success : function(json) {
												if(json.statusCode=="1" && json.data){
													btn.val(registerMsg.resend+curCount)
															.removeClass("btn-green")
															.addClass("biu-btn")
															.attr("style","color:#fff;");
													smsObj = window.setInterval(
															_this.startSmsTime,
															1000); // 启动计时器，1秒执行一次
												}else{
													_this._showCheckMsg(json.statusInfo);
												}
											}
										});
							}
						},
						startSmsTime : function() {
							if (curCount == 1) {
								window.clearInterval(smsObj);// 停止计时器
								$("#send_dynamicode_btn").val(
										registerMsg.getDynamiCode).removeClass(
										"biu-btn").addClass("btn-green");
							} else {
								curCount = curCount - 1;
								$("#send_dynamicode_btn").val(registerMsg.resend+curCount);
							}
						}
					});
			module.exports = registerPager;
		});