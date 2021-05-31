package com.ws.wr.bean;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.ws.wr.bean.base.BaseBean;

public class Skill extends BaseBean {
    private String name;
    /**
     * 0：了解
     * 1：熟悉
     * 2：掌握
     * 3：精通
     */
    private Integer level;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    @JsonIgnore
    public String getLevelString() {
        switch (level) {
            case 1: return "熟悉";
            case 2: return "掌握";
            case 3: return "精通";
            default: return "了解";
        }
    }
}
