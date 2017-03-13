define('app/jsp/home', function (require, exports, module) {
    'use strict';
    var $=require('jquery'),
        Widget = require('arale-widget/1.2.0/widget'),
        AjaxController = require('opt-ajax/1.0.0/index');
    require("audio/audio.min");
    require("jquery-validation/1.15.1/jquery.validate");
    require("app/util/aiopt-validate-ext");
	require('jquery-i18n/1.2.2/jquery.i18n.properties.min');
    require('webuploader/webuploader');
	var CountWordsUtil = require("app/util/countWords");

    //实例化AJAX控制处理对象
    var ajaxController = new AjaxController();
    var languageaudio;
	var sourYiWen="";
	var clip;
    var uploader = null;
	var homePage = Widget.extend({
        //属性，使用时由类的构造函数传入
        attrs: {
            clickId:""
        },

        //事件代理
        events: {
            "click #recharge-popo":"_addOralOrderTemp",
            "click #toCreateOrder":"_toCreateOrder",
			"keyup #int-before": "_verifyLan",
            "click #trante": "_mt",
            "click #sus-top2": "_text2audio",
			"click #sus-top3":"_collectTrans",
			"click #humanTranBtn":"_goTextOrder",
			"click .change": "_change",
			"click #preser-btn": "_saveText",
			"click #preser-close": "_cancelSave",
			"click #error": "_transError"
        },

        //重写父类
        setup: function () {
            homePage.superclass.setup.call(this);

        	//初始化国际化
			$.i18n.properties({//加载资浏览器语言对应的资源文件
				name: ["home","commonRes"], //资源文件名称，可以是数组
				path: _i18n_res, //资源文件路径
				mode: 'both',
                cache: true,
				language: currentLan,
                checkAvailableLanguages: true
			});

			this._initPage();

            audiojs.events.ready(function() {
                languageaudio = audiojs.createAll();
            });
            if ( !WebUploader.Uploader.support() ) {
                alert( 'Web Uploader 不支持您的浏览器！如果你使用的是IE浏览器，请尝试升级 flash 播放器');
                throw new Error( 'WebUploader does not support the browser you are using.' );
            }else if(uploader==null){
                this._initUpdate();
            }

            //若需要触发译文收藏
            if(true == needCollect){
                this.textCounter('inputsLen',2000);
            	this._collectTrans();
			}
        },

        _initPage:function () {
            var _this = this;
            // $('.dropdown').eq(0).attr('id', 'drop-a');
            // $('.dropdown').eq(1).attr('id', 'drop-b');

            //源语言改变
			$(".dropdown .selected").eq(0).bind('DOMNodeInserted', function (e) {
                _this._diffSrc();
            });

            //目标语言改变
			$(".dropdown .selected").eq(1).bind('DOMNodeInserted', function (e) {
                _this._mt();
            });
        },
		//字数统计
		textCounter:function(desc,maxlimit) {
			var totalWords =  CountWordsUtil.count($("#int-before").val());
			// if (totalWords > maxlimit){
			//     //如果元素区字符数大于最大字符数，按照最大字符数截断；
			//     $($this).val($($this).val().substring(0, maxlimit));
			// }
			//在记数区文本框内显示剩余的字符数；
			$("#"+desc).html(totalWords);
		},

		//人工翻译,跳转到笔译订单
       	_goTextOrder:function(){
			window.location.href=_base+"/written";
		},

        _resetMt:function () {
            $('#tgtNew').empty();
            $('#srcNew').empty();
            $('#transRes').val('');
            $('#transResBak').val('');
            $("#tgtOld").show();
            $("#tgtNew").hide();
            $(".post-cion").css("visibility","hidden");
			$("#transError").html('');
        },

        //翻译
        _mt:function() {
			var _this=this;
			var ywText="";
        	var from=$(".dropdown .selected").eq(0).attr("value");
        	var to=$(".dropdown .selected").eq(1).attr("value");
            $("#showb option").each(function () {
                if ($(".dropdown .selected").eq(1).html() == $(this).text()) {
                    to = $(this).val();
                    return false;
                }
            });
			if (Window.console){
				console.log("from:"+from+",to:"+to);
			}

            _this._resetMt();

			if (!$("#int-before").val()) {
				return;
			}

			if ( CountWordsUtil.count( $("#int-before").val()) > 2000) {
				$("#transError").html($.i18n.prop("home.error.toolarge"));
				return;
			}

			if (from == 'auto' || $("#int-before") == '') {
				return
			}

        	ajaxController.ajax({
				type: "post",
				url: _base + "/mt",
				data: {
					from: from,
					to: to,
					text: $("#int-before").val()
				},
				success: function (data) {
					if("OK" === data.statusInfo) {
						//设置启用分词
                        $("#tgtNew").attr("onmousemove","srcMove()");
                        $("#tgtNew").attr("onmouseout","srcOut()");
						//图标展示
                        $(".post-cion").css("visibility","visible");
						$("#transError").html('');

						$('#tgtNew').empty();
						$('#srcNew').empty();

						var array=eval("("+data.data+")");
						var translation = array.translation;
						if(translation){
							jQuery.each(translation, function(i,item){
								var translated  = item.translated;
								jQuery.each(translated, function(i,item){
									ywText = ywText+item.text;
									sourYiWen = sourYiWen+item.text;
									$("#transRes").val(ywText);
									$("#transResBak").val(ywText);

									//翻译后的文字超过1024，隐藏播放喇叭
									if ($("#transRes").val().length > 1024)
										$("#sus-top2").hide();
									else
										$("#sus-top2").show();

									var alignmentRaw  = item["alignment-raw"];
									var tgtTokenized  = item["tgt-tokenized"];
									var srcTokenized  = item["src-tokenized"];
									if(tgtTokenized){
										_this._yiwenSpan(alignmentRaw,tgtTokenized,srcTokenized,i+1);
									}//若没有分词信息，则不触发分词。
									else{
										$("#srcNew").append(" <span id='src_10'>"+$("#int-before").val()+"</span> ");
										$("#tgtOld").hide();
										$("#tgtNew").show();
										//取消分词触发
                                        $("#tgtNew").removeAttr("onmousemove");
                                        $("#tgtNew").removeAttr("onmouseout");
										$("#tgtNew").append(" <span class='' id='10'>"+ywText+"</span> ");
									}
								});
							});
						}
                        var collectionId = array.collectionId;
						if(collectionId!=null && collectionId!=""){
                            //设置收藏ID，
                            $("#sus-top3").attr("collectId",collectionId);
                            //并将收藏按钮设置为取消收藏
                            $("#sus-top3 span.suspension3").eq(0).text($.i18n.prop("home.collection.cancle.title"));
						}
					} else {
						//图标隐藏
                        $(".post-cion").css("visibility","hidden");
						$("#transError").html($.i18n.prop("home.error.trans"));
						//alert($.i18n.prop("home.error.trans"));
					}
					
				}
			});
        },

		//检测语言 并翻译
		_verifyLan:function() {
			var _this = this;
			var from = $(".dropdown .selected").eq(0).attr("value");

			var key =  $("#int-before").val();

            _this._resetMt();
			if (key) {
			// 	var key_le = key.length;
			// 	if(key_le > 2000){
			// 		//如果元素区字符数大于最大字符数，按照最大字符数截断；
			// 		key = key.substring(0, 2000);
			// 		$("#int-before").val(key);
			// 		$("#inputsLen").html(2000);
			// 	}else{
			// 		//在记数区文本框内显示剩余的字符数；
			// 		$("#inputsLen").html(key_le);
			// 	}

				if ( CountWordsUtil.count( $("#int-before").val()) > 2000) {
					$("#transError").html($.i18n.prop("home.error.toolarge"));
					return;
				}

				//语言检测
				ajaxController.ajax({
					type: "post",
					url: _base + "/translateLan",
					data: {
						text: $("#int-before").val()
					},
					success: function (data) {
						if("OK" === data.statusInfo) {
							var vLan = data.data;
							var checkFlag = false;
							if ( vLan!= '') {
								$("#showa option").each(function () {
									if ($(this).val() == vLan) {
										checkFlag = true;
										$('.selected').eq(0).html( $(this).text());
										return false;
									}
								});

								if (!checkFlag && $('.selected').eq(0).attr('value')=='auto') {
									//检测结果在源语言里没找到。
									$("#transError").html($.i18n.prop("home.error.verify"));
									return;
								}

                                if (checkFlag) {
                                    $('.selected').eq(0).attr('value', vLan);
                                }

								_this._diffSrc();
								_this._mt();
							} else { //检测语言失败
								$("#transError").html($.i18n.prop("home.error.verify"));
							}
						}
					}
				});
			}

		},

        //使源语言和目标语言不一样
		_diffSrc:function () {
			var srcValue = $(".selected").eq(0).attr('value');
			var srcText = $(".selected").eq(0).html();
			var disValue = $(".selected").eq(1).attr('value');
            var disText = $(".selected").eq(1).html();

			if (srcText == disText) {
				$("#showb option").each(function() {
					if ($(this).attr('value') != disValue) {
						srcValue = $(this).val();
						srcText = $(this).text();
						$(".selected").eq(1).attr('value', srcValue);
						$(".selected").eq(1).html(srcText);
						return false;
					}
				});
			}

			$(".dropdown").eq(1).find('li').each(function () {
                if ($(this).html() == $(".selected").eq(0).html())
                    $(this).hide();
                else
                    $(this).show();
            });
        },

        _change:function() {
        	var srcValue = $(".selected").eq(0).attr('value');
        	var srcText = $(".selected").eq(0).html();
        	var disValue = $(".selected").eq(1).attr('value');
        	var disText = $(".selected").eq(1).html();
        	
        	if ($(".selected").eq(0).attr('value') == 'auto') {
        		$("#showb option").each(function() {
        			if ($(this).attr('value') != disValue) {
        				srcValue = $(this).val();
        				srcText = $(this).text();
        				return false;
        			}
        		});
        	}

        	$(".selected").eq(0).attr('value', disValue);
        	$(".selected").eq(0).html(disText);
        	$(".selected").eq(1).attr('value', srcValue);
        	$(".selected").eq(1).html(srcText);
        	
        },
        //文本转音频
        _text2audio:function() {
			//获取目标语言编码
			var to =$(".dropdown .selected").eq(1).attr("value");
            var audio = languageaudio[0];
            var itostr = $.trim($("#transRes").val());
            var playUrl = _base + '/Hcicloud/text2audio?lan='+to+'&text='+ window.encodeURI(window.encodeURI(itostr));
            //
            // 		 $("#audioPlay").attr("src", playUrl);
            audio.load(_base + '/Hcicloud/text2audio?lan='+to+'&text='+ window.encodeURI(window.encodeURI(itostr)));
            $(".audiojs .play").click();
        	//var myAudio = document.getElementById('audioPlay');
            // if(myAudio.paused){
		     //    var itostr = $.trim($("#transRes").val());
		     //    if(itostr != null){
	        // 		 var playUrl = _base + '/Hcicloud/text2audio?lan='+to+'&text='+ window.encodeURI(window.encodeURI(itostr));
	        //
	        // 		 $("#audioPlay").attr("src", playUrl);
	        // 		 console.log(playUrl);
	        // 		 myAudio.play();
		     //    }
	        // }else{
	        //     myAudio.pause();
	        // }
        },
        
        //保存
        _saveText:function() {
        	$("#transRes").attr("readonly","readonly");
            var collectId = $("#sus-top3").attr("collectId");
			if(collectId!=null && collectId!=""){
				this._updateCollect(collectId);
			}else{
                if ($.trim( $("#transRes").val())=='')
                    $(".post-cion").css("visibi lity","hidden");
                else
                    $(".post-cion").css("visibility","visible");

                if ($.trim(sourYiWen) == $("#transRes").val()) {
                    $("#tgtOld").hide();
                    $("#tgtNew").show();
                }
			}
        },
		//更新收藏译文
		_updateCollect:function (collectId) {
            ajaxController.ajax({
                type: "post",
                url: _base + "/collectTrans/update/"+collectId,
                data: {
                    translation: $("#transRes").val()
                },
                success: function (data) {
                    if("OK" === data.statusInfo) {
                        if ($.trim( $("#transRes").val())=='')
                            $(".post-cion").css("visibi lity","hidden");
                        else
                            $(".post-cion").css("visibility","visible");

                        if ($.trim(sourYiWen) == $("#transRes").val()) {
                            $("#tgtOld").hide();
                            $("#tgtNew").show();
                        }
                    }
                }
            });
        },
        
        //取消
        _cancelSave:function() {
        	$("#transRes").val($("#transResBak").val());
        	$("#transRes").attr("readonly","readonly");
			if ($.trim(sourYiWen) == $("#transRes").val()) {
				$("#tgtOld").hide();
				$("#tgtNew").show();
			}
        },
        
        //翻译有误
        _transError:function() {
        	$("#transRes").removeAttr("readonly");
			$("#transResBak").val($("#transRes").val());
			$("#tgtNew").hide();
			$("#tgtOld").show();
        },

		//截取原文 译文
		_yiwenSpan:function(alignmentRaw,tgtTokenized,srcTokenized,int){
			//译文
			var tgt = tgtTokenized.split(" ");
			//原文
			var src = srcTokenized.split(" ");
			var newTgt = "";
			var newSrc = "";
			jQuery.each(alignmentRaw, function(i,item){
				var srcStart  = item["src-start"];
				var srcEnd  = item["src-end"];

				var tgtStart  = item["tgt-start"];
				var tgtEnd  = item["tgt-end"];
				if(srcStart == srcEnd){
					var sNewStart = " <span id=src_"+int+""+i+">"+src[srcStart]+"</span> " ;
					src[srcStart]= sNewStart;
				}else{
					var sNewStart = " <span id=src_"+int+""+i+">"+src[srcStart];
					var sNewEnd = src[srcEnd]+"</span> " ;
					src[srcStart]= sNewStart;
					src[srcEnd] = sNewEnd;
				}

				if(tgtStart == tgtEnd){
					var tNewStart = "<span class='' id="+int+""+i+"  onmousemove='tgtMove("+int+""+i+")' onmouseout='tgtOut("+int+""+i+")'>"+tgt[tgtStart]+"</span>";
					tgt[tgtStart]= tNewStart;
				}else{
					var tNewStart = "<span class=''  id="+int+""+i+" onmousemove='tgtMove("+int+""+i+")' onmouseout='tgtOut("+int+""+i+")'>"+tgt[tgtStart] ;
					var tNewEnd = tgt[tgtEnd]+"</span>" ;
					tgt[tgtStart]= tNewStart;
					tgt[tgtEnd] = tNewEnd;
				}

			});
			for (var int = 0; int < tgt.length; int++) {
				newTgt=newTgt+tgt[int]+" ";

			}
			for (var int2 = 0; int2 < src.length; int2++) {
				newSrc=newSrc+src[int2]+" ";
			}
			$("#srcNew").append(newSrc);
			$("#tgtOld").hide();
			$("#tgtNew").show();
			$("#tgtNew").append(newTgt);

		},

		//初始化文件上传
        _initUpdate:function () {
            var _this= this;
            var FILE_TYPES=['doc','docx','txt'];
            var from=$(".dropdown .selected").eq(0).attr("value");
            var to=$(".dropdown .selected").eq(1).attr("value");
            uploader = WebUploader.create({
                swf : _base+"/resources/spm_modules/webuploader/Uploader.swf",
                server: _base+'/mtUpload',
                auto : true,
                pick : {id: "#selectFile",  multiple: false},
                // accept: {
                //     title: 'fileTypes',
                //     extensions: 'doc,docx,txt',
                //     mimeTypes: 'application/msword'
                // },
                resize : false,
                // 禁掉全局的拖拽功能。这样不会出现图片拖进页面的时候，把图片打开。
                disableGlobalDnd: true,
                formData: {"from":from,"to":to},
                fileNumLimit: 1,
                fileSingleSizeLimit: 100 * 1024   // 100 K
            });
			//当文件被加入队列之前触发
            uploader.on("beforeFileQueued", function (file) {
            	//判断文件是否为空
                if (file.size == 0) {
                    _this._showWarn($.i18n.prop('home.upload.error.empty'));
                    return false;
                }
				//判断文件是否小于100k
                if (file.size > 10*1024) {
                    _this._showWarn($.i18n.prop('home.upload.error.fileSizeSingle'));
                    return false;
                }
				//判断文件是否允许的格式
                if ($.inArray(file.ext.toLowerCase(), FILE_TYPES)<0) {
                    _this._showWarn($.i18n.prop('home.upload.error.type'));
                    return false;
                }

            });
            //文件开始上传
            uploader.on("uploadStart",function (file) {
				new Dialog({
                    closeIconShow:false,
                    icon:"loading",
                    //正在处理中，请稍后...
                    content: $.i18n.prop('com.ajax.def.content')
                }).showModal();
            });
			//显示上传进度
            // uploader.on("uploadProgress",function(file,percentage){
             //    var fileId = $("#"+file.id),
             //        percent = fileId.find(".progress .progress-bar");
             //    if(!percent.length){//避免重复创建
             //        percent = $('<div class="progress progress-striped active"><div class="progress-bar" role="progressbar" style="width: 0%"></div></div>')
             //            .appendTo(fileId).find('.progress-bar');
             //    }
             //    fileId.next().find('span').css('width',percentage*100+"%");
             //    fileId.next().find('p[name="percent"]').text(parseInt(percentage*100)+"%");
             //    percent.css( 'width', percentage * 100 + '%' );
            //
            // });
			//上传成功后触发
            uploader.on( 'uploadSuccess', function( file, responseData ) {
                if(responseData.statusCode=="1"){
                    //上传成功需要进行跳转
					alert("OK");
                }//上传失败
                else{
                    _this._showFail($.i18n.prop('home.upload.error.upload'));
                    //删除文件
                    var file = uploader.getFile(file.id);
                    uploader.removeFile(file);
                    return;
                }
            });

            //  当validate不通过时，会以派送错误事件的形式通知调用者
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
			//上传失败
            uploader.on( 'uploadError', function( file, reason ) {
                _this._showFail($.i18n.prop('home.upload.error.upload'));
                var file = uploader.getFile(file.id);
                uploader.removeFile(file);
            });
        },
		//收藏译文
		_collectTrans:function () {
			var collectId = $("#sus-top3").attr("collectId");
			//若已经收藏，则进行取消收藏
			if(collectId!=null && collectId!=""){
				this._cancelCollectTrans();
				return;
			}
            ajaxController.ajax({
                type: "post",
                url: _base + "/collectTrans/add",
                data: {
                    sourceLanguage: $(".dropdown .selected").eq(0).attr("value"),
                    targetLanguage: $(".dropdown .selected").eq(1).attr("value"),
                    original: $("#int-before").val(),
                    translation: $("#transRes").val()
                },
                success: function (data) {
                    if("OK" === data.statusInfo) {
                        //显示收藏成功
                        $("#transError").html($.i18n.prop("home.collection.success"));
                        //设置收藏ID，
						$("#sus-top3").attr("collectId",data.data);
						//并将收藏按钮设置为取消收藏
                        $("#sus-top3 span.suspension3").eq(0).text($.i18n.prop("home.collection.cancle.title"));
                    }
                }
            });
        },
		//取消译文收藏。
		_cancelCollectTrans:function () {
			var collectId = $("#sus-top3").attr("collectId");
			if (collectId==null || collectId=="")
				return;
            ajaxController.ajax({
                type: "post",
                url: _base + "/collectTrans/del",
                data: {collectionIds: "["+collectId+"]"},
                success: function (data) {
                    if("OK" === data.statusInfo) {
                       	//收藏已取消
                        $("#transError").html($.i18n.prop("home.collection.cancle.success"));
                        $("#sus-top3").attr("collectId","");
                        //收藏按钮显示收藏译文
                        $("#sus-top3 span.suspension3").eq(0).text($.i18n.prop("home.collection.title"));
                    }
                }
            });

        },
		//显示警告信息
        _showWarn: function (msg) {
            new Dialog({
                content: msg,
                icon: 'warning',
                okValue: $.i18n.prop("com.ajax.def.okbtn"),
                title: $.i18n.prop("com.info.dialog.prompt"),
                ok: function () {
                    this.close();
                }
            }).showModal();
        },
		//显示失败信息
        _showFail:function(msg){
            if ($("div[tabindex='-1']").size() == 0) {
                new Dialog({
                    title: $.i18n.prop("com.info.dialog.prompt"),
                    content:msg,
                    icon:'fail',
                    okValue: $.i18n.prop("com.ajax.def.okbtn"),
                    ok:function(){
                        this.close();
                    }
                }).show();
            }
        }
    });

    module.exports = homePage;
});
