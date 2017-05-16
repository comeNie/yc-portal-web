$(function(){
  var num=3;//设置添加的翻译语言子元素个数的计数器
  var id=3;
  //添加语言的效果
  $(document).on('click','[add-languages]',function(){
    var text = $('<div class="edit quesbox addLanguage"> <ul class="quesbox-wrap addLanguage"> <li> <div class="select-wrap select-wrap1"> <div class="select radius drop-down LanguageType" drop-down>中文→西班牙语</i></div> <div class="select-con undis"> <ul> <li><a href="javascript:;">中文→英语</a></li> <li><a href="javascript:;">中文→日语</a></li> <li><a href="javascript:;">中文→韩语</a></li> </ul> </div> </div> <div class="select-wrap select-wrap2"> <div class="select radius drop-down selectType" drop-down>口译</i></div> <div class="select-con undis"> <ul> <li><a href="javascript:;">口译</a></li> <li><a href="javascript:;">笔译</a></li> </ul> </div> </div> <input type="text" class="int-text int-mini radius input1 inputPrice" id="ok"> <span class="unit" >元/千字</span> <p class="edit-chose"> <span class="txt4" ok></span> <span class="txt5" clear></span> </p> </li> </ul> </div>'); 
      //每次只能添加一个编辑项目
      if(!$(this).parent('.value').find('[add-program] .quesbox').length>0){
        $(this).siblings('[add-program]').append(text);
      }
      return false;
  });
  //确定添加语言
  $(document).on('click','[ok]',function(){
    var input1=$('.addLanguage').find(".LanguageType").html()// 取得选项-1的值 语种
    var input2=$('.addLanguage').find(".selectType").html()//取得选项-2的值 口译或者笔译
    var input3=$('.addLanguage').find(".inputPrice").val()//取得选项-3的值 价格
    var clone=$( "<p class=inputp"+num+"><span class='txt1 input12'>"+input1+"</span>"+"<span class='txt2 input13' >"+input2+"</span>"+"<span class='txt1 input14'><strong>"+input3+"</strong>元/千字（参考价）</span>"+"<span>未测试</span>"+"<input type='button' class='btn biu-btn btn-auto-25 btn-red radius10' name="+id+" value='删 除' confirm-step2-language ><input type='button' class='btn biu-btn btn-auto-25 btn-green radius10' editBtnLang name=1."+id+" value='编 辑' "+"></p>" )
    $('.inputexit').before(clone);
    num+=1;
    id+=1;
    $('.addLanguage.quesbox').remove();
    
  })
  //取消添加语言
  $(document).on('click','[clear]',function(){
    $('.addLanguage.quesbox').remove();
  })
  //编辑当期翻译语言
  $(document).on('click','[editBtnLang]',function(){
    var delettedNodeNum=$(this).attr('name').substr(2)//处理’编辑‘对应的id 取尾数
    console.log(delettedNodeNum);
    var id = ".inputp"+delettedNodeNum;
    // $('.inputContainer').find(id).remove()
    var edit = $('<div class="edit quesbox addLanguage"> <ul class="quesbox-wrap addLanguage"> <li> <div class="select-wrap select-wrap1"> <div class="select radius drop-down LanguageType" drop-down>中文→西班牙语</i></div> <div class="select-con undis"> <ul> <li><a href="javascript:;">中文→英语</a></li> <li><a href="javascript:;">中文→日语</a></li> <li><a href="javascript:;">中文→韩语</a></li> </ul> </div> </div> <div class="select-wrap select-wrap2"> <div class="select radius drop-down selectType" drop-down>口译</i></div> <div class="select-con undis"> <ul> <li><a href="javascript:;">口译</a></li> <li><a href="javascript:;">笔译</a></li> </ul> </div> </div> <input type="text" class="int-text int-mini radius input1 inputPrice" id="ok"> <span class="unit" >元/千字</span> <p class="edit-chose"> <span class="txt4" ok></span> <span class="txt5" clear></span> </p> </li> </ul> </div>'); 
    $('.inputexit').before(edit)

    $(document).on('click','[clear]',function(){
       $('.addLanguage').remove();
    })
    $(document).on('click','[ok]',function(){
      $('.inputContainer').find(id).remove()
    })
  })
  //删除当前翻译语言
  $(document).on('click','[confirm-step2-language]',function(ev){
    var parent = $(this);
    var delettedNodeNum=parent.attr('name');
    $('#confirm-step2-language-mask').fadeIn(100);
    $('#confirm-step2-language').slideDown(100);
    // })
    //点击确认
    $('#confirm-step2-language-confirm').click(function(){
      $('#confirm-step2-language-mask').fadeOut(200);
      $('#confirm-step2-language').slideUp(200);
      var child = $(this);
      var cla=".inputp"+delettedNodeNum;
      $('.inputContainer').find(cla).remove();
    })
    //点击取消
    $('#confirm-step2-language-cancel').click(function(){
      $('#confirm-step2-language-mask').fadeOut(200);
      $('#confirm-step2-language').slideUp(200);
    })

  })
  
  //添加教育背景效果
  $(document).on('click','[add-educate]',function(){
    var text1 = $(' <div class="educate quesbox"> <ul class="quesbox-wrap"> <li class="mb10"> <div class="select-wrap select-wrap1 mr30"> <div class="select radius drop-down select-col" drop-down="">北京大学</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">北京大学</a></li> <li><a href="javascript:;">天津大学</a></li> <li><a href="javascript:;">南京大学</a></li> </ul> </div> </div> <div class="select-wrap select-wrap2 mr30"> <div class="select radius drop-down select-deg" drop-down="">本科</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">本科</a></li> <li><a href="javascript:;">大专</a></li> <li><a href="javascript:;">硕士</a></li> </ul> </div> </div> <div class="select-input"> <label for="class-name">专业名称</label> <input type="text" class="int-text int-mini radius input-maj" id="class-name"/> </div> </li> <li class="mb10"> <div class="select-wrap mr10"> <div class="select radius drop-down coutry" drop-down="">中国</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">中国</a></li> </ul> </div> </div> <div class="select-wrap mr10"> <div class="select radius drop-down province" drop-down="">北京</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">北京</a></li> <li><a href="javascript:;">天津</a></li> </ul> </div> </div> <div class="select-wrap"> <div class="select radius drop-down city" drop-down="">北京市</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">北京市</a></li> <li><a href="javascript:;">天津市</a></li> </ul> </div> </div> <span class="posi-title">地址：</span> </li> <li class="address-input mb10"> <input type="text" class="int-text int-mini radius address" placeholder="详细地址"/> </li> <li> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down yearStart" drop-down="">2010</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">2010</a></li> <li><a href="javascript:;">2011</a></li> <li><a href="javascript:;">2012</a></li> <li><a href="javascript:;">2013</a></li> </ul> </div> </div> <span class="unit mr10">年</span> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down monthStart" drop-down="">09</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">01</a></li> <li><a href="javascript:;">02</a></li> <li><a href="javascript:;">03</a></li> <li><a href="javascript:;">04</a></li> <li><a href="javascript:;">05</a></li> <li><a href="javascript:;">06</a></li> <li><a href="javascript:;">07</a></li> <li><a href="javascript:;">08</a></li> <li><a href="javascript:;">09</a></li> <li><a href="javascript:;">10</a></li> <li><a href="javascript:;">11</a></li> <li><a href="javascript:;">12</a></li> </ul> </div> </div> <span class="unit mr20">月</span> <span class="unit mr20">至</span> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down yearEnd" drop-down="">2010</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">2010</a></li> <li><a href="javascript:;">2011</a></li> <li><a href="javascript:;">2012</a></li> <li><a href="javascript:;">2013</a></li> </ul> </div> </div> <span class="unit mr10">年</span> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down monthEnd" drop-down="">09</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">01</a></li> <li><a href="javascript:;">02</a></li> <li><a href="javascript:;">03</a></li> <li><a href="javascript:;">04</a></li> <li><a href="javascript:;">05</a></li> <li><a href="javascript:;">06</a></li> <li><a href="javascript:;">07</a></li> <li><a href="javascript:;">08</a></li> <li><a href="javascript:;">09</a></li> <li><a href="javascript:;">10</a></li> <li><a href="javascript:;">11</a></li> <li><a href="javascript:;">12</a></li> </ul> </div> </div> <span class="unit">月</span> <span class="posi-title">时间：</span> <p class="edit-chose"> <span class="txt4" add-edu-ok></span> <span class="txt5" add-edu-clear></span> </p> </li> </ul> </div>'); 
    //每次只能添加一个编辑项目
      if(!$(this).parent('.value').find('[add-program] .quesbox').length>0){
        $(this).siblings('[add-program]').append(text1);
      }
      return false;
  });
    //确认添加教育背景
    $(document).on('click','[add-edu-ok]',function(){
      //地址信息
      var college = $('.educate').find('.select-col').html()//选择学校名称
      var degree = $('.educate').find('.select-deg').html()//选择学位名称
      var major = $('.educate').find('.input-maj').val()//获取专业名称
      var coutry = $('.educate').find('.coutry').html()//选择国家名称
      var province =$('.educate').find('.province').html()//选择省份名称
      var city = $('.educate').find('.city').html()//选择城市名称
      var address = $('.educate').find('.address').val()//获取详细地址
      //时间信息
      var yearStart= $('.educate').find('.yearStart').html()//选择开始年份
      var monthStart= $('.educate').find('.monthStart').html()//选择开始月份
      var yearEnd = $('.educate').find('.yearEnd').html()//选择结束年份
      var monthEnd= $('.educate').find('.monthEnd').html()//选择结束月份

      var text =$( "<p class=inputp"+num+"><span class='txt3'>"+college+"</span><span class='txt3'>"+yearStart+'/'+monthStart+'-'+yearEnd+'/'+monthEnd+"</span><span>"+degree+"</span><input type='button' class='btn biu-btn btn-auto-25 btn-red radius10' name="+id+" value='删 除' confirm-step2-educate><input type='button' class='btn biu-btn btn-auto-25 btn-green radius10' name=1."+id+" value='编 辑' editBtnEdu></p>" )
      num+=1;
      id+=1;
      $('.exit2').before(text)
      $('.educate.quesbox').remove()

    })
    //取消添加教育背景
    $(document).on('click','[add-edu-clear]',function(){
      console.log('取消');
    $('.educate.quesbox').remove();
    })
    //编辑当前教育背景
    $(document).on('click','[editBtnEdu]',function(){
      var delettedNodeNum=$(this).attr('name').substr(2)//处理'编辑'对应的id 取尾数
      var id =".inputp"+delettedNodeNum;
      // $('.eduContainer').find(id).remove()
      var edit = $(' <div class="educate quesbox"> <ul class="quesbox-wrap"> <li class="mb10"> <div class="select-wrap select-wrap1 mr30"> <div class="select radius drop-down select-col" drop-down="">北京大学</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">北京大学</a></li> <li><a href="javascript:;">天津大学</a></li> <li><a href="javascript:;">南京大学</a></li> </ul> </div> </div> <div class="select-wrap select-wrap2 mr30"> <div class="select radius drop-down select-deg" drop-down="">本科</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">本科</a></li> <li><a href="javascript:;">大专</a></li> <li><a href="javascript:;">硕士</a></li> </ul> </div> </div> <div class="select-input"> <label for="class-name">专业名称</label> <input type="text" class="int-text int-mini radius input-maj" id="class-name"/> </div> </li> <li class="mb10"> <div class="select-wrap mr10"> <div class="select radius drop-down coutry" drop-down="">中国</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">中国</a></li> </ul> </div> </div> <div class="select-wrap mr10"> <div class="select radius drop-down province" drop-down="">北京</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">北京</a></li> <li><a href="javascript:;">天津</a></li> </ul> </div> </div> <div class="select-wrap"> <div class="select radius drop-down city" drop-down="">北京市</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">北京市</a></li> <li><a href="javascript:;">天津市</a></li> </ul> </div> </div> <span class="posi-title">地址：</span> </li> <li class="address-input mb10"> <input type="text" class="int-text int-mini radius address" placeholder="详细地址"/> </li> <li> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down yearStart" drop-down="">2010</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">2010</a></li> <li><a href="javascript:;">2011</a></li> <li><a href="javascript:;">2012</a></li> <li><a href="javascript:;">2013</a></li> </ul> </div> </div> <span class="unit mr10">年</span> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down monthStart" drop-down="">09</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">01</a></li> <li><a href="javascript:;">02</a></li> <li><a href="javascript:;">03</a></li> <li><a href="javascript:;">04</a></li> <li><a href="javascript:;">05</a></li> <li><a href="javascript:;">06</a></li> <li><a href="javascript:;">07</a></li> <li><a href="javascript:;">08</a></li> <li><a href="javascript:;">09</a></li> <li><a href="javascript:;">10</a></li> <li><a href="javascript:;">11</a></li> <li><a href="javascript:;">12</a></li> </ul> </div> </div> <span class="unit mr20">月</span> <span class="unit mr20">至</span> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down yearEnd" drop-down="">2010</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">2010</a></li> <li><a href="javascript:;">2011</a></li> <li><a href="javascript:;">2012</a></li> <li><a href="javascript:;">2013</a></li> </ul> </div> </div> <span class="unit mr10">年</span> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down monthEnd" drop-down="">09</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">01</a></li> <li><a href="javascript:;">02</a></li> <li><a href="javascript:;">03</a></li> <li><a href="javascript:;">04</a></li> <li><a href="javascript:;">05</a></li> <li><a href="javascript:;">06</a></li> <li><a href="javascript:;">07</a></li> <li><a href="javascript:;">08</a></li> <li><a href="javascript:;">09</a></li> <li><a href="javascript:;">10</a></li> <li><a href="javascript:;">11</a></li> <li><a href="javascript:;">12</a></li> </ul> </div> </div> <span class="unit">月</span> <span class="posi-title">时间：</span> <p class="edit-chose"> <span class="txt4" add-edu-ok></span> <span class="txt5" add-edu-clear-edit></span> </p> </li> </ul> </div>'); 
      $('.exit2').before(edit)

      $(document).on('click','[add-edu-clear-edit]',function(){
        console.log('取消编辑成功')
        $('.educate').remove();
      })
      $(document).on('click','[add-edu-ok]',function(){
       
        $('.eduContainer').find(id).remove()
        // $('.educate.quesbox').remove()
      })

    })  
    //删除当前教育背景
    $(document).on('click','[confirm-step2-educate]',function(){


    console.log('点击了删除')
    var parent = $(this);
    var delettedNodeNum=parent.attr('name');
    // console.log(delettedNodeNum);//拿到要删除的哪个元素的id
    // console.log(self.find('.input1-1'))
    // $('[confirm-step2-language]').click(function(){
    $('#confirm-step2-educate-mask').fadeIn(100);
    $('#confirm-step2-educate').slideDown(100);
    // })
    //点击确认
    $('#confirm-step2-educate-confirm').click(function(){
      $('#confirm-step2-educate-mask').fadeOut(200);
      $('#confirm-step2-educate').slideUp(200);
      var child = $(this);
      var cla=".inputp"+delettedNodeNum;
      // console.log(cla)
      // console.log($('.inputContainer').children())
      $('.eduContainer').find(cla).remove();
      // console.log(ev.target)
      // var re=$().find('[confirm-step2-language]');
    })
    //点击取消
    $('#confirm-step2-educate-cancel').click(function(){
      $('#confirm-step2-educate-mask').fadeOut(200);
      $('#confirm-step2-educate').slideUp(200);
    })


    })
   //添加工作经验
  $(document).on('click','[add-work]',function(){
    var text2 = $('<div class="educate work-expersise quesbox"> <ul class="quesbox-wrap"> <li class="mb10"> <div class="select-input mr20"> <input type="text" class="int-text int-mini radius companyName"/> </div> <div class="select-input"> <label for="work-name">职位名称：</label> <input type="text" class="int-text int-mini radius workName" id="work-name"/> </div> <span class="posi-title">企业名称：</span> </li> <li class="mb10"> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down yearStart" drop-down="">2010</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">2010</a></li> <li><a href="javascript:;">2011</a></li> <li><a href="javascript:;">2012</a></li> <li><a href="javascript:;">2013</a></li> </ul> </div> </div> <span class="unit mr10">年</span> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down monthStart" drop-down="">09</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">01</a></li> <li><a href="javascript:;">02</a></li> <li><a href="javascript:;">03</a></li> <li><a href="javascript:;">04</a></li> <li><a href="javascript:;">05</a></li> <li><a href="javascript:;">06</a></li> <li><a href="javascript:;">07</a></li> <li><a href="javascript:;">08</a></li> <li><a href="javascript:;">09</a></li> <li><a href="javascript:;">10</a></li> <li><a href="javascript:;">11</a></li> <li><a href="javascript:;">12</a></li> </ul> </div> </div> <span class="unit mr20">月</span> <span class="unit mr20">至</span> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down yearEnd" drop-down="">2010</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">2010</a></li> <li><a href="javascript:;">2011</a></li> <li><a href="javascript:;">2012</a></li> <li><a href="javascript:;">2013</a></li> </ul> </div> </div> <span class="unit mr10">年</span> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down monthEnd" drop-down="">09</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">01</a></li> <li><a href="javascript:;">02</a></li> <li><a href="javascript:;">03</a></li> <li><a href="javascript:;">04</a></li> <li><a href="javascript:;">05</a></li> <li><a href="javascript:;">06</a></li> <li><a href="javascript:;">07</a></li> <li><a href="javascript:;">08</a></li> <li><a href="javascript:;">09</a></li> <li><a href="javascript:;">10</a></li> <li><a href="javascript:;">11</a></li> <li><a href="javascript:;">12</a></li> </ul> </div> </div> <span class="unit">月</span> <span class="posi-title">在职时间：</span> </li> <li> <textarea class="int-text int-mini radius describe"></textarea> <span class="posi-title">职位描述：</span> <p class="edit-chose"> <span class="txt4" add-work-ok></span> <span class="txt5" add-work-clear></span> </p> </li> </ul> </div>'); 
    //每次只能添加一个编辑项目
      if(!$(this).parent('.value').find('[add-program] .quesbox').length>0){
        $(this).siblings('[add-program]').append(text2);
      }
      return false;
  });
  //确认添加工作经验
  $(document).on('click','[add-work-ok]',function(){
    var companyName=$('.work-expersise').find('.companyName').val()//获取企业名称
    var workName=$('.work-expersise').find('.workName').val()//获取职位名称
    var yearStart=$('.work-expersise').find('.yearStart').html()//选择开始年份
    var monthStart=$('.work-expersise').find('.monthStart').html()//选择开始月份
    var yearEnd=$('.work-expersise').find('.yearEnd').html()//选择结束年份
    var monthEnd=$('.work-expersise').find('.monthEnd').html()//选择结束月份
    var describe=$('.work-expersise').find('.describe').val()//获取职位描述
    // console.log(describe)
    var Time=yearEnd-yearStart;
    if(Time==0){//不足一年 算作一年
      Time=1
    }
    var text=$("<p class= inputp"+num+"><span class='txt3'>"+companyName+"</span><span class='txt3'>"+yearStart+'/'+monthStart+'-'+yearEnd+'/'+monthEnd+"</span><span><strong>"+Time+"</strong>年</span><input type='button' class='btn biu-btn btn-auto-25 btn-red radius10' name="+id+" value='删 除'' setting-save-btn1><input type='button' class='btn biu-btn btn-auto-25 btn-green radius10' name=1."+id+" value='编 辑' editBtnWork></p>")
    num+=1;
    id+=1;
    $('.exit3').before(text);
    $('.work-expersise').remove()
  })
  //取消添加工作经验
  $(document).on('click','[add-work-clear]',function(){
    $('.work-expersise').remove();
    })  
  //编辑工作经验
  $(document).on('click','[editBtnWork]',function(){
    var delettedNodeNum=$(this).attr('name').substr(2)//处理'编辑'对应的id 取尾数
    var id =".inputp"+delettedNodeNum;
    // console.log(id)
    // $('.workContainer').find(id).remove()
    // console.log($('.workContainer').find(id))
    var edit = $('<div class="educate work-expersise quesbox"> <ul class="quesbox-wrap"> <li class="mb10"> <div class="select-input mr20"> <input type="text" class="int-text int-mini radius companyName"/> </div> <div class="select-input"> <label for="work-name">职位名称：</label> <input type="text" class="int-text int-mini radius workName" id="work-name"/> </div> <span class="posi-title">企业名称：</span> </li> <li class="mb10"> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down yearStart" drop-down="">2010</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">2010</a></li> <li><a href="javascript:;">2011</a></li> <li><a href="javascript:;">2012</a></li> <li><a href="javascript:;">2013</a></li> </ul> </div> </div> <span class="unit mr10">年</span> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down monthStart" drop-down="">09</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">01</a></li> <li><a href="javascript:;">02</a></li> <li><a href="javascript:;">03</a></li> <li><a href="javascript:;">04</a></li> <li><a href="javascript:;">05</a></li> <li><a href="javascript:;">06</a></li> <li><a href="javascript:;">07</a></li> <li><a href="javascript:;">08</a></li> <li><a href="javascript:;">09</a></li> <li><a href="javascript:;">10</a></li> <li><a href="javascript:;">11</a></li> <li><a href="javascript:;">12</a></li> </ul> </div> </div> <span class="unit mr20">月</span> <span class="unit mr20">至</span> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down yearEnd" drop-down="">2010</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">2010</a></li> <li><a href="javascript:;">2011</a></li> <li><a href="javascript:;">2012</a></li> <li><a href="javascript:;">2013</a></li> </ul> </div> </div> <span class="unit mr10">年</span> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down monthEnd" drop-down="">09</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">01</a></li> <li><a href="javascript:;">02</a></li> <li><a href="javascript:;">03</a></li> <li><a href="javascript:;">04</a></li> <li><a href="javascript:;">05</a></li> <li><a href="javascript:;">06</a></li> <li><a href="javascript:;">07</a></li> <li><a href="javascript:;">08</a></li> <li><a href="javascript:;">09</a></li> <li><a href="javascript:;">10</a></li> <li><a href="javascript:;">11</a></li> <li><a href="javascript:;">12</a></li> </ul> </div> </div> <span class="unit">月</span> <span class="posi-title">在职时间：</span> </li> <li> <textarea class="int-text int-mini radius describe"></textarea> <span class="posi-title">职位描述：</span> <p class="edit-chose"> <span class="txt4" add-work-ok></span> <span class="txt5" add-work-clear-edit></span> </p> </li> </ul> </div>'); 
    $('.exit3').before(edit)

    $(document).on('click','[add-work-clear-edit]',function(){
      $('.work-expersise').remove();
    })
    $(document).on('click','[add-work-ok]',function(){
    $('.workContainer').find(id).remove()
    // $('.work-expersise').remove()
    })

  })
  //删除工作经验
  $(document).on('click','[setting-save-btn1]',function(){
    var parent = $(this);
    var delettedNodeNum=parent.attr('name');
    // console.log(delettedNodeNum);//拿到要删除的哪个元素的id
    // console.log(self.find('.input1-1'))
    // $('[confirm-step2-language]').click(function(){
    $('#setting-mask1').fadeIn(100);
    $('#setting-dialog1').slideDown(100);
    // })
    //点击确认
    $('#setting-save-confirm1').click(function(){
      $('#setting-mask1').fadeOut(200);
      $('#setting-dialog1').slideUp(200);
      var child = $(this);
      var cla=".inputp"+delettedNodeNum;
      $('.workContainer').find(cla).remove();
    })
    //点击取消
    $('#setting-sav-cancel1').click(function(){
      $('#setting-mask1').fadeOut(200);
      $('#setting-dialog1').slideUp(200);
    })
  })
  //添加证书
  $(document).on('click','[add-card]',function(){
    var text3 = $('<div class="educate work-expersise quesbox diploma"> <ul class="quesbox-wrap"> <li class="mb10"> <div class="select-input mr20"> <input type="text" class="int-text int-mini radius diplomaName"/> </div> <div class="select-input"> <label for="card-name">颁发证书机构：</label> <input type="text" class="int-text int-mini radius from" id="card-name"/> </div> <span class="posi-title">证书名称：</span> </li> <li class="mb10"> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down year" drop-down="">2010</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">2010</a></li> <li><a href="javascript:;">2011</a></li> <li><a href="javascript:;">2012</a></li> <li><a href="javascript:;">2013</a></li> </ul> </div> </div> <span class="unit mr10">年</span> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down month" drop-down="">09</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">01</a></li> <li><a href="javascript:;">02</a></li> <li><a href="javascript:;">03</a></li> <li><a href="javascript:;">04</a></li> <li><a href="javascript:;">05</a></li> <li><a href="javascript:;">06</a></li> <li><a href="javascript:;">07</a></li> <li><a href="javascript:;">08</a></li> <li><a href="javascript:;">09</a></li> <li><a href="javascript:;">10</a></li> <li><a href="javascript:;">11</a></li> <li><a href="javascript:;">12</a></li> </ul> </div> </div> <span class="unit mr20">月</span> <span class="posi-title">颁发日期：</span> </li> <li> <textarea class="int-text int-mini radius describe"></textarea> <span class="posi-title">证书概述：</span> <p class="edit-chose"> <span class="txt4" add-diploma-ok></span> <span class="txt5" add-diploma-clear></span> </p> </li> </ul> </div>'); 
    //每次只能添加一个编辑项目
      if(!$(this).parent('.value').find('[add-program] .quesbox').length>0){
        $(this).siblings('[add-program]').append(text3);
      }
      return false;
  });
  //确定添加证书
  $(document).on('click','[add-diploma-ok]',function(){
    console.log('被处罚了')
    var name=$('.diploma').find('.diplomaName').val()//获取证书名称
    var from=$('.diploma').find('.from').val()//获取证书颁发机构
    var year =$('.diploma').find('.year').html()//选择证书年份
    var month =$('.diploma').find('.month').html()//选择证书颁发月份
    var describe=$('.diploma').find('describe').val()//获取证书描述
    console.log(name)
    var text=$("<p class='inputp"+num+"'><span class='txt3'>"+name+"</span><span class='txt3'>"+year+'/'+month+"</span><span>"+from+"</span><input type='button' class='btn biu-btn btn-auto-25 btn-red radius10' name='"+id+"' value='删 除' setting-save-btn><input type='button' class='btn biu-btn btn-auto-25 btn-green radius10' name='1."+id+"' value='编 辑' editBtnDiploma></p>")
    num+=1;
    id+=1;
    $('.exit4').before(text)
    $('.diploma').remove();
  })
  //取消添加证书
  $(document).on('click','[add-diploma-clear]',function(){
      console.log('取消');
    $('.diploma').remove();
    })
  //编辑证书内容
  $(document).on('click','[editBtnDiploma]',function(){
    console.log('编辑')

    var delettedNodeNum=$(this).attr('name').substr(2)//处理'编辑'对应的id 取尾数
    var id =".inputp"+delettedNodeNum;
    
    var edit= $('<div class="educate work-expersise quesbox diploma"> <ul class="quesbox-wrap"> <li class="mb10"> <div class="select-input mr20"> <input type="text" class="int-text int-mini radius diplomaName"/> </div> <div class="select-input"> <label for="card-name">颁发证书机构：</label> <input type="text" class="int-text int-mini radius from" id="card-name"/> </div> <span class="posi-title">证书名称：</span> </li> <li class="mb10"> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down year" drop-down="">2010</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">2010</a></li> <li><a href="javascript:;">2011</a></li> <li><a href="javascript:;">2012</a></li> <li><a href="javascript:;">2013</a></li> </ul> </div> </div> <span class="unit mr10">年</span> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down month" drop-down="">09</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">01</a></li> <li><a href="javascript:;">02</a></li> <li><a href="javascript:;">03</a></li> <li><a href="javascript:;">04</a></li> <li><a href="javascript:;">05</a></li> <li><a href="javascript:;">06</a></li> <li><a href="javascript:;">07</a></li> <li><a href="javascript:;">08</a></li> <li><a href="javascript:;">09</a></li> <li><a href="javascript:;">10</a></li> <li><a href="javascript:;">11</a></li> <li><a href="javascript:;">12</a></li> </ul> </div> </div> <span class="unit mr20">月</span> <span class="posi-title">颁发日期：</span> </li> <li> <textarea class="int-text int-mini radius describe"></textarea> <span class="posi-title">证书概述：</span> <p class="edit-chose"> <span class="txt4" add-diploma-ok></span> <span class="txt5" add-diploma-clear-edit></span> </p> </li> </ul> </div>'); 
    $('.exit4').before(edit)
    // $('.diplomaContainer').find(id).remove()
    $(document).on('click','[add-diploma-clear-edit]',function(){
      console.log('取消编辑成功')
       $('.diploma').remove();
    })
    $(document).on('click','[add-diploma-ok]',function(){
      console.log('编辑成功')
      
      $('.diplomaContainer').find(id).remove()//移除原来的数据

    })

  })   
  //删除证书
  $(document).on('click','[setting-save-btn]',function(){
    console.log('点击了删除')
    var parent = $(this);
    var delettedNodeNum=parent.attr('name');
    // console.log(delettedNodeNum);//拿到要删除的哪个元素的id
    // console.log(self.find('.input1-1'))
    // $('[confirm-step2-language]').click(function(){
    $('#setting-mask').fadeIn(100);
    $('#setting-dialog').slideDown(100);
    // })
    //点击确认
    $('#setting-save-confirm').click(function(){
      $('#setting-mask').fadeOut(200);
      $('#setting-dialog').slideUp(200);
      var child = $(this);
      var cla=".inputp"+delettedNodeNum;
      $('.diplomaContainer').find(cla).remove();
    })
    //点击取消
    $('#setting-sav-cancel').click(function(){
      $('#setting-mask').fadeOut(200);
      $('#setting-dialog').slideUp(200);
    })
  })

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