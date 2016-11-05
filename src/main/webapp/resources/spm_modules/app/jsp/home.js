define('app/jsp/home', function (require, exports, module) {
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

    var homePage = Widget.extend({
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
            homePage.superclass.setup.call(this);
        }
    });

    module.exports = homePage;
});
