<%--
  Created by IntelliJ IDEA.
  Detail: violorch
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
    <!-- bootstrap-datetimepicker -->
    <link href="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css" rel="stylesheet">
</head>
<body>
<shiro:hasPermission name="message:send:send">
    <input id="p_send" style="display: none" value="1">
</shiro:hasPermission>
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="row">
                    <div class="col-lg-12">
                        <form id="myForm">
                            <div class="row">
                                <div class="col-xs-3">
                                    <div class="input-group">
                                        <span class="input-group-addon">消息发送对象</span>
                                        <select class="form-control" id="userType">
                                            <option value="">全部</option>
                                            <option value="sys_user_front">前台用户</option>
                                            <option value="sys_user_admin">后台用户</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <div class="input-group">
                                        <span class="input-group-addon">手机号码</span>
                                        <input type="text" class="form-control" id="phone">
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <div class="input-group">
                                        <span class="input-group-addon">消息名</span>
                                        <input type="text" class="form-control" id="messageName">
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <div class="input-group">
                                        <span class="input-group-addon">发送形式</span>
                                        <select class="form-control" id="sendType">
                                            <option value="">全部</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <br />
                            <div class="row">
                                <div class="col-xs-3">
                                    <div id="start_send_time" class="input-group date form_datetime col-md-12">
                                        <span class="input-group-addon">开始日期</span>
                                        <input id="startSendTime" name="startSendTime" class="form-control" size="16" type="text" value="" readonly>
                                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <div id="end_send_time" class="input-group date form_datetime col-md-12">
                                        <span class="input-group-addon">结束日期</span>
                                        <input id="endSendTime" name="endSendTime" class="form-control" size="16" type="text" value="" readonly>
                                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <div class="input-group">
                                        <span class="input-group-addon">消息发送状态</span>
                                        <select class="form-control" id="status">
                                            <option value="">全部</option>
                                            <option value="0">成功</option>
                                            <option value="1">失败</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <button type="button" class="btn btn-primary btn-sm" onclick="search(1)">查询</button>
                                    <button type="button" class="btn btn-primary btn-sm" onclick="$('#myForm')[0].reset();">重置</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="panel-body">
                <div class="table-responsive">
                    <table id="myTable"
                           class="table table-striped table-bordered table-hover"
                           data-url="<%=request.getContextPath()%>/admin/messageSend/json"
                           data-pageSize="10,50,100" data-method="GET">
                        <thead>
                        <tr>
                            <%--<th width="2%" data-field="id">ID</th>--%>
                            <th width="10%" data-field="userType" data-call="true">发送对象类型</th>
                            <th width="10%" data-field="realName" >名称</th>
                            <th width="10%" data-field="phone" >手机号码</th>
                            <th width="15%" data-field="messageName" data-call="true">消息名称</th>
                            <th width="5%" data-field="sendType" data-call="true">发送形式</th>
                            <th width="15%" data-field="sendTime" data-call="true">发送时间</th>
                            <th width="10%" data-field="status" data-call="true">发送状态</th>
                            <th width="15%" data-field="errorMsg" data-call="true">失败原因</th>
                            <th width="10%" data-field="button" data-call="true">操作</th>
                        </tr>
                        </thead>
                        <tbody id="tbodyId">
                        </tbody>
                    </table>
                </div>
                <div class="row">
                    <div align="left" class="col-xs-6">
                        <div class="input-group">
                            <span class="input-group-addon" id="pageCount"></span> <select
                                id="pageSize" onchange="search(1)" class="form-control"
                                style="width: 100px"></select>
                        </div>
                    </div>
                    <div align="right" class="col-xs-6">
                        <ul class="pagination" id="pagination"></ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/template/bootMainJs.jsp"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/utils.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/jqPaginator.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/myPage.js"></script>
<!-- bootstrap-datetimepicker -->
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript">

    $(function(){
        var sendType = $.parseJSON('${sendType}');
        for (var i = 0; i < sendType.length; i++) {
            $(new Option(sendType[i].dicDataName,sendType[i].dicDataValue)).appendTo('#sendType');
        }

        $('#start_send_time').datetimepicker({
            minView: "month", //选择日期后，不会再跳转去选择时分秒
            format: "yyyy-mm-dd", //选择日期后，文本框显示的日期格式
            language: 'zh-CN', //汉化
            autoclose:true //选择日期后自动关闭
        });
        $('#end_send_time').datetimepicker({
            minView: "month", //选择日期后，不会再跳转去选择时分秒
            format: "yyyy-mm-dd", //选择日期后，文本框显示的日期格式
            language: 'zh-CN', //汉化
            autoclose:true //选择日期后自动关闭
        });
    });

    function tableCallBack(data, id){
        if (id == 'sendType'){
            var sendType = $.parseJSON('${sendType}');
            for (var i = 0; i < sendType.length; i++) {
                if(sendType[i].dicDataValue == data.sendType) {
                    return sendType[i].dicDataName;
                    break;
                }
            }
        } else if (id == 'userType'){
            if(data[id] == 'sys_user_front'){
                return '前台用户';
            }else if(data[id] == 'sys_user_admin'){
                return '后台用户';
            }
        } else if (id == 'status'){
            if(data[id] == '0'){
                return '成功';
            }else if(data[id] == '1') {
                return '失败';
            }
        } else if(id == 'button') {
            if ($('#p_send').val() == 1) {
                if(data.status == '1') {
                    return '<button type="button" class="btn btn-primary btn-xs" onclick="sendDetail(\'' + data.id + '\');">推送</button> '
                            + '<button type="button" class="btn btn-primary btn-xs" onclick="viewContent(\'' + data.id + '\');">查看</button>';
                } else {
                    return '<button type="button" class="btn btn-primary btn-xs disabled">推送</button> '
                            + '<button type="button" class="btn btn-primary btn-xs" onclick="viewContent(\'' + data.id + '\');">查看</button>';
                }
            }
        } else {
            if(data[id] == null || data[id] == ''){
                return '';
            }else{
                return data[id];
            }
        }
    }

    function viewContent(id) {
        $.ajax({
            url: '<%=request.getContextPath()%>/admin/messageSend/messageDetail?id=' + id,
            dataType: 'json',
            type: 'GET',
            success: function (data) {
                if(data.status == 'ok'){
                    var index = layer.open({
                        type: 1,
                        title: data.msg.detailsTitle,
                        area: ['900px', '600px'],
                        offset: [100,(($(window).width()-900)/2)],
                        content: '<div style="margin:20px;">' + data.msg.detailsContent + '</div>'
                    });
                }else{
                    layer.alert(data.msg, {icon : 5});
                }
            },
            error: function(){
                layer.alert('系统错误', {icon : 5});
            }
        });
    }

    function sendDetail(id){
        //询问框
        layer.confirm('是否确定此操作？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.ajax({
                url: '<%=request.getContextPath()%>/admin/messageSend/sendForOne',
                dataType: 'json',
                type: 'POST',
                data: {
                    id: id
                },
                success: function (data) {
                    if(data.status == 'ok'){
                        layer.closeAll('dialog');
                        search(parseInt($('.active').attr('jp-data')));
                    }else{
                        layer.alert(data.msg, {icon : 5});
                    }
                },
                error: function(){
                    layer.alert('系统错误', {icon : 5});
                }
            });
        }, function(){

        });
    }
</script>
</body>
</html>