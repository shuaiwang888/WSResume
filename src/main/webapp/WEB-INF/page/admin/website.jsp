<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("ctx", request.getContextPath()); %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>App Store简历管理-网站信息</title>
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
                        <h2>网站信息</h2>
                    </div>
                    <div class="body">
                        <form class="form-validation" method="post" action="${ctx}/website/save">
                            <input type="hidden" name="id" value="${website.id}">
                            <div class="row">
                                <div class="col-lg-2 col-md-2 col-sm-3 col-xs-3 form-control-label">
                                    <label for="footer">底部</label>
                                </div>
                                <div class="col-lg-10 col-md-10 col-sm-9 col-xs-9">
                                    <div class="form-group">
                                        <div class="form-line">
                                                <textarea name="footer" maxlength="1000"
                                                          id="footer" cols="30" rows="5"
                                                          class="form-control no-resize"
                                                          placeholder="底部">${website.footer}</textarea>
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
<script>
    $('.menu .list .website').addClass('active')
</script>
</body>

</html>