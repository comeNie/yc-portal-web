define("app/jsp/user/password/password",
		function(require, exports, module) {
			var smsObj; // timer变量，控制时间
			var count = 5; // 间隔函数，1秒执行
			var curCount;// 当前剩余秒数
			var accountFlag = false;
			var imgCodeFlag = false;
			var isBindPhone = false;
			var isBindEmail = false;
			var $ = require('jquery'), 
			Widget = require('arale-widget/1.2.0/widget'), 
			Dialog = require("optDialog/src/dialog"), 
			AjaxController = require('opt-ajax/1.0.0/index');
			// 实例化AJAX控制处理对象
			var ajaxController = new AjaxController();
			// 定义页面组件类
			var passwordPager = Widget
					.extend({
						/* 事件代理 */
						events : {
							/**
							 * 刷新验证码
							 */
							"click #refreshVerificationCode" : "_refreshVerificationCode",
							/**
							 * 校验验证码
							 */
							//"blur #verifyCodeImg" : "_checkImageCode",
							/**
							 * 校验账号
							 */
							//"blur #userName" : "_checkAccount",
							/**
							 * 发送邮件
							 */
							"click #sendEmailBtn" : "_sendEmail",
							/**
							 * 账号下一步
							 */
							"click #back-btn":"_nextStep", 
							/**
							 * 发送动态码
							 */
							"click #send_dynamicode_btn":"_sendDynamiCode",
							/**
							 * 手机验证身份下一步
							 */
							"click #next-bt1":"_checkDynamicode",
							/**
							 * 输入密码下一步
							 */
							"click #next-bt2":"_checkPassword",
							/**
							 * 校验密码
							 */
							"blur #password":"_checkPasswordValue",
							/**
							 * 校验验证码
							 */
							"blur  #confirmPassword":"_checkConfirmPasswordValue",
							/**
							 * 邮箱验证下一步
							 */
							"click #next-bt4":"_checkEmailImageCode",
							/**
							 * 邮箱密码
							 */
							"blur #emailPassword":"_checkEmailPasswordValue",
							/**
							 * 邮箱确认密码
							 */
							"blur #emailConfirmPassword":"_checkEmailConfirmPasswordValue",
							/**
							 * 邮件密码
							 */
							"click #next-bt5":"_checkEmailPassword"
							
						},
						/* 重写父类 */
						setup : function() {
							passwordPager.superclass.setup.call(this);
							this._loadCountry();
							$(".set-up a").click(function () {
				                $(".set-up a").each(function () {
				                    $(this).removeClass("current");
				                });
				                $(this).addClass("current");
				            });
							$('.set-up a').click(function(){
							  var index=$('.set-up a').index(this);
							     if(index==0){
							     $('#set-table1').show();
							  	 $('#set-table2').hide();
							   }
							   if(index==1){
							   $('#set-table2').show();
							   $('#set-table1').hide();
							   }
							  });

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
											html.push('<option reg="'
													+ t.regularExpression
													+ '" value="' + _code
													+ '" >' + _code + '+'
													+ name + '</option>');
										}
										$("#country").html(html.join(""));
									}
								}
							});
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
						/* 异步校验图形验证码 */
						_checkImageCode : function() {
							var imgCode = $("#verifyCodeImg");
							var imgCodeVal = imgCode.val();
							if(imgCodeVal==null||imgCodeVal==""){
								$("#verifyCodeImgErrMsg").show();
								$("#verifyCodeImgErrMsg").text("");
								$("#verifyCodeImgErrMsg").text("请输入验证码");
								$("#back-pass").show();
								$("#back-pass1").hide();
								return;
							}
							if ($.trim(imgCodeVal).length < 4) {
								return;
							}
							var _this = this;
							ajaxController.ajax({
								type : "post",
								processing : false,
								message : "保存中，请等待...",
								async: false,
								url : _base + "/userCommon/checkImageVerifyCode",
								data : {
									'imgCode' : imgCodeVal
								},
								success : function(json) {
									if (!json.data) {
										imgCode.focus();
										$("#verifyCodeImgErrMsg").show();
										$("#verifyCodeImgErrMsg").text("校验码信息错误")
									}else{
										$("#verifyCodeImgErrMsg").hide();
										$("#verifyCodeImgErrMsg").text("");
										imgCodeFlag = true;
									}
								}
							});
						},
						/**
						 * 发送邮件
						 */
						_sendEmail:function(){
							var _this = this;
							var sendEmailBtn =$("#sendEmailBtn");
							sendEmailBtn.attr("disabled", true);
							ajaxController.ajax({
								type : "POST",
								data : {
									"email": $("#passwordEmail").html(),
									"type":'5',
									"uid":$("#userId").val()
								},
								dataType: 'json',
								url :_base+"/userCommon/sendEmail",
								processing: true,
								message : "正在处理中，请稍候...",
								success : function(data) {
									var resultCode = data.data;
									if(!resultCode){
										$("#emailErrMsg").show();
										$("#emailErrMsg").text("发送邮件失败");
										sendEmailBtn.removeAttr("disabled"); //移除disabled属性
									}else{
										var step = 59;
										sendEmailBtn.val('重新发送60');
							            var _res = setInterval(function(){
							            	sendEmailBtn.val('重新发送'+step);
							                step-=1;
							                if(step <= 0){
							                	sendEmailBtn.removeAttr("disabled"); //移除disabled属性
							                	sendEmailBtn.val('获取验证码');
							                clearInterval(_res);//清除setInterval
							                }
							            },1000);
									}
								},
								failure : function(){
									sendEmailBtn.removeAttr("disabled"); //移除disabled属性
								},
								error : function(){
									alert("网络连接超时!");
								}
							});
						},
						/**
						 * 校验账号
						 */
						_checkAccount:function(){
							var userName = $("#userName");
							var userNameValue = $("#userName").val();
							if(userNameValue==""||userNameValue==null){
								$("#userNameErrMsg").show();
								$("#userNameText").text("请输入账号");
								return false;
							}else{
								$("#userNameErrMsg").hide();
								$("#userNameText").text("");
								ajaxController.ajax({
									type : "post",
									processing : false,
									async: false,
									message : "保存中，请等待...",
									url : _base + "/password/checkAccountInfo",
									data : {
										'account' : $("#userName").val()
									},
									success : function(jsonData) {
										if(jsonData.responseHeader.resultCode=="111111"){
											$("#userNameErrMsg").show();
											$("#userNameText").text("用户不存在");
											accountFlag = false;
										}
										if(jsonData.responseHeader.resultCode=="000000"){
											
											$("#userNameErrMsg").hide();
											$("#userNameText").text("");
											/**
											 * 保存用户id
											 */
											var userId = jsonData.data.uid;
											$("#userId").val(userId);
											/**
											 * 查看邮箱和手机号是否绑定
											 */
											var telphone = jsonData.data.mobilephone;
											$("#telephone").html(telphone);
											var passwordEmail = jsonData.data.email;
											$("#passwordEmail").html(passwordEmail);
											if(telphone!=null&&telphone!=""){
												 isBindPhone = true;
											}
											if(passwordEmail!=null&&passwordEmail!=""){
												 isBindEmail = true;
											}
											if(isBindPhone||isBindEmail){//绑定任意一个则有帐号
												accountFlag = true;
											}else{
												accountFlag = false;
											}
											
										}
									}
								});
							}
							
						},
					  /**
					   * 账号下一步
					   */
				       _nextStep:function(){
				    	   this._checkAccount();
						   this._checkImageCode();
						   /**
						    * 如果手机号绑定邮箱没有绑定是不能找回密码的
						    * 如果邮箱绑定手机号没有绑定是不能找回密码的
						    */
				    	   if(accountFlag&&imgCodeFlag){
				    		   if(isBindEmail&&!isBindPhone){
				    			   $('#set-table2').show();
								   $('#set-table1').hide();
								   $("#set-table1").html("<div class='recharge-success mt-40'><ul><li class='word'>没有绑定手机,无法通过手机号找回密码</li></ul></div>");
				    		       $("#phoneVerification a").removeClass("current");
				    		       $("#emailVerification a").addClass("current");
				    		   }
				    		   if(!isBindEmail&&isBindPhone){
				    			   $('#set-table1').show();
								   $('#set-table2').hide();
								   $("#set-table2").html("<div class='recharge-success mt-40'><ul><li class='word'>没有绑定邮箱,无法通过邮箱地址找回密码</li></ul></div>");
				    		   }
				    		   if(!isBindEmail&&!isBindPhone){
				    			   $('#set-table1').show();
								   $('#set-table2').hide();
								   $("#set-table1").html("<div class='recharge-success mt-40'><ul><li class='word'>没有绑定手机,无法通过手机号找回密码</li></ul></div>");
								   $("#set-table2").html("<div class='recharge-success mt-40'><ul><li class='word'>没有绑定邮箱,无法通过邮箱地址找回密码</li></ul></div>");
				    		   }
				    		   $("#back-pass").hide();
							   $("#back-pass1").show();
							}
						},
						/* 发送验证码 */
					  _sendDynamiCode : function() {
						var _this = this;
						var btn = $("#send_dynamicode_btn");
						if (btn.hasClass("biu-btn")) {
							return;
						}
						curCount = count;
						ajaxController
							.ajax({
								type : "post",
								processing : false,
								message : "保存中，请等待...",
								url : _base + "/userCommon/sendSmsCode",
								data : {
									'phone' : $("#telephone").html(),
									'type':"2",
									'uid':$("#userId").val()
								},
								success : function(data) {
									if(data.data==false){
										$("#dynamicode").show();
										$("#dynamicode").text(data.statusInfo);
										$("#send_dynamicode_btn").removeAttr("disabled"); //移除disabled属性
							            $('#send_dynamicode_btn').val('获取验证码');
										return;
									}else{
										if(data.data){
											var step = 59;
								            $('#send_dynamicode_btn').val('重新发送60');
								            $("#send_dynamicode_btn").attr("disabled", true);
								            var _res = setInterval(function(){
								                $("#send_dynamicode_btn").attr("disabled", true);//设置disabled属性
								                $('#send_dynamicode_btn').val('重新发送'+step);
								                step-=1;
								                if(step <= 0){
								                $("#send_dynamicode_btn").removeAttr("disabled"); //移除disabled属性
								                $('#send_dynamicode_btn').val('获取验证码');
								                clearInterval(_res);//清除setInterval
								                }
								            },1000);
								            $("#dynamicode").hide();
										}else{
											$("#send_dynamicode_btn").removeAttr("disabled");
										}
								  }
								}
							});
						},
						/**
						 * 校验动态码
						 */
						_checkDynamicode:function(){
							 var phoneDynamicode = $("#phoneDynamicode").val();
							 if(phoneDynamicode==null||phoneDynamicode==""){
								 $("#dynamicode").show();
								 $("#dynamicode").text("请输入验证码");
								 return false;
							 }
							 ajaxController.ajax({
								 type:"post",
				    				url:_base+"/userCommon/checkSmsCode",
				    				data:{
				    					phone:$("#telephone").html(),
				    					type:"2",
				    					code:$("#phoneDynamicode").val(),
				    				},
				    		        success: function(data) {
				    		        	if(!data.data){
				    		        		$("#dynamicode").show();
											$("#dynamicode").text(data.statusInfo);
											return false;
				    		        	}else{
				    		        		 $("#tcode").val(phoneDynamicode);
				    		        		 $("#next1").hide();
				 						     $("#next2").show();
				    		        	}
				    		          },
				    				error: function(error) {
				    						alert("error:"+ error);
				    					}
				    				});
							 
						},
						/**
						 * 输入密码下一步
						 */
						_checkPassword:function(){
							// 密码校验
							var password = $("#password");
							var passwordVal = password.val();
							if ($.trim(passwordVal) == "") {
								this._showCheckMsg(passwordMsg.password_empty);
								$("#passwordMsg").show();
								password.focus();
								return false;
							}
							if (!/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,16}$/
									.test(passwordVal)) {
								this._showCheckMsg(passwordMsg.password_error);
								$("#passwordMsg").show();
								password.focus();
								return false;
							}
							// 确认密码
							var confirmPassword = $("#confirmPassword");
							var confirmPasswordVal = confirmPassword.val();
							if ($.trim(confirmPasswordVal) == "") {
								this._showCheckMsg(passwordMsg.confirm_password_empty);
								$("#passwordMsg").show();
								return false;
							}
							if (confirmPasswordVal != passwordVal) {
								this._showCheckMsg(passwordMsg.confirm_password_error);
								$("#passwordMsg").show();
								return false;
							}
							ajaxController.ajax({
								type:"post",
			    				url:_base+"/password/updatePassword",
			    				data:{
			    					'uid':$("#userId").val(),
			    					'newpw':passwordVal,
			    					'checke_code':$("#tcode").val()
			    				},
			    		        success: function(json) {
			    		        	if(!json.data){
			    		        		alert("保存失败");
			    		        		return false;
			    		        	}else if(json.data){
			    		        		$("#next2").hide();
										$("#next3").show();
			    		        	}
			    		          },
			    				error: function(error) {
			    						alert("error:"+ error);
			    					}
			    				});
						},
						/**
						 * 校验手机密码
						 */
						_checkPasswordValue:function(){
							// 密码校验
							var password = $("#password");
							var passwordVal = password.val();
							if ($.trim(passwordVal) == "") {
								this._showCheckMsg(passwordMsg.password_empty);
								$("#passwordMsg").show();
								password.focus();
								return false;
							}
							if (!/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,16}$/
									.test(passwordVal)) {
								this._showCheckMsg(passwordMsg.password_error);
								$("#passwordMsg").show();
								password.focus();
								return false;
							}
							
						},
						/**
						 * 校验确认密码
						 */
						_checkConfirmPasswordValue:function(){
							// 确认密码
							var confirmPassword = $("#confirmPassword");
							var confirmPasswordVal = confirmPassword.val();
							if ($.trim(confirmPasswordVal) == "") {
								this._showCheckMsg(passwordMsg.confirm_password_empty);
								$("#passwordMsg").show();
								return false;
							}
						},
						/* 展示校验信息 */
						_showCheckMsg : function(msg) {
							$("#passwordMsg").html(msg)
						},
						/**
						 * 校验邮件验证码
						 */
						_checkEmailImageCode:function(){
							var emailIdentifyCode = $("#emailIdentifyCode").val();
							if(emailIdentifyCode==""||emailIdentifyCode==null){
								$("#emailErrMsg").show();
								$("#emailErrMsg").text("请输入验证码");
								return;
							}
							ajaxController.ajax({
								type:"post",
			    				url:_base+"/userCommon/checkEmailCode",
			    				data:{
			    					'email':$("#passwordEmail").html(),
			    					'code':$("#emailIdentifyCode").val(),
			    				},
			    		        success: function(data) {
			    		        	if(!data.data){
			    		        		alert("保存失败");
			    		        		return false;
			    		        	}else{
			    		        		$("#next4").hide();
										$("#next5").show();
										$("#tcode").val($("#emailIdentifyCode").val());
			    		        	}
			    		          },
			    				error: function(error) {
			    						alert("error:"+ error);
			    					}
			    				});
							
						},
						/**
						 * 校验邮箱密码
						 */
						_checkEmailPasswordValue:function(){
							// 密码校验
							var emailPassword = $("#emailPassword");
							var emailPasswordVal = emailPassword.val();
							if ($.trim(emailPasswordVal) == "") {
								$("#emailPasswordErrMsg").show();
								$("#emailPasswordErrMsg").html(passwordMsg.password_empty)
								password.focus();
								return false;
							}
							if (!/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,16}$/
									.test(emailPasswordVal)) {
								$("#emailPasswordErrMsg").show();
								$("#emailPasswordErrMsg").html(passwordMsg.password_error);
								password.focus();
								return false;
							}
							$("#emailPasswordErrMsg").hide();
						},
						/**
						 * 校验确认密码
						 */
						_checkEmailConfirmPasswordValue:function(){
							// 确认密码
							var emailConfirmPassword = $("#emailConfirmPassword");
							var confirmPasswordVal = emailConfirmPassword.val();
							if ($.trim(confirmPasswordVal) == "") {
								$("#emailPasswordErrMsg").html(passwordMsg.confirm_password_error)
								$("#emailPasswordErrMsg").show();
								return false;
							}
							$("#emailPasswordErrMsg").hide();
						},
						/**
						 * 输入邮箱密码下一步
						 */
						_checkEmailPassword:function(){
							// 密码校验
							var password = $("#emailPassword");
							var passwordVal = password.val();
							if ($.trim(passwordVal) == "") {
								this._showCheckMsg(passwordMsg.password_empty);
								$("#emailPasswordErrMsg").show();
								$("#emailPasswordErrMsg").text("密码不能为空");
								password.focus();
								return false;
							}
							if (!/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,16}$/
									.test(passwordVal)) {
								this._showCheckMsg(passwordMsg.password_error);
								$("#emailPasswordErrMsg").text(passwordMsg.password_error);
								$("#emailPasswordErrMsg").show();
								password.focus();
								return false;
							}
							// 确认密码
							var confirmPassword = $("#emailConfirmPassword");
							var confirmPasswordVal = confirmPassword.val();
							if ($.trim(confirmPasswordVal) == "") {
								this._showCheckMsg(passwordMsg.confirm_password_empty);
								$("#emailPasswordErrMsg").show();
								return false;
							}
							if (confirmPasswordVal != passwordVal) {
								this._showCheckMsg("两次密码不一致");
								$("#emailPasswordErrMsg").show();
								return false;
							}
							ajaxController.ajax({
								type:"post",
			    				url:_base+"/password/updatePassword",
			    				data:{
			    					'newpw':passwordVal,
			    					'checke_code':$("#tcode").val(),
			    					'uid':$("#userId").val()
			    				},
			    		        success: function(json) {
			    		        	if(!json.data){
			    		        		alert("保存失败");
			    		        		return false;
			    		        	}else if(json.data){
			    		        		$("#next5").hide();
			    		        		$("#next6").show();
			    		        	}
			    		          },
			    				error: function(error) {
			    						alert("error:"+ error);
			    					}
			    				});
						},
					});
			module.exports = passwordPager;
		});