package com.ai.yc.protal.web.utils;

import java.sql.Timestamp;

/**
 * Created by liutong on 2017/4/5.
 */
public final class DateUtils  {
    private DateUtils(){}

    /**
     * 返回从当前时间延后指定秒之后的时间
     * @param afterSecond 需要延后的时间，单位：秒
     * @return
     */
    public static Timestamp afterNow(int afterSecond){
        return new Timestamp(System.currentTimeMillis()+afterSecond);
    }
}
