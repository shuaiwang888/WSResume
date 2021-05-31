package com.ws.wr.dao.impl;

import com.ws.wr.bean.Skill;
import com.ws.wr.dao.SkillDao;
import org.springframework.jdbc.core.BeanPropertyRowMapper;

import java.util.ArrayList;
import java.util.List;

public class SkillDaoImpl extends BaseDaoImpl<Skill> implements SkillDao {
    @Override
    public boolean save(Skill bean) {
        Integer id = bean.getId();
        List<Object> args = new ArrayList<>();
        args.add(bean.getName());
        args.add(bean.getLevel());
        String sql;
        if (id == null || id < 1) { // 添加
            sql = "INSERT INTO skill(name, level) VALUES(?, ?)";
        } else {
            sql = "UPDATE skill SET name = ?, level = ? WHERE id = ?";
            args.add(id);
        }
        return tpl.update(sql, args.toArray()) > 0;
    }

    @Override
    public Skill get(Integer id) {
        String sql = "SELECT id, created_time, name, level FROM skill WHERE id = ?";
        return tpl.queryForObject(sql, new BeanPropertyRowMapper<>(Skill.class), id);
    }

    @Override
    public List<Skill> list() {
        String sql = "SELECT id, created_time, name, level FROM skill";
        return tpl.query(sql, new BeanPropertyRowMapper<>(Skill.class));
    }
}
