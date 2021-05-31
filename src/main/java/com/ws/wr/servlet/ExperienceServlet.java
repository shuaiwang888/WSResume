package com.ws.wr.servlet;

import com.ws.wr.bean.Company;
import com.ws.wr.bean.Experience;
import com.ws.wr.service.CompanyService;
import com.ws.wr.service.UserService;
import com.ws.wr.service.WebsiteService;
import com.ws.wr.service.impl.CompanyServiceImpl;
import com.ws.wr.service.impl.UserServiceImpl;
import com.ws.wr.service.impl.WebsiteServiceImpl;
import org.apache.commons.beanutils.BeanUtils;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/experience/*")
public class ExperienceServlet extends BaseServlet<Experience> {
    private CompanyService companyService = new CompanyServiceImpl();
    private UserService userService = new UserServiceImpl();
    private WebsiteService websiteService = new WebsiteServiceImpl();

    // 这张页面要获取其他功能模块的信息
    public void front(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setAttribute("user", userService.list().get(0));
        request.setAttribute("footer", websiteService.list().get(0).getFooter());
        request.setAttribute("experiences", service.list());
        forward(request, response, "front/experience.jsp");
    }

    public void admin(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setAttribute("experiences", service.list());
        request.setAttribute("companies", companyService.list()); // 这里查找companyService.list()的数据是为了在选择公司时关联
        forward(request, response, "admin/experience.jsp");
    }

    public void save(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Experience experience = new Experience();
        BeanUtils.populate(experience, request.getParameterMap());

        // 对公司信息做特殊处理
        Company company = new Company();
        company.setId(Integer.valueOf(request.getParameter("companyId")));
        experience.setCompany(company);

        if (service.save(experience)) { // 保存成功
            // 重定向到admin
            redirect(request, response, "experience/admin");
        } else { // 保存失败
            forwardError(request, response, "工作经验保存失败");
        }
    }

    public void remove(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String[] idStrs = request.getParameterValues("id");
        List<Integer> ids = new ArrayList<>();
        for (String i : idStrs) {
            ids.add(Integer.valueOf(i));
        }
        //删除逻辑
        if (service.remove(ids)) {
            redirect(request, response, "experience/admin");
        } else {
            forwardError(request, response, "工作经验删除失败");
        }
    }
}
