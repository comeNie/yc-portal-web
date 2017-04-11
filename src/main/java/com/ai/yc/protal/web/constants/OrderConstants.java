package com.ai.yc.protal.web.constants;

/**
 * Created by liutong on 16/11/11.
 */
public final class OrderConstants {
    private OrderConstants(){

    }
    //个人类型订单
    public static final String ORDER_TYPE_PERSON = "1";
    //企业类型订单
    public static final String ORDER_TYPE_ENTERPRISE = "2";

    //用户类型 个人
    public static final String USER_TYPE_PERSON = "10";
    //用户类型 企业
    public static final String USER_TYPE_ENTERPRISE = "11";
    //用户类型 代理人
    public static final String USER_TYPE_AGENT = "12";

    //前台查询订单轨迹flag
    public static final String STATECHG_FLAG = "0";

    public static class ErrorCode{
        private ErrorCode(){}

        /**
         * 订单领取到达上限
         */
        public static final String NUM_MAX_LIMIT = "100001";
        /**
         * 订单已被领取
         */
        public static final String ALREADY_CLAIM = "100002";
    }

    /**
     * 订单类型
     */
    public static class TranslateType{
        private TranslateType(){}

        /*
        文本
         */
        public static final String TEXT = "0";
        /*
        文档
         */
        public static final String DOC = "1";
        /*
        口译
         */
        public static final String ORAL = "2";
    }
   
    /**
     * 后台状态
     */
    public static class State{
        private State(){}
        
        /**
         *提交
         */
        public static final String SUBMIT = "10";
        
        /**
         * 待支付
         */
        public static final String UN_PAID = "11";
        
        /**
         * 已支付
         */
        public static final String PAID = "12";
        
        /**
         * 待报价
         */
        public static final String UN_PRICE = "13";
        
        /**
         * 待领取
         */
        public static final String UN_RECEIVE = "20";
        
        /**
         * 已领取
         */
        public static final String RECEIVE = "21";
        
        /**
         * 已分配
         */
        public static final String ASSIGNED = "211";
        
        /**
         * 翻译中
         */
        public static final String TRANSLATING = "23";
        
        /**
         * 已提交
         */
        public static final String SUBMITTED = "24";
        
        /**
         * 修改中
         */
        public static final String MODIFIY = "25";
        
        /**
         * 待审核
         */
        public static final String UN_CHECK = "40";

        /**
         * 审核通过
         */
        public static final String CHECK_SUCCESS = "41";
        
        /**
         * 审核失败
         */
        public static final String CHECK_FAIL = "42";
        
        /**
         * 待确认
         */
        public static final String UN_CONFIRM = "50";
        
        /**
         * 已确认
         */
        public static final String CONFIRMED = "51";
        
        /**
         * 待评价
         */
        public static final String UN_EVALUATE = "52";
        
        /**
         * 已评价
         */
        public static final String EVALUATED = "53";
        
        /**
         * 完成 
         */
        public static final String FINISH = "90";
        
        /**
         * 关闭（取消）
         */
        public static final String CLOSE = "91";
        
        /**
         * 已退款
         */
        public static final String REFUNDED = "92";
    }

    /**
     * 客户端显示状态
     */
    public static class DisplayState{
        private DisplayState(){}
        
        /**
         * 待支付
         */
        public static final String UN_PAID = "11";
        
        /**
         * 待报价
         */
        public static final String UN_PRICE = "13";
        
        /**
         * 翻译中
         */
        public static final String TRANSLATING = "23";
        
        /**
         * 待确认
         */
        public static final String UN_CONFIRM = "50";
        
        /**
         * 待评价
         */
        public static final String UN_EVALUATE = "52";
        
        /**
         * 完成 
         */
        public static final String FINISH = "90";
        
        /**
         * 关闭（取消）
         */
        public static final String CLOSE = "91";
        
        /**
         * 已退款
         */
        public static final String REFUNDED = "92";
    }

    /**
     * 订单步骤的完成状态
     */
    public static class FollowVoFinishState{
        private FollowVoFinishState(){}

        /**
         * 未开始
         */
        public static final String  NOT_START = "0";
        /**
         * 进行中
         */
        public static final String  IN_PROGRESS = "1";
        /**
         * 已完成
         */
        public static final String FINISH = "2";
    }

    /**
     * 订单步骤领取状态
     */
    public static class FollowVoReceiveState{
        private FollowVoReceiveState(){}

        /**
         * 未领取
         */
        public static final String UNCLAIMED = "0";
        /**
         * 已领取
         */
        public static final String RECEIVE = "1";
    }
}
