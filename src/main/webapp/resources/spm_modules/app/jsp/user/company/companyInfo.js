define('app/jsp/user/company/companyInfo', function (require, exports, module) {
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
    $(".portrait-file").addClass("webuploader-element-invisible");
    var showMsg = function(msg){
    	var d = Dialog({
			content:msg,
			icon:'fail',
			okValue: companyInfoMsg.showOkValueMsg,
			title: companyInfoMsg.showTitleMsg,
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
			okValue: companyInfoMsg.showOkValueMsg,
			title: companyInfoMsg.showTitleMsg,
			ok:function(){
				d.close();
			}
		});
		d.showModal();
    };
    //定义页面组件类
    var CompanyInfoPager = Widget.extend({
    	//属性，使用时由类的构造函数传入
    	attrs: {
    	},
    	Statics: {
    		DEFAULT_PAGE_SIZE: 10
    	},
    	//事件代理
    	events: {
			//保存数据
    		"blur [id='companyName']":"_checkCompanyNameValue",
    		"change [id='countryInfo']":"_getProviceValue",
    		"change [id='provinceInfo']":"_getCnCityValue",
			//"blur [id='countryInfo']":"_checkCountryValue",
			"blur [id='provinceInfo']":"_checkProvinceValue",
			"blur [id='cnCityInfo']":"_checkCnCityValue",
			"blur [id='address']":"_checkAddressValue",
			"change [id='uploadImg']":"_uploadFile",
			"blur [id='linkman']":"_checkLinkMan",
			"blur [id='content']":"_checkContent",
			"click [id='recharge-popo']":"_saveCompanyInfo"
        },
        //重写父类
    	setup: function () {
    		CompanyInfoPager.superclass.setup.call(this);
    		//var formValidator=this._initValidate();
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
    		/*$(":input").bind("focusout",function(){
				formValidator.element(this);
			});*/
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
					$("#area-error").show().html(companyInfoMsg.provinceErrorMsg);
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
					$("#area-error").show().html(companyInfoMsg.cityErrorMsg);
				}
			}
		},
		_checkAddressValue:function () {
			var address = $("#address").val();
			if(address!=""||address==null){
				$("#detail-address").hide().html("");
			}else {
				$("#detail-address").show().html(companyInfoMsg.detailAddressErrorMsg);
			}
		},
		_checkLinkMan:function(){
			var flag = true;
			var linkman = $("#linkman").val();
			if(linkman==null||linkman==""){
				$("#linkManErrMsg").show();
				$("#linkManText").text(companyInfoMsg.linkmanempty);
				flag = false;
			}
			if(linkman.length>50){
				$("#linkManErrMsg").show();
				$("#linkManText").text(companyInfoMsg.linkmanlength);
				flag = false;
			}
			if(flag){
				$("#linkManErrMsg").hide();
			}
			return flag;
		},
		_checkContent:function(){
			var content = $("#content").val();
		},
		_checkCompanyNameValue:function(){
			var companyName =  $("#companyName").val();
			var flag = true;
			if(companyName==null||companyName==""){
				$("#companyNameErrMsg").show();
				$("#companyNameErrText").text(companyInfoMsg.companynameempty);
				flag = false;
			}
			if(companyName.length>50){
				$("#companyNameErrMsg").show();
				$("#companyNameErrText").text(companyInfoMsg.companynamelength);
				flag = false;
				
			}
			if(flag){
				ajaxController.ajax({
					type:"post",
					async:false,
					url:_base+"/p/company/checkCompanyName",
					data:{
						'companyName':companyName
					},
			        success: function(json) {
			        	 if(!json.data){
			        		 $("#companyNameErrMsg").show();
			        		 $("#companyNameErrText").text(json.statusInfo);
			        		 flag = false;
			        	 }else{
			        		 $("#companyNameErrMsg").hide();
			        		 $("#companyNameErrText").text(""); 
			        		 flag = true;
			        	 }
			          }
					});
			}
			if(flag){
				$("#companyNameErrMsg").hide();
			}
			return flag;
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
							html.push('<option value=0>' + companyInfoMsg.areaTitle + '</option>');
							for (var i = 0; i < data.length; i++) {
								var t = data[i];
								var _code = t.regionCode;
								var name = t.regionNameCn;
								if ("zh_CN" != currentLan) {
									name = t.regionNameEn;
								}
								if(countryCode ==_code){
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
		        		html.push('<option value=0 selected="selected">' + companyInfoMsg.areaTitle + '</option>');
		        		$("#provinceInfo").html(html.join(""));
		        		html2.push('<option value=0>' + companyInfoMsg.areaTitle + '</option>');
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
						html.push('<option value=0>' + companyInfoMsg.areaTitle + '</option>');
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
    	_checkImageValue:function(){
    		
    	},
    	_saveCompanyInfo:function(){
    		var flag = true;
    		var companyNameFlag = this._checkCompanyNameValue();
    		if(!companyNameFlag){
    			flag = false;
    		}
    		var linkManFlag = this._checkLinkMan();
    		if(!linkManFlag){
    			flag = false;
    		}
    		var countryinfo = $("#countryInfo").val();
    		if($("#provinceInfo").is(":disabled")){
				 $("#provinceInfo").val("");
			 }else {
				 var province = $("#provinceInfo").val();
				 if(province=="0"||province==""||province==null){
					 $("#area-error").show().html(companyInfoMsg.provinceErrorMsg);
					 flag = false;
				 }
			 }
			 if($("#cnCityInfo").is(":disabled")){
				 $("#cnCityInfo").val("");
			 }else {
				 var city = $("#cnCityInfo").val();
				 if(city=="0"||city==""||city==null){
					$("#area-error").show().html(companyInfoMsg.cityErrorMsg);
					flag = false;
				 }
			 }
			var address = $("#address").val();
			if(countryinfo!="0"&&(address==""||address==null)){
				$("#detail-address").show().html(companyInfoMsg.detailAddressErrorMsg);
				flag = false;
			}
			var attacid = $("#attacid").val();
			var attacidText = $("#uploadImgText").html();
			var uploadEntpIdText=$("#uploadEntpIdText").html();
			if(attacid==null||attacid==""){
				$("#uploadImgErrMsg").show();
				$("#uploadImgText").text(companyInfoMsg.licenseempty);
				flag = false;
			}else if(attacidText!=null&&attacidText!=""||uploadEntpIdText!=null&&uploadEntpIdText!=""){
				flag = false;
			}
			if(flag){
				$("#companyInfo").submit();
			}
    	}
    })
    module.exports = CompanyInfoPager
});

function uploadImg(imageId,imgMsg,imgText){
	
	var image = $("#"+imageId).val();
	if(!/\.(gif|jpg|png|jpeg|bmp|GIF|JPG|PNG|JPEG|BMP)$/.test(image)){
		$("#"+imgMsg).show();
		$("#"+imgText).show();
		$("#"+imgText).text(companyInfoMsg.uplaodImageMsg);
		return false;
	}else if(document.getElementById(imageId).files[0].size>2*1024*1024){
		$("#"+imgMsg).show();
		$("#"+imgText).show();
		$("#"+imgText).text(companyInfoMsg.uplaodImageMsg);
		return false;
	}else{
		$("#"+imgMsg).hide();
		$("#"+imgText).hide();
		$("#"+imgText).text('');
	}
}

