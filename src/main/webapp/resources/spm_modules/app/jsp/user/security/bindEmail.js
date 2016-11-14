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
					icon:'info',
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
							
							/**
							 * 通过邮箱修改邮箱
							 */
							//验证身份发送邮件
							"click #sendEmailBtn" : "_sendEmail",
							//邮箱验证下一步
							"click #next-bt4":"_checkEmailImageCode",
							//通过邮箱修改邮箱,校验邮箱合法性
							"blur #bindEmail":"_checkEmail",
							//通过邮箱修改邮箱，发送动态码验证
							"click #email-sendCode-btn":"_sendDynamiCode",
							//校验手机和验证码是否匹配，如果匹配则修改手机号
							"click #bandEmailSubmit":"_submitValue",
						},
						/* 重写父类 */
						setup : function() {
							bindEmailPager.superclass.setup.call(this);
						},
						/**
						 * 发送邮件
						 */
						_sendEmail:function(){
							var _this = this;
							$("#sendEmailBtn").attr("disabled", true);
							ajaxController.ajax({
								type : "POST",
								data : {
									"email": "178070754@qq.com",
									"type":"5"
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
										$("#sendEmailBtn").removeAttr("disabled"); //移除disabled属性
									}else{
										var step = 59;
							            $('#sendEmailBtn').val('重新发送60');
							            $("#sendEmailBtn").attr("disabled", true);
							            var _res = setInterval(function(){
							                $("#sendEmailBtn").attr("disabled", true);//设置disabled属性
							                $('#sendEmailBtn').val('重新发送'+step);
							                step-=1;
							                if(step <= 0){
							                $("#sendEmailBtn").removeAttr("disabled"); //移除disabled属性
							                $('#sendEmailBtn').val('获取验证码');
							                clearInterval(_res);//清除setInterval
							                }
							            },1000);
							            //window.location.href = _base+"/user/bandEmail/sendBandEmailSuccess?email="+$("#email").val();
										
									}
								},
								failure : function(){
									$("#sendEmailBtn").removeAttr("disabled"); //移除disabled属性
								},
								error : function(){
									alert("网络连接超时!");
								}
							});
						},
						/**
						 * 校验动态码
						 */
						_checkUpdatePhoneDynamicode:function(){
							 var phoneDynamicode = $("#uphoneDynamicode").val();
							 if(phoneDynamicode==null||phoneDynamicode==""){
								 $("#updateEmailErrMsg").show();
								 $("#updateEmailErrMsg").text("请输入验证码");
								 return false;
							 }
							 ajaxController.ajax({
								    type:"post",
				    				url:_base+"/userCommon/checkSmsCode",
				    				data:{
				    					phone:$("#uPhone").val(),
				    					type:"2",
				    					code:$("#uphoneDynamicode").val(),
				    				},
				    		        success: function(data) {
				    		        	if(!data.data){
				    		        		$("#uphoneDynamicode").show();
											$("#uphoneDynamicode").text(data.statusInfo);
											return false;
				    		        	}else{
				    		        		 ajaxController.ajax({
				    		        			 type:"post",
								    			 url:_base+"/p/security/updatePhone",
								    			 data:{
								    					phone:$("#uPhone").val(),
								    					type:"2",
								    					code:$("#uphoneDynamicode").val(),
								    				},
								    				success: function(data) {
								    					var jsonData = JSON.parse(data);
								    		        	if(jsonData.statusCode!="1"){
								    		        		alert("修改失败")
															return false;
								    		        	}else{
								    		        		$("#next2").hide();
								    		        		$("#next3").show();
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
						},
						/* 邮箱校验 */
						_checkEmail : function() {
							debugger;
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
							return true;
						},
						/* 发送动态码 */
						_sendDynamiCode : function() {
								var _this = this;
								var btn = $("#email-sendCode-btn");
								if (btn.hasClass("biu-btn")) {
									return;
								}
								curCount = count;
								ajaxController
									.ajax({
										type : "post",
										processing : false,
										message : "保存中，请等待...",
										url : _base + "/userCommon/sendEmail",
										data : {
											'email' : $("#emailValue").val(),
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
			    					email:"178070754@qq.com",
			    					code:$("#emailIdentifyCode").val(),
			    				},
			    		        success: function(data) {
			    		        	if(!data.data){
			    		        		$("#emailErrMsg").show();
			    		        		$("#emailErrMsg").text(data.statusInfo);
			    		        		return false;
			    		        	}else{
			    		        		$("#next4").hide();
										$("#next5").show();
			    		        	}
			    		          },
			    				error: function(error) {
			    						alert("error:"+ error);
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
								    			 url:_base+"/p/security/bindEmail",
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
						},
						_submitEmailValue:function(){
							/**
							 * 校验动态码
							 */
							 var emailDynamicode = $("#phoneUEmailCode").val();
							 if(emailDynamicode==null||emailDynamicode==""){
								 $("#phoneUEmailErrMgs").show();
								 $("#phoneUEmailErrMgs").text("请输入验证码");
								 return false;
							 }
							 ajaxController.ajax({
								    type:"post",
				    				url:_base+"/userCommon/checkEmailCode",
				    				data:{
				    					email:$("#phoneUEmail").val(),
				    					type:"5",
				    					code:$("#phoneUEmailCode").val(),
				    				},
				    		        success: function(data) {
				    		        	if(!data.data){
				    		        		$("#phoneUEmailErrMgs").show();
											$("#phoneUEmailErrMgs").text(data.statusInfo);
											return false;
				    		        	}else{
				    		        		 ajaxController.ajax({
				    		        			 type:"post",
								    			 url:_base+"/p/security/updateEmail",
								    			 data:{
								    				 	email:$("#phoneUEmail").val(),
								    					type:"5",
								    					code:$("#phoneUEmailCode").val(),
								    				},
								    				success: function(data) {
								    					var jsonData = JSON.parse(data);
								    		        	if(jsonData.statusCode!="1"){
								    		        		alert("修改失败")
															return false;
								    		        	}else{
								    		        		$("#next2").hide();
								    		        		$("#next3").show();
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