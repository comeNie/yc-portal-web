package com.ai.yc.portal.web.test.service;

import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.yc.protal.web.constants.Constants;
import com.ai.yc.translator.api.translatorservice.interfaces.IYCTranslatorServiceSV;
import com.ai.yc.translator.api.translatorservice.param.SearchYCTranslatorSkillListRequest;
import com.ai.yc.translator.api.translatorservice.param.YCTranslatorSkillListResponse;
import com.alibaba.fastjson.JSON;
import org.junit.Test;

/**
 * Created by liutong on 16/12/2.
 */
public class TranslatorServiceSVTest {

    @Test
    public void getTranslatorSkillListTest(){
        IYCTranslatorServiceSV userServiceSV = DubboConsumerFactory.getService(IYCTranslatorServiceSV.class);
        SearchYCTranslatorSkillListRequest searchYCUserReq = new SearchYCTranslatorSkillListRequest();
        searchYCUserReq.setTenantId(Constants.DEFAULT_TENANT_ID);
        searchYCUserReq.setUserId("4444313");
        YCTranslatorSkillListResponse userInfoResponse = userServiceSV.getTranslatorSkillList(searchYCUserReq);
        System.out.println(JSON.toJSONString(userInfoResponse));
    }
}
