<%--
  Created by IntelliJ IDEA.
  User: violorch
  Date: 2016/6/6
  Time: 10:14
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
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/jquery.treegrid.css">
</head>
<body>
<shiro:hasPermission name="protocol:type:update">
    <input id="p_update" style="display: none" value="1">
</shiro:hasPermission>
<shiro:hasPermission name="protocol:type:updateStatus">
    <input id="p_update_status" style="display: none" value="1">
</shiro:hasPermission>
<shiro:hasPermission name="protocol:type:delete">
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
                                <div class="col-xs-2">
                                    <div class="input-group">
                                        <span class="input-group-addon">名称</span>
                                        <input type="text" class="form-control" id="name">
                                    </div>
                                </div>
                                <div class="col-xs-2">
                                    <div class="input-group">
                                        <span class="input-group-addon">状态</span>
                                        <select class="form-control" id="status">
                                            <option value="">全部</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-xs-2">
                                    <div class="input-group">
                                        <span class="input-group-addon">类型</span>
                                        <select class="form-control" id="type">
                                            <option value="">全部</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-xs-2">
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
                           data-url="<%=request.getContextPath()%>/admin/protocolType/json"
                           data-pageSize="10,50,100" data-method="get">
                        <thead>
                        <tr>
                            <th width="10%" data-field="id">ID</th>
                            <th width="30%" data-field="name">名称</th>
                            <th width="15%" data-field="type" data-call="true">类型</th>
                            <th width="10%" data-field="status" data-call="true">状态</th>
                            <th width="20%" data-field="button" data-call="true">操作</th>
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
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/jqPaginator.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/myPage.js"></script>
<script type="text/javascript">
    $(function(){
        var typeList = $.parseJSON('${typeList}');
        for (var i = 0; i < typeList.length; i++) {
            $(new Option(typeList[i].dicDataName,typeList[i].dicDataValue)).appendTo('#type');
        }

        var enabledStatusList =$.parseJSON('${enabledStatusList}');
        for (var i = 0; i < enabledStatusList.length; i++) {
            $(new Option(enabledStatusList[i].dicDataName,enabledStatusList[i].dicDataValue)).appendTo('#status');
        }
    });

    function tableCallBack(data,id){
        if (id == 'type') {
            var typeList = ${typeList};
            for (var i = 0; i < typeList.length; i++) {
                if(data[id] == typeList[i].dicDataValue){
                    return typeList[i].dicDataName;
                    break;
                }
            }
            return data[id];
        } else if (id == 'status'){
            var enabledStatusList = ${enabledStatusList};
            for (var i = 0; i < enabledStatusList.length; i++) {
                if(data[id] == enabledStatusList[i].dicDataValue){
                    return enabledStatusList[i].dicDataName;
                    break;
                }
            }
            return data[id];
        }else if(id == 'button'){
            var str = '';
            if($('#p_update_status').val() == 1){
                if(data.status == '0'){
                    str = str + '<button type="button" class="btn btn-warning btn-xs" onclick="editStatus(\'' + data.id + '\',\'1\');">禁用</button> ';
                }else{
                    str = str + '<button type="button" class="btn btn-warning btn-xs" onclick="editStatus(\'' + data.id + '\',\'0\');">启用</button> ';
                }
            }
            if($('#p_delete').val() == 1){
                str = str + '<button type="button" class="btn btn-danger btn-xs" onclick="deleteProtocol(\'' + data.id + '\');">删除</button> ';
            }
            return str;
        }else{
            if(data[id] == null || data[id] == ''){
                return '';
            }else{
                return data[id];
            }
        }
    }

    function add(){
        layer.open({
            type: 2,
            area: ['500px', '400px'],
            offset: [100,(($(window).width()-500)/2)],
            title: '增加协议类型',
            content: ['<%=request.getContextPath()%>/admin/protocolType/create','no']
        });
    }

    function edit(id){
        layer.open({
            type: 2,
            area: ['500px', '400px'],
            offset: [100,(($(window).width()-500)/2)],
            title: '修改协议类型',
            content: ['<%=request.getContextPath()%>/admin/protocolType/update?id=' + id,'no']
        });
    }

    function deleteProtocol(id){
        //询问框
        layer.confirm('是否确定此操作？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.ajax({
                url: '<%=request.getContextPath()%>/admin/protocolType/delete',
                dataType: 'json',
                type: 'post',
                data: {
                    id:id
                },
                success: function (data) {
                    if(data.status == 'ok'){
                        layer.alert('删除成功', {icon : 6});
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

    function editStatus(id,status){
        //询问框
        layer.confirm('是否确定此操作？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.ajax({
                url: '<%=request.getContextPath()%>/admin/protocolType/updateStatus',
                dataType: 'json',
                type: 'post',
                data: {
                    id:id,
                    status:status
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