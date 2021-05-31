package com.ws.wr.bean;

import org.apache.commons.fileupload.FileItem;

import java.util.Map;

public class UploadParams {
    private Map<String, Object> params;
    private Map<String, FileItem> fileParams;

    public Map<String, Object> getParams() {
        return params;
    }

    public void setParams(Map<String, Object> params) {
        this.params = params;
    }

    public Map<String, FileItem> getFileParams() {
        return fileParams;
    }

    public void setFileParams(Map<String, FileItem> fileParams) {
        this.fileParams = fileParams;
    }

    public Object getParam(String name) {
        return params.get(name);
    }

    public FileItem getFileParam(String name) {
        return fileParams.get(name);
    }
}
