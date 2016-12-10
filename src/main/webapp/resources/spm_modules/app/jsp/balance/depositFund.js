define('app/jsp/balance/depositFund', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
	    Widget = require('arale-widget/1.2.0/widget');

	require('jquery-i18n/1.2.2/jquery.i18n.properties.min');
    var depositFundPager = Widget.extend({
    	
    	//事件代理
    	events: {
			"click #recharge-popo":"_payOrder",
			"click #completed":"_payRe",
			"blur #orderAmount":"_check"
           	},
            
    	//重写父类
    	setup: function () {
			depositFundPager.superclass.setup.call(this);
			$.i18n.properties({//加载资浏览器语言对应的资源文件
				name: ["myaccount"], //资源文件名称，可以是数组
				path: _i18n_res, //资源文件路径
				mode: 'both',
				language: currentLan,
				async: false
			});
    	},
		//验证输入金额
		_check:function () {
			var target = $("#orderAmount").val();
			var input = $.i18n.prop('account.tishi.input')
			if (target==""){
				$("#tishi1").html($.i18n.prop('account.tishi.input'));
				return false;
			}
			if (isNaN(target)) {
				$("#tishi1").html($.i18n.prop('account.tishi.validmoney'));
				return false;
			}
			if (target<=0||(target.toString().split(".").length > 1 && target.toString().split(".")[1].length > 2)){
				$("#tishi1").html($.i18n.prop('account.tishi.validmoney'));
				return;
			}
		},
		//支付订单
		_payOrder:function(){
			//当前地址
			var merchantUrl = "";
			var orderAmount = $("#orderAmount").val();
			if (orderAmount==""){
				$("#tishi1").html($.i18n.prop('account.tishi.input'));
				return false;
			}
			if (isNaN(orderAmount)) {
				$("#tishi1").html($.i18n.prop('account.tishi.validmoney'));
				return false;
			}
			if (orderAmount<=0){
				$("#tishi1").html($.i18n.prop('account.tishi.validmoney'));
				return;
			}
				$('#eject-mask').fadeIn(100);
				$('#rechargepop').slideDown(100);

			$('#close-completed').click(function(){
				$('#eject-mask').fadeOut(200);
				$('#rechargepop').slideUp(200);
			})
			$("#merchantUrl").val(window.location.href);
				//提交
			$("#toPayForm").submit();

		},
		_payRe:function () {
			$('#eject-mask').fadeOut(200);
			$('#rechargepop').slideUp(200);
		}
    });
    
    module.exports = depositFundPager;
});