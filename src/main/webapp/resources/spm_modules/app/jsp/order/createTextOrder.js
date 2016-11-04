define('app/jsp/order/createTextOrder', function (require, exports, module) {
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
			"click #recharge-popo":"_addTextOrderTemp",
			"click #toCreateOrder":"_toCreateOrder",
			"click #urgentOrder":"_transPrice",
			"change #selectDuad":"_transPrice",
           	},
            
    	//重写父类
    	setup: function () {
    		textOrderAddPager.superclass.setup.call(this);
			this._transGrade();
			this._transPrice();
		
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
    					commonText:true
    				},
    				isAgree: {
    					required:true,
    				}
    			},
    			messages: {
    				translateContent: {
    					required:"请输入翻译内容",
    					maxlength:"最大长度不能超过{0}"
    				},
    				isAgree: {
    					required: "请阅读并同意翻译协议",
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
			
			$("#textOrderPage").hide();
			$("#contactPage").css('display','block'); 
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
			
		}
    });
    
    module.exports = textOrderAddPager;
});