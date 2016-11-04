package com.ai.yc.protal.web.utils;

import com.ai.opt.sdk.components.mcs.MCSClientFactory;
import com.ai.paas.ipaas.mcs.interfaces.ICacheClient;
import com.ai.yc.protal.web.constants.Constants.Register;

public class AiPassUitl {
    
    /**
     * 获取缓存客户端 TODO 区分国内、国外
     * @return
     * @author mimw
     */
    public static ICacheClient getCacheClient() {
        //获取cache客户端
        ICacheClient iCacheClient = MCSClientFactory.getCacheClient(Register.CACHE_NAMESPACE);
        return iCacheClient;
    }
}
