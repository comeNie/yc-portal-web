define('app/jsp/translator/translatorInfo', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
    Widget = require('arale-widget/1.2.0/widget'),
    Dialog = require("optDialog/src/dialog"),
    AjaxController = require('opt-ajax/1.0.0/index'),
    Calendar = require('arale-calendar/1.1.2/index');
    
    require("jsviews/jsrender.min");
    require("jsviews/jsviews.min");
    
    require("jquery-validation/1.15.1/jquery.validate");
	require("app/util/aiopt-validate-ext");
    
	require("my97DatePicker/WdatePicker");
	
	require('webuploader/webuploader');
    
    //实例化AJAX控制处理对象
    var ajaxController = new AjaxController();
    var uploader = null;
    var count=0;
    var languageText="";
    var tmpNumber = 0;
    $(".portrait-file").addClass("webuploader-element-invisible");
    var showMsg = function(msg){
    	var d = Dialog({
			content:msg,
			icon:'fail',
			okValue: translatorInfoMsg.showOkValueMsg,
			title: translatorInfoMsg.showTitleMsg,
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
			okValue: translatorInfoMsg.showOkValueMsg,
			title: translatorInfoMsg.showTitleMsg,
			ok:function(){
				d.close();
			}
		});
		d.showModal();
    };
    //定义页面组件类
    var TranslatorInfoPager = Widget.extend({
    	//属性，使用时由类的构造函数传入
    	attrs: {
    	},
    	Statics: {
    		DEFAULT_PAGE_SIZE: 10
    	},
    	//事件代理
    	events: {
			//保存数据
    		"blur [id='nickname']":"_checkNickNameValue",
    		"blur [id='userName']":"_checkUserNameValue",
    		"change [id='countryInfo']":"_getProviceValue",
    		"change [id='provinceInfo']":"_getCnCityValue",
			//"blur [id='countryInfo']":"_checkCountryValue",
			"blur [id='provinceInfo']":"_checkProvinceValue",
			"blur [id='cnCityInfo']":"_checkCnCityValue",
			"blur [id='address']":"_checkAddressValue",
			"change [id='uploadImg']":"_uploadFile",
			"click [id='OK']":"_createLanguage",
			"click [id='addLanguage']":"_addLanguage",
			"click [id='editText']":"_toEditText",
			"click [id='recharge-popo']":"_toSaveFirstStep",
        },
        //重写父类
    	setup: function () {
    		TranslatorInfoPager.superclass.setup.call(this);
    		var formValidator=this._initValidate();
    		this._loadAllCountry();
    		this._loadLanguage();
    		this._loadGoodUse();
    		this._loadField();
    		this._loadParentLanguage();
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
			this._uploadFile();
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
					$("#area-error").show().html(translatorInfoMsg.provinceErrorMsg);
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
					$("#area-error").show().html(translatorInfoMsg.cityErrorMsg);
				}
			}
		},
		_checkAddressValue:function () {
			var address = $("#address").val();
			if(address!=""||address==null){
				$("#detail-address").hide().html("");
			}else {
				$("#detail-address").show().html(translatorInfoMsg.detailAddressErrorMsg);
			}
		},
		_toSaveFirstStep:function(){
    	    var formValidator=this._initValidate();
			formValidator.form();
			if(!$("#dataForm").valid()){
				return false;
			}else{
				var goodFieldobj=document.getElementsByName('goodFields'); 
	    		var goodFields=''; 
	    		for(var i=0; i<goodFieldobj.length; i++){ 
		    		if(goodFieldobj[i].checked){
		    			goodFields+=goodFieldobj[i].value+','; //如果选中，将value添加到变量s中 
		    			}
		    		}
	    		goodFields = goodFields.substring(0, goodFields.length-1);
	    		if(goodFields.length==0){
					$("#goodFieldError").show();
					$("#goodFieldErrorText").text("请选择擅长领域");
					return;
				}else{
					$("#goodFieldError").hide();
				}
	    		$("#goodFieldsValue").val(goodFields);
	    		
	    		var goodUsersObj=document.getElementsByName('goodUsers'); 
	    		var goodUsers=''; 
	    		for(var i=0; i<goodUsersObj.length; i++){ 
		    		if(goodUsersObj[i].checked){
		    			goodUsers+=goodUsersObj[i].value+','; //如果选中，将value添加到变量s中 
		    			}
		    		}
	    		goodUsers = goodUsers.substring(0, goodUsers.length-1);
	    		if(goodUsers.length==0){
					$("#goodUsersError").show();
					$("#goodUsersErrorText").text("请选择擅长用途");
					return;
				}else{
					$("#goodUsersError").hide();
				}
	    		
			 var userPortraitImg ="";
			 if($("#portraitFileId").attr("src")){
				 userPortraitImg =$("#portraitFileId").attr("src");
			 }
			 var userName =$("#userName").val();
			 var nickName =$("#nickname").val();
			
			 var countryinfo = $("#countryInfo").val();
			 if($("#provinceInfo").is(":disabled")){
				 $("#provinceInfo").val("");
			 }else {
				 var province = $("#provinceInfo").val();
				 if(province=="0"||province==""||province==null){
					 $("#area-error").show().html(translatorInfoMsg.provinceErrorMsg);
					 return false;
				 }
			 }
			 if($("#cnCityInfo").is(":disabled")){
				 $("#cnCityInfo").val("");
			 }else {
				 var city = $("#cnCityInfo").val();
				 if(city=="0"||city==""||city==null){
					$("#area-error").show().html(translatorInfoMsg.cityErrorMsg);
					return false;
				 }
			 }
			var address = $("#address").val();
			if(countryinfo!="0"&&(address==""||address==null)){
				$("#detail-address").show().html(translatorInfoMsg.detailAddressErrorMsg);
				return false;
			}
             ajaxController.ajax({
					type:"post",
					processing : true,
					message : " ",
    				url:_base+"/p/translator/toSaveFirstStep",
    				data:{
    					'translatorId':translatorId,
    					'firstName':$("#firstName").val(),
    					'lastName':$("#lastName").val(),
    					'nickName':$("#nickName").val(),
    					'tmpBirthday':$("#startTime").val(),
						'country':$("#countryInfo").val(),
						'province':$("#provinceInfo").val(),
						'cnCity':$("#cnCityInfo").val(),
						'address':$("#address").val(),
						'legalCertNum':$("#legalCertNum").val(),
						'motherTongue':$("#motherTongue").val(),
						'workingLife':$("#translationYears").val(),
						'areaOfExperise':goodFields,
						'areaOfUse':goodUsers,
						'fixPhone':$("#fixPhone").val(),
						'qq':$("#qq").val()
    				},
    		        success: function(json) {
    		        	if(!json.data){
    		        		showMsg(json.statusInfo);
    		        	}else{
    		        		window.location.href = _base+"/p/translator/toSecondStepPager?source=interpreter&curLanguage="+curLanguage;
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
		        pick : "#portraitbox",
		        accept: {
		            title: 'Images',
		            extensions: 'gif,jpg,jpeg,bmp,png',
		            mimeTypes: 'image/*'
		        },		        
		        resize : false,
		        disableGlobalDnd: true,
		        fileNumLimit: 10,
		        fileSizeLimit: 5 * 1024 * 1024    // 5 M
		    });

		    uploader.on("beforeFileQueued", function (file) {
		    	var image = file.name;
		    	 var allSize = file.size;
		    	if(!/\.(gif|jpg|png|jpeg|bmp|GIF|JPG|PNG|JPEG|BMP)$/.test(image)){
		    		$("#uploadImgErrMsg").show();
		    		$("#uploadImgText").show();
		    		$("#uploadImgText").text(translatorInfoMsg.uplaodImageMsg);
		    		$("#uploadImgFlag").val("0");
		    		return false;
		    	}else if(allSize > 5*1024*1024){
		    		$("#uploadImgErrMsg").show();
		    		$("#uploadImgText").show();
		    		$("#uploadImgText").text(translatorInfoMsg.uplaodImageMsg);
		    		$("#uploadImgFlag").val("0");
		    		return false;
		    	}else{
		    		$("#uploadImgErrMsg").hide();
		    		$("#uploadImgText").hide();
		    		$("#uploadImgText").text('');
		    		$("#uploadImgFlag").val("1");
		    	}
		    });
	     // 文件上传成功，给item添加成功class, 用样式标记上传成功。  
	        uploader.on( 'uploadSuccess', function( file, data) {  
	        	if(data.isTrue){
	        		document.getElementById("portraitFileId").src=data.url;
	        		$("#portraitId").val(data.idpsId);
	        	 }else{
	        		 $("#uploadImgText").text(translatorInfoMsg.uplaodImageMsg);
	        	 }
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
    		}, $.validator.format(translatorInfoMsg.userNameErrorMsg) );
    		$.validator.addMethod( "checkNickName", function( value, element, param ) {
    			if(param==false)return true;
    			/*如果参数值存在，则进行校验*/
    			var empty = $.trim(value).length?false:true;
    			if(empty)return true;
    			var valid =  (_this._regCheckNickName(value))?true:false;		
    			return valid;
    		}, $.validator.format(translatorInfoMsg.nickNameErrorMsg) );
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
    			    },
    			    legalCertNum:{
    			    	required:false,
    			    	regexp: /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/,
    			    	digits:false,
    			    },
    			    workingLife:{
    			    	required:true,
    			    	regexp: /(^\d{1,3}$)/,
    			    	digits:false,
    			    },
    			    fixPhone:{
    			    	required:false,
    			    	regexp: /(^\d{1,10}$)/,
    			    	digits:false,
    			    }
    			},
    			messages: {
    				userName: {
    					required:translatorInfoMsg.userNameEmptyMsg,
    					maxlength:translatorInfoMsg.userNameMaxMsg,
    					minlength:translatorInfoMsg.userNameMinMsg
    					},
    				nickname: {
    					required:translatorInfoMsg.nickNameEmptyMsg,
    					maxlength:translatorInfoMsg.nickNameMaxMsg,
    					minlength:translatorInfoMsg.nickNameMinMsg
    				},
    				qq:{
    					digits: translatorInfoMsg.qqErrorMsg
    				},
    				legalCertNum:{
    					regexp: "请输入正确的身份证号"
    				},
    				workingLife:{
    					required:"翻译年限不能为空",
    					maxlength:"翻译年限不能超过3位整数",
    					regexp: "请输入小于999的整数"
    				},
    				fixPhone:{
     			    	required:false,
     			    	regexp: "请输入正确座机号"
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
							html.push('<option value=0>' + translatorInfoMsg.areaTitle + '</option>');
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
		        		html.push('<option value=0 selected="selected">' + translatorInfoMsg.areaTitle + '</option>');
		        		$("#provinceInfo").html(html.join(""));
		        		html2.push('<option value=0>' + translatorInfoMsg.areaTitle + '</option>');
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
						html.push('<option value=0>' + translatorInfoMsg.areaTitle + '</option>');
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
    	},
    	_loadLanguage:function(){
    		var orderType = $("#orderType").val()
    		ajaxController.ajax({
    			async:false,
				type:"post",
				url:_base+"/p/translator/getLanguages",
				data:{
					language:currentLan,
					orderType:orderType,
				},
		        success: function(json) {
		        	 if(json.statusCode=='0'){
		        		 /*$("#userNameErrMsg").hide();
		        		 $("#userName-error").show().html(json.statusInfo);*/
		        	 }else{
		        		/*$("#userNameErrMsg").show();
		        		$("#userName-error").hide().html(""); */
		        		var data = json.data;
						if (data) {
							var html = [];
							//html.push('<option value=0>' + "q" + '</option>');
							for (var i = 0; i < data.length; i++) {
								var t = data[i];
								var _code = t.duadId;
								var sourceName = t.sourceCn;
								var targetName = t.targetCn;
								if ("zh_CN" != currentLan) {
									sourceName = t.sourceEn;
									targetName = t.targetCn;
								}
								if(countryCode==_code){
									html.push('<option selected="selected" value=' + _code+ '>' +name + '</option>');
								}else{
									html.push('<option value=' + _code+ '>' + sourceName+"->"+targetName + '</option>');
								}
								
							}
							$("#languagePair").html(html.join(""));
							languageText = html.join("");
							languagePairText = html.join("");
						}
		        	 }
		          }
				});
    	},
    	_loadParentLanguage:function(){
    		ajaxController.ajax({
    			async:false,
				type:"post",
				url:_base+"/p/translator/getParentLanguages",
		        success: function(json) {
		        	 if(json.statusCode!='0'){
			        		var data = json.data;
							if (data) {
								var html = [];
								//html.push('<option value=0>' + "q" + '</option>');
								for (var i = 0; i < data.length; i++) {
									var t = data[i];
									var _code = t.pkDicTable;
									var name = "";
									if ("zh_CN" != currentLan) {
										name = t.nameEN;
									}else{
										name = t.nameZH;
									}
									if(motherTongue ==_code&&name!=null){
										html.push('<option selected="selected" value=' + _code+ '>' +name + '</option>');
									}else if(name!=null){
										html.push('<option value=' + _code+ '>' +name + '</option>');
									}
									
								}
								$("#motherTongue").html(html.join(""));
							}
			        	 
		        	 }
		          }
				});
    	},
    	_createLanguage:function(){
    		var tmpInput = $("#tmpIntput").val();
    		$("#dl"+tmpInput).remove();
    		//获取翻译类型值
    		var orderTypeObj = document.getElementById("orderType");
    		var orderText = orderTypeObj.options[orderTypeObj.selectedIndex].innerHTML;
    		var orderValue = $("#orderType").val();
    		//获取语言对值
    		var languageObj = document.getElementById("languagePair");
    		var translatorText = languageObj.options[languageObj.selectedIndex].innerHTML;
    		var translatorValue = $("#languagePair").val();
    		//获取参考价格值
    		var referencePrice = $("#referencePrice").val();
    		if(referencePrice==null||referencePrice==""){
    			$("#referencePriceErrMsg").show();
    			$("#referencePriceText").text("请输入参考价格");
    			return;
    		}else{
    			$("#referencePriceErrMsg").hide();
    		}
    		var orderTypeSelectText = "";
    		var languageSelectText = "";
    		if(orderValue=="1"){
    			var dl = "<dl id=dtObj"+count+"><dt id=orderTypeObject"+count+">"+orderText+"</dt><dt id=translator"+count+">"+translatorText+"</dt><dt class='more' id=referencePrice"+count+">"+referencePrice+"元/千字（参考价）</dt><dt class='btn'><span><a href='javascript:void(0)' id='editText' onclick='editText("+count+","+translatorValue+")' class='green'>编辑</a></span>";
    			orderTypeSelectText = "<div id=hideTextDiv"+count+"><dt id=editOrderTypeObj"+count+"><select class='select select-in-small' id='orderType"+count+"'>"+
    							"<option selected='selected' value='1'>口译</option><option value='2'>笔译</option></select></dt>"
    		}else if(orderValue=="2"){
    			var dl = "<dl id=dtObj"+count+"><dt id=orderTypeObject"+count+">"+orderText+"</dt><dt id=translator"+count+">"+translatorText+"</dt><dt class='more' id=referencePrice"+count+">"+referencePrice+"元/千字（参考价）</dt><dt class='small'>未测试</dt><dt class='btn'><span><a href='#' class='blue'>测试</a></span><span><a href='javascript:void(0)' id='editText' onclick='editText("+count+")' class='green'>编辑</a></span>"
    			orderTypeSelectText = "<div id=hideTextDiv"+count+"><dt id=editOrderTypeObj"+count+"><select class='select select-in-small' id='orderType"+count+"'>"+
								      "<option value='1'>口译</option><option selected='selected'  value='2'>笔译</option></select></dt>"
    		}
    		languageSelectText = "<dt><select class='select select-in-small' id='languagePair"+count+"'>"+languageText+"</select></dt>"+
    							 "<dt class='more'><input type='text' class='int-text int-in radius' id='referencePrice"+count+"' value="+referencePrice+">元/千字（参考价）</dt><dt class='small'>未测试</dt>"+
    							 "<dt class='btn'><span class='i-green' id='updateOK' onclick='updateText("+count+")'><i class='icon iconfont'>&#xe651;</i></span><span class='i-red' id='deleteText' onclick=deleteUpdateText("+count+")><i class='icon iconfont'>&#xe652;</i></span></dt></dl>"
    		$("#languagesDiv").append(dl);
    		//加div的目的是在编辑的时候容易控制隐藏显示
    		$("#languagesDiv").append("<dl id=dl"+count+">"+orderTypeSelectText+languageSelectText+"</dl>");
    		$("#dl"+count).hide();
    		$("#createLanguage"+count).hide();
    		count = count+1;
    	},
    	_addLanguage:function(){
    		
    	  var orderTypeSelectText = "<dl id=createLanguage"+count+">"+
    								"<dt>"+
    								  "<select class='select select-in-small' id='orderType'>"+
    								  "<option selected='selected' value='1'>口译</option>"+
    								  "<option value='2'>笔译</option>"+
    								  "</select>"+
    								 "</dt>"
    			
    	 var languageSelectText = "<dt><select class='select select-in-small' id='languagePair'>"+languagePairText+"</select></dt>"+
    							 "<dt class='more'><input type='text' class='int-text int-in radius init-small' id='referencePrice'><span>元/千字<span></dt>"+
    							 "<dt class='small'>未测试</dt>"+
    							 "<dt class='btn'><span class='i-green' id='OK'><i class='icon iconfont'>&#xe651;</i></span><span class='i-red' id='deleteText' onclick=deleteText("+count+")><i class='icon iconfont'>&#xe652;</i></span></dt></dl>"
    		$("#languagesDiv").append(orderTypeSelectText+languageSelectText);
    	},
    	_loadGoodUse:function(){
    		ajaxController.ajax({
    			async:false,
				type:"post",
				url:_base+"/p/translator/getGoodUser",
				data:{
					language:currentLan,
				},
		        success: function(json) {
		        	 if(json.statusCode!='0'){
		        		var data = json.data;
		        		var goodUsers = JSON.parse(userList);
						if (data) {
							var html = [];
							for (var i = 0; i < data.length; i++) {
								var t = data[i];
								var _code = t.purposeId;
								var domainName = t.purposeCn;
								if ("zh_CN" != currentLan) {
									domainName = t.purposeEn;
								}
								var flag = false;
								for(var j=0;j<goodUsers.length;j++){
									var domonId = goodUsers[j];
									if(_code==domonId.extendKey){
										flag = true;
									}
								}
								if(flag){
									html.push("<p><span><input type='checkbox' class='radio' checked name=goodUsers value="+_code+"></input></span><span>"+domainName+"</span></p>");
								}else{
									html.push("<p><span><input type='checkbox' class='radio' name=goodUsers value="+_code+"></input></span><span>" + domainName + '</span></p>');
								}
								
							}
							$("#goodUser").append(html.join(""));
						}
		        	 }
		          }
				});
    	},
    	_loadField:function(){
    		ajaxController.ajax({
    			async:false,
				type:"post",
				url:_base+"/p/translator/getField",
				data:{
					language:currentLan,
				},
		        success: function(json) {
		        	 if(json.statusCode!='0'){
		        		var data = json.data;
		        		var goodFields = JSON.parse(fieldList);
						if (data) {
							var html = [];
							for (var i = 0; i < data.length; i++) {
								var t = data[i];
								var _code = t.domainId;
								var domainName = t.domainCn;
								if ("zh_CN" != currentLan) {
									domainName = t.domainEn;
								}
								var flag = false;
								for(var j=0;j<goodFields.length;j++){
									var domonId = goodFields[j];
									if(_code==domonId.extendKey){
										flag = true;
									}
								}
								if(flag){
									html.push("<p><span><input type='checkbox' class='radio' name='goodFields' checked value="+_code+"></input></span><span>"+domainName+"</span></p>");
								}else{
									html.push("<p><span><input type='checkbox' class='radio' name='goodFields' value="+_code+"></input></span><span>" + domainName + '</span></p>');
								}
								
							}
							$("#goodField").append(html.join(""));
						}
		        	 }
		          }
				});
    	},
    	
    })
    module.exports = TranslatorInfoPager
});
function editText(number,text){
	$("#tmpIntput").val(number);
	//选中语言对的值
	$("#languagePair"+number).val(text); 
	$("#dl"+number).show();
	$("#hideTextDiv"+number).show();
	$("#dtObj"+number).remove();
}
function updateText(number){
	var languageSelectText = "";
	//获取翻译类型值
	var orderTypeObj = document.getElementById("orderType"+number);
	var orderText = orderTypeObj.options[orderTypeObj.selectedIndex].innerHTML;
	var orderValue = $("#orderType"+number).val();
	//获取语言对值
	var languageObj = document.getElementById("languagePair"+number);
	var translatorText = languageObj.options[languageObj.selectedIndex].innerHTML;
	var translatorValue = $("#languagePair"+number).val();
	//获取参考价格值
	var referencePrice = $("#referencePrice"+number).val();
	if(referencePrice==null||referencePrice==""){
		$("#referencePriceErrMsg").show();
		$("#referencePriceText").text("请输入参考价格");
		return;
	}else{
		$("#referencePriceErrMsg").hide();
	}
	if(orderValue=="1"){
		var dl = "<dl id=dtObj"+number+"><dt id=orderTypeObject"+number+">"+orderText+"</dt>"+
				 "<dt id=translator"+number+">"+translatorText+"</dt>"+
				 "<dt class='more' id=referencePrice"+number+">"+referencePrice+"元/千字（参考价）</dt>"+
				 "<dt class='btn'><span><a href='javascript:void(0)' id='editText' onclick='editText("+number+","+translatorValue+")' class='green'>编辑</a></span>";
		orderTypeSelectText = "<dt id=editOrderTypeObj"+number+">"+
								 "<select class='select select-in-small' id='orderType"+number+"'>"+
						          "<option selected='selected' value='1'>口译</option>"+
						          "<option value='2'>笔译</option>"+
						         "</select>"+
						         "</dt>"
	}else if(orderValue=="2"){
		var dl = "<dl id=dtObj"+number+"><dt id=orderTypeObject"+number+">"+orderText+"</dt>"+
				 "<dt id=translator"+number+">"+translatorText+"</dt>"+
				 "<dt class='more' id=referencePrice"+number+">"+referencePrice+"元/千字（参考价）</dt>"+
				 "<dt class='small'>未测试</dt><dt class='btn'><span><a href='#' class='blue'>测试</a></span><span><a href='javascript:void(0)' id='editText' onclick='editText("+number+")' class='green'>编辑</a></span>"
		orderTypeSelectText = "<dt id=editOrderTypeObj"+number+">"+
									"<select class='select select-in-small' id='orderType"+number+"'>"+
									"<option value='1'>口译</option>"+
									"<option selected='selected'  value='2'>笔译</option>"+
									"</select>"+
								"</dt>"
	}
	
	languageSelectText = "<dt>"+
							"<select class='select select-in-small' id='languagePair"+number+"'>"+languagePairText+"</select>"+
						 "</dt>"+
	 					 "<dt class='more'>"+
	 					 	"<input type='text' class='int-text int-in radius' id='referencePrice"+number+"' value="+referencePrice+">元/千字（参考价）</dt><dt class='small'>未测试"+
	 					 "</dt>"+
	 					 "<dt class='btn'>"+
	 					   "<span class='i-green' id='updateOK' onclick='updateText("+number+")'><i class='icon iconfont'>&#xe651;</i></span><span class='i-red' id='deleteText' onclick=deleteUpdateText("+number+")><i class='icon iconfont'>&#xe652;</i></span>"+
	 					 "</dt>"
	$("#dl"+number).append(dl);
	$("#hideTextDiv"+number).remove();
	$("#dl"+number).append("<div id=hideTextDiv"+number+">"+orderTypeSelectText+languageSelectText+"</div>")
	$("#hideTextDiv"+number).hide();
	$("#createLanguage").hide();
}
function deleteText(number){
	$("#createLanguage"+number).remove();
}
function deleteUpdateText(number){
	$("#dl"+number).remove();
}
function uploadPortraitImg(uploadImgFile){
	
	var image = $("#uploadImg").val();
	if(!/\.(gif|jpg|png|jpeg|bmp|GIF|JPG|PNG|JPEG|BMP)$/.test(image)){
		$("#uploadImgErrMsg").show();
		$("#uploadImgText").show();
		$("#uploadImgText").text(translatorInfoMsg.uplaodImageMsg);
		$("#uploadImgFlag").val("0");
		return false;
	}else if(document.getElementById("uploadImg").files[0].size>5*1024*1024){
		$("#uploadImgErrMsg").show();
		$("#uploadImgText").show();
		$("#uploadImgText").text(translatorInfoMsg.uplaodImageMsg);
		$("#uploadImgFlag").val("0");
		return false;
	}else{
		$("#uploadImgErrMsg").hide();
		$("#uploadImgText").hide();
		$("#uploadImgText").text('');
		$("#uploadImgFlag").val("1");
	}
	
	 $.ajaxFileUpload({  
         url:_base+"/p/translator/uploadImage",  
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

