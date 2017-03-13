package com.ai.yc.protal.web.controller.user;

import com.ai.opt.base.exception.BusinessException;
import com.ai.opt.base.vo.BaseResponse;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.util.BeanUtils;
import com.ai.opt.sdk.util.CollectionUtil;
import com.ai.opt.sdk.util.StringUtil;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.yc.protal.web.model.user.UserCollectionTrans;
import com.ai.yc.protal.web.utils.UserUtil;
import com.ai.yc.user.api.usercollectiontranslation.interfaces.IYCUserCollectionSV;
import com.ai.yc.user.api.usercollectiontranslation.param.UserCollectionInfoRequest;
import com.alibaba.fastjson.JSON;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

/**
 * 用户收藏
 * Created by liutong on 2017/2/22.
 */
@Controller
@RequestMapping("/p/collectTrans")
public class CollectTransController {
    private static final Logger LOGGER = LoggerFactory.getLogger(CollectTransController.class);
    @Autowired
    ResWebBundle rb;

    /**
     * 展示用户收藏分页页面
     * @return
     */
    @RequestMapping("/listView")
    public String listView(){
        //TODO......
        return "";
    }

    /**
     * 更新收藏译文
     * @param userCollectionTrans
     * @return
     */
    @RequestMapping("/update")
    @ResponseBody
    public ResponseData<String> updateTranslation(UserCollectionTrans userCollectionTrans){
        ResponseData<String> responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS,"OK");
        try{
            IYCUserCollectionSV userCollectionSV = DubboConsumerFactory.getService(IYCUserCollectionSV.class);
            UserCollectionInfoRequest collectionInfoRequest = new UserCollectionInfoRequest();
            BeanUtils.copyProperties(collectionInfoRequest,userCollectionTrans);
            collectionInfoRequest.setUserId(UserUtil.getUserId());
            //更新收藏译文
            BaseResponse response = userCollectionSV.updateCollectionInfo(collectionInfoRequest);
            if(!response.getResponseHeader().isSuccess()){
                LOGGER.error("del translation fail.\r\ncode={},message={}"
                        ,response.getResponseHeader().getResultCode()
                        ,response.getResponseHeader().getResultMessage());
                throw new BusinessException(response.getResponseHeader().getResultCode()
                        ,response.getResponseHeader().getResultMessage());
            }
        }catch (Exception e){
            LOGGER.error("update collect translation fail.",e);
            responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE
                    ,rb.getMessage("user.collect.update.fail"));
        }
        return responseData;
    }
}
