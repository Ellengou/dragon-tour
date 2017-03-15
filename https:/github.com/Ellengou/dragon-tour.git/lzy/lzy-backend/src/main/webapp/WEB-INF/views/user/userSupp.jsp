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
	<shiro:hasPermission name="suppCredit:query">
	    <input id="p_credit" style="display: none" value="1">
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
											<span class="input-group-addon">供应商名称</span>
											<input type="text" class="form-control" id="nickName">
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
							data-url="<%=request.getContextPath()%>/admin/userSupp/queryUserSuppsCreditLimit"
							data-pageSize="10,50,100" data-method="POST">
							<thead>
								<tr>
									<th width="10%" data-field="id">ID</th>
									<th width="15%" data-field="companyName">公司</th>
									<th width="15%" data-field="nickName">供应商名称</th>
							
									<th width="15%" data-field="creditLimit">信用额度</th>
									<th width="15%" data-field="freezonCredit">冻结额度</th>
									<th width="15%" data-field="balanceCredit">可用额度</th>
									<th width="15%" data-field="button" data-call="true">操作</th>
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
    		if($('#p_credit').val() == 1){
    			if(data.enabled == '0'){
    				return '<button type="button" class="btn btn-warning btn-xs" onclick="suppCredit(\'' + data.id + '\');">信用额度审核列表</button>';
    			}else{
    				return '';
    			}
    		}else{
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

    function suppCredit(id){
    	var index = layer.open({
    	    type: 2,
    	    area: ['900px', '500px'],
    	    offset: [100,(($(window).width()-900)/2)],
    	    title: '供应商额度审核页面',
    	    content: ['<%=request.getContextPath()%>/admin/suppCredit/suppCreditPage?id=' + id,'no']
    	});
    	layer.full(index);
    }
	</script>
</body>
</html>