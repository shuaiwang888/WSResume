package com.ws.wr.service.impl;

import com.ws.wr.dao.BaseDao;
import com.ws.wr.service.BaseService;

import java.util.List;

@SuppressWarnings("unchecked")
public abstract class BaseServiceImpl<T> implements BaseService<T> {
    // 自动生成
    protected BaseDao<T> dao = newDao();
    protected BaseDao<T> newDao() { // 就是下面两句的替换
        // com.ws.wr.service.impl.AwardServiceImpl
        // com.ws.wr.dao.impl.AwardDaoImpl
        try {
            String clsName = getClass().getName()
                    .replace(".service.", ".dao.") // 这样写是为了严谨，防止类名重复为替换错误
                    .replace("ServiceImpl", "DaoImpl");
            return (BaseDao<T>) Class.forName(clsName).newInstance();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 删除
     */
    public boolean remove(Integer id) {
        return dao.remove(id);
    }
    public boolean remove(List<Integer> ids) {
        return dao.remove(ids);
    }

    /**
     * 添加或更新
     */
    public boolean save(T bean) {
        return dao.save(bean);
    }

    /**
     * 获取单个对象
     */
    public T get(Integer id) {
        return dao.get(id);
    }

    /**
     * 获取多个对象
     */
    public List<T> list() {
        return dao.list();
    }

    /**
     * 获取统计值
     */
    public int count() {
        return dao.count();
    }

}
