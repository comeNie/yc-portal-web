define("app/jsp/user/security/bindEmail",
		function(require, exports, module) {
			var smsObj; // timer变量，控制时间
			var count = 5; // 间隔函数，1秒执行
			var curCount;// 当前剩余秒数
			var accountFlag = false;
			var imgCodeFlag = false;
			var isBandPhone = false;
			var isBandEmail = false;
			var showInfoMsg = function(msg){
		    	var d = Dialog({
					content:msg,
					icon:'success',
					okValue: '确 定',
					title: '提示',
					ok:function(){
						this.close();
					}
				});
				d.show();
		    }
			var $ = require('jquery'), 
			Widget = require('arale-widget/1.2.0/widget'), 
			Dialog = require("optDialog/src/dialog"), 
			AjaxController = require('opt-ajax/1.0.0/index');
			// 实例化AJAX控制处理对象
			var ajaxController = new AjaxController();
			// 定义页面组件类
			var bindEmailPager = Widget
					.extend({
						/* 事件代理 */
						events : {
							 //通过邮箱修改邮箱,校验邮箱合法性
							"blur #bindEmail":"_checkEmail",
							//通过邮箱修改邮箱，发送动态码验证
							"click #email-sendCode-btn":"_sendDynamiCode",
							"click #recharge-popo":"_submitValue"
						},
						/* 重写父类 */
						setup : function() {
							bindEmailPager.superclass.setup.call(this);
						},
						/**
						 * 发送邮件
						 */
						/* 邮箱校验 */
						_checkEmail : function() {
							var email = $("#bindEmail");
							var emailVal = email.val();
							if ($.trim(emailVal) == "") {
								$("#emailUErrMsg").show();
								$("#emailUErrMsg").text("请输入邮箱地址");
								//email.focus();
								return false;
							}
							if (!/^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/
									.test(emailVal)) {
								$("#emailUErrMsg").show();
								$("#emailUErrMsg").text("请输入合法邮箱地址");
								return false;
							}
							$("#emailUErrMsg").hide();
							var _this = this;
							ajaxController.ajax({
								type : "post",
								processing : false,
								message : "保存中，请等待...",
								url : _base + "/p/security/checkPhoneOrEmail",
								data : {
									'checkType' : 'email',
									"checkVal" : emailVal
								},
								success : function(json) {
									if (!json.data) {
										showInfoMsg(json.statusInfo);
									}
								}
							});
							return true;
						},
						/* 发送动态码 */
						_sendDynamiCode : function() {
							    if(!this._checkEmail()){
							    	return;
							    }
								var _this = this;
								var btn = $("#email-sendCode-btn");
								if (btn.hasClass("biu-btn")) {
									return;
								}
								ajaxController
									.ajax({
										type : "post",
										processing : false,
										message : "保存中，请等待...",
										url : _base + "/userCommon/sendEmail",
										data : {
											'email' : $("#bindEmail").val(),
											'type':"5"
										},
										success : function(data) {
											if(data.data==false){
												$("#dynamicodeErrMsg").show();
												$("#dynamicodeErrMsg").text(data.statusInfo);
												$("#email-sendCode-btn").removeAttr("disabled"); //移除disabled属性
									            $('#email-sendCode-btn').val('获取验证码');
												return;
											}else{
												if(data.data){
													var step = 59;
										            $('#email-sendCode-btn').val('重新发送60');
										            $("#email-sendCode-btn").attr("disabled", true);
										            var _res = setInterval(function(){
										                $("#email-sendCode-btn").attr("disabled", true);//设置disabled属性
										                $('#email-sendCode-btn').val('重新发送'+step);
										                step-=1;
										                if(step <= 0){
										                $("#email-sendCode-btn").removeAttr("disabled"); //移除disabled属性
										                $('#email-sendCode-btn').val('获取验证码');
										                clearInterval(_res);//清除setInterval
										                }
										            },1000);
										            $("#dynamicodeErrMsg").hide();
												}else{
													$("#email-sendCode-btn").removeAttr("disabled");
												}
										  }
										}
									});
							},
						_submitValue:function(){
							/**
							 * 校验动态码
							 */
							 var emailDynamicode = $("#emailValue").val();
							 if(emailDynamicode==null||emailDynamicode==""){
								 $("#dynamicodeErrMsg").show();
								 $("#dynamicodeErrMsg").text("请输入验证码");
								 return false;
							 }
							 ajaxController.ajax({
								    type:"post",
				    				url:_base+"/userCommon/checkEmailCode",
				    				data:{
				    					email:$("#bindEmail").val(),
				    					type:"5",
				    					code:emailDynamicode,
				    				},
				    		        success: function(data) {
				    		        	if(!data.data){
				    		        		$("#dynamicodeErrMsg").show();
											$("#dynamicodeErrMsg").text(data.statusInfo);
											return false;
				    		        	}else{
				    		        		 ajaxController.ajax({
				    		        			 type:"post",
								    			 url:_base+"/p/security/updateEmail",
								    			 data:{
								    				 	email:$("#bindEmail").val(),
								    					type:"5",
								    					code:emailDynamicode,
								    				},
								    				success: function(data) {
								    					var jsonData = JSON.parse(data);
								    		        	if(jsonData.statusCode!="1"){
								    		        		alert("修改失败")
															return false;
								    		        	}else{
								    		        		alert("绑定成功")
								    		        	}
								    		          },
								    				error: function(error) {
								    						alert("error:"+ error);
								    					}
								    				});
				    		        	}
				    		          },
				    				error: function(error) {
				    						alert("error:"+ error);
				    					}
				    				});
						}
					});
			module.exports = bindEmailPager;
		});