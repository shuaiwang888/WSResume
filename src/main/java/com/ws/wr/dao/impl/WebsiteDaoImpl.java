package com.ws.wr.dao.impl;

import com.ws.wr.bean.Website;
import com.ws.wr.dao.WebsiteDao;
import org.springframework.jdbc.core.BeanPropertyRowMapper;

import java.util.ArrayList;
import java.util.List;

public class WebsiteDaoImpl extends BaseDaoImpl<Website> implements WebsiteDao {
    /**
     * 添加或更新
     */
    public boolean save(Website bean) {
        Integer id = bean.getId();
        List<Object> args = new ArrayList<>();
        args.add(bean.getFooter());
        String sql;
        if (id == null || id < 1) { // 添加
            sql = "INSERT INTO website(footer) VALUES(?)";
        } else { // 更新(传id时)
            sql = "UPDATE website SET footer = ? WHERE id = ?";
            args.add(id);
        }
        return tpl.update(sql, args.toArray()) > 0;
    }

    /**
     * 获取单个对象
     */
    public Website get(Integer id) {
        return null;
    }

    /**
     * 获取多个对象
     */
    public List<Website> list() {
        String sql = "SELECT id, created_time, footer FROM website";
        //BeanPropertyRowMapper<>(mappedClass) 也是SpringJDBC的方法
        return tpl.query(sql, new BeanPropertyRowMapper<>(Website.class));
    }
}
