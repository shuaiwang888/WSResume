package com.ws.wr.servlet;

import com.ws.wr.bean.Award;
import com.ws.wr.bean.UploadParams;
import com.ws.wr.util.Uploads;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/award/*")
public class AwardServlet extends BaseServlet<Award> {
//    private AwardService service = new AwardServiceImpl(); 已经在BaseServlet自动生成

    public void admin(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<Award> awards = service.list();
        request.setAttribute("awards", awards);
        forward(request, response, "admin/award.jsp");
    }

    // 在添加操作后发送请求到服务器，保存数据
    public void save(HttpServletRequest request, HttpServletResponse response) throws Exception {
        UploadParams uploadParams = Uploads.parseRequest(request);

        Award award = new Award();
        BeanUtils.populate(award, uploadParams.getParams()); // 写入非文件参数

        FileItem item = uploadParams.getFileParam("imageFile"); // 写入文件参数
        award.setImage(Uploads.uploadImage(item, request, award.getImage())); // 封装

        if (service.save(award)) {
            redirect(request, response, "award/admin");
        } else {
            forwardError(request, response, "获奖成就保存失败");
        }
    }

    // 整合传入一个id（删除一个），还是多个id
    public void remove(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String[] idStrs = request.getParameterValues("id");
        List<Integer> ids = new ArrayList<>();
        for (String idStr : idStrs) {
            ids.add(Integer.valueOf(idStr));
        }
        //删除逻辑
        if (service.remove(ids)) {
            redirect(request, response, "award/admin");
        } else {
            forwardError(request, response, "获奖成就删除失败");
        }
    }
}
