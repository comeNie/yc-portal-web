package com.ai.yc.protal.web.controller;

import com.ai.opt.base.exception.BusinessException;
import com.ai.opt.base.vo.BaseResponse;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.util.BeanUtils;
import com.ai.opt.sdk.util.CollectionUtil;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.opt.sso.client.filter.SSOClientConstants;
import com.ai.opt.sso.client.filter.SSOClientUtil;
import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.paas.ipaas.mcs.interfaces.ICacheClient;
import com.ai.yc.common.api.cachekey.key.CacheKey;
import com.ai.yc.common.api.cachekey.model.HomeDataConfig;
import com.ai.yc.protal.web.constants.LoginConstants;
import com.ai.yc.protal.web.model.user.UserCollectionTrans;
import com.ai.yc.protal.web.utils.AiPassUitl;
import com.ai.yc.protal.web.utils.UserUtil;
import com.ai.yc.user.api.usercollectiontranslation.interfaces.IYCUserCollectionSV;
import com.ai.yc.user.api.usercollectiontranslation.param.UserCollectionInfoRequest;
import com.ai.yc.user.api.usercollectiontranslation.param.UserCollectionInfoResponse;
import com.alibaba.fastjson.JSON;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Locale;

/**
 * Created by liutong on 16/11/5.
 */
@Controller
public class IndexController {
    private static final Logger LOGGER = LoggerFactory.getLogger(IndexController.class);
    /*
        首页待收藏的译文，临时存放标记
     */
    public static final String USER_COLLECT_TEMP = "userCollectTemp";
    @Autowired
    ResWebBundle rb;
    /**
     * 首页
     * @return
     */
    @RequestMapping("/home")
    public String indexView(Model uiModel){
        //获取基础数据
        ICacheClient cacheClient = AiPassUitl.getCacheClient();
        String homeDataStr = cacheClient.hget(CacheKey.HOME_DATA_CONFIG_KEY,CacheKey.HOME_DATA_CONFIG_KEY);

        HomeDataConfig homeDataCon = null;
        try {
            if (StringUtils.isBlank(homeDataStr)) {
                throw new BusinessException("未找到相关数据");
            }
            LOGGER.info("the footer date:{}",homeDataStr);
            homeDataCon = JSON.parseObject(homeDataStr, HomeDataConfig.class);
        } catch (Exception e) {
            LOGGER.error("Query the footer data failed.",e);
            homeDataCon = new HomeDataConfig();
            homeDataCon.setCustomNum("54900");//客户
            homeDataCon.setLgdataNum("26783000");//语料
            homeDataCon.setOrderNum("600892");//订单数量
            homeDataCon.setInterpreterNum("78239");//译员数量
            homeDataCon.setLanguageNum("60");//语种
        }

        uiModel.addAttribute("homeData",homeDataCon);
        return "/home";
    }

    /**
     * 适用于点击"登录"按钮后的跳转
     * @return
     */
    @RequestMapping("/p/index")
    public String ssoIndexView(){
        return "redirect:/";
    }

    /**
     * 单点退出
     * @param request
     * @param session
     * @return
     */
    @RequestMapping("/ssologout")
    public String ssoLogout(HttpServletRequest request,HttpSession session){
        String logOutServerUrl = SSOClientUtil.getLogOutServerUrlRuntime(request);
        String logOutBackUrl = SSOClientUtil.getLogOutBackUrlRuntime(request);
        try {
            if(UserUtil.getSsoUser()!=null){
                session.removeAttribute(SSOClientConstants.USER_SESSION_KEY);
                session.invalidate();
            }
        } catch (Exception e) {
            LOGGER.error("用户登出失败",e);
        }
        return "redirect:"+logOutServerUrl + "?service=" + logOutBackUrl;
    }

    /**
     * 笔译订单
     * @return
     */
    @RequestMapping("/written")
    public String writtenView(){
        return "forward:/order/create/text";
    }

    /**
     * 口译订单
     * @return
     */
    @RequestMapping("/oral")
    public String oralView(){
        return "forward:/order/create/oral";
    }

    /**
     * 关于我们
     * @return
     */
    @RequestMapping("/aboutus")
    public String aboutus(){
        return staticUrl()+"/about";
    }

    /**
     * 合作伙伴
     * @return
     */
    @RequestMapping("/client")
    public String client(){
        return staticUrl()+"/clients";
    }

    /**
     * 下单指南
     * @return
     */
    @RequestMapping("/guide")
    public String guide(){
        return staticUrl()+"/guide";
    }

    /**
     * 译者认证
     * @return
     */
    @RequestMapping("/tident")
    public String tident(){
        return staticUrl() + "/certification";
    }

    /**
     * 常見問題
     * @return
     */
    @RequestMapping("/faq")
    public String faq(){
        return staticUrl() + "/faq";
    }

    /**
     * 协议规则
     * @return
     */
    @RequestMapping("/agreement")
    public String agreement(){
        return staticUrl() + "/agreement";
    }

    /**
     * 服务说明
     * @return
     */
    @RequestMapping("/sexplain")
    public String sexplain(){
        return staticUrl() + "/sexplain";
    }

    /**
     * 服务协议
     * @return
     */
    @RequestMapping("/rule")
    public String serviceAgreement(){
        return staticUrl()+"/serviceAgreement";
    }
    /**
     * 译者咨询
     * @return
     */
    @RequestMapping("/tconsult")
    public String tconsul(){
        return staticUrl() + "/tconsul";
    }

    /**
     * 找翻译
     * @return
     */
    @RequestMapping("/findyee")
    public String findyee(){
        return staticUrl() + "/app";
    }

    /**
     * 服务
     * @return
     */
    @RequestMapping("/service")
    public String service(){
        return staticUrl() + "/service";
    }

    /**
     * 添加译文收藏
     */
    @RequestMapping("/collectTrans/add")
    @ResponseBody
    public ResponseData<String> addTranslation(UserCollectionTrans userCollectionTrans,HttpSession session){
        ResponseData<String> responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS,"OK");
        try{
            //若用户没有登录，则进行临时保存收藏信息
            if(UserUtil.getSsoUser() == null){
                session.setAttribute(USER_COLLECT_TEMP,userCollectionTrans);
                responseData = new ResponseData<String>(LoginConstants.AJAX_STATUS_LOGIN,"");
            }else {
                IYCUserCollectionSV userCollectionSV = DubboConsumerFactory.getService(IYCUserCollectionSV.class);
                UserCollectionInfoRequest collectionInfoRequest = new UserCollectionInfoRequest();
                BeanUtils.copyProperties(collectionInfoRequest, userCollectionTrans);
                collectionInfoRequest.setCollectionId(null);
                collectionInfoRequest.setUserId(UserUtil.getUserId());
                //收藏译文
                UserCollectionInfoResponse response = userCollectionSV.insertCollectionInfo(collectionInfoRequest);
                if(!response.getResponseHeader().isSuccess()){
                    throw new BusinessException(response.getResponseHeader().getResultCode()
                            ,response.getResponseHeader().getResultMessage());
                }else {//返回收藏记录的标识
                    responseData.setData(response.getCollectionId());
                }
//                responseData.setData("123");
                //清除收藏译文的缓存
                session.removeAttribute(USER_COLLECT_TEMP);
            }
        }catch (Exception e){
            LOGGER.error("add collect translation fail.",e);
            responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE
                    ,rb.getMessage("user.collect.add.fail"));
        }

        return responseData;
    }
    /**
     * 取消译文收藏
     * @param collectionIds  id集合的json串
     * @return
     */
    @RequestMapping("/collectTrans/del")
    @ResponseBody
    public ResponseData<String> delTranslation(String collectionIds){
        ResponseData<String> responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS,"OK");
        try{
            //若用户没有登录，则进行临时保存收藏信息
            if(UserUtil.getSsoUser() == null){
                responseData = new ResponseData<String>(LoginConstants.AJAX_STATUS_LOGIN,"");
            }//若译文ID不为空，则进行取消操作
            else if(StringUtils.isNotBlank(collectionIds)) {
                List<String> collectionIdList = JSON.parseArray(collectionIds,String.class);
                IYCUserCollectionSV userCollectionSV = DubboConsumerFactory.getService(IYCUserCollectionSV.class);
                BaseResponse response = null;
                if(!CollectionUtil.isEmpty(collectionIdList)){
                    UserCollectionInfoRequest collectionInfoReq = new UserCollectionInfoRequest();
                    collectionInfoReq.setCollectionIds(collectionIdList);
                    collectionInfoReq.setUserId(UserUtil.getUserId());
                    //取消译文收藏
                    response = userCollectionSV.deleteCollectionInfo(collectionInfoReq);
                }
                if(response != null && !response.getResponseHeader().isSuccess()){
                    LOGGER.error("del translation fail.\r\ncode={},message={}"
                            ,response.getResponseHeader().getResultCode()
                            ,response.getResponseHeader().getResultMessage());
                    throw new BusinessException(response.getResponseHeader().getResultCode()
                            ,response.getResponseHeader().getResultMessage());
                }
            }
        } catch (Exception e){
            LOGGER.error("del collect translation fail.",e);
            responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE
                    ,rb.getMessage("user.collect.del.fail"));
        }
        return responseData;
    }
    /**
     * 更新译文收藏
     * @param collectionId  id集合的json串
     * @param translation  译文
     * @return
     */
    @RequestMapping("/collectTrans/update/{collectionId}")
    @ResponseBody
    public ResponseData<String> updateTranslation(
            @PathVariable("collectionId") String collectionId, String translation){
        ResponseData<String> responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS,"OK");
        try{
            //若用户没有登录，则进行临时保存收藏信息
            if(UserUtil.getSsoUser() == null){
                responseData = new ResponseData<String>(LoginConstants.AJAX_STATUS_LOGIN,"");
            }//若译文ID和译文均不为空，则进行更新操作
            else if(StringUtils.isNotBlank(collectionId) && StringUtils.isNotBlank(translation)) {
                IYCUserCollectionSV userCollectionSV = DubboConsumerFactory.getService(IYCUserCollectionSV.class);
                UserCollectionInfoRequest collectionInfoRequest = new UserCollectionInfoRequest();
                collectionInfoRequest.setUserId(UserUtil.getUserId());//用户标识
                collectionInfoRequest.setCollectionId(collectionId);//收藏标识
                collectionInfoRequest.setTranslation(translation);//更新译文
                BaseResponse response = userCollectionSV.updateCollectionInfo(collectionInfoRequest);
                if(response != null && !response.getResponseHeader().isSuccess()){
                    LOGGER.error("update translation fail.\r\nhead={}",JSON.toJSONString(response.getResponseHeader()));
                    throw new BusinessException(response.getResponseHeader().getResultCode()
                            ,response.getResponseHeader().getResultMessage());
                }
            }
        } catch (Exception e){
            LOGGER.error("update collect translation fail.",e);
            responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE
                    ,rb.getMessage("user.collect.update.fail"));
        }
        return responseData;
    }
    private String staticUrl(){
        return Locale.SIMPLIFIED_CHINESE.equals(rb.getDefaultLocale())?"/static":"/staticEs";
    }
}
