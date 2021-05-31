package com.ws.wr.service.impl;

import com.ws.wr.bean.User;
import com.ws.wr.dao.UserDao;
import com.ws.wr.service.UserService;

public class UserServiceImpl extends BaseServiceImpl<User> implements UserService {
    @Override
    public User get(User user) {
        return ((UserDao) dao).get(user);
    }
}
