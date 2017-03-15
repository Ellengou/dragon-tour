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
											<input type="text" class="form-control" id="nickName">
										</div>
									</div>
									<div class="col-xs-2">
										<div class="input-group">
											<span class="input-group-addon">手机</span>
											<input type="text" class="form-control" id="phone">
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
				<shiro:hasPermission name="user:dealer:export">
					<div class="panel-heading">
						<button type="button" class="btn btn-primary" onclick="exportAll();">导出</button>
					</div>
				</shiro:hasPermission>
				<div class="panel-body">
					<div class="table-responsive">
						<table id="myTable"
							class="table table-striped table-bordered table-hover"
							data-url="<%=request.getContextPath()%>/admin/userFront/queryDealers"
							data-pageSize="10,50,100" data-method="POST">
							<thead>
								<tr>
									<th  data-field="id">ID</th>
									<th  data-field="compCoreName">核心企业</th>
									<th  data-field="compName">所属公司</th>
									<th  data-field="suppName">名称</th>
									<th  data-field="phone">手机</th>
									<th  data-field="agentPerson">代理人姓名</th>
									<th  data-field="agentPhone">代理人手机</th>
									<th  data-field="merchantNumber">NC客商编号</th>
									<th  data-field="operateTime" data-call="true">注册时间</th>
									<th  data-field="verifyStatus" data-call="true">审核状态</th>
									<th  data-field="status" data-call="true">状态</th>
									<th  data-field="enabled" data-call="true">关联状态</th>
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
		if(id == 'verifyStatus'){
			var verifyStatusList = ${verifyStatusList};
    		for (var i = 0; i < verifyStatusList.length; i++) {
    			if(data[id] == verifyStatusList[i].dicDataValue){
    				return verifyStatusList[i].dicDataName;
    				break;
    			}
			}
    		return data[id];
    	}else if(id == 'status'){
    		var userStatusList = ${userStatusList};
			for (var i = 0; i < userStatusList.length; i++) {
				if(data[id] == userStatusList[i].dicDataValue){
    				return userStatusList[i].dicDataName;
    				break;
    			}
			}
    		return data[id];
    	}else if(id == 'enabled'){
    		var relationStatusList = ${relationStatusList};
			for (var i = 0; i < relationStatusList.length; i++) {
				if(data[id] == relationStatusList[i].dicDataValue){
    				return relationStatusList[i].dicDataName;
    				break;
    			}
			}
    		return data[id];
    	}else{
    		if(data[id] == null || data[id] == ''){
    			return '';
    		}else{
    			return data[id];
    		}
    	}
	}
	
	function exportAll(){
		window.open("<%=request.getContextPath()%>/admin/userFront/dealerExport");
	}
	</script>
</body>
</html>