(function( $ ){
    // 当domReady的时候开始初始化
    $(function() {
         //var $list = $("#fileInfo");
        var FILE_TYPES=['rar','zip','doc','docx','pdf','jpg','png','jif'];
         uploader = WebUploader.create({
	    	  swf : _base+"/resources/spm_modules/webuploader/Uploader.swf",
	          server: _base+'/order/uploadFile',
	          auto : true,
	          pick : "#selectFile",
	          dnd: '#fy2', //拖拽
	          accept: {
	      	    title: 'intoTypes',
	      	    extensions: 'rar,zip,doc,docx,pdf,jpg,png,gif',
	      	    mimeTypes: 'application/zip,application/msword,application/pdf,image/jpg,image/png,image/gif'
	      		},
             resize : false,
             // 禁掉全局的拖拽功能。这样不会出现图片拖进页面的时候，把图片打开。
             disableGlobalDnd: true,
             fileNumLimit: 10,
             fileSizeLimit: 100 * 1024 * 1024,    // 100 M
         });

        uploader.on("beforeFileQueued", function (file) {
            var allSize = file.size;
            var allCount = $("#fileList ul").length + 1
            $("#fileList ul li").each(function() {
                allSize += $(this).attr("size");
            });

            if (allSize > 100*1024*1024) {
                alert("上传文件不能超过100M");
                return false;
            }

            if (allCount > 10) {
                alert("上传文件个数不能超过10个");
                return false;
            }

            if ($.inArray(file.ext, FILE_TYPES)<0) {
                alert("请上传rar,zip,doc,docx,pdf,jpg,png,jif");
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
             fileId.next().find('p[name="percent"]').text(percentage*100+"%");
             percent.css( 'width', percentage * 100 + '%' );

         });

         uploader.on( 'uploadSuccess', function( file, responseData ) {
        	 if(responseData.statusCode=="1"){
					var fileData = responseData.data;
					console.log(fileData);
					//文件上传成功
					if(fileData){
						 $("#"+file.id).attr("fileId", fileData);
						return;
					}
				}//上传失败
				else{
				    alert("上传文件失败");
                    //删除文件
                    $("#"+file.id).parent('ul').remove();
                    var file = uploader.getFile(file.id);
                    uploader.removeFile(file);
					return;
				}
         });

         uploader.on( 'uploadError', function( file, reason ) {
        	 alert(reason);
             //删除文件
             $("#"+file.id).parent('ul').remove();
             var file = uploader.getFile(file.id);
             uploader.removeFile(file);
         });

         uploader.on( 'uploadComplete', function( file ) {
             $( '#'+file.id ).find('.progress').fadeOut();
         });


         //删除
    	 $('.attachment').delegate('ul li i','click',function(){
			 $(this).parent().parent('ul').remove();

			 var id = $(this).parent().parent('ul').find('li:first').attr("id");
			 var file = uploader.getFile(id);
			 uploader.removeFile(file);
		 });
    });

})( jQuery );