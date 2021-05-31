package com.ws.wr.dao;

import java.util.List;

public interface BaseDao<T> {
    boolean remove(Integer id);
    boolean remove(List<Integer> ids);
    boolean save(T bean);
    T get(Integer id);
    List<T> list();
    int count();
}
