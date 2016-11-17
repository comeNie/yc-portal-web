define('app/jsp/transOrder/orderInfo', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
	    Widget = require('arale-widget/1.2.0/widget'),
	    AjaxController = require('opt-ajax/1.0.0/index');
    
    //实例化AJAX控制处理对象
    var ajaxController = new AjaxController();
    
    var orderInfoPage = Widget.extend({
    	
    	//事件代理
    	events: {
			"click #textSave":"_textSave",
			"click #submit": "_orderSubmit",
			"click #trans": "_trans",
			"click #editText": "_editText",
			"change input[type='file']": "_upload",
    	},
    	
//    	下载文件
    	_downLoad:function(fileId, fileName) {
    		window.open(_base + "/p/customer/order/download?fileId="+fileId+"&fileName="+fileName);
    	},
    	
    	//上传译文
    	_upload:function() {
			 var formData = new FormData($( "#uploadForm" )[0]); 
			 $.ajax({  
		         url: _base +"/p/trans/order/upload" ,  
		         type: 'POST',  
		         data: formData,  
		         async: false,  
		         cache: false,  
		         contentType: false,  
		         processData: false,  
		         success: function (data) {  
		        	 if ("1" === data.statusCode) {
							//保存成功
							//刷新页面
				    		window.location.reload();
						}
		         },  
		         error: function (data) {  
		             alert(data.data);  
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
					state: "23"
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
    	
    	// 
    	
    	  //提交订单
        _orderSubmit:function() {
        	ajaxController.ajax({
				url: _base + "/p/trans/order/save",
				data: {
					orderId: $("#orderId").val(),
				},
				success: function (data) {
					if ("1" === data.statusCode) {
						//提交成功
						//刷新页面
			    		window.location.reload();
					}
				}
			});
        }
        
    });
    module.exports = orderInfoPage;
});