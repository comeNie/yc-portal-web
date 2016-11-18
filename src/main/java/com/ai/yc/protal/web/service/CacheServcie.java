package com.ai.yc.protal.web.service;

import com.ai.paas.ipaas.mcs.interfaces.ICacheClient;
import com.ai.yc.common.api.cachekey.key.CacheKey;
import com.ai.yc.common.api.cachekey.model.SysDomain;
import com.ai.yc.common.api.cachekey.model.SysDuad;
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
     * 获取指定语言下订单的语言对
     * @param locale
     * @return
     */
    public List<SysDuad> getAllDuad(Locale locale){
        List<SysDuad> duadList = new ArrayList<SysDuad>();
        /*
        ICacheClient iCacheClient = AiPassUitl.getCacheClient();
        String duadStr = iCacheClient.get(CacheKey.CN_DUAD_KEY);
        duadList = JSONObject.parseArray(duadStr, SysDuad.class);
        */
        //TODO...模拟数据
        SysDuad sysDuad = new SysDuad();
        sysDuad.setDuadId("1");
        sysDuad.setLanguage("zh");
        sysDuad.setSourceCn("中文");
        sysDuad.setSourceEn("zh");
        sysDuad.setTargetCn("英文");
        sysDuad.setTargetEn("en");
        sysDuad.setOrdinary("100");
        sysDuad.setOrdinaryUrgent("150");
        sysDuad.setProfessional("200");
        sysDuad.setProfessionalUrgent("250");
        sysDuad.setPublish("300");
        sysDuad.setPublishUrgent("350");
        sysDuad.setOrdinaryDollar("10");
        sysDuad.setOurgentDollar("20");
        sysDuad.setProfessionalDollar("30");
        sysDuad.setPurgentDollar("40");
        sysDuad.setPublishDollar("50");
        sysDuad.setPuburgentDollar("60");
        
        
        SysDuad sysDuad1 = new SysDuad();
        sysDuad1.setDuadId("1");
        sysDuad1.setLanguage("zh");
        sysDuad1.setSourceCn("中文2");
        sysDuad1.setSourceEn("zh");
        sysDuad1.setTargetCn("英文3");
        sysDuad1.setTargetEn("en");
        sysDuad1.setOrdinary("100");
        sysDuad1.setOrdinaryUrgent("150");
        sysDuad1.setProfessional("200");
        sysDuad1.setProfessionalUrgent("250");
        sysDuad1.setPublish("300");
        sysDuad1.setPublishUrgent("350");
        sysDuad1.setOrdinaryDollar("10");
        sysDuad1.setOurgentDollar("20");
        sysDuad1.setProfessionalDollar("30");
        sysDuad1.setPurgentDollar("40");
        sysDuad1.setPublishDollar("50");
        sysDuad1.setPuburgentDollar("60");
        duadList.add(sysDuad);
        duadList.add(sysDuad1);
        return duadList;
    }

    /**
     * 查询指定语言下的领域信息集合
     * @return
     */
    public List<SysDomain> getAllDomain(Locale locale){
        ICacheClient iCacheClient = AiPassUitl.getCacheClient();
        String domainStr;
        //目前全部为中文数据
//        domainStr = iCacheClient.get(CacheKey.CN_DOMAIN_KEY);
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
        //目前全部为中文数据
//        String purposeStr = iCacheClient.get(CacheKey.CN_PURPOSE_KEY);
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
