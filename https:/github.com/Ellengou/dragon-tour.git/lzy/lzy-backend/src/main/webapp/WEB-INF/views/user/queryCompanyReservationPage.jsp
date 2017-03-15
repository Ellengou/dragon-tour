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
									<div class="col-xs-3">
										<div class="input-group">
											<span class="input-group-addon">核心企业</span>
											<input type="text" class="form-control" id = "compName" name = "compName">
										</div>
									</div>
									<div class="col-xs-3">
										<div class="input-group">
											<span class="input-group-addon">联系人</span>
											<input type="text" class="form-control" id="contactName" name="contactName">
										</div>
									</div>
									<div class="col-xs-3">
										<div class="input-group date form_time">
											<span class="input-group-addon">创建时间</span>
											<input class="form-control " type="text" id="minCreateTime"  name="minCreateTime"  readonly>
							                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
							                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
										</div>
									</div>
									
									
									<div class="col-xs-3">
										<div class="input-group date form_time">
											<input class="form-control" type="text" id="maxCreateTime" name="maxCreateTime"  readonly>
							                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
							                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
										</div>
									</div>
								</div>
								<br />
								<div class="row">
									<div class="col-xs-3">
										<div class="input-group" id = "div_loanStatus">
											<span class="input-group-addon">状态</span>
											<select  class="form-control" name="verifyStatus" id="verifyStatus">
											</select>
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
							data-url="<%=request.getContextPath()%>/admin/company/reservation/queryCompanyReservations"
							data-pageSize="10,50,100" data-method="get">
							<thead>
								<tr>
									<th data-field="comp_name">核心企业</th>
									<th data-field="contact_name">联系人名称</th>
									<th data-field="contact_phone">联系人电话</th>
									<th data-field="create_time">提交时间</th>
									<th data-field="verify_status_name">审核状态</th>
									<th data-field="verify_user_id">审核人</th>
									<th data-field="verify_time">审核时间</th>
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
    <script src="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
	
	<script type="text/javascript">
	$("#verifyStatus").showList('option',{infoList:'${verifyStatusList}'})
	$('.form_time').datetimepicker({
        format: 'yyyy-mm-dd hh:ii:ss',
        language:'zh-CN',
        weekStart: 1,
        todayHighlight:true,
        autoclose:true,
        pickerPosition: "bottom-left"
    });
	function tableCallBack(data,id){
        if(id == 'button'){
        	var str = '';
        	if(data.verify_status == '0')
        	str += '<button type="button" class="btn btn-primary btn-xs" onclick="query(\'' + data.id + '\');">审核</button>';
            return str;
        }else{
            if(data[id] == null || data[id] == ''){
                return '';
            }else{
                return data[id];
            }
        }
    }
	function query(id){
		var index = layer.open({
    	    type: 2,
    	    offset: [50,(($(window).width()-600)/2)],
    	    title: false,
    	    content: ['<%=request.getContextPath()%>/admin/company/reservation/verify?id=' + id,'yes']
    	});
		layer.full(index);
	}
	$(document).ready(function(){
		
	});
	</script>
</body>
</html>