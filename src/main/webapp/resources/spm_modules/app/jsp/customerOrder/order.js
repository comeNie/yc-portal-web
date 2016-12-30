define('app/jsp/customerOrder/order', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
        Widget = require('arale-widget/1.2.0/widget'),
        Dialog = require("optDialog/src/dialog"),
        AjaxController = require('opt-ajax/1.0.0/index');
    require('jquery-i18n/1.2.2/jquery.i18n.properties.min');


    //实例化AJAX控制处理对象
    var ajaxController = new AjaxController();

    var orderPage = Widget.extend({

        //重写父类
        setup: function () {
            orderPage.superclass.setup.call(this);
            //初始化国际化
            $.i18n.properties({//加载资浏览器语言对应的资源文件
                name: ["orderInfo"], //资源文件名称，可以是数组
                path: _i18n_res, //资源文件路径
                mode: 'both',
                language: currentLan,
                checkAvailableLanguages: true,
                async: true
            });
        },

        //提交订单
        _orderSubmit:function(orderId) {
            new Dialog({
                content:$.i18n.prop('order.info.submit.info'),
                icon:'prompt',
                okValue: $.i18n.prop('order.info.dialog.ok'),
                cancelValue:$.i18n.prop('order.info.dialog.cancel'),
                title: $.i18n.prop('order.info.submit.order'),
                ok:function(){
                    ajaxController.ajax({
                        type: "post",
                        url: _base + "/p/trans/order/save",
                        data: {
                            orderId: orderId,
                        },
                        success: function (data) {
                            if ("1" === data.statusCode) {
                                //提交成功
                                window.location.reload();
                            }
                        }
                    });
                },
                cancel:function(){
                    this.close();
                }
            }).showModal();

        },

        //确认订单
        _confirm:function(orderId) {
            new Dialog({
                content:$.i18n.prop('order.info.confirm.info'),
                icon:'prompt',
                okValue: $.i18n.prop('order.info.dialog.ok'),
                cancelValue:$.i18n.prop('order.info.dialog.cancel'),
                title: $.i18n.prop('order.info.confirm.order'),
                ok:function(){
                    ajaxController.ajax({
                        type: "post",
                        url: _base + "/p/trans/order/updateState",
                        data: {
                            orderId: orderId,
                            state: "90",
                            displayFlag: "90",
                        },
                        success: function (data) {
                            if ("1" === data.statusCode) {
                                //成功
                                //刷新页面
                                window.location.reload();
                            }
                        }
                    });
                },
                cancel:function(){
                    this.close();
                }
            }).showModal();

        },

        //取消订单
        _cancelOrder:function(orderId) {
            new Dialog({
                content:$.i18n.prop('order.info.cancel.info'),
                icon:'prompt',
                okValue: $.i18n.prop('order.info.dialog.ok'),
                cancelValue:$.i18n.prop('order.info.dialog.cancel'),
                title: $.i18n.prop('order.info.cancel.order'),
                ok:function(){
                    ajaxController.ajax({
                        type: "post",
                        url: _base+"/p/customer/order/cancelOrder",
                        data: {'orderId': orderId},
                        success: function(data){
                            //取消成功,刷新页面
                            if("1"===data.statusCode){
                                window.location.reload();
                            }
                        }
                    });
                },
                cancel:function(){
                    this.close();
                }
            }).showModal();
        },

        //跳转支付
        _orderPay:function(orderId, unit) {
            window.location.href=_base+"/p/customer/order/payOrder/"+orderId+"?unit="+unit;
        },


//    	下载文件
        _downLoad:function(fileId, fileName) {
            fileName = window.encodeURI( window.encodeURI(fileName));
            window.open(_base +"/p/customer/order/download?fileId="+fileId+"&fileName="+fileName);
        },


    });
    module.exports = orderPage;
});