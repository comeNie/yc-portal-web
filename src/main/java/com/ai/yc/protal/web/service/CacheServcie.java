package com.ai.yc.protal.web.service;

import com.ai.paas.ipaas.mcs.interfaces.ICacheClient;
import com.ai.yc.common.api.cachekey.key.CacheKey;
import com.ai.yc.common.api.cachekey.model.SysDomain;
import com.ai.yc.common.api.cachekey.model.SysPurpose;
import com.ai.yc.protal.web.utils.AiPassUitl;
import com.alibaba.fastjson.JSON;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

/**
 * 缓存操作服务
 * Created by liutong on 16/11/15.
 */
@Service
public class CacheServcie {

    /**
     * 查询指定语言下的领域信息集合ß
     * @return
     */
    public List<SysDomain> getAllDomain(Locale locale){
        ICacheClient iCacheClient = AiPassUitl.getCacheClient();
        String domainStr;
        //若为中文
        /*if(Locale.SIMPLIFIED_CHINESE.equals(locale)){
            domainStr = iCacheClient.get(CacheKey.CN_DOMAIN_KEY);
        }else {
            domainStr = iCacheClient.get(CacheKey.EN_DOMAIN_KEY);
        }*/
//        return JSON.parseArray(domainStr,SysDomain.class);
        List<SysDomain> domainList = new ArrayList<SysDomain>();
        //领域 TODO... 模拟数据
        SysDomain sysDomain = new SysDomain();
        sysDomain.setDomainId("1");
        sysDomain.setDomainCn("医学");
        sysDomain.setDomainEn("yixue");
        sysDomain.setLanguage("zh");
        domainList.add(sysDomain);
        domainList.add(sysDomain);
        return domainList;
    }

    /**
     * 查询指定语言下的作用集合
     * @return
     */
    public List<SysPurpose> getAllPurpose(Locale locale){
        ICacheClient iCacheClient = AiPassUitl.getCacheClient();
//        String purposeStr;
//        //若为中文
//        if(Locale.SIMPLIFIED_CHINESE.equals(locale)){
//            purposeStr = iCacheClient.get(CacheKey.CN_PURPOSE_KEY);
//        }else {
//            purposeStr = iCacheClient.get(CacheKey.EN_PURPOSE_KEY);
//        }
//        return JSON.parseArray(purposeStr,SysPurpose.class);
        List<SysPurpose> purposeList = new ArrayList<SysPurpose>();
        //TODO... 模拟数据
        //用途
        SysPurpose sysPurpose = new SysPurpose();
        sysPurpose.setPurposeId("1");
        sysPurpose.setLanguage("zh");
        sysPurpose.setPurposeCn("专业论文");
        sysPurpose.setPurposeEn("zhuanYeLunWen");
        purposeList.add(sysPurpose);

        SysPurpose sysPurpose1 = new SysPurpose();
        sysPurpose1.setPurposeId("2");
        sysPurpose1.setLanguage("zh");
        sysPurpose1.setPurposeCn("简历");
        sysPurpose1.setPurposeEn("zhuanYeLunWen");
        purposeList.add(sysPurpose1);

        SysPurpose sysPurpose3 = new SysPurpose();
        sysPurpose3.setPurposeId("3");
        sysPurpose3.setLanguage("zh");
        sysPurpose3.setPurposeCn("产品说明");
        sysPurpose3.setPurposeEn("zhuanYeLunWen");
        purposeList.add(sysPurpose3);

        return purposeList;
    }

}
