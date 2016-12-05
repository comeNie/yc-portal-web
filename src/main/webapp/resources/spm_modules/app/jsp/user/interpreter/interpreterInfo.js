define('app/jsp/user/interpreter/interpreterInfo', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
    Widget = require('arale-widget/1.2.0/widget'),
    Dialog = require("optDialog/src/dialog"),
    Paging = require('paging/0.0.1/paging-debug'),
    Uploader = require('arale-upload/1.2.0/index'),
    AjaxController = require('opt-ajax/1.0.0/index'),
    Calendar = require('arale-calendar/1.1.2/index');
    
    require("jsviews/jsrender.min");
    require("jsviews/jsviews.min");
    require("bootstrap-paginator/bootstrap-paginator.min");
    require("app/util/jsviews-ext");
    require("opt-paging/aiopt.pagination");
    require("twbs-pagination/jquery.twbsPagination.min");
    
    require("jquery-validation/1.15.1/jquery.validate");
	require("app/util/aiopt-validate-ext");
    
	require("my97DatePicker/WdatePicker");
	
	require("app/jsp/user/ajaxfileupload");
	
    var SendMessageUtil = require("app/util/sendMessage");
    
    //实例化AJAX控制处理对象
    var ajaxController = new AjaxController();
    var showMsg = function(msg){
    	var d = Dialog({
			content:msg,
			icon:'fail',
			okValue: interpreterInfoMsg.showOkValueMsg,
			title: interpreterInfoMsg.showTitleMsg,
			ok:function(){
				d.close();
			}
		});
		d.showModal();
    };
    var showMsg2 = function(msg){
    	var d = Dialog({
			content:msg,
			icon:'success',
			okValue: interpreterInfoMsg.showOkValueMsg,
			title: interpreterInfoMsg.showTitleMsg,
			ok:function(){
				d.close();
			}
		});
		d.showModal();
    };
    //定义页面组件类
    var InterPreterInfoPager = Widget.extend({
    	//属性，使用时由类的构造函数传入
    	attrs: {
    	},
    	Statics: {
    		DEFAULT_PAGE_SIZE: 10
    	},
    	//事件代理
    	events: {
			//保存数据
    		"click [id='saveButton']":"_saveInterpreterInfo",
    		"blur [id='nickname']":"_checkNickNameValue",
    		"blur [id='userName']":"_checkUserNameValue"
        },
        //重写父类
    	setup: function () {
    		InterPreterInfoPager.superclass.setup.call(this);
    		var formValidator=this._initValidate();
    		$(":input").bind("focusout",function(){
				formValidator.element(this);
			});
    	},
    	_saveInterpreterInfo:function(){
    	    var formValidator=this._initValidate();
			formValidator.form();
			if(!$("#dataForm").valid()){
				return false;
			}else{
			 var userPortraitImg ="";
			 if($("#portraitFileId").attr("src")){
				 userPortraitImg =$("#portraitFileId").attr("src");
			 }
			 var userName =$("#userName").val();
			 var nickName =$("#nickname").val();
             ajaxController.ajax({
					type:"post",
					processing : true,
					message : " ",
    				url:_base+"/p/interpreter/saveInfo",
    				data:{
    					'portraitId':$("#portraitId").val(),
    					'userName':userName,
						'nickname':nickName,
						'firstname':$("#firstname").val(),
						'lastname':$("#lastname").val(),
						'sex':$("input[name='sex']:checked").val(),
						'birthdayTmp':$("#startTime").val(),
						'qq':$("#qq").val(),
						'portraitId':$("#portraitId").val(),
						'originalNickname':originalNickname,
						'originalUsername':originalUsername,
						'userPortraitImg':userPortraitImg
    				},
    		        success: function(json) {
    		        	if(!json.data){
    		        		showMsg(json.statusInfo);
    		        	}else{
    		        		if(originalUsername!=userName&&userName!=""){//用户名发生改变
    		        			//输入框替换
    		    				$("#p_userName").html(userName);
    		    				//更新头部菜单用户名显示
    		    				$("#top_username").html(userName);
    		    				//更新左侧菜单用户名显示
    		    				$("#left_username").html(userName);
    		    			}
    		        		//用户名重新赋值
    		        		originalUsername = userName;
		        			//昵称重新赋值
    		        		originalNickname=nickName;
    		        		//更新头像显示
    		        		$("#ycUserPortraitImg").attr("src",$("#portraitFileId").attr("src"));
    		        		showMsg2(json.statusInfo);
    		        	}
    		          }
    				});
			
			}
		},
		_checkNickNameValue:function(){
			var nickname =  $("#nickname").val();
			if(originalNickname==nickname||nickname==""){//昵称未改变无需校验
				return;
			}
			if(!this._regCheckNickName(nickname)){
				return;
			}
			ajaxController.ajax({
				type:"post",
				url:_base+"/p/interpreter/checkNickName",
				data:{
					'nickName':nickname
				},
		        success: function(json) {
		        	 if(!json.data){
		        		 $("#nickname-error").show().html(json.statusInfo);
		        	 }else{
		        		 $("#nickname-error").hide().html(""); 
		        	 }
		          }
				});
		},
		_checkUserNameValue:function(){
			var userName =  $("#userName").val();
			if(originalUsername==userName||userName==""){//用户名未改变无需校验
				return;
			}
			if(!this._regCheckUserName(userName)){
				return;
			}
			ajaxController.ajax({
				type:"post",
				url:_base+"/p/interpreter/checkUserName",
				data:{
					'userName':userName
				},
		        success: function(json) {
		        	 if(!json.data){
		        		 $("#userName-error").show().html(json.statusInfo);
		        	 }else{
		        		 $("#userName-error").hide().html(""); 
		        	 }
		          }
				});
		}
		,
		_regCheckUserName:function(value){
			var re = /^(?![0-9]+$)(?![a-zA-Z]+$)[a-z0-9A-Z][a-z0-9A-Z_]{5,15}$/;
			return re.test(value);
		},
		_regCheckNickName:function(value){
			var re = /^[\-_0-9a-zA-Z\u4e00-\u9fa5]{1,24}$/;
			return re.test(value);
		}
		
		,
    	_initValidate:function(){
    		var _this = this;
    		$.validator.addMethod( "checkUserName", function( value, element, param ) {
    			if(param==false)return true;
    			/*如果参数值存在，则进行校验*/
    			var empty = $.trim(value).length?false:true;
    			if(empty)return true;
    			var valid =  (_this._regCheckUserName(value))?true:false;		
    			return valid;
    		}, $.validator.format(interpreterInfoMsg.userNameErrorMsg) );
    		$.validator.addMethod( "checkNickName", function( value, element, param ) {
    			if(param==false)return true;
    			/*如果参数值存在，则进行校验*/
    			var empty = $.trim(value).length?false:true;
    			if(empty)return true;
    			var valid =  (_this._regCheckNickName(value))?true:false;		
    			return valid;
    		}, $.validator.format(interpreterInfoMsg.nickNameErrorMsg) );
    		var formValidator=$("#dataForm").validate({
    			rules: {
    				userName: {
    					required:true,
    					maxlength:16,
    					minlength:6,
    					checkUserName: $("#userName").val()
    					},
    				nickname: {
    					required:true,
    					maxlength:24,
    					minlength:1,
    					checkNickName: $("#nickname").val()
    					},
    			   qq:{
    			    	required:false,
    					maxlength:10,
    					digits:true,
    			    }
    			},
    			messages: {
    				userName: {
    					required:interpreterInfoMsg.userNameEmptyMsg,
    					maxlength:interpreterInfoMsg.userNameMaxMsg,
    					minlength:interpreterInfoMsg.userNameMinMsg
    					},
    				nickname: {
    					required:interpreterInfoMsg.nickNameEmptyMsg,
    					maxlength:interpreterInfoMsg.nickNameMaxMsg,
    					minlength:interpreterInfoMsg.nickNameMinMsg
    				},
    				qq:{
    					digits: interpreterInfoMsg.qqErrorMsg
    				}
    			},
    			
    			
    		});
    		
    		return formValidator;
    	}
    })
    module.exports = InterPreterInfoPager
});
function uploadPortraitImg(uploadImgFile){
	
	var image = $("#uploadImg").val();
	if(!/\.(gif|jpg|png|jpeg|bmp|GIF|JPG|PNG|JPEG|BMP)$/.test(image)){
		$("#uploadImgErrMsg").show();
		$("#uploadImgText").show();
		$("#uploadImgText").text(interpreterInfoMsg.uplaodImageMsg);
		$("#uploadImgFlag").val("0");
		return false;
	}else if(document.getElementById("uploadImg").files[0].size>5*1024*1024){
		$("#uploadImgErrMsg").show();
		$("#uploadImgText").show();
		$("#uploadImgText").text(interpreterInfoMsg.uplaodImageMsg);
		$("#uploadImgFlag").val("0");
		return false;
	}else{
		$("#uploadImgErrMsg").hide();
		$("#uploadImgText").hide();
		$("#uploadImgText").text('');
		$("#uploadImgFlag").val("1");
	}
	
	 $.ajaxFileUpload({  
         url:_base+"/p/interpreter/uploadImage",  
         secureuri:false,  
         fileElementId:uploadImgFile,//file标签的id  
         dataType: "text",//返回数据的类型  
         data:{uploadImgFile:uploadImgFile},//一同上传的数据  
         success: function (data, status) {
        	 var jsonData = JSON.parse(data);
        	if(jsonData.isTrue){
        		document.getElementById("portraitFileId").src=jsonData.url;
        		$("#portraitId").val(jsonData.idpsId);
        	 }
         },
         error: function (data, status, e) {  
             alert(e);  
         }
     }); 
	}

