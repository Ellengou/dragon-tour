<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
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
								<div class="col-xs-6">
									<div class="input-group" >
										<span class="input-group-addon">核心企业/第三方机构</span>
										<select name="companyId" id = "companyId" class="form-control"></select>
									</div>
								</div>
								<div class="row">
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
							data-url="<%=request.getContextPath()%>/servicerate/queryServiceRate"
							data-pageSize="10,50,100" data-method="get">
							<thead>
								<tr>
									<th data-field="company_name">核心企业/第三方机构</th>
									<th data-field="interest_rate" data-call="true">月利率(‰)</th>
									<th data-field="status" data-call="true">状态</th>
									<th data-field="create_time">创建时间</th>
									<th data-field="update_time">更新时间</th>
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
	$("#companyId").showList('option', {
		infoList : '${list}',
		column_name:'comp_name',
		column_value:'id'
	});
	function tableCallBack(data,id){
		if(id == 'interest_rate'){
			var str = '';
			if(data.status == '0'){
				str = '<span style="color: red;font-weight:bold;">'+data[id]+'</span>';
			}else{
				str = data[id];
			}
			return str;
		}else if(id == 'status'){
        	if(data[id] == '1'){
        		return '停用';
        	}else if(data[id] == '0'){
        		return '<span style="color: red;">使用中</span>';
        	}
        }else{
            if(data[id] == null || data[id] == ''){
                return '';
            }else{
                return data[id];
            }
        }
    }
	
	</script>
</body>
</html>