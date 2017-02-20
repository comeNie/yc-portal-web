define('app/jsp/customerOrder/orderEvaluate', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
        Widget = require('arale-widget/1.2.0/widget'),
        AjaxController = require('opt-ajax/1.0.0/index');

    //实例化AJAX控制处理对象
    var ajaxController = new AjaxController();

    var orderEvaluatePage = Widget.extend({
        //属性，使用时由类的构造函数传入
        attrs: {
            clickId:""
        },


        //事件代理
        events: {
            "click #recharge-popo":"_evaluateOrder",
            "click #evaluate-determine":"_seeEvaluate",
        },

        //重写父类
        setup: function () {
            orderEvaluatePage.superclass.setup.call(this);
        },

        // 评价订单
        _evaluateOrder:function () {
            var orderId = $("#orderId").val();
            ajaxController.ajax({
                type: "post",
                processing: true,
                url: _base+"/p/customer/order/evaluateOrder",
                data: {'orderId': orderId},
                success: function(data){
                    $("#evaluate-password").show();

                }
            });

        },

        _seeEvaluate:function () {
            window.location.href=_base+"/p/customer/order/seeEvaluate/"+$("#orderId").val();
        }
    });
    module.exports = orderEvaluatePage;
});