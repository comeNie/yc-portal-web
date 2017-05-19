package com.ai.yc.protal.web.model;

public class CatLine {

	/**
	 * 语言对ID
	 */
	private String languageId;
	/**
	 * 原文附件
	 */
	private String fileId;
	/**
	 * 领域id
	 */
	private String fieldId;
	/**
	 * 产品文件id
	 */
	private String prodFileId;

	public String getLanguageId() {
		return languageId;
	}

	public void setLanguageId(String languageId) {
		this.languageId = languageId;
	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String getFieldId() {
		return fieldId;
	}

	public void setFieldId(String fieldId) {
		this.fieldId = fieldId;
	}

	public String getProdFileId() {
		return prodFileId;
	}

	public void setProdFileId(String prodFileId) {
		this.prodFileId = prodFileId;
	}

}
