define("app/jsp/user/security/bindPhone",
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
			var showMsg = function(msg){
		    	var d = Dialog({
					content:msg,
					icon:'fail',
					okValue: phoneBindMsg.showOkValueMsg,
					title: phoneBindMsg.showTitleMsg,
					ok:function(){
						d.close();
					}
				});
				d.showModal();
		    };
			// 实例化AJAX控制处理对象
			var ajaxController = new AjaxController();
			// 定义页面组件类
			var bindPhonePager = Widget
					.extend({
						/* 事件代理 */
						events : {
							/**
							 * 通过手机修改手机号
							 */
							//发送手机动态码
							"click #send_dynamicode_btn":"_sendDynamiCode",
							//校验手机号
							"blur #telephone":"_checkPhone",
							"click #submitPhoneBtn":"_submitPhone"
						 },
						/* 重写父类 */
						setup : function() {
							bindPhonePager.superclass.setup.call(this);
							this._loadCountry();
							},
						_showMsg:function(msg){
							var showErrorDialog = function(msg){
						    	var d = Dialog({
									content:msg,
									icon:'fail',
									okValue: phoneBindMsg.showOkValueMsg,
									title: phoneBindMsg.showTitleMsg,
									ok:function(){
										this.close();
									}
								});
								d.showModal();
						    }
						},
						/* 加载国家 */
						_loadCountry : function() {
							ajaxController.ajax({
								type : "post",
								processing : false,
								message : phoneBindMsg.saveingMsg,
								url : _base + "/userCommon/loadCountry",
								data : {},
								success : function(json) {
									var data = json.data;
									//console.log(currentLan);
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
													+ '" >' +name + '+'
													+  _code + '</option>');
										}
										$("#country").html(html.join(""));
									}
								}
							});
						},
						/* 发送动态码 */
					  _sendDynamiCode : function() {
						  if (!this._checkPhone()) {
							 return;
						  }
							var _this = this;
							var _dynamicode_btn = $("#send_dynamicode_btn");
						  _dynamicode_btn.attr("class", "btn biu-btn radius btn-medium");

						  _dynamicode_btn.attr("disabled", true);
						  var countryValue = $("#country").find("option:selected").attr("value");
						  var _res;
						  ajaxController.ajax({
									type : "post",
									processing : false,
									message : phoneBindMsg.saveingMsg,
									url : _base + "/userCommon/sendSmsCode",
									data : {
										'phone' : $("#telephone").val(),
										'type':"2",
										'countryValue':countryValue,
									},
									success : function(data) {
										if(data.data==false){
											$("#telephoneErrMsg").show();
											$("#telephoneErrMsg").text(data.statusInfo);
											//showMsg(data.statusInfo);
											_dynamicode_btn.removeAttr("disabled"); //移除disabled属性
											_dynamicode_btn.attr("class", "btn border-green border-sma radius btn-medium");
											_dynamicode_btn.val(phoneBindMsg.getOperationCode);
											return;
										}else{
											$("#dynamicode1").hide();
										}
									},
									beforeSend:function(){
										var step = 119;
										_dynamicode_btn.val(phoneBindMsg.resend60);
						                _res = setInterval(function(){
						            	_dynamicode_btn.val(step+"S "+phoneBindMsg.resend);
						                step-=1;
						                if(step < 0){
						                _dynamicode_btn.removeAttr("disabled"); //移除disabled属性
										_dynamicode_btn.attr("class", "btn border-green border-sma radius btn-medium");
						                _dynamicode_btn.val(phoneBindMsg.inputOperationCode);
						                clearInterval(_res);//清除setInterval
						                }
							           },1000);
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
								 $("#dynamicode").text(phoneBindMsg.pleaseInputOC);
								 //showMsg(phoneBindMsg.pleaseInputOC);
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
				    		        		//showMsg(data.statusInfo);
											return false;
				    		        	}else{
				    		        		 $("#next1").hide();
				 						     $("#next2").show();
				    		        	}
				    		          },
				    				error: function(error) {
				    						showMsg("error:"+ error);
				    					}
				    				});
							 
						},
						/* 手机格式校验 */
						_checkPhone : function() {
							var country = $("#country").find("option:selected");
							var reg = country.attr("reg");
							var phone = $("#telephone");
							var phoneVal = phone.val();
							if ($.trim(phoneVal) == "") {
								$("#telephoneErrMsg").show();
								$("#telephoneErrMsg").text(phoneBindMsg.phoneNumCanNotEmpty);
								//phone.focus();
								//showMsg(phoneBindMsg.phoneNumCanNotEmpty);
								return false;
							}else{
								reg = eval('/' + reg + '/');
								if (!reg.test(phoneVal)) {
									$("#telephoneErrMsg").show();
									$("#telephoneErrMsg").text(phoneBindMsg.pleaseInputRightPhoneNum);
									//phone.focus();
									//showMsg(phoneBindMsg.pleaseInputRightPhoneNum);
									return false;
								}else{
									ajaxController.ajax({
										type : "post",
										processing : false,
										async:false,
										message : phoneBindMsg.saveingMsg,
										url : _base + "/reg/checkPhoneOrEmail",
										data : {
											'checkType' : "phone",
											"checkVal" :phoneVal
										},
										success : function(json) {
											if (!json.data) {
												$("#telephoneErrMsg").show();
												$("#telephoneErrMsg").text(json.statusInfo);
												//showMsg(json.statusInfo);
											}else{
												$("#telephoneErrMsg").hide();
											}
										}
									});
								}
							}
							return true;
						},
						_submitPhone:function(){
							if(!this._checkPhone()){
								return;
							}
							/**
							 * 校验动态码
							 */
							 var phoneDynamicode = $("#dynamicode").val();
							 if(phoneDynamicode==null||phoneDynamicode==""){
								 $("#telephoneErrMsg").show();
								 $("#telephoneErrMsg").text(phoneBindMsg.pleaseInputOC);
								 //showMsg(phoneBindMsg.pleaseInputOC);
								 return false;
							 }
							 var countryValue = $("#country").find("option:selected").attr("country_value");
							 ajaxController.ajax({
								    type:"post",
				    				url:_base+"/userCommon/checkSmsCode",
				    				data:{
				    					phone:$("#telephone").val(),
				    					type:"2",
				    					code:phoneDynamicode
				    				},
				    		        success: function(data) {
				    		        	if(!data.data){
				    		        		 $("#telephoneErrMsg").show();
											 $("#telephoneErrMsg").text(data.statusInfo);
				    		        		//showMsg(data.statusInfo);
											return false;
				    		        	}else{
				    		        		 ajaxController.ajax({
				    		        			 type:"post",
								    			 url:_base+"/p/security/updatePhone",
								    			 data:{
								    					phone:$("#telephone").val(),
								    					code:phoneDynamicode,
								    					type:"2",
								    					countryValue:countryValue
								    				},
								    				success: function(json) {
								    					if(!json.data){
								    						 $("#telephoneErrMsg").show();
															 $("#telephoneErrMsg").text(data.statusInfo);
								    		        		//showMsg(json.statusInfo);
															return false;
								    		        	}else{
								    		        		//showMsg(phoneBindMsg.bingSuccess);
								    		        		location.href=_base+"/p/security/bindPhoneSuccess?source="+source;
								    		        	}
								    		          },
								    				error: function(error) {
								    						showMsg("error:"+ error);
								    					}
								    				});
				    		        	}
				    		          },
				    				error: function(error) {
				    						showMsg("error:"+ error);
				    					}
				    				});
						}
					});
			module.exports = bindPhonePager;
		});