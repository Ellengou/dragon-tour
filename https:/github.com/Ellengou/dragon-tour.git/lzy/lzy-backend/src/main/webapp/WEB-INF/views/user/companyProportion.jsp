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
	<shiro:hasPermission name="companyProportion:edit">
	    <input id="p_edit" style="display: none" value="1">
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
											<span class="input-group-addon">企业名称</span>
											<input type="text" class="form-control" id="compName">
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
							data-url="<%=request.getContextPath()%>/admin/company/queryCompanyProportions"
							data-pageSize="10,50,100" data-method="POST">
							<thead>
								<tr>
									<th width="10%" data-field="compCordId">核心企业ID</th>
									<th width="40%" data-field="compName">核心企业名称</th>
									<th width="40%" data-field="proportion" data-call="true">核心企业额度比例</th>
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
    			if(data.ischeck == '1'){
    				str = str + '<button type="button" class="btn btn-primary btn-xs" onclick="edit(\'' + data.compCordId + '\');">编辑</button> ';
    			}
    		}
    		return str;
    	}else if(id == 'proportion'){
    		if(data.proportion == null || data.proportion == ''){
    			return "暂无配置";
    		}else{
    			return data.proportion;	
    		}
    	}else{
    		if(data[id] == null || data[id] == ''){
    			return '';
    		}else{
    			return data[id];
    		}
    	}
	}
	
    function edit(compCordId){
    	layer.open({
    	    type: 2,
    	    area: ['400px', '300px'],
    	    offset: [100,(($(window).width()-400)/2)],
    	    title: '修改核心企业额度比例',
    	    content: ['<%=request.getContextPath()%>/admin/company/editCompanyProportionPage?compCordId=' + compCordId,'yes']
    	});
    }
	</script>
</body>
</html>