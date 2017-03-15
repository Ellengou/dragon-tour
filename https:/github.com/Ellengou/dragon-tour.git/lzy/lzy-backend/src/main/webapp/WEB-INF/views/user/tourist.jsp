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
<shiro:hasPermission name="user:tourist:status">
	<input id="p_status" style="display: none" value="1">
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
										<span class="input-group-addon">昵称</span>
										<input type="text" class="form-control" id="nickName">
									</div>
								</div>
								<div class="col-xs-2">
									<div class="input-group">
										<span class="input-group-addon">邮箱</span>
										<input type="text" class="form-control" id="email">
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

			<div class="panel-body">
				<div class="table-responsive">
					<table id="myTable"
						   class="table table-striped table-bordered table-hover"
						   data-url="<%=request.getContextPath()%>/admin/userFront/queryTourists"
						   data-pageSize="10,50,100" data-method="post">
						<thead>
						<tr>
							<th width="20px" data-field="id">ID</th>
							<th width="50px" data-field="nickName">昵称</th>
							<th width="50px" data-field="phone">手机</th>
							<th width="50px" data-field="email">邮箱</th>
							<th width="50px" data-field="operateTime" data-call="true">注册时间</th>
							<th width="50px" data-field="status" data-call="true">状态</th>
							<th width="50px" data-field="button" data-call="true">操作</th>
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
<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/utils.js"></script>

<script type="text/javascript">
	function tableCallBack(data,id){
		if(id == 'status'){
			var userStatusList = ${userStatusList};
			for (var i = 0; i < userStatusList.length; i++) {
				if(data[id] == userStatusList[i].dicDataValue){
					return userStatusList[i].dicDataName;
					break;
				}
			}
			return data[id];
		}else if(id == 'button'){
			var str = '<button type="button" class="btn btn-primary btn-xs" onclick="info(\'' + data.id + '\');">详情</button> ';
			if($('#p_status').val() == 1){
				str = str + '<button type="button" class="btn btn-warning btn-xs" onclick="editStatus(\'' + data.id + '\',\'' + data.status + '\',\'1\');">修改状态</button>';
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

	function info(id){
		layer.open({
			type: 2,
			area: ['900px', '700px'],
			offset: [100,(($(window).width()-900)/2)],
			title: '游客信息',
			content: ['<%=request.getContextPath()%>/admin/userFront/touristInfoPage?id=' + id,'yes']
		});
	}

	function editStatus(id,status,type){
		layer.open({
			type: 2,
			area: ['500px', '300px'],
			offset: [100,(($(window).width()-500)/2)],
			title: '修改游客状态',
			content: ['<%=request.getContextPath()%>/admin/userFront/editUserFrontStatusPage?id=' + id + '&status=' + status + '&type=' + type,'no']
		});
	}
</script>
</body>
</html>