package com.ws.wr.servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.code.kaptcha.impl.DefaultKaptcha;
import com.google.code.kaptcha.util.Config;
import com.ws.wr.bean.UploadParams;
import com.ws.wr.bean.User;
import com.ws.wr.service.AwardService;
import com.ws.wr.service.SkillService;
import com.ws.wr.service.UserService;
import com.ws.wr.service.WebsiteService;
import com.ws.wr.service.impl.AwardServiceImpl;
import com.ws.wr.service.impl.SkillServiceImpl;
import com.ws.wr.service.impl.WebsiteServiceImpl;
import com.ws.wr.util.Uploads;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.fileupload.FileItem;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

@WebServlet("/user/*")
public class UserServlet extends BaseServlet<User> {
    private SkillService skillService = new SkillServiceImpl();
    private AwardService awardService = new AwardServiceImpl();
    private WebsiteService websiteService = new WebsiteServiceImpl();

    @Override
    //这里是为了在请求http://localhost:8080/wr/时，转发到首页
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uri = request.getRequestURI();
        String[] cmps = uri.split("/");
        String methodName = "/" + cmps[cmps.length - 1];
        if (methodName.equals(request.getContextPath())) {
            try {
                front(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            super.doGet(request, response);
        }
    }

    public void admin(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setAttribute("experiences", service.list().get(0)); // 拿到唯一的那个用户信息
        forward(request, response, "admin/user.jsp");
    }

    public void save(HttpServletRequest request, HttpServletResponse response) throws Exception {
        UploadParams uploadParams = Uploads.parseRequest(request);

        // 请求参数转成User
        User user = new User();
        BeanUtils.populate(user, uploadParams.getParams());

        // 从Session中拿到邮箱、密码(这两个是在个人信息中不能改的，所以直接在这里赋值，不然会报null错误)
        User loginUser = (User) request.getSession().getAttribute("user");
        user.setEmail(loginUser.getEmail());
        user.setPassword(loginUser.getPassword());

        // 处理用户的头像
        FileItem item = uploadParams.getFileParam("photoFile");
        user.setPhoto(Uploads.uploadImage(item, request, user.getPhoto()));

        if (service.save(user)) { // 保存成功
            redirect(request, response, "user/admin");

            // 更新session中的用户（并且在更改信息后也要重新保存到Session中，以便其他功能模块在Session中请求信息在旁边显示）
            request.getSession().setAttribute("user", user);
        } else {
            forwardError(request, response, "个人信息保存失败");
        }
    }

    // 登录(进行改造，AJAX发送异步请求)
    public void login(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 设置编码
        response.setContentType("text/json; charset=UTF-8");
        Map<String, Object> result = new HashMap();

        // 检查验证码(toLowerCase():忽略大小写)
        String  captcha = request.getParameter("captcha").toLowerCase();

        // 从Session中取出验证码
        String code = (String) request.getSession().getAttribute("code");
        if (!captcha.equals(code)) {
            // forwardError(request, response, "验证码不正确");
            result.put("success", false);
            result.put("msg", "验证码不正确");
        } else {
            // 检查用户名、密码
            User user = new User();
            BeanUtils.populate(user, request.getParameterMap());
            user = ((UserService) service).get(user);
            if (user != null) { // 用户名、密码正确
                // 登录成功后，将User对象放入Session中
                request.getSession().setAttribute("user", user);
                // redirect(request, response, "user/admin");
                result.put("success", true);
            } else { // 用户名、密码有问题
                // forwardError(request, response, "邮箱或密码不正确");
                result.put("success", false);
                result.put("msg", "邮箱或密码不正确");
            }
        }

        // 设置Cookie的存储时间(一个星期不会清楚，免登陆)
        Cookie cookie = new Cookie("JSESSIONID", request.getSession().getId());
        cookie.setMaxAge(3600 * 24 * 7);
        response.addCookie(cookie);

        response.getWriter().write(new ObjectMapper().writeValueAsString(result));
    }

    /**
     * 退出登录
     */
    public void logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 清除登录信息（将session中的用户删除）
        request.getSession().removeAttribute("user");

        // 重定向到登录页面
        redirect(request, response, "page/login.jsp");
    }

    // 密码操作
    public void password(HttpServletRequest request, HttpServletResponse response) throws Exception {
        forward(request, response, "admin/password.jsp");
    }

    // 更新密码
    public void updatePassword(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String oldPassword = request.getParameter("oldPassword");
        // 对比session中用户的密码
        User user = (User) request.getSession().getAttribute("user");
        if (!user.getPassword().equals(oldPassword)) {
            forwardError(request, response, "旧密码不正确");
            return;
        }

        // 保存新密码
        String newPassword = request.getParameter("newPassword");
        user.setPassword(newPassword);
        if (service.save(user)) { // 保存成功
            redirect(request, response, "page/login.jsp");
        } else {
            forwardError(request, response, "修改密码失败");
        }
    }


    // 验证码
    public void captcha(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 创建Katpcha对象
        DefaultKaptcha dk = new DefaultKaptcha();

        // 验证码的配置（加载kaptcha.properties）
        try (InputStream is = getClass().getClassLoader().getResourceAsStream("kaptcha.properties")) {
            Properties properties = new Properties();
            properties.load(is);

            Config config = new Config(properties);
            dk.setConfig(config);
        }

        // 生成验证码字符串
        String code = dk.createText(); // code就是图片上显示的文字信息

        // 存储到Session中(当客户端首次请求服务器时，就会创建一个全新的Session)
        HttpSession session = request.getSession();
        session.setAttribute("code", code.toLowerCase());

        // 生成验证码图片
        BufferedImage image = dk.createImage(code);

        // 设置返回数据的格式
        response.setContentType("image/jpeg");

        // 将图片数据写会到客户端
        ImageIO.write(image, "jpg", response.getOutputStream());
    }

    // 前台页面
    public void front(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 用户信息
        User user = service.list().get(0);
        request.setAttribute("user", user);

        // 提前切割出所有特征值
        // 个人特质
        request.setAttribute("trait", user.getTrait().split(","));
        // 兴趣爱好
        request.setAttribute("interests", user.getInterests().split(","));

        // 专业技能
        request.setAttribute("skills", skillService.list());
        // 获奖成就
        request.setAttribute("awards", awardService.list());
        // 网站的底部信息
        request.setAttribute("footer", websiteService.list().get(0).getFooter());

        forward(request, response, "front/user.jsp");
    }

}
