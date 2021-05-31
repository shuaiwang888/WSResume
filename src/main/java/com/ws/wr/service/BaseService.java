package com.ws.wr.service;

import java.util.List;

public interface BaseService<T> {
    boolean remove(Integer id);
    boolean remove(List<Integer> ids);
    boolean save(T bean);
    T get(Integer id);
    List<T> list();
    int count();
}
