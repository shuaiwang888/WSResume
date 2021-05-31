package com.ws.wr.service;

import com.ws.wr.bean.User;

public interface UserService extends BaseService<User> {
    User get(User user);
}
