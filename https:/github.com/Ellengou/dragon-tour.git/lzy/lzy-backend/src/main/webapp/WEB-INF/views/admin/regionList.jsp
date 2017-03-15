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
<shiro:hasPermission name="sys:region:edit">
    <input id="p_update"  value="1" type="hidden">
</shiro:hasPermission>
<shiro:hasPermission name="sys:region:delete">
    <input id="p_delete"  value="1" type="hidden">
</shiro:hasPermission>
<shiro:hasPermission name="sys:region:comp:edit">
    <input id="p_comp_update"  value="1" type="hidden">
</shiro:hasPermission>
<shiro:hasPermission name="sys:region:status:edit">
    <input id="p_status_update"  value="1" type="hidden">
</shiro:hasPermission>
<div class="row">
    <div class="col-md-9">
        <div class="panel panel-default">
            <shiro:hasPermission name="sys:region:add">
                <div class="panel-heading">
                    <button type="button" class="btn btn-primary" onclick="addRegion(0);">新增根节点区域</button>
                    <button type="button" class="btn btn-primary" onclick="addRegion(1);">新增子区域</button>
                </div>
            </shiro:hasPermission>
            <div class="panel-body">
                <table id="treeGrid" class="tree table table-bordered table-striped table-condensed">
                    <thead>
                    <tr>
                        <th data-field="id" width="5%" >id</th>
                        <th data-field="code" width="10%">区域编码</th>
                        <th data-field="name" width="10%">区域名称</th>
                        <th data-field="charge" width="10%">区域负责人</th>
                        <th data-field="chargePhone" width="20%">负责人电话</th>
                        <th data-field="operateTime" width="15%">修改时间</th>
                        <th data-field="status" data-call="true" width="10%">是否启用</th>
                        <th data-field="button" data-call="true" width="20%">操作</th>
                    </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="panel panel-primary">
            <div class="panel-heading">
                公司列表
            </div>
            <div class="panel-body">
                <ul id="tree" class="ztree">
                </ul>
            </div>
        </div>
        <shiro:hasPermission name="sys:region:comp:edit">
            <button type="button" class="btn btn-primary btn-lg btn-block" onclick="editRegionCompSubmit();">保存修改</button>
        </shiro:hasPermission>
    </div>
</div>

<%@ include file="/WEB-INF/views/template/bootMainJs.jsp"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/jquery.treegrid.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/zTree/jquery.ztree.core.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/zTree/jquery.ztree.excheck.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/zTree/jquery.ztree.exhide.js"></script>

<script type="text/javascript">
    var currentRole = -1;
    var zTree;

    var setting = {
        async: {
            enable: true,
            url:'<%=request.getContextPath()%>/admin/region/allComp',
//            otherParam:{"pid":"0"},
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
                name: 'compName',
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
        // left
        $('#treeGrid').treegrid({
            data:'<%=request.getContextPath()%>/admin/region/json?id=0',
            initialState: 'collapse',
            removeCss: false,
            ifSelectOne:true,
            expanderExpandedClass: 'glyphicon glyphicon-triangle-bottom',
            expanderCollapsedClass: 'glyphicon glyphicon-triangle-right'
        });

        // right
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
                return '启用';
            }
        } else if(id == 'button') {
            var _button = '';
            var count = 0;
            if ($('#p_update').val() == 1) {
                _button += '<button type="button" class="btn btn-primary btn-xs" onclick="editRegion(' + data.id + ');">编辑</button> ';
                count ++;
            }

            if ($('#p_comp_update').val() == 1) {
                _button += '<button type="button" class="btn btn-warning btn-xs" onclick="editRegionCom(' + data.id + ');"> 修改区域范围</button> ';
                count ++
            }

            if ($('#p_status_update').val() == 1) {
                if(data.status == '0'){
                    _button += '<button type="button" class="btn btn-warning btn-xs" onclick="editStatus(\'' + data.id + '\',\'1\');">启用</button> ';
                } else {
                    _button += '<button type="button" class="btn btn-warning btn-xs" onclick="editStatus(\'' + data.id + '\',\'0\');">停用</button> ';
                }
                count ++;
            }

            if ($('#p_delete').val() == 1) {
                _button += '<button type="button" class="btn btn-danger btn-xs" onclick="deleteRegion(' + data.id + ');">删除</button> ';
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

    function addRegion(type) {
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
            area: ['900px', '500px'],
            offset: [100,(($(window).width()-900)/2)],
            title: '区域管理->新增区域',
            content: ['<%=request.getContextPath()%>/admin/region/create?pid=' + pid, 'no']
        });
    }

    function editRegion(id){
        //iframe层-父子操作
        var index = layer.open({
            type: 2,
            area: ['900px', '500px'],
            offset: [100,(($(window).width()-900)/2)],
            title: '区域管理->修改区域',
            content: ['<%=request.getContextPath()%>/admin/region/update?id=' + id,'no']
        });
    }

    function editStatus(id, status){
        //询问框
        layer.confirm('是否确定此操作？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.ajax({
                url: '<%=request.getContextPath()%>/admin/region/updateStatus',
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

    function deleteRegion(id){
        layer.confirm('是否确定此操作？', {
            btn: ['确定','取消'] //按钮
        }, function() {
            $.ajax({
                type: 'POST',
                url: '<%=request.getContextPath()%>/admin/region/delete',
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

    function editRegionCom(id) {
        currentRole = id;
        zTree.checkAllNodes(false);
        zTree.showNodes();
        $.ajax({
            type:'GET',
            url:  '<%=request.getContextPath()%>/admin/region/jsonInComp?regionId=' + id,
            dataType:'json',
            success: function (data) {
                if (data) {
                    var pRegion = data.pRegion; // 父类所有公司ID
                    var oRegion = data.oRegion; // 其他同级区域所有公司ID
                    var cRegion = data.cRegion; // 已经被选择的公司ID

                    var nodes = zTree.getNodes();
                    for (var i = 0; i < nodes.length; i ++) {
                        console.log(nodes[i].id);
                        zTree.setChkDisabled(nodes[i], false);
                        zTree.showNode(nodes[i]);

                        if ($.inArray(nodes[i].id, pRegion) >= 0) {
                            if ($.inArray(nodes[i].id, oRegion) >= 0) {
                                zTree.setChkDisabled(nodes[i], true);
                            } else {
//                                alert($.inArray(nodes[i].id, cRegion) )
                                if ($.inArray(nodes[i].id, cRegion) >= 0) {
//                                    alert(1);
                                    zTree.checkNode(nodes[i], true, true);
                                }
                            }
                        } else {
//                            nodes[i].chkDisabled = true;
                            zTree.hideNode(nodes[i]);
                        }
                    }

//                    for (var i = 0; i < data.length; i ++) {
//                        var node = zTree.getNodeByParam("id", data[i]);
//                        if (node != null) {
//                            zTree.checkNode(node, true, true);
//                        }
//                    }
                }
            },
            error: function(){
                layer.alert('系统错误', {
                    icon : 5
                });
            }
        });
    }

    function editRegionCompSubmit() {
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
            url: '<%=request.getContextPath()%>/admin/region/' + currentRole + '/updateCompRegion/',
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

    function refreshGrid() {
        $('#treeGrid').treegrid({
            data:'<%=request.getContextPath()%>/admin/region/json?id=0',
            initialState: 'collapse',
            removeCss: false,
            ifSelectOne:true,
            expanderExpandedClass: 'glyphicon glyphicon-menu-down',
            expanderCollapsedClass: 'glyphicon glyphicon-menu-right'
        });
    }
</script>
</body>
</html>
