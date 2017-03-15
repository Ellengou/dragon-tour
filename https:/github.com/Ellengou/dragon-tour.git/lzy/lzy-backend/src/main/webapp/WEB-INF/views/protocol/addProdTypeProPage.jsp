<%--
  Created by IntelliJ IDEA.
  User: violorch
  Date: 2016/6/6
  Time: 10:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                        <input type="hidden" name="prodTypeId" id="prodTypeId" value="${prodTypeId}" >
                        <div class="form-group input-group">
                            <span class="input-group-addon">类型名称</span>
                            <input type="text" class="form-control" name="name" id="name" value="${type.name}">
                        </div>
                        <div class="form-group input-group">
                            <span class="input-group-addon">属性选择</span>
                            <input type="text" class="form-control" value="协议" disabled="disabled">
                        </div>
                        <div class="form-group input-group">
                            <label>&nbsp;协议类型状态&nbsp;&nbsp;&nbsp;</label>
                            <input type="radio" name="status" value="1"  checked> 停用
                            <input type="radio" name="status" value="0" > 启用
                        </div>
                        <hr>
                        <div class="row" align="center">
                            <div class="col-xs-12">
                                <button type="button" class="btn btn-primary" onclick="submitType();">确定</button>
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
    $(function () {
    });

    var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
    //关闭窗口并刷新页面
    function closePage() {
        parent.layer.close(index);
    }

    function submitType() {
        //询问框
        layer.confirm('是否确定此操作？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            var url = '<%=request.getContextPath()%>/admin/protocolType/saveProdTypePro';
            $.ajax({
                type:'POST',
                url: url,
                data:{
                    name:$('#name').val(),
                    status:$("input[type='radio']:checked").val(),
                    prodTypeId : $('#prodTypeId').val()
                },
                dataType:'json',
                beforeSend:function() {
                    // TODO FORM ...
                },
                success: function (data) {
                    //parent.search(parseInt(parent.$('.active').attr('jp-data')));

                    if(data.status == 'ok'){
                        layer.alert('添加成功！', {
                            icon: 6
                        });
                        window.parent.location.reload();
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
