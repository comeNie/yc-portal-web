define('app/jsp/transOrder/orderInfo', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
	    Widget = require('arale-widget/1.2.0/widget'),
		Dialog = require("optDialog/src/dialog"),
	    AjaxController = require('opt-ajax/1.0.0/index');
	require('jquery-i18n/1.2.2/jquery.i18n.properties.min');
	require('webuploader/webuploader');
    //实例化AJAX控制处理对象
    var ajaxController = new AjaxController();
	var processingDialog;
	var uploader = null;
    var orderInfoPage = Widget.extend({

    	//事件代理
    	events: {
			"click #textSave":"_textSave",
			"click #trans": "_trans",
			"click #editText": "_editText",
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
                checkAvailableLanguages: true,
				async: true
			});
            this._uploadFileWeb();
		},

		//上传文档，js控制
		_uploadFileWeb:function() {

			if ( !WebUploader.Uploader.support() ) {
				alert( 'Web Uploader 不支持您的浏览器！如果你使用的是IE浏览器，请尝试升级 flash 播放器');
				throw new Error( 'WebUploader does not support the browser you are using.' );
			}else if(uploader==null){
				this._initUpdate();
			}
		},

		_initUpdate:function () {
            if(processingDialog==null){
                processingDialog = new Dialog({
                    closeIconShow:false,
                    icon:"loading",
                    //正在处理中，请稍后...
                    //content: $.i18n.prop('com.ajax.def.content')
                });
            }

			var _this= this;
			var FILE_TYPES=['rar','doc','docx','txt','pdf','jpg','png','gif'];
			uploader = WebUploader.create({
				swf : _base+"/resources/spm_modules/webuploader/Uploader.swf",
				server: _base+'/p/trans/order/upload',
				auto : true,
				pick : "#selectFile",
				accept: {
					title: 'intoTypes',
					extensions: 'rar,doc,docx,txt,pdf,jpg,png,gif',
					// mimeTypes: 'application/zip,application/msword,application/pdf,image/jpeg,image/png,image/gif'
				},
                formData: {
                    orderId: $("#orderId").val()
                },
                resize : false,
				// 禁掉全局的拖拽功能。这样不会出现图片拖进页面的时候，把图片打开。
				disableGlobalDnd: true,
				// fileNumLimit: 10,
				fileSizeLimit: 100 * 1024 * 1024,    // 100 M
			});

            uploader.addButton({
                id: '#upload-btn',
                innerHTML: '选择文件'
            });

			uploader.on("beforeFileQueued", function (file) {
				var allSize = file.size;
                $("li[fileSize]").each(function () {
                    allSize += parseInt($(this).attr("fileSize"));
                });

				if (file.size > 20*1024*1024) {
					_this._showWarn($.i18n.prop('order.upload.error.fileSizeSingle'));
					return false;
				}

				if (allSize > 100*1024*1024) {
					_this._showWarn($.i18n.prop('order.upload.error.fileSize'));
					return false;
				}

				if ($.inArray(file.ext, FILE_TYPES)<0) {
					_this._showWarn($.i18n.prop('order.upload.error.type'));
					return false;
				}

                processingDialog.showModal();
			});

			uploader.on("fileQueued",function(file){
			});

			uploader.on("uploadProgress",function(file,percentage){
			});

			uploader.on( 'uploadSuccess', function( file, responseData ) {
				if(responseData.statusCode=="1"){
                    window.location.reload();
				}//上传失败
				else{
					_this._showFail($.i18n.prop('order.upload.error.upload'));
					//删除文件
					var file = uploader.getFile(file.id);
					uploader.removeFile(file);
					return;
				}
			});

			//  验证大小
			// uploader.on("error",function (type){
			// 	if(type == "F_DUPLICATE"){
			// 		_this._showWarn($.i18n.prop('order.upload.error.repeat'));
			// 	}else if(type == "Q_EXCEED_SIZE_LIMIT"){
			// 		_this._showWarn($.i18n.prop('order.upload.error.fileSize'));
			// 	}else if(type == "Q_EXCEED_NUM_LIMIT"){
			// 		_this._showWarn($.i18n.prop('order.upload.error.fileNum'));
			// 	}else if(type == "Q_TYPE_DENIED"){
			// 		_this._showWarn($.i18n.prop('order.upload.error.type'));
			// 	}
			// });

			uploader.on( 'uploadError', function( file, reason ) {
				_this._showFail($.i18n.prop('order.upload.error.upload'));

				//删除文件
				var file = uploader.getFile(file.id);
				uploader.removeFile(file);
			});

			uploader.on( 'uploadComplete', function( file ) {
                processingDialog.close();
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
			if ($.trim($("#transTextArea").val()) == '') {
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