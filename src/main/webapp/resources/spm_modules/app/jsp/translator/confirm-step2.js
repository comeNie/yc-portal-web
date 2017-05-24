var languages = ""
var addLanguage = new Array();
var addEducation = new Array();
var addwork = new Array();
var addcard = new Array();
var country = "";
var province = "";
var cnCity="";
var countryCode = "";
var provinceCode = "";
var cityCode = "";
var curLanguage = "";
var translatorTypeInterpret = translatorInfoMsg.interpret;
var translatorTypeTranslate = translatorInfoMsg.translate;
var priceUnit = translatorInfoMsg.priceUnit;
var deleteButton = translatorInfoMsg.deleteButton;
var editButton = translatorInfoMsg.editButton;
var eduspecialty = translatorInfoMsg.eduspecialty;
var edumaster = translatorInfoMsg.edumaster;
var eduundergraduate = translatorInfoMsg.eduspecialty;
var majorname = translatorInfoMsg.majorname;
var address = translatorInfoMsg.address;
var detailaddress = translatorInfoMsg.detailaddress;
var time = translatorInfoMsg.time;
var year = translatorInfoMsg.year;
var month = translatorInfoMsg.month;
var to = translatorInfoMsg.to;
var positionname = translatorInfoMsg.positionname;
var companyname = translatorInfoMsg.companyname;
var incumbencytime = translatorInfoMsg.incumbencytime;
var positiondescription = translatorInfoMsg.positiondescription;
var certificateauthority = translatorInfoMsg.certificateauthority;
var issuedate = translatorInfoMsg.issuedate;
var certificateoverview = translatorInfoMsg.certificateoverview;
var certificatename = translatorInfoMsg.certificatename;
$(function(){
  var num=0;//设置添加的翻译语言子元素个数的计数器
  var id=0;
  //添加语言的效果
  $(document).on('click','[add-languages]',function(){
    var text = $('<div class="edit quesbox addLanguage">'+
    				'<ul class="quesbox-wrap addLanguage">'+
    		     		'<li>'+
	    		     		'<select class="select select-in-small translatorType" onchange="loadLanguage(this.value)">'+
	    		     			'<option value="1">'+translatorTypeInterpret+'</option>'+
			     				'<option value="2" selected>'+translatorTypeTranslate+'</option>'+
			     			'</select>&nbsp;&nbsp;'+
		    		     	'<select  class="select select-in-small LanguageType" id="languageId">'+
		    		     		languages+
		    		     	'</select>&nbsp;&nbsp;'+
	    		     	 '<span class="ash" id="languageText"></span></label>'+
	    		     	 '<input type="text" class="int-text int-mini radius inputPrice" style="height:45px" id="ok">'+
	    		     	 '<span >'+priceUnit+'</span>&nbsp;&nbsp;&nbsp;&nbsp;'+
	    		     	 '<span id="languageErrMsg" style="display: none;"/>'+
						 '<p class="edit-chose">'+
						   '<span class="txt4" ok></span>'+
						   '<span class="txt5" clear></span>'+
						 '</p>'+
						 '</li>'+
						 '</ul>'+
					'</div>'); 
      
      //每次只能添加一个编辑项目
      if(!$(this).parent('.value').find('[add-program] .quesbox').length>0){
        $(this).siblings('[add-program]').append(text);
      }
      loadLanguage("2");
      return false;
  });
  //确定添加语言
  $(document).on('click','[ok]',function(){
    var input1=$('.addLanguage').find(".LanguageType").val()// 取得选项-1的值 语种
    var lanValue = $('.addLanguage').find(".LanguageType").find("option:selected").html();
    var input2=$('.addLanguage').find(".translatorType").val()//取得选项-2的值 口译或者笔译
    var translatorTypeValue = $('.addLanguage').find(".translatorType").find("option:selected").html();
    var input3=$('.addLanguage').find(".inputPrice").val()//取得选项-3的值 价格
    var reg = /^\d{1,10}$/;
    if(input3==""||input3==null){
    	$("#languageErrMsg").show().html(translatorInfoMsg.languageprivceempty);
    	return;
    }else{
    	if(!reg.test(input3)){
    		$("#languageErrMsg").show().html(translatorInfoMsg.languageprivcenumber);
        	return;
    	}else{
    		$("#languageErrMsg").hide();
    	}
    }
    var clone = "";
    if(input2=="2"){
    	clone=$( "<p class=inputp"+num+"><span class='txt1 input12'>"+lanValue+"</span>"+"<span class='txt2 input13' >"+translatorTypeValue+"</span>"+"<span class='txt1 input14'><strong>"+input3+"</strong>元/千字（参考价）</span>"+
    	    		"<span>translatorInfoMsg.didnottest</span>"+
    	    		"<input type='button' class='btn biu-btn btn-auto-25 btn-red radius10' name="+id+" value='"+deleteButton+"' confirm-step2-language >"+
    	    		"<input type='button' class='btn biu-btn btn-auto-25 btn-green radius10' editBtnLang name=1."+id+" value='"+editButton+"' "+"></p>" )
    }else{
   	    clone=$( "<p class=inputp"+num+"><span class='txt1 input12'>"+lanValue+"</span>"+"<span class='txt2 input13' >"+translatorTypeValue+"</span>"+"<span class='txt1 input14'><strong>"+input3+"</strong>元/千字（参考价）</span>"+
	    		"<input type='button' class='btn biu-btn btn-auto-25 btn-red radius10' name="+id+" value='"+deleteButton+"' confirm-step2-language >"+
	    		"<input type='button' class='btn biu-btn btn-auto-25 btn-green radius10' editBtnLang name=1."+id+" value='"+editButton+"' "+"></p>" )
    }
    $('.inputexit').before(clone);
    addLanguage[num] = "{"+"'duadId':"+"'"+input1+"',"+"'translationType':"+"'"+input2+"',"+"'referencePrice':"+input3+"}";
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
      addLanguage.splice(parseInt(delettedNodeNum),1);
    })
    //点击取消
    $('#confirm-step2-language-cancel').click(function(){
      $('#confirm-step2-language-mask').fadeOut(200);
      $('#confirm-step2-language').slideUp(200);
    })

  })
  
  //添加教育背景效果
  $(document).on('click','[add-educate]',function(){
	var provinceInfo = $("#provinceInfo").val();
	loadAllCountry();
	getProviceValue("3385");
	getCnCityValue("0");
	var curY = (new Date() ).getFullYear();
	var yoption = "";
    for(var i = 0; i <= curY - 1930; i++) {
    	var year = 1930+i;
    	if(year==2017){
    		yoption = yoption+"<option selected>"+year+"</option>";            
    	}else{
    		yoption = yoption+"<option>"+year+"</option>"; 
    	}
    }
    var text1 = $('<div class="educate quesbox">'+
    				'<ul class="quesbox-wrap">'+
    				 ' <li class="mb10">'+
    				    '<div class="select-wrap select-wrap1 mr30">'+
    				      	'<div class="select-input">'+
    				      		'<input type="text" class="int-text int-mini radius input-ename"/>'+
    				      		'<span id="inputNameErrMsg" style="display: none;"/></span>'+
					        '</div>'+
	    				     	'<select class="select select-in-small select-deg">'+
	    				     	  '<option value="2">'+eduundergraduate+'</option>'+
	    				     	  '<option value="3">'+eduspecialty+'</option>'+
	    				     	  '<option value="1">'+edumaster+'</option>'+
	    				     	'</select>&nbsp;&nbsp;&nbsp;'+
	    				     	'<label for="class-name">'+majorname+'</label>&nbsp;&nbsp;'+
	    				     	'<input type="text" class="int-text int-mini radius input-maj" style="height:45px;width:150px" id="class-name"/>'+
	    				     	'<span id="majorErrMsg" style="display: none;"></span>'+
	    				     	'</li>'+
	    				     	'<li>'+
	    				     		'<div select-con undis>'+
	    				     		'<span class="posi-title">'+address+':</span>'+
		    				     	'<select  class="select select-in-small countryInfo" id="countryInfo" name="country" onchange="getProviceValue(this.value)" style="width:180px">'+
										country+
									'</select>&nbsp;&nbsp;'+
			  						'<select class="select select-in-small provinceInfo" id="provinceInfo" onchange="getCnCityValue(this.value)" name="province" style="width:180px">'+
			  							province+
			  						 ' </select>&nbsp;&nbsp;'+
			  						'<select class="select select-in-small cnCityInfo" id="cnCityInfo" name="cnCity" style="width:180px">'+
			  							cnCity+
			  						'</select>&nbsp;&nbsp;'+
			  						'</div>'+
			  					'</li>'+
	    				     	' <li class="address-input mb10" style="padding-top:10px">'+
	    				     		'<input type="text" class="int-text int-mini radius address" placeholder="'+detailaddress+'"/>'+
	    				     		'<label id="addressErrMsg" style="display: none;"><span class="ash" id="addressText"></span></label>'+
	    				     	' </li>'+
	    				     	' <li>'+
		    				     		'<select  class="select select-in-small edu-year-start-add" id="year" name="year">'+
		    				     			yoption+
		    				     		'</select>&nbsp;&nbsp;'+
	    				     		'<span>'+year+'</span>&nbsp;&nbsp;'+
	    				     		'<span class="posi-title">'+time+'：</span>'+
	    				     		  '<select  class="select select-in-small edu-month-start-add" id="month" name="month">'+
	    				     		    '<option>01</option>'+
	    				     		    '<option>02</option>'+
	    				     		    '<option>03</option>'+ 
	    				     		    '<option>04</option>'+
	    				     		    '<option>05</option>'+ 
	    				     		    '<option>06</option>'+ 
	    				     		    '<option>07</option>'+ 
	    				     		    '<option>08</option>'+ 
	    				     		    '<option>09</option>'+
	    				     		    '<option>10</option>'+
	    				     		    '<option>11</option>'+
	    				     		    '<option>12</option>'+
	    				     		  '</select>&nbsp;&nbsp;'+
	    				     		'<span>'+month+'</span>&nbsp;&nbsp;'+
	    				     		'<span>'+to+'</span>&nbsp;&nbsp;'+
		    				     	'<select  class="select select-in-small edu-year-end-add" id="year" name="year">'+
		    				     		yoption+
		    				     	'</select>&nbsp;&nbsp;'+
	    				     		'<span>'+year+'</span>&nbsp;&nbsp;'+
	    				     		'<select  class="select select-in-small edu-month-end-add" id="month" name="month">'+
	    				     		    '<option>01</option>'+
	    				     		    '<option>02</option>'+
	    				     		    '<option>03</option>'+ 
	    				     		    '<option>04</option>'+
	    				     		    '<option>05</option>'+ 
	    				     		    '<option>06</option>'+ 
	    				     		    '<option>07</option>'+ 
	    				     		    '<option>08</option>'+ 
	    				     		    '<option>09</option>'+
	    				     		    '<option>10</option>'+
	    				     		    '<option>11</option>'+
	    				     		    '<option>12</option>'+
	    				     		 '</select>&nbsp;&nbsp;'+
	    				     		'<span>'+month+'</span>'+
	    				     		'<p class="edit-chose"> <span class="txt4" add-edu-ok></span> <span class="txt5" add-edu-clear></span> </p> </li> </ul>'+
	    				     		'</div>'+
	    				     	 '</div>'+
	    				     	' </div>'); 
    //每次只能添加一个编辑项目
      if(!$(this).parent('.value').find('[add-program] .quesbox').length>0){
        $(this).siblings('[add-program]').append(text1);
      }
      return false;
  });
    //确认添加教育背景
    $(document).on('click','[add-edu-ok]',function(){
      //地址信息
      var college = $('.educate').find('.input-ename').val()//选择学校名称
      var degree = $('.educate').find('.select-deg').val()//选择学位名称
      var major = $('.educate').find('.input-maj').val()//获取专业名称
      var country = $('.educate').find('.countryInfo').val()//选择国家名称
      var province =$('.educate').find('.provinceInfo').val()//选择省份名称
      var city = $('.educate').find('.cnCityInfo').val()//选择城市名称
      var address = $('.educate').find('.address').val()//获取详细地址
      if(college==""){
    	  $("#inputNameErrMsg").show().html(translatorInfoMsg.collegenameempty);
    	  return false;
      }else if(college.length>50){
    	  $("#inputNameErrMsg").show();
    	  $("#inputNameText").text(translatorInfoMsg.collegenamelength);
    	  return false;
      }
      if(major==""){
    	  $("#majorErrMsg").show().html(translatorInfoMsg.majornameempty);
    	  return false;
      }else if(major.length>50){
    	  $("#majorErrMsg").show().html(translatorInfoMsg.majornamelength);
    	  return false;
      }
      if(address==""||address==null){
    	  $("#addressErrMsg").show();
    	  $("#addressErrMsg").text(translatorInfoMsg.detailAddressEmpty);
    	  return false;
      }else if(address.length>50){
    	  $("#addressErrMsg").show();
    	  $("#addressErrMsg").text(translatorInfoMsg.detailAddressLength);
    	  return false;
      }
      //时间信息
      var yearStart= $('.educate').find('.edu-year-start-add').val()//选择开始年份
      var monthStart= $('.educate').find('.edu-month-start-add').val()//选择开始月份
      var yearEnd = $('.educate').find('.edu-year-end-add').val()//选择结束年份
      var monthEnd= $('.educate').find('.edu-month-end-add').val()//选择结束月份

      var text =$( "<p class=inputp"+num+"><span class='txt3'>"+college+"</span><span class='txt3'>"+yearStart+'/'+monthStart+'-'+yearEnd+'/'+monthEnd+"</span><span>"+degree+"</span><input type='button' class='btn biu-btn btn-auto-25 btn-red radius10' name="+id+" value='删 除' confirm-step2-educate><input type='button' class='btn biu-btn btn-auto-25 btn-green radius10' name=1."+id+" value='编 辑' editBtnEdu></p>" )
      num+=1;
      id+=1;
      addEducation[num] = "{"+
      						"'school':"+"'"+college+"',"+"'eduBackground':"+"'"+degree+"',"+"'profession':"+
      						"'"+major+"',"+"'coutry':"+"'"+country+"',"+"'province':"+"'"+province+"',"+
      						"'city':"+"'"+city+"',"+"'eduAddr':"+"'"+address+"',"+
      						"'studyStartTime':"+"'"+yearStart+"/"+monthStart+"',"+"'studyEndTime':"+"'"+
      						 yearEnd+"/"+monthEnd+"'"+
      					  "}";
      
      $('.exit2').before(text)
      $('.educate.quesbox').remove()

    })
    //取消添加教育背景
    $(document).on('click','[add-edu-clear]',function(){
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
        $('.educate').remove();
      })
      $(document).on('click','[add-edu-ok]',function(){
       
        $('.eduContainer').find(id).remove()
        // $('.educate.quesbox').remove()
      })

    })  
    //删除当前教育背景
    $(document).on('click','[confirm-step2-educate]',function(){


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
      addEducation.splice(parseInt(delettedNodeNum),1);
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
	  var curY = (new Date() ).getFullYear();
		var yoption = "";
	    for(var i = 0; i <= curY - 1930; i++) {
	    	var year = 1930+i;
	    	if(year==2017){
	    		yoption = yoption+"<option selected>"+year+"</option>";            
	    	}else{
	    		yoption = yoption+"<option>"+year+"</option>"; 
	    	}
	    }
    var text2 = $('<div class="educate work-expersise quesbox">'+
    				'<ul class="quesbox-wrap"> <li class="mb10">'+
    				  '<div class="select-input mr20">'+
    				  '<input type="text" class="int-text int-mini radius companyName"/>'+
    				  '<span id="companyError"></span>'+
    				  '</div>'+
    				  '<div class="select-input">'+
    				  '<label for="work-name">'+positionname+'：</label>'+
    				  '<input type="text" class="int-text int-mini radius workName" id="work-name"/> </div>'+
    				  '<span id="workNameError"></span>'+
    				  '<span class="posi-title">'+companyname+'：</span> </li>'+
    				  '<li class="mb10">'+
    					' <li>'+
			     		'<select  class="select select-in-small work-year-start-add" id="year" name="year">'+
			     			yoption+
			     		'</select>&nbsp;&nbsp;'+
			     		'<span>'+year+'</span>&nbsp;&nbsp;'+
			     		'<span class="posi-title">'+incumbencytime+'：</span>'+
			     		'<select  class="select select-in-small work-month-start-add" id="month" name="month">'+
			     		    '<option>01</option>'+
			     		    '<option>02</option>'+
			     		    '<option>03</option>'+ 
			     		    '<option>04</option>'+
			     		    '<option>05</option>'+ 
			     		    '<option>06</option>'+ 
			     		    '<option>07</option>'+ 
			     		    '<option>08</option>'+ 
			     		    '<option>09</option>'+
			     		    '<option>10</option>'+
			     		    '<option>11</option>'+
			     		    '<option>12</option>'+
		     		  '</select>&nbsp;&nbsp;'+
		     		'<span>'+month+'</span>&nbsp;&nbsp;'+
		     		'<span>'+to+'</span>&nbsp;&nbsp;'+
			     	'<select  class="select select-in-small work-year-end-add" id="year" name="year">'+
			     		yoption+
			     	'</select>&nbsp;&nbsp;'+
		     		'<span>'+year+'</span>&nbsp;&nbsp;'+
		     		'<select  class="select select-in-small work-month-end-add" id="month" name="month">'+
		     		    '<option>01</option>'+
		     		    '<option>02</option>'+
		     		    '<option>03</option>'+ 
		     		    '<option>04</option>'+
		     		    '<option>05</option>'+ 
		     		    '<option>06</option>'+ 
		     		    '<option>07</option>'+ 
		     		    '<option>08</option>'+ 
		     		    '<option>09</option>'+
		     		    '<option>10</option>'+
		     		    '<option>11</option>'+
		     		    '<option>12</option>'+
		     		 '</select>&nbsp;&nbsp;'+
		     		'<span>'+month+'</span>'+
		     		'<li style="padding-top:10px">'+
		     		'<textarea class="int-text int-mini radius describe"></textarea>'+
    				'<span class="posi-title">'+positiondescription+'：</span>'+
    				'<p class="edit-chose">'+
    					'<span class="txt4" add-work-ok></span>'+
    					'<span class="txt5" add-work-clear></span>'+
    				'</p>'+
    				'</li>'+
		     		'</div>'+
    				'</div>'+
    				'</div>'+
    				'</li>'+
    				'<li>'+
    				
    				'<p class="edit-chose"> <span class="txt4" add-work-ok></span>'+
    				'<span class="txt5" add-work-clear></span> </p> </li> </ul> </div>'); 
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
    var yearStart=$('.work-expersise').find('.work-year-start-add').val()//选择开始年份
    var monthStart=$('.work-expersise').find('.work-month-start-add').val()//选择开始月份
    var yearEnd=$('.work-expersise').find('.work-year-end-add').val()//选择结束年份
    var monthEnd=$('.work-expersise').find('.work-month-end-add').val()//选择结束月份
    var describe=$('.work-expersise').find('.describe').val()//获取职位描述
    
    
    if(companyName==null||companyName==""){
    	$("#companyError").show().html(translatorInfoMsg.companynameempty);
    	return false;
    }else{
    	if(companyName.length>50){
    		$("#companyError").show().html(translatorInfoMsg.companynamelength);
    		return false;
    	}else{
    		$("#companyError").hide();
    	}
    }
    
    if(workName==null||workName==""){
    	$("#workNameError").show().html(translatorInfoMsg.positionnameempty);
    	return false;
    }else{
    	if(workName.length>50){
    		$("#workNameError").show().html(translatorInfoMsg.positionnamelength);
    		return false;
    	}else{
    		$("#workNameError").hide();
    	}
    }
    
    // console.log(describe)
    var Time=yearEnd-yearStart;
    if(Time==0){//不足一年 算作一年
      Time=1
    }
    var text=$("<p class= inputp"+num+"><span class='txt3'>"+companyName+"</span><span class='txt3'>"+yearStart+'/'+monthStart+'-'+yearEnd+'/'+monthEnd+"</span><span><strong>"+Time+"</strong>年</span><input type='button' class='btn biu-btn btn-auto-25 btn-red radius10' name="+id+" value='删 除'' setting-save-btn1><input type='button' class='btn biu-btn btn-auto-25 btn-green radius10' name=1."+id+" value='编 辑' editBtnWork></p>")
    addwork[num] = "{"+
	    			  "'company':'"+companyName+"',"+"'position':"+workName+
	    			  "',"+"'workStartTime':'"+yearStart+"/"+monthStart+"',"+"'workEndTime':'"+ yearEnd+"/"+monthEnd+"'"+
    			   "}";
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
      addwork.splice(parseInt(delettedNodeNum),1);
    })
    //点击取消
    $('#setting-sav-cancel1').click(function(){
      $('#setting-mask1').fadeOut(200);
      $('#setting-dialog1').slideUp(200);
    })
  })
  //添加证书
  $(document).on('click','[add-card]',function(){
    var curY = (new Date() ).getFullYear();
	var yoption = "";
    for(var i = 0; i <= curY - 1930; i++) {
    	var year = 1930+i;
    	if(year==2017){
    		yoption = yoption+"<option selected>"+year+"</option>";            
    	}else{
    		yoption = yoption+"<option>"+year+"</option>"; 
    	}
    }
    var text3 = $('<div class="educate work-expersise quesbox diploma">'+
    		       '<ul class="quesbox-wrap">'+
    		         '<li class="mb10">'+
    		           '<div class="select-input mr20">'+
    		           	'<input type="text" class="int-text int-mini radius diplomaName"/>'+
    		            '<span id="diplomaNameError"></span>'+
    		           '</div>'+
    		           '<div class="select-input">'+
    		             '<label for="card-name">'+certificateauthority+'：</label>'+
    		             '<input type="text" class="int-text int-mini radius from" id="card-name"/>'+
    		             '<span id="cardNameError"></span>'+
    		           '</div>'+
    		            '<span class="posi-title">'+certificatename+'：</span> </li>'+
    		            '<li class="mb10">'+
    		        	'<select  class="select select-in-small card-year-start-add" id="year" name="year">'+
		     				yoption+
		     			'</select>&nbsp;&nbsp;'+
			     		'<span>'+year+'</span>&nbsp;&nbsp;'+
			     		'<span class="posi-title">'+issuedate+'：</span>'+
			     		  '<select  class="select select-in-small card-month-start-add" id="month" name="month">'+
			     		    '<option>01</option>'+
			     		    '<option>02</option>'+
			     		    '<option>03</option>'+ 
			     		    '<option>04</option>'+
			     		    '<option>05</option>'+ 
			     		    '<option>06</option>'+ 
			     		    '<option>07</option>'+ 
			     		    '<option>08</option>'+ 
			     		    '<option>09</option>'+
			     		    '<option>10</option>'+
			     		    '<option>11</option>'+
			     		    '<option>12</option>'+
			     		  '</select>&nbsp;&nbsp;'+
			     		  '<span>'+month+'</span>'+
			     		  '<li>'+
	  		              	   '<textarea class="int-text int-mini radius describe"></textarea>'+
	  		              	   '<span class="posi-title">'+certificateoverview+'：</span>'+
	  		              	   '<p class="edit-chose">'+
	  		              	     '<span class="txt4" add-diploma-ok></span>'+
	  		              	     '<span class="txt5" add-diploma-clear></span>'+
	  		              	   '</p>'+
  		              	  '</li>'+
    		              '</div>'+
    		              '</div>'+
    		              '</li>'
    		              ); 
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
    var year =$('.diploma').find('.card-year-start-add').val()//选择证书年份
    var month =$('.diploma').find('.card-month-start-add').val()//选择证书颁发月份
    var describe=$('.diploma').find('.describe').val()//获取证书描述
    if(name==null||name==""){
    	$("#diplomaNameError").show().html(translatorInfoMsg.certificatenameempty);
    	return false;
    }else{
    	if(name.length>50){
    		$("#diplomaNameError").show().html(translatorInfoMsg.certificatenamelength);
    		return false;
    	}else{
    		$("#diplomaNameError").hide();
    	}
    		
    }
    
    if(from==null||from==""){
    	$("#cardNameError").show().html(translatorInfoMsg.certificateauthorityname);
    	return false;
    }else{
    	if(from.length>50){
    		$("#cardNameError").show().html(translatorInfoMsg.certificateauthoritylength);
    		return false;
    	}else{
    		$("#cardNameError").hide();
    	}
    		
    }
    console.log(name)
    var text=$("<p class='inputp"+num+"'><span class='txt3'>"+name+"</span><span class='txt3'>"+year+'/'+month+"</span><span>"+from+"</span><input type='button' class='btn biu-btn btn-auto-25 btn-red radius10' name='"+id+"' value='删 除' setting-save-btn><input type='button' class='btn biu-btn btn-auto-25 btn-green radius10' name='1."+id+"' value='编 辑' editBtnDiploma></p>")
    num+=1;
    id+=1;
    addcard[num] = "{"+
    				  "'certificateName':'"+name+"',"+"'grantingInstitution':'"+from+
    				  "',"+"'awardedTime':'"+year+"/"+month+"',"+"'certificatesDescribe':'"+describe+"'}";
    $('.exit4').before(text)
    $('.diploma').remove();
  })
  //取消添加证书
  $(document).on('click','[add-diploma-clear]',function(){
    $('.diploma').remove();
    })
  //编辑证书内容
  $(document).on('click','[editBtnDiploma]',function(){
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