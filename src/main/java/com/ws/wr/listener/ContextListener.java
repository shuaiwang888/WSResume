package com.ws.wr.listener;

import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.converters.DateConverter;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.util.Date;

@WebListener()
public class ContextListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // 在项目启动（部署）的时候做一些一次性的操作（资源加载）
        System.out.println("contextInitialized------------------");

        // null参数表示允许值为null
        DateConverter dateConverter = new DateConverter(null);
        dateConverter.setPatterns(new String[]{"yyyy-MM-dd"});
        ConvertUtils.register(dateConverter, Date.class);

//        // 初始化日期转换格式，给教育经历的日期转换
//        // null参数表示允许值为null
//        DateConverter dateConverter = new DateConverter(null);
//        dateConverter.setPatterns(new String[]{"yyyy-MM-dd", "yyyy-MM-dd HH:mm:ss"});
//        ConvertUtils.register(dateConverter, Date.class);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // 回收资源
        System.out.println("contextDestroyed------------------");
    }
}
