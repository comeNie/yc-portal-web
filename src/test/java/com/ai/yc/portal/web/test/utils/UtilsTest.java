package com.ai.yc.portal.web.test.utils;

import com.ai.yc.order.api.orderallocation.param.OrdAllocationPersonInfo;
import com.ai.yc.order.api.orderallocation.param.OrderAllocationReceiveFollowInfo;
import com.ai.yc.protal.web.utils.PasswordMD5Util;
import com.alibaba.fastjson.JSON;
import org.junit.Test;
import org.springframework.web.bind.annotation.RequestMapping;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by liutong on 2017/3/22.
 */
public class UtilsTest {

    @Test
    public void test1(){
        BigDecimal discount = new BigDecimal(0.88);
        double dis = discount.doubleValue()*10;
        System.out.println(dis%1>0?Double.toString(dis):Integer.toString((int)dis));
        String md5Str = PasswordMD5Util.Md5Utils.md5("1234asdf");
        System.out.println(md5Str);
        Double d = 200d/10000;

        BigDecimal discountBig = new BigDecimal(200d/10000).setScale(4, RoundingMode.HALF_UP);
        System.out.println(discountBig.toString());
    }

    @Test
    public void test2(){
        List<OrderAllocationReceiveFollowInfo> followList = new ArrayList<>();
        OrderAllocationReceiveFollowInfo followInfo = new OrderAllocationReceiveFollowInfo();
        followInfo.setFollowId(12l);
        followInfo.setFinishState("12");
        followInfo.setOperType("12");
        followInfo.setStep("2");
        List<OrdAllocationPersonInfo> personInfos = new ArrayList<>();
        OrdAllocationPersonInfo personInfo = new OrdAllocationPersonInfo();
        personInfo.setInterperId("223");
        personInfo.setInterperFee(234l);
        personInfo.setPersonId(3234l);
        personInfo.setInterperName("3432");
        personInfos.add(personInfo);
        followInfo.setOrdAllocationPersonInfoList(personInfos);
        followList.add(followInfo);
        System.out.println(JSON.toJSONString(followList));

        List<OrderAllocationReceiveFollowInfo> followInfoList =
                JSON.parseArray(JSON.toJSONString(followList),OrderAllocationReceiveFollowInfo.class);
        System.out.println(followInfoList.size());
    }
}
