<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>App Store简历管理-修改密码</title>
    <%@ include file="common/style.jsp" %>
</head>

<body class="theme-blue">
<%@ include file="common/nav.jsp" %>

<section class="content">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <div class="card">
                    <div class="header">
                        <h2>修改密码</h2>
                    </div>
                    <div class="body">
                        <form class="form-validation" method="post" action="${ctx}/user/updatePassword">
                            <div class="row">
                                <div class="col-lg-2 col-md-2 col-sm-3 col-xs-3 form-control-label">
                                    <label for="oldPassword">旧密码</label>
                                </div>
                                <div class="col-lg-10 col-md-10 col-sm-9 col-xs-9">
                                    <div class="form-group">
                                        <div class="form-line">
<%--                                            这里处理是为了不会讲客户端真实输入的密码发送服务器，而是将MD5处理之后的才发，新密码也是如此--%>
                                            <input type="hidden" name="oldPassword">
<%--                                            去掉的输入框的name，就不会发过去--%>
                                            <input type="password" id="oldPassword"
                                                   maxlength="20" class="form-control"
                                                   placeholder="旧密码"
                                                   required>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-2 col-md-2 col-sm-3 col-xs-3 form-control-label">
                                    <label for="newPassword">新密码</label>
                                </div>
                                <div class="col-lg-10 col-md-10 col-sm-9 col-xs-9">
                                    <div class="form-group">
                                        <div class="form-line">
                                            <input type="hidden" name="newPassword">
                                            <input type="password" id="newPassword" maxlength="20" class="form-control"
                                                   placeholder="新密码"
                                                   required>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-2 col-md-2 col-sm-3 col-xs-3 form-control-label">
                                    <label for="confirm">确认</label>
                                </div>
                                <div class="col-lg-10 col-md-10 col-sm-9 col-xs-9">
                                    <div class="form-group">
                                        <div class="form-line">
                                            <input type="password" id="confirm" class="form-control"
                                                   placeholder="确认" maxlength="20"
                                                   required>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-lg-offset-2 col-md-offset-2 col-sm-offset-3 col-xs-offset-3">
                                    <button class="btn btn-primary waves-effect m-l-15" type="submit">保存</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<%@ include file="common/script.jsp" %>
<script src="${ctx}/asset/plugin/JavaScript-MD5/md5.min.js"></script>
<script>
    $('.menu .list .password').addClass('active')

    addValidatorRules('.form-validation', function () {
        $('[name=oldPassword]').val(md5($('#oldPassword').val()))
        $('[name=newPassword]').val(md5($('#newPassword').val()))
        return true
    })

    // $('#confirm').rules('add', {
    //     equalTo: '[id=newPassword]'
    // })

</script>
</body>

</html>
