<%@page import="com.ai.yc.protal.web.constants.Constants"%>
<%@page import="com.ai.opt.sdk.components.ccs.CCSClientFactory"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<%@ include file="/inc/inc.jsp" %>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="${_base}/resources/spm_modules/webuploader/webuploader.css">
<title><spring:message code="yctranslator.second.title" /></title>
</head>
<body>
<!--弹出--> 
<div class="eject-big">
    <div class="prompt-samll" id="modify-password">
    <div class="prompt-samll-title"><spring:message code="yctranslator.second.delete.tip"/></div>
    <!--确认删除-->
    <div class="prompt-samll-confirm">
      <ul class="pass-list">
      <li>
          <spring:message code="yctranslator.second.delete.first.line"/>
      </li>
       <li>
           <spring:message code="yctranslator.second.delete.second.line"/>
      </li>
      <li class="eject-btn">
        <input type="button" id="modify-determine" class="btn btn-green btn-120 radius20" value="<spring:message code="yctranslator.second.botton.Ok"/>">
        <input type="button" id="modify-close" class="btn border-green btn-120 radius20" value="<spring:message code="yctranslator.second.botton.cancle"/>">
      </li>   
      </ul>
    </div>
    </div>  
  <div class="mask" id="eject-mask"></div>
</div>
<!--/弹出结束-->
<!--弹出--> 
<div class="eject-big">
    <div class="prompt-samll" id="setting-dialog">
    <div class="prompt-samll-title"><spring:message code="yctranslator.second.delete"/></div>
    <!--确认删除-->
    <div class="prompt-samll-confirm">
      <ul class="pass-list">
      <li>
       <spring:message code="yctranslator.second.delete.cer"/>
      </li>
      <li class="eject-btn">
        <input type="button" id="setting-save-confirm" class="btn btn-green btn-120 radius20" value="<spring:message code="yctranslator.second.botton.Ok"/>">
        <input type="button" id="setting-save-cancel" class="btn border-green btn-120 radius20" value="<spring:message code="yctranslator.second.botton.cancle"/>">
      </li>   
      </ul>
    </div>
    </div>  
  <div class="mask" id="setting-mask"></div>
</div>
<!--/弹出结束--> 
<!--弹出--> 
<div class="eject-big">
    <div class="prompt-samll" id="setting-dialog1">
    <div class="prompt-samll-title"><spring:message code="yctranslator.second.delete"/></div>
    <!--确认删除-->
    <div class="prompt-samll-confirm">
      <ul class="pass-list">
      <li>
        <spring:message code="yctranslator.second.delete.work"/>
      </li>
      <li class="eject-btn">
        <input type="button" id="setting-save-confirm1" class="btn btn-green btn-120 radius20" value="确 定">
        <input type="button" id="setting-save-cancel1" class="btn border-green btn-120 radius20" value="<spring:message code="yctranslator.second.botton.cancle"/>">
      </li>   
      </ul>
    </div>
    </div>  
  <div class="mask" id="setting-mask1"></div>
</div>
<!--/弹出结束--> 
<!--弹出--> 
<div class="eject-big">
    <div class="prompt-samll" id="confirm-step2-educate">
    <div class="prompt-samll-title"><spring:message code="yctranslator.second.delete"/></div>
    <!--确认删除-->
    <div class="prompt-samll-confirm">
      <ul class="pass-list">
      <li>
        <spring:message code="yctranslator.second.delete.edu"/>
      </li>
      <li class="eject-btn">
        <input type="button" id="confirm-step2-educate-confirm" class="btn btn-green btn-120 radius20" value="确 定">
        <input type="button" id="confirm-step2-educate-cancel" class="btn border-green btn-120 radius20" value="<spring:message code="yctranslator.second.botton.cancle"/>">
      </li>   
      </ul>
    </div>
    </div>  
  <div class="mask" id="confirm-step2-educate-mask"></div>
</div>
<!--/弹出结束--> 
<!--弹出--> 
<div class="eject-big">
    <div class="prompt-samll" id="confirm-step2-language">
    <div class="prompt-samll-title"><spring:message code="yctranslator.second.delete"/></div>
    <!--确认删除-->
    <div class="prompt-samll-confirm">
      <ul class="pass-list">
      <li>
      	<spring:message code="yctranslator.second.language.first.line"/>
      </li>
      <li>
        <spring:message code="yctranslator.second.language.second.line"/>
      </li>
      <li class="eject-btn">
        <input type="button" id="confirm-step2-language-confirm" class="btn btn-green btn-120 radius20" value="<spring:message code="yctranslator.second.botton.Ok"/>">
        <input type="button" id="confirm-step2-language-cancel" class="btn border-green btn-120 radius20" value="<spring:message code="yctranslator.second.botton.cancle"/>">
      </li>   
      </ul>
    </div>
    </div>  
  <div class="mask" id="confirm-step2-language-mask"></div>
</div>
<!--/弹出结束--> 
<!-- 译员不能为空提示弹窗 -->
<div class="eject-big">
    <div class="prompt-samll" id="confirm-step2-empty">
    <div class="prompt-samll-title"> <spring:message code="yctranslator.second.delete.tip"/></div>
    <!--确认删除-->
    <div class="prompt-samll-confirm">
      <ul class="pass-list">
      <li>
      <spring:message code="yctranslator.second.delete.language.tip"/>
     
      </li>
      <li class="eject-btn">
        <input type="button" id="confirm-step2-empty-confirm" class="btn btn-green btn-120 radius20" value=" <spring:message code="yctranslator.second.botton.Ok"/>">
      </li>   
      </ul>
    </div>
    </div>  
  <div class="mask" id="confirm-step2-empty-mask"></div>
</div>
	<!--头部-->
	<c:if test="${source=='user'}">
      <%@ include file="/inc/userTopMenu.jsp"%>
  	</c:if>
 	 <c:if test="${source=='interpreter'}">
      <%@ include file="/inc/transTopMenu.jsp"%>
  	</c:if>
  <!--二级主体-->
  <!--外侧背景-->
  <div class="cloud-container">
  <!--内侧内容区域-->
  <div class="cloud-wrapper">
  	<!--左侧菜单-->
  	<!--左侧菜单-->
  	<div class="left-subnav">
  	 <c:if test="${source=='user'}">
  	<%@ include file="/inc/leftmenu.jsp"%>
  	</c:if>
     <c:if test="${source=='interpreter'}">
    <%@ include file="/inc/transLeftmenu.jsp"%>
  	</c:if>
  	</div>
  	<!--右侧内容-->
  	<!--右侧大块-->
  	 <div class="right-wrapper third-testing">
        <!--订单详细待确认-->
        <div class="step-big"> 
          <!--步骤-->
          <div class="step">
            <!--完善议员信息-->
            <div class="step-none adopt-green-border alr-completed">
              <p class="green-line short"></p>
              <ul>
                <li class="circle"><i class="icon iconfont">&#xe60e;</i></li>
                <li class="word">完善议员信息</li>
              </ul>
              <p class="green-line short"></p>
            </div>
            <!--填写翻译简历-->
            <div class="step-none adopt-green-border alr-completed">
              <p class="green-line"></p>
              <ul>
                <li class="circle"><i class="icon iconfont">&#xe60e;</i></li>
                <li class="word">填写翻译简历</li>
              </ul>
              <p class="green-line"></p>
            </div>
            <!--语言测试-->
            <div class="step-none adopt-green-border">
              <p class="green-line"></p>
              <ul>
                <li class="circle"><i class="">3</i></li>
                <li class="word">语言测试</li>
              </ul>
              <p class="green-line short"></p>
            </div>
          </div>
        </div>
        <!--蒙版-->
        <div class="prompt-modal"></div>
        <!--切换语言提示-->
        <div class="prompt-box">
          <div class="prompt-header">
            <span>提示</span>
          </div>
          <div class="prompt-content">
            <p>您当前语言的测试还没有完成，若选择其他语种测试，则当前测试将无法保留，需要重新测试，确定选择其他测试语言吗？</p>
          </div>
          <div class="prompt-footer">
            <button class="confirm">确定</button>
            <button class="cancel">取消</button>
          </div>
        </div>
        <!--超时提示-->
        <div class="overtime-box">
          <div class="overtime-header">
            <span>超时提示</span>
          </div>
          <div class="overtime-content">
            <p>很遗憾，您已经超时，没有完成本次测试</p>
          </div>
          <div class="overtime-footer">
            <button class="confirm">重新测试</button>
            <button class="cancel">取消</button>
          </div>
        </div>
        <!--测试table-->
	   	<div class="testing-table mt-20" id="languageTable"> 
          <div class="tab-bar">
            <ul>
             <c:forEach items="${firstQuestMap}" var="language">
             	<li tab-li><a href="javascript:void(0)" onclick="changeTab ('0','lan${language.key.duadId}')" class="current">${language.key.languageNameZh}<span class="not-tested"></span></a></li>
             </c:forEach>
             <c:forEach items="${languageQuest}" var="language">
             	<li tab-li><a href="javascript:void(0)" onclick="changeTab ('1','lan${language.key.duadId}')">${language.key.languageNameZh}<span class="not-tested"></span></a></li>
             </c:forEach>
            </ul>
          </div>
          
        </div>  
      </div>
    </div>
           
</body>
<%@ include file="/inc/incJs.jsp" %>
<script type="text/javascript">
var current ="interpreterInfo";
var originalNickname="${interpreterInfo.nickname}";
var originalUsername="${user_session_key.username}";
var countryCode = "${interpreterInfo.country}";
var provinceCode = "${interpreterInfo.province}";
var cnCityCode = "${interpreterInfo.cnCity}";
var languagePairText = "";

var languageList = '${languageListJson}';
var eduList = '${educationListJson}';
var workList = '${workListJson}';
var cerList = '${certificationListJson}';
var languageQuestion= '${languageQuest}';
var titleMap= '${titleMap}';
var firstTitleMap= '${firstTitleMap}';
var firstLanguageNum= '${firstLanguageNum}';
var translatorInfoMsg ={
		"languageprivceempty" : '<spring:message code="yctranslator.second.language.price.empty"/>',
		"languageprivcenumber" : '<spring:message code="yctranslator.second.language.price.number"/>',
		"didnottest" : '<spring:message code="yctranslator.add.translate.state.didnottest"/>',
		"interpret" : '<spring:message code="yctranslator.add.translatertype.interpret"/>',
		"translate" : '<spring:message code="yctranslator.add.translate.translate"/>',
		"priceUnit" : '<spring:message code="yctranslator.second.language.price"/>',
		"deleteButton" : '<spring:message code="yctranslator.second.delete"/>',
		"editButton" : '<spring:message code="yctranslator.second.edit"/>',
		"eduspecialty" : '<spring:message code="yctranslator.second.education.specialty"/>',
		"edumaster" : '<spring:message code="yctranslator.second.education.master"/>',
		"eduundergraduate" : '<spring:message code="yctranslator.second.education.undergraduate"/>',
		"majorname" : '<spring:message code="yctranslator.second.education.majorname"/>',
		"address" : '<spring:message code="yctranslator.second.education.address"/>',
		"detailaddress" : '<spring:message code="yctranslator.second.education.detailaddress"/>',
		"time" : '<spring:message code="yctranslator.second.education.time"/>',
		"year" : '<spring:message code="yctranslator.second.education.time.year"/>',
		"month" : '<spring:message code="yctranslator.second.education.time.month"/>',
		"to" : '<spring:message code="yctranslator.second.education.time.to"/>',
		"positionname" : '<spring:message code="yctranslator.second.work.position.name"/>',
		"companyname" : '<spring:message code="yctranslator.second.work.company.name"/>',
		"incumbencytime" : '<spring:message code="yctranslator.second.work.incumbency.time"/>',
		"positiondescription" : '<spring:message code="yctranslator.second.work.position.description"/>',
		"certificateauthority" : '<spring:message code="yctranslator.second.cer.certificate.authority"/>',
		"certificatename" : '<spring:message code="yctranslator.second.cer.certificate.name"/>',
		"issuedate" : '<spring:message code="yctranslator.second.cer.issue.date"/>',
		"certificateoverview" : '<spring:message code="yctranslator.second.cer.certificate.overview"/>',
		"collegenameempty" : '<spring:message code="yctranslator.second.education.college.name.empty "/>',
		"collegenamelength" : '<spring:message code="yctranslator.second.education.college.name.length"/>',
		"majornameempty" : '<spring:message code="yctranslator.second.education.major.name.empty"/>',
		"majornamelength" : '<spring:message code="yctranslator.second.education.major.name.lengthe"/>',
		"detailAddressEmpty" : '<spring:message code="yctranslator.second.education.college.name.empty"/>',
		"detailAddressLength" : '<spring:message code="yctranslator.second.education.college.name.length"/>',
		"companynameempty" : '<spring:message code="yctranslator.second.work.company.name.empty"/>',
		"companynamelength" : '<spring:message code="yctranslator.second.work.company.name.length"/>',
		"positionnameempty" : '<spring:message code="yctranslator.second.work.position.name.empty"/>',
		"positionnamelength" : '<spring:message code="yctranslator.second.work.position.name.length"/>',
		"certificatenameempty" : '<spring:message code="yctranslator.second.cer.certificate.name.empty"/>',
		"certificatenamelength" : '<spring:message code="yctranslator.second.cer.certificate.name.length"/>',
		"certificateauthorityname" : '<spring:message code="yctranslator.second.cer.certificate.authority.name"/>',
		"certificateauthoritylength" : '<spring:message code="yctranslator.second.cer.certificate.authority.length"/>',
		"showOkValueMsg" : '<spring:message code="yctranslator.second.botton.Ok"/>',
		"showTitleMsg" : '<spring:message code="yctranslator.second.botton.cancle"/>',
   		
	};
function changeTab(index,questionValue){
	var divStart= "";
	var divQuestion = $("#"+questionValue);
	$(".testing-con").hide();
	divStart = '<div class="testing-con" test-con id='+questionValue+'>'+
				    '<div class="tab-con">'+
				    '<div class="tip-msg">'+
				       '<p class="pull-left txt">您好，请您在30分钟内完成下列测试题目，以便我们将对您的翻译进行评级。</p>'+
				       '<p class="pull-left surplus-time">剩余时间:<span class="time">30</span>分钟</p>'+
				    '</div>'+
				'<div>';
	if((typeof(divQuestion.html()) == 'undefined')){
		$("#"+questionValue).show();
		if(index == 0){
			map = firstTitleMap;
		}else{
			map = titleMap;
		}
		var str = $.parseJSON(map);
		var map = eval(str);  
		var questionV = map[questionValue];
		var divEnd = '</div>'+
					    '<div class="recharge-btn confirm-btn">'+
					    '<input type="button" class="btn btn-green btn-xxxlarge radius10" value="确定">'+
					  '</div>'+
					'</div>'+
					'</div>';
		var divBody = "";
		for(var i=0;i<questionV.length;i++){
			   var questionObject = questionV[i];
			   divBody =divBody+ '<ol>'+
					              '<li class="item">'+
					                '<p class="title">'+questionObject.choiceQuestion+'</p>'+
					                '<ul class="answer-list">'+
					                  '<li class="horizontal answer" answer><a href="javascitpt:;"><i class="icon-radio2 icon-radioed"></i>'+questionObject.optiona+'</a></li>'+
					                  '<li class="horizontal answer" answer><a href="javascitpt:;"><i class="icon-radio2"></i>'+questionObject.optionb+'</a></li>'+
					                  '<li class="horizontal answer" answer><a href="javascitpt:;"><i class="icon-radio2"></i>'+questionObject.optionc+'</a></li>'+
					                  '<li class="horizontal answer" answer><a href="javascitpt:;"><i class="icon-radio2"></i>'+questionObject.optiond+'</a></li>'+
					                '</ul>'+
					              '</li>'+
					            '</ol>';
		}
		$("#languageTable").append(divStart+divBody+divEnd);
	}else{
		$(".testing-con").hide();
		$("#"+questionValue).show();
	}
}
$(function(){
	var questionValue = "lan"+firstLanguageNum
	changeTab(0,questionValue);
	//选择答案
    $(document).on('click', '[answer]', function(){
      $(this).find('.icon-radio2').addClass('icon-radioed');
      $(this).siblings().find('.icon-radio2').removeClass('icon-radioed');
    });

    //tab切换
    var index;
    var that
    $(document).on('click','[tab-li]', function(){
      $('.third-testing .prompt-modal').css('display','block');
      $('.third-testing .prompt-box').css('display','block');
      index = $(this).index();
      that=this;
    });

    //提示窗确认
    $(document).on('click','.confirm', function(){
      $('.third-testing .prompt-modal').css('display','none');
      $('.third-testing .prompt-box').css('display','none');
      $('.third-testing .overtime-box').css('display','none');
      $(that).find('a').addClass('current');
      $(that).siblings().find('a').removeClass('current');
      $(that).parents('.tab-bar').siblings('.testing-con').addClass('undis').eq(index).removeClass('undis');
    });

    //提示窗取消
    $(document).on('click','.cancel', function(){
      $('.third-testing .prompt-modal').css('display','none');
      $('.third-testing .prompt-box').css('display','none');
      $('.third-testing .overtime-box').css('display','none');
    });

   /*  //超时提醒
    var settime=setTimeout(function(){
      $('.third-testing .prompt-modal').css('display','block');
      $('.third-testing .overtime-box').css('display','block');
    },3000); */
  });
</script>

</html>
