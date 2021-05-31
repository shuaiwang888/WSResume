package com.ws.wr.servlet;

import com.ws.wr.bean.Company;
import com.ws.wr.bean.UploadParams;
import com.ws.wr.util.Uploads;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.fileupload.FileItem;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/company/*")
public class CompanyServlet extends BaseServlet<Company> {
    public void admin(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<Company> companies = service.list();
        request.setAttribute("companies", companies);
        forward(request, response, "admin/company.jsp");
    }

    public void save(HttpServletRequest request, HttpServletResponse response) throws Exception {
        UploadParams uploadParams = Uploads.parseRequest(request);

        Company company = new Company();
        BeanUtils.populate(company, uploadParams.getParams()); // 写入非文件参数

        FileItem item = uploadParams.getFileParam("logoFile");
        company.setLogo(Uploads.uploadImage(item, request, company.getLogo())); // 封装

        if (service.save(company)) {
            redirect(request, response, "company/admin");
        } else {
            forwardError(request, response, "公司信息保存失败");
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
            redirect(request, response, "company/admin");
        } else {
            forwardError(request, response, "公司信息删除失败");
        }
    }
}
