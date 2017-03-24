$(function(){
  
  //添加语言的效果
  $(document).on('click','[add-languages]',function(){
    var text = $('<div class="edit quesbox"> <ul class="quesbox-wrap"> <li> <div class="select-wrap select-wrap1"> <div class="select radius drop-down" drop-down>中文→西班牙语</i></div> <div class="select-con undis"> <ul> <li><a href="javascript:;">中文→英语</a></li> <li><a href="javascript:;">中文→日语</a></li> <li><a href="javascript:;">中文→韩语</a></li> </ul> </div> </div> <div class="select-wrap select-wrap2"> <div class="select radius drop-down" drop-down>口译</i></div> <div class="select-con undis"> <ul> <li><a href="javascript:;">口译</a></li> <li><a href="javascript:;">笔译</a></li> </ul> </div> </div> <input type="text" class="int-text int-mini radius input1"> <span class="unit">元/千字</span> <p class="edit-chose"> <span class="txt4"></span> <span class="txt5"></span> </p> </li> </ul> </div>'); 
      //每次只能添加一个编辑项目
      if(!$(this).parent('.value').find('[add-program] .quesbox').length>0){
        $(this).siblings('[add-program]').append(text);
      }
      return false;
  });
  
  //添加教育背景效果
  $(document).on('click','[add-educate]',function(){
    var text1 = $(' <div class="educate quesbox"> <ul class="quesbox-wrap"> <li class="mb10"> <div class="select-wrap select-wrap1 mr30"> <div class="select radius drop-down" drop-down="">北京大学</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">北京大学</a></li> <li><a href="javascript:;">天津大学</a></li> <li><a href="javascript:;">南京大学</a></li> </ul> </div> </div> <div class="select-wrap select-wrap2 mr30"> <div class="select radius drop-down" drop-down="">本科</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">本科</a></li> <li><a href="javascript:;">大专</a></li> <li><a href="javascript:;">硕士</a></li> </ul> </div> </div> <div class="select-input"> <label for="class-name">专业名称</label> <input type="text" class="int-text int-mini radius" id="class-name"/> </div> </li> <li class="mb10"> <div class="select-wrap mr10"> <div class="select radius drop-down" drop-down="">中国</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">中国</a></li> </ul> </div> </div> <div class="select-wrap mr10"> <div class="select radius drop-down" drop-down="">北京</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">北京</a></li> <li><a href="javascript:;">天津</a></li> </ul> </div> </div> <div class="select-wrap"> <div class="select radius drop-down" drop-down="">北京市</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">北京市</a></li> <li><a href="javascript:;">天津市</a></li> </ul> </div> </div> <span class="posi-title">地址：</span> </li> <li class="address-input mb10"> <input type="text" class="int-text int-mini radius" placeholder="详细地址"/> </li> <li> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down" drop-down="">2010</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">2010</a></li> <li><a href="javascript:;">2011</a></li> <li><a href="javascript:;">2012</a></li> <li><a href="javascript:;">2013</a></li> </ul> </div> </div> <span class="unit mr10">年</span> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down" drop-down="">09</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">01</a></li> <li><a href="javascript:;">02</a></li> <li><a href="javascript:;">03</a></li> <li><a href="javascript:;">04</a></li> <li><a href="javascript:;">05</a></li> <li><a href="javascript:;">06</a></li> <li><a href="javascript:;">07</a></li> <li><a href="javascript:;">08</a></li> <li><a href="javascript:;">09</a></li> <li><a href="javascript:;">10</a></li> <li><a href="javascript:;">11</a></li> <li><a href="javascript:;">12</a></li> </ul> </div> </div> <span class="unit mr20">月</span> <span class="unit mr20">至</span> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down" drop-down="">2010</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">2010</a></li> <li><a href="javascript:;">2011</a></li> <li><a href="javascript:;">2012</a></li> <li><a href="javascript:;">2013</a></li> </ul> </div> </div> <span class="unit mr10">年</span> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down" drop-down="">09</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">01</a></li> <li><a href="javascript:;">02</a></li> <li><a href="javascript:;">03</a></li> <li><a href="javascript:;">04</a></li> <li><a href="javascript:;">05</a></li> <li><a href="javascript:;">06</a></li> <li><a href="javascript:;">07</a></li> <li><a href="javascript:;">08</a></li> <li><a href="javascript:;">09</a></li> <li><a href="javascript:;">10</a></li> <li><a href="javascript:;">11</a></li> <li><a href="javascript:;">12</a></li> </ul> </div> </div> <span class="unit">月</span> <span class="posi-title">时间：</span> <p class="edit-chose"> <span class="txt4"></span> <span class="txt5"></span> </p> </li> </ul> </div>'); 
    //每次只能添加一个编辑项目
      if(!$(this).parent('.value').find('[add-program] .quesbox').length>0){
        $(this).siblings('[add-program]').append(text1);
      }
      return false;
  });

   //添加工作经验
  $(document).on('click','[add-work]',function(){
    var text2 = $('<div class="educate work-expersise quesbox"> <ul class="quesbox-wrap"> <li class="mb10"> <div class="select-input mr20"> <input type="text" class="int-text int-mini radius"/> </div> <div class="select-input"> <label for="work-name">职位名称：</label> <input type="text" class="int-text int-mini radius" id="work-name"/> </div> <span class="posi-title">企业名称：</span> </li> <li class="mb10"> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down" drop-down="">2010</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">2010</a></li> <li><a href="javascript:;">2011</a></li> <li><a href="javascript:;">2012</a></li> <li><a href="javascript:;">2013</a></li> </ul> </div> </div> <span class="unit mr10">年</span> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down" drop-down="">09</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">01</a></li> <li><a href="javascript:;">02</a></li> <li><a href="javascript:;">03</a></li> <li><a href="javascript:;">04</a></li> <li><a href="javascript:;">05</a></li> <li><a href="javascript:;">06</a></li> <li><a href="javascript:;">07</a></li> <li><a href="javascript:;">08</a></li> <li><a href="javascript:;">09</a></li> <li><a href="javascript:;">10</a></li> <li><a href="javascript:;">11</a></li> <li><a href="javascript:;">12</a></li> </ul> </div> </div> <span class="unit mr20">月</span> <span class="unit mr20">至</span> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down" drop-down="">2010</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">2010</a></li> <li><a href="javascript:;">2011</a></li> <li><a href="javascript:;">2012</a></li> <li><a href="javascript:;">2013</a></li> </ul> </div> </div> <span class="unit mr10">年</span> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down" drop-down="">09</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">01</a></li> <li><a href="javascript:;">02</a></li> <li><a href="javascript:;">03</a></li> <li><a href="javascript:;">04</a></li> <li><a href="javascript:;">05</a></li> <li><a href="javascript:;">06</a></li> <li><a href="javascript:;">07</a></li> <li><a href="javascript:;">08</a></li> <li><a href="javascript:;">09</a></li> <li><a href="javascript:;">10</a></li> <li><a href="javascript:;">11</a></li> <li><a href="javascript:;">12</a></li> </ul> </div> </div> <span class="unit">月</span> <span class="posi-title">在职时间：</span> </li> <li> <textarea class="int-text int-mini radius"></textarea> <span class="posi-title">职位描述：</span> <p class="edit-chose"> <span class="txt4"></span> <span class="txt5"></span> </p> </li> </ul> </div>'); 
    //每次只能添加一个编辑项目
      if(!$(this).parent('.value').find('[add-program] .quesbox').length>0){
        $(this).siblings('[add-program]').append(text2);
      }
      return false;
  });
  
  //添加证书
  $(document).on('click','[add-card]',function(){
    var text3 = $('<div class="educate work-expersise quesbox"> <ul class="quesbox-wrap"> <li class="mb10"> <div class="select-input mr20"> <input type="text" class="int-text int-mini radius"/> </div> <div class="select-input"> <label for="card-name">颁发证书机构：</label> <input type="text" class="int-text int-mini radius" id="card-name"/> </div> <span class="posi-title">证书名称：</span> </li> <li class="mb10"> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down" drop-down="">2010</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">2010</a></li> <li><a href="javascript:;">2011</a></li> <li><a href="javascript:;">2012</a></li> <li><a href="javascript:;">2013</a></li> </ul> </div> </div> <span class="unit mr10">年</span> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down" drop-down="">09</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">01</a></li> <li><a href="javascript:;">02</a></li> <li><a href="javascript:;">03</a></li> <li><a href="javascript:;">04</a></li> <li><a href="javascript:;">05</a></li> <li><a href="javascript:;">06</a></li> <li><a href="javascript:;">07</a></li> <li><a href="javascript:;">08</a></li> <li><a href="javascript:;">09</a></li> <li><a href="javascript:;">10</a></li> <li><a href="javascript:;">11</a></li> <li><a href="javascript:;">12</a></li> </ul> </div> </div> <span class="unit mr20">月</span> <span class="posi-title">颁发日期：</span> </li> <li> <textarea class="int-text int-mini radius"></textarea> <span class="posi-title">证书概述：</span> <p class="edit-chose"> <span class="txt4"></span> <span class="txt5"></span> </p> </li> </ul> </div>'); 
    //每次只能添加一个编辑项目
      if(!$(this).parent('.value').find('[add-program] .quesbox').length>0){
        $(this).siblings('[add-program]').append(text3);
      }
      return false;
  });
  
  $(document).on('click','[drop-down]',function(){
     $(this).parent('.select-wrap').siblings().find('.select-con').addClass('undis');
     $(this).parents().siblings().find('.select-con').addClass('undis');
     if($(this).siblings('.select-con').hasClass('undis')){
         $(this).siblings().removeClass('undis');
     }else{
        $(this).siblings().addClass('undis');
     }
      return false; 
  });

  $(document).on('click','.select-con ul li',function(){
      var text = $(this).text();
      $(this).parents('.select-con').siblings('[drop-down]').text(text);
      $(this).parents('.select-con').addClass('undis');
      return false;
  });

  $(document).on('click','body',function(){
     if(!$('.select-con').hasClass('undis')){
        $('.select-con').addClass('undis')
      }
  });
 
});