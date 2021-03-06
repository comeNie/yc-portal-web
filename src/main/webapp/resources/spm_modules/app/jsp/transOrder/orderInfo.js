define('app/jsp/transOrder/orderInfo', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
	    Widget = require('arale-widget/1.2.0/widget'),
		Dialog = require("optDialog/src/dialog"),
	    AjaxController = require('opt-ajax/1.0.0/index');
    require("jsviews/jsrender.min");
    require("jsviews/jsviews.min");
    require("app/util/jsviews-ext");
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
			//点击分配
			"click #recharge-popo":"_allocation",
			//添加口译人员
			"click #addInterpreter":"_addInter",
			//译员确认领取
			"click #claim":"_claim",
			//lsp审核
			"click #approvalBtn":"_approval",
			"click #editText": "_editText",
			//领取订单
			"click #received":"_getOrder",
			//确定分配人员
			"click #tran-determine":"_confirmAssign",
			//关闭分配窗口
			"click #tran-close":"_closeTran",
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
                cache: true,
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
		 showMsg :function(msg){
	    	var d = Dialog({
				content:msg,
				icon:'fail',
				okValue:alloPenMsg.showOK,
				title: "提示",
				ok:function(){
					d.close();
				}
			});
			d.showModal();
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
				pick : {id:"#selectFile", multiple: false},
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

				if (file.size == 0) {
					_this._showWarn($.i18n.prop('order.upload.error.empty'));
					return false;
				}

				if (file.size > 20*1024*1024) {
					_this._showWarn($.i18n.prop('order.upload.error.fileSizeSingle'));
					return false;
				}

				if (allSize > 100*1024*1024) {
					_this._showWarn($.i18n.prop('order.upload.error.fileSize'));
					return false;
				}

				if ($.inArray(file.ext.toLowerCase(), FILE_TYPES)<0) {
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
				processing: true,
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
				processing: true,
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
		//分配按钮触发事件
        _allocation:function () {
        	var _this = this;
			//若是待领取的口译订单，则直接显示分配
			if(translateType == "2" && orderState == "21"){
				_this._openTran();
			}//若是待领取的笔译订单，则直接显示笔译分配
			else if(translateType!="2"){
				_this._openPenTran();
			}
			//_this._openPenTran();
			//若是笔译，且不是待领取，则从后台获取数据。
        },
		//添加口译译员信息
        _addInter:function () {
        	//校验译员最多有10项
        	var ss = $("#oralTrans").find("tr").length;
        	var interperNum = parseInt(ss)+1;
        	if(interperNum>10){
        		//alert("最多4个译员");
        		this.showMsg(alloPenMsg.moreMouthInterperError);
        		return false;
        	}
    		var data = {"name":"","number":"","opType":""};
            var htmlOutput = "<tr>"+this._editInter(data)+"</tr>";
            $("#oralTrans").append(htmlOutput);
        },
		//保存口译分配译员信息
		_saveInter:function (interInfo) {
            var template = $.templates("#tranView");
            return template.render(interInfo);
        },
		//编辑口译分配译员信息
		_editInter:function (interInfo) {
            var template = $.templates("#tranEdit");
            return template.render(interInfo);
        },
		//lsp译员领取订单
        _claim:function () {
            ajaxController.ajax({
                type: "post",
                processing: true,
                url: _base + "/p/assigntask/claim",
                data: {
                    orderId: $("#orderId").val(),
                    step: followId
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
    	//从已领取到翻译状态
    	_trans:function() {
    		ajaxController.ajax({
				type: "post",
				processing: true,
				url: _base + "/p/trans/order/updateState",
				data: {
					orderId: $("#orderId").val(),
					state: "23",
					displayFlag: "23"
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
						processing: true,
						url: _base+"/p/taskcenter/claim",
						data: {'orderId': orderId,"lspId":lspId,"lspRole":lspRole,"translateType":translateType},
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
		//lsp审核
        _approval:function () {
            ajaxController.ajax({
                type: "post",
                processing: true,
                url: _base + "/p/trans/order/approval",
                data: {
                    orderId: orderId
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
		//打开口译分配窗口
		_openTran:function () {
            $('#eject-mask').fadeIn(100);
            $('[assign-tran-dialog]').slideDown(100);
        },
        //打开笔译分配窗口
        _openPenTran:function () {
            $('#eject-mask').fadeIn(100);
            $('#fenpei').slideDown(100);
           // this._bindInterperSelect();
        },
		//保存分配人员信息
        _confirmAssign:function () {
        	var _this=this;
            //若是待领取的口译订单，则直接显示分配
            if(translateType == "2"){
            	//判断确认口译分配人员
            	_this._confirmOralAssign();
            	//分配
            }
        },
        //口译订单分配保存
        _alloOral:function (param) {
        	if(null==param || ""==param){
        		//alert("译员信息不能为空");
        		this.showMsg(alloPenMsg.interperNotEmptyError);
        		return false;
        	}
        	var orderId = $("#orderId").val();
            ajaxController.ajax({
                type: "post",
                processing: true,
                dataType : "json",
                url: _base + "/p/customer/order/alloOrder",
                data: {
                	orderId:orderId,
                	personInfo:JSON.stringify(param)
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
		//确认口译分配人员
		_confirmOralAssign:function () {
			//检查是否有未保存译员信息。
			var _this=this;
			var param = {};
			var personList=[];
            $("#oralTrans").children().each(function (i) {
            	//判断input选项是否存在
            	var inObj = $(this).children().children("input").eq(0).val();
            	var dataname = $(this).children().children("span").eq(0).text() ;
            	var datanumber = $(this).children().children("span").eq(1).text() ;
            	var person = {};
            	person.interperName = dataname;
            	person.tel = datanumber;
            	personList.push(person);
            	if(undefined!=inObj){
            		if(inObj==null || ""==inObj){
                		//alert("有未保存的译员数据");
                		this.showMsg(alloPenMsg.notFinishError);
                		return false;
                	}
            	}
            })
            if(null==personList || ""==personList){
            	alert("译员不能为空");
            	return false;
            }else{
            	 //调用分配操作
                param.personList=personList;
                _this._alloOral(param);
            }
           
        },
		//关闭口译分配窗口
        _closeTran:function () {
            $('#eject-mask').fadeOut(200);
            $('[assign-tran-dialog]').slideUp(200);
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
		},
		//查询笔译分配人员
		_bindInterperSelect : function() {
			var this_=this;
			$.ajax({
				type : "post",
				processing : false,
				url : _base+ "/p/customer/order/getInterperSelect",
				dataType : "json",
				data : {
					lspId:$("#lspId").val(),
					duadId:$("#langugeId").val()
				},
				message : "正在加载数据..",
				success : function(data) {
					if(null!=data.data){
						userList=data.data;
					}else{
						alert("分配译员查询错误");
					}
				}
			});
		}

    });
    module.exports = orderInfoPage;
});
//笔译订单分配
function alloPen(param,orderId){
	$.ajax({
		type : "post",
		processing : false,
		message : "删除",
		url: _base + "/p/customer/order/alloPenOrder",
        data: {
        	orderId:orderId,
        	personInfo:JSON.stringify(param)
        },
		success : function(json) {
			//刷新页面
            window.location.reload();
		}
	})
}