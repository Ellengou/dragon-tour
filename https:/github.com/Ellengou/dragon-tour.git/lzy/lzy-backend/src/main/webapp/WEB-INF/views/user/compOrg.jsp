<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>后台管理系统</title>
	<%@ include file="/WEB-INF/views/template/bootMainCss.jsp"%>
</head>
<body>
<shiro:hasPermission name="compOrg:edit">
	<input id="p_edit" style="display: none" value="1">
</shiro:hasPermission>
<shiro:hasPermission name="compOrg:delete">
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
										<span class="input-group-addon">部门名称</span>
										<input type="text" class="form-control" id="name">
									</div>
								</div>
								<div class="col-xs-3">
									<button type="button" class="btn btn-primary btn-sm" onclick="search(1)">查询</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="panel-heading">
				<a class="btn btn-primary" href="<%=request.getContextPath()%>/template/部门表.xls" target="_self">部门模板下载</a> 
				<shiro:hasPermission name="compOrg:add">
					<button type="button" class="btn btn-primary" onclick="add();">新增</button>
				</shiro:hasPermission>
				<shiro:hasPermission name="compOrg:import">
					<button type="button" class="btn btn-primary" onclick="importExcel();">导入</button>
				</shiro:hasPermission>
			</div>
			<div class="panel-body">
				<div class="table-responsive">
					<table id="myTable"
						   class="table table-striped table-bordered table-hover"
						   data-url="<%=request.getContextPath()%>/admin/compOrg/queryCompOrgs"
						   data-pageSize="10,50,100" data-method="POST">
						<thead>
						<tr>
							<th width="10%" data-field="id">ID</th>
							<th width="20%" data-field="pidName">所属公司</th>
							<th width="20%" data-field="name">部门名称</th>
							<!-- <th width="10%" data-field="principal">负责人</th> -->
							<th width="20%" data-field="tel">部门电话</th>
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

<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/jqPaginator.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/myPage.js"></script>

<script type="text/javascript">

	function tableCallBack(data,id){
		if(id == 'button'){
			var str = '';
			if($('#p_edit').val() == 1){
				str = str + '<button type="button" class="btn btn-primary btn-xs" onclick="edit(\'' + data.id + '\');">编辑</button> ';
			}
			if($('#p_delete').val() == 1){
				str = str + '<button type="button" class="btn btn-danger btn-xs" onclick="deleteCompOrg(\'' + data.id + '\');">删除</button>';
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
			area: ['900px', '300px'],
			offset: [100,(($(window).width()-900)/2)],
			title: '添加部门',
			content: ['<%=request.getContextPath()%>/admin/compOrg/addCompOrgPage','no']
		});
	}

	function edit(id){
		layer.open({
			type: 2,
			area: ['900px', '300px'],
			offset: [100,(($(window).width()-900)/2)],
			title: '修改部门',
			content: ['<%=request.getContextPath()%>/admin/compOrg/editCompOrgPage?id=' + id,'no']
		});
	}

	function deleteCompOrg(id){
		//询问框
		layer.confirm('是否确定此操作？', {
			btn: ['确定','取消'] //按钮
		}, function(){
			$.ajax({
				url: '<%=request.getContextPath()%>/admin/compOrg/deleteCompOrg',
				dataType: 'json',
				type: 'POST',
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


    function importExcel() {
        layer.open({
            type: 2,
            area: ['500px', '300px'],
            offset: [100,(($(window).width()-500)/2)],
            title: '导入部门',
            content: ['<%=request.getContextPath()%>/admin/userFront/uploadFilePage?type=5','no']
        });
    }
</script>
</body>
</html>