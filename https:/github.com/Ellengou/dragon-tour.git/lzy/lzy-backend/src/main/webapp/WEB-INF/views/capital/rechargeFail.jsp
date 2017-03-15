<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台管理系统</title>
<%@ include file="/WEB-INF/views/template/bootMainCss.jsp"%>
<!-- bootstrap-datetimepicker -->
<link href="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css" rel="stylesheet">
</head>
<body>
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-body">
					<div class="row">
						<div class="col-lg-12">
							<form id="myForm" action="<%=request.getContextPath()%>/admin/recharge/rechargeExportForFail" method="GET" target="_blank">
								<div class="row">
									<div class="col-xs-4">
						                <div id="dstart" class="input-group date form_datetime col-md-12">
						                	<span class="input-group-addon">开始日期</span>
						                    <input id="startDate" name="startDate" class="form-control" size="16" type="text" value="" readonly>
											<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
											<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
						                </div>
						            </div>
						            <div class="col-xs-4">
						                <div id="dend" class="input-group date form_datetime col-md-12">
						                	<span class="input-group-addon">结束日期</span>
						                    <input id="endDate" name="endDate" class="form-control" size="16" type="text" value="" readonly>
											<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
											<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
						                </div>
						            </div>
									<div class="col-xs-3">
										<button type="button" class="btn btn-primary btn-sm" onclick="search(1)">查询</button>
									</div>
								</div>
								<br />
								<div class="row">
									<div class="col-xs-3">
										<div class="input-group">
											<span class="input-group-addon">充值方式</span>
											<select class="form-control" id="rechargeWay">
												<option value="">全部</option>
                                            </select>
										</div>
									</div>
									<div class="col-xs-3">
										<div class="input-group">
											<span class="input-group-addon">支付方式</span>
											<select class="form-control" id="payWay">
												<option value="">全部</option>
                                            </select>
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>

				<div class="panel-heading">
					<shiro:hasPermission name="recharge:export:fail">
						<button type="button" class="btn btn-primary" onclick="exportNow();">导出当前</button> <button type="button" class="btn btn-primary" onclick="exportAll();">导出全部</button>
					</shiro:hasPermission>
					<font size="4">&nbsp;&nbsp;昨日充值：${yesterdayMonery}&nbsp;&nbsp;充值总额：${allMonery}</font>
				</div>
				<div class="panel-body">
					<div class="table-responsive">
						<table id="myTable"
							class="table table-striped table-bordered table-hover"
							data-url="<%=request.getContextPath()%>/admin/recharge/queryRechargesForFail"
							data-pageSize="10,50,100" data-method="POST">
							<thead>
								<tr>
									<th width="15%" data-field="serialNum">交易号</th>
									<th width="10%" data-field="rechargeWay" data-call="true">充值方式</th>
									<th width="10%" data-field="payWay" data-call="true">支付方式</th>
									<th width="10%" data-field="name">真实姓名</th>
									<th width="10%" data-field="type" data-call="true">用户类型</th>
									<th width="10%" data-field="rechargeMoney">充值金额</th>
									<th width="10%" data-field="actualMoney">实际到账</th>
									<th width="15%" data-field="rechargeTime" data-call="true">充值时间</th>
									<th width="10%" data-field="status" data-call="true">状态</th>
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
    <!-- bootstrap-datetimepicker -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.zh-CN.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/utils.js"></script>
    
	<script type="text/javascript">
	$(function(){
		var rechargeWayList = $.parseJSON('${rechargeWayList}');
		for (var i = 0; i < rechargeWayList.length; i++) {
			$(new Option(rechargeWayList[i].dicDataName,rechargeWayList[i].dicDataValue)).appendTo('#rechargeWay');
		}
		var payWayList = $.parseJSON('${payWayList}');
		for (var i = 0; i < payWayList.length; i++) {
			$(new Option(payWayList[i].dicDataName,payWayList[i].dicDataValue)).appendTo('#payWay');
		}
	});
	$(function () {
    	$('#dstart').datetimepicker({
    		minView: "month", //选择日期后，不会再跳转去选择时分秒 
    		format: "yyyy-mm-dd", //选择日期后，文本框显示的日期格式 
    		language: 'zh-CN', //汉化 
    		autoclose:true, //选择日期后自动关闭 
    		pickerPosition: "bottom-left"
        });
    	$('#dend').datetimepicker({
    		minView: "month", //选择日期后，不会再跳转去选择时分秒 
    		format: "yyyy-mm-dd", //选择日期后，文本框显示的日期格式 
    		language: 'zh-CN', //汉化 
    		autoclose:true, //选择日期后自动关闭 
    		pickerPosition: "bottom-left"
        });
	});
	function tableCallBack(data,id){
    	if(id == 'status'){
    		if(data[id] == null || data[id] == ''){
    			return '';
    		}
    		var rechargeStatusList = ${rechargeStatusList};
    		for (var i = 0; i < rechargeStatusList.length; i++) {
    			if(data[id] == rechargeStatusList[i].dicDataValue){
    				return rechargeStatusList[i].dicDataName;
    				break;
    			}
			}
    		return data[id];
    	}else if(id == 'rechargeWay'){
        	if(data[id] == null || data[id] == ''){
    			return '';
    		}
        	var rechargeWayList = ${rechargeWayList};
    		for (var i = 0; i < rechargeWayList.length; i++) {
    			if(data[id] == rechargeWayList[i].dicDataValue){
    				return rechargeWayList[i].dicDataName;
    				break;
    			}
			}
    		return data[id];
    	}else if(id == 'type'){
    		if(data[id] == null || data[id] == ''){
    			return '';
    		}
    		var scfRoleTypeList = ${scfRoleTypeList};
    		for (var i = 0; i < scfRoleTypeList.length; i++) {
    			if(data[id] == scfRoleTypeList[i].dicDataValue){
    				return scfRoleTypeList[i].dicDataName;
    				break;
    			}
			}
    		return data[id];
    	}else if(id == 'payWay'){
    		if(data[id] == null || data[id] == ''){
    			return '';
    		}
    		var payWayList = ${payWayList};
    		for (var i = 0; i < payWayList.length; i++) {
    			if(data[id] == payWayList[i].dicDataValue){
    				return payWayList[i].dicDataName;
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
	
	function exportNow(){
		$("#myForm").submit();
	}
	
	function exportAll(){
		window.open("<%=request.getContextPath()%>/admin/recharge/rechargeExportForFail");
	}
	</script>
</body>
</html>