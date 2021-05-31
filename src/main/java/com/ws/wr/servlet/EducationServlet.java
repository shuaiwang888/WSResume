package com.ws.wr.servlet;

import com.ws.wr.bean.Education;
import com.ws.wr.service.UserService;
import com.ws.wr.service.WebsiteService;
import com.ws.wr.service.impl.UserServiceImpl;
import com.ws.wr.service.impl.WebsiteServiceImpl;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/education/*")
public class EducationServlet extends BaseServlet<Education> {
    private UserService userService = new UserServiceImpl();
    private WebsiteService websiteService = new WebsiteServiceImpl();

    public void front(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setAttribute("user", userService.list().get(0));
        request.setAttribute("footer", websiteService.list().get(0).getFooter());
        request.setAttribute("educations", service.list());
        forward(request, response, "front/education.jsp");
    }

    // 调用admin就是为了调用所有的教育经验（调list()）
    // 所以不是直接访问education.jsp，需要发送请求在这里，通过数据库操作后转发给education.jsp展示
    public void admin(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<Education> educations = service.list();
        request.setAttribute("educations", educations);
        forward(request, response, "admin/education.jsp");
    }

    // 在添加操作后发送请求到服务器，保存数据
    public void save(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Education education = new Education();
        BeanUtils.populate(education, request.getParameterMap());
        if (service.save(education)) { // 保存成功
            // 重定向到admin
            redirect(request, response, "education/admin");
        } else { // 保存失败
            forwardError(request, response, "教育信息保存失败");
        }
    }

//    public void remove(HttpServletRequest request, HttpServletResponse response) throws Exception {
//        Integer id = Integer.valueOf(request.getParameter("id"));
//        if (dao.remove(id)) {
//            response.sendRedirect(request.getContextPath() + "/education/admin");
//        } else {
//            request.setAttribute("error", "教育信息保存失败");
//            request.getRequestDispatcher("/page/error.jsp").forward(request, response);
//        }
//    }

    // 整合传入一个id(删除一个),还是多个id的删除方法实现
    public void remove(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String[] idStrs = request.getParameterValues("id");
        List<Integer> ids = new ArrayList<>();
        for (String i : idStrs) {
            ids.add(Integer.valueOf(i));
        }
        //删除逻辑
        if (service.remove(ids)) {
            redirect(request, response, "education/admin");
        } else {
            forwardError(request, response, "教育信息删除失败");
        }
    }
}
