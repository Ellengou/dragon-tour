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
									<div class="col-xs-2">
										<button type="button" class="btn btn-primary btn-sm" onclick="add()">新增</button>
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
							data-url="<%=request.getContextPath()%>/admin/debt/product/queryConnInfos"
							data-pageSize="10,50,100" data-method="get">
							<thead>
								<tr>
									<th data-field="money_source_id">资金来源</th>
									<th data-field="comp_core_id">核心公司</th>
									<th data-field="borrow_product_name">借款产品</th>
									<th data-field="dead_line">贷款期限(天)</th>
									<th data-field="min_money">最小额度(元)</th>
									<th data-field="max_money">最大额度(元)</th>
									<th data-field="invest_rate">贷款年利率(%)</th>
									<th data-field="loan_type">还款方式</th>
									<th data-field="repay_date">还款日</th>
									<th data-field="status">状态</th>
									<th data-field="user_id">创建人</th>
									<th data-field="create_time">创建时间</th>
									<th data-field="update_user_id">更新人</th>
									<th data-field="update_time">更新时间</th>
									<th data-field="button" data-call="true">操作</th>
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
	
	function tableCallBack(data,id){
        if(id == 'button'){
            return '<button type="button" class="btn btn-primary btn-xs" onclick="query(\'' + data.id + '\');">修改</button>';;
        }else{
            if(data[id] == null || data[id] == ''){
                return '';
            }else{
                return data[id];
            }
        }
    }
	
	function query(id){
		layer.open({
    	    type: 2,
    	    area: ['600px', '600px'],
    	    offset: [20,(($(window).width()-600)/2)],
    	    title: '修改',
    	    content: '<%=request.getContextPath()%>/admin/debt/product/edit?id=' + id
    	});
    }
	
	function add(){
		layer.open({
    	    type: 2,
    	    area: ['600px', '600px'],
    	    offset: [20,(($(window).width()-600)/2)],
    	    title: '新增',
    	    content: '<%=request.getContextPath()%>/admin/debt/product/add'
    	});
	}
	
	$(document).ready(function(){
		 
	});
	</script>
</body>
</html>