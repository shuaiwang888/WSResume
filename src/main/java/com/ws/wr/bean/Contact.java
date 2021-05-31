package com.ws.wr.bean;

import com.ws.wr.bean.base.BaseBean;

public class Contact extends BaseBean {
    private String name;
    private String email;
    private String subject;
    private String comment;
    private Boolean alreadyRead = false;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Boolean getAlreadyRead() {
        return alreadyRead;
    }

    public void setAlreadyRead(Boolean alreadyRead) {
        this.alreadyRead = alreadyRead;
    }

    // 在这里重写父类的方法（年月日），写成新的方法（年月日时分秒）
//    public String getJson() throws Exception {
//        ObjectMapper mapper = new ObjectMapper();
//        mapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
//        return mapper.writeValueAsString(this).replace("\"", "'");
//    }
}
