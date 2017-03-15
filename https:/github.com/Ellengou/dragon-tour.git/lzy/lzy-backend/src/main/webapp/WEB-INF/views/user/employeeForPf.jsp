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
	<shiro:hasPermission name="user:employee:status">
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
											<span class="input-group-addon">真实姓名</span>
											<input type="text" class="form-control" id="name">
										</div>
									</div>
									<div class="col-xs-2">
										<div class="input-group">
											<span class="input-group-addon">员工编号</span>
											<input type="text" class="form-control" id="empno">
										</div>
									</div>
									<div class="col-xs-2">
										<div class="input-group">
											<span class="input-group-addon">手机</span>
											<input type="text" class="form-control" id="phone">
										</div>
									</div>
									<div class="col-xs-2">
										<div class="input-group">
											<span class="input-group-addon">身份证号</span>
											<input type="text" class="form-control" id="idCard">
										</div>
									</div>
									<div class="col-xs-2">
										<div class="input-group">
											<span class="input-group-addon">公司名称</span>
											<input type="text" class="form-control" id="compName">
										</div>
									</div>
									<div class="col-xs-2">
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
							data-url="<%=request.getContextPath()%>/admin/userFront/queryEmployees"
							data-pageSize="10,50,100" data-method="POST">
							<thead>
							<tr>
								<%--<th width="5%" data-type="checkbox" data-field="id"></th>--%>
								<th width="5%" data-field="id">ID</th>
								<th width="15%" data-field="compName">公司</th>
								<th width="10%" data-field="empno">员工编号</th>
								<th width="10%" data-field="name">真实姓名</th>
								<th width="10%" data-field="phone">手机</th>
								<th width="10%" data-field="email">邮箱</th>
								<th width="15%" data-field="operateTime" data-call="true">注册时间</th>
								<th width="5%" data-field="status" data-call="true">状态</th>
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
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/utils.js"></script>
    
	<script type="text/javascript">
	function tableCallBack(data,id){
    	if(id == 'status'){
    		if(data[id] == '0'){
    			return '正常';
    		}else if(data[id] == '1'){
    			return '登录锁定';
    		}else if(data[id] == '2'){
    			return '系统锁定';
    		}else{
    			return data[id];
    		}
    	}else if(id == 'button'){
        	var str = "";
        	if($('#p_status').val() == 1){
        		str += '<button type="button" class="btn btn-warning btn-xs" onclick="editStatus(\'' + data.id + '\',\'' + data.status + '\',\'' + data.type + '\');">修改状态</button>';
        	}
        	str += '&nbsp<button type="button" class="btn btn-primary btn-xs" onclick="view(\'' + data.id + '\');">详情</button>';
        	return str;
    	}else{
    		if(data[id] == null || data[id] == ''){
    			return '';
    		}else{
    			return data[id];
    		}
    	}
	}
    
    function editStatus(id,status,type){
    	layer.open({
    	    type: 2,
    	    area: ['500px', '300px'],
    	    offset: [100,(($(window).width()-500)/2)],
    	    title: '修改员工状态',
    	    content: ['<%=request.getContextPath()%>/admin/userFront/editUserFrontStatusPage?id=' + id + '&status=' + status + '&type=' + type,'no']
    	});
    }
    function view(id){
        var index = layer.open({
            type: 2,
            offset: [50,(($(window).width()-900)/2)],
            title: false,
            content: '<%=request.getContextPath()%>/admin/userFront/viewEmployeePage?id=' + id
        });
        layer.full(index);
    }
	</script>
</body>
</html>