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
    	Implements:CountWordsUtil,
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
			"click #editContactDiv":"_editContactDiv"
           	},
            
    	//重写父类
    	setup: function () {
    		textOrderAddPager.superclass.setup.call(this);
			this._transGrade();
			this._transPrice();
			this._globalRome();
		
			var formValidator=this._initValidate();
			$(":input").bind("focusout",function(){
				formValidator.element(this);
			});
    	},
        
        _initValidate:function(){
        	var formValidator=$("#textOrderForm").validate({
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
			var totalWords = CountWordsUtil.count($("#translateContent").val());
			
			var baseInfo = {};
			//baseInfo.chlId=""后台写
			//baseInfo.orderType
			baseInfo.busiType = 1;
			baseInfo.translateType = "0"; //0：快速翻译 1：文档翻译
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
			contactInfo.contactName =  $("#editContactDiv").find('p').eq(0).html();
			contactInfo.contactTel  =  $("#editContactDiv").find('p').eq(1).html();
			contactInfo.contactEmail  =  $("#editContactDiv").find('p').eq(2).html();
			
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
						//alert("保存成功");
						//保存成功,回退到进入的列表页
//						window.history.go(-1)
					}
				}
			});
		},
		
		_toCreateOrder:function(){
			$("#textOrderPage").show();
			$("#contactPage").hide();
		},
		
		//翻译等级改变
		_transGrade:function() {
			$("#transGrade ul").each(function () {
				$(this).click(function () {
					$(this).children('label').remove();
					$(this).addClass("none-ml current");
					$(this).append('<label><i class="icon iconfont">&#xe617;</i></label>');
					
					$($(this).siblings()).removeClass("none-ml current");
					$($(this).siblings()).children('label').remove();
				});
			}) 
		},
		
		//翻译级别改变，价格改变
		_transPrice:function() {
			var selected = $("#selectDuad").find("option:selected");
			var currency = selected.attr("currency");
			var ordinary = selected.attr("ordinary");
			var ordinaryUrgent = selected.attr("ordinaryUrgent");
			var professional = selected.attr("professional");
			var professionalUrgent = selected.attr("professionalUrgent");
			var publish = selected.attr("publish");
			var publishUrgent = selected.attr("publishUrgent");
			
			if ( $("#urgentOrder").is(':checked') ) {
				$("#stanPrice").html(ordinaryUrgent + currency);
				$("#proPrice").html(professionalUrgent + currency);
				$("#pubPrice").html(publishUrgent + currency);
			} else {
				$("#stanPrice").html(ordinary + currency);
				$("#proPrice").html(professional + currency);
				$("#pubPrice").html(publish + currency);
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
					
					selObj.append("<option value='"+row["COUNTRY_CODE"]+"'>"+text+"   +"+row["COUNTRY_CODE"]+"</option>");
				});
			});
		}
		
    });
    
    module.exports = textOrderAddPager;
});