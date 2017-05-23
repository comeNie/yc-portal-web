package com.ai.yc.protal.web.controller.level;

import com.ai.opt.base.exception.BusinessException;
import com.ai.opt.base.exception.SystemException;
import com.ai.opt.base.vo.BaseListResponse;
import com.ai.opt.base.vo.BaseResponse;
import com.ai.opt.base.vo.PageInfo;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.util.CollectionUtil;
import com.ai.opt.sdk.util.UUIDUtil;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.slp.balance.api.incomeoutquery.interfaces.IncomeOutQuerySV;
import com.ai.slp.balance.api.incomeoutquery.param.FundBookQueryResponse;
import com.ai.slp.balance.api.incomeoutquery.param.IncomeDetail;
import com.ai.slp.balance.api.incomeoutquery.param.IncomeQueryRequest;
import com.ai.slp.balance.api.sendcoupon.interfaces.ISendCouponSV;
import com.ai.slp.balance.api.sendcoupon.param.DeductionCouponRequest;
import com.ai.slp.balance.api.sendcoupon.param.DeductionCouponResponse;
import com.ai.slp.balance.api.sendcoupon.param.FreezeCouponRequest;
import com.ai.yc.common.api.sysconfig.interfaces.IQuerySysConfigSV;
import com.ai.yc.common.api.sysconfig.param.MemberConfig;
import com.ai.yc.protal.web.constants.BalanceConstants;
import com.ai.yc.protal.web.constants.Constants;
import com.ai.yc.protal.web.model.pay.AccountBalanceInfo;
import com.ai.yc.protal.web.service.BalanceService;
import com.ai.yc.protal.web.utils.*;
import com.ai.yc.user.api.usergriwthvalue.interfaces.IYCUserGriwthValueSV;
import com.ai.yc.user.api.usergriwthvalue.param.UserGriwthValueListResponse;
import com.ai.yc.user.api.usergriwthvalue.param.UsrGriwthValueInfo;
import com.ai.yc.user.api.usergriwthvalue.param.UsrGriwthValuePageInfoRequest;
import com.ai.yc.user.api.userlevelchange.interfaces.IYCUserLevelChangeSV;
import com.ai.yc.user.api.userlevelchange.param.LevelInfoResponse;
import com.alibaba.fastjson.JSON;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 我的帐户
 * Created by lixiaokui on 16/11/14.
 */
@Controller
@RequestMapping("/p/level")
public class LevelController {
    private static final Logger LOGGER = LoggerFactory.getLogger(LevelController.class);
    @Autowired
    BalanceService balanceService;
    @Autowired
    ResWebBundle rb;

    /**
     * 显示我的级别页面
     * @return
     */
    @RequestMapping("/myLevel")
    public String toMylevel(Model uiModel){
        LOGGER.info("用户成长值,级别查询开始:");
        //用户当前的成长值
        try {
            LOGGER.info("获取级别查询服务======IYCUserLevelChangeSV:");
            IYCUserLevelChangeSV iycUserLevelChangeSV = DubboConsumerFactory.getService(IYCUserLevelChangeSV.class);
            LOGGER.info("调用级别查询服务======IYCUserLevelChangeSV:");
            LOGGER.info("用户id=========="+UserUtil.getUserId());
            LevelInfoResponse levelInfoResponse = iycUserLevelChangeSV.queryLevelInfo(UserUtil.getUserId());
            LOGGER.info("获取用户的成长值范围服务开始========IQuerySysConfigSV:");
            IQuerySysConfigSV iQuerySysConfigSV = DubboConsumerFactory.getService(IQuerySysConfigSV.class);
            MemberConfig config = iQuerySysConfigSV.getMemberConfig();
            LOGGER.info("成长值范围是====="+JSON.toJSONString(config));
            Map<String,Integer> levelMap = null;
            if ("0000".equals(config.getResponseHeader().getResultCode())||true==config.getResponseHeader().getIsSuccess()){
                levelMap = new HashMap<>();
                uiModel.addAttribute("levelGriwth",config);
                //普通会员
                levelMap.put("1",Integer.parseInt(config.getOrdinaryMember()));
                //黄金会员(运营后台)||vip(前台)
                levelMap.put("2",Integer.parseInt(config.getGoldMember()));
                //白金会员(运营后台)||svip会员(前台)
                levelMap.put("3",Integer.parseInt(config.getPlatinumMember()));
                //钻石会员(运营后台)||svip白金会员(前台)
                levelMap.put("4",Integer.parseInt(config.getMasonryMember()));
            }else {
                levelMap.put("1",0);
            }

            if ("0000".equals(levelInfoResponse.getResponseHeader().getResultCode())){
                uiModel.addAttribute("levelChanges",levelInfoResponse.getLevelInfos());
                uiModel.addAttribute("griwth",levelInfoResponse.getLevelInfos().get(0).getGriwthValue());
                uiModel.addAttribute("level",levelInfoResponse.getLevelInfos().get(0).getLevel());
                //不是最高级别的会员,则放入下一个级别
                if (!"4".equals(levelInfoResponse.getLevelInfos().get(0).getLevel())){
                    uiModel.addAttribute("nextLevel",Integer.parseInt(levelInfoResponse.getLevelInfos().get(0).getLevel())+1);
                    uiModel.addAttribute("nextGriwth",levelMap.get((Integer.parseInt(levelInfoResponse.getLevelInfos().get(0).getLevel())+1)+""));
                }
                if ("4".equals(levelInfoResponse.getLevelInfos().get(0).getLevel())){
                    uiModel.addAttribute("nextGriwth",levelMap.get("4"));
                }
            }
            if ("0001".equals(levelInfoResponse.getResponseHeader().getResultCode())){
                //如果级别不存在,则默认普通会员且成长值为0;
                uiModel.addAttribute("griwth",levelMap.get("1"));
                uiModel.addAttribute("level","1");
                //下个级别为vip会员,成长值为vip会员的成长值
                uiModel.addAttribute("nextGriwth",levelMap.get("2"));
                uiModel.addAttribute("nextLevel",2);
            }
        }catch (Exception e){
            LOGGER.error("查询成长值和级别失败:",e);
        }
        return "level/myLevel";
    }

    @RequestMapping("/griwthList")
    @ResponseBody
    public ResponseData<PageInfo<UsrGriwthValueInfo>> accountList(@RequestParam(value = "pageNo")int pageNO,
                                                            @RequestParam(value = "pageSize")int pageSize){
        ResponseData<PageInfo<UsrGriwthValueInfo>> resData =null;
        IYCUserGriwthValueSV iycUserGriwthValueSV = DubboConsumerFactory.getService(IYCUserGriwthValueSV.class);
        UsrGriwthValuePageInfoRequest usrGriwthValuePageInfoRequest = new UsrGriwthValuePageInfoRequest();
        try {
            usrGriwthValuePageInfoRequest.setUserId(UserUtil.getUserId());
            usrGriwthValuePageInfoRequest.setPageNo(pageNO);
            usrGriwthValuePageInfoRequest.setPageSize(pageSize);
            UserGriwthValueListResponse userGriwthValueListResponse = iycUserGriwthValueSV.queryGriwthValueInfo(usrGriwthValuePageInfoRequest);
            if (userGriwthValueListResponse.getResponseHeader().isSuccess()){
                resData = new ResponseData<PageInfo<UsrGriwthValueInfo>>(ResponseData.AJAX_STATUS_SUCCESS, "查询成功",userGriwthValueListResponse.getGetCollectionListByPage());
            }else {
                LOGGER.error("成长值查询结果失败!=====成长值分页对象:"+ JSON.toJSONString(userGriwthValueListResponse.getUsrGriwthValueListByPage));
                resData = new ResponseData<PageInfo<UsrGriwthValueInfo>>(ResponseData.AJAX_STATUS_FAILURE, "查询失败", null);
            }
        } catch (Exception e) {
            LOGGER.error("查询成长值分页失败:",e);
            resData = new ResponseData<PageInfo<UsrGriwthValueInfo>>(ResponseData.AJAX_STATUS_FAILURE, "查询收支失败");
        }
        return resData;
    }

}
