package com.ai.yc.portal.web.test.utils;

import com.ai.yc.protal.web.utils.PasswordMD5Util;
import org.junit.Test;

import java.math.BigDecimal;
import java.math.RoundingMode;

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
}
