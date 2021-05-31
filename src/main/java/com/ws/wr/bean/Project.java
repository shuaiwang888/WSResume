package com.ws.wr.bean;

import com.ws.wr.bean.base.DateBean;

public class Project extends DateBean {
    private String name;
    private String intro;
    private String website;
    /**
     * 多张图片之间用逗号隔开
     */
    private String image;
    private Company company; // 这里是公司外键关联

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIntro() {
        return intro;
    }

    public void setIntro(String intro) {
        this.intro = intro;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }
}
