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
                        <input type="hidden" name="id" id="id" value="${resource.id}">
                        <input type="hidden" name="pid" id="pid" value="${resource.pid}">
                        <div class="form-group input-group">
                            <span class="input-group-addon">资源名称</span>
                            <input type="text" class="form-control" name="name" id="name" value="${resource.name}">
                        </div>
                        <div class="form-group input-group">
                            <span class="input-group-addon">资源编码</span>
                            <input type="text" class="form-control" name="code" id="code" value="${resource.code}">
                        </div>
                        <div class="form-group input-group">
                            <span class="input-group-addon">资源描述</span>
                            <input type="text" class="form-control" name="remark" id="remark" value="${resource.remark}">
                        </div>
                        <div class="form-group input-group">
                            <label>&nbsp;菜单权限级别&nbsp;&nbsp;&nbsp;</label>
                            <input type="checkbox" name="dataType" id="dataType0" value="0"> 平台可使用
                            <input type="checkbox" name="dataType" id="dataType1" value="1"> 核心企业可使用
                            <input type="checkbox" name="dataType" id="dataType2" value="2"> 第三方机构可使用
                            <input type="checkbox" name="dataType" id="dataType3" value="3"> 子公司可使用
                            <input type="checkbox" name="dataType" id="dataType4" value="4"> 部门可使用
                        </div>
                        <div class="form-group input-group">
                            <label>&nbsp;菜单状态&nbsp;&nbsp;&nbsp;</label>
                            <input type="radio" name="status" value="0"  checked> 停用
                            <input type="radio" name="status" value="1" > 启用
                        </div>
                        <hr>
                        <div class="row" align="center">
                            <div class="col-xs-12">
                                <button type="button" class="btn btn-primary" onclick="submitResource();">确定</button>
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
        var dataType = '${resource.dataType}';
        if (dataType == '') {
            $('#dataType0').attr('checked', 'checked');
            $('#dataType1').attr('checked', 'checked');
            $('#dataType2').attr('checked', 'checked');
            $('#dataType3').attr('checked', 'checked');
            $('#dataType4').attr('checked', 'checked');
        }
        if (dataType.indexOf("0") >= 0) {
            $('#dataType0').attr('checked', 'checked');
        }
        if (dataType.indexOf("1") >= 0) {
            $('#dataType1').attr('checked', 'checked');
        }
        if (dataType.indexOf("2") >= 0) {
            $('#dataType2').attr('checked', 'checked');
        }
        if (dataType.indexOf("3") >= 0) {
            $('#dataType3').attr('checked', 'checked');
        }
        if (dataType.indexOf("4") >= 0) {
            $('#dataType4').attr('checked', 'checked');
        }

        var statusTmp = ${resource.status};
        if (statusTmp == '0') {
            $("input[name=status]:eq(0)").attr("checked",'checked');
        } else if (statusTmp == '1') {
            $("input[name=status]:eq(1)").attr("checked",'checked');
        }
    });

    var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
    //关闭窗口并刷新页面
    function closePage() {
        parent.layer.close(index);
    }

    function submitResource() {
        var dataType = '';
        $('input:checkbox').each(function() {
            if ($(this).prop('checked') == true) {
                dataType = dataType + ',' + $(this).val();
            }
        });
        //询问框
        layer.confirm('是否确定此操作？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            var url = '<%=request.getContextPath()%>/admin/resource/' + action;
            $.ajax({
                type: 'POST',
                url: url,
                data: {
                    id: $('#id').val(),
                    pid: $('#pid').val(),
                    name: $('#name').val(),
                    code: $('#code').val() + '',
                    remark: $('#remark').val(),
                    dataType: dataType,
                    status: $("input[type='radio']:checked").val()
                },
                dataType: 'json',
                beforeSend: function () {
                    // TODO FORM ...
                },
                success: function (data) {
                    if (data.status == 'ok') {
                        parent.search(parseInt(parent.$('.active').attr('jp-data')));
                        closePage();
                    } else {
                        layer.alert(data.msg, {
                            icon: 5
                        });
                    }
                },
                error: function () {
                    layer.alert('系统错误', {
                        icon: 5
                    });
                }
            })
        }, function(){

        });
    }
</script>
</body>
</html>
