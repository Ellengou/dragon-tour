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
<shiro:hasPermission name="message:detail:update">
    <input id="p_update" style="display: none" value="1">
</shiro:hasPermission>
<shiro:hasPermission name="message:detail:updateStatus">
    <input id="p_update_status" value="1" type="hidden">
</shiro:hasPermission>
<shiro:hasPermission name="message:detail:send">
    <input id="p_send" style="display: none" value="1">
</shiro:hasPermission>
<shiro:hasPermission name="message:detail:delete">
    <input id="p_delete" style="display: none" value="1">
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
                                        <span class="input-group-addon">消息标题</span>
                                        <input type="text" class="form-control" id="name">
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
                                <div class="col-xs-3">
                                    <div class="input-group">
                                        <span class="input-group-addon">消息类型</span>
                                        <select class="form-control" id="typeId">
                                            <option value="">全部</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <div class="input-group">
                                        <span class="input-group-addon">发送对象</span>
                                        <select class="form-control" id="userType">
                                            <option value="">全部</option>
                                            <option value="sys_user_front">前台用户</option>
                                            <option value="sys_user_admin">后台用户</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <br />
                            <div class="row">
                                <div class="col-xs-3">
                                    <div class="input-group">
                                        <span class="input-group-addon">是否群发</span>
                                        <select class="form-control" id="isGroup">
                                            <option value="">全部</option>
                                            <option value="0">是</option>
                                            <option value="1">否</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <div class="input-group">
                                        <span class="input-group-addon">消息状态</span>
                                        <select class="form-control" id="status">
                                            <option value="">全部</option>
                                            <option value="0">启用</option>
                                            <option value="1">停用</option>
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

            <div class="panel-heading">
                <shiro:hasPermission name="message:detail:add">
                    <button type="button" class="btn btn-primary" onclick="addDetail();">新增</button>
                </shiro:hasPermission>
            </div>

            <div class="panel-body">
                <div class="table-responsive">
                    <table id="myTable"
                           class="table table-striped table-bordered table-hover"
                           data-url="<%=request.getContextPath()%>/admin/messageDetail/json"
                           data-pageSize="10,50,100" data-method="GET">
                        <thead>
                        <tr>
                            <th width="5%" data-field="id">ID</th>
                            <th width="10%" data-field="sendType" data-call="true">发送类型</th>
                            <th width="10%" data-field="typeId" data-call="true">消息类型</th>
                            <th width="20%" data-field="name">消息名称</th>
                            <th width="10%" data-field="userType" data-call="true">消息对象类型</th>
                            <th width="10%" data-field="isGroup" data-call="true">是否群发</th>
                            <th width="15%" data-field="operatorTime" data-call="true">操作时间</th>
                            <th width="5%" data-field="status" data-call="true">状态</th>
                            <th width="15%" data-field="button" data-call="true">操作</th>
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

        var sysMessageTypes = $.parseJSON('${sysMessageTypes}');
        for (var i = 0; i < sysMessageTypes.length; i++) {
            $(new Option(sysMessageTypes[i].name,sysMessageTypes[i].id)).appendTo('#typeId');
        }
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
        } else if (id == 'typeId'){
            var sysMessageTypes = $.parseJSON('${sysMessageTypes}');
            for (var i = 0; i < sysMessageTypes.length; i++) {
                if(sysMessageTypes[i].id == data.typeId) {
                    return sysMessageTypes[i].name;
                    break;
                }
            }
        } else if (id == 'isGroup') {
            if (data[id] == '0') {
                return '是';
            } else {
                return '否';
            }
        } else if (id == 'userType'){
            if(data[id] == 'sys_user_front'){
                return '前台用户';
            }else if(data[id] == 'sys_user_admin'){
                return '后台用户';
            }
        } else if (id == 'status'){
            if(data[id] == '0'){
                return '启用';
            }else if(data[id] == '1') {
                return '停用';
            }
        } else if(id == 'button') {
            var _button = '';
            if ($('#p_update').val() == 1) {
                _button += '<button type="button" class="btn btn-primary btn-xs" onclick="editDetail(' + data.id + ');">编辑</button> ';
            }

            if ($('#p_update_status').val() == 1) {
                if(data.status == '0') {
                    if ($('#p_send').val() == 1) {
                        if (data.isGroup == '0') {
                            _button += '<button type="button" class="btn btn-primary btn-xs" onclick="sendDetail(' + data.id + ');">推送</button> ';
                        } else {
                            _button += '<button type="button" class="btn btn-primary btn-xs disabled" onclick="sendDetail(' + data.id + ');">推送</button> ';
                        }
                    }
                    _button += '<button type="button" class="btn btn-warning btn-xs" onclick="editStatus(\'' + data.id + '\',\'1\');">停用</button> ';
                } else {
                    if ($('#p_send').val() == 1) {
                        _button += '<button type="button" class="btn btn-primary btn-xs disabled">推送</button> ';
                    }
                    _button += '<button type="button" class="btn btn-warning btn-xs" onclick="editStatus(\'' + data.id + '\',\'0\');">启用</button> ';
                }
            }

            if ($('#p_delete').val() == 1) {
                _button += '<button type="button" class="btn btn-danger btn-xs" onclick="deleteDetail(' + data.id + ');">删除</button> ';
            }

            return _button;
        } else {
            if(data[id] == null || data[id] == ''){
                return '';
            }else{
                return data[id];
            }
        }
    }

    function addDetail(){
        var index = layer.open({
            type: 2,
            area: ['900px', '700px'],
            offset: [100,(($(window).width()-900)/2)],
            title: '添加消息',
            content: ['<%=request.getContextPath()%>/admin/messageDetail/create','no']
        });
        layer.full(index);
    }

    function editDetail(id){
        var index = layer.open({
            type: 2,
            area: ['900px', '700px'],
            offset: [100,(($(window).width()-900)/2)],
            title: '修改消息信息',
            content: ['<%=request.getContextPath()%>/admin/messageDetail/update?id=' + id,'no']
        });
        layer.full(index);
    }

    function sendDetail(id){
        var index = layer.open({
            type: 2,
            area: ['600px', '350px'],
            offset: [100,(($(window).width()-600)/2)],
            title: '推送消息信息',
            content: ['<%=request.getContextPath()%>/admin/messageSend/send?id=' + id,'no']
        });
    }

    function deleteDetail(id){
        layer.confirm('是否确定此操作？', {
            btn: ['确定','取消'] //按钮
        }, function() {
            $.ajax({
                type: 'POST',
                url: '<%=request.getContextPath()%>/admin/messageDetail/delete?id=' + id,
                dataType: 'json',
                success: function (data) {
                    if (data.status == 'ok') {
                        layer.alert('删除成功!', {
                            icon: 6
                        }, function(index){
                            layer.closeAll('dialog');
                            search(1);
                        });
                    } else {
                        layer.alert(data.msg, {
                            icon: 56
                        });
                    }
                }
            });
        });
    }

    function editStatus(id, status){
        //询问框
        layer.confirm('是否确定此操作？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.ajax({
                url: '<%=request.getContextPath()%>/admin/messageDetail/updateStatus',
                dataType: 'json',
                type: 'POST',
                data: {
                    id:id,
                    status:status
                },
                success: function (data) {
                    if(data.status == 'ok'){
                        layer.closeAll('dialog');
                        search(1);
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