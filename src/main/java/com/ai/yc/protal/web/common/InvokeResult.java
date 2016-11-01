package com.ai.yc.protal.web.common;

public class InvokeResult {
    private Object data;
    private Object datas;
    private String message;
    private String result;
    
    public static InvokeResult datasSuccess(Object datas) {
        InvokeResult result = new InvokeResult();
        result.setDatas(datas);
        result.setResult("0");
        return result;
    }
    
    public static InvokeResult dataSuccess(Object data) {
        InvokeResult result = new InvokeResult();
        result.setData(data);
        result.setResult("0");
        return result;
    }
    
    public static InvokeResult failure(String message) {
        InvokeResult result = new InvokeResult();
        result.setMessage(message);
        result.setResult("1");
        return result;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public Object getDatas() {
        return datas;
    }

    public void setDatas(Object datas) {
        this.datas = datas;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }
}
