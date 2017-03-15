<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: violorch
  Date: 2016/4/22
  Time: 9:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>后台管理系统</title>
    <!-- Bootstrap Core CSS -->
    <%@ include file="/WEB-INF/views/template/validator.jsp"%>
</head>
<body>
<div id="page-wrapper" style="padding: 0 15px;">
    <div class="row">
        <div class="col-lg-12">
            <br>
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <form id="myForm">
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="input-group">
                                            <span class="input-group-addon">登录名</span>
                                            <input type="hidden" name="id" id="id" value="${adminUser.id}" >
                                            <input type="text" class="form-control" name="loginName" id="loginName" value="${adminUser.loginName}">
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="input-group">
                                            <span class="input-group-addon">真实姓名</span>
                                            <input type="text" class="form-control" name="realName" id="realName" value="${adminUser.realName}">
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="input-group">
                                            <span class="input-group-addon">性别</span>
                                            <select class="form-control required" id="sex">
                                                <option value="0">女</option>
                                                <option value="1">男</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="input-group">
                                            <span class="input-group-addon">电话</span>
                                            <input type="number" class="form-control" minlength="11" maxlength="11"
                                                   name="phone" id="phone" value="${adminUser.phone}">
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="input-group">
                                            <span class="input-group-addon">邮箱</span>
                                            <input type="email" class="form-control" name="email" id="email" value="${adminUser.email}">
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="input-group">
                                            <span class="input-group-addon">IPCC座机</span>
                                            <input type="text" class="form-control" name="ipccUname" id="ipccUname" value="${adminUser.ipccUname}">
                                        </div>
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="form-group input-group">
                                        <label>&nbsp;&nbsp;&nbsp;后台用户状态&nbsp;&nbsp;&nbsp;</label>
                                        <input type="radio" name="state" value="0"  checked> 正常使用
                                        <input type="radio" name="state" value="2" > 锁定用户
                                    </div>
                                </div>
                                <hr>
                                <div class="row" align="center">
                                    <div class="col-xs-12">
                                        <%--<button type="submit" class="btn btn-primary" onclick="submitUser();">确定</button>--%>
                                        <input type="submit" class="btn btn-primary" value="确定" />
                                        <button type="button" class="btn btn-primary" onclick="closePage();">关闭</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


</div>
<script>
    var action="${action}";
    var _parent = parent;
    // 初始化
    $(function () {
        if (action == "update") {
            $('#loginName').attr("readonly","readonly");
        }

        $('#sex').val('${adminUser.sex}');
        if ($('#sex').val() == null) {
            $('#sex').val("0");
        }
        if ('${adminUser.state}' == '2') {
            $("input[name=state]:eq(1)").attr("checked",'checked');
        } else {
            $("input[name=state]:eq(0)").attr("checked",'checked');
        }

        if (action == "create") {
            $('#myForm').validate_popover({
                onsubmit: true,
                popoverPosition: 'right',
                rules: {
                    loginName: {
                        required: true,
                        remote: {
                            url: "<%=request.getContextPath()%>/admin/manager/checkLoginName",
                            type: "get"
                        }
                    },
                },
                messages: {
                    loginName: {
                        required:'登录名不能为空',
                        remote: '当前登录名已存在'
                    }
                },
                submitHandler: function (form) {
                    $.ajax({
                        type: 'POST', // You can change this to GET if you want to submit via GET
                        method: $(this).attr('method'),
                        url: '<%=request.getContextPath()%>/admin/manager/' + action,
                        dataType: 'json',
                        data: {
                            id: $('#id').val(),
                            loginName: $('#loginName').val(),
                            realName: $('#realName').val(),
                            sex: $('#sex').val(),
                            phone: $('#phone').val(),
                            email: $('#email').val(),
                            ipccUname: $('#ipccUname').val(),
                            state: $("input[type='radio']:checked").val()
                        }
                    }).done(function (data) {
                        if (data.status == 'ok') {
                            _parent.search(parseInt(_parent.$('.active').attr('jp-data')));
                            closePage();
                        } else {
                            layer.alert(data.msg, {
                                icon: 5
                            });
                        }
                    }).fail(function (jqXHR, textStatus) {
                        layer.alert('系统错误', {
                            icon: 5
                        });
                    });
                }
            });
        } else {
            $('#myForm').validate_popover({
                onsubmit: true,
                popoverPosition: 'right',
                submitHandler: function (form) {
                    $.ajax({
                        type: 'POST', // You can change this to GET if you want to submit via GET
                        method: $(this).attr('method'),
                        url: '<%=request.getContextPath()%>/admin/manager/' + action,
                        dataType: 'json',
                        data: {
                            id: $('#id').val(),
                            loginName: $('#loginName').val(),
                            realName: $('#realName').val(),
                            sex: $('#sex').val(),
                            phone: $('#phone').val(),
                            email: $('#email').val(),
                            ipccUname: $('#ipccUname').val(),
                            state: $("input[type='radio']:checked").val()
                        }
                    }).done(function (data) {
                        if (data.status == 'ok') {
                            _parent.search(parseInt(_parent.$('.active').attr('jp-data')));
                            closePage();
                        } else {
                            layer.alert(data.msg, {
                                icon: 5
                            });
                        }
                    }).fail(function (jqXHR, textStatus) {
                        layer.alert('系统错误', {
                            icon: 5
                        });
                    });
                }
            });
        }
    });

    var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
    //关闭窗口并刷新页面
    function closePage() {
        parent.layer.close(index);
    }

</script>
</body>
</html>
