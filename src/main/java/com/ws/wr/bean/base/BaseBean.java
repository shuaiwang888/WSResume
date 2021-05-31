package com.ws.wr.bean.base;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.text.SimpleDateFormat;
import java.util.Date;

public abstract class BaseBean {
    private Integer id;
    private Date createdTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    // @JsonIgnore
    public Date getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(Date createdTime) {
        this.createdTime = createdTime;
    }

    // 这里的toString方法是使用了JSON第三方库Jackson，使得将java对象转换为JSON字符串给jsp中的edit()（编辑）方法显示原始值
    @JsonIgnore
    public String getJson() throws Exception {
        ObjectMapper mapper = new ObjectMapper();
        mapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")); // 设置转换日期格式,不然无法显示
        // 将默认生成的双引号替换成单引号i，防止与jsp中外面还有一个双引号发送冲突
        return mapper.writeValueAsString(this).replace("\"", "'");
    }
}
