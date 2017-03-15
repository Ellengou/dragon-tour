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
    <%@ include file="/WEB-INF/views/template/bootMainCss.jsp"%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/css/jquery.treegrid.css">
</head>
<body>
<form id="myForm">
    <input type="hidden" id="pid" value="-1">
</form>
<shiro:hasPermission name="sys:res:update">
    <input id="p_update"  value="1" type="hidden">
</shiro:hasPermission>
<shiro:hasPermission name="sys:res:updateStatus">
    <input id="p_update_status"  value="1" type="hidden">
</shiro:hasPermission>
<shiro:hasPermission name="sys:res:delete">
    <input id="p_delete"  value="1" type="hidden">
</shiro:hasPermission>
<div class="row">
    <div class="col-md-3">
        <div class="panel panel-primary">
            <div class="panel-heading">
                菜单列表
            </div>
            <div class="panel-body">
                <table id="treeGrid" class="tree table table-bordered table-striped table-condensed">
                    <thead>
                    <tr>
                        <th data-field="id" width="80">id</th>
                        <th data-field="name" width="200">name</th>
                    </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="col-md-9">
        <div class="panel panel-primary">
            <div class="panel-heading">
                资源列表
            </div>
            <div class="panel-body">
                <div class="panel-heading">
                    <shiro:hasPermission name="sys:res:add">
                        <button type="button" class="btn btn-primary" onclick="addResource();">新增</button>
                    </shiro:hasPermission>
                </div>
                <div class="table-responsive">
                    <table id="myTable"
                           class="table table-striped table-bordered table-hover"
                           data-url="<%=request.getContextPath()%>/admin/resource/opera/json"
                           data-pageSize="10,50,100" data-method="get">
                        <thead>
                        <tr>
                            <th width="10%" data-field="id">ID</th>
                            <th width="17%" data-field="name">资源名称</th>
                            <th width="16%" data-field="code">资源编码</th>
                            <th width="17%" data-field="remark">资源描述</th>
                            <th data-field="dataType" data-call="true" width="15%">菜单使用范围</th>
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
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/jqPaginator.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/myPage.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/jquery.treegrid.js"></script>
<script type="text/javascript">
    var pid = -1;

    $(function() {
        $('#treeGrid').treegrid({
            data:'<%=request.getContextPath()%>/admin/resource/menu/json?id=0',
            initialState: 'collapse',
            removeCss: false,
            ifSelectOne:true,
            expanderExpandedClass: 'glyphicon glyphicon-triangle-bottom',
            expanderCollapsedClass: 'glyphicon glyphicon-triangle-right'
        });
    });

    function clickCallBack(node, data) {
        $('#pid').val(data);
        search(1);
    }

    function tableCallBack(data,id){
        if (id == 'dataType') {
            var result = '';
            if (data[id].indexOf('0') >= 0) {
                result = result + '<span class="label label-primary">平</span> '
            }
            if (data[id].indexOf('1') >= 0) {
                result = result + '<span class="label label-primary">核</span> '
            }
            if (data[id].indexOf('2') >= 0) {
                result = result + '<span class="label label-primary">三</span> '
            }
            if (data[id].indexOf('3') >= 0) {
                result = result + '<span class="label label-primary">子</span> '
            }
            if (data[id].indexOf('4') >= 0) {
                result = result + '<span class="label label-primary">部</span> '
            }
            return result;
        } else if(id == 'status'){
            if (data[id] == '0') {
                return '停用';
            } else if (data[id] == '1'){
                return '启用';
            }
        } else if(id == 'button') {
            var _button = '';
            var count = 0;
            if ($('#p_update').val() == 1) {
                _button += '<button type="button" class="btn btn-primary btn-xs" onclick="editResource(' + data.id + ');">编辑</button> ';
                count ++;
            }
            if ($('#p_update_status').val() == 1) {
                if(data.status == '0'){
                    _button += '<button type="button" class="btn btn-warning btn-xs" onclick="editStatus(\'' + data.id + '\',\'1\');">启用</button> ';
                }else{
                    _button += '<button type="button" class="btn btn-warning btn-xs" onclick="editStatus(\'' + data.id + '\',\'0\');">停用</button> ';
                }
                count ++;
            }
            if ($('#p_delete').val() == 1) {
                _button += '<button type="button" class="btn btn-danger btn-xs" onclick="deleteResource(' + data.id + ');">删除</button>';
                count ++
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

    function addResource() {
        pid = $('#pid').val();
        if (pid == -1) {
            layer.alert('请先选择菜单', {
                icon: 5
            });
            return;
        }
        //iframe层-父子操作
        var index = layer.open({
            type: 2,
            area: ['900px', '400px'],
            offset: [100,(($(window).width()-900)/2)],
            title: '资源管理->新增资源',
            content: ['<%=request.getContextPath()%>/admin/resource/create?pid=' + pid, 'no']
        });
    }

    function editResource(id){
        //iframe层-父子操作
        var index = layer.open({
            type: 2,
            area: ['900px', '400px'],
            offset: [100,(($(window).width()-900)/2)],
            title: '资源管理->修改资源',
            content: ['<%=request.getContextPath()%>/admin/resource/update?id=' + id,'no']
        });
    }
    
    function deleteResource(id) {
        layer.confirm('是否确定此操作？', {
            btn: ['确定','取消'] //按钮
        }, function() {
            $.ajax({
                type: 'POST',
                url: '<%=request.getContextPath()%>/admin/resource/delete',
                dataType: 'json',
                data: {
                    id: id
                },
                success: function (data) {
                    if (data.status == 'ok') {
                        layer.closeAll('dialog');
                        search(parseInt($('.active').attr('jp-data')));
                        layer.alert('删除成功！', {
                            icon: 6
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
                url: '<%=request.getContextPath()%>/admin/resource/updateStatus',
                dataType: 'json',
                type: 'POST',
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
