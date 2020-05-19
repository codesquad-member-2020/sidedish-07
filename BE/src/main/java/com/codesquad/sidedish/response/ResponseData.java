package com.codesquad.sidedish.response;

public class ResponseData {

    public enum STATUS { SUCCESS, ERROR }

    private STATUS status;

    private Object content;

    public ResponseData(STATUS status, Object content) {
        this.status = status;
        this.content = content;
    }

    public String getStatus() {
        return status.name();
    }

    public Object getContent() {
        return content;
    }
}
