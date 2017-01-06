define('app/jsp/order/payOrder', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
        Dialog = require("optDialog/src/dialog"),
	    Widget = require('arale-widget/1.2.0/widget'),
		AjaxController = require('opt-ajax/1.0.0/index');

	require('jquery-i18n/1.2.2/jquery.i18n.properties.min');
	//实例化AJAX控制处理对象
	var ajaxController = new AjaxController();
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
            //默认选择第一个支付方式
            $("#payment-method ul:first").click();
			//初始化国际化
			$.i18n.properties({//加载资浏览器语言对应的资源文件
				name: "payOrder", //资源文件名称，可以是数组
				path: _i18n_res, //资源文件路径
				mode: 'both',
				language: currentLan,
                checkAvailableLanguages: true,
				async: true
			});
    	},
		//检查订单是否已经支付，
		_isPay:function () {
			var _this = this;
			ajaxController.ajax({
				type: "post",
                processing:true,
				url: _base+"/p/customer/order/isPay",
				data: {'orderId': $("#orderId").val()},
				success: function(data){
					//可以支付
					if("OK"===data.statusInfo){
						//模拟点击事件
						$("#subForm").click();
					} else {
						// _this._showWarn($.i18n.prop('pay.error.paid'));
						//订单错误，跳转到订单错误页面。
						window.location.href= _base+"/order/error";
					}
				}
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
			}//使用余额支付
			else {
				//判断余额是否足够
				if(acctBalance<orderPayFee){
					this._showWarn($.i18n.prop('pay.dialog.recharge'));
				}//未设置支付密码
				else if(payPassExist == false){
					this._showToSetPass();
				}//余额支付,需要密码
             	else if(needPayPass==="1"){
                    $("#payPass").val("");
                    $('#eject-mask').fadeIn(100);
                    $('#rechargepop').slideDown(100);
                }//余额支付不需要密码
                else{
                    this._YEPaySubmit();
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
				this._showWarn($.i18n.prop('pay.pass.empty'));
				return;
			}
			$("#balancePass").val(payPass);
			//提交
			this._YEPaySubmit();
		},
		//余额支付
		_YEPaySubmit:function () {
			var _this= this;
            ajaxController.ajax({
                type: "post",
                processing:true,
                url: _base+"/p/customer/order/payOrder/balance",
                data: $("#yePayForm").serializeArray(),
                success: function(data){
                	var payResult = data.data;
                    //支付成功，跳转到支付成功页面
                    if("success"===payResult.payResultCode){
                        window.location.href= _base+"/pay/yePayResultView?payResult=true&orderId="+payResult.orderId;
                    }//1.密码错误，进行提示，确认
                    else if("000006"===payResult.payResultCode){
                        _this._showWarn($.i18n.prop('pay.error.passwd'));
					}//未设置密码，进行提示，点击按钮进入密码设置页面
					else if("000007"===payResult.payResultCode){
                        _this._showToSetPass();
					}//余额不足，刷新当前页面
                    else if("300002"===payResult.payResultCode){
                        new Dialog({
                            content:$.i18n.prop('pay.error.balance.noenough'),
                            icon:'warning',
                            okValue: $.i18n.prop("pay.dialog.ok"),
                            title:  $.i18n.prop("pay.dialog.prompt"),
                            ok:function(){
                                window.location.reload();
                            }
                        }).showModal();
                    }//其他错误，进入订单异常页面
                    else {
                        // _this._showWarn($.i18n.prop('pay.error.paid'));
                        //订单错误，跳转到订单错误页面。
                        window.location.href= _base+"/order/error";
                    }
                }
            });
        },
		//调转到充值页面
		_toDeposit:function(){
			window.location.href=_base+"/p/balance/depositFund";
		},
		//显示设置密码的提示信息
		_showToSetPass:function () {
            new Dialog({
                content:$.i18n.prop('pay.error.pass.empty'),
                icon:'warning',
                okValue: $.i18n.prop("pay.dialog.setpw.btn"),
                title:  $.i18n.prop("pay.dialog.prompt"),
                ok:function(){
                    window.location.href= _base+"/p/security/seccenter?source=user";
                }
            }).showModal();
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