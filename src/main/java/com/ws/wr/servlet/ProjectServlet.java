package com.ws.wr.servlet;

import com.ws.wr.bean.Company;
import com.ws.wr.bean.Project;
import com.ws.wr.bean.UploadParams;
import com.ws.wr.service.CompanyService;
import com.ws.wr.service.UserService;
import com.ws.wr.service.WebsiteService;
import com.ws.wr.service.impl.CompanyServiceImpl;
import com.ws.wr.service.impl.UserServiceImpl;
import com.ws.wr.service.impl.WebsiteServiceImpl;
import com.ws.wr.util.Uploads;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.fileupload.FileItem;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/project/*")
public class ProjectServlet extends BaseServlet<Project> {
    private CompanyService companyService = new CompanyServiceImpl();
    private UserService userService = new UserServiceImpl();
    private WebsiteService websiteService = new WebsiteServiceImpl();

    public void front(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setAttribute("user", userService.list().get(0));
        request.setAttribute("footer", websiteService.list().get(0).getFooter());
        request.setAttribute("projects", service.list());
        forward(request, response, "front/project.jsp");
    }

    public void admin(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setAttribute("projects", service.list());
        request.setAttribute("companies", companyService.list()); // 这里查找companyService.list()的数据是为了在选择公司时关联
        forward(request, response, "admin/project.jsp");
    }

    public void save(HttpServletRequest request, HttpServletResponse response) throws Exception {
        UploadParams uploadParams = Uploads.parseRequest(request);

        Project project = new Project();
        BeanUtils.populate(project, uploadParams.getParams()); // uploadParams.getParams() = params

        // 对公司信息做特殊处理
        Company company = new Company();
        company.setId(Integer.valueOf(uploadParams.getParam("companyId").toString()));
        project.setCompany(company);

        // 项目图片
        FileItem item = uploadParams.getFileParam("imageFile"); // uploadParams.getFileParams() = fileParams
        project.setImage(Uploads.uploadImage(item, request, project.getImage())); // 封装

        if (service.save(project)) { // 保存成功
            // 重定向到admin
            redirect(request, response, "project/admin");
        } else { // 保存失败
            forwardError(request, response, "项目经验保存失败");
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
            redirect(request, response, "project/admin");
        } else {
            forwardError(request, response, "项目经验删除失败");
        }
    }
}
