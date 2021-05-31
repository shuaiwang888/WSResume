package com.ws.wr.bean;

import java.util.Date;

public class ContactListParam {
    // 查询留言信息时，需要发送这6个参数给服务器
    public static final int READ_ALL = 2;
    private Integer pageNo;
    private Integer pageSize;
    private Date beginDay;
    private Date endDay;
    private String keyword;
    /**
     * 0：未读
     * 1：已读
     * 2：全部
     */
    private Integer alreadyRead;

    public Integer getPageNo() {
        return pageNo;
    }

    public void setPageNo(Integer pageNo) {
        this.pageNo = pageNo;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public Date getBeginDay() {
        return beginDay;
    }

    public void setBeginDay(Date beginDay) {
        this.beginDay = beginDay;
    }

    public Date getEndDay() {
        return endDay;
    }

    public void setEndDay(Date endDay) {
        this.endDay = endDay;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public Integer getAlreadyRead() {
        return alreadyRead;
    }

    public void setAlreadyRead(Integer alreadyRead) {
        this.alreadyRead = alreadyRead;
    }
}
