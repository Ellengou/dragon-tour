<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台管理系统</title>
<%@ include file="/WEB-INF/views/template/bootMainCss.jsp"%>
<link href="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css" rel="stylesheet">
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
									<input type="text" name="compCoreId" id = "compCoreId" value="${compCoreId}" hidden="true">
									<div class="col-xs-2">
										<button type="button" class="btn btn-primary btn-sm" onclick="add('${compCoreId}')">设置</button>
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
							data-url="<%=request.getContextPath()%>/moneysource/queryMoneySource"
							data-pageSize="10,50,100" data-method="get">
							<thead>
								<tr>
									<th data-field="money_source_id">资金来源</th>
									<th data-field="comp_core_id">核心公司</th>
									<th data-field="status">状态</th>
									<th data-field="create_user_id">关联人</th>
									<th data-field="create_time">关联时间</th>
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
	<script src="<%=request.getContextPath()%>/bootstrap/js/util.js" type="text/javascript"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/jqPaginator.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/myPage.js"></script>
	
	<script type="text/javascript">
	//设置核心企业列表
	
	function add(){
		layer.open({
    	    type: 2,
    	    area: ['600px', '450px'],
    	    offset: [100,(($(window).width()-600)/2)],
    	    title: false,
    	    content: '<%=request.getContextPath()%>/moneysource/add?compCoreId=${compCoreId}'
    	});
	}
	
	$(document).ready(function(){
		 
	});
	</script>
</body>
</html>