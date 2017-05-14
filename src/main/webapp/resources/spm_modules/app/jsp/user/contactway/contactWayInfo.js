define('app/jsp/user/contactway/contactWayInfo', function (require, exports, module) {
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
			okValue:contactInfoMsg.showOK,
			title: "提示",
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
    loadCountry("","country-add");
    //定义页面组件类
    var ContactWayInfoPager = Widget.extend({
    	//属性，使用时由类的构造函数传入
    	attrs: {
    	},
    	Statics: {
    		DEFAULT_PAGE_SIZE: 10
    	},
    	//事件代理
    	events: {
    		"click [id='saveButton']":"_saveContactInfo",
        },
        //重写父类
    	setup: function () {
    		ContactWayInfoPager.superclass.setup.call(this);
    	},
    	_saveContactInfo:function (){
    		var checkphoneflag = checkphone('telephoneAdd','telephoneAddErrMsg','telephoneAddErrorText','country-add');
    		var checkemailflag = checkUserEmail('emailAdd','emailAddErrMsg','emailAddErrorText');
    		var checkusernameflag = checkUserName('userNameAdd','userNameAddErrMsg','userNameAddErrorText');
    		if(checkphoneflag&&checkemailflag&&checkusernameflag){
    			$.ajax({
    				type : "post",
    				processing : false,
    				message : "保存",
    				url : _base + "/p/contactway/saveContactInfo",
    				data : {
    					'gnCountryId':$("#country-add").val(),
    					'userName':$("#userNameAdd").val(),
    					'email':$("#emailAdd").val(),
    					'mobilePhone':$("#telephoneAdd").val(),
    				},
    				success : function(json) {
    					if (json.statusCode=="000000") {
    						window.location.href = _base+"/p/contactway/contactwayPager?source=user"
    					}else if(json.statusCode=="400001"){
    						showMsg(json.statusInfo)
    					}else{
    						showMsg(contactInfoMsg.saveDataFail)
    					}
    				}
    			})
    		}
    	}

    });
    	module.exports = ContactWayInfoPager
    });
var contactId="0";
function checkUserName(inputId,labelId,spanId){
	var userName  = $("#"+inputId).val();
	var flag = true;
	if(userName==null||userName==""){
		$("#"+labelId).show();
		$("#"+spanId).text(contactInfoMsg.userNameEmptyError);
		flag = false; 
	}else{
		$.ajax({
			type : "post",
			processing : false,
			message : "sss",
			url : _base + "/p/contactway/checkUserName",
			data : {
				'userName' : userName,
				'contactId':contactId
			},
			success : function(json) {
				if (json.statusCode!="000000") {
					$("#"+labelId).show();
					$("#"+spanId).text(contactInfoMsg.userNameExistError);
					flag = false; 
				}else{
					$("#"+labelId).hide();
					flag = true;
				}
			}
		})
	}
	return flag;
}

function checkUserEmail(inputId,labelId,spanId){
	var email  = $("#"+inputId).val();
	var flag = true;
	if(email==null||email==""){
		$("#"+labelId).show();
		$("#"+spanId).text(contactInfoMsg.emailEmptyError);
		flag = false; 
	}else{
		if (!/^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/
				.test(email)) {
			$("#"+labelId).show();
			$("#"+spanId).text(contactInfoMsg.emailOKError);
			flag = false; 
		}else{
			$.ajax({
				type : "post",
				processing : false,
				message : "sss",
				url : _base + "/p/contactway/checkUserEmail",
				data : {
					'userEmail' : email,
					'contactId':contactId
				},
				success : function(json) {
					if (json.statusCode!="000000") {
						$("#"+labelId).show();
						$("#"+spanId).text(contactInfoMsg.phoneExistError);
						flag = false; 
					}else{
						$("#"+labelId).hide();
						flag = true;
					}
				}
			})
		}
	}
	return flag;
}
function checkphone(inputId,labelId,spanId,countryId){
	var telephone  = $("#"+inputId).val();
	var flag = true;
	if($.trim(telephone)==null||$.trim(telephone)==""){
		$("#"+labelId).show();
		$("#"+spanId).text(contactInfoMsg.phoneEmptyError);
		flag = false; 
	}else{
		var country = $("#"+countryId).find("option:selected");
		var reg = country.attr("reg");
		var countryCode = country.val();
		reg = eval('/' + reg + '/');
		phoneVal =countryCode+telephone;
		if (!reg.test(phoneVal)) {
			$("#"+labelId).show();
			$("#"+spanId).text(contactInfoMsg.phoneOKError);
			flag = false;
		}else{
			$.ajax({
				type : "post",
				processing : false,
				async:false,
				url : _base + "/p/contactway/checkUserPhone",
				data : {
					"telephone" :telephone,
					'contactId':contactId
				},
				success : function(json) {
					if (json.statusCode!="000000") {
						$("#"+labelId).show();
						$("#"+spanId).text(contactInfoMsg.phoneExistError);
					}else{
						$("#"+labelId).hide();
					}
				}
			});
		}
	}
	return flag;
}
function loadCountry(countryCode,countryId){
		$.ajax({
			type : "post",
			processing : false,
			message : "ssss",
			url : _base + "/userCommon/loadCountry",
			data : {},
			success : function(json) {
				var data = json.data;
				if (json.statusCode == "1" && data) {
					var html = [];
					for (var i = 0; i < data.length; i++) {
						var t = data[i];
						var _code = t.countryCode;
						var name = t.countryNameCn;
						if ("zh_CN" != currentLan) {
							name = t.countryNameEn;
						}
						if(_code==countryCode){
							html.push('<option  selected = "selected"  country_value="'+t.countryValue+'" reg="'
									+ t.regularExpression
									+ '" value="' + _code
									+ '" >' +name + '+'
									+  _code + '</option>');
						}else{
							html.push('<option country_value="'+t.countryValue+'" reg="'
									+ t.regularExpression
									+ '" value="' + _code
									+ '" >' +name + '+'
									+  _code + '</option>');
						}
					}
					$("#"+countryId).html(html.join(""));
				}
			}
		});
}

function editContact(id){
	contactId = id;
	$.ajax({
		type : "post",
		processing : false,
		message : "sss",
		url : _base + "/p/contactway/editContactway",
		data : {
			'contactId' : contactId
		},
		success : function(json) {
			if (json.statusCode) {
				loadCountry(json.data.gnCountryId,"country-edit");
				$("#contactUserName").val(json.data.userName);
				$("#email").val(json.data.email);
				$("#telephone").val(json.data.mobilePhone);
			}else{
				alert("失败")
			}
		}
	})
}
function delContact(id){
	contactId = id;
	
}
function confirmEdit(){
	var checkphoneflag = checkphone('telephone','telephoneErrMsg','telephoneErrorText','country-edit');
	var checkemailflag = checkUserEmail('email','emailErrMsg','emailErrorText');
	var checkusernameflag = checkUserName('contactUserName','userNameErrMsg','userNameErrorText');
	if(checkphoneflag&&checkemailflag&&checkusernameflag){
		$.ajax({
			type : "post",
			processing : false,
			message : "",
			url : _base + "/p/contactway/updatecontactway",
			data : {
				'contactId' : contactId,
				'gnCountryId':$("#country-edit").val(),
				'userName':$("#userName").val(),
				'email':$("email").val(),
				'mobilePhone':$("#telephone").val(),
			},
			success : function(json) {
				if (json.statusCode) {
					window.location.href = _base+"/p/contactway/contactwayPager?source=user"
				}else{
					alert("失败")
				}
			}
		})
	}
	
}
function setDefaultValue(id){
	var isdefault = 0;
	if($('#isdefaultValue').is(':checked')){
		isdefault = 1;
	}
	$.ajax({
		type : "post",
		processing : false,
		message : "删除",
		url : _base + "/p/contactway/setDefault",
		data : {
			'contactId' : id,
			'isDefault':isdefault
		},
		success : function(json) {
			if (json.statusCode=="000000") {
				window.location.href = _base+"/p/contactway/contactwayPager?source=user"
			}else{
				alert("失败")
			}
		}
	})
}
function confirmDel(){
	$.ajax({
		type : "post",
		processing : false,
		message : "删除",
		url : _base + "/p/contactway/delcontactway",
		data : {
			'contactId' : contactId
		},
		success : function(json) {
			if (json.statusCode=="000000") {
				window.location.href = _base+"/p/contactway/contactwayPager?source=user"
			}else{
				alert("失败")
			}
		}
	})
}

