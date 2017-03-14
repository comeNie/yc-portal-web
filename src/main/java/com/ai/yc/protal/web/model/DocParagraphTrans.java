package com.ai.yc.protal.web.model;

import java.io.Serializable;

/**
 * 文档段落原文译文信息类
 * Created by liutong on 2017/3/14.
 */
public class DocParagraphTrans implements Serializable{
    private static final long serialVersionUID = 1l;
    //原文
    private String sourceText;
    //译文
    private String Translation;
    //原文长度，
    private int sourceLen;

    public String getSourceText() {
        return sourceText;
    }

    public void setSourceText(String sourceText) {
        this.sourceText = sourceText;
    }

    public String getTranslation() {
        return Translation;
    }

    public void setTranslation(String translation) {
        Translation = translation;
    }

    public int getSourceLen() {
        return sourceLen;
    }

    public void setSourceLen(int sourceLen) {
        this.sourceLen = sourceLen;
    }
}
