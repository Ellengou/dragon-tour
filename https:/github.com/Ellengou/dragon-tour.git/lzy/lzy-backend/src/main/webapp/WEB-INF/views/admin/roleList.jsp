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
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/plugin/zTree/demo.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap/plugin/zTree/metroStyle.css">
</head>
<body>
<shiro:hasPermission name="sys:role:update">
    <input id="p_update"  value="1" type="hidden">
</shiro:hasPermission>
<shiro:hasPermission name="sys:role:delete">
    <input id="p_delete"  value="1" type="hidden">
</shiro:hasPermission>
<shiro:hasPermission name="sys:role:resUpdate">
    <input id="p_res_update"  value="1" type="hidden">
</shiro:hasPermission>
<div class="row">
    <div class="col-md-9">
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="row">
                    <div class="col-lg-12">
                        <form id="myForm">
                            <div class="row">
                                <div class="col-xs-4">
                                    <div class="input-group">
                                        <span class="input-group-addon">角色名</span>
                                        <input type="text" class="form-control" id="rlname">
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <input type="hidden" id="type" value="1">
                                    <button type="button" class="btn btn-primary btn-sm" onclick="search(1)">查询</button>
                                    <button type="button" class="btn btn-primary btn-sm" onclick="$('#myForm')[0].reset();">重置</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <shiro:hasPermission name="sys:role:add">
                <div class="panel-heading">
                    <button type="button" class="btn btn-primary" onclick="addRole();">新增</button>
                </div>
            </shiro:hasPermission>
            <div class="panel-body">
                <div class="table-responsive">
                    <table id="myTable"
                           class="table table-striped table-bordered table-hover"
                           data-url="<%=request.getContextPath()%>/admin/role/json"
                           data-pageSize="10,50,100" data-method="get">
                        <thead>
                        <tr>
                            <th width="20" data-field="id">ID</th>
                            <th width="50" data-field="rlname">角色名</th>
                            <th width="50" data-field="memo">备注</th>
                            <th width="100" data-field="status" data-call="true">状态</th>
                            <th width="50" data-field="button" data-call="true">操作</th>
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
    <div class="col-md-3">
        <div class="panel panel-primary">
            <div class="panel-heading">
                菜单列表
            </div>
            <div class="panel-body">
                <ul id="tree" class="ztree">
                </ul>
            </div>
        </div>
        <shiro:hasPermission name="sys:role:resUpdate">
            <button type="button" class="btn btn-primary btn-lg btn-block" onclick="editRoleResSubmit();">保存修改</button>
        </shiro:hasPermission>
    </div>
</div>

<%@ include file="/WEB-INF/views/template/bootMainJs.jsp"%>

<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/jqPaginator.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/myPage.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/zTree/jquery.ztree.core.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/zTree/jquery.ztree.excheck.js"></script>

<script type="text/javascript">
    var currentRole = -1;
    var zTree;

    var setting = {
        async: {
            enable: true,
            url:'<%=request.getContextPath()%>/admin/resource/jsonInRole',
            otherParam:{"pid":"0"},
            type: "get",
        },
        view: {
            selectedMulti: false
        },
        check: {
            enable: true,
            chkboxType: { "Y": "p", "N": "s" }
        },
        data: {
            key: {
                url:null
            },
        },
        callback: {
            beforeExpand: beforeExpand,
            onExpand: onExpand,
            onClick: onClick
        }
    };

    $(function () {
        zTree = $.fn.zTree.init($("#tree"), setting);
    });

    var curExpandNode = null;
    function beforeExpand(treeId, treeNode) {
        var pNode = curExpandNode ? curExpandNode.getParentNode():null;
        var treeNodeP = treeNode.parentTId ? treeNode.getParentNode():null;
        var zTree = $.fn.zTree.getZTreeObj("tree");
        for(var i=0, l=!treeNodeP ? 0:treeNodeP.children.length; i<l; i++ ) {
            if (treeNode !== treeNodeP.children[i]) {
                zTree.expandNode(treeNodeP.children[i], false);
            }
        }
        while (pNode) {
            if (pNode === treeNode) {
                break;
            }
            pNode = pNode.getParentNode();
        }
        if (!pNode) {
            singlePath(treeNode);
        }

    }

    function singlePath(newNode) {
        if (newNode === curExpandNode) return;

        var zTree = $.fn.zTree.getZTreeObj("tree"),
                rootNodes, tmpRoot, tmpTId, i, j, n;

        if (!curExpandNode) {
            tmpRoot = newNode;
            while (tmpRoot) {
                tmpTId = tmpRoot.tId;
                tmpRoot = tmpRoot.getParentNode();
            }
            rootNodes = zTree.getNodes();
            for (i=0, j=rootNodes.length; i<j; i++) {
                n = rootNodes[i];
                if (n.tId != tmpTId) {
                    zTree.expandNode(n, false);
                }
            }
        } else if (curExpandNode && curExpandNode.open) {
            if (newNode.parentTId === curExpandNode.parentTId) {
                zTree.expandNode(curExpandNode, false);
            } else {
                var newParents = [];
                while (newNode) {
                    newNode = newNode.getParentNode();
                    if (newNode === curExpandNode) {
                        newParents = null;
                        break;
                    } else if (newNode) {
                        newParents.push(newNode);
                    }
                }
                if (newParents!=null) {
                    var oldNode = curExpandNode;
                    var oldParents = [];
                    while (oldNode) {
                        oldNode = oldNode.getParentNode();
                        if (oldNode) {
                            oldParents.push(oldNode);
                        }
                    }
                    if (newParents.length>0) {
                        zTree.expandNode(oldParents[Math.abs(oldParents.length-newParents.length)-1], false);
                    } else {
                        zTree.expandNode(oldParents[oldParents.length-1], false);
                    }
                }
            }
        }
        curExpandNode = newNode;
    }

    function onExpand(event, treeId, treeNode) {
        curExpandNode = treeNode;
    }

    function onClick(e,treeId, treeNode) {
        zTree.expandNode(treeNode, null, null, null, true);
    }

    //---------------------------------------

    function tableCallBack(data,id){
        if (id == 'status'){
            if (data[id] == '0') {
                return '停用';
            } else if (data[id] == '1'){
                return '启用（仅限本企业数据）';
            } else if (data[id] == '2') {
                return '启用（本企业数据以及旗下公司所有数据）';
            } else if (data[id] == '3') {
                return '超级管理员';
            }
        } else if(id == 'button') {
            var _button = '';
            var count = 0;
            if ($('#p_update').val() == 1) {
                _button += '<button type="button" class="btn btn-primary btn-xs" onclick="editRole(' + data.id + ');">编辑</button> ';
                count ++;
            }

            if ($('#p_res_update').val() == 1) {
                _button += '<button type="button" class="btn btn-warning btn-xs" onclick="editRoleRes(' + data.id + ');"> 修改权限 </button> ';
                count ++
            }

            if ($('#p_delete').val() == 1) {
                _button += '<button type="button" class="btn btn-danger btn-xs" onclick="deleteRole(' + data.id + ');">删除</button> ';
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

    function addRole() {
        //iframe层-父子操作
        var index = layer.open({
            type: 2,
            area: ['900px', '300px'],
            offset: [100,(($(window).width()-900)/2)],
            title: '用户管理->新增用户',
            content: ['<%=request.getContextPath()%>/admin/role/create','no']
        });
    }

    function editRole(id){
        //iframe层-父子操作
        var index = layer.open({
            type: 2,
            area: ['900px', '300px'],
            offset: [100,(($(window).width()-900)/2)],
            title: '用户管理->修改用户',
            content: ['<%=request.getContextPath()%>/admin/role/update?id=' + id,'no']
        });
    }

    function deleteRole(id){
        layer.confirm('删除时，对应用户相关权限也将被删除！是否确定此操作？', {
            btn: ['确定','取消'] //按钮
        }, function() {
            $.ajax({
                type: 'POST',
                url: '<%=request.getContextPath()%>/admin/role/delete/',
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
                            icon: 5
                        });
                    }
                }
            });
        });
    }

    function editRoleRes(id) {
        currentRole = id;
        zTree.checkAllNodes(false);

        $.ajax({
            type:'GET',
            url:  '<%=request.getContextPath()%>/admin/role/res/json?roleId=' + id,
            dataType:'json',
            success: function (data) {
                if (data) {
                    for (var i = 0; i < data.length; i ++) {
                        var node = zTree.getNodeByParam("id", data[i]);
                        if (node != null) {
                            zTree.checkNode(node, true, true);
                        }
                    }
                }
            },
            error: function(){
                layer.alert('系统错误', {
                    icon : 5
                });
            }
        });
    }

    function editRoleResSubmit() {
        if (currentRole == -1) {
            layer.alert('请点击对应角色的修改权限按钮！', {
                icon : 6
            });
            return;
        }

        var nodes = zTree.getCheckedNodes(true);
        var newResourceList = [];
        for (var i = 0; i < nodes.length; i++) {
            newResourceList.push(nodes[i].id);
        }
        $.ajax({
            type: 'POST',
            url: '<%=request.getContextPath()%>/admin/role/' + currentRole + '/updateRoleRes/',
            dataType:'json',
            contentType: 'application/json',
            data:JSON.stringify(newResourceList),
            success: function (data) {
                console.log(data);
                if (data.status == 'ok') {
                    layer.alert('权限分配成功！', {
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
