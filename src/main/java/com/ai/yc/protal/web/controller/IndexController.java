package com.ai.yc.protal.web.controller;

import com.ai.paas.ipaas.mcs.interfaces.ICacheClient;
import com.ai.yc.common.api.cachekey.key.CacheKey;
import com.ai.yc.common.api.cachekey.model.HomeDataConfig;
import com.ai.yc.protal.web.utils.AiPassUitl;
import com.alibaba.fastjson.JSON;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by liutong on 16/11/5.
 */
@Controller
public class IndexController {

    /**
     * 首页
     * @return
     */
    @RequestMapping("/home")
    public String indexView(Model uiModel){
        //获取基础数据
        ICacheClient cacheClient = AiPassUitl.getCacheClient();
        String homeDataStr = cacheClient.get(CacheKey.HOME_DATA_CONFIG_KEY);
        //TODO... 模拟数据
        HomeDataConfig homeDataCon = new HomeDataConfig();
        if (StringUtils.isNotBlank(homeDataStr)) {
            homeDataCon = JSON.parseObject(homeDataStr, HomeDataConfig.class);
        }
        homeDataCon.setCustomNum("54900");//客户
        homeDataCon.setLgdataNum("26783000");//语料
        homeDataCon.setOrderNum("600892");//订单数量
        homeDataCon.setInterpreterNum("78239");//译员数量
        homeDataCon.setLanguageNum("60");//语种
        uiModel.addAttribute("homeData",homeDataCon);
        return "/home";
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
}
