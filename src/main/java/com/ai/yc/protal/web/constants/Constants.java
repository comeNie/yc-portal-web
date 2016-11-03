package com.ai.yc.protal.web.constants;

public final class Constants {
	private Constants() {
	}

	public static final class Register {
		private Register() {
		}
		 /** 验证码ccs配置路径 */
        public static final String VERIFICATION_CCS_NAMESPACE = "/com/ai/opt/verification-code-config";
		 /** 缓存命名空间 */
        public static final String CACHE_NAMESPACE = "com.ai.yc.protal.web.register.cache";
	}

	public static final class PictureVerify {
		private PictureVerify() {
		}
		/** 图片验证码超时时间 */
		public static final String  DEFAULT_VERIFY_OVERTIME = "3600";
		/** 图片验证码超时时间key */
		public static final String VERIFY_OVERTIME_KEY = "picture_verifycode_overtime";
		/** 图片验证码key */
		public static final String VERIFY_IMAGE_KEY = "picture_verifycode_key";
		/** 图片验证码长度 */
		public static final int VERIFY_SIZE = 4;
	}

}