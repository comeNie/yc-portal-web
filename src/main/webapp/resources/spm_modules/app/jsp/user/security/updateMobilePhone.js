define("app/jsp/user/security/updateMobilePhone",
		function(require, exports, module) {
			var smsObj; // timer变量，控制时间
			var count = 5; // 间隔函数，1秒执行
			var curCount;// 当前剩余秒数
			var accountFlag = false;
			var imgCodeFlag = false;
			var isBandPhone = false;
			var isBandEmail = false;
			var $ = require('jquery'), 
			Widget = require('arale-widget/1.2.0/widget'), 
			Dialog = require("optDialog/src/dialog"), 
			AjaxController = require('opt-ajax/1.0.0/index');
			// 实例化AJAX控制处理对象
			var ajaxController = new AjaxController();
			// 定义页面组件类
			var updatePhonePager = Widget
					.extend({
						/* 事件代理 */
						events : {
							/**
							 * 通过手机修改手机号
							 */
							//发送手机动态码
							"click #send_dynamicode_btn":"_sendDynamiCode",
							//手机验证身份下一步
							"click #next-bt1":"_checkPhoneDynamicode",
							//校验手机号
							"blur #uPhone":"_checkPhone",
							//校验手机合法性
							"click #usend_dynamicode_btn":"_checkPhone",
							//修改手机号，发送动态码
							"click #usend_dynamicode_btn":"_sendUDynamiCode",
							//校验手机和动态码是否匹配
							"click #unext-bt2":"_checkUpdatePhoneDynamicode",

							
							
							/**
							 * 通过邮箱修改手机号
							 */
							//验证身份发送邮件
							"click #sendEmailBtn" : "_sendEmail",
							//邮箱验证下一步
							"click #next-bt4":"_checkEmailImageCode",
							//通过邮箱修改手机号,校验手机号合法性
							"blur #emailUpdatePhone":"_checkEmailUpdatePhone",
							//通过邮箱修改手机号，发送动态码验证
							"click #emailUpDynamicodeBtn":"_sendEmailUPhoneDynamiCode",
							//校验手机和验证码是否匹配，如果匹配则修改手机号
							"click #next-bt5":"_submitValue",
						},
						/* 重写父类 */
						setup : function() {
							updatePhonePager.superclass.setup.call(this);
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
							if(phone!=""&&email==""){
								 $('#set-table1').show();
								 $('#set-table2').hide();
								 $("#set-table1").html("<div class='recharge-success mt-40'><ul><li class='word'>没有绑定手机,无法手机号</li></ul></div>");
							}
							if(phone==""&&email!=""){
								 $('#set-table1').show();
								 $('#set-table2').hide();
								 $("#set-table2").html("<div class='recharge-success mt-40'><ul><li class='word'>没有绑定手机,无法手机号</li></ul></div>");
							}
							if(phone==""&&email==""){
								 $('#set-table1').show();
								 $('#set-table2').hide();
								 $("#set-table1").html("<div class='recharge-success mt-40'><ul><li class='word'>没有绑定手机,无法手机号</li></ul></div>");
								 $("#set-table2").html("<div class='recharge-success mt-40'><ul><li class='word'>没有绑定手机,无法手机号</li></ul></div>");
							}

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
						/**
						 * 发送邮件
						 */
						_sendEmail:function(){
							var _this = this;
							$("#sendEmailBtn").attr("disabled", true);
							ajaxController.ajax({
								type : "POST",
								data : {
									"email": "178070754@qq.com"
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
					  _sendUDynamiCode:function(){
						  if (this._checkPhone()) {
							  this._sendDynamiCode();
						  }
					  },
						/* 发送动态码 */
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
										'type':"2"
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
						 * 校验身份验证手机和验证码是不是匹配
						 */
						_checkPhoneDynamicode:function(){
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
						 * 校验动态码
						 */
						_checkUpdatePhoneDynamicode:function(){
							 var phoneDynamicode = $("#uphoneDynamicode").val();
							 if(phoneDynamicode==null||phoneDynamicode==""){
								 $("#uphoneErrMsg").show();
								 $("#uphoneErrMsg").text("请输入验证码");
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
						/* 手机格式校验 */
						_checkPhone : function() {
							var country = $("#country").find("option:selected");
							var reg = country.attr("reg");
							var phone = $("#uPhone");
							var phoneVal = phone.val();
							if ($.trim(phoneVal) == "") {
								$("#uphoneErrMsg").show();
								$("#uphoneErrMsg").html("手机号不能为空");
								phone.focus();
								return false;
							}else{
								$("#uphoneErrMsg").hide();
								reg = eval('/' + reg + '/');
								if (!reg.test(phoneVal)) {
									$("#uphoneErrMsg").show();
									$("#uphoneErrMsg").html("请输入正确的手机号");
									phone.focus();
									return false;
								}else{
									$("#uphoneErrMsg").hide();
									ajaxController.ajax({
										type : "post",
										processing : false,
										message : "保存中，请等待...",
										url : _base + "/reg/checkPhoneOrEmail",
										data : {
											'checkType' : "phone",
											"checkVal" : $("#uPhone").val()
										},
										success : function(json) {
											if (!json.data) {
												$("#uphoneErrMsg").show();
												$("#uphoneErrMsg").html(json.statusInfo);
											}else{
												$("#uphoneErrMsg").hide();
											}
										}
									});
								}
							}
							return true;
						},
						/**
						 *  通过邮箱地址修改手机号 
						 */
						_checkEmailUpdatePhone : function() {
							var country = $("#country").find("option:selected");
							var reg = country.attr("reg");
							var phone = $("#emailUpdatePhone");
							var phoneVal = phone.val();
							if ($.trim(phoneVal) == "") {
								$("#emailUpdatePhoneErrMsg").show();
								$("#emailUpdatePhoneErrMsg").html("手机号不能为空");
								phone.focus();
								return false;
							}else{
								$("#emailUpdatePhoneErrMsg").hide();
								reg = eval('/' + reg + '/');
								if (!reg.test(phoneVal)) {
									$("#emailUpdatePhoneErrMsg").show();
									$("#emailUpdatePhoneErrMsg").html("请输入正确的手机号");
									phone.focus();
									return false;
								}else{
									$("#emailUpdatePhoneErrMsg").hide();
									ajaxController.ajax({
										type : "post",
										processing : false,
										message : "保存中，请等待...",
										url : _base + "/reg/checkPhoneOrEmail",
										data : {
											'checkType' : "phone",
											"checkVal" : $("#emailUpdatePhone").val()
										},
										success : function(json) {
											if (!json.data) {
												$("#emailUpdatePhoneErrMsg").show();
												$("#emailUpdatePhoneErrMsg").html(json.statusInfo);
											}else{
												$("#emailUpdatePhoneErrMsg").hide();
											}
										}
									});
								}
							}
							return true;
						},
						/* 发送动态码 */
						  _sendEmailUPhoneDynamiCode : function() {
								var _this = this;
								var btn = $("#emailUpDynamicodeBtn");
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
											'phone' : $("#emailUpdatePhone").val(),
											'type':"2"
										},
										success : function(data) {
											if(data.data==false){
												$("#emailUpdatePhoneErrMsg").show();
												$("#emailUpdatePhoneErrMsg").text(data.statusInfo);
												$("#emailUpDynamicodeBtn").removeAttr("disabled"); //移除disabled属性
									            $('#emailUpDynamicodeBtn').val('获取验证码');
												return;
											}else{
												if(data.data){
													var step = 59;
										            $('#emailUpDynamicodeBtn').val('重新发送60');
										            $("#emailUpDynamicodeBtn").attr("disabled", true);
										            var _res = setInterval(function(){
										                $("#emailUpDynamicodeBtn").attr("disabled", true);//设置disabled属性
										                $('#emailUpDynamicodeBtn').val('重新发送'+step);
										                step-=1;
										                if(step <= 0){
										                $("#emailUpDynamicodeBtn").removeAttr("disabled"); //移除disabled属性
										                $('#emailUpDynamicodeBtn').val('获取验证码');
										                clearInterval(_res);//清除setInterval
										                }
										            },1000);
										            $("#emailUpdatePhoneErrMsg").hide();
												}else{
													$("#emailUpDynamicodeBtn").removeAttr("disabled");
												}
										  }
										}
									});
							},
						/**
						 * 邮箱修改手机号，获取动态码
						 */
						_sendEmailPhoneUDynamiCode:function(){
							if (this._checkEmailUpdatePhone()) {
								  this._sendEmailUPhoneDynamiCode();
							  }
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
							 var phoneDynamicode = $("#emailUValidateCode").val();
							 if(phoneDynamicode==null||phoneDynamicode==""){
								 $("#emailUpdatePhoneErrMsg").show();
								 $("#emailUpdatePhoneErrMsg").text("请输入验证码");
								 return false;
							 }
							 ajaxController.ajax({
								    type:"post",
				    				url:_base+"/userCommon/checkSmsCode",
				    				data:{
				    					phone:$("#emailUpdatePhone").val(),
				    					type:"2",
				    					code:$("#emailUValidateCode").val(),
				    				},
				    		        success: function(data) {
				    		        	if(!data.data){
				    		        		$("#emailUpdatePhoneErrMsg").show();
											$("#emailUpdatePhoneErrMsg").text(data.statusInfo);
											return false;
				    		        	}else{
				    		        		 ajaxController.ajax({
				    		        			 type:"post",
								    			 url:_base+"/p/security/updatePhone",
								    			 data:{
								    					phone:$("#emailUpdatePhone").val(),
								    					type:"2",
								    					code:$("#emailUValidateCode").val(),
								    				},
								    				success: function(data) {
								    					var jsonData = JSON.parse(data);
								    		        	if(jsonData.statusCode!="1"){
								    		        		alert("修改失败")
															return false;
								    		        	}else{
								    		        		$("#next5").hide();
								    		        		$("#next6").show();
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
			module.exports = updatePhonePager;
		});