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

}
