define('app/jsp/order/payOrder', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
        Dialog = require("optDialog/src/dialog"),
	    Widget = require('arale-widget/1.2.0/widget'),
		AjaxController = require('opt-ajax/1.0.0/index');

    require("jsviews/jsrender.min");
    require("jsviews/jsviews.min");
    require("app/util/jsviews-ext");
	require('jquery-i18n/1.2.2/jquery.i18n.properties.min');
	//实例化AJAX控制处理对象
	var ajaxController = new AjaxController();
    var payOrderPager = Widget.extend({
        Statics: {
            ORDER_TYPE_PERSON: "1",//个人
            ORDER_TYPE_COM: "2",//公司
            CURRENCY_UNIT_RMB:"1",//人民币
            CURRENCY_UNIT_USD:"2"//美元
        },
    	//事件代理
    	events: {
			"click #recharge-popo":"_freezeCoupon",
			"click #payment-method ul":"_changePayType",
			"click #depositBtn":"_toDeposit",
            "change #couponSelect":"_changeCoupon",
            "change #orderTypeSelect":"_changeOrderType",
            "change #conponCode":"_inputCouponCode",//输入优惠码
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
                cache: true,
				language: currentLan,
                checkAvailableLanguages: true,
				async: false
			});
			this._changeOrderType();
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

		//订单类型变更时，重新计算费用
        _changeOrderType:function () {
			//查看是否企业用户
			var orderType = $("#orderTypeSelect").val();
            comDisFee = 0;
            orderPayFee = totalFee;
            //默认为个人账户
            balance = acctBalance;
            //默认为个人账户，此时需要密码
            needPayPass = "1";
            $("#accountId").val(acctoundId);
            $("#corporaId").val("");

            $("#discountSum").val("");
			if(payOrderPager.ORDER_TYPE_COM == orderType){
                orderPayFee = totalFee * discount;
                var tmp = orderPayFee%10;
                orderPayFee -= tmp;
                if(tmp>4){
                    orderPayFee += 10;
                }
                //企业账户优惠金额
                comDisFee = totalFee - orderPayFee;
                //设置不需要校验密码
                needPayPass = "0";
                balance = compayBalance;
                $("#accountId").val(comAccountId);
                $("#corporaId").val(compayId);
                $("#discountSum").val(discount);
			}
			if(window.console){
			    console.log("_changeOrderType="+$("#accountId").val()+","+$("#corporaId").val());
            }
            $("#orderAmount").val(orderPayFee);
			$("#orderType").val(orderType);
			//查询可用优惠券
            this._queryCoupon();
        },
		//查询可用优惠券
		_queryCoupon:function () {
    		var _this = this;
            $("#couponSelect").empty();
            ajaxController.ajax({
                type: "post",
                processing:true,
                url: _base+"/p/balance/query/coupon",
                data: $("#toPayForm").serializeArray(),
                success: function(data){
                    //判断是否有可用优惠券
					var couponArry = eval(data.data);
					var currencyUnit = $("currencyUnit").val();
					//若存在可用优惠券
					if(couponArry==null || couponArry.length<1){
                        $("#couponSelect").append("<option value='' faceVal='0'>"+noCoupon+"</option>");
                        //优惠码可输入
						$("#conponCode").removeAttr("disabled");
					}else {
                        $("#conponCode").attr("disabled","disabled");
                        $.each( couponArry, function(i, n){
                        	var couponOpt = $.i18n.prop('pay.order.rmb.coupon.option',
                                _this.liToYuan(n.faceValue),
                                _this.timestampToDate("yyyy-MM-dd",n.effectiveEndTime));
                        	//若是美元
                        	if(""==currencyUnit){
                                couponOpt = $.i18n.prop('pay.order.usd.coupon.option',
                                    _this.liToYuan(n.faceValue),
                                    _this.timestampToDate("yyyy-MM-dd",n.effectiveEndTime));
							}
                            $("#couponSelect").append("<option value='"+
								n.couponId+"' faceVal='"+n.faceValue+"'>"+couponOpt+"</option>");
                        });
                        //添加不使用优惠券信息
                        $("#couponSelect").append("<option value='' faceVal='0'>"+
							$.i18n.prop("pay.order.not.coupon.option")+"</option>");
					}
					_this._changeCoupon();
                },
                failure:function () {
                    $("#couponSelect").append("<option value='' faceVal='0'>"+noCoupon+"</option>");
                    //优惠码可输入
                    $("#conponCode").removeAttr("disabled");
                    _this._changeCoupon();
                },
				error:function () {
                    $("#couponSelect").append("<option value='' faceVal='0'>"+noCoupon+"</option>");
                    //优惠码可输入
                    $("#conponCode").removeAttr("disabled");
                    _this._changeCoupon();
                }
            });
        },
		//优惠券变更时，重新计算优惠信息
		_changeCoupon:function () {
    		//获取优惠面值
			var faceVal = $("#couponSelect").find("option:selected").attr("faceVal");
            this._changeCouponOrCode(Number(faceVal));
            $("#conponCode").val("");
        },
        //优惠券或优惠码变更时
        _changeCouponOrCode:function (faceVal) {
            $("#couponFee").val("");
            couponDisFee = faceVal;
            orderPayFee = totalFee - comDisFee - couponDisFee;
            //若应付金额小于0，则按0执行
            if(orderPayFee<0){
                orderPayFee = 0;
            }

            this._changePayFee();
            //若优惠券金额为0，则允许输入优惠码
            if(couponDisFee == 0){
                //优惠码可输入
                $("#conponCode").removeAttr("disabled");
            }//优惠券金额大于0，
            else if(couponDisFee>0){
                var tem = couponDisFee>totalFee?totalFee:couponDisFee;
                $("#couponFee").val(tem);
            }
            if(window.console){
                console.log("couponFee:"+$("#couponFee").val());
            }
            //重新变更支付方式
            this._changeShowPayType();
        },
		//优惠变更时，变更金额显示
		_changePayFee:function () {
            var discounted = comDisFee + couponDisFee;
            //若优惠金额大于订单金额，则优惠金额为订单金额
            if(discounted>totalFee){
                discounted = totalFee;
            }
			//优惠金额变更
			$("#discounted").html(this.liToYuan(discounted));
			//应付金额变更
			$("#payable").html(this.liToYuan(orderPayFee));

			$("#orderAmount").val(orderPayFee);
        },
        //输入优惠码时
        _inputCouponCode:function () {
            var _this = this;
            var code = $("#conponCode").val();
            //优惠券
            var coupon = $("#couponSelect").val();
            //若优惠券为空，则优惠金额为0
            if(coupon==null || coupon=="")
                couponDisFee = 0;
            //若优惠券不为空，优惠码为空或不等于16位，则不做任何处理
            if((coupon !=null && coupon!="")
                || code==null
                || code.length!=16){
                return;
            }
            //查询优惠码的金额及有效性
            ajaxController.ajax({
                type: "post",
                processing:true,
                url: _base+"/p/balance/coupon/verify",
                data: {"currencyUnit":currencyUnit,"orderAmount":orderPayFee,"couponId":couponId},
                success: function(data){
                    var coupon = eval(data.data);
                    _this._changeCouponOrCode(Number(coupon.faceValue));
                }
            });
        },
        //变更支付方式显示
        _changeShowPayType:function () {
            var orderType = $("#orderTypeSelect").val();
            var balanceTmp = acctBalance;
            var showPayAfter = false;
            //若为企业账户
            if(payOrderPager.ORDER_TYPE_COM == orderType){
                balanceTmp = compayBalance;
                //允许后付费
                if(allowAfter){
                    showPayAfter = true;
                }
            }
            //币种
            var currencyUnit = $("#currencyUnit").val();
            //若允许后付费，则使用1，默认使用3
            var current = showPayAfter?1:3;
            //如果为人民币，
            if(payOrderPager.CURRENCY_UNIT_RMB == currencyUnit){
                //支付金额为0，或支付金额小于等于余额且不支持后付费
                if(orderPayFee == 0 || (orderPayFee<=balanceTmp && !showPayAfter)){
                    current = 2;
                }
            }
            //若支持后付费，则
            var currentData = {"current":current};

            //是否显示翻译后付费
            var payTemp = showPayAfter?$.templates("#hfPayTemp").render(currentData):"";
            //其他支付方式
            var otherPayTemp = $.templates("#otherPayTemp").render(currentData);
            //若是人民币，则显示余额信息
            if(payOrderPager.CURRENCY_UNIT_RMB == currencyUnit){
                var yeObj = {"balance":balanceTmp,"current":current};
                //余额
                var yePayTemp = $.templates("#yePayTemp").render(yeObj);
                //若余额不足，则放在最后
                if(orderPayFee>balanceTmp){
                    payTemp = payTemp+otherPayTemp+yePayTemp;
                }//若余额充足，则放在第一位
                else {
                    payTemp = payTemp+yePayTemp+otherPayTemp;
                }
            }
            else {
                payTemp += otherPayTemp;
            }
            $("#payment-method").html(payTemp);

        },
        //冻结优惠码或优惠券
        _freezeCoupon:function () {
            var _this = this;
            //订单号
            var orderId = $("#orderId").val();
            //优惠券
            var couponId = $("#couponSelect").val();
            var codeTmp = $("#conponCode").val();
            //若优惠券不存在，则获取优惠码
            if((couponId==null || couponId=="")
                && codeTmp!=null
                && codeTmp.length == 16){
                couponId = codeTmp;
            }
            $("#couponId").val(couponId);
            //若优惠券和优惠码均不存在，则直接进行订单支付
            if(couponId==null || couponId==""){
                this._payOrder();
                return;
            }
            ajaxController.ajax({
                type: "post",
                processing:true,
                url: _base+"/p/balance/coupon/freeze",
                data: {"orderId":orderId,"couponId":couponId},
                success: function(data){
                    //绑定成功，直接进行订单支付
                    _this._payOrder();
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
			var path = _base+"/p/customer/order/pay/noorg";
            //若支付金额为0，则直接为优惠券支付
			if(orderPayFee <= 0 ){
                $("#payType").val("YHQ");
                $('#toPayForm').attr("action", path).submit();
                $('#toPayForm').removeAttr("target");
            }//若为翻译后付费，则直接提交订单
            else if("HF" == payType ){
                $('#toPayForm').removeAttr("target");
                $('#toPayForm').attr("action", path).submit();
            }
            //若为余额支付
            else if("YE" == payType){
                var orderType = $("#orderTypeSelect").val();
                //判断余额是否足够
                if(balance<orderPayFee){
                    this._showWarn($.i18n.prop('pay.dialog.recharge'));
                }//需要支付密码、支付密码不存在
                else if( needPayPass == "1"
                    && payPassExist == false){
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
			}//第三方支付
			else {
                $("#merchantUrl").val(window.location.href);
                if(window.console){
                    console.info("content:"+$.i18n.prop('pay.msg.tip'));
                    console.info("okValue:"+$.i18n.prop('pay.completed.btn'));
                    console.log("cancelVal:"+$.i18n.prop('pay.error.btn'));
                    console.log("title:"+$.i18n.prop('pay.result.title'))
                }
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
        //验证优惠码/优惠券是否有效
        _verifyCoupon:function () {
		    var currencyUnit = $("#currencyUnit").val();
            //优惠券
            var couponId = $("#couponSelect").val();
            //若优惠券不存在，则获取优惠码
            if(couponId==null || couponId==""){
                couponId = $("#conponCode").val();
            }
            //若优惠券和优惠码均不存在
            if(couponId==null || couponId==""){
                return;
            }
            ajaxController.ajax({
                type: "post",
                processing:true,
                url: _base+"/p/balance/coupon/verify",
                data: {"currencyUnit":currencyUnit,"orderAmount":orderPayFee,"couponId":couponId},
                success: function(data){

                }
            });
        },
		//余额支付
		_YEPaySubmit:function () {
			var _this= this;
			//订单类型
            var orderType = $("#orderType").val();
            //应收费用
            $("#yeTotalAmount").val(orderPayFee);
            //订单类型
            $("#yeOrderType").val(orderType);
            //企业标识
            $("#yeCorporaId").val($("#corporaId").val());
            //折扣
            $("#yeDiscountSum").val($("#discountSum").val());
            //优惠金额
            $("#yeCouponFee").val($("#couponFee").val());
            //优惠券
            $("#yeCouponId").val($("#couponId").val());
            if(window.console){
                console.log($("#corporaId").val()+":"+$("#couponId").val());
                console.log($("#yeCorporaId").val()+","+$("#yeCouponId").val());
            }
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
        },
        liToYuan:function(li){
            var result = '0.00';
            if(isNaN(li) || !li){
                return result;
            }
            return this.fmoney(parseInt(li)/1000, 2);
        },
        fmoney: function (s, n) {
            n = n > 0 && n <= 20 ? n : 2;
            s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";
            var l = s.split(".")[0].split("").reverse(),
                r = s.split(".")[1];
            var t = "", i = 0;
            for (i = 0; i < l.length; i++) {
                t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");
            }
            return t.split("").reverse().join("") + "." + r;
        },
        timestampToDate: function (format, timestamp) {
            if (timestamp != null) {
                return (new Date(parseFloat(timestamp))).format(format);
            } else {
                return null;
            }
    	}
		
    });
    
    module.exports = payOrderPager;
});