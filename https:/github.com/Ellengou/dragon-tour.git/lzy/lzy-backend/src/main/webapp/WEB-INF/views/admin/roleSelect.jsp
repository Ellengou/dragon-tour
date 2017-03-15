<%--
  Created by IntelliJ IDEA.
  User: violorch
  Date: 2016/5/16
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
    <%@ include file="/WEB-INF/views/template/bootMainCss.jsp"%>
    <link href="<%=request.getContextPath()%>/bootstrap/plugin/icheck/flat/blue.css" rel="stylesheet">
    <style>
        .col-xs-3 {
            margin-bottom: 10px;
        }
        #button {
            width: 94%;
            position:absolute;
            bottom:10px;
            left: 3%;
        }
    </style>
</head>
<body>
<div class="panel-body">
    <div class="row">
        <div class="col-lg-12">
            <div class="row" id="main">

            </div>
        </div>
    </div>

    <button type="button" class="btn btn-primary btn-lg btn-block" id="button" onclick="saveUserRole();">保存修改</button>
</div>
</div>
<%@ include file="/WEB-INF/views/template/bootMainJs.jsp"%>
<script src="<%=request.getContextPath()%>/bootstrap/plugin/icheck/icheck.js"></script>
<script type="application/javascript">
    $(function () {
        $.ajax({
            type: 'GET',
            dataType: "json",
            url: '<%=request.getContextPath()%>/admin/manager/role/json?userId=' + ${userId},
            success: function (data) {
                var template = '';
                $('#main').html('');
                for(var i = 0; i < data.length; i++){
                    template += '<div class="col-xs-3">';
                    if (data[i].checked == 1) {
                        template += '<input type="checkbox" name="role" id="' + data[i].id + '" checked>    ' + data[i].rlname;
                    } else {
                        template += '<input type="checkbox" name="role" id="' + data[i].id + '">    ' + data[i].rlname;
                    }
                    template += '</div>';
                }
                $('#main').html(template);

                $('input').iCheck({
                    checkboxClass: 'icheckbox_flat-blue'
                });
            }
        });
    });
    
    function saveUserRole() {
        var roleIds = [];
        $('input:checkbox[name=role]:checked').each(function(i){
            roleIds.push($(this).attr('id'));
        });
        $.ajax({
            url: '<%=request.getContextPath()%>/admin/manager/${userId}/updateUserRole',
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            data:JSON.stringify(roleIds),
            success: function (data) {
                console.log(data);
                if (data.status == 'ok') {
                    layer.alert('角色分配成功！', {
                        icon : 6
                    });
                } else {
                    layer.alert(data.msg, {
                        icon : 5
                    });
                }
            }
        });
    }
</script>
</body>
</html>