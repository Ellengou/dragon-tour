<%@ page import="com.runlion.common.constants.SysMessageConstants" %><%--
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
    <style>
        .btn-group-xs>.btn, .btn-xs {
            margin-bottom: 5px;
        }
    </style>
</head>
<body>
<div id="page-wrapper" style="padding: 0 15px;">
    <div class="row">
        <div class="col-lg-12">
            <br>
            <div class="panel panel-default">
                <div class="panel-body">
                    <form role="myForm">
                        <div class="row">
                            <div class="input-group">
                                <span class="input-group-addon">标题消息</span>
                                <input type="hidden" name="id" id="id" value="${detail.id}" >
                                <input type="text" class="form-control" name="name" id="name" value="${detail.name}" readonly>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="input-group">
                                <span class="input-group-addon">发送对象</span>
                                <select class="form-control" id="sendGroup" name="sendGroup" onchange="changeSendGroup();">
                                    <option value="">所有人</option>
                                </select>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="input-group">
                                <span class="input-group-addon">核心企业</span>
                                <select class="form-control" id="sendGroupComp" name="sendGroupComp">
                                    <option value="">所有</option>
                                </select>
                            </div>
                        </div>
                        <br />
                        <hr>
                        <div class="row" align="center">
                            <div class="input-group">
                                <button type="button" class="btn btn-primary" onclick="submitType();">确定</button> &nbsp;&nbsp;
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
        $("#sendGroupComp").attr("disabled", true);
        var sendGroupComp = $.parseJSON('${sendGroupComp}');
        for (var i = 0; i < sendGroupComp.length; i++) {
            $(new Option(sendGroupComp[i].compName, sendGroupComp[i].id)).appendTo('#sendGroupComp');
        }

        if ("${detail.userType}" == "<%=SysMessageConstants.USER_TYPE_ADMIN%>") {
            $(new Option("平台用户", 1)).appendTo('#sendGroup');
            $(new Option("核心企业", 2)).appendTo('#sendGroup');

        } else {
            var sendGroup = $.parseJSON('${sendGroup}');
            for (var i = 0; i < sendGroup.length; i++) {
                $(new Option(sendGroup[i].dicDataName, sendGroup[i].dicDataValue)).appendTo('#sendGroup');
            }

        }
    });
    
    function changeSendGroup() {
        if ("${detail.userType}" == "<%=SysMessageConstants.USER_TYPE_ADMIN%>") {
            if ($('#sendGroup').val() == 1) {
                $('#sendGroupComp').val("");
                $("#sendGroupComp").attr('disabled', true);
            } else if ($('#sendGroup').val() == 2) {
                $("#sendGroupComp").attr("disabled", false);
            } else {
                $('#sendGroupComp').val("");
                $("#sendGroupComp").attr('disabled', true);
            }
        } else {
            $('#sendGroupComp').val("");
            $("#sendGroupComp").attr('disabled', false);
            if ($('#sendGroup').val() == 1) {
                $("#sendGroupComp").attr('disabled', true);
            }
        }
    }

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
            var url = '<%=request.getContextPath()%>/admin/messageSend/send';
            $.ajax({
                type:'POST',
                url: url,
                data:{
                    id:$('#id').val(),
                    sendGroup: $('#sendGroup').val(),
                    sendGroupComp: $('#sendGroupComp').val()
                },
                dataType:'json',
                beforeSend:function() {
                    // TODO FORM ...
                },
                success: function (data) {
                    if(data.status == 'ok'){
                        layer.alert('发送成功！', {
                            icon: 6
                        });
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
