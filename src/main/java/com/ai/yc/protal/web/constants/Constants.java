package com.ai.yc.protal.web.constants;

public final class Constants {

	private Constants() {
	}

	public static final java.lang.String SUCCESS_CODE = "000000";

	public static final String ERROR_CODE = "111111";
	public static final String DEFAULT_TENANT_ID = "yeecloud";

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
		/** 注册手机验证码key */
		public static final String REGISTER_SEND_PHONE_CODE_KEY = "register_send_phone_code_";
		/** 注册手机验证码次数key */
		public static final String REGISTER_SEND_PHONE_CODE_COUNT_KEY = "register_send_phone_code_count_";
		
		/** 注册手机验证码最大次数超时时间key */
		public static final String REGISTER_SEND_PHONE_CODE_MAX_COUNT_OVERTIME_KEY = "register_phone_code_count_overtime";
	
		/** 注册手机验证码最多次数key */
		public static final String REGISTER_SEND_PHONE_CODE_MAX_COUNT_KEY = "register_phone_code_max_count";
		
		/** 注册手机验证码key */
		public static final String REGISTER_PHONE_CODE_OVERTIME_KEY = "register_phone_code_overtime";
	}

	public static final class PictureVerify {
		private PictureVerify() {
		}

		/** 图片验证码超时时间 */
		public static final String DEFAULT_VERIFY_OVERTIME = "3600";
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
		/** 手机验证码长度 */
		public static final String REGISTER_VERIFY_PHONE_KEY = "register_verify_phone_key";
		/** 短信验证码超时时间key */
		public static final String VERIFY_OVERTIME_KEY = "picture_verifycode_overtime";
		/** 短信验证码默认超时时候 */
		public static final String DEFAULT_VERIFY_OVERTIME = "1800";
	}
}
