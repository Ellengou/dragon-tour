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
                        <input type="hidden" name="id" id="id" value="${role.id}">
                        <div class="form-group input-group">
                            <span class="input-group-addon">角色名称</span>
                            <input type="text" class="form-control" name="rlname" id="rlname" value="${role.rlname}">
                        </div>
                        <div class="form-group input-group">
                            <span class="input-group-addon">角色描述</span>
                            <input type="text" class="form-control" name="memo" id="memo" value="${role.memo}">
                        </div>
                        <div class="form-group input-group">
                            <label>&nbsp;角色状态&nbsp;&nbsp;&nbsp;</label>
                            <input type="radio" name="status" value="0"  checked> 停用
                            <input type="radio" name="status" value="1" > 启用（仅限本企业数据）
                            <input type="radio" name="status" value="2" > 启用（本企业数据以及旗下公司所有数据）
                        </div>
                        <hr>
                        <div class="row" align="center">
                            <div class="col-xs-12">
                                <button type="button" class="btn btn-primary" onclick="submitForm();">确定</button>
                                <button type="button" class="btn btn-primary" onclick="closePage();">关闭</button>
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
    var action="${action}";

    $(function () {
        var statusTmp = '${role.status}';
        if (statusTmp == '0') {
            $("input[name=status]:eq(0)").attr("checked",'checked');
        } else if (statusTmp == '1') {
            $("input[name=status]:eq(1)").attr("checked",'checked');
        } else if (statusTmp == '2') {
            $("input[name=status]:eq(2)").attr("checked",'checked');
        }
    });

    var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
    //关闭窗口并刷新页面
    function closePage() {
        parent.layer.close(index);
    }
    function submitForm() {
        //将form表单参数组成json
//        var jsonData = {};
//        $("#myForm").find("input").each(function() {
//            jsonData[$(this).attr('id')] = $(this).val();
//        });
        //询问框
        layer.confirm('是否确定此操作？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.ajax({
                type:'POST',
                url:  '<%=request.getContextPath()%>/admin/role/' + action,
                data:{
                    id:$('#id').val(),
                    rlname:$('#rlname').val(),
                    memo:$('#memo').val(),
                    status:$("input[type='radio']:checked").val()
                },
                dataType:'json',
                beforeSend:function() {
                    // TODO FORM ...
                },
                success: function (data) {
                    if(data.status == 'ok'){
                        parent.search(parseInt(parent.$('.active').attr('jp-data')));
                        closePage();
                    }else{
                        layer.alert(data.msg, {
                            icon : 5
                        });
                    }
                },
                error: function(){
                    layer.alert('系统错误', {
                        icon : 5
                    });
                }
            });
        }, function(){

        });
    }
</script>
</body>
</html>
