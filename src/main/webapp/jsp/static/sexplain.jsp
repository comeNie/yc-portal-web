<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>服务说明</title>
    <%@include file="/inc/inc.jsp" %>
</head>
<body>
<!--面包屑导航-->
<%@include file="/inc/topHead.jsp" %>
<!--主导航-->
<%@include file="/inc/topMenu.jsp" %>

<!--主体-->
<div class="agreement-wrapper-big">
    <div class="agreement-wrapper">
        <div class="subnav-left">
            <ul>
                <li><a href="javascript:" class="current">服务内容</a></li>
                <li><a href="javascript:">服务时间</a></li>
                <li><a href="javascript:">服务价格</a></li>
                <li><a href="javascript:">付费方式</a></li>
                <li><a href="javascript:">售后服务</a></li>
                <li><a href="javascript:">保密机制</a></li>
            </ul>
        </div>
        <div class="agreement-right">
            <div id="tab-xy1">
                <div class="agreement-word">
                    <ul>
                        <li>
                            <p class="blue">快速翻译</p>
                            <p>适用于短文本翻译服务，最快30分钟即可获得翻译结果。仅限2000字以内的翻译业务；支持中文同英、法、俄、西、日、韩间的互译。</p>
                        </li>
                        <li>
                            <p class="blue">创意翻译</p>
                            <p>满足您在广告词、起名(商标名、公司名、店名、产品名)、文学性文字（歌词、诗词类）方面的创意性翻译需求。翻译完成后，除译文外，我们将同时提供翻译解释；支持中文同英、法、俄、西、日、韩间的互译。</p>
                        </li>
                        <li>
                            <p class="blue">证件翻译</p>
                            <p>为您专业提供各类证、证书和其他证明性文件的翻译服务。包含：身份证、护照、驾照、企业执照、毕业证、学位证、荣誉证书、医学证明等文件。翻译完成后，除了获得一份电子版的译文外，还可申请获得一份加盖我司公章的打印件；支持中文同英、法、俄、西、日、韩间的互译。</p>
                        </li>
                        <li>
                            <p class="blue">文档翻译</p>
                            <p>若翻译内容较多，建议您使用文档翻译服务。所提交的文档必须为doc、docx、txt、pdf、ppt、pptx、xlsx,等格式的翻译业务，若需翻译jpg、png、tif等图片格式或大小超过20M的文件时，请电话与我们联系；支持中文同英、法、俄、西、日、韩间的互译。</p>
                        </li>
                        <li>
                            <p class="blue">简历翻译</p>
                            <p>为您提供专业的英文简历翻译、译文审校、母语润色等特色服务，有众多简历翻译专家为您提供专业指导，支持在线翻译，可通过简历模版自动生成简历，以高品质的翻译质量，以简单，便捷的翻译流程为您提供专业的简历翻译服务。目前，暂时只支持中译英。</p>
                        </li>
                        <li>
                            <p class="blue">口译</p>
                            <p>国家级口译服务，提供陪同翻译、交替传译、同声传译等服务。为了更好的为您服务，建议提前三个工作日以上进行申请；提供中英、中俄、中法、中西、中日、中韩间的互译。</p>
                        </li>
                    </ul>
                </div>
            </div>
            <div id="tab-xy2" style="display: none;">
                <div class="agreement-word">
                    <ul>
                        <li>
                            <p class="blue">快速翻译 | 创意翻译 | 证件翻译 | 文档翻译 | 简历翻译</p>
                            <p>周一至周五09:00-18:00 (重大节假日除外)，非工作时间提交的订单将顺延至工作时间处理。</p>
                        </li>
                        <li>
                            <p class="blue">口译</p>
                            <p>周一至周五09:00-18:00 (重大节假日除外)，非工作时间提交的订单将顺延至工作时间处理，建议提前三个工作日以上进行申请。</p>
                        </li>
                    </ul>
                </div>
            </div>
            <div id="tab-xy3"  style="display: none;">
                <div class="agreement-word">
                    <ul>
                        <li>
                            <p class="blue">快速翻译</p>
                            <p>根据不同语种按字收费，提交订单时会提示预计完成时间</p>
                        </li>
                        <li>
                            <table  class="table table-border table-bg  table-bordered  table-height65">
                                <tr class="bj">
                                    <th>语言</th>
                                    <th>价格  元/字</th>
                                    <th>语言</th>
                                    <th>价格  元/单词</th>
                                    <th>语言</th>
                                    <th>价格  元/字</th>
                                    <th>语言</th>
                                    <th>价格  元/单词</th>
                                </tr>
                                <tr>
                                    <td>中→英</td>
                                    <td>0.28</td>
                                    <td>英→中</td>
                                    <td>0.4</td>
                                    <td>中→西</td>
                                    <td>0.6</td>
                                    <td>西→中</td>
                                    <td>0.6</td>
                                </tr>
                                <tr>
                                    <td>中→法</td>
                                    <td>0.4</td>
                                    <td>法→中</td>
                                    <td>0.6</td>
                                    <td>中→日</td>
                                    <td>0.4</td>
                                    <td>日→中</td>
                                    <td>0.4</td>
                                </tr>
                                <tr>
                                    <td>中→俄</td>
                                    <td>0.4</td>
                                    <td>俄→中</td>
                                    <td>0.6</td>
                                    <td>中→韩</td>
                                    <td>0.4</td>
                                    <td>韩→中</td>
                                    <td>0.4</td>
                                </tr>
                            </table>
                        </li>
                        <li class="mt-20">
                            <p>译员配置：专业级译员服务；实时待命，立等可取</p>
                            <p>售后服务：翻译完成48小时内，不满意可以申请译员免费修改</p>
                        </li>
                        <li>
                            <p class="blue">创意翻译</p>
                            <p>每笔订单仅提供1条内容的翻译服务，采取按条收费，翻译完成后的译文字数需控制在50字以内；服务价格， 100元/条。</p>
                        </li>
                        <li>
                            <p class="blue">证件翻译</p>
                            <p>每笔订单仅提供1份证件的翻译服务，采取按份收费；服务价格，200元/份。</p>
                        </li>
                        <li>
                            <p class="blue">文档翻译</p>
                        </li>
                        <li>
                            <table  class="table table-border table-bg  table-bordered  table-height65">
                                <tr class="bj">
                                    <th>语言</th>
                                    <th>普通级别<br>(千字/元)</th>
                                    <th>专业级别<br>(千字/元)</th>
                                    <th>出版级别<br>(千字/元)</th>
                                    <th>语言/等级</th>
                                    <th>普通级别<br>(千字/元)</th>
                                    <th>专业级别<br>(千字/元)</th>
                                    <th>出版级别<br>(千字/元)</th>
                                </tr>
                                <tr>
                                    <td>中→英</td>
                                    <td>150</td>
                                    <td>280</td>
                                    <td>450</td>
                                    <td>英→中</td>
                                    <td>220</td>
                                    <td>360</td>
                                    <td>800</td>
                                </tr>
                                <tr>
                                    <td>中→法</td>
                                    <td>240</td>
                                    <td>300</td>
                                    <td>500</td>
                                    <td>法→中</td>
                                    <td>350</td>
                                    <td>420</td>
                                    <td>640</td>
                                </tr>
                                <tr>
                                    <td>中→俄</td>
                                    <td>240</td>
                                    <td>300</td>
                                    <td>500</td>
                                    <td>俄→中</td>
                                    <td>350</td>
                                    <td>420</td>
                                    <td>640</td>
                                </tr>
                                <tr>
                                    <td>中→西</td>
                                    <td>280</td>
                                    <td>380</td>
                                    <td>650</td>
                                    <td>西→中</td>
                                    <td>400</td>
                                    <td>500</td>
                                    <td>700</td>
                                </tr>
                                <tr>
                                    <td>中→日</td>
                                    <td>240</td>
                                    <td>260</td>
                                    <td>500</td>
                                    <td>日→中</td>
                                    <td>240</td>
                                    <td>300</td>
                                    <td>500</td>
                                </tr>
                                <tr>
                                    <td>中→韩</td>
                                    <td>240</td>
                                    <td>300</td>
                                    <td>500</td>
                                    <td>韩→中</td>
                                    <td>240</td>
                                    <td>300</td>
                                    <td>500</td>
                                </tr>
                            </table>
                        </li>
                        <li class="mt-20">
                            <p>文档翻译，不足300字按照300字计算</p>
                            <p>原文是中文，按照word文档中字符数（不计空格）计算价格，页眉、页脚、文本框、图片另行统计计算</p>
                            <p>原文是外文，按照外文单词数计算价格</p>
                            <p>翻译按照级别分为以下内容</p>
                        </li>
                        <li>
                            <table  class="table table-border table-bg  table-bordered  table-height65">
                                <tr class="bj">
                                    <th>等级分类</th>
                                    <th>适用范围</th>
                                    <th>译员配置</th>
                                    <th>售后服务</th>
                                </tr>
                                <tr>
                                    <td>普通级别</td>
                                    <td>适用于个人阅读、理解，不适用于专业领域</td>
                                    <td>1-2年翻译经验，累计翻译字数达100万</td>
                                    <td rowspan="3">翻译完成5天内，<br>可以申请译员免费<br>修改</td>
                                </tr>
                                <tr>
                                    <td>专业级别</td>
                                    <td>适用于专业领域、重要场合<br>对专业性及译者有极高要求</td>
                                    <td>3年以上，累计翻译字数达300万，<br>根据所属专业领域安排相应的译员</td>
                                </tr>
                                <tr>
                                    <td>出版级别</td>
                                    <td>用于科学论文发表，学术交流<br>对译者背景领域有极高要求</td>
                                    <td>5年以上，累计翻译字数达500万<br>资深译员翻译，领域专家润色</td>
                                </tr>
                            </table>
                        </li>
                        <li class="mt-20">
                            <p>为了帮助您获得更好的服务体验，我们极力推荐您使用“专业级别”以上的翻译服务</p>
                        </li>
                        <li>
                            <p class="blue">简历翻译</p>
                        </li>
                        <li>
                            <table  class="table table-border table-bg  table-bordered  table-height65">
                                <tr class="bj">
                                    <th>等级分类</th>
                                    <th>产品介绍</th>
                                    <th>适合人群</th>
                                </tr>
                                <tr>
                                    <td>普通级别</td>
                                    <td>直接将简历翻译成英文，内容不做修改，<br>与原文意思保持一致。</td>
                                    <td>对英文简历有普通需求的白领及刚毕业人群</td>
                                </tr>
                                <tr>
                                    <td>母语润色</td>
                                    <td>将中文简历内容进行校正后，根据所属专业领域<br>译成英文，翻译后的文章能准确传达简历内涵，<br>并按照外籍人士阅读习惯进行简历翻译。</td>
                                    <td>有外企面试需求、对英文简历专业化程度有一定<br>要求的高级白领人群，对内容专业度、英文简历<br>质量有高端要求的精英白领人</td>
                                </tr>
                            </table>
                        </li>
                        <li>
                            <table  class="table table-border table-bg  table-bordered  table-height65">
                                <tr class="bj">
                                    <th></th>
                                    <th>简历翻译</th>
                                    <th>译文审校</th>
                                    <th>英文简历排版</th>
                                    <th>简历修改</th>
                                    <th>格式转换</th>
                                    <th>母语润色</th>
                                </tr>
                                <tr>
                                    <td>普通级别</td>
                                    <td class="blue"><i class="icon iconfont">&#xe64d;</i></td>
                                    <td class="blue"><i class="icon iconfont">&#xe64d;</i></td>
                                    <td class="blue"><i class="icon iconfont">&#xe64d;</i></td>
                                    <td class="blue"></td>
                                    <td class="blue"></td>
                                    <td class="blue"></td>
                                </tr>
                                <tr>
                                    <td>母语润色</td>
                                    <td class="blue"><i class="icon iconfont">&#xe64d;</i></td>
                                    <td class="blue"><i class="icon iconfont">&#xe64d;</i></td>
                                    <td class="blue"><i class="icon iconfont">&#xe64d;</i></td>
                                    <td class="blue"><i class="icon iconfont">&#xe64d;</i></td>
                                    <td class="blue"><i class="icon iconfont">&#xe64d;</i></td>
                                    <td class="blue"><i class="icon iconfont">&#xe64d;</i></td>
                                </tr>
                            </table>
                        </li>
                        <li>
                            <table  class="table table-border table-bg  table-bordered  table-height65">
                                <tr class="bj">
                                    <th></th>
                                    <th>处理时间</th>
                                    <th>优惠价</th>
                                </tr>
                                <tr>
                                    <td>普通级别</td>
                                    <td>千字以内1个工作日；每超过一千字顺延1个工作日</td>
                                    <td>千字以内20元；超出部分，每超过500字，加收10元</td>
                                </tr>
                                <tr>
                                    <td>母语润色</td>
                                    <td>千字以内1个工作日；每超过一千字顺延1个工作日</td>
                                    <td>千字以内200元；超出部分，每超过500字，加收100元</td>
                                </tr>
                            </table>
                        </li>
                        <li class="mt-20">
                            <p>注：</p>
                            <p>1、简历模板内的内容均为非必填项，您可以按需填写，将只收取所填部分的费用；</p>
                            <p>2、20元为基本价格，限千字以内，超出部分需加收相应的费用；</p>
                        </li>
                        <li class="mt-20">
                            <p class="blue">口译</p>
                        </li>
                        <li>
                            <table  class="table table-border table-bg  table-bordered  table-height65">
                                <tr class="bj">
                                    <th width="13%">服务类别</th>
                                    <th width="13%">服务项目</th>
                                    <th width="13%">服务等级</th>
                                    <th width="61%">服务价格</th>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td style="padding:0;">
                                        <table class="table">
                                            <tr style="border:none">
                                                <td class="leftborder" colspan="2"  width="40%">A类语种</td>
                                                <td colspan="3" width="60%">B类语种</td>
                                            </tr>
                                            <tr>
                                                <td class="leftborder bottomborder"  width="20%">英语</td>
                                                <td class="bottomborder" width="20%">日语/韩语</td>
                                                <td class="bottomborder" width="20%">俄语/法语/德语</td>
                                                <td class="bottomborder" width="20%">西班牙语</td>
                                                <td class="bottomborder" width="20%">葡萄牙语</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding: 0;">陪同翻译</td>
                                    <td style="padding: 0;">短期陪同<br>（元/天）</td>
                                    <td style="padding: 0;">
                                        <table class="table">
                                            <tr>
                                                <td class="leftborder">技术陪同</td>
                                            </tr>
                                            <tr>
                                                <td class="leftborder">商务陪同</td>
                                            </tr>
                                            <tr>
                                                <td class="bottomborder leftborder">生活陪同</td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="padding: 0;">
                                        <table class="table">
                                            <tr>
                                                <td class="leftborder"  width="20%">1800</td>
                                                <td class="" width="20%">2200</td>
                                                <td class="" width="20%">2400</td>
                                                <td class="" width="20%">2600</td>
                                                <td class="" width="20%">3000</td>
                                            </tr>
                                            <tr>
                                                <td class=" leftborder"  width="20%">1600</td>
                                                <td class="" width="20%">1800</td>
                                                <td class="" width="20%">2000</td>
                                                <td class="" width="20%">2200</td>
                                                <td class="" width="20%">2500</td>
                                            </tr>
                                            <tr>
                                                <td class="bottomborder leftborder"  width="20%">1000</td>
                                                <td class="bottomborder" width="20%">1600</td>
                                                <td class="bottomborder" width="20%">1800</td>
                                                <td class="bottomborder" width="20%">2000</td>
                                                <td class="bottomborder" width="20%">2200</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding: 0;">陪同翻译</td>
                                    <td style="padding:0;" >
                                        <table class="table" width="100%">
                                            <tr>
                                                <td class="leftborder" >同声传译<br>（元/天/人）</td>
                                            </tr>
                                            <tr>
                                                <td class="leftborder bottomborder">交替传译<br>（元/天/人）</td>
                                            </tr>

                                        </table>
                                    </td>
                                    <td style="padding: 0;">
                                        <table class="table">
                                            <tr>
                                                <td class="leftborder">技术陪同</td>
                                            </tr>
                                            <tr>
                                                <td class="leftborder">商务陪同</td>
                                            </tr>
                                            <tr>
                                                <td class="leftborder">商务陪同</td>
                                            </tr>
                                            <tr>
                                                <td class="bottomborder leftborder">生活陪同</td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="padding: 0;">
                                        <table class="table">
                                            <tr>
                                                <td class="leftborder"  width="20%">6000</td>
                                                <td class="" width="20%">8000</td>
                                                <td class="" width="20%">10000</td>
                                                <td class="" width="20%">12000</td>
                                                <td class="" width="20%">17000</td>
                                            </tr>
                                            <tr>
                                                <td class=" leftborder"  width="20%">8000</td>
                                                <td class="" width="20%">10000</td>
                                                <td class="" width="20%">12000</td>
                                                <td class="" width="20%">14000</td>
                                                <td class="" width="20%">20000</td>
                                            </tr>
                                            <tr>
                                                <td class=" leftborder"  width="20%">5000</td>
                                                <td class="" width="20%">6000</td>
                                                <td class="" width="20%">8000</td>
                                                <td class="" width="20%">9000</td>
                                                <td class="" width="20%">10000</td>
                                            </tr>
                                            <tr>
                                                <td class="bottomborder leftborder"  width="20%">6000</td>
                                                <td class="bottomborder" width="20%">7000</td>
                                                <td class="bottomborder" width="20%">10000</td>
                                                <td class="bottomborder" width="20%">11000</td>
                                                <td class="bottomborder" width="20%">15000</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </li>
                    </ul>
                </div>
            </div>
            <div id="tab-xy4"  style="display: none;">
                <div class="agreement-word">
                    <ul>
                        <li>
                            <span class="icon1"></span>
                            <span class="icon2"></span>
                            <span class="icon3"></span>
                        </li>

                    </ul>
                </div>
            </div>
            <div id="tab-xy5"  style="display: none;">
                <div class="agreement-word">
                    <ul>
                        <li>
                            <p>译云传承40年的服务品质，整合全球服务资源，承诺保证所有译文的质量，不满意免费修改。</p>
                        </li>
                        <li>
                            <p class="blue">快速翻译</p>
                            <p>最快每分钟10个字，具体时间需根据翻译内容多少和难度而定；翻译完成48小时内，不满意可以提出申请，我们提供免费修改服务。</p>
                        </li>
                        <li>
                            <p class="blue">创意翻译</p>
                            <p>翻译完成后，除译文外，我们将同时提供翻译解释；翻译完成48小时内，不满意可以提出申请，我们提供免费修改服务。</p>
                        </li>
                        <li>
                            <p class="blue">证件翻译</p>
                            <p>翻译完成后，除了获得一份电子版的译文外，还可申请获得一份加盖我司公章的打印件；翻译完成48小时内，不满意可以提出申请，我们提供免费修改服务。</p>
                        </li>
                        <li>
                            <p class="blue">文档翻译</p>
                            <p>一般性的文档译员处理速度在2000-3000字/天，专业性特别强的内容，译员处理速度1500-2500字/天，处理速度和内容的领域和难度有关，具体时间请下单后咨询我们客服。</p>
                        </li>
                        <li>
                            <p class="blue">简历翻译</p>
                            <p>普通级别的简历翻译千字以内1个工作日，每超过一千字顺延1个工作日；母语润色级别的简历翻译千字以内1个工作日，每超过一千字顺延1个工作日；处理速度和内容的领域和难度有关，具体时间请下单后咨询我们客服。</p>
                        </li>

                    </ul>
                </div>
            </div>
            <div id="tab-xy6" style="display: none;">
                <div class="agreement-word">
                    <ul>
                        <li>我们深知您的资料的重要性，您的数据资料可能是关乎市场战略、企业发展，甚至是企业的成败，或者牵涉到您的个人隐私。译云建立了集技术与法律一体化的严格保密制度，对客户交付的所有资料，都实施严格的保密措施，妥善保管客户所交付的资料文件。</li>
                    </ul>
                </div>
            </div>


        </div>

    </div>
</div>
<a href="#0" class="cd-top"><i class="icon-angle-down"></i></a>

<!--底部-->
<%@include file="/inc/indexFoot.jsp" %>

<script type="text/javascript" src="${uedroot}/scripts/modular/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/frame.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/script.js"></script>
</body>
</html>
