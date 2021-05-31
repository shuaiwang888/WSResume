package com.ws.wr.servlet;

import com.ws.wr.bean.Skill;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/skill/*")
public class SkillServlet extends BaseServlet<Skill> {
//    private SkillService service = new SkillServiceImpl(); // 左边是接口名称，右边是具体实现类

    public void admin(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<Skill> skills = service.list();
        request.setAttribute("skills", skills);
        forward(request, response, "admin/skill.jsp");
    }

    // 在添加操作后发送请求到服务器，保存数据
    public void save(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Skill skill = new Skill();
        BeanUtils.populate(skill, request.getParameterMap());
        if (service.save(skill)) { // 保存成功
            // 重定向到admin
            redirect(request, response, "skill/admin");
        } else { // 保存失败
            forwardError(request, response, "专业技能保存失败");
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
            redirect(request, response, "skill/admin");
        } else {
            forwardError(request, response, "专业技能删除失败");
        }
    }
}
