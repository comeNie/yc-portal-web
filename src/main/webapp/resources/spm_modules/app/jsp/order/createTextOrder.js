define('app/jsp/order/createTextOrder', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
	    Widget = require('arale-widget/1.2.0/widget'),
	    AjaxController = require('opt-ajax/1.0.0/index');
    require("jsviews/jsrender.min");

    require("jquery-validation/1.15.1/jquery.validate");
	require("app/util/aiopt-validate-ext");
    var CountWordsUtil = require("app/util/countWords");
    
    //实例化AJAX控制处理对象
    var ajaxController = new AjaxController();
    var textOrderAddPager = Widget.extend({
    	//属性，使用时由类的构造函数传入
    	attrs: {
    		clickId:""
    	},
    	
    	//事件代理
    	events: {
			"click #recharge-popo":"_addTextOrderTemp",
			"click #submitOrder":"_addTextOrder",
			"click #toCreateOrder":"_toCreateOrder",
			"click #urgentOrder":"_transPrice",
			"click .dropdown":"_transPrice",
			"click #saveContact":"_saveContact",
			"click #editContact":"_editContactDiv",
			"click #fy-btn": "_uploadFile",
			"click #fy-btn1": "_inputText",
			"click #globalRome": "_setPattern",
           	},
            
    	//重写父类
    	setup: function () {
    		textOrderAddPager.superclass.setup.call(this);
			
			var formValidator=this._initValidate();
			$(":input").bind("focusout",function(){
				formValidator.element(this);
			});
			
			this._transGrade();
			this._transPrice();
			this._globalRome();
			this._initPage();
    	},
        
        _initValidate:function(){
        	var formValidator=$("#textOrderForm").validate({
        		errorPlacement: function(error, element) {
					if (element.is(":checkbox")) {
						error.appendTo(element.parent().parent().parent());
					} else {
						error.insertAfter(element);
					}
						
				},
				highlight: function(element, errorClass) {
					
				}, 
				unhighlight: function(element, errorClass) {
					
				} ,
				errorClass:"x-label",
				showErrors:function(errorMap,errorList) {
					$('ul li p label').remove()//删除所有隐藏的li p label标签
					this.defaultShowErrors();
				},
    			rules: {
    				translateContent: {
    					required:true,
    					maxlength:2000,
    					remote:{
						   url: _base + "/verifyTranslateLan",
			                type:"post",
			                dataType:"json",
			                data:{
			                		lan: $("#selectDuad").find("option:selected").attr("sourceEn"), 
			                		text: $("#translateContent").val()
			                	}
    					}
    				},
    				isAgree: {
    					required:true,
    				},
    				contactName: {
    					required:true,
    					maxlength:15
    				},
    				phoneNum: {
    					required:true,
    				},
    				email: {
    					required:true,
    					email:true
    				}
    			},
    			messages: {
    				translateContent: {
    					required:"请输入翻译内容",
    					maxlength:"最大长度不能超过{0}",
    					remote: "您输入的内容和源语言不一致"
    				},
    				isAgree: {
    					required: "请阅读并同意翻译协议",
    				},
    				contactName: {
    					required: "请输入姓名",
    				},
    				phoneNum: {
    					required:"请输入手机号",
    					pattern: "请输入正确的手机号"
    				},
    				email: {
    					required:"请输入邮箱",
    					email:"请输入正确的邮箱"
    				}
    			}
    		});
    		
    		return formValidator;
        },
            
    	//提交文本订单
		_addTextOrderTemp:function(){
			var _this= this;
        	var formValidator=_this._initValidate();
			formValidator.form();
			if(!$("#textOrderForm").valid()){
				//alert('验证不通过！！！！！');
				return;
			}
			
			this._queryAutoOffer();
			
			var tableFirstLine = $("#textOrderTable tbody tr").eq(0).find("td")
			tableFirstLine.eq(0).html($("#translateContent").val().substring(0,15));
			tableFirstLine.eq(1).html($("#selectDuad").find("option:selected").text());
			tableFirstLine.eq(2).html($("#selectPurpose").find("option:selected").text());
			tableFirstLine.eq(3).html($("#selectDomain").find("option:selected").text());
			tableFirstLine.eq(4).html($(".none-ml.current").find("p").eq(0).html());
			
			$("#textOrderPage").hide();
			$("#contactPage").css('display','block'); 
		},
		
		_addTextOrder:function(){
			var _this= this;
        	var formValidator=_this._initValidate();
			formValidator.form();
			if(!$("#textOrderForm").valid()){
				//alert('验证不通过！！！！！');
				return;
			}
			
			//计算字数
			var transContent = $("#translateContent").val();
			var totalWords = CountWordsUtil.count($("#translateContent").val());
			
			var baseInfo = {};
			var productInfo = {};
			var contactInfo = {};
			var feeInfo = {};
			//区分国内外订单
			if (currentLan.indexOf("zh") >= 0) { 
				baseInfo.orderType = "0";
				baseInfo.flag = "0";
				baseInfo.chlId = "0";
			}else {
				baseInfo.orderType = "1";
				baseInfo.flag = "1";//业务标识 0:国内业务 1：国际业务 ??
				baseInfo.chlId = "1";
			}
			
			baseInfo.orderType = "1"; //??
			baseInfo.busiType = 1;
			if($("li[fileid]").length > 0) {
				baseInfo.translateType = "1"
				
				var fileInfoList = [];
				//判断是文档翻译
				$("li[fileid]").each(function(){   
					var tempObj = {};
					tempObj.fileName = $(this).text();
					tempObj.fileSaveId = $(this).attr("fileid");
					fileInfoList.push(tempObj);    
				});
				productInfo.fileInfoList = fileInfoList;
				
				baseInfo.subFlag = "1";
				productInfo.needTranslateInfo = JSON.stringify(fileInfoList);
				productInfo.translateInfo = "";
				baseInfo.translateName = $("#fileList").find('li:first').text().substring(0,15);
			} else {
				baseInfo.translateType = "0"; //0：快速翻译 1：文档翻译 
				baseInfo.subFlag = "0"; // "0：系统自动报价 1：人工报价"
				productInfo.needTranslateInfo = $("#translateContent").val();
				productInfo.translateInfo = "";
				baseInfo.translateName = $("#translateContent").val().substring(0,15);
			}
			baseInfo.orderLevel = "1";
			baseInfo.userType = "10"; //"10：个人 11：企业 12：代理人 "??
			//baseInfo.corporaId
			//baseInfo.accountId
				
			var today = new Date();
			baseInfo.timeZone = 'GMT+'+(0 - today.stdTimezoneOffset()/60);
			
			productInfo.translateSum = totalWords;
			productInfo.useCode = "222";
			productInfo.fieldCode = "222";
			productInfo.isSetType = "1";
			if ( $("#urgentOrder").is(':checked') )
				productInfo.isUrgent = "Y";
			else 
				productInfo.isUrgent = "N";
				
			var duadList =[];    
			var tempLanPairObj = {};
			tempLanPairObj.languagePairId = $(".dropdown .selected").attr('value');
			tempLanPairObj.languagePairName =  $(".dropdown .selected").text();
			tempLanPairObj.languageNameEn = currentLan.indexOf("zh") >= 0 ? 'zh':'en';
			duadList.push(tempLanPairObj);
			productInfo.languagePairInfoList = duadList;
			
			var translateLevelInfoList=[];
			var tempTranlevObj={};
			tempTranlevObj.translateLevel = $(".none-ml.current").attr('name');
			translateLevelInfoList.push(tempTranlevObj);
			
			productInfo.translateLevelInfoList = translateLevelInfoList;
			
//			contactInfo.contactName =  $("#editContactDiv").find('p').eq(0).html();
//			contactInfo.contactTel  =  $("#editContactDiv").find('p').eq(1).html();
//			contactInfo.contactEmail  =  $("#editContactDiv").find('p').eq(2).html();
			contactInfo.contactName=$("#saveContactDiv").find('input').eq(0).val();
		    contactInfo.contactTel="+"+$("#saveContactDiv").find('option:selected').val()+" "+$("#saveContactDiv").find('input').eq(1).val();
			contactInfo.contactEmail=$("#saveContactDiv").find('input').eq(2).val();
			
			feeInfo.totalFee = 100000;
			feeInfo.currencyUnit = $("#selectDuad").find("option:selected").val();
			
			ajaxController.ajax({
				type: "post",
				processing: true,
				message: "保存中，请等待...",
				url: _base + "/order/save",
				data: {
					baseInfo: JSON.stringify(baseInfo),
					productInfo: JSON.stringify(productInfo),
					contactInfo: JSON.stringify(contactInfo),
					feeInfo: JSON.stringify(feeInfo)
				},
				success: function (data) {
					if ("OK" === data.statusInfo) {
						if(baseInfo.translateType == 0) { //文字翻译
							window.location.href =  _base + "/p/customer/order/payOrder/"+data.data;
						} else {
							
							//文档翻译，跳到待报价页面，暂缺
						}
					} else { //用户未登陆
						window.location.href = _base + "/p/order/orderSubmit?orderType=text";
					}
				}
			});
		},
		
		//查询报价
		_queryAutoOffer:function() {
			if($("li[fileid]").length > 0) {
				$("#price").html("<span>请耐心等待报价！</span>");
				return;
			}
			
			var req={};
			req.wordNum = CountWordsUtil.count($("#translateContent").val());
		    req.duadId = $("#selectDuad").find("option:selected").val();
		    req.purposeId = $("#selectPurpose").find("option:selected").val();
		    
		    req.translateLevel = $(".none-ml.current").attr('name');
		   
	    	if ( $("#urgentOrder").is(':checked') ) 
	    		req.isUrgent  = "1";
			else 
				req.isUrgent  = "0";
		    
			ajaxController.ajax({
				type: "post",
				url: _base + "/order/queryAutoOffer",
				data: {
					reqParams: JSON.stringify(req),
				},
				success: function (data) {
					if ("1" === data.statusCode) {
						var unit;
						if (data.data.currencyUnit === "1")
							unit = "元";
						else
							unit = "$";
						$("#price").html("<span>"+ data.data.price +"</span>"+ unit);
					}
				}
			});
		},
		
		_toCreateOrder:function(){
			$("#textOrderPage").show();
			$("#contactPage").hide();
		},
		
		//翻译等级改变，翻译速度改变
		_transGrade:function() {
			var _this = this;
			$("#transGrade ul").each(function () {
				$(this).click(function () {
					
				
					$(this).children('label').remove();
					$(this).addClass("current");
					$(this).append('<label></label>');
					
					$($(this).siblings()).removeClass("current");
					$($(this).siblings()).children('label').remove();
					
					_this._getSpeed();
				});
			}) 
		},
		
		//初始化页面后做的操作
		_initPage:function() {
			//改变上传div高度
			$("#selectFile").children("div:last").css("height", '70px');
			$("#fy2").hide();
			
		},
		
		//语言对改变，价格改变,翻译速度改变
		_transPrice:function() {
			var _this = this;
			
        	$("#selectDuad").find('option').each(function() {
        		var val = $(this).val();
        		if (val ==  $(".dropdown .selected").attr('value')) {
        			var selected = $(this);

        			var currency;
        			var ordinary = selected.attr("ordinary");
        			var ordinaryUrgent = selected.attr("ordinaryUrgent");
        			var professional = selected.attr("professional");
        			var professionalUrgent = selected.attr("professionalUrgent");
        			var publish = selected.attr("publish");
        			var publishUrgent = selected.attr("publishUrgent");
        			
        			if (currentLan.indexOf("zh") >= 0) {
        				currency = "元";
        			} else {
        				currency = "美元";
        			}
        			
        			if ($("#urgentOrder").is(':checked') ) {
        				$("#stanPrice").html(professionalUrgent).after(currency);
        				$("#proPrice").html(professionalUrgent);
        				$("#pubPrice").html(publishUrgent);
        			} else {
        				$("#stanPrice").html(ordinary);
        				$("#proPrice").html(professional);
        				$("#pubPrice").html(publish);
        			}
        			
        			$("#stanPrice").next('a').html(currency);
    				$("#proPrice").next('a').html(currency);
    				$("#pubPrice").next('a').html(currency);
        		
        		}
            });
		
			this._getSpeed();
		},
		
		//获取翻译速度价格
		_getSpeed:function() {
			var ordSpeed = 2;
			var ordSpeedUrgent = 1;
			var proSpeed = 3;
			var proSpeedUrgent = 2;
			var pubSpeed = 4;
			var pubSpeedUrgent = 3;
			
			if ($("#urgentOrder").is(':checked')) {
				if($(".none-ml.current").attr('name') == 0) {
					$("#speedValue").html(ordSpeedUrgent);
				} else if($(".none-ml.current").attr('name') == 1) {
					$("#speedValue").html(proSpeedUrgent);
				} else {
					$("#speedValue").html(pubSpeedUrgent);
				}
			} else {
				if($(".none-ml.current").attr('name') == 0) {
					$("#speedValue").html(ordSpeed);
				} else if($(".none-ml.current").attr('name') == 1) {
					$("#speedValue").html(proSpeed);
				} else {
					$("#speedValue").html(pubSpeed);
				}
			}
		},
		
		_saveContact:function() {
			$("#saveContactDiv").hide();
			
			$("#editContactDiv").find('p').eq(0).html($("#saveContactDiv").find('input').eq(0).val());
			$("#editContactDiv").find('p').eq(1).html("+"+$("#saveContactDiv").find('option:selected').val()+" "+$("#saveContactDiv").find('input').eq(1).val());
			$("#editContactDiv").find('p').eq(2).html($("#saveContactDiv").find('input').eq(2).val());
			
			$("#editContactDiv").show();
		},
		
		_editContactDiv:function() {
			$("#saveContactDiv").show();
			$("#editContactDiv").hide();
		},
		
		_globalRome:function() {
			$.getJSON(_base + "/resources/spm_modules/app/jsp/order/globalRome.json",function(data){
				$.each(data.row,function(rowIndex,row){
					var selObj = $("#globalRome");
					var text;
					if (currentLan.indexOf("zh") >= 0) {
						text = row["COUNTRY_NAME_CN"];
					} else {
						text = row["COUNTRY_NAME_EN"];
					}
					
					selObj.append("<option value='"+row["COUNTRY_CODE"]+"' exp='" +row["REGULAR_EXPRESSION"]+"'>"+text+"   +"+row["COUNTRY_CODE"]+"</option>");
				});
			});
		},
		
		//文字输入，js控制
		_inputText:function() {
			$("#selectAddedSer").attr("disabled",true);
			$("#selectFormatConv").attr("disabled",true);
			$("#inputFormatConv").hide();
		},
	
		//上传文档，js控制
		_uploadFile:function() {
			$("#selectAddedSer").attr("disabled",false);
			$("#selectFormatConv").attr("disabled",false);
			$("#inputFormatConv").show();
		},
		
		//根据国家设置号码匹配规则
		_setPattern:function() {
			var pattern = $("#saveContactDiv").find('option:selected').attr('exp');
			$("#phoneNum").attr('pattern',pattern);
		}
		
    });
    
    module.exports = textOrderAddPager;
});