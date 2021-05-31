<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--格式化标签库--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>App Store简历管理-工作经验</title>
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
                            <h2>工作经验</h2>
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
                            <%--只有当experiences有值时，才显示那个列表--%>
                            <c:if test="${not empty experiences}">
                                <table class="table table-bordered table-hover table-striped">
                                    <thead>
                                    <tr>
                                        <th>
                                            <div class="switch">
                                                <label><input type="checkbox"><span class="lever switch-col-blue"></span></label>
                                            </div>
                                        </th>
                                        <th>职位</th>
                                        <th>公司</th>
                                        <th>开始</th>
                                        <th>结束</th>
                                        <th>简介</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                        <%--更改--%>
                                    <tbody>
                                    <form id="remove-form" action="${ctx}/experience/remove" method="post">
                                        <c:forEach items="${experiences}" var="experience">
                                            <tr>
                                                <td>
                                                    <div class="switch">
                                                            <%--选中的标记(蓝色)--%>
                                                        <label><input type="checkbox" name="id" value="${experience.id}"><span class="lever switch-col-blue"></span></label>
                                                    </div>
                                                </td>
                                                <td>${experience.job}</td>
<%--                                                这就是关联后的写法,而且帮助公司名称与网址--%>
                                                <c:choose>
                                                    <c:when test="${empty experience.company.website}">
                                                        <td>${experience.company.name}</td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <td>
                                                            <a href="${experience.company.website}" target="_blank">${experience.company.name}</a>
                                                        </td>
                                                    </c:otherwise>
                                                </c:choose>
                                                <td><fmt:formatDate pattern="yyyy-MM-dd" value="${experience.beginDay}" /></td>
                                                <td><fmt:formatDate pattern="yyyy-MM-dd" value="${experience.endDay}" /></td>
                                                <td>${experience.intro}</td>
                                                <td>
                                                    <button type="button" class="btn bg-blue waves-effect btn-xs"
                                                        <%--                                                            更改,调experience中的getJson方法--%>
                                                            onclick="edit(${experience.json})">
                                                        <i class="material-icons">edit</i>
                                                        <span>编辑</span>
                                                    </button>
                                                    <button type="button" class="btn bg-pink waves-effect btn-xs"
                                                            onclick="remove(${experience.id}, '${experience.job}')">
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
                    <h4 class="modal-title">添加工作经验</h4>
                </div>
                <div class="modal-body">
<%--                    更改--%>
                    <form class="form-validation" method="post" action="${ctx}/experience/save">
<%--                    为了在编辑发送id给服务器，达到更新的操作--%>
                        <input style="display: none" type="text" name="id">
                        <div class="row">
                            <div class="col-lg-2 col-md-2 col-sm-3 col-xs-3 form-control-label">
                                <label>公司</label>
                            </div>
                            <div class="col-lg-10 col-md-10 col-sm-9 col-xs-9">
                                <div class="form-group">
<%--                                    更改关联; 这里的companies是在ExperienceServlet中查找拿过来的--%>
<%--                                    对公司信息做特殊处理(在ExperienceServlet的save中)且必选:name="companyId" required--%>
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
                                <label for="job">职位</label>
                            </div>
                            <div class="col-lg-10 col-md-10 col-sm-9 col-xs-9">
                                <div class="form-group">
                                    <div class="form-line">
                                        <input type="text" id="job" name="job" maxlength="20" class="form-control"
                                               placeholder="职位"
                                               required>
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
        $('.menu .list .experience').addClass('active')

        addValidatorRules('.form-validation')

        // 调用添加时，会找到那个div，调用clone方法生成一个全新的列表，就没有残留了

        const $addForBox = $('#add-form-box');
        const $addForm = $addForBox.find('form');

        function add() {
            // $('#add-form-box').clone(true).modal() 第一种方法
            // 第二种方法
            $addForBox.modal()
            $addForm[0].reset() // 重置表单的内容

        }

        // 这里的编辑操作要提前填好值（与add添加不同）
        function edit(bean) {
            add()

            // 填充表单(之前的做法是：点击编辑时发送相应id到服务器，再从数据库中拿到更详细的数据进行显示)
            for (const k in bean) {
                $addForm.find('[name=' + k + ']').val(bean[k])
            }

            $addForm.find('[name=companyId]').val(json.company.id)
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
                location.href = '${ctx}/experience/remove?id=' + id;

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
