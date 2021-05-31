<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--格式化标签库--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>App Store简历管理-项目经验</title>
    <%@ include file="common/style.jsp"%>  <!-- 头部：类似于直接从common/head.jsp拷贝过来，用相对路径 -->
</head>

<body class="theme-blue">
    <%@ include file="common/nav.jsp"%> <!-- 中部 -->

    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="card">
                        <div class="header">
                            <h2>项目经验</h2>
                        </div>
                        <div class="body table-responsive">
                            <div class="menus">
                                <div class="buttons">
                                    <button type="button" class="btn bg-blue waves-effect btn-sm"
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
                            <%--只有当projects有值时，才显示那个列表--%>
                            <c:if test="${not empty projects}">
                                <table class="table table-bordered table-hover table-striped">
                                    <thead>
                                    <tr>
                                        <th>
                                            <div class="switch">
                                                <label><input type="checkbox"><span class="lever switch-col-blue"></span></label>
                                            </div>
                                        </th>
                                        <th>名称</th>
                                        <th>图片</th>
                                        <th>公司</th>
                                        <th>开始</th>
                                        <th>结束</th>
                                        <th>简介</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                        <%--更改--%>
                                    <tbody>
                                    <form id="remove-form" action="${ctx}/project/remove" method="post">
                                        <c:forEach items="${projects}" var="project">
                                            <tr>
                                                <td>
                                                    <div class="switch">
                                                            <%--选中的标记(蓝色)--%>
                                                        <label><input type="checkbox" name="id" value="${project.id}"><span class="lever switch-col-blue"></span></label>
                                                    </div>
                                                </td>
                                                <c:choose>
                                                    <c:when test="${empty project.website}">
                                                        <td>${project.name}</td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <td>
                                                            <a href="${project.website}" target="_blank">${project.name}</a>
                                                        </td>
                                                    </c:otherwise>
                                                </c:choose>

                                                <td><img src="${ctx}/${project.image}" alt=""></td>
<%--                                                这就是关联后的写法,而且帮助公司名称与网址--%>
                                                <c:choose>
                                                    <c:when test="${empty project.company.website}">
                                                        <td>${project.company.name}</td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <td>
                                                            <a href="${project.company.website}" target="_blank">${project.company.name}</a>
                                                        </td>
                                                    </c:otherwise>
                                                </c:choose>
                                                <td><fmt:formatDate pattern="yyyy-MM-dd" value="${project.beginDay}" /></td>
                                                <td><fmt:formatDate pattern="yyyy-MM-dd" value="${project.endDay}" /></td>
                                                <td>${project.intro}</td>
                                                <td>
                                                    <button type="button" class="btn bg-blue waves-effect btn-xs"
                                                        <%--                                                            更改,调project中的getJson方法--%>
                                                            onclick="edit(${project.json})">
                                                        <i class="material-icons">edit</i>
                                                        <span>编辑</span>
                                                    </button>
                                                    <button type="button" class="btn bg-pink waves-effect btn-xs"
                                                            onclick="remove(${project.id}, '${project.name}')">
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
                    <h4 class="modal-title">添加项目经验</h4>
                </div>
                <div class="modal-body">
<%--                    更改--%>
                    <form class="form-validation"
                          method="post"
                          enctype="multipart/form-data"
                          action="${ctx}/project/save">
<%--                    为了在编辑发送id给服务器，达到更新的操作--%>
                        <input style="display: none" type="text" name="id">
                        <input style="display: none" type="text" name="image">
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
                                <label>图片</label>
                            </div>
                            <div class="col-lg-10 col-md-10 col-sm-9 col-xs-9">
                                <div class="form-group">
                                    <div class="fileinput fileinput-new" data-provides="fileinput">
                                        <div class="fileinput-new thumbnail">
                                            <img src="${ctx}/asset/admin/img/noimage.png" alt="">
                                        </div>
                                        <div class="fileinput-preview fileinput-exists thumbnail"></div>
                                        <i class="material-icons clear fileinput-exists" data-dismiss="fileinput">close</i>
                                        <input type="file" name="imageFile" accept="image/*">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-lg-2 col-md-2 col-sm-3 col-xs-3 form-control-label">
                                <label>公司</label>
                            </div>
                            <div class="col-lg-10 col-md-10 col-sm-9 col-xs-9">
                                <div class="form-group">
<%--                                    更改关联; 这里的companies是在projectservlet中查找拿过来的--%>
<%--                                    对公司信息做特殊处理(在projectservlet的save中)且必选:name="companyId" required--%>
                                    <select name="companyId" required>
                                        <c:forEach items="${companies}" var="company">
                                            <option value="${company.id}">${company.name}</option>
                                        </c:forEach>

                                    </select>
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
                                        <input type="url" id="website" name="website" maxlength="20" class="form-control"
                                               placeholder="网址(以http://、 https://开头)">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-2 col-md-2 col-sm-3 col-xs-3 form-control-label">
                                <label for="beginDay">开始</label>
                            </div>
                            <div class="col-lg-10 col-md-10 col-sm-9 col-xs-9">
                                <div class="form-group">
                                    <div class="form-line">
                                        <input type="date" id="beginDay" name="beginDay" class="form-control"
                                               required>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-2 col-md-2 col-sm-3 col-xs-3 form-control-label">
                                <label for="endDay">结束</label>
                            </div>
                            <div class="col-lg-10 col-md-10 col-sm-9 col-xs-9">
                                <div class="form-group">
                                    <div class="form-line">
                                        <input type="date" id="endDay" name="endDay" class="form-control"
                                               required>
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

    <%@ include file="common/script.jsp"%> <!-- 尾部 -->

    <script>
        $('.menu .list .project').addClass('active')

        addValidatorRules('.form-validation')

        // 调用添加时，会找到那个div，调用clone方法生成一个全新的列表，就没有残留了

        const $addForBox = $('#add-form-box');
        const $addForm = $addForBox.find('form');
        const $img = $addForm.find('.fileinput .thumbnail img')

        function add() {
            $addForBox.modal()
            $addForm[0].reset() // 重置表单的内容
            $img.attr('src', '${ctx}/asset/admin/img/noimage.png') // 重置图片

        }

        // 这里的编辑操作要提前填好值（与add添加不同）
        function edit(bean) {
            add()

            // 填充表单(之前的做法是：点击编辑时发送相应id到服务器，再从数据库中拿到更详细的数据进行显示)
            for (const k in bean) {
                const $input = $addForm.find('[name=' + k + ']')
                if ($input.attr('type') === 'file') continue // name与intro参数
                $input.val(bean[k])
            }

            $addForm.find('[name=companyId]').val(bean.company.id)

            // 设置img的值
            if (bean.image) { // 有值时才会设置
                $img.attr('src', '${ctx}/' + bean.image)
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
                location.href = '${ctx}/project/remove?id=' + id;

                // swal({
                //     title: '删除成功',
                //     text: '【' + name + '】已经被删除！',
                //     icon: 'success',
                //     timer: 1500,
                //     buttons: false
                // })
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

                // swal({
                //     title: "删除成功",
                //     text: "被选中的记录已经被删除！",
                //     icon: "success",
                //     timer: 1500,
                //     buttons: false
                // })
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
