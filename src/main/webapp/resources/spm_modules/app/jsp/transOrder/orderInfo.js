define('app/jsp/transOrder/orderInfo', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
	    Widget = require('arale-widget/1.2.0/widget'),
		Dialog = require("optDialog/src/dialog"),
	    AjaxController = require('opt-ajax/1.0.0/index');
	require('jquery-i18n/1.2.2/jquery.i18n.properties');
    //实例化AJAX控制处理对象
    var ajaxController = new AjaxController();
	var processingDialog;
    var orderInfoPage = Widget.extend({

    	//事件代理
    	events: {
			"click #textSave":"_textSave",
			"click #trans": "_trans",
			"click #editText": "_editText",
			"change input[type='file']": "_upload",
			//领取订单
			"click #received":"_getOrder"
    	},
		//重写父类
		setup: function () {
			orderInfoPage.superclass.setup.call(this);
			//初始化国际化
			$.i18n.properties({//加载资浏览器语言对应的资源文件
				name: ["orderInfo","commonRes"], //资源文件名称，可以是数组
				path: _i18n_res, //资源文件路径
				mode: 'both',
				language: currentLan,
				async: true
			});

		},

    	//上传译文校验
        _upload: function () {
            var _this = this;
            //添加上传文件验证
            var FILE_TYPES=['rar','zip','doc','docx','txt','pdf','jpg','png','gif'];
            var filePath = $("#upload").val();
            if(filePath == null || filePath=== '')
            	return;
            var extStart = filePath.lastIndexOf(".");
            var ext = filePath.substring(extStart+1, filePath.length).toLowerCase();
            //没有扩展名或扩展名不在允许范围内，则进行提示
            if (extStart < 1 || $.inArray(ext, FILE_TYPES)<0) {
                _this._showWarn($.i18n.prop('order.upload.error.type'));
                return false;
            }

			var form = document.forms["uploadForm"];
			var file = form["file"].files[0];
            var allSize = file.size;
            $("li[fileSize]").each(function () {
                allSize += parseInt($(this).attr("fileSize"));
            });

            if (file.size > 100*1024*1024) {
                _this._showWarn($.i18n.prop('order.upload.error.fileSizeSingle'));
                return
            }

            if (allSize > 100*1024*1024) {
                _this._showWarn($.i18n.prop('order.upload.error.fileSize'));
                return
            }

			if(processingDialog==null){
				processingDialog = new Dialog({
					closeIconShow:false,
					icon:"loading",
					//正在处理中，请稍后...
					content: $.i18n.prop('com.ajax.def.content')
				});
			}

			processingDialog.showModal();
            this._uploadFile();
        },

        _uploadFile:function() {
            var formData = new FormData($("#uploadForm")[0]);
            $.ajax({
                url: _base + "/p/trans/order/upload",
                type: 'POST',
                data: formData,
                async: true,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
            	processingDialog.close();
                    if ("1" === data.statusCode) {
                        //保存成功
                        //刷新页面
                        window.location.reload();
                    } else {
                        _this._showWarn(data.statusInfo);
                    }
                },
                error: function (data) {
            	processingDialog.close();
                    _this._showFail($.i18n.prop('order.upload.error.upload'));
                }
            });
        },

    	//删除译文
    	_delFile:function(fileId) {
    		ajaxController.ajax({
				type: "post",
				url: _base + "/p/trans/order/deleteFile",
				data: {
					orderId: $("#orderId").val(),
					fileId: fileId
				},
				success: function (data) {
					if ("1" === data.statusCode) {
						//删除成功
						//刷新页面
			    		window.location.reload();
					}
				}
			});
    	},

    	//保存译文
    	_textSave:function() {
			if ($("#transTextArea").val() == '') {
				this._showWarn($.i18n.prop('order.save.reason.transNull'));
				return
			}

    		ajaxController.ajax({
				type: "post",
				url: _base + "/p/trans/order/updateInfo",
				data: {
					orderId: $("#orderId").val(),
					translateInfo: $("#transTextArea").val()
				},
				success: function (data) {
					if ("1" === data.statusCode) {
						//保存成功
						//刷新页面
			    		window.location.reload();
					}
				}
			});
    	},

    	//修改按钮 触发的效果
    	_editText:function() {
    		$("#editText").parent().next().hide();
    		$("#editText").parent().parent().next("ul").show();
    		$("#editText").parent().next().next().show();
    	},

    	//从已领取到翻译状态
    	_trans:function() {
    		ajaxController.ajax({
				type: "post",
				url: _base + "/p/trans/order/updateState",
				data: {
					orderId: $("#orderId").val(),
					state: "23",
					displayFlag: "23",
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

		//领取订单
		_getOrder:function(){
			new Dialog({
				content:$.i18n.prop('order.info.claimed.confirm'),
				icon:'prompt',
				okValue: $.i18n.prop('order.info.dialog.ok'),
				cancelValue:$.i18n.prop('order.info.dialog.cancel'),
				title: $.i18n.prop('order.info.claimed.order'),
				ok:function(){
					ajaxController.ajax({
						type: "post",
						url: _base+"/p/taskcenter/claim",
						data: {'orderId': orderId,"lspId":lspId},
						success: function(data){
							//领取成功,刷新页面
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

		_showWarn:function(msg){
			new Dialog({
				content:msg,
				icon:'warning',
				okValue: $.i18n.prop("order.info.dialog.ok"),
				title:  $.i18n.prop("order.info.dialog.prompt"),
				ok:function(){
					this.close();
				}
			}).showModal();
		},
		_showFail:function(msg){
			new Dialog({
				title: $.i18n.prop("order.info.dialog.prompt"),
				content:msg,
				icon:'fail',
				okValue: $.i18n.prop("order.info.dialog.ok"),
				ok:function(){
					this.close();
				}
			}).showModal();
		}

    });
    module.exports = orderInfoPage;
});