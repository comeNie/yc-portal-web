define('app/jsp/order/createOralOrder', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
	    Widget = require('arale-widget/1.2.0/widget'),
	    AjaxController = require('opt-ajax/1.0.0/index');
    require("jsviews/jsrender.min");

    require("jquery-validation/1.15.1/jquery.validate");
	require("app/util/aiopt-validate-ext");
	require('jquery-i18n/1.2.2/jquery.i18n.properties.min');	
	
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
            },
            
    	//重写父类
    	setup: function () {
    		textOrderAddPager.superclass.setup.call(this);
    		
    		//初始化国际化
			$.i18n.properties({//加载资浏览器语言对应的资源文件
				name: ["orderInfo"], //资源文件名称，可以是数组
				path: _i18n_res, //资源文件路径
				mode: 'both',
				language: currentLan,
			});
    		

			var formValidator=this._initValidate();
			$(":input").bind("focusout",function(){
				formValidator.element(this);
			});
    	},
        	
        _initValidate:function(){
        	var formValidator=$("#oralOrderForm").validate({
				focusInvalid:true,
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
					$('ul li p label').each(function (index,element) {
						if (index > 0)
							element.remove();
					});
				},
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
        				}
    			},
    			messages: {
    				transSubject: {
    					required: $.i18n.prop('order.place.error.subject'), //"请填写翻译主题",
    					maxlength: $.i18n.prop('order.place.error.Maximum') //"最大长度不能超过{0}"
    				},
    				duad: {
    					required: $.i18n.prop('order.place.error.lan')//"请选择语言"
    				},
    				interpretationType: {
    					required: $.i18n.prop('order.place.error.interType') //"请选择口译类型"
    				},
    				begin_time: {
    					required: $.i18n.prop('order.place.error.startTime') //"请选择开始时间"   
    				},
    				end_time: {
    					required: $.i18n.prop('order.place.error.endTime') //"请选择结束时间"
    				},
    				meetingAmount: {
    					required: $.i18n.prop('order.place.error.meetNum'),//"请输入会议场数",
    					digits: $.i18n.prop('order.place.error.integer'),//"请输入整数",
    					min: $.i18n.prop('order.place.error.min'),//"最小值为{0}",
    					max: $.i18n.prop('order.place.error.max')//"最大值为{0}"
    				},
    				interpreterNum: {
    					required: $.i18n.prop('order.place.error.interNum'),//"请输入译员数量",
    					digits: $.i18n.prop('order.place.error.integer'),//"请输入整数",
    					min: $.i18n.prop('order.place.error.min'),//"最小值为{0}",
    					max: $.i18n.prop('order.place.error.max')//"最大值为{0}"
    				},
    				isAgree: {
    					required: $.i18n.prop('order.place.error.agree')//"请阅读并同意翻译协议",
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
                return formValidator.focusInvalid();
			}
			

			var duadNameList =[];
			$('input[name="duad"]:checked').each(function(){
				duadNameList.push($(this).parent().next().html());
			});

			var interpretationTypeList = [];
			$('input[name="interpretationType"]:checked').each(function(){    
				interpretationTypeList.push($(this).parent().next().html());
			});

			var orderSummary = {};
			orderSummary.duadName = duadNameList.join(" ");
			orderSummary.translevel = interpretationTypeList.join(" ");

			var baseInfo = {};
			var productInfo = {};

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

			baseInfo.translateType = "2"; //2：口译翻译"
			baseInfo.translateName = $("#transSubject").val();
			baseInfo.orderLevel = "1"; //??
			baseInfo.subFlag = "1"; // "0：系统自动报价 1：人工报价"
			baseInfo.userType = "10"; //"10：个人 11：企业 12：代理人 "??
			//baseInfo.corporaId
			//baseInfo.accountId
			var today = new Date();
			if(today.stdTimezoneOffset()/60 > 0)
				baseInfo.timeZone = 'GMT-'+Math.abs(today.stdTimezoneOffset()/60);
			else
				baseInfo.timeZone = 'GMT+'+Math.abs(today.stdTimezoneOffset()/60);

			productInfo.meetingSum = $("#meetingAmount").val();
			productInfo.interperGen = $("#gender").find("option:selected").val();
			productInfo.meetingAddress = $("#place").find("option:selected").text();
			productInfo.interperSum = $("#interpreterNum").val();

			var offsetMis = new Date().getTimezoneOffset()*60*1000;
			if(window.console){
				console.log("The offsetMis "+offsetMis);
			}
			productInfo.startTime = new Date($("#begin_time").val()).getTime();
			productInfo.endTime = new Date($("#end_time").val()).getTime();

			var translateLevelInfoList = [];
			$('input[name="interpretationType"]:checked').each(function(){
				var tempObj = {};
				tempObj.translateLevel =$(this).val();
				translateLevelInfoList.push(tempObj);
			});
			productInfo.translateLevelInfoList = translateLevelInfoList;

			var duadList =[];
			$('input[name="duad"]:checked').each(function(){
				var tempObj = {};
				tempObj.languagePairId =$(this).val();
				tempObj.languagePairName = $(this).attr('duadZh');
				tempObj.languageNameEn = $(this).attr('duadEn');
				duadList.push(tempObj);
			});
			productInfo.languagePairInfoList = duadList;

			if ( $("#urgentOrder").is(':checked') )
				productInfo.isUrgent = "Y";
			else
				productInfo.isUrgent = "N";

			//创建订单
			ajaxController.ajax({
				type: "post",
                processing: true,
				url: _base + "/order/add",
				data: {
					baseInfo: JSON.stringify(baseInfo),
					productInfo: JSON.stringify(productInfo),
					orderSummary: JSON.stringify(orderSummary)
				},
				success: function (data) {
					if ("1" === data.statusCode)
						window.location.href =  _base + "/p/order/contact?skip="+data.data;
				}
			});

		},

    });
    
    module.exports = textOrderAddPager;
});