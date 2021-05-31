<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--格式化标签库--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>App Store简历管理-公司信息</title>
    <%@ include file="common/style.jsp"%>
</head>

<body class="theme-blue">
    <%@ include file="common/nav.jsp"%>

    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="card">
                        <div class="header">
                            <h2>公司信息</h2>
                        </div>
                        <div class="body table-responsive">
                            <div class="menus">
                                <div class="buttons">
                                    <button type="button" class="btn bg-blue waves-effect btn-sm"
                                    <%--更改：这里点击添加就会调用add对表单进行重置--%>
                                            onclick="add()">
                                        <i class="material-icons">add</i>
                                        <span>添加</span>
                                    </button>
                                    <button type="button"
                                            class="btn bg-pink waves-effect btn-sm removeAll disabled"
                                            disabled
                                            onclick="removeAll()">
                                        <i class="material-icons">delete</i>
                                        <span>删除选中</span>
                                    </button>
                                </div>
                            </div>
                            <%--只有当companys有值时，才显示那个列表--%>
                            <c:if test="${not empty companies}">
                                <table class="table table-bordered table-hover table-striped">
                                    <thead>
                                    <tr>
                                        <th>
                                            <div class="switch">
                                                <label><input type="checkbox"><span class="lever switch-col-blue"></span></label>
                                            </div>
                                        </th>
                                        <th>名称</th>
                                        <th>Logo</th>
                                        <th>简介</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                        <%--选择多个删除操作时，需要添加id选择器，转到/company/remove处理--%>
                                    <form id="remove-form" method="post" action="${ctx}/company/remove">
                                        <c:forEach items="${companies}" var="company">
                                            <tr>
                                                <td>
                                                    <div class="switch">
                                                        <%--选中后绑定其id--%>
                                                        <label><input name="id" type="checkbox" value="${company.id}"><span class="lever switch-col-blue"></span></label>
                                                    </div>
                                                </td>
<%--                                                这里实现的是如果输入一个正确的网址，就绑定在公司名称上--%>
                                                <c:choose>
                                                    <c:when test="${empty company.website}">
                                                        <td>${company.name}</td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <td>
                                                            <a href="${company.website}" target="_blank">${company.name}</a>
                                                        </td>
                                                    </c:otherwise>
                                                </c:choose>

                                                <td>
                                                    <img src="${ctx}/${company.logo}" alt="">
                                                </td>
                                                <td>${company.intro}</td>
                                                <td>
                                                    <button type="button" class="btn bg-blue waves-effect btn-xs"
                                                        <%--点击编辑时，需要调其将java对象转换为json对象的函数--%>
                                                            onclick="edit(${company.json})">
                                                        <i class="material-icons">edit</i>
                                                        <span>编辑</span>
                                                    </button>
                                                    <button type="button" class="btn bg-pink waves-effect btn-xs"
                                                        <%--传两个变量--%>
                                                            onclick="remove('${company.id}', '${company.name}')">
                                                        <i class="material-icons">delete</i>
                                                        <span>删除</span>
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </form>
                                    </tbody>
                                </table>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!--  add-form-box  -->
    <div class="modal fade" id="add-form-box" style="display: none;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">添加公司</h4>
                </div>
                <div class="modal-body">
<%--                更改发送image图片的必要的两个属性:method="post" enctype="multipart/form-data"--%>
                    <form class="form-validation"
                          method="post"
                          enctype="multipart/form-data"
                          action="${ctx}/company/save">
<%--                    这是是为了在编辑的时候就算没有改图片，客户端也会发图片的路径过去，就是为了防止图片数据在计算路径时空指针异常--%>
                        <input style="display: none" type="text" name="id">
                        <input style="display: none" type="text" name="logo">
                        <div class="row">
                            <div class="col-lg-2 col-md-2 col-sm-3 col-xs-3 form-control-label">
                                <label>Logo</label>
                            </div>
                            <div class="col-lg-10 col-md-10 col-sm-9 col-xs-9">
                                <div class="form-group">
                                    <div class="fileinput fileinput-new" data-provides="fileinput">
                                        <div class="fileinput-new thumbnail">
                                            <img src="${ctx}/asset/admin/img/noimage.png" alt="">
                                        </div>
                                        <div class="fileinput-preview fileinput-exists thumbnail"></div>
                                        <i class="material-icons clear fileinput-exists" data-dismiss="fileinput">close</i>
                                        <input type="file" name="logoFile" accept="image/*">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-2 col-md-2 col-sm-3 col-xs-3 form-control-label">
                                <label for="name">名称</label>
                            </div>
                            <div class="col-lg-10 col-md-10 col-sm-9 col-xs-9">
                                <div class="form-group">
                                    <div class="form-line">
                                        <input type="text" id="name" name="name" maxlength="20" class="form-control"
                                               placeholder="名称"
                                               required>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-2 col-md-2 col-sm-3 col-xs-3 form-control-label">
                                <label for="website">网址</label>
                            </div>
                            <div class="col-lg-10 col-md-10 col-sm-9 col-xs-9">
                                <div class="form-group">
                                    <div class="form-line">
<%--                                        type="url" placeholder="网址(以http://、 https://开头)"--%>
                                        <input type="url" id="website" name="website" maxlength="40" class="form-control"
                                               placeholder="网址(以http://、 https://开头)">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-2 col-md-2 col-sm-3 col-xs-3 form-control-label">
                                <label for="intro">简介</label>
                            </div>
                            <div class="col-lg-10 col-md-10 col-sm-9 col-xs-9">
                                <div class="form-group">
                                    <div class="form-line">
                                        <textarea name="intro" maxlength="1000" id="intro" cols="30" rows="5" class="form-control no-resize" placeholder="简介"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg-offset-2 col-md-offset-2 col-sm-offset-3 col-xs-offset-3">
                                <button class="btn btn-primary waves-effect m-l-15" type="submit">保存</button>
                                <button class="btn btn-info waves-effect m-l-15" data-dismiss="modal">关闭</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

<%@ include file="common/script.jsp"%>

<script>
    $('.menu .list .company').addClass('active')

    addValidatorRules('.form-validation')

    const $addForBox = $('#add-form-box');
    const $addForm = $addForBox.find('form');
    const $img = $addForm.find('.fileinput .thumbnail img')

    function add() {
        $addForBox.modal()
        $addForm[0].reset() // 重置表单的内容name,intro (并不会去重置type=hidden的表单)
        $img.attr('src', '${ctx}/asset/admin/img/noimage.png')

    }

    // 这里的编辑操作要提前填好值（与add添加不同）
    function edit(bean) {  // bean就是json
        add()

        // 填充表单信息
        for (const k in bean) {
            const $input = $addForm.find('[name=' + k + ']')
            if ($input.attr('type') === 'file') continue // name与intro参数
            $input.val(bean[k])
        }

        // 设置img的值
        if (bean.logo) { // 有值时才会设置
            $img.attr('src', '${ctx}/' + bean.logo)
        }
    }

    function remove(id, name) {
        swal({
            title: "你确定？",
            text: '你确定要删除【' + name + '】？',
            icon: 'warning',
            dangerMode: true,
            buttons: {
                cancel: '取消',
                confirm: '确定'
            }
        }).then(willDelete => {
            if (!willDelete) return
            // 点击确认了
            location.href = '${ctx}/company/remove?id=' + id;
        })
    }

    function removeAll() {
        swal({
            title: "你确定？",
            text: "你确定要删除所有选中的记录？",
            icon: "warning",
            dangerMode: true,
            buttons: {
                cancel: "取消",
                confirm: "确定"
            }
        }).then(willDelete => {
            if (!willDelete) return

            // 拿到表单，发送请求(调用submit请求)
            $('#remove-form').submit()
        })
    }

    const $set = $(".table tbody tr input[type=checkbox]")
    const $removeAll = $('.table-responsive .removeAll')
    $('.table thead th input[type=checkbox]').change(function () {
        let checked = $(this).is(":checked")
        if (checked) {
            $set.each(function () {
                $(this).prop("checked", true)
                $(this).parents('tr').addClass("active")
            })
            $removeAll.removeClass('disabled')
            $removeAll.prop('disabled', false)
        } else {
            $set.each(function () {
                $(this).prop("checked", false)
                $(this).parents('tr').removeClass("active")
            })
            $removeAll.addClass('disabled')
            $removeAll.prop('disabled', true)
        }
    })

    $set.change(function () {
        $(this).parents('tr').toggleClass("active")
        if ($('.table tbody tr input[type=checkbox]:checked').length > 0) {
            $removeAll.removeClass('disabled')
            $removeAll.prop('disabled', false)
        } else {
            $removeAll.addClass('disabled')
            $removeAll.prop('disabled', true)
        }
    })
</script>
</body>

</html>
