define('app/jsp/order/createTextOrder', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
	    Widget = require('arale-widget/1.2.0/widget'),
		Dialog = require("optDialog/src/dialog"),
	    AjaxController = require('opt-ajax/1.0.0/index');
    require("jsviews/jsrender.min");

    require("jquery-validation/1.15.1/jquery.validate");
	require("app/util/aiopt-validate-ext");
	require('jquery-i18n/1.2.2/jquery.i18n.properties.min');
	require('webuploader/webuploader');
    var CountWordsUtil = require("app/util/countWords");
    
    //实例化AJAX控制处理对象
    var ajaxController = new AjaxController();
    var uploader = null;
    //是否支持Placeholder属性
    var supportPlaceholder = true;
    var textOrderAddPager = Widget.extend({
    	//属性，使用时由类的构造函数传入
    	attrs: {
    		clickId:""
    	},
    	
    	//事件代理
    	events: {
			"click #recharge-popo":"_addTextOrderTemp",
			"click #urgentOrder":"_transPrice",
            "click #_getSpeed": "_getSpeed",
			"click .dropdown":"_chDuad",
			"click #saveContact":"_saveContact",
			"click #editContact":"_editContactDiv",
			// "click #fy-btn": "_uploadFile",
			"click #fy-btn1": "_inputText",
			"click #clear-btn": "_clearText",
			"keyup #translateContent": "_clearControl",
			"change #selectFormatConv": "_formatControl"
           	},
            
    	//重写父类
    	setup: function () {
    		textOrderAddPager.superclass.setup.call(this);
			//初始化国际化
			$.i18n.properties({//加载资浏览器语言对应的资源文件
				name: ["orderInfo"], //资源文件名称，可以是数组
				path: _i18n_res, //资源文件路径
				mode: 'both',
                cache: true,
                checkAvailableLanguages: true,
				language: currentLan
			});
			supportPlaceholder='placeholder'in document.createElement('input');
			if(!supportPlaceholder){
                this._ie8palceholder();
			}
			var formValidator=this._initValidate();
			$(":input").bind("focusout",function(){
				formValidator.element(this);
			});
            this._initUpdate();
			this._transGrade();
			this._transPrice();
			this._initPage();

    	},

        textCounter:function($this,desc,maxlimit) {
            var placeholderStr = $($this).attr("placeholder");
            //若不支持属性，且当前内容等于提示信息，则不处理
            if(!supportPlaceholder && $($this).val() === placeholderStr){
				return;
            }

            var totalWords =  CountWordsUtil.count( $($this).val());
            // if (totalWords > maxlimit){
            //     //如果元素区字符数大于最大字符数，按照最大字符数截断；
            //     $($this).val($($this).val().substring(0, maxlimit));
            // }
            //在记数区文本框内显示剩余的字符数；
            $("#"+desc).html(totalWords);
        },

        _initValidate: function () {
            var _this = this;
            var formValidator = $("#textOrderForm").validate({
                onkeyup: false,
                focusInvalid: true,
                rules: {
                    translateContent: {
                        required: true,
						notNull: true,
                        wordsMax: 2000,
                        remote: {                                          //验证检查语言
                            type: "POST",
                            url: _base + "/translateLan",
                            data: {
                                text: function () {
                                    return $("#translateContent").val();
                                }
                            },
                            dataType: 'json',
                            dataFilter: function (data) {//判断控制器返回的内容
                                data = jQuery.parseJSON(data);

                                var sourlan = 'en';
                                $("#selectDuad").find('option').each(function () {
                                    var val = $(this).val();
                                    if (val == $(".dropdown .selected").attr('value')) {
                                        var selected = $(this);
                                        sourlan = selected.attr("sourceCode");
                                        return false;
                                    }
                                });

                                if (sourlan == data.data) {
                                    return true;
                                } else {
                                    return false;
                                }
                            }
                        }
                    },
					inputFormatConv: {required: true,notNull: true,}
                    // isAgree: {
                    //     required: true
                    // }
                },
                messages: {
                    translateContent: {
                        required: $.i18n.prop('order.place.error.translation'), //"请输入翻译内容",
						notNull: $.i18n.prop('order.place.error.translation'),
                        wordsMax: $.i18n.prop('order.place.error.MaximumWords'),//"超出最大长度,
                        remote:  $.i18n.prop('order.place.error.contentConsis')//"您输入的内容和源语言不一致"
                    },
					inputFormatConv: {
						required: $.i18n.prop('order.place.error.format'), //请输入转换格式
						notNull: $.i18n.prop('order.place.error.format'),
                    }
                    // isAgree: {
                    //     required: $.i18n.prop('order.place.error.agree')//"请阅读并同意翻译协议",
                    // }
                }
            });

            return formValidator;
        },


    	//提交文本订单
		_addTextOrderTemp:function(){
			var _this= this;
        	var formValidator=_this._initValidate();
			formValidator.form();
			if(!$("#textOrderForm").valid()){
				//alert('验证不通过！！！！！');
				return formValidator.focusInvalid();
			}

			if(!$('#isAgree').is(':checked')) {
				_this._showWarn( $.i18n.prop('order.place.error.agree'));
				return;
			}
			//文档类型
			if(!_this._isTextTransType()) {
				var stats = uploader.getStats();
				//判断是否上传文件
				if ($("#fileList ul").length < 1) {
					_this._showWarn($.i18n.prop('order.upload.error.nofile'));
					return;
				} else if(stats.progressNum > 0) { //上传中
					_this._showWarn($.i18n.prop('order.upload.error.ing'));
					return;
				}
			}


			//计算字数
			var totalWords = CountWordsUtil.count($("#translateContent").val());

			var baseInfo = {};
			var productInfo = {};
			var orderSummary = {};
            orderSummary.duadId =  $.trim($(".dropdown .selected").attr('value'));
            orderSummary.duadName = $.trim($(".dropdown .selected").html());
			orderSummary.purposeName = $.trim($("#selectPurpose").find("option:selected").text());
			orderSummary.domainName = $.trim($("#selectDomain").find("option:selected").text());
			orderSummary.translevel = $.trim($("#transGrade ul.current").find("p").eq(0).html());
			//区分国内外订单
			if (currentLan.indexOf("zh") >= 0) {
				baseInfo.orderType = "0";
				baseInfo.flag = "0";
				baseInfo.chlId = "0";
			}else {
				baseInfo.orderType = "1";
				baseInfo.flag = "1";//业务标识 0:国内业务 1：国际业务 ??
				baseInfo.chlId = "1";
			}

			baseInfo.orderType = "1"; //??
			baseInfo.busiType = 1;
			if(!_this._isTextTransType()) { //文档类型
				baseInfo.translateType = "1"

				var fileInfoList = [];
				//判断是文档翻译
				$("li[fileid]").each(function(){
					var tempObj = {};
					tempObj.fileName = $(this).text();
					tempObj.fileSaveId = $(this).attr("fileid");
					tempObj.fileSie = $(this).attr("size");
					fileInfoList.push(tempObj);
				});
				productInfo.fileInfoList = fileInfoList;

				baseInfo.subFlag = "1";
				//productInfo.needTranslateInfo = JSON.stringify(fileInfoList);
				productInfo.translateInfo = "";
				var translateName = $.trim($("#fileList").find('li:first').text());
				if (translateName.length>15) {
					baseInfo.translateName = translateName.substring(0,15) + "......";
				} else {
					baseInfo.translateName = translateName;
				}
			} else {
				baseInfo.translateType = "0"; //0：快速翻译 1：文档翻译
				baseInfo.subFlag = "0"; // "0：系统自动报价 1：人工报价"

                var transContant = $("#translateContent").val();
                transContant=transContant.replace(/\n|\r\n/g,"<br>");
                productInfo.needTranslateInfo = transContant;
				productInfo.translateInfo = "";
				var translateName =  $.trim($("#translateContent").val());
				if (translateName.length>15) {
					baseInfo.translateName = translateName.substring(0,15) + "......";
				} else {
					baseInfo.translateName = translateName;
				}
			}
			baseInfo.orderLevel = "1";
			baseInfo.userType = "10"; //"10：个人 11：企业 12：代理人 "??
			productInfo.typeDesc=$.trim($("#inputFormatConv").val());//格式转换
			//baseInfo.corporaId
			//baseInfo.accountId

            var remark = this.getUrlParam("remark");
            if (remark != '' || remark != undefined) {
                baseInfo.remark = remark; //备注 给译员留言
            }


            var today = new Date();
			if(today.stdTimezoneOffset()/60 > 0)
				baseInfo.timeZone = 'GMT-'+Math.abs(today.stdTimezoneOffset()/60);
			else
				baseInfo.timeZone = 'GMT+'+Math.abs(today.stdTimezoneOffset()/60);

			productInfo.translateSum = totalWords;
			productInfo.useCode = $("#selectPurpose").val();  //用途
			productInfo.fieldCode = $("#selectDomain").val();  //领域

			if($("#selectAddedSer").val() == 1)
				productInfo.isSetType = "Y"; //是否排版
			else
				productInfo.isSetType = "N";

			if ( $("#urgentOrder").is(':checked') )
				productInfo.isUrgent = "Y";
			else
				productInfo.isUrgent = "N";

			var duadList =[];
			var tempLanPairObj = {};
			tempLanPairObj.languagePairId = $(".dropdown .selected").attr('value');
			$("#selectDuad").find('option').each(function() {
				var val = $(this).val();
				if (val ==  $(".dropdown .selected").attr('value')) {
					var selected = $(this);

					tempLanPairObj.languagePairName = selected.attr('sourceCn') + "→" + selected.attr('targertCn');
					tempLanPairObj.languageNameEn = selected.attr('sourceEn') + "→" + selected.attr('targertEn');
					return false;
				}
			});

			duadList.push(tempLanPairObj);
			productInfo.languagePairInfoList = duadList;

			var translateLevelInfoList=[];
			var tempTranlevObj={};
			tempTranlevObj.translateLevel = $("#transGrade ul.current").first().attr('name');
			translateLevelInfoList.push(tempTranlevObj);

			productInfo.translateLevelInfoList = translateLevelInfoList;

            //创建订单
			ajaxController.ajax({
				type: "post",
                processing: true,
				url: _base + "/order/add",
				data: {
					baseInfo: JSON.stringify(baseInfo),
					productInfo: JSON.stringify(productInfo),
					orderSummary: JSON.stringify(orderSummary),
					fileInfoList: JSON.stringify(fileInfoList)
				},
				success: function (data) {
                    if ("1" === data.statusCode) {
						window.location.href =  _base + "/p/order/contact?skip="+data.data;
					}
				}
			});
		},

		//判断是否是文档翻译类型
		_isTextTransType:function () {
			if ($("#fy2").css("display") == "none")
				return true
			else
				return false;
		},

		//翻译等级改变，翻译速度改变
		_transGrade:function() {
			var _this = this;
			$("#transGrade ul").each(function () {
				$(this).click(function () {
					
				
					$(this).children('label').remove();
					$(this).addClass("current");
					$(this).append('<label></label>');
					
					$($(this).siblings()).removeClass("current");
					$($(this).siblings()).children('label').remove();
					
					_this._getSpeed();
				});
			}) 
		},
		
		//初始化页面后做的操作
		_initPage:function() {
			//页面初始化，从session取订单信息
			//改变上传div高度
			// $("#selectFile").children("div:last").css("height", '70px');

			//根据翻译类型，显示不同
			if ($("#transType").val() == "1") {
				//文档
				$("#fy1").hide();
				$("#fy2").show();
				// $("#selectAddedSer").attr("disabled",false);
				// $("#selectFormatConv").attr("disabled",false);

				//格式转换
				if ($("#format").val() != '') {
					$("#selectFormatConv").val("1");
					$("#inputFormatConvP").show();
					$("#inputFormatConv").val($("#format").val());
				}
				this._uploadFile();
			} else {
				//文字
				$("#fy2").hide();
				if ($("#translateContent").val() !='') {
					$("#clear-btn").show();
				}
				$("#selectFormatConv").val("2");
				// $("#selectAddedSer").attr("disabled",true);
				// $("#selectFormatConv").attr("disabled",true);
				// $("#selectAddedSer option:first").hide();
				// $("#selectFormatConv option:first").hide();

                $("#inputsLen").html( CountWordsUtil.count( $("#translateContent").val() ) );

                this.toggleOptionShow($('#selectAddedSer'),'',[0]);
                this.toggleOptionShow($('#selectFormatConv'),'',[0]);
			}

            //session 语言对
            if ($("#duadName").val() != '') {
                $(".dropdown .selected").html($("#duadName").val());
                $(".dropdown .selected").attr("value", $("#duadId").val());
                this._transPrice();
            }

			//翻译级别
			if ($("#transLv").val() != '') {
				$("#transGrade ul").each(function () {
					if ($("#transLv").val() == $(this).attr("name")) {
						$(this).children('label').remove();
						$(this).addClass("current");
						$(this).append('<label></label>');

						$($(this).siblings()).removeClass("current");
						$($(this).siblings()).children('label').remove();
					}
				});

                //设置耗时
                if($("#isUrgent").val() == 'Y')
                    this._getSpeed($("#transLv").val(),true);
                else
                    this._getSpeed($("#transLv").val(),false);

			}

			//首页传过来的参数
			var selPurpose = this.getUrlParam("selPurpose");
			if (selPurpose != '' && selPurpose != undefined ) {
				$("#selectPurpose").val(selPurpose);
			}

			//用途
			if ($("#useCode").val() != '') {
				$("#selectPurpose").val($("#useCode").val());
			}

			//领域
			if ($("#fieldCode").val() != '') {
				$("#selectDomain").val($("#fieldCode").val());
			}

			//排版
			if ($("#isSetType").val() == 'Y') {
				$("#selectAddedSer").val("1");
			}

			//加急
			if ($("#isUrgent").val() == 'Y') {
				$("#urgentOrder").attr("checked", true);
				this._transPrice();
			}


		},

        //语言对改变触发
        _chDuad:function () {
			if ($.trim($("#translateContent").val()) != '' &&
				$("#translateContent").val() != $("#translateContent").attr('placeholder')) {
				//清除remote验证的缓存，重新验证
				$("#translateContent").removeData("previousValue");
				if ( $.trim($("#translateContent")!='' )) {
					var formValidator=this._initValidate();
					formValidator.form();
				}
			}

            this._transPrice();
        },
		
		//价格改变,翻译速度改变
		_transPrice:function() {
			// var _this = this;

        	$("#selectDuad").find('option').each(function() {
        		var val = $(this).val();
        		if (val ==  $(".dropdown .selected").attr('value')) {
        			var selected = $(this);

					var ordinary,ordinaryUrgent,professional,professionalUrgent,publish,publishUrgent;
					if (currentLan.indexOf("zh") >= 0) {
						ordinary = selected.attr("ordinary");
						ordinaryUrgent = selected.attr("ordinaryUrgent");
						professional = selected.attr("professional");
						professionalUrgent = selected.attr("professionalUrgent");
						publish = selected.attr("publish");
						publishUrgent = selected.attr("publishUrgent");
					} else {
						ordinary = selected.attr("ordinaryDollar");
						ordinaryUrgent = selected.attr("ourgentDollar");
						professional = selected.attr("professionalDollar");
						professionalUrgent = selected.attr("purgentDollar");
						publish = selected.attr("publishDollar");
						publishUrgent = selected.attr("puburgentDollar");
					}

        			
        			if ($("#urgentOrder").is(':checked') ) {
        				$("#stanPrice").html(ordinaryUrgent);
        				$("#proPrice").html(professionalUrgent);
        				$("#pubPrice").html(publishUrgent);
        			} else {
        				$("#stanPrice").html(ordinary);
        				$("#proPrice").html(professional);
        				$("#pubPrice").html(publish);
        			}
        			
        		}
            });
		
			this._getSpeed();
		},
		
		//获取翻译速度价格
		_getSpeed:function(lvId, isUrge) {
			var ordSpeed = 2;
			var ordSpeedUrgent = 1;
			var proSpeed = 3;
			var proSpeedUrgent = 2;
			var pubSpeed = 4;
			var pubSpeedUrgent = 3;

            if (lvId =='' || lvId == undefined)
                lvId = $(".current").attr('name');

            if (isUrge =='' || isUrge == undefined)
                isUrge = $("#urgentOrder").is(':checked')

			if (isUrge) {
				if(lvId == '100210') {
					$("#speedValue").html(ordSpeedUrgent);
				} else if(lvId == '100220') {
					$("#speedValue").html(proSpeedUrgent);
				} else {
					$("#speedValue").html(pubSpeedUrgent);
				}
			} else {
				if(lvId == '100210') {
					$("#speedValue").html(ordSpeed);
				} else if(lvId == '100220') {
					$("#speedValue").html(proSpeed);
				} else {
					$("#speedValue").html(pubSpeed);
				}
			}
		},

		//文字输入，js控制
		_inputText:function() {
			$("#selectAddedSer").val(2);
			$("#selectFormatConv").val(2);

			// $("#selectAddedSer").attr("disabled",true);
			// $("#selectFormatConv").attr("disabled",true);
			// $("#selectAddedSer option:first").hide();
			// $("#selectFormatConv option:first").hide();
            this.toggleOptionShow($('#selectAddedSer'),'',[0]);
            this.toggleOptionShow($('#selectFormatConv'),'',[0]);

			$("#inputFormatConvP").hide();
			$("#inputFormatConv").val("");
		},
	
		//上传文档，js控制
		_uploadFile:function() {
			// $("#selectAddedSer").attr("disabled",false);
			// $("#selectFormatConv").attr("disabled",false);
			// $("#selectAddedSer option:first").show();
			// $("#selectFormatConv option:first").show();
            this.toggleOptionShow($('#selectAddedSer'),[0,1],'');
            this.toggleOptionShow($('#selectFormatConv'),[0,1],'');

            if ( !WebUploader.Uploader.support() ) {
                alert( 'Web Uploader 不支持您的浏览器！如果你使用的是IE浏览器，请尝试升级 flash 播放器');
                throw new Error( 'WebUploader does not support the browser you are using.' );
            }else if(uploader==null){
                this._initUpdate();
            }
		},
		
		//清空输入文字
		_clearText:function() {
			$("#translateContent").val("");
            $("#inputsLen").html(0);
			$("#clear-btn").hide();
		},

		//清空 按钮出现控制
		_clearControl:function() {
			var variable = $("#translateContent").val();
			if (variable !== '')  {
				if(!supportPlaceholder && variable === $("#translateContent").attr("placeholder")){
					return;
				}
				$("#clear-btn").show();

                // var key_le = variable.length;
                // if(key_le > 2000){
                //     //如果元素区字符数大于最大字符数，按照最大字符数截断；
                //     variable = variable.substring(0, 2000);
                //     $("#int-before").val(variable);
                //     $("#inputsLen").html(2000);
                // }else{
                //     //在记数区文本框内显示剩余的字符数；
                //     $("#inputsLen").html(key_le);
                // }
			} else {
				$("#clear-btn").hide();
                $("#inputsLen").html(0);
			}
		},

		//input 格式转换控制
		_formatControl:function() {
			if (1 == $("#selectFormatConv").val()) {
				$("#inputFormatConvP").show();
			} else {
				$("#inputFormatConvP").hide();
				$("#inputFormatConv").val("");
			}
				
			
		},

		_showWarn:function(msg){
			if ($("div[tabindex='-1']").size() == 0) {
				new Dialog({
					content: msg,
					icon: 'warning',
					okValue: $.i18n.prop("order.info.dialog.ok"),
					title: $.i18n.prop("order.info.dialog.prompt"),
					ok: function () {
						this.close();
					}
				}).showModal();
			}
		},

		_showFail:function(msg){
			if ($("div[tabindex='-1']").size() == 0) {
				new Dialog({
					title: $.i18n.prop("order.info.dialog.prompt"),
					content:msg,
					icon:'fail',
					okValue: $.i18n.prop("order.info.dialog.ok"),
					ok:function(){
						this.close();
					}
				}).show();
			}
		},

		//获取url中参数
		getUrlParam:function(name) {
			var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
			var r = window.location.search.substr(1).match(reg);  //匹配目标参数
			if (r != null) return decodeURI(r[2]); return null; //返回参数值
		},

		//格式化金钱
		fmoney:function (s, n) {
			var result = '0.00';
			if(isNaN(s) || !s){
				return result;
			}

			n = n > 0 && n <= 20 ? n : 2;
			s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";
			var l = s.split(".")[0].split("").reverse(),
			r = s.split(".")[1];
			var t = "";
			for(var i = 0; i < l.length; i ++ ){
				t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");
			}
			return t.split("").reverse().join("") + "." + r;
		},

        /*参数说明：
         需被控制的Select对象，
         需显示的option序号(留空则不处理) eg:[0,1,3]，
         需隐藏的option序号(留空则不处理) eg:[2,4,6]
         */
        toggleOptionShow:function(obj,arrShow,arrHide){
            function arrHandle(arr,type){
                if($.isArray(arr)){
                    var len=arr.length;
                    for(var i=0;i<len;i++){
                        var optionNow=obj.find("option").eq(arr[i]);
                        var optionP=optionNow.parent("span");
                        if(type=="show"){
                            if(optionP.size()){
                                optionP.children().clone().replaceAll(optionP);
                            }
                        }else{
                            if(!optionP.size()){
                                optionNow.wrap("<span style='display:none'></span>");
                            }
                        }
                    }
                }
        }
        arrHandle(arrShow,"show");
        arrHandle(arrHide,"hide");
    },

    //初始化上传控件
		_initUpdate:function () {
			var _this= this;
            var FILE_TYPES=['rar','doc','docx','txt','pdf','jpg','png','gif'];
            uploader = WebUploader.create({
                swf : _base+"/resources/spm_modules/webuploader/Uploader.swf",
                server: _base+'/order/uploadFile',
                auto : true,
                pick : {id: "#selectFile",  multiple: false},
                dnd: '#fy2', //拖拽
                accept: {
                    title: 'fileTypes',
                    extensions: 'rar,doc,docx,txt,pdf,jpg,png,gif',
                    // mimeTypes: 'application/zip,application/msword,application/pdf,image/jpeg,image/png,image/gif'
                },
                resize : false,
                // 禁掉全局的拖拽功能。这样不会出现图片拖进页面的时候，把图片打开。
                disableGlobalDnd: true,
                fileNumLimit: 10,
                fileSizeLimit: 100 * 1024 * 1024,    // 100 M
            });


			uploader.on("filesQueued", function (files) {
				var allCount = $("#fileList ul").length + 1
				if (allCount > 10) {
					_this._showWarn($.i18n.prop('order.upload.error.fileNum'));
					return false;
				}
			});

            uploader.on("beforeFileQueued", function (file) {
                var allSize = file.size;

                $("#fileList ul li").each(function() {
                    allSize += $(this).attr("size");
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

            });

            uploader.on("fileQueued",function(file){
                $("#fileList ul").css('"border-bottom","none"');
                $("#fileList").append('<ul style="border-bottom: medium none;"><li class="word" size="'+file.size+'" id="'+file.id+'">'+file.name+'</li><li><p class="ash-bj"><span style="width:0%;"></span></p><p name="percent">0%</p></li><li class="right"><i class="icon iconfont" >&#xe618;</i></li></ul>');
            });

            uploader.on("uploadProgress",function(file,percentage){

                var fileId = $("#"+file.id),
                    percent = fileId.find(".progress .progress-bar");
                if(!percent.length){//避免重复创建
                    percent = $('<div class="progress progress-striped active"><div class="progress-bar" role="progressbar" style="width: 0%"></div></div>')
                        .appendTo(fileId).find('.progress-bar');
                }
                fileId.next().find('span').css('width',percentage*100+"%");
                fileId.next().find('p[name="percent"]').text(parseInt(percentage*100)+"%");
                percent.css( 'width', percentage * 100 + '%' );

            });

            uploader.on( 'uploadSuccess', function( file, responseData ) {
                if(responseData.statusCode=="1"){
                    var fileData = responseData.data;
                    // console.log(fileData);
                    //文件上传成功
                    if(fileData){
                        $("#"+file.id).attr("fileId", fileData);
                        return;
                    }
                }//上传失败
                else{
					_this._showFail($.i18n.prop('order.upload.error.upload'));
                    //删除文件
                    $("#"+file.id).parent('ul').remove();
                    var file = uploader.getFile(file.id);
                    uploader.removeFile(file);
                    return;
                }
            });

			//  验证大小
			uploader.on("error",function (type){
				if(type == "F_DUPLICATE"){
					_this._showWarn($.i18n.prop('order.upload.error.repeat'));
				}else if(type == "Q_EXCEED_SIZE_LIMIT"){
					//_this._showWarn($.i18n.prop('order.upload.error.fileSize'));
				}else if(type == "Q_EXCEED_NUM_LIMIT"){
					//_this._showWarn($.i18n.prop('order.upload.error.fileNum'));
				}else if(type == "Q_TYPE_DENIED"){
					//_this._showWarn($.i18n.prop('order.upload.error.type'));
				}

			});

            uploader.on( 'uploadError', function( file, reason ) {
				_this._showFail($.i18n.prop('order.upload.error.upload'));

                //删除文件
                $("#"+file.id).parent('ul').remove();
                var file = uploader.getFile(file.id);
                uploader.removeFile(file);
            });

            uploader.on( 'uploadComplete', function( file ) {
                $( '#'+file.id ).find('.progress').fadeOut();
            });
        },

        _removeFile:function (id) {
            var file = uploader.getFile(id);
            uploader.removeFile(file);
        },
        _ie8palceholder:function(){
            $("#translateContent").trigger("focus");
            $("#translateContent").trigger("blur");
        }

    });
    
    module.exports = textOrderAddPager;
});