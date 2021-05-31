package com.ws.wr.bean;

import com.ws.wr.bean.base.BaseBean;

public class Award extends BaseBean {
    private String name;
    private String image;
    private String intro;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getIntro() {
        return intro;
    }

    public void setIntro(String intro) {
        this.intro = intro;
    }
}
