package com.ws.wr.dao.impl;

import com.ws.wr.bean.Company;
import com.ws.wr.dao.CompanyDao;
import org.springframework.jdbc.core.BeanPropertyRowMapper;

import java.util.ArrayList;
import java.util.List;

public class CompanyDaoImpl extends BaseDaoImpl<Company> implements CompanyDao {

    @Override
    public boolean save(Company bean) {
        Integer id = bean.getId();
        List<Object> args = new ArrayList<>();
        args.add(bean.getName());
        args.add(bean.getLogo());
        args.add(bean.getWebsite());
        args.add(bean.getIntro());
        String sql;
        if (id == null || id < 1) { // 添加
            sql = "INSERT INTO company(name, logo, website, intro) VALUES(?, ?, ?, ?)";
        } else {
            sql = "UPDATE company SET name = ?, logo = ?, website = ?, intro = ? WHERE id = ?";
            args.add(id);
        }
        return tpl.update(sql, args.toArray()) > 0;
    }

    @Override
    public Company get(Integer id) {
        String sql = "SELECT id, created_time, name, logo, website, intro FROM company WHERE id = ?";
        return tpl.queryForObject(sql, new BeanPropertyRowMapper<>(Company.class), id);
    }

    @Override
    public List<Company> list() {
        String sql = "SELECT id, created_time, name, logo, website, intro FROM company";;
        return tpl.query(sql, new BeanPropertyRowMapper<>(Company.class));
    }
}
