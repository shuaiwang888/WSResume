package com.ws.wr.bean;

import com.ws.wr.bean.base.DateBean;

public class Experience extends DateBean {
    private String job;
    private String intro;
    private Company company; // 这里是公司外键关联，更加面向对象

    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job;
    }

    public String getIntro() {
        return intro;
    }

    public void setIntro(String intro) {
        this.intro = intro;
    }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

//    public Integer getCompanyId() {
//        return company.getId();
//    }
}
