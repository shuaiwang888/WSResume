package com.ws.wr.filter;

import jdk.nashorn.internal.ir.annotations.Ignore;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

// "/*":表示拦截客户端发给服务器的所有请求:注解方式
@WebFilter("/*")
public class LoginFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        // 请求前的处理
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        String uri = request.getRequestURI();

        if (uri.contains("/asset/")
                || uri.contains("/contact/save")) { // 由于其中有些css资源也包含路径admin，所以需要提前将asset这些资源放行，不然页面会很丑
            chain.doFilter(req, resp);
        } else if (uri.contains("/admin")
                || uri.contains("/save")
                || uri.contains("/remove")
                || uri.contains("/user/password")
                || uri.contains("/user/updatePassword")) { //只有这些情况才要验证是否登录
            Object user = request.getSession().getAttribute("user");
            if (user != null) { // 登录成功过
                chain.doFilter(req, resp); // 有句话才表示Filter放行请求给服务器，并且服务器才能有效返回
            } else { // 没有登录
                response.sendRedirect(request.getContextPath() + "/page/login.jsp");
            }
        } else {
            chain.doFilter(req, resp);
        }

        // 服务器响应后的处理
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
