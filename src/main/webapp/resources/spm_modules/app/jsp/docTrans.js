define('app/jsp/docTrans', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
        Widget = require('arale-widget/1.2.0/widget'),
        Dialog = require("optDialog/src/dialog"),
        AjaxController = require('opt-ajax/1.0.0/index');
	require('jquery-i18n/1.2.2/jquery.i18n.properties.min');

    //实例化AJAX控制处理对象
    var ajaxController = new AjaxController();
    var languageaudio;
	var sourYiWen="";
	var clip;
    var uploader = null;

	var docTrans = Widget.extend({
        //属性，使用时由类的构造函数传入
        attrs: {},

        //事件代理
        events: {
            "click #downDoc":"_downDoc",
            "click #downTxt":"_downTxt",
            "click #loadMore":""
        },

        //重写父类
        setup: function () {
            docTrans.superclass.setup.call(this);

        	//初始化国际化
			$.i18n.properties({//加载资浏览器语言对应的资源文件
				name: ["home","commonRes"], //资源文件名称，可以是数组
				path: _i18n_res, //资源文件路径
				mode: 'both',
                cache: true,
				language: currentLan,
                checkAvailableLanguages: true
			});

        },

        //下载doc
		_downDoc:function () {
            window.open(_base +"/downloadDoc?fileType=doc");
        },
        //下载txt
        _downTxt:function () {
            window.open(_base +"/downloadDoc?fileType=txt");
        },
        //加载更多
        _loadMore:function () {
            if(window.console){
                console.log("load more");
            }
        },


		//显示警告信息
        _showWarn: function (msg) {
            new Dialog({
                content: msg,
                icon: 'warning',
                okValue: $.i18n.prop("com.ajax.def.okbtn"),
                title: $.i18n.prop("com.info.dialog.prompt"),
                ok: function () {
                    this.close();
                }
            }).showModal();
        },
		//显示失败信息
        _showFail:function(msg){
            if ($("div[tabindex='-1']").size() == 0) {
                new Dialog({
                    title: $.i18n.prop("com.info.dialog.prompt"),
                    content:msg,
                    icon:'fail',
                    okValue: $.i18n.prop("com.ajax.def.okbtn"),
                    ok:function(){
                        this.close();
                    }
                }).show();
            }
        }
    });

    module.exports = docTrans;
});
