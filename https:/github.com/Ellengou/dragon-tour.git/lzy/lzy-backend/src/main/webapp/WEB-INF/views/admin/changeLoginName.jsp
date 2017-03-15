<%--
  Created by IntelliJ IDEA.
  User: violorch
  Date: 2016/5/19
  Time: 11:05
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
    <link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div id="page-wrapper" style="padding: 0 15px;">
    <div class="row">
        <div class="col-lg-12">
            <br>
            <div class="panel panel-default">
                <div class="panel-body">
                    <form role="myForm">
                        <div class="form-group input-group">
                            <span class="input-group-addon">登录名</span>
                            <input type="text" class="form-control" name="loginName" id="loginName" >
                        </div>
                        <%--<div class="form-group input-group">--%>
                            <%--<span class="input-group-addon">新密码</span>--%>
                            <%--<input type="password" class="form-control" name="newPassword" id="newPassword">--%>
                        <%--</div>--%>
                        <%--<div class="form-group input-group">--%>
                            <%--<span class="input-group-addon">重复密码</span>--%>
                            <%--<input type="password" class="form-control" name="plainPassword" id="plainPassword">--%>
                        <%--</div>--%>
                        <hr>
                        <div class="row" align="center">
                            <div class="col-xs-12">
                                <button type="button" class="btn btn-primary" onclick="submitForm();">确定</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="<%=request.getContextPath()%>/bootstrap/js/jquery.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<!-- layer JavaScript -->
<script src="<%=request.getContextPath()%>/bootstrap/plugin/layer/layer.js" type="text/javascript"></script>
<script>
    var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
    //关闭窗口并刷新页面
    function closePage() {
        parent.layer.close(index);
    }

    function submitForm() {
        $.ajax({
            type:'POST',
            url: '<%=request.getContextPath()%>/admin/manager/changeLoginName',
            dataType: 'json',
            data:{loginName:$('#loginName').val()},
            success: function (data) {
                if (data.status == 'ok'){
                    layer.alert('修改登录名成功，请重新登陆', {
                        icon : 6
                    });
                    setTimeout(function () {
                        top.location.href = '<%=request.getContextPath()%>/admin/logout';
                    }, 1000);
                }else{
                    layer.alert(data.msg, {
                        icon : 5
                    });
                }
            },
            error: function(){

            }
        });
    }

</script>
</body>
</html>

