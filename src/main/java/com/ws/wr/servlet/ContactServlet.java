package com.ws.wr.servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ws.wr.bean.Contact;
import com.ws.wr.bean.ContactListParam;
import com.ws.wr.service.ContactService;
import com.ws.wr.service.UserService;
import com.ws.wr.service.WebsiteService;
import com.ws.wr.service.impl.UserServiceImpl;
import com.ws.wr.service.impl.WebsiteServiceImpl;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/contact/*")
public class ContactServlet extends BaseServlet<Contact> {
    private UserService userService = new UserServiceImpl();
    private WebsiteService websiteService = new WebsiteServiceImpl();

    public void front(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setAttribute("user", userService.list().get(0));
        request.setAttribute("footer", websiteService.list().get(0).getFooter());
        forward(request, response, "front/contact.jsp"); // 这里是转发到front下的jsp
    }

    public void admin(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ContactListParam param = new ContactListParam();
        BeanUtils.populate(param, request.getParameterMap());
        request.setAttribute("result", ((ContactService) service).list(param));
        forward(request, response, "admin/contact.jsp");
    }

    public void save(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 检查验证码
        String code = (String) request.getSession().getAttribute("code"); // 输入的(在Session获取)
        String captcha = request.getParameter("captcha"); // 服务器发送的
        if (!code.equals(captcha)) {
            forwardError(request, response, "验证码错误");
            return;
        }

        Contact contact = new Contact();
        BeanUtils.populate(contact, request.getParameterMap());
        if (service.save(contact)) { // 保存成功
            redirect(request, response, "contact/front");
        } else {
            forwardError(request, response, "留言信息保存失败");
        }
    }

    // 查看后通过AJAX(异步)请求发送给服务器修改阅读状态的值，返回到客户端将其标为已读
    public void read(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Integer id = Integer.valueOf(request.getParameter("id"));

        Map<String, Object> result = new HashMap<>();
        if (((ContactService) service).read(id)) {
            result.put("success", true);
            result.put("msg", "查看成功");
        } else {
            result.put("success", false);
            result.put("msg", "查看失败");
        }

        response.setContentType("text/json; charset=UTF-8");
        response.getWriter().write(new ObjectMapper().writeValueAsString(result)); //发送给jsp
    }

    public void remove(HttpServletRequest request, HttpServletResponse response) throws Exception {

    }
}
