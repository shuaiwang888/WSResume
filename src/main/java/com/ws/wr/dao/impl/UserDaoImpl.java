package com.ws.wr.dao.impl;

import com.ws.wr.bean.User;
import com.ws.wr.dao.UserDao;
import org.springframework.jdbc.core.BeanPropertyRowMapper;

import java.util.ArrayList;
import java.util.List;

public class UserDaoImpl extends BaseDaoImpl<User> implements UserDao {
    @Override
    public boolean save(User bean) {
        Integer id = bean.getId();
        List<Object> args = new ArrayList<>();
        args.add(bean.getPassword());
        args.add(bean.getEmail());
        args.add(bean.getPhoto());
        args.add(bean.getIntro());
        args.add(bean.getName());
        args.add(bean.getBirthday());
        args.add(bean.getAddress());
        args.add(bean.getPhone());
        args.add(bean.getJob());
        args.add(bean.getTrait());
        args.add(bean.getInterests());
        String sql;
        if (id == null || id < 1) { // 添加
            sql = "INSERT INTO user(password, email, photo, intro, name, birthday, address, p, job, trait, interests) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        } else {
            sql = "UPDATE user SET password = ?, email = ?, photo = ?, intro = ?, name = ?, birthday = ?, address = ?, phone = ?, job = ?, trait = ?, interests = ? WHERE id = ?";
            args.add(id);
        }
        return tpl.update(sql, args.toArray()) > 0;
    }

    @Override
    public User get(Integer id) {
        String sql = "SELECT id, created_time, password, email, photo, intro, name, birthday, address, phone, job, trait, interests FROM user WHERE id = ?";
        return tpl.queryForObject(sql, new BeanPropertyRowMapper<>(User.class), id);
    }

    @Override
    public List<User> list() {
        String sql = "SELECT id, created_time, password, email, photo, intro, name, birthday, address, phone, job, trait, interests FROM user";
        return tpl.query(sql, new BeanPropertyRowMapper<>(User.class));
    }

    // 为拿到登录客户端的邮箱密码进行验证
    @Override
    public User get(User user) {
        String sql = "SELECT id, created_time, password, email, photo, intro, name, birthday, address, phone, job, trait, interests FROM user WHERE email = ? AND password = ?";
        List<User> users = tpl.query(sql, new BeanPropertyRowMapper<>(User.class), user.getEmail(), user.getPassword());
        return users.isEmpty() ? null : users.get(0); // 不为空时返回唯一的邮箱密码
    }
}
