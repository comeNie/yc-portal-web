define('app/jsp/order/createOralOrder', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
	    Widget = require('arale-widget/1.2.0/widget'),
	    AjaxController = require('opt-ajax/1.0.0/index');
    require("jsviews/jsrender.min");

    require("jquery-validation/1.15.1/jquery.validate");
	require("app/util/aiopt-validate-ext");
    var SendMessageUtil = require("app/util/sendMessage");
    
    //实例化AJAX控制处理对象
    var ajaxController = new AjaxController();
    
    var textOrderAddPager = Widget.extend({
    	Implements:SendMessageUtil,
    	//属性，使用时由类的构造函数传入
    	attrs: {
    		clickId:""
    	},
    	
    	//事件代理
    	events: {
			"click #recharge-popo":"_addOralOrderTemp",
			"click #submitOrder": "_addOralOrder",
			"click #toCreateOrder":"_toCreateOrder",
			"click #saveContact":"_saveContact",
			"click #editContact":"_editContactDiv"
            },
            
    	//重写父类
    	setup: function () {
    		textOrderAddPager.superclass.setup.call(this);
    		
    		this._globalRome();
    		
			var formValidator=this._initValidate();
			$(":input").bind("focusout",function(){
				formValidator.element(this);
			});
    	},
        	
        _initValidate:function(){
        	var formValidator=$("#oralOrderForm").validate({
    			rules: {
    				transSubject: {
    					required:true,
    					maxlength:15
    					},
    					duad: 'required',
    					interpretationType: 'required',
    					begin_time:{
        					required: true,
        					date: true,
        					maxDate: $("#endDate").val()
        				},
        				end_time:{
        					required: true,
        					date:true,
        				},
        				meetingAmount:{
        					required: true,
        					digits:true,
        					min:1,
        					max:100
        				},
        				interpreterNum:{
        					required: true,
        					digits:true,
        					min:1,
        					max:100
        				},
        				isAgree: {
        					required: true,
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
    				transSubject: {
    					required:"请填写翻译主题",
    					maxlength:"最大长度不能超过{0}"
    				},
    				duad: {
    					required:"请选择语言"
    				},
    				interpretationType: {
    					required:"请选择口译类型"
    				},
    				begin_time: {
    					required: "请选择开始时间"   
    				},
    				end_time: {
    					required:"请选择结束时间"
    				},
    				meetingAmount: {
    					required: "请输入会议场数",
    					digits: "请输入整数",
    					min:"最小值为{0}",
    					max:"最大值为{0}"
    				},
    				interpreterNum: {
    					required: "请输入译员数量",
    					digits: "请输入整数",
    					min:"最小值为{0}",
    					max:"最大值为{0}"
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
        _addOralOrderTemp:function(){
        	var _this= this;
        	var formValidator=_this._initValidate();
			formValidator.form();
			if(!$("#oralOrderForm").valid()){
				//alert('验证不通过！！！！！');
				return;
			}
			
			$("#oralOrderPage").hide();
			
			var tableFirstLine = $("#oralOrderTable tbody tr").eq(0).find("td")
			tableFirstLine.eq(0).html($("#transSubject").val());
			
			var duadList =[];    
			$('input[name="duad"]:checked').each(function(){    
				duadList.push($(this).val()+" ");    
			});
			tableFirstLine.eq(1).html(duadList);
			
			var interpretationTypeList = [];
			$('input[name="interpretationType"]:checked').each(function(){    
				interpretationTypeList.push($(this).val()+" ");    
			});  
			tableFirstLine.eq(2).html(interpretationTypeList);
			tableFirstLine.eq(3).html($("#begin_time").val());
			tableFirstLine.eq(4).html($("#end_time").val());
			tableFirstLine.eq(5).html($("#place").val());
			tableFirstLine.eq(6).html($("#meetingAmount").val());
			
			$("#contactPage").show();
		},
		
		//提交文本订单
        _addOralOrder:function(){
        	var _this= this;
        	var formValidator=_this._initValidate();
			formValidator.form();
			if(!$("#oralOrderForm").valid()){
				//alert('验证不通过！！！！！');
				return;
			}
			
			var baseInfo = {};
			//baseInfo.chlId=""后台写
			//baseInfo.orderType
			baseInfo.busiType = 1;
			baseInfo.translateType = "2"; //2：口译翻译"
			baseInfo.translateName = $("#transSubject").val();
			//baseInfo.orderLevel =??
			baseInfo.subFlag = "1"; // "0：系统自动报价 1：人工报价"
			//baseInfo.userType
			baseInfo.userId = "userid";
			baseInfo.corporaId = "corporaId";
			
			var productInfo = {};
			productInfo.meetingSum = $("#meetingAmount").val();
			productInfo.interperGen = $("#gender").find("option:selected").val(); 
			productInfo.meetingAddress = $("#place").find("option:selected").val(); 
			productInfo.interperSum = $("#interpreterNum").val(); 
			productInfo.startTime = new Date($("#begin_time").val()).getTime(); 
			productInfo.endTime = new Date($("#end_time").val()).getTime(); 
			
			var duadList =[];    
			$('input[name="duad"]:checked').each(function(){   
				var tempObj = {};
				tempObj.languagePairId =$(this).attr("name");
				//languagePairName =
				//languageNameEn =
				duadList.push(tempObj);    
			});
			productInfo.languagePairInfoList = duadList;
			
			if ( $("#urgentOrder").is(':checked') ) {
				productInfo.isUrgent = "1";
			}
			
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
			$("#oralOrderPage").show();
			$("#contactPage").hide();
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