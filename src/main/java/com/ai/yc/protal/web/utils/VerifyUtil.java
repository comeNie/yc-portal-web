package com.ai.yc.protal.web.utils;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.util.Random;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ai.opt.sdk.components.mail.EmailFactory;
import com.ai.opt.sdk.components.mail.EmailTemplateUtil;
import com.ai.opt.sdk.components.mcs.MCSClientFactory;
import com.ai.opt.sdk.util.RandomUtil;
import com.ai.paas.ipaas.mcs.interfaces.ICacheClient;
import com.ai.yc.protal.web.constants.Constants.PictureVerify;
import com.ai.yc.protal.web.model.mail.SendEmailRequest;
import com.alibaba.fastjson.JSONObject;

public class VerifyUtil {
	private static final Logger LOGGER = LoggerFactory
			.getLogger(VerifyUtil.class);

	public static BufferedImage getImageVerifyCode(String namespace,
			String cacheKey, int width, int height) {
		// int width = 100, height = 38;
		BufferedImage image = new BufferedImage(width, height,
				BufferedImage.TYPE_INT_RGB);

		// 获取图形上下文
		Graphics g = image.getGraphics();

		// 设定背景色
		g.setColor(new Color(0xDCDCDC));
		g.fillRect(0, 0, width, height);

		// 画边框
		g.setColor(Color.lightGray);
		g.drawRect(0, 0, width - 1, height - 1);

		// 取随机产生的认证码
		String verifyCode = RandomUtil.randomString(PictureVerify.VERIFY_SIZE);
		// 将认证码存入缓存
		try {
			ICacheClient cacheClient = MCSClientFactory
					.getCacheClient(namespace);
			String overTimeStr = PictureVerify.DEFAULT_VERIFY_OVERTIME;
			JSONObject config = AiPassUitl.getVerificationCodeConfig();
			if (config != null
					&& config.containsKey(PictureVerify.VERIFY_OVERTIME_KEY)) {
				overTimeStr = config.getString(PictureVerify.VERIFY_OVERTIME_KEY);
			}

			cacheClient.setex(cacheKey, Integer.valueOf(overTimeStr),
					verifyCode);
			if (LOGGER.isDebugEnabled())
				LOGGER.debug("cacheKey=" + cacheKey + ",verifyCode="
						+ verifyCode);
			// 将认证码显示到图象中
			g.setColor(new Color(0x10a2fb));

			g.setFont(new Font("Atlantic Inline", Font.PLAIN, 30));
			String Str = verifyCode.substring(0, 1);
			g.drawString(Str, 8, 25);

			Str = verifyCode.substring(1, 2);
			g.drawString(Str, 28, 30);
			Str = verifyCode.substring(2, 3);
			g.drawString(Str, 48, 27);

			Str = verifyCode.substring(3, 4);
			g.drawString(Str, 68, 32);
			// 随机产生88个干扰点，使图象中的认证码不易被其它程序探测到
			Random random = new Random();
			for (int i = 0; i < 88; i++) {
				int x = random.nextInt(width);
				int y = random.nextInt(height);
				g.drawOval(x, y, 0, 0);
			}

			// 图象生效
			g.dispose();

		} catch (Exception e) {
			LOGGER.error("生成图片验证码错误", e);
		}
		return image;
	}

	/**
	 * 发送邮件
	 * 
	 * @param emailRequest
	 * @return
	 */
	public static boolean sendEmail(SendEmailRequest emailRequest) {
		boolean success = true;
		String htmlcontext = EmailTemplateUtil.buildHtmlTextFromTemplate(
				emailRequest.getTemplateRUL(), emailRequest.getData());
		try {
			EmailFactory.SendEmail(emailRequest.getTomails(),
					emailRequest.getCcmails(), emailRequest.getSubject(),
					htmlcontext);
		} catch (Exception e) {
			success = false;
			LOGGER.error(e.getMessage(), e);
		}
		return success;
	}

}
