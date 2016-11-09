define('app/jsp/order/createTextOrder', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
	    Widget = require('arale-widget/1.2.0/widget'),
	    AjaxController = require('opt-ajax/1.0.0/index');
    require("jsviews/jsrender.min");

    require("jquery-validation/1.15.1/jquery.validate");
	//require("app/util/aiopt-validate-ext");
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
			"change #selectDuad":"_transPrice",
			"click #saveContact":"_saveContact",
			"click #editContact":"_editContactDiv",
			"click #fy-btn": "_uploadFile",
			"click #fy-btn1": "_inputText",
			"click #globalRome": "_setPattern",
           	},
            
    	//重写父类
    	setup: function () {
    		textOrderAddPager.superclass.setup.call(this);
			this._transGrade();
			this._transPrice();
			this._globalRome();
			this._initPage();
		
			var formValidator=this._initValidate();
			$(":input").bind("focusout",function(){
				formValidator.element(this);
			});
    	},
        
        _initValidate:function(){
        	var formValidator=$("#textOrderForm").validate({
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
			//baseInfo.chlId=""后台写
			//baseInfo.orderType
			baseInfo.busiType = 1;
			baseInfo.translateType = "0"; //0：快速翻译 1：文档翻译 缺判断
			baseInfo.translateName = $("#translateContent").val().substring(0,15);
			//baseInfo.orderLevel =??
			baseInfo.subFlag = "0"; // "0：系统自动报价 1：人工报价"
			//baseInfo.userType
			baseInfo.userId = "userid";
			baseInfo.corporaId = "corporaId";
			
			var productInfo = {};
			productInfo.translateSum = totalWords;
			productInfo.useCode = "";
			productInfo.fieldCode = "";
			productInfo.isSetType = "1"
			if ( $("#urgentOrder").is(':checked') ) {
				productInfo.isUrgent = "1";
			}
			//productInfo.needTranslateInfo??
			productInfo.translateInfo = $("#translateContent").val();
			var duadList =[];    
			$('input[name="duad"]:checked').each(function(){   
				var tempObj = {};
				tempObj.languagePairId =$(this).attr("name");
				//languagePairName =
				//languageNameEn =
				duadList.push(tempObj);    
			});
			productInfo.languagePairInfoList = duadList;
			//productInfo.translateLevelInfoList = []
			
			var contactInfo = {};
//			contactInfo.contactName =  $("#editContactDiv").find('p').eq(0).html();
//			contactInfo.contactTel  =  $("#editContactDiv").find('p').eq(1).html();
//			contactInfo.contactEmail  =  $("#editContactDiv").find('p').eq(2).html();
			contactInfo.contactName=$("#saveContactDiv").find('input').eq(0).val();
		    contactInfo.contactName="+"+$("#saveContactDiv").find('option:selected').val()+" "+$("#saveContactDiv").find('input').eq(1).val();
			contactInfo.contactName=$("#saveContactDiv").find('input').eq(2).val();
			
			var feeInfo = {};
			feeInfo.totalFee = 100;
			feeInfo.currencyUnit = $("#selectDuad").find("option:selected").attr("currency");
			
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
					if ("1" === data.statusCode) {
						if(baseInfo.translateType == 1) {
							window.location.href =  _base + "/p/customer/order/payOrder";
						} else {
							
						}
						
					}
				}
			});
		},
		
		//查询报价
		_queryAutoOffer:function() {
			var req={};
			req.wordNum = CountWordsUtil.count($("#translateContent").val());
		    req.duadId = $("#selectDuad").find("option:selected").val();
		    req.purposeId = $("#selectPurpose").find("option:selected").val();
		    
		    if($(".none-ml.current").attr('name') == 0) {
		    	req.translateLevel = "100210";
			} else if($(".none-ml.current").attr('name') == 1) {
				req.translateLevel = "100220";
			} else {
				req.translateLevel = "100230";
			}
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
			var selected = $("#selectDuad").find("option:selected");
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
				$("#proPrice").html(professionalUrgent).after(currency);
				$("#pubPrice").html(publishUrgent).after(currency);
			} else {
				$("#stanPrice").html(ordinary).after(currency);
				$("#proPrice").html(professional).after(currency);
				$("#pubPrice").html(publish).after(currency);
			}
			
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