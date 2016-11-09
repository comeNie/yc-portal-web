(function( $ ){
    // 当domReady的时候开始初始化
    $(function() {
         //var $list = $("#fileInfo");

         uploader = WebUploader.create({
	    	  swf : _base+"/resources/spm_modules/webuploader/Uploader.swf",
	          server: _base+'/order/uploadFile',
	          auto : true,
	          pick : "#selectFile",
             resize : false,
             fileNumLimit: 300,
             fileSizeLimit: 100 * 1024 * 1024,    // 200 M
         });

         uploader.on("fileQueued",function(file){
             $("#fileInfo").append('<div id="'+file.id+'">'+file.name+'<p class="state">等待上传</p><div class="webuploadDelbtn">删除</div></div>');
         });
         uploader.on("uploadProgress",function(file,percentage){
             console.log(file);
             var fileId = $("#"+file.id),
                 percent = fileId.find(".progress .progress-bar");
             if(!percent.length){//避免重复创建
                 percent = $('<div class="progress progress-striped active"><div class="progress-bar" role="progressbar" style="width: 0%"></div></div>')
                     .appendTo(fileId).find('.progress-bar');
             }
             fileId.find('p.state').text('上传中');
             percent.css( 'width', percentage * 100 + '%' );
             console.log(percentage);

         });
         uploader.on( 'uploadSuccess', function( file ) {
             $( '#'+file.id ).find('p.state').text('已上传');
         });

         uploader.on( 'uploadError', function( file ) {
             $( '#'+file.id ).find('p.state').text('上传出错');
         });

         uploader.on( 'uploadComplete', function( file ) {
             $( '#'+file.id ).find('.progress').fadeOut();
         });

         uploader.onFileDequeued = function( file ) {
//             fileCount--;
//             fileSize -= file.size;

//             var fullName = $("#hiddenInput" + $(item)[0].id + file.id).val();
//             if (fullName!=null) {
//                 $.post(webuploaderoptions.deleteServer, { fullName: fullName }, function (data) {
//                     alert(data.message);
//                 })
//             }
                 $("#"+file.id).remove();
//             $("#"+ $(item)[0].id + file.id).remove();
//             $("#hiddenInput" + $(item)[0].id + file.id).remove();

//             if ( !fileCount ) {
//                 setState( 'pedding' );
//             }
//
//             removeFile( file );
//             updateTotalProgress();

         };

         function updateTotalProgress() {
             var loaded = 0,
                 total = 0,
                 spans = $progress.children(),
                 percent;

             $.each( percentages, function( k, v ) {
                 total += v[ 0 ];
                 loaded += v[ 0 ] * v[ 1 ];
             } );

             percent = total ? loaded / total : 0;


             spans.eq( 0 ).text( Math.round( percent * 100 ) + '%' );
             spans.eq( 1 ).css( 'width', Math.round( percent * 100 ) + '%' );
             updateStatus();
         }

         //删除
//         $list.on("click", ".webuploadDelbtn", function () {
//             debugger
//             var $ele = $(this);
//             var id = $ele.parent().attr("id");
//             //var id = id.replace($(item)[0].id, "");
//
//             var file = uploader.getFile(id);
//             uploader.removeFile(file);
//         });



         //上传出错时触发
         uploader.on( "uploadError", function( obj, reason  ) {
               var errorMessage = response.message;
                   alert(reason,3); 
           });
    });

})( jQuery );