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
			"click #toCreateOrder":"_toCreateOrder"
            },
            
    	//重写父类
    	setup: function () {
    		textOrderAddPager.superclass.setup.call(this);
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
    					maxlength:15,
    					commonText:true
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
			$("#contactPage").show();
		},
		
		_toCreateOrder:function(){
			$("#oralOrderPage").show();
			$("#contactPage").hide();
		}
    });
    
    module.exports = textOrderAddPager;
});