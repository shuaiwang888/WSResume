<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--格式化标签库--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>App Store简历管理-专业技能</title>
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
                            <h2>专业技能</h2>
                        </div>
                        <div class="body table-responsive">
                            <div class="menus">
                                <div class="buttons">
                                    <button type="button" class="btn bg-blue waves-effect btn-sm"
<%--                                        更改：这里点击添加就会调用add对表单进行重置--%>
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
<%--                        只有当skills有值时，才显示那个列表--%>
                            <c:if test="${not empty skills}">
                                <table class="table table-bordered table-hover table-striped">
                                    <thead>
                                    <tr>
                                        <th>
                                            <div class="switch">
                                                <label><input type="checkbox"><span class="lever switch-col-blue"></span></label>
                                            </div>
                                        </th>
                                        <th>名称</th>
                                        <th>级别</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                        <%--                                选择多个删除操作时，需要添加id选择器，转到/skill/remove处理--%>
                                    <form id="remove-form" method="post" action="${ctx}/skill/remove">
                                        <c:forEach items="${skills}" var="skill">
                                            <tr>
                                                <td>
                                                    <div class="switch">
                                                            <%--                                                    选中后绑定其id--%>
                                                        <label><input name="id" type="checkbox" value="${skill.id}"><span class="lever switch-col-blue"></span></label>
                                                    </div>
                                                </td>
                                                <td>${skill.name}</td>
                                                <td>${skill.levelString}</td>
                                                <td>
                                                    <button type="button" class="btn bg-blue waves-effect btn-xs"
                                                        <%--点击编辑时，需要调其将java对象转换为json对象的函数--%>
                                                            onclick="edit(${skill.json})">
                                                        <i class="material-icons">edit</i>
                                                        <span>编辑</span>
                                                    </button>
                                                    <button type="button" class="btn bg-pink waves-effect btn-xs"
                                                        <%--传两个变量--%>
                                                            onclick="remove('${skill.id}', '${skill.name}')">
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
                    <h4 class="modal-title">添加专业技能</h4>
                </div>
                <div class="modal-body">
<%--                这里为跳转到save界面，并发送一个隐藏id（更新时会用到）--%>
                    <form class="form-validation" method="post" action="${ctx}/skill/save">
                        <input style="display: none" type="text" name="id">
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
                                <label>级别</label>
                            </div>
                            <div class="col-lg-10 col-md-10 col-sm-9 col-xs-9">
                                <div class="form-group">
                                    <select name="level">
                                        <option value="0">了解</option>
                                        <option value="1">熟悉</option>
                                        <option value="2">掌握</option>
                                        <option value="3">精通</option>
                                    </select>
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
        $('.menu .list .skill').addClass('active')

        addValidatorRules('.form-validation')

        const $addForBox = $('#add-form-box');
        const $addForm = $addForBox.find('form');

        function add() {
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
                location.href = '${ctx}/skill/remove?id=' + id;
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
