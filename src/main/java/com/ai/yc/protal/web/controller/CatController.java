package com.ai.yc.protal.web.controller;

import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ai.opt.base.vo.BaseResponse;
import com.ai.opt.sdk.components.dss.DSSClientFactory;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.dss.base.interfaces.IDSSClient;
import com.ai.yc.order.api.updateorder.interfaces.IUpdateOrderSV;
import com.ai.yc.order.api.updateorder.param.UpdateProdFileRequest;
import com.ai.yc.protal.web.constants.Constants;
import com.ai.yc.protal.web.model.Attachment;

@Controller
@RequestMapping("/cat")
public class CatController {
	@RequestMapping(value = "/upload")
	@ResponseBody
	public ResponseData<String> upload(
			@RequestParam(value = "file", required = false) MultipartFile file,String fileId) {
		if (file == null) {
			return new ResponseData<String>(
					ResponseData.AJAX_STATUS_FAILURE, "请选择上传文件", null);
		}
		IDSSClient client = DSSClientFactory
				.getDSSClient(Constants.IPAAS_ORDER_FILE_DSS);
		try {
			String transfileId = client.save(file.getBytes(),
					file.getOriginalFilename());
			Attachment attachment = new Attachment(file.getOriginalFilename(),
					transfileId, file.getSize());
			//调用文件修改服务
			IUpdateOrderSV iUpdateOrderSV = DubboConsumerFactory.getService(IUpdateOrderSV.class);
			UpdateProdFileRequest req = new UpdateProdFileRequest();
			req.setFileTranslateId(attachment.getFileId());
			req.setFileTranslateName(attachment.getFileName());
			BaseResponse base = iUpdateOrderSV.updateOrderFile(req);
			if(true==base.getResponseHeader().isSuccess()){
				return new ResponseData<String>(
						ResponseData.AJAX_STATUS_SUCCESS, "上传成功", "000000");
			}else{
				return new ResponseData<String>(
						ResponseData.AJAX_STATUS_FAILURE, "上传失败", "999999");
			}
		} catch (IOException e) {
			return new ResponseData<String>(
					ResponseData.AJAX_STATUS_FAILURE, "系统异常，请稍后重试", null);
		}

	}
}
