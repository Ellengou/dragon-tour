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
<shiro:hasPermission name="sys:res:menu:update">
    <input id="p_update" value="1" type="hidden">
</shiro:hasPermission>
<shiro:hasPermission name="sys:res:menu:updateStatus">
    <input id="p_update_status"  value="1" type="hidden">
</shiro:hasPermission>
<shiro:hasPermission name="sys:res:menu:delete">
    <input id="p_delete" value="1" type="hidden">
</shiro:hasPermission>
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <shiro:hasPermission name="sys:res:menu:add">
                <div class="panel-heading">
                    <button type="button" class="btn btn-primary" onclick="addMenu(0);">新增根节点菜单</button>
                    <button type="button" class="btn btn-primary" onclick="addMenu(1);">新增子菜单</button>
                </div>
            </shiro:hasPermission>
            <div class="panel-body">
                <table id="treeGrid" class="tree table table-bordered table-striped table-condensed">
                    <thead>
                    <tr>
                        <th data-field="id" width="10%">id</th>
                        <th data-field="name" width="10%">菜单名称</th>
                        <th data-field="url" width="30%">菜单url</th>
                        <th data-field="disorder" width="5%">菜单排序</th>
                        <th data-field="dataType" data-call="true" width="30%">菜单使用范围</th>
                        <th data-field="status" data-call="true" width="5%">是否启用</th>
                        <th data-field="button" data-call="true" width="10%">操作</th>
                    </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/template/bootMainJs.jsp"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/jquery.treegrid.js"></script>
<script type="text/javascript">
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
    function tableCallBack(data,id){
        if (id == 'dataType') {
            var result = '';
            if (data[id].indexOf('0') >= 0) {
                result = result + '<span class="label label-primary">平台</span> '
            }
            if (data[id].indexOf('1') >= 0) {
                result = result + '<span class="label label-primary">核心企业</span> '
            }
            if (data[id].indexOf('2') >= 0) {
                result = result + '<span class="label label-primary">第三方公司</span> '
            }
            if (data[id].indexOf('3') >= 0) {
                result = result + '<span class="label label-primary">子公司</span> '
            }
            if (data[id].indexOf('4') >= 0) {
                result = result + '<span class="label label-primary">部门</span> '
            }
            return result;
        } else if (id == 'status') {
            if (data[id] == '0') {
                return '停用';
            } else {
                return '启用';
            }
        } else if (id == 'button') {
            var _button = '';
            var count = 0;
            if ($('#p_update').val() == 1) {
                _button += '<button type="button" class="btn btn-primary btn-xs" onclick="editMenu(' + data.id + ');">编辑</button> ';
                count ++;
            }

            if ($('#p_update_status').val() == 1) {
                if(data.status == '0'){
                    _button += '<button type="button" class="btn btn-warning btn-xs" onclick="editStatus(\'' + data.id + '\',\'1\');">启用</button> ';
                } else {
                    _button += '<button type="button" class="btn btn-warning btn-xs" onclick="editStatus(\'' + data.id + '\',\'0\');">停用</button> ';
                }
                count ++;
            }

            if ($('#p_delete').val() == 1) {
                _button += '<button type="button" class="btn btn-danger btn-xs" onclick="deleteMenu(' + data.id + ');">删除</button>';
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

    function addMenu(type) {
        //iframe层-父子操作
        var pid = 0;
        if (type == 1) {
            var node = $('.tree').treegrid('getSelectData');
            if (node.length < 1) {
                layer.alert('请先选择父级菜单', {
                    icon : 6
                });
                return;
            } else {
                pid = node[0][0];
            }
        }

        var index = layer.open({
            type: 2,
            area: ['900px', '400px'],
            offset: [100,(($(window).width()-900)/2)],
            title: '菜单管理->新增菜单',
            content: ['<%=request.getContextPath()%>/admin/resource/menu/create?pid=' + pid, 'no']
        });

    }

    function editMenu(id){
        //iframe层-父子操作
        var index = layer.open({
            type: 2,
            area: ['900px', '400px'],
            offset: [100,(($(window).width()-900)/2)],
            title: '菜单管理->修改菜单',
            content: ['<%=request.getContextPath()%>/admin/resource/menu/update?id=' + id,'no']
        });
    }

    function deleteMenu(id) {
        layer.confirm('是否确定此操作？', {
            btn: ['确定','取消'] //按钮
        }, function() {
            $.ajax({
                type: 'POST',
                url: '<%=request.getContextPath()%>/admin/resource/menu/delete/',
                dataType: 'json',
                data: {
                    id: id
                },
                success: function (data) {
                    if (data.status == 'ok') {
                        layer.alert('删除成功!', {
                            icon: 6
                        }, function(index){
                            layer.closeAll('dialog');
                            location.reload();
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

    function refreshGrid() {
        $('#treeGrid').treegrid({
            data:'<%=request.getContextPath()%>/admin/resource/menu/json?id=0',
            initialState: 'collapse',
            removeCss: false,
            ifSelectOne:true,
            expanderExpandedClass: 'glyphicon glyphicon-menu-down',
            expanderCollapsedClass: 'glyphicon glyphicon-menu-right'
        });
    }

    function editStatus(id, status){
        //询问框
        layer.confirm('是否确定此操作？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.ajax({
                url: '<%=request.getContextPath()%>/admin/resource/menu/updateStatus',
                dataType: 'json',
                type: 'POST',
                data: {
                    id:id,
                    status:status
                },
                success: function (data) {
                    if(data.status == 'ok'){
                        layer.closeAll('dialog');
                        refreshGrid();
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
