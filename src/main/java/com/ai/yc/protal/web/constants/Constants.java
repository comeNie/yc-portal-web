package com.ai.yc.protal.web.constants;

public final class Constants {

	private Constants() {
	}

	public static final java.lang.String SUCCESS_CODE = "000000";

	public static final String ERROR_CODE = "111111";
	public static final String DEFAULT_TENANT_ID = "yeecloud";
	//订单文档存储
	public static final String IPAAS_ORDER_FILE_DSS = "order-file-dss";

	/** 邮箱可重复发送时间 配置key */
	public static final String SEND_VERIFY_MAX_TIME_KEY = "/email_verifycode_send_maxtime";
	  /** IP发送邮件次数key */
    public static final String CACHE_KEY_IP_SEND_EMAIL_NUM = "band-email-ip-send-email-num";
    /** 邮件验证码超时时间 配置key */
	public static final String VERIFY_OVERTIME_KEY = "/email_verifycode_overtime";
	/** 缓存命名空间*/
    public static final String CACHE_NAMESPACE = "com.ai.yc.user.email.cache";
    /** ip可重复发送次数保存时间  配置key */
    public static final String IP_SEND_OVERTIME_KEY = "/email_ip_send_overtime";
    /** ip可重复发送次数 配置key */
    public static final String SEND_VERIFY_IP_MAX_NO_KEY = "/email_send_ip_maxno";
    /** 修改邮箱发送手机次数key */
    public static final String CACHE_KEY_UPDATE_SEND_EMAIL_NUM = "band-email-update-send-phone-num";
	
	public static final class Register {
		private Register() {
		}

		/** 验证码ccs配置路径 */
		public static final String VERIFICATION_CCS_NAMESPACE = "/com/ai/opt/verification-code-config";
		/** 缓存命名空间 */
		public static final String CACHE_NAMESPACE = "com.ai.yc.protal.web.register.cache";
		/** 注册邮件中文模版 */
		public static final String REGISTER_EMAIL_ZH_CN_TEMPLATE = "email/template/yc-register_zh_cn-mail.xml";
		/** 注册邮件英文模版 */
		public static final String REGISTER_EMAIL_EN_US_TEMPLATE = "email/template/yc-register_en_us-mail.xml";
		/** 邮箱校验 */
		public static final String CHECK_TYPE_EMAIL = "email";
		/** 手机校验 */
		public static final String CHECK_TYPE_PHONE = "phone";
		/** 校验通过 */
		public static final String CHECK_TYPE_SUCCESS = "1";
		/** 注册国家缓存key */
		public static final String REGISTER_COUNTRY_LIST_KEY = "register_country_list_key";
		/** 注册国家缓存超时时间 */
		public static final int REGISTER_COUNTRY_LIST_KEY_OVERTIME = 5 * 60;
		
	}

	public static final class PictureVerify {
		private PictureVerify() {
		}

		/** 图片验证码超时时间key */
		public static final String VERIFY_OVERTIME_KEY = "picture_verifycode_overtime";
		/** 图片验证码key */
		public static final String VERIFY_IMAGE_KEY = "picture_verifycode_key";
		/** 图片验证码长度 */
		public static final int VERIFY_SIZE = 4;
	}

	public final class PhoneVerify {
		private PhoneVerify() {
		}
		/** 手机验证码长度 */
		public static final int VERIFY_SIZE = 6;
		/** 注册手机验证码key */
		public static final String REGISTER_PHONE_CODE = "register_phone_code";
		/** 注册手机验证码超时时间 */
		public static final String REGISTER_PHONE_CODE_OVERTIME = "register_phone_code_overtime";
		/** 注册手机验证码当前发送次数key */
		public static final String REGISTER_PHONE_CODE_COUNT = "register_phone_code_count";
		/** 注册手机验证码最多次数key */
		public static final String REGISTER_PHONE_CODE_MAX_COUNT = "register_phone_code_max_count";
		/** 注册手机验证码最大次数超时时间key */
		public static final String REGISTER_PHONE_CODE_MAX_COUNT_OVERTIME = "register_phone_code_max_count_overtime";
		
		/** 资料修改手机验证码key */
		public static final String UPDATE_DATA_PHONE_CODE = "update_data_phone_code";
		/** 资料修改手机验证码超时时间 */
		public static final String UPDATE_DATA_PHONE_CODE_OVERTIME = "update_data_phone_code_overtime";
		/** 资料修改手机验证码当前发送次数key */
		public static final String UPDATE_DATA_PHONE_CODE_COUNT = "update_data_phone_code_count";
		/** 资料修改手机验证码最多次数key */
		public static final String UPDATE_DATA_PHONE_CODE_MAX_COUNT = "update_data_phone_code_max_count";
		/** 资料修改手机验证码最大次数超时时间key */
		public static final String UPDATE_DATA_PHONE_CODE_MAX_COUNT_OVERTIME = "update_data_phone_code_max_count_overtime";
	}
}
