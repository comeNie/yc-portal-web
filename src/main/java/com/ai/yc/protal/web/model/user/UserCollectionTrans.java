package com.ai.yc.protal.web.model.user;

import java.io.Serializable;

/**
 * 收藏译文
 * Created by liutong on 2017/2/22.
 */
public class UserCollectionTrans implements Serializable{
    private static final Long serialVersionUID = 1l;
    /**
     * 主键Id
     */
    private String collectionId;
    /**
     * 源语言
     */
    private String sourceLanguage;
    /**
     * 目标语言
     */
    private String targetLanguage;
    /**
     * 原文
     */
    private String  original;
    /**
     * 译文
     */
    private String translation;

    public String getCollectionId() {
        return collectionId;
    }

    public void setCollectionId(String collectionId) {
        this.collectionId = collectionId;
    }

    public String getSourceLanguage() {
        return sourceLanguage;
    }

    public void setSourceLanguage(String sourceLanguage) {
        this.sourceLanguage = sourceLanguage;
    }

    public String getTargetLanguage() {
        return targetLanguage;
    }

    public void setTargetLanguage(String targetLanguage) {
        this.targetLanguage = targetLanguage;
    }

    public String getOriginal() {
        return original;
    }

    public void setOriginal(String original) {
        this.original = original;
    }

    public String getTranslation() {
        return translation;
    }

    public void setTranslation(String translation) {
        this.translation = translation;
    }
}
