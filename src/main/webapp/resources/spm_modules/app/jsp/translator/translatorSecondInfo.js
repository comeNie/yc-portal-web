define('app/jsp/translator/translatorSecondInfo', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
    Widget = require('arale-widget/1.2.0/widget'),
    Dialog = require("optDialog/src/dialog"),
    AjaxController = require('opt-ajax/1.0.0/index'),
    Calendar = require('arale-calendar/1.1.2/index');
    
    require("jsviews/jsrender.min");
    require("jsviews/jsviews.min");
    
    require("jquery-validation/1.15.1/jquery.validate");
    require("app/jsp/translator/confirm-step2");
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
    		"blur [id='introduction']":"_checkIntroduction",
    		"click [id='ddd']":"_saveTranslatorSecondInfo",
    		
        },
        //重写父类
    	setup: function () {
    		TranslatorInfoPager.superclass.setup.call(this);
    		curLanguage = currentLan;
    	},
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
    	_checkIntroduction:function(){
    		var introductionValue = $("#introduction").html();
    		var flag = true;
    		if(introductionValue==""||introductionValue==null){
    			$("#introductionTip").show().html("个人简介不能为空");
    			flag = false;
    		}else{
    			if(introductionValue.length>500){
    				$("#introductionTip").show().html("个人简介不能超过500个字符");
        			flag = false;
    			}else{
    				$("#introductionTip").hide().html("");
    			}
    		}
    		return flag;
    	},

    	_saveTranslatorSecondInfo:function(){
    		/**
    		 * 校验个人简介
    		 */
    		var introductionValue = $("#introduction").val();
    		var flag = true;
    		if(introductionValue==""||introductionValue==null){
    			$("#introductionErrMsg").show();
    			$("#introductionText").text("个人简介不能为空");
    			flag = false;
    		}else{
    			if(introductionValue.length>500){
    				$("#introductionErrMsg").show();
        			$("#introductionText").text("个人简介不能为空");
        			flag = false;
    			}
    		}
    		var language = JSON.stringify(addLanguage);
    		var education = JSON.stringify(addEducation);
    		var workvalue = JSON.stringify(addwork);
    		var cardvalue = JSON.stringify(addcard);
    		var introduction = $("#introduction").val();
    		if(true){
    			ajaxController.ajax({
        			async:false,
    				type:"post",
    				url:_base+"/p/translator/saveSecondStepPager",
    				data:{
    					"languages":language,
    					"education":education,
    					"addwork":workvalue,
    					"addcard":cardvalue,
    					"introduction":introduction,
    					'eduList': eduList,
    					'workList':workList,
    					'cerList':cerList,
    					'languageList':languageList
    				},
    		        success: function(json) {
    		        	if(json.data){
    		        		showMsg(json.statusInfo);
    		        	}else{
    		        		showMsg(json.statusInfo);
    		        	}
    		        }
        		})
    		}
    		
    	}  
    })
    module.exports = TranslatorInfoPager
});

function loadLanguage(translatoryTypeValue){
	$.ajax({
		async:false,
		type:"post",
		url:_base+"/p/translator/getLanguages",
		data:{
			'language':currentLan,
			'translatorType':translatoryTypeValue,
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
							html.push('<option selected="selected" value=' + _code+ ' >' +sourceName+"->"+targetName + '</option>');
						}else{
							html.push('<option value=' + _code+ ' >' + sourceName+"->"+targetName + '</option>');
						}
						
					}
					languages = html.join("");
					$('.addLanguage').find(".LanguageType").html(languages);
				}
        	 }
          }
		});
}
function loadAllCountry(){
	$.ajax({
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
					country = html.join("");
					$("#countryInfo").html(html.join(""));
				}
        	 }
          }
		});
}
function getProviceValue(countryCode){
	$.ajax({
		async:false,
		type:"post",
		url:_base+"/p/interpreter/getProvice",
		data:{
			'regionCode':countryCode,
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
						provinceCode = _code;
					}
					province = html.join("");
					$("#provinceInfo").html(html.join(""));
				}
        	 }
          }
		});
}
function getCnCityValue(provinceCode){
	$.ajax({
		async:false,
		type:"post",
		url:_base+"/p/interpreter/getCnCityInfo",
		data:{
			'Code':provinceCode,
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
						cityCode = _code;
					}
					cnCity = html.join("");
					$("#cnCityInfo").html(html.join(""));
				}
        	 }
          }
		});
}
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

