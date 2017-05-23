$(function(){
  var num=3;//设置添加的翻译语言子元素个数的计数器
  var id=3;
  var langValue;//语言名称的dataValue值
  var typeValue;//翻译方式的dataValue值
 
  //添加语言的效果
  $(document).on('click','[add-languages]',function(){
    var text = $("<div class='edit quesbox addLanguage'> <ul class='quesbox-wrap addLanguage'> <li> <div class='select-wrap select-wrap1'> <div class='select radius drop-down LanguageType' drop-down dataValue="+langValue+">中文→西班牙语</i></div> <div class='select-con undis'> <ul> <li><a href='javascript:;' dataValue='1' selectA1>中文→英语</a></li> <li><a href='javascript:;' dataValue='2' selectA1>中文→日语</a></li> <li><a href='javascript:;' dataValue='3' selectA1>中文→韩语</a></li> </ul> </div> </div> <div class='select-wrap select-wrap2'> <div class='select radius drop-down selectType' drop-down dataValue="+typeValue+">口译</i></div> <div class='select-con undis'> <ul> <li><a href='javascript:;' dataValue='1' selectA2>口译</a></li> <li><a href='javascript:;' dataValue='2' selectA2>笔译</a></li> </ul> </div> </div> <input type='text' class='int-text int-mini radius input1 inputPrice' id='ok'> <span class='unit' >元/千字</span> <p class='edit-chose'> <span class='txt4' ok></span> <span class='txt5' clear></span> </p> </li> </ul> </div>"); 
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
    var clone=$( "<p class=inputp"+num+"><span class='txt1 inputLang'>"+input1+"</span>"+"<span class='txt2 inputType' >"+input2+"</span>"+"<span class='txt1 inputPrice'><strong>"+input3+"</strong>元/千字（参考价）</span>"+"<span>未测试</span>"+"<input type='button' class='btn biu-btn btn-auto-25 btn-red radius10' name="+id+" value='删 除' confirm-step2-language ><input type='button' class='btn biu-btn btn-auto-25 btn-green radius10' editBtnLang name=1."+id+" value='编 辑' "+"></p>" )
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
    var input1=$(this).parent().find(".inputLang").html()// 取得选项-1的值 语种
    var input2=$(this).parent().find(".inputType").html()//取得选项-2的值 口译或者笔译
    var input3=$(this).parent().find(".inputPrice").find('strong').html()//取得选项-3的值 价格
    // input1=1231;
    console.log(input3)
    var delettedNodeNum=$(this).attr('name').substr(2)//处理’编辑‘对应的id 取尾数
    var id = ".inputp"+delettedNodeNum;
    var langType = $(this).parent
    var edit = $("<div class='edit quesbox addLanguage'> <ul class='quesbox-wrap addLanguage'> <li> <div class='select-wrap select-wrap1'> <div class='select radius drop-down LanguageType' drop-down>"+input1+"</i></div> <div class='select-con undis'> <ul> <li><a href='javascript:;'>中文→英语</a></li> <li><a href='javascript:;'>中文→日语</a></li> <li><a href='javascript:;'>中文→韩语</a></li> </ul> </div> </div> <div class='select-wrap select-wrap2'> <div class='select radius drop-down selectType' drop-down>"+input2+"</i></div> <div class='select-con undis'> <ul> <li><a href='javascript:;'>口译</a></li> <li><a href='javascript:;'>笔译</a></li> </ul> </div> </div> <input type='text' class='int-text int-mini radius input1 inputPrice' id='ok' value="+input3+"> <span class='unit' >元/千字</span> <p class='edit-chose'> <span class='txt4' ok></span> <span class='txt5' clear></span> </p> </li> </ul> </div>"); 
    //每次只允许编辑一个选项
    if(!$(this).parents('.value').find('.addLanguage').length>0){

      //添加修改的内容
      $('.inputexit').before(edit)
      //禁用本栏目其他编辑按钮
      $(this).parents('.inputContainer').find('[editBtnLang]').attr("disabled",true);
    }
    // console.log($(this).parent('.value').find('[add-program] .quesbox').length>0)
    $(document).on('click','[clear]',function(){
       $('.addLanguage').remove();
       //取消其他按钮禁用
      $('[editBtnLang]').removeAttr("disabled");
    })
    $(document).on('click','[ok]',function(){
      $('.inputContainer').find(id).remove()
      //取消其他按钮禁用
      $('[editBtnLang]').removeAttr("disabled");
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
      $('.addLanguage').remove();
      //取消其他按钮禁用
      $('[editBtnLang]').removeAttr("disabled");
    })
    //点击取消
    $('#confirm-step2-language-cancel').click(function(){
      $('#confirm-step2-language-mask').fadeOut(200);
      $('#confirm-step2-language').slideUp(200);
    })

  })
  
  //添加教育背景效果
  $(document).on('click','[add-educate]',function(){
    var text1 = $(' <div class="educate quesbox"> <ul class="quesbox-wrap"> <li class="mb10"> <div class="select-wrap select-wrap1 mr30"> <div class="select-input" > <label for="class-name"></label> <input type="text" class="int-text int-mini radius input-maj select-col" id="class-name"/> <span class="posi-title">学校：</span></div>  </div> <div class="select-wrap select-wrap2 mr30"> <div class="select radius drop-down select-deg" drop-down="">本科</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">本科</a></li> <li><a href="javascript:;">大专</a></li> <li><a href="javascript:;">硕士</a></li> </ul> </div> </div> <div class="select-input"> <label for="class-name">专业名称</label> <input type="text" class="int-text int-mini radius input-maj" id="class-name"/> </div> </li> <li class="mb10"> <div class="select-wrap mr10"> <div class="select radius drop-down coutry" drop-down="">中国</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">中国</a></li> </ul> </div> </div> <div class="select-wrap mr10"> <div class="select radius drop-down province" drop-down="">北京</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">北京</a></li> <li><a href="javascript:;">天津</a></li> </ul> </div> </div> <div class="select-wrap"> <div class="select radius drop-down city" drop-down="">北京市</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">北京市</a></li> <li><a href="javascript:;">天津市</a></li> </ul> </div> </div> <span class="posi-title">地址：</span> </li> <li class="address-input mb10"> <input type="text" class="int-text int-mini radius address" placeholder="详细地址"/> </li> <li> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down yearStart" drop-down="">2010</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">2010</a></li> <li><a href="javascript:;">2011</a></li> <li><a href="javascript:;">2012</a></li> <li><a href="javascript:;">2013</a></li> </ul> </div> </div> <span class="unit mr10">年</span> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down monthStart" drop-down="">09</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">01</a></li> <li><a href="javascript:;">02</a></li> <li><a href="javascript:;">03</a></li> <li><a href="javascript:;">04</a></li> <li><a href="javascript:;">05</a></li> <li><a href="javascript:;">06</a></li> <li><a href="javascript:;">07</a></li> <li><a href="javascript:;">08</a></li> <li><a href="javascript:;">09</a></li> <li><a href="javascript:;">10</a></li> <li><a href="javascript:;">11</a></li> <li><a href="javascript:;">12</a></li> </ul> </div> </div> <span class="unit mr20">月</span> <span class="unit mr20">至</span> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down yearEnd" drop-down="">2010</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">2010</a></li> <li><a href="javascript:;">2011</a></li> <li><a href="javascript:;">2012</a></li> <li><a href="javascript:;">2013</a></li> </ul> </div> </div> <span class="unit mr10">年</span> <div class="select-wrap select-wrap2 mr10"> <div class="select radius drop-down monthEnd" drop-down="">09</div> <div class="select-con undis"> <ul> <li><a href="javascript:;">01</a></li> <li><a href="javascript:;">02</a></li> <li><a href="javascript:;">03</a></li> <li><a href="javascript:;">04</a></li> <li><a href="javascript:;">05</a></li> <li><a href="javascript:;">06</a></li> <li><a href="javascript:;">07</a></li> <li><a href="javascript:;">08</a></li> <li><a href="javascript:;">09</a></li> <li><a href="javascript:;">10</a></li> <li><a href="javascript:;">11</a></li> <li><a href="javascript:;">12</a></li> </ul> </div> </div> <span class="unit">月</span> <span class="posi-title">时间：</span> <p class="edit-chose"> <span class="txt4" add-edu-ok></span> <span class="txt5" add-edu-clear></span> </p> </li> </ul> </div>'); 
    //每次只能添加一个编辑项目
      if(!$(this).parent('.value').find('[add-program] .quesbox').length>0){
        $(this).siblings('[add-program]').append(text1);
      }
      return false;
  });
    //确认添加教育背景
    $(document).on('click','[add-edu-ok]',function(){
      //地址信息
      var college = $('.educate').find('.select-col').val()//选择学校名称
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

      var text =$( "<p class=inputp"+num+" data-major='"+major+"'+ data-coutry='"+coutry+"' data-province='"+province+"' data-city='"+city+"' data-address='"+address+"'><span class='txt3 inputCol'>"+college+"</span><span class='txt3 inputDate'>"+yearStart+'/'+monthStart+'-'+yearEnd+'/'+monthEnd+"</span><span class='inputDegree'>"+degree+"</span><input type='button' class='btn biu-btn btn-auto-25 btn-red radius10' name="+id+" value='删 除' confirm-step2-educate><input type='button' class='btn biu-btn btn-auto-25 btn-green radius10' name=1."+id+" value='编 辑' editBtnEdu></p>" )
      var which='.input'+id 
      num+=1;
      id+=1;
      
      $(which).attr('data-coutry',coutry)//存储添加的数据到p中的data-xxx属性
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
      // var i =$(this).parent().attr('class').slice(6)//获取id值 用于读取数据
      // var which="input"+i;
      // console.log(which);
       //地址信息
      // $(this).parent().attr('data-major',dataMajor)
      var college = $(this).parent().find('.inputCol').html()//选择学校名称
      var degree = $(this).parent().find('.inputDegree').html()//选择学位名称
      var major = $(this).parent().attr('data-major')//获取专业名称
      var coutry = $(this).parent().attr('data-coutry')//选择国家名称
      var province =$(this).parent().attr('data-province')//选择省份名称
      var city = $(this).parent().attr('data-city')//选择城市名称
      var address = $(this).parent().attr('data-address')//获取详细地址
      console.log(major)
      //时间信息
      var yearStart= $(this).parent().find('.inputDate').html().slice(0,4)//选择开始年份
      var monthStart= $(this).parent().find('.inputDate').html().slice(5,7)//选择开始月份
      var yearEnd = $(this).parent().find('.inputDate').html().slice(8,12)//选择结束年份
      var monthEnd= $(this).parent().find('.inputDate').html().slice(13)//选择结束月份
      console.log(monthEnd);
      var delettedNodeNum=$(this).attr('name').substr(2)//处理'编辑'对应的id 取尾数
      var id =".inputp"+delettedNodeNum;
      // $('.eduContainer').find(id).remove()
      var edit = $( "<div class='educate quesbox'> <ul class='quesbox-wrap'> <li class='mb10'> <div class='select-wrap select-wrap1 mr30'> <div class='select-input mr20' > <label for='class-name'></label> <input type='text' class='int-text int-mini radius input-maj select-col' id='class-name' value="+college+"><span class='posi-title'>学校：</span> </div> <div class='select-con undis'> <ul> <li><a href='javascript:;'>北京大学</a></li> <li><a href='javascript:;'>天津大学</a></li> <li><a href='javascript:;'>南京大学</a></li> </ul> </div> </div> <div class='select-wrap select-wrap2 mr30'> <div class='select radius drop-down select-deg' drop-down=''>"+degree+"</div> <div class='select-con undis'> <ul> <li><a href='javascript:;'>本科</a></li> <li><a href='javascript:;'>大专</a></li> <li><a href='javascript:;'>硕士</a></li> </ul> </div> </div> <div class='select-input'> <label for='class-name'>专业名称</label> <input type='text' class='int-text int-mini radius input-maj' id='class-name' value="+major+"> </div> </li> <li class='mb10'> <div class='select-wrap mr10'> <div class='select radius drop-down coutry' drop-down=''>"+coutry+"</div> <div class='select-con undis'> <ul> <li><a href='javascript:;'>中国</a></li> </ul> </div> </div> <div class='select-wrap mr10'> <div class='select radius drop-down province' drop-down=''>"+province+"</div> <div class='select-con undis'> <ul> <li><a href='javascript:;'>北京</a></li> <li><a href='javascript:;'>天津</a></li> </ul> </div> </div> <div class='select-wrap'> <div class='select radius drop-down city' drop-down=''>"+city+"</div> <div class='select-con undis'> <ul> <li><a href='javascript:;'>北京市</a></li> <li><a href='javascript:;'>天津市</a></li> </ul> </div> </div> <span class='posi-title'>地址：</span> </li> <li class='address-input mb10'> <input type='text' class='int-text int-mini radius address' placeholder='详细地址' value="+address+"> </li> <li> <div class='select-wrap select-wrap2 mr10'> <div class='select radius drop-down yearStart' drop-down=''>"+yearStart+"</div> <div class='select-con undis'> <ul> <li><a href='javascript:;'>2010</a></li> <li><a href='javascript:;'>2011</a></li> <li><a href='javascript:;'>2012</a></li> <li><a href='javascript:;'>2013</a></li> </ul> </div> </div> <span class='unit mr10'>年</span> <div class='select-wrap select-wrap2 mr10'> <div class='select radius drop-down monthStart' drop-down=''>"+monthStart+"</div> <div class='select-con undis'> <ul> <li><a href='javascript:;'>01</a></li> <li><a href='javascript:;'>02</a></li> <li><a href='javascript:;'>03</a></li> <li><a href='javascript:;'>04</a></li> <li><a href='javascript:;'>05</a></li> <li><a href='javascript:;'>06</a></li> <li><a href='javascript:;'>07</a></li> <li><a href='javascript:;'>08</a></li> <li><a href='javascript:;'>09</a></li> <li><a href='javascript:;'>10</a></li> <li><a href='javascript:;'>11</a></li> <li><a href='javascript:;'>12</a></li> </ul> </div> </div> <span class='unit mr20'>月</span> <span class='unit mr20'>至</span> <div class='select-wrap select-wrap2 mr10'> <div class='select radius drop-down yearEnd' drop-down=''>"+yearEnd+"</div> <div class='select-con undis'> <ul> <li><a href='javascript:;'>2010</a></li> <li><a href='javascript:;'>2011</a></li> <li><a href='javascript:;'>2012</a></li> <li><a href='javascript:;'>2013</a></li> </ul> </div> </div> <span class='unit mr10'>年</span> <div class='select-wrap select-wrap2 mr10'> <div class='select radius drop-down monthEnd' drop-down=''>"+monthEnd+"</div> <div class='select-con undis'> <ul> <li><a href='javascript:;'>01</a></li> <li><a href='javascript:;'>02</a></li> <li><a href='javascript:;'>03</a></li> <li><a href='javascript:;'>04</a></li> <li><a href='javascript:;'>05</a></li> <li><a href='javascript:;'>06</a></li> <li><a href='javascript:;'>07</a></li> <li><a href='javascript:;'>08</a></li> <li><a href='javascript:;'>09</a></li> <li><a href='javascript:;'>10</a></li> <li><a href='javascript:;'>11</a></li> <li><a href='javascript:;'>12</a></li> </ul> </div> </div> <span class='unit'>月</span> <span class='posi-title'>时间：</span> <p class='edit-chose'> <span class='txt4' add-edu-ok></span> <span class='txt5' add-edu-clear-edit></span> </p> </li> </ul> </div>"); 
      //每次只允许编辑一个项目
      if(!$(this).parents('.value').find('.quesbox').length>0){
        $('.exit2').before(edit)
        //禁用本栏目其他编辑按钮
        $(this).parents('.eduContainer').find('[editBtnEdu]').attr("disabled",true);
      }

      $(document).on('click','[add-edu-clear-edit]',function(){
        console.log('取消编辑成功')
        $('.educate').remove();
         //取消其他按钮禁用
        $('[editBtnEdu]').removeAttr("disabled");
      })
      $(document).on('click','[add-edu-ok]',function(){
       
        $('.eduContainer').find(id).remove()
         //取消其他按钮禁用
        $('[editBtnEdu]').removeAttr("disabled");
      })

    })  
    //删除当前教育背景
    $(document).on('click','[confirm-step2-educate]',function(){
    var parent = $(this);
    var delettedNodeNum=parent.attr('name');
    $('#confirm-step2-educate-mask').fadeIn(100);
    $('#confirm-step2-educate').slideDown(100);
    // })
    //点击确认
    $('#confirm-step2-educate-confirm').click(function(){
      $('#confirm-step2-educate-mask').fadeOut(200);
      $('#confirm-step2-educate').slideUp(200);
      var child = $(this);
      var cla=".inputp"+delettedNodeNum;
      $('.eduContainer').find(cla).remove();
      $('.educate').remove();
      //取消其他按钮禁用
      $('[editBtnEdu]').removeAttr("disabled");
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
    if(Time<=0){//不足一年 算作一年
      Time=1
    }
    var text=$("<p class= inputp"+num+"><span class='txt3 inputComName'>"+companyName+"</span><span class='txt3 inputDate'>"+yearStart+'/'+monthStart+'-'+yearEnd+'/'+monthEnd+"</span><span class='inputTime'><strong>"+Time+"</strong>年</span><input type='button' class='btn biu-btn btn-auto-25 btn-red radius10' name="+id+" value='删 除'' setting-save-btn1><input type='button' class='btn biu-btn btn-auto-25 btn-green radius10' name=1."+id+" value='编 辑' editBtnWork></p>")
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
    var companyName=$(this).parent().find('.inputComName').html()//获取企业名称
    var workName='职位名称'//获取职位名称
    var yearStart=$(this).parent().find('.inputDate').html().slice(0,4)//选择开始年份
    var monthStart=$(this).parent().find('.inputDate').html().slice(5,7)//选择开始月份
    var yearEnd=$(this).parent().find('.inputDate').html().slice(8,12)//选择结束年份
    var monthEnd=$(this).parent().find('.inputDate').html().slice(13)//选择结束月份
    console.log(yearEnd)
    var describe='职位描述'//获取职位描述
    var delettedNodeNum=$(this).attr('name').substr(2)//处理'编辑'对应的id 取尾数
    var id =".inputp"+delettedNodeNum;
    var edit = $("<div class='educate work-expersise quesbox'> <ul class='quesbox-wrap'> <li class='mb10'> <div class='select-input mr20'> <input type='text' class='int-text int-mini radius companyName' value="+companyName+"> </div> <div class='select-input'> <label for='work-name'>职位名称：</label> <input type='text' class='int-text int-mini radius workName' id='work-name' value="+workName+"> </div> <span class='posi-title'>企业名称：</span> </li> <li class='mb10'> <div class='select-wrap select-wrap2 mr10'> <div class='select radius drop-down yearStart' drop-down=''>"+yearStart+"</div> <div class='select-con undis'> <ul> <li><a href='javascript:;'>2010</a></li> <li><a href='javascript:;'>2011</a></li> <li><a href='javascript:;'>2012</a></li> <li><a href='javascript:;'>2013</a></li> </ul> </div> </div> <span class='unit mr10'>年</span> <div class='select-wrap select-wrap2 mr10'> <div class='select radius drop-down monthStart' drop-down=''>"+monthStart+"</div> <div class='select-con undis'> <ul> <li><a href='javascript:;'>01</a></li> <li><a href='javascript:;'>02</a></li> <li><a href='javascript:;'>03</a></li> <li><a href='javascript:;'>04</a></li> <li><a href='javascript:;'>05</a></li> <li><a href='javascript:;'>06</a></li> <li><a href='javascript:;'>07</a></li> <li><a href='javascript:;'>08</a></li> <li><a href='javascript:;'>09</a></li> <li><a href='javascript:;'>10</a></li> <li><a href='javascript:;'>11</a></li> <li><a href='javascript:;'>12</a></li> </ul> </div> </div> <span class='unit mr20'>月</span> <span class='unit mr20'>至</span> <div class='select-wrap select-wrap2 mr10'> <div class='select radius drop-down yearEnd' drop-down='' >"+yearEnd+"</div> <div class='select-con undis'> <ul> <li><a href='javascript:;'>2010</a></li> <li><a href='javascript:;'>2011</a></li> <li><a href='javascript:;'>2012</a></li> <li><a href='javascript:;'>2013</a></li> </ul> </div> </div> <span class='unit mr10'>年</span> <div class='select-wrap select-wrap2 mr10'> <div class='select radius drop-down monthEnd' drop-down=''>"+monthEnd+"</div> <div class='select-con undis'> <ul> <li><a href='javascript:;'>01</a></li> <li><a href='javascript:;'>02</a></li> <li><a href='javascript:;'>03</a></li> <li><a href='javascript:;'>04</a></li> <li><a href='javascript:;'>05</a></li> <li><a href='javascript:;'>06</a></li> <li><a href='javascript:;'>07</a></li> <li><a href='javascript:;'>08</a></li> <li><a href='javascript:;'>09</a></li> <li><a href='javascript:;'>10</a></li> <li><a href='javascript:;'>11</a></li> <li><a href='javascript:;'>12</a></li> </ul> </div> </div> <span class='unit'>月</span> <span class='posi-title'>在职时间：</span> </li> <li> <textarea class='int-text int-mini radius describe'>"+describe+"</textarea> <span class='posi-title'>职位描述：</span> <p class='edit-chose'> <span class='txt4' add-work-ok></span> <span class='txt5' add-work-clear-edit></span> </p> </li> </ul> </div>"); 
    //每次只允许编辑一个项目
    if(!$(this).parents('.value').find('.work-expersise').length>0){
        $('.exit3').before(edit)
        //禁用本栏目其他编辑按钮
        $(this).parents('.workContainer').find('[editBtnWork]').attr("disabled",true);
    }

    $(document).on('click','[add-work-clear-edit]',function(){
      $('.work-expersise').remove();
       //取消其他按钮禁用
      $('[editBtnWork]').removeAttr("disabled");
    })
    $(document).on('click','[add-work-ok]',function(){
    $('.workContainer').find(id).remove()
    // $('.work-expersise').remove()
     //取消其他按钮禁用
      $('[editBtnWork]').removeAttr("disabled");
    })

  })
  //删除工作经验
  $(document).on('click','[setting-save-btn1]',function(){
    var parent = $(this);
    var delettedNodeNum=parent.attr('name');
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
      $('.work-expersise').remove();
      //取消其他按钮禁用
      $('[editBtnLang]').removeAttr("disabled");
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
    var name=$('.diploma').find('.diplomaName').val()//获取证书名称
    var from=$('.diploma').find('.from').val()//获取证书颁发机构
    var year =$('.diploma').find('.year').html()//选择证书年份
    var month =$('.diploma').find('.month').html()//选择证书颁发月份
    var describe=$('.diploma').find('describe').val()//获取证书描述
    console.log(name)
    var text=$("<p class='inputp"+num+"'><span class='txt3 inputName'>"+name+"</span><span class='txt3 inputDate'>"+year+'/'+month+"</span><span class='inputCol'>"+from+"</span><input type='button' class='btn biu-btn btn-auto-25 btn-red radius10' name='"+id+"' value='删 除' setting-save-btn><input type='button' class='btn biu-btn btn-auto-25 btn-green radius10' name='1."+id+"' value='编 辑' editBtnDiploma></p>")
    num+=1;
    id+=1;
    $('.exit4').before(text)
    $('.diploma').remove();
  })
  //取消添加证书
  $(document).on('click','[add-diploma-clear]',function(){
    $('.diploma').remove();
    })
  //编辑证书内容
  $(document).on('click','[editBtnDiploma]',function(){
    var name=$(this).parent().find('.inputName').html()//获取证书名称
    var from=$(this).parent().find('.inputCol').html()//获取证书颁发机构
    var year =$(this).parent().find('.inputDate').html().slice(0,4)//选择证书年份
    var month =$(this).parent().find('.inputDate').html().slice(5,7)//选择证书颁发月份
    var describe="证书描述"//获取证书描述
    console.log(month)

    var delettedNodeNum=$(this).attr('name').substr(2)//处理'编辑'对应的id 取尾数
    var id =".inputp"+delettedNodeNum;
    
    var edit= $("<div class='educate work-expersise quesbox diploma'> <ul class='quesbox-wrap'> <li class='mb10'> <div class='select-input mr20'> <input type='text' class='int-text int-mini radius diplomaName' value="+name+"> </div> <div class='select-input'> <label for='card-name'>颁发证书机构：</label> <input type='text' class='int-text int-mini radius from' id='card-name' value="+from+"> </div> <span class='posi-title'>证书名称：</span> </li> <li class='mb10'> <div class='select-wrap select-wrap2 mr10'> <div class='select radius drop-down year' drop-down=''>"+year+"</div> <div class='select-con undis'> <ul> <li><a href='javascript:;'>2010</a></li> <li><a href='javascript:;'>2011</a></li> <li><a href='javascript:;'>2012</a></li> <li><a href='javascript:;'>2013</a></li> </ul> </div> </div> <span class='unit mr10'>年</span> <div class='select-wrap select-wrap2 mr10'> <div class='select radius drop-down month' drop-down=''>"+month+"</div> <div class='select-con undis'> <ul> <li><a href='javascript:;'>01</a></li> <li><a href='javascript:;'>02</a></li> <li><a href='javascript:;'>03</a></li> <li><a href='javascript:;'>04</a></li> <li><a href='javascript:;'>05</a></li> <li><a href='javascript:;'>06</a></li> <li><a href='javascript:;'>07</a></li> <li><a href='javascript:;'>08</a></li> <li><a href='javascript:;'>09</a></li> <li><a href='javascript:;'>10</a></li> <li><a href='javascript:;'>11</a></li> <li><a href='javascript:;'>12</a></li> </ul> </div> </div> <span class='unit mr20'>月</span> <span class='posi-title'>颁发日期：</span> </li> <li> <textarea class='int-text int-mini radius describe' >"+describe+"</textarea> <span class='posi-title'>证书概述：</span> <p class='edit-chose'> <span class='txt4' add-diploma-ok></span> <span class='txt5' add-diploma-clear-edit></span> </p> </li> </ul> </div>"); 
    //  每次只允许编辑一个项目
    if(!$(this).parents('.value').find('.diploma').length>0){
      $('.exit4').before(edit)
      //禁用本栏目其他编辑按钮
      $(this).parents('.diplomaContainer').find('[editBtnDiploma]').attr("disabled",true);
    }
    // $('.diplomaContainer').find(id).remove()
    $(document).on('click','[add-diploma-clear-edit]',function(){
      console.log('取消编辑成功')
      $('.diploma').remove();
      //取消其他按钮禁用
      $('[editBtnDiploma]').removeAttr("disabled");
    })
    $(document).on('click','[add-diploma-ok]',function(){
      console.log('编辑成功')
      $('.diplomaContainer').find(id).remove()//移除原来的数据
       //取消其他按钮禁用
      $('[editBtnDiploma]').removeAttr("disabled");
    })

  })   
  //删除证书
  $(document).on('click','[setting-save-btn]',function(){
    console.log('点击了删除')
    var parent = $(this);
    var delettedNodeNum=parent.attr('name');

    $('#setting-mask').fadeIn(100);
    $('#setting-dialog').slideDown(100);
    //点击确认
    $('#setting-save-confirm').click(function(){
      $('#setting-mask').fadeOut(200);
      $('#setting-dialog').slideUp(200);
      var child = $(this);
      var cla=".inputp"+delettedNodeNum;
      $('.diplomaContainer').find(cla).remove();
      $('.diploma').remove();
      //取消其他按钮禁用
      $('[editBtnLang]').removeAttr("disabled");
    })
    //点击取消
    $('#setting-sav-cancel').click(function(){
      $('#setting-mask').fadeOut(200);
      $('#setting-dialog').slideUp(200);
    })
  })
 
});