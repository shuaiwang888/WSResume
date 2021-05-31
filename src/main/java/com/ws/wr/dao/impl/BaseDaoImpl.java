package com.ws.wr.dao.impl;

import com.alibaba.druid.pool.DruidDataSourceFactory;
import com.ws.wr.dao.BaseDao;
import com.ws.wr.util.Strings;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.sql.DataSource;
import java.io.InputStream;
import java.lang.reflect.ParameterizedType;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

//BaseDaoImpl用来抽取所有xxxImpl的公共代码（如删除方法）
public abstract class BaseDaoImpl<T> implements BaseDao<T> { // BaseDaoImpl<T>这里表明自己也是一个抽象类，不能写死Education或Website等
    //创建连接池
    protected static JdbcTemplate tpl; // 这是SpringJDBC的核心类(该框架省去了异常处理、打开和关闭资源等低级细节)
    static {
        try (InputStream is = WebsiteDaoImpl.class.getClassLoader().getResourceAsStream("druid.properties")){
            // 获取连接池
            Properties properties = new Properties();
            properties.load(is);
            DataSource ds = DruidDataSourceFactory.createDataSource(properties);
            // 创建tpl
            tpl = new JdbcTemplate(ds);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 自动生成表名
    private String table = table(); // 这样不用每次都调用table()
    protected String table() { // 获取表名education
        ParameterizedType superClassType = (ParameterizedType)getClass().getGenericSuperclass();
        Class beanCls = (Class) superClassType.getActualTypeArguments()[0];
        String clsName = beanCls.getSimpleName();
        return Strings.underLineCase(clsName);
    }

    public boolean remove(Integer id) {
        String sql = "DELETE FROM " + table + " WHERE id = ?";
        return tpl.update(sql, id) > 0;
    }
    public boolean remove(List<Integer> ids) {
        List<Object> args = new ArrayList<>();
        StringBuffer sql = new StringBuffer();
        //在传入多个id全部删除时的sql语句的拼接
        sql.append("DELETE FROM ").append(table).append(" WHERE id in (");
        for (Integer id : ids) {
            args.add(id);
            sql.append("?, ");
        }
        sql.replace(sql.length()-2, sql.length(), ")");
        return tpl.update(sql.toString(), args.toArray()) > 0;
    }

    public int count() {
        String sql = "SELECT COUNT(*) FROM " + table;
        return tpl.queryForObject(sql, new BeanPropertyRowMapper<>(Integer.class));
    }
}
