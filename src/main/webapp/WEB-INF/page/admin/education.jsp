<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--格式化标签库--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>App Store简历管理-教育信息</title>
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
                            <h2>教育信息</h2>
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
                            <%--只有当educations有值时，才显示那个列表--%>
                            <c:if test="${not empty educations}">
                                <table class="table table-bordered table-hover table-striped">
                                    <thead>
                                    <tr>
                                        <th>
                                            <div class="switch">
                                                <label><input type="checkbox"><span class="lever switch-col-blue"></span></label>
                                            </div>
                                        </th>
                                        <th>名称</th>
                                        <th>开始</th>
                                        <th>结束</th>
                                        <th>类型</th>
                                        <th>简介</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                        <%--更改--%>
                                    <tbody>
                                    <form id="remove-form" action="${ctx}/education/remove" method="post">
                                        <c:forEach items="${educations}" var="education">
                                            <tr>
                                                <td>
                                                    <div class="switch">
                                                            <%--选中的标记(蓝色)--%>
                                                        <label><input type="checkbox" name="id" value="${education.id}"><span class="lever switch-col-blue"></span></label>
                                                    </div>
                                                </td>
                                                <td>${education.name}</td>
                                                <td><fmt:formatDate pattern="yyyy-MM-dd" value="${education.beginDay}" /></td>
                                                <td><fmt:formatDate pattern="yyyy-MM-dd" value="${education.endDay}" /></td>
                                                <td>${education.typeString}</td>
                                                <td>${education.intro}</td>
                                                <td>
                                                    <button type="button" class="btn bg-blue waves-effect btn-xs"
                                                        <%--                                                            更改,调education中的getJson方法--%>
                                                            onclick="edit(${education.json})">
                                                        <i class="material-icons">edit</i>
                                                        <span>编辑</span>
                                                    </button>
                                                    <button type="button" class="btn bg-pink waves-effect btn-xs"
                                                            onclick="remove(${education.id}, '${education.name}')">
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
                    <h4 class="modal-title">添加教育信息</h4>
                </div>
                <div class="modal-body">
<%--                    更改--%>
                    <form class="form-validation" method="post" action="${ctx}/education/save">
<%--                    为了在编辑发送id给服务器，达到更新的操作--%>
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
                                <label>类型</label>
                            </div>
                            <div class="col-lg-10 col-md-10 col-sm-9 col-xs-9">
                                <div class="form-group">
                                    <select name="type">
                                        <option value="1">小学</option>
                                        <option value="2">初中</option>
                                        <option value="3">高中</option>
                                        <option value="4">中专</option>
                                        <option value="5">大专</option>
                                        <option value="6" selected>本科</option>
                                        <option value="7">硕士</option>
                                        <option value="8">博士</option>
                                        <option value="0">其它</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-2 col-md-2 col-sm-3 col-xs-3 form-control-label">
                                <label for="beginDay">入学</label>
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
                                <label for="endDay">毕业</label>
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
        $('.menu .list .education').addClass('active')

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

            // 上面的for循环优化了下面这么多的代码
            // $addForm.find('[name=name]').val(education.name)
            // $addForm.find('[name=beginDay]').val(education.beginDay)
            // $addForm.find('[name=endDay]').val(education.endDay)
            // $addForm.find('[name=type]').val(education.type)
            // $addForm.find('[name=intro]').val(education.intro)
            // // 需要发送隐藏id，达到更新的目的，不然就是添加操作了
            // $addForm.find('[name=id]').val(education.id)
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
                location.href = '${ctx}/education/remove?id=' + id;

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
