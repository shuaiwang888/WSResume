package com.ws.wr.bean;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.ws.wr.bean.base.DateBean;

public class Education extends DateBean {
    // 教育信息特殊字段
    private String name;
    private String intro;
    /**
     * 0: 其它 1: 小学 2: 初中 3: 高中 4: 中专 5: 大专 6: 本科 7: 硕士 8: 博士
     */
    private Integer type; // type:学历，用Integer来存，只需标明每个整数对应的学历水平

    @JsonIgnore // json忽略这个类型转回到客户端(不用再返回给客户端显示，再如创建时间也不用)
    public String getTypeString() { // 用于数据库与客户端展示差异转换
        switch (type) {
            case 1: return "小学";
            case 2: return "初中";
            case 3: return "高中";
            case 4: return "中专";
            case 5: return "大专";
            case 6: return "本科";
            case 7: return "硕士";
            case 8: return "博士";
            default: return "其它";
        }
    }

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

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

}
