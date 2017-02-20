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
            var orderEvaluateInfo = {};

            //服务质量 1颗星8分
            orderEvaluateInfo.serveQuality = 8*$("#serviceQuality .starC").attr('name').substring(4);
            //服务速度 1颗星6分
            orderEvaluateInfo.serveSpeen = 6*$("#serviceSpeed .starC").attr('name').substring(4);
            // 服务态度 1颗星6分
            orderEvaluateInfo.serveManner = 6*$("#serviceAttitude .starC").attr('name').substring(4);
            orderEvaluateInfo.evaluateContent = $("#evaluateContent").val();//评价内容

            ajaxController.ajax({
                type: "post",
                processing: true,
                url: _base+"/p/customer/order/evaluateOrder",
                data: {
                    orderId: orderId,
                    orderEvaluateInfo: JSON.stringify(orderEvaluateInfo)
                },
                success: function(data){
                    $("#evaluate-password").show();
                }
            });

        },

        _seeEvaluate:function () {
            window.location.href=_base+"/p/customer/order/seeEvaluate/"+$("#orderId").val();
        },

        _clickSatr:function ($star) {
            var starIndex = $($star).attr("name").substring(4);
            var checkStar = _base+"/resources/template/images/xx-01.jpg";
            var uncheckStar = _base+"/resources/template/images/xx-02.jpg";
            $($star).parent().parent().find("img").each(function (index,element) {
                element.src = uncheckStar;
                $(element).removeClass("starC");
            });

            $($star).addClass("starC");

            $($star).parent().parent().find("img").each(function (index,element) {
                if (index < starIndex)
                    element.src = checkStar;
            });
        }
    });
    module.exports = orderEvaluatePage;
});