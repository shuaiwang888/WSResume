package com.ws.wr.dao;

import com.ws.wr.bean.User;

public interface UserDao extends BaseDao<User> {
    User get(User user);
}
