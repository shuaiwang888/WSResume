package com.ws.wr.servlet;

import com.ws.wr.service.BaseService;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.converters.DateConverter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.Date;

@SuppressWarnings("unchecked")
public abstract class BaseServlet<T> extends HttpServlet {
    // 自动生成
    protected BaseService<T> service = newService() ;
    protected BaseService<T> newService() {
        // com.ws.wr.servlet.AwardServlet
        // com.ws.wr.service.impl.AwardServiceImpl
        try {
            String clsName = getClass().getName()
                    .replace(".servlet.", ".service.impl.") // 这样写是为了严谨，防止类名重复为替换错误
                    .replace("Servlet", "ServiceImpl");
            return (BaseService<T>) Class.forName(clsName).newInstance();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 设置编码
            request.setCharacterEncoding("UTF-8");

            // 利用方法名调用方法
            String uri = request.getRequestURI(); //获取请求地址
            String[] cmps = uri.split("/"); //以划线作分割->[, crm, customer, list]
            String methodName = cmps[cmps.length - 1]; // 获取最后一个地址(list或save等)
            // 传入方法名和参数是后面两个的方法
            Method method = getClass().getMethod(methodName, HttpServletRequest.class, HttpServletResponse.class);
            method.invoke(this, request, response); // 回调
        } catch (Exception e) {
            e.printStackTrace(); // 这里的e一般抛出是InvocationTargetException

            // 抛出真正的问题到客户端展示
            Throwable cause = e;
            while (cause.getCause() != null) {
                cause = cause.getCause();
            }
            forwardError(request, response, cause.getClass().getName() + ": " + cause.getMessage());
        }
    }

    // 重定向
    protected void redirect (HttpServletRequest request, HttpServletResponse response, String path)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/" + path);
    }

    // 转发
    protected void forward(HttpServletRequest request, HttpServletResponse response, String path)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/page/" + path).forward(request, response);
    }

    // 转发错误信息到error.jsp
    protected void forwardError(HttpServletRequest request, HttpServletResponse response, String error)
            throws ServletException, IOException {
        request.setAttribute("error", error);
        forward(request, response, "error.jsp");
    }
}
