<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en" class="crt crt-nav-on crt-nav-type1 crt-main-nav-on crt-sidebar-on crt-layers-2">
<head>
    <%@ include file="common/style.jsp" %>
    <title>${user.name}-联系我吧</title>
</head>
<body class="">
    <div class="crt-wrapper">
        <%@ include file="common/smallNav.jsp" %>

        <div id="crt-container" class="crt-container">
            <%@ include file="common/bigNav.jsp" %>
            <div class="crt-container-sm">
                <div class="crt-paper-layers">
                    <div class="crt-paper clear-mrg">
                        <div class="crt-paper-cont paper-padd clear-mrg">
                            <div class="padd-box">
                                <h2 class="title-lg text-upper">联系我吧</h2>
                                <div class="padd-box-xs">
                                    <header class="contact-head">
                                        <h3 class="title text-upper">可以随时联系我！</h3>
                                    </header>
                                </div>
                                <div class="padd-box-sm">
                                    <form action="${ctx}/contact/save" method="post" class="contact-form">
                                        <div class="form-group">
                                            <label class="form-label" for="name">您的姓名</label>
                                            <div class="form-item-wrap">
                                                <input id="name" name="name" maxlength="20" class="form-item" type="text" required>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="form-label" for="email">您的邮箱</label>
                                            <div class="form-item-wrap">
                                                <input id="email" name="email" maxlength="50" class="form-item" type="email" required>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="form-label" for="subject">您的主题</label>
                                            <div class="form-item-wrap">
                                                <input id="subject" name="subject" class="form-item" type="text">
                                            </div>
                                        </div>
                                        <div class="form-group"><label class="form-label" for="comment">您的留言</label>
                                            <div class="form-item-wrap">
                                                <textarea id="comment" name="comment" class="form-item" required></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="form-label" for="captcha">验证码</label>
                                            <div class="form-item-wrap">
                                                <input id="captcha" name="captcha" class="form-item" type="text" required>
                                                <img src="${ctx}/user/captcha" id="captchaImage" alt="">
                                            </div>
                                        </div>
                                        <div class="form-submit form-item-wrap">
                                            <input class="btn btn-primary btn-lg" type="submit" value="发布您的留言"
                                                   onclick="public()">
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- .crt-paper -->
                </div><!-- .crt-paper-layers -->
            </div><!-- .crt-container-sm -->
        </div>

        <%@ include file="common/foot.jsp" %>
    </div><!-- .crt-wrapper --><!-- Scripts -->
    <%@ include file="common/script.jsp" %>
    <script>
        // 验证码
        $('#captchaImage').click(function () {
            $(this).hide().attr('src', '${ctx}/user/captcha?time=' + new Date().getTime()).fadeIn()
        })

        function public() {
            console.log('发布成功')
        }
    </script>
</body>
</html>