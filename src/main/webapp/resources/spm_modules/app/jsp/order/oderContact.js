define('app/jsp/order/oderContact', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
        Widget = require('arale-widget/1.2.0/widget'),
        AjaxController = require('opt-ajax/1.0.0/index');
    require("jsviews/jsrender.min");

    require("jquery-validation/1.15.1/jquery.validate");
    require("app/util/aiopt-validate-ext");
    require('jquery-i18n/1.2.2/jquery.i18n.properties.min');
    var CountWordsUtil = require("app/util/countWords");


    //实例化AJAX控制处理对象
    var ajaxController = new AjaxController();
    var orderContactPager = Widget.extend({
        //属性，使用时由类的构造函数传入
        attrs: {
            clickId:""
        },


        //事件代理
        events: {
            "click #saveContact":"_saveContact",
            "click #editContact":"_editContactDiv",
            "click #globalRome": "_setPattern",
            "click #submitOrder":"_addTextOrder",
            "click #toCreateOrder": "_toCreateOrder"
        },


        //重写父类
        setup: function () {
            orderContactPager.superclass.setup.call(this);
            //初始化国际化
            $.i18n.properties({//加载资浏览器语言对应的资源文件
                name: ["orderInfo"], //资源文件名称，可以是数组
                path: _i18n_res, //资源文件路径
                mode: 'both',
                language: currentLan
            });

            var formValidator=this._initValidate();
            $(":input").bind("focusout",function(){
                formValidator.element(this);
            });

            this._globalRome();
        },

        _initValidate:function(){
            var formValidator=$("#contactForm").validate({
                errorPlacement: function(error, element) {
                    if (element.is(":checkbox")) {
                        error.appendTo(element.parent().parent().parent());
                    } else {
                        error.insertAfter(element);
                    }

                },
                highlight: function(element, errorClass) {

                },
                unhighlight: function(element, errorClass) {

                } ,
                errorClass:"x-label",
                showErrors:function(errorMap,errorList) {
                    $('ul li p label').remove()//删除所有隐藏的li p label标签
                    this.defaultShowErrors();
                    $('ul li p label').each(function (index,element) {
                        if (index > 0)
                            element.remove();
                    });
                },
                rules: {
                    contactName: {
                        required:true,
                    },
                    phoneNum: {
                        required:true,
                    },
                    email: {
                        required:true,
                        email:true
                    }
                },
                messages: {
                    contactName: {
                        required: $.i18n.prop('order.place.error.name')//"请输入姓名",
                    },
                    phoneNum: {
                        required: $.i18n.prop('order.place.error.phone'),//"请输入手机号",
                        pattern: $.i18n.prop('order.place.error.phone1')//"请输入正确的手机号"
                    },
                    email: {
                        required: $.i18n.prop('order.place.error.email'),//"请输入邮箱",
                        email: $.i18n.prop('order.place.error.email1')//"请输入正确的邮箱"
                    }
                }
            });

            return formValidator;
        },

        //保存联系人
        _saveContact:function() {
            var _this= this;
            var formValidator=_this._initValidate();
            formValidator.form();
            if(!$("#contactForm").valid()){
                //alert('验证不通过！！！！！');
                return;
            }

            //发请求保存联系人
            ajaxController.ajax({
                type: "post",
                url: _base + "/p/order/saveContact",
                data: $("#contactForm").serializeArray(),
                success: function (data) {
                    if ("1" === data.statusCode) {
                        //成功
                        $("#saveContactDiv").hide();
                        $("#editContactDiv").find('p').eq(0).html($("#contactName").val());
                        $("#editContactDiv").find('p').eq(1).html("+"+$("#globalRome").find('option:selected').attr('code')+" "+$("#phoneNum").val());
                        $("#editContactDiv").find('p').eq(2).html($("#email").val());
                        $("#editContactDiv").show();
                    }
                }
            });


        },

        //编辑联系人
        _editContactDiv:function() {
            $("#saveContactDiv").show();
            $("#editContactDiv").hide();
        },

        //国际编码
        _globalRome:function() {
            var gnCountryId = $("input[name='gnCountryId']").val();
            $.getJSON(_base + "/resources/spm_modules/app/jsp/order/globalRome.json",function(data){
                $.each(data.row,function(rowIndex,row){
                    var selObj = $("#globalRome");
                    var text;
                    if (currentLan.indexOf("zh") >= 0) {
                        text = row["COUNTRY_NAME_CN"];
                    } else {
                        text = row["COUNTRY_NAME_EN"];
                    }

                    selObj.append("<option value='"+row["ID"]+"' code='"+row["COUNTRY_CODE"]+"' exp='" +row["REGULAR_EXPRESSION"]+"'>"+text+"   +"+row["COUNTRY_CODE"]+"</option>");
                });
            });

            if (gnCountryId != '') {
                $("#globalRome").val(gnCountryId);
                this._setPattern();
            }
        },

        //根据国家设置号码匹配规则
        _setPattern:function() {
            var pattern = $("#saveContactDiv").find('option:selected').attr('exp');
            $("#phoneNum").attr('pattern',pattern);
        },

        //提交订单
        _addTextOrder:function(){
            var translateType = $("#transType").val();
            var contactInfo = {};
            $("#saveContactDiv").hide();
            contactInfo.contactName=$("#contactName").val();
            contactInfo.contactTel="+"+$("#globalRome").find('option:selected').attr('code')+" "+$("#phoneNum").val();
            contactInfo.contactEmail=$("#email").val();

            ajaxController.ajax({
                type: "post",
                processing: true,
                message: "保存中，请等待...",
                url: _base + "/p/order/save",
                data: {
                    contactInfo: JSON.stringify(contactInfo),
                    remark: $("#remark").val()
                },
                success: function (data) {
                    if ("1" === data.statusCode) {
                        if(translateType == 0) { //文字翻译
                            window.location.href =  _base + "/p/customer/order/payOrder/"+data.data;
                        } else {
                            //口译、文档翻译，跳到待报价页面
                            window.location.href =  _base + "/p/customer/order/orderOffer";
                        }
                    }
                }
            });
        },

        //返回上一页
        _toCreateOrder:function () {
            var translateType = $("#transType").val();

            if(translateType == 2) { //口译
                window.history.go($("#toCreateOrder").attr("skip"));
            } else {
               window.location.href= _base + "/written";
            }

        }

    });

    module.exports = orderContactPager;
});