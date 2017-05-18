define('app/jsp/order/orderContact', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
    Widget = require('arale-widget/1.2.0/widget'),
    Dialog = require("optDialog/src/dialog"),
    AjaxController = require('opt-ajax/1.0.0/index');
    require("jsviews/jsrender.min");
   
    require("jquery-validation/1.15.1/jquery.validate");
    require("app/util/aiopt-validate-ext");
   
    var CountWordsUtil = require("app/util/countWords");
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
    var orderContactPager = Widget.extend({
        //属性，使用时由类的构造函数传入
        attrs: {
            clickId:""
        },


        //事件代理
        events: {
            "click #submitOrder":"_addTextOrder",
            "click #toCreateOrder": "_toCreateOrder",
            "click #deleteId": "_deleteClss",
            "click [id='saveButton']":"_saveContactInfo"
        },


        //重写父类
        setup: function () {
            orderContactPager.superclass.setup.call(this);
        },
        
        _deleteClss:function(){
        	$("#deleteeject-mask").show();
        },
        //保存联系人
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
    						window.location.reload();
    					}else if(json.statusCode=="400001"){
    						showMsg(json.statusInfo);
    					}else{
    						showMsg(contactInfoMsg.saveDataFail);
    					}
    				}
    			})
    		}
    	},
        
        //提交订单
        _addTextOrder:function(){
            var _this= this;
            var translateType = $("#transType").val();
            var contactInfo = {};
            $("#saveContactDiv").hide();
            //获取联系方式信息
           var info =  $('input[name=checkContect]:checked').val(); 
           var contactList = info.split(",");
            contactInfo.contactName=contactList[0];
            contactInfo.contactTel="+"+contactList[1]+" "+contactList[2];
            contactInfo.contactEmail=contactList[3];
            ajaxController.ajax({
                type: "post",
                processing: true,
                url: _base + "/p/order/save",
                data: {
                    contactInfo:JSON.stringify(contactInfo),
                    remark: $("#remark").val(),
                    transType: $("#transType").val()
                },
                success: function (data) {
                    if ("1" === data.statusCode) {
                        if(translateType == 0) { //文字翻译
                            window.location.href =  _base + "/p/customer/order/payOrder/"+data.data;
                        } else {
                            //口译、文档翻译，跳到待报价页面
                            window.location.href =  _base + "/p/customer/order/orderOffer";
                        }
                    }
                }
            });
        },

        //返回上一页
        _toCreateOrder:function () {
            // if ($("#saveContactDiv").css("display") != 'none') {
            //     if (this._saveContact() == false)
            //         return
            // }

            var translateType = $("#transType").val();

            if(translateType == 2) { //口译
                // window.history.go($("#toCreateOrder").attr("skip"));
                window.location.href= _base + "/oral?flag=return";
            } else {
                var remark = $.trim($("#remark").val());
                if (remark != '')
                    window.location.href= _base + "/order/create/text?flag=return&remark="+window.encodeURI(remark);
                else
                    window.location.href= _base + "/order/create/text?flag=return";
            }

        }

    });

    module.exports = orderContactPager;
});
var contactId="0";
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
function delContact(id){
	contactId = id;	
}

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
//编辑联系人
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
				$("#isDefaultEdit").val(json.data.isDefault);
			}else{
				alert("失败")
			}
		}
	})
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
				'userName':$("#contactUserName").val(),
				'email':$("#email").val(),
				'mobilePhone':$("#telephone").val(),
				'isDefault':$("#isDefaultEdit").val()
			},
			success : function(json) {
				if (json.statusCode) {
					 window.location.reload();
				}else{
					alert("失败")
				}
			}
		})
	}
	
}
function setDefaultValue(id){
	var isdefault = 1;
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
				 window.location.reload();
			}else{
				alert("失败")
			}
		}
	})
}
function moreConcats(){
	$('div[name=moreConcats]').each(function(){
		$(this).show();
	});
	//将收起按钮展示，更多按钮隐藏
	$("#moreButId").hide();
	$("#upContect").show();
}
function upConcats(){
	$('div[name=moreConcats]').each(function(){
		$(this).hide();
	});
	//将收起按钮展示，更多按钮隐藏
	$("#moreButId").show();
	$("#upContect").hide();
}