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
											<span class="input-group-addon">银行卡号</span>
											<input type="text" class="form-control" id="bankNo" name="bankNo">
										</div>
									</div>
									<div class="col-xs-2">
										<div class="input-group">
											<span class="input-group-addon">姓名</span>
											<input type="text" class="form-control" id="name" name="name">
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
					<a class="btn btn-primary" href="<%=request.getContextPath()%>/template/员工银行卡.xls" target="_self">员工银行卡模板下载</a> 
					<shiro:hasPermission name="bankCard:emp:upload">
						<button type="button" class="btn btn-primary" onclick="uopload();">上传员工银行卡</button>
					</shiro:hasPermission>
				</div>
				<div class="panel-body">
					<div class="table-responsive">
						<table id="myTable"
							class="table table-striped table-bordered table-hover"
							data-url="<%=request.getContextPath()%>/admin/bankCard/queryEmpBankCards"
							data-pageSize="10,50,100" data-method="POST">
							<thead>
								<tr>
									<th width="20px" data-field="id">ID</th>
									<th width="50px" data-field="compCoreName">核心企业</th>
									<th width="50px" data-field="compName">公司名称</th>
									<th width="50px" data-field="empno">员工编号</th>
									<th width="50px" data-field="name">姓名</th>
									<th width="50px" data-field="bankName">银行名称</th>
									<th width="50px" data-field="openName">开户行</th>
									<th width="50px" data-field="bankNo">银行卡号</th>
									<th width="50px" data-field="status" data-call="true">状态</th>
									<th width="50px" data-field="signStatus" data-call="true">签约状态</th>
									<th width="50px" data-field="activateStatus" data-call="true">激活状态</th>
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
    		var bankCardStatusList = ${bankCardStatusList};
    		for (var i = 0; i < bankCardStatusList.length; i++) {
    			if(data[id] == bankCardStatusList[i].dicDataValue){
    				return bankCardStatusList[i].dicDataName;
    				break;
    			}
			}
    		return data[id];
    	}if(id == 'signStatus'){
    		if(data.payClass == 'AbcPay'){
    			if(data.signStatus == '0'){
    				return '';
    			}
    			var signStatusList = ${signStatusList};
        		for (var i = 0; i < signStatusList.length; i++) {
        			if(data[id] == signStatusList[i].dicDataValue){
        				return signStatusList[i].dicDataName;
        				break;
        			}
    			}
        		return '';
    		}else{
    			return '';
    		}	
    	}else if(id == 'activateStatus'){
    		if(data.activateStatus == '' || data.activateStatus == null){
    			return '';
    		}else{
    			var bankCardActivateStatusList = ${bankCardActivateStatusList};
        		for (var i = 0; i < bankCardActivateStatusList.length; i++) {
        			if(data[id] == bankCardActivateStatusList[i].dicDataValue){
        				return bankCardActivateStatusList[i].dicDataName;
        				break;
        			}
    			}
        		return '';
    		}
    	}else{
    		if(data[id] == null || data[id] == ''){
    			return '';
    		}else{
    			return data[id];
    		}
    	}
	}
	
	function uopload(){
		layer.open({
    	    type: 2,
    	    area: ['400px', '300px'],
    	    offset: [100,(($(window).width()-400)/2)],
    	    title: '上传员工银行卡页面',
    	    content: ['<%=request.getContextPath()%>/admin/bankCard/uploadEmpPage','no']
    	});
	}
	</script>
</body>
</html>