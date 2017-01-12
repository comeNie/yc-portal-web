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
	
	require('webuploader/webuploader');
	
    var SendMessageUtil = require("app/util/sendMessage");
    
    //实例化AJAX控制处理对象
    var ajaxController = new AjaxController();
    var uploader = null;
    
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
    		"blur [id='userName']":"_checkUserNameValue",
    		"change [id='countryInfo']":"_getProviceValue",
    		"change [id='provinceInfo']":"_getCnCityValue",
			//"blur [id='countryInfo']":"_checkCountryValue",
			"blur [id='provinceInfo']":"_checkProvinceValue",
			"blur [id='cnCityInfo']":"_checkCnCityValue",
			"blur [id='address']":"_checkAddressValue",
			"change [id='uploadImg']":"_uploadFile"
        },
        //重写父类
    	setup: function () {
    		InterPreterInfoPager.superclass.setup.call(this);
    		var formValidator=this._initValidate();
    		this._loadAllCountry();
    		var countryValue = $("#countryInfo").val();
    		var provinceInfo = $("#provinceInfo").val();
    		if(provinceCode!=null&&countryValue!='0'){
    			$("#provinceP").show();
    			this._getProviceValue();
    		}
    		if(cnCityCode!=null&&provinceInfo!='0'){
    			$("#cnCityP").show();
    			this._getCnCityValue();
    		}
    		$(":input").bind("focusout",function(){
				formValidator.element(this);
			});
    	},
		//校验地址库是否合法
		/*_checkArea: function () {
			var countryInfo = $("#countryInfo").val();
			if(countryInfo)

		},*/
		_checkCountryValue:function () {
			var countryinfo = $("#countryInfo").val();
			if(countryinfo=="0"){
				$("#area-error").hide().html("");
				return ;
			}
		},
		_checkProvinceValue:function () {
			if($("#provinceInfo").is(":hidden")){
				$("#provinceInfo").val("");
			}else {
				var province = $("#provinceInfo").val();
				if(province!="0"){
					$("#area-error").hide().html("");
				}else {
					$("#area-error").show().html(interpreterInfoMsg.provinceErrorMsg);
				}
			}
		},
		_checkCnCityValue:function () {
			if($("#cnCityInfo").is(":hidden")){
				$("#cnCityInfo").val("");
			}else {
				var city = $("#cnCityInfo").val();
				if(city!="0"){
					$("#area-error").hide().html("");
				}else {
					$("#area-error").show().html(interpreterInfoMsg.cityErrorMsg);
				}
			}
		},
		_checkAddressValue:function () {
			var address = $("#address").val();
			if(address!=""||address==null){
				$("#detail-address").hide().html("");
			}else {
				$("#detail-address").show().html(interpreterInfoMsg.detailAddressErrorMsg);
			}
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
			/* if(!_checkArea()){
				 return false;
			 }*/
			 var countryinfo = $("#countryInfo").val();
			 /*if(countryinfo=="0"||countryinfo==""||countryinfo==null){
				 $("#area-error").show().html("请选择国家");
				 return false;
			 }*/
			 if($("#provinceInfo").is(":disabled")){
				 $("#provinceInfo").val("");
			 }else {
				 var province = $("#provinceInfo").val();
				 if(province=="0"||province==""||province==null){
					 $("#area-error").show().html(interpreterInfoMsg.provinceErrorMsg);
					 return false;
				 }
			 }
			 if($("#cnCityInfo").is(":disabled")){
				 $("#cnCityInfo").val("");
			 }else {
				 var city = $("#cnCityInfo").val();
				 if(city=="0"||city==""||city==null){
					$("#area-error").show().html(interpreterInfoMsg.cityErrorMsg);
					return false;
				 }
			 }
			var address = $("#address").val();
			if(countryinfo!="0"&&(address==""||address==null)){
				$("#detail-address").show().html(interpreterInfoMsg.detailAddressErrorMsg);
				return false;
			}
             ajaxController.ajax({
					type:"post",
					processing : true,
					message : " ",
    				url:_base+"/p/interpreter/saveInfo",
    				data:{
						'country':$("#countryInfo").val(),
						'province':$("#provinceInfo").val(),
						'cnCity':$("#cnCityInfo").val(),
						'address':$("#address").val(),
    					'portraitId':$("#portraitId").val(),
    					'userName':userName,
						'nickname':nickName,
						'firstname':$("#firstname").val(),
						'lastname':$("#lastname").val(),
						'sex':$("input[name='sex']:checked").val(),
						'birthdayTmp':$("#startTime").val(),
						'qq':$("#qq").val(),
						// 'portraitId':$("#portraitId").val(),
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
			if(userName==""){
				$("#userNameErrMsg").hide();
				return;
			}
			if(originalUsername==userName){//用户名未改变无需校验
				return;
			}else{
				$("#userNameErrMsg").show();
			}
			var userNameLength = $.trim(userName).length;
			if(userNameLength<6||userNameLength>16||userNameLength==0){
				$("#userNameErrMsg").hide();
				return;
			}else{
				$("#userNameErrMsg").show();
			}
			if(!this._regCheckUserName(userName)){
				$("#userNameErrMsg").hide();
				return;
			}else{
				$("#userNameErrMsg").show();
			}
			ajaxController.ajax({
				type:"post",
				url:_base+"/p/interpreter/checkUserName",
				data:{
					'userName':userName
				},
		        success: function(json) {
		        	 if(!json.data){
		        		 $("#userNameErrMsg").hide();
		        		 $("#userName-error").show().html(json.statusInfo);
		        	 }else{
		        		 $("#userNameErrMsg").show();
		        		 $("#userName-error").hide().html(""); 
		        	 }
		          }
				});
		}
		,
		_regCheckUserName:function(value){
			var re = /^[0-9a-zA-Z]\w{5,15}$/;
			return re.test(value);
		},
		_regCheckNickName:function(value){
			var re = /^[\-_0-9a-zA-Z\u4e00-\u9fa5]{1,24}$/;
			return re.test(value);
		},
		_uploadFile:function(){
			if ( !WebUploader.Uploader.support() ) {
				alert( 'Web Uploader 不支持您的浏览器！如果你使用的是IE浏览器，请尝试升级 flash 播放器');
				throw new Error( 'WebUploader does not support the browser you are using.' );
		     }else if(uploader==null){
		         this._initUpdate();
		     }
		},
		_initUpdate:function(){
			var _this= this;
		    var FILE_TYPES=['gif','jpg','png','jpeg','bmp','GIF','JPG','PNG','JPEG','BMP'];
		    uploader = WebUploader.create({
		        swf : _base+"/resources/spm_modules/webuploader/Uploader.swf",
		        server: _base+'/p/interpreter/uploadImage',
		        auto : true,
		        pick : "#uploadImg",
		        dnd: '#dndArea',  //拖拽
		        accept: {
		            title: 'Images',
		            extensions: 'gif,jpg,png,jpeg,bmp,GIF,JPG,PNG,JPEG,BMP',
		            // mimeTypes: 'application/zip,application/msword,application/pdf,image/jpeg,image/png,image/gif'
		        },
		        method:'POST',
		        resize : false,
		        // 禁掉全局的拖拽功能。这样不会出现图片拖进页面的时候，把图片打开。
		        disableGlobalDnd: true,
		        fileNumLimit: 10,
		        fileSizeLimit: 5 * 1024 * 1024,    // 5 M
		    });

		    uploader.on("beforeFileQueued", function (file) {
		        var allSize = file.size;
		        if (allSize > 5*1024*1024) {
					_this._showWarn("aabcdcse");
		            return false;
		        }
		    });
		    
		    // 当有文件添加进来的时候  
		     uploader.on( 'fileQueued', function( file ) {  // webuploader事件.当选择文件后，文件被加载到文件队列中，触发该事件。等效于 uploader.onFileueued = function(file){...} ，类似js的事件定义。  
		          var $li = $(  
		                 '<div id="' + file.id + '" class="file-item thumbnail">' +  
		                      '<img>' +  
		                      '<div class="info">' + file.name + '</div>' +  
		                      '</div>'  
		                     ),  
		                  $img = $li.find('img');  
		              // $list为容器jQuery实例  
		              $list.append( $li );  
		              // 创建缩略图  
		              // 如果为非图片文件，可以不用调用此方法。  
		              // thumbnailWidth x thumbnailHeight 为 100 x 100  
		            uploader.makeThumb( file, function( error, src ) {   //webuploader方法  
		                if ( error ) {  
		                    $img.replaceWith('<span>不能预览</span>');  
		                    return;  
		                }  
		     
		                $img.attr( 'src', src );  
		            }, 100, 100 );  
		        });  
		     // 文件上传成功，给item添加成功class, 用样式标记上传成功。  
		        uploader.on( 'uploadSuccess', function( file ) {  
		            $( '#'+file.id ).addClass('upload-state-done');  
		        });  
		       
		        // 文件上传失败，显示上传出错。  
		        uploader.on( 'uploadError', function( file ) {  
		            var $li = $( '#'+file.id ),  
		                $error = $li.find('div.error');  
		       
		            // 避免重复创建  
		            if ( !$error.length ) {  
		                $error = $('<div class="error"></div>').appendTo( $li );  
		            }  
		       
		            $error.text('上传失败');  
		       });  
		},
    	_initValidate:function(){
    		var _this = this;
    		$.validator.addMethod( "checkUserName", function( value, element, param ) {
    			if(param==false)return true;
    			/*如果参数值存在，则进行校验*/
    			var empty = $.trim(value).length?false:true;
    			if(empty)return true;
    			var userNameLength = $.trim(value).length;
    			if(userNameLength<6||userNameLength>16||userNameLength==0){
    				$("#userNameErrMsg").hide();
    			}
    			var valid =  (_this._regCheckUserName(value))?true:false;	
    			if(!valid){
    				$("#userNameErrMsg").hide();
    			}
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
    	},
    	_loadAllCountry:function(){
    		ajaxController.ajax({
    			async:false,
				type:"post",
				url:_base+"/p/interpreter/getAllCountry",
		        success: function(json) {
		        	 if(json.statusCode=='0'){
		        		 $("#userNameErrMsg").hide();
		        		 $("#userName-error").show().html(json.statusInfo);
		        	 }else{
		        		 $("#userNameErrMsg").show();
		        		$("#userName-error").hide().html(""); 
		        		var data = json.data;
						if (data) {
							var html = [];
							html.push('<option value=0>' + interpreterInfoMsg.areaTitle + '</option>');
							for (var i = 0; i < data.length; i++) {
								var t = data[i];
								var _code = t.regionCode;
								var name = t.regionNameCn;
								if ("zh_CN" != currentLan) {
									name = t.regionNameEn;
								}
								if(countryCode==_code){
									html.push('<option selected="selected" value=' + _code+ '>' +name + '</option>');
								}else if(_code=='3385'){
									html.push('<option selected="selected" value=' + _code+ '>' + name + '</option>');
								}else{
									html.push('<option value=' + _code+ '>' + name + '</option>');
								}
								
							}
							$("#countryInfo").html(html.join(""));
						}
		        	 }
		          }
				});
    	},
    	_getProviceValue:function(){
    		ajaxController.ajax({
    			async:false,
				type:"post",
				url:_base+"/p/interpreter/getProvice",
				data:{
					'regionCode':$("#countryInfo").val(),
				},
		        success: function(json) {
		        	 if(json.statusCode=='0'){
		        		 $("#userNameErrMsg").hide();
		        		 $("#userName-error").show().html(json.statusInfo);
		        	 }else{
		        		$("#userNameErrMsg").show();
		        		$("#userName-error").hide().html(""); 
		        		var data = json.data;
		        		var html = [];
		        		var html2=[];
		        		html.push('<option value=0 selected="selected">' + interpreterInfoMsg.areaTitle + '</option>');
		        		$("#provinceInfo").html(html.join(""));
		        		html2.push('<option value=0>' + interpreterInfoMsg.areaTitle + '</option>');
						$("#cnCityInfo").html(html2.join(""));
						if (data) {
							if(data.length==0){
								$("#provinceInfo").attr("disabled",true);
								$("#cnCityInfo").attr("disabled",true);
								return;
							}
							$("#provinceInfo").attr("disabled",false);
							// $("#cnCityInfo").show();
							
							for (var i = 0; i < data.length; i++) {
								var t = data[i];
								var _code = t.regionCode;
								var name = t.regionNameCn;
								if ("zh_CN" != currentLan) {
									name = t.regionNameEn;
								}
								if(_code==provinceCode){
									html.push('<option selected="selected" value=' + _code+ '>' + name + '</option>');
								}else{
									html.push('<option value=' + _code+ '>' + name + '</option>');
								}
							}
							$("#provinceInfo").html(html.join(""));
						}
		        	 }
		          }
				});
    	},
    	_getCnCityValue:function(){
    		ajaxController.ajax({
    			async:false,
				type:"post",
				url:_base+"/p/interpreter/getCnCityInfo",
				data:{
					'Code':$("#provinceInfo").val(),
				},
		        success: function(json) {
		        	 if(json.statusCode=='0'){
		        		 $("#userNameErrMsg").hide();
		        		 $("#userName-error").show().html(json.statusInfo);
		        	 }else{
		        		$("#userNameErrMsg").show();
		        		$("#userName-error").hide().html(""); 
		        		var data = json.data;
		        		var html = [];
						html.push('<option value=0>' + interpreterInfoMsg.areaTitle + '</option>');
						$("#cnCityInfo").html(html.join(""));
						if (data) {
							if(data.length==0){
								$("#cnCityInfo").attr("disabled",true);
								return;
							}
							$("#cnCityInfo").attr("disabled",false);
							for (var i = 0; i < data.length; i++) {
								var t = data[i];
								var _code = t.regionCode;
								var name = t.regionNameCn;
								if ("zh_CN" != currentLan) {
									name = t.regionNameEn;
								}
								if(cnCityCode==_code){
									html.push('<option selected="selected" value=' + _code+ ' >' + name + '</option>');
								}else{
									html.push('<option value=' + _code+ ' >' + name + '</option>');
								}
							}
							$("#cnCityInfo").html(html.join(""));
						}
		        	 }
		          }
				});
    	}
    })
    module.exports = InterPreterInfoPager
});

/*function uploadFile(){
	alert("sfeefrfsef");
	 if ( !WebUploader.Uploader.support() ) {
         alert( 'Web Uploader 不支持您的浏览器！如果你使用的是IE浏览器，请尝试升级 flash 播放器');
         throw new Error( 'WebUploader does not support the browser you are using.' );
     }else if(uploader==null){
         this.initUpdate();
     }
	this.initUpdate();
}

//初始化上传控件
function initUpdate() {
	var _this= this;
    var FILE_TYPES=['gif','jpg','png','jpeg','bmp','GIF','JPG','PNG','JPEG','BMP'];
    uploader = WebUploader.create({
        swf : _base+"/resources/spm_modules/webuploader/Uploader.swf",
        server: _base+'/p/interpreter/uploadImage',
        auto : true,
        pick : "#selectFile",
       // dnd: '#fy2', //拖拽
        accept: {
            title: 'Images',
            extensions: 'gif,jpg,png,jpeg,bmp,GIF,JPG,PNG,JPEG,BMP',
            // mimeTypes: 'application/zip,application/msword,application/pdf,image/jpeg,image/png,image/gif'
        },
        method:'POST',
        resize : false,
        // 禁掉全局的拖拽功能。这样不会出现图片拖进页面的时候，把图片打开。
        disableGlobalDnd: true,
        fileNumLimit: 10,
        fileSizeLimit: 5 * 1024 * 1024,    // 5 M
    });

    uploader.on("beforeFileQueued", function (file) {
        var allSize = file.size;
        if (allSize > 5*1024*1024) {
			_this._showWarn("aabcdcse");
            return false;
        }
    });
    
    // 当有文件添加进来的时候  
     uploader.on( 'fileQueued', function( file ) {  // webuploader事件.当选择文件后，文件被加载到文件队列中，触发该事件。等效于 uploader.onFileueued = function(file){...} ，类似js的事件定义。  
          var $li = $(  
                 '<div id="' + file.id + '" class="file-item thumbnail">' +  
                      '<img>' +  
                      '<div class="info">' + file.name + '</div>' +  
                      '</div>'  
                     ),  
                  $img = $li.find('img');  
              // $list为容器jQuery实例  
              $list.append( $li );  
              // 创建缩略图  
              // 如果为非图片文件，可以不用调用此方法。  
              // thumbnailWidth x thumbnailHeight 为 100 x 100  
            uploader.makeThumb( file, function( error, src ) {   //webuploader方法  
                if ( error ) {  
                    $img.replaceWith('<span>不能预览</span>');  
                    return;  
                }  
     
                $img.attr( 'src', src );  
            }, 100, 100 );  
        });  
     // 文件上传成功，给item添加成功class, 用样式标记上传成功。  
        uploader.on( 'uploadSuccess', function( file ) {  
            $( '#'+file.id ).addClass('upload-state-done');  
        });  
       
        // 文件上传失败，显示上传出错。  
        uploader.on( 'uploadError', function( file ) {  
            var $li = $( '#'+file.id ),  
                $error = $li.find('div.error');  
       
            // 避免重复创建  
            if ( !$error.length ) {  
                $error = $('<div class="error"></div>').appendTo( $li );  
            }  
       
            $error.text('上传失败');  
       });  
     // 完成上传完了，成功或者失败，先删除进度条。  
}*/

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

