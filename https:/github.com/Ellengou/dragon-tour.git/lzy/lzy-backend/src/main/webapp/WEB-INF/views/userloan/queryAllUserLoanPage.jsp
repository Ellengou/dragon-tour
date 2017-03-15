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
										<div class="input-group" >
											<span class="input-group-addon">核心企业</span>
											<select name="pledgeCompCoreId" id = "pledgeCompCoreId" class="form-control"></select>
										</div>
									</div>
									<div class="col-xs-3">
										<div class="input-group">
											<span class="input-group-addon">供应商</span>
											<input type="text" class="form-control" id="frontUserName" name="frontUserName">
										</div>
									</div>
									<div class="col-xs-3">
										<div class="input-group date form_time">
											<span class="input-group-addon">申请时间</span>
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
										<div class="input-group">
											<span class="input-group-addon">质押单位</span>
											<input type="text" class="form-control" id="pledgeCompanyName" name ="pledgeCompanyName">
										</div>
									</div>
									<div class="col-xs-3">
										<div class="input-group" id = "div_zjlx">
											<span class="input-group-addon">资金类型</span>
											<select name="moneySource" id = "moneySource" class="form-control"></select>
										</div>
									</div>
									<div class="col-xs-3">
										<div class="input-group" id = "div_zjlx">
											<span class="input-group-addon">状态</span>
											<select name="loanStatus" id = "loanStatus" class="form-control"></select>
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
							data-url="<%=request.getContextPath()%>/admin/userloan/queryAllUserLoan"
							data-pageSize="10,50,100" data-method="get">
							<thead>
								<tr>
									<th data-field="pledgeCompCoreName">核心企业</th>
									<th data-field="frontUserName">供应商名称</th>
									<th data-field="loanMoney">额度(元)</th>
									<th data-field="deadLine">期限(天)</th>
									<th data-field="investRate">年利率(%)</th>
									<th data-field="loanerName">申请人</th>
									<th data-field="operatorPhone">经办人手机</th>
									<th data-field="loanType">还款方式</th>
									<th data-field="pledgeCompanyName">质押单位</th>
									<th data-field="moneySourceName">资金来源</th>
									<th data-field="createTime">申请时间</th>
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
	
	<%@ include file="/WEB-INF/views/userloan/template/template_script.jsp"%>
	<script type="text/javascript">
	$("#loanStatus").showList('option',{infoList:'${loanStatus}'});
	function tableCallBack(data,id){
        if(id == 'button'){
            return '<button type="button" class="btn btn-primary btn-xs" onclick="queryUserLoan(\'' + data.id + '\');">查看</button>';;
        }else{
            if(data[id] == null || data[id] == ''){
                return '';
            }else{
                return data[id];
            }
        }
    }
	function queryUserLoan(id){
		var index = layer.open({
	        type: 2,
	        offset: [100,(($(window).width()-900)/2)],
	        title: false,
	        content: '<%=request.getContextPath()%>/admin/userloan/view?id=' + id
	    });
		layer.full(index);
	}
	$(document).ready(function(){
		$("#pledgeCompCoreId").change(function(){
			$("#moneySource").empty();
			var compCoreId = $(this).val();
			$.ajax({
				url : '<%=request.getContextPath()%>/admin/userloan/getCompCoreMoneySource?compCoreId='+compCoreId,
				type : 'GET',
				dataType: 'json',
				success : function(data){
					if(data.status == 'ok'){
						$("#moneySource").showList('option',{infoList:data.code})
					}else{
						alert(data.msg)
					}
				}
			})
		});
	});
	</script>
</body>
</html>