define('app/jsp/order/payOrder', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
        Dialog = require("optDialog/src/dialog"),
	    Widget = require('arale-widget/1.2.0/widget');

	require('jquery-i18n/1.2.2/jquery.i18n.properties.min');
    var payOrderPager = Widget.extend({
    	
    	//事件代理
    	events: {
			"click #recharge-popo":"_payOrder",
			"click #payment-method ul":"_changePayType",
			"click #depositBtn":"_toDeposit",
			"click #completed":"_submitYEpay",//余额支付确认
			"click #close-completed":"_closeCompleted"//余额支付取消
           	},
            
    	//重写父类
    	setup: function () {
			payOrderPager.superclass.setup.call(this);
			this._changePayType();
			//初始化国际化
			$.i18n.properties({//加载资浏览器语言对应的资源文件
				name: ["payOrder"], //资源文件名称，可以是数组
				path: _i18n_res, //资源文件路径
				mode: 'both',
				language: currentLan,
				async: true
			});
    	},
		//支付订单
		_payOrder:function(){
			//获取支付方式
			var payType = $("#payment-method .current").eq(0).attr("payType");
			//当前地址
			var merchantUrl = "";
			$("#payType").val(payType);
			//若不为余额支付
			if("YE" != payType){
				$("#merchantUrl").val(window.location.href);
				//提交
				new Dialog({
                    content:$.i18n.prop('pay.msg.tip'),
                    okValue: $.i18n.prop('pay.completed.btn'),
                    cancelValue: $.i18n.prop('pay.error.btn'),
                    title: $.i18n.prop('pay.result.title'),
                    ok:function(){
                        //跳转到我的订单
						window.location.href=_base+"/p/customer/order/list/view";
                    },
                	cancel:function(){
						//跳转到常见问题
                        window.location.href=_base+"/faq";
					}
				}).showModal();
				$("#toPayForm").submit();
			}else {
				//判断余额是否足够
				if(acctBalance<orderPayFee){
					this._showWarn($.i18n.prop('pay.dialog.recharge'));
				}//余额支付,需要密码
             	else if(needPayPass==="1"){
                    $("#payPass").val("");
                    $('#eject-mask').fadeIn(100);
                    $('#rechargepop').slideDown(100);
                }//余额支付不需要密码
                else{
                    $("#yePayForm").submit();
                }
			}

		},
		//变更支付方式
		_changePayType:function(){
			var _this = this;
			$("#payment-method ul").each(function () {
                var type = $(this).attr("payType");
                if("YE" == type && acctBalance<orderPayFee){
                    return;
                }
				$(this).click(function () {
					$(this).children('label').remove();
					$(this).addClass("current");
					$(this).append('<label><i class="icon iconfont">&#xe617;</i></label>');

					$($(this).siblings()).removeClass("current");
					$($(this).siblings()).children('label').remove();
				});
			});
		},
		//关闭支付密码弹出框
		_closeCompleted:function(){
			$('#eject-mask').fadeOut(200);
			$('#rechargepop').slideUp(200);
		},
		//提交余额支付
		_submitYEpay:function(){
			var payPass=$("#payPass").val().trim();
			//密码不能为空
			if(payPass==""||payPass==null){
				alert($.i18n.prop('pay.pass.null'));
				return;
			}
			$("#balancePass").val(payPass);
			//提交
			$("#yePayForm").submit();
		},
		//调转到充值页面
		_toDeposit:function(){
			window.location.href=_base+"/p/balance/depositFund";
		},
        _showWarn:function(msg){
            new Dialog({
                content:msg,
                icon:'warning',
                okValue: $.i18n.prop("pay.dialog.ok"),
                title:  $.i18n.prop("pay.dialog.prompt"),
                ok:function(){
                    this.close();
                }
            }).showModal();
        }
		
    });
    
    module.exports = payOrderPager;
});