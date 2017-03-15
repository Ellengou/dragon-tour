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
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">合同类型管理</h1>
	</div>
</div>
<shiro:hasPermission name="contract:type:update">
	<input id="p_update" value="1" type="hidden">
</shiro:hasPermission>
<shiro:hasPermission name="contract:type:delete">
	<input id="p_delete" value="1" type="hidden">
</shiro:hasPermission>
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<shiro:hasPermission name="contract:type:add">
				<div class="panel-heading">
					<button type="button" class="btn btn-primary" onclick="addType(0);">新增根节点类型</button>
					<button type="button" class="btn btn-primary" onclick="addType(1);">新增子类型</button>
				</div>
			</shiro:hasPermission>
			<div class="panel-body">
				<table id="treeGrid" class="tree table table-bordered table-striped table-condensed">
					<thead>
					<tr>
						<th data-field="id" width="80">id</th>
						<th data-field="name" width="200">name</th>
						<th data-field="status" data-call="true" width="100">是否启用</th>
						<th data-field="button" data-call="true" width="100">操作</th>
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
			data:'<%=request.getContextPath()%>/admin/contractType/json?id=0',
			initialState: 'collapse',
			removeCss: false,
			ifSelectOne:true,
			expanderExpandedClass: 'glyphicon glyphicon-menu-down',
			expanderCollapsedClass: 'glyphicon glyphicon-menu-right'
		});
	});
	function tableCallBack(data,id){
		if (id == 'status') {
			if (data[id] == '0') {
				return '启用';
			} else {
				return '停用';
			}
		} else if (id == 'button') {
			var _button = '';
			var count = 0;
			if ($('#p_update').val() == 1) {
				_button += '<button type="button" class="btn btn-primary btn-xs" onclick="editType(' + data.id + ');">编辑</button> ';
				count ++;
			}
			if ($('#p_delete').val() == 1) {
				_button += '<button type="button" class="btn btn-danger btn-xs" onclick="deleteType(' + data.id + ');">删除</button>';
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

	function addType(type) {
		//iframe层-父子操作
		var pid = 0;
		if (type == 1) {
			var node = $('.tree').treegrid('getSelectData');
			if (node.length < 1) {
				layer.alert('请先选择父级合同类型', {
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
			offset: [100,($(window).width()/5)],
			title: '合同类型管理->新增合同类型',
			content: ['<%=request.getContextPath()%>/admin/contractType/create?pid=' + pid, 'no']
		});

	}

	function editType(id){
		//iframe层-父子操作
		var index = layer.open({
			type: 2,
			area: ['900px', '400px'],
			offset: [100,($(window).width()/5)],
			title: '合同类型管理->合同类型用户',
			content: ['<%=request.getContextPath()%>/admin/contractType/update?id=' + id,'no']
		});
	}

	function deleteType(id) {
		layer.confirm('是否确定此操作？', {
			btn: ['确定','取消'] //按钮
		}, function() {
			$.ajax({
				type: 'POST',
				url: '<%=request.getContextPath()%>/admin/contractType/delete/',
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
			data:'<%=request.getContextPath()%>/admin/contractType/json?id=0',
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