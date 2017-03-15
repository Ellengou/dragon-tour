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
							<form id="myForm">
								<div class="row">
									<div class="col-xs-3">
										<div class="input-group">
											<span class="input-group-addon">员工编号</span>
											<input type="text" class="form-control" id="empno" name="empno">
										</div>
									</div>
									<div class="col-xs-3">
										<div class="input-group">
											<span class="input-group-addon">姓名</span>
											<input type="text" class="form-control" id="name" name="name">
										</div>
									</div>
									<div class="col-xs-3">
										<div class="input-group">
											<span class="input-group-addon">公司名称</span>
											<input type="text" class="form-control" id="compName" name="compName">
										</div>
									</div>
									<div class="col-xs-3">
										<button type="button" class="btn btn-primary btn-sm" onclick="search(1)">查询</button>
									</div>
								</div>
								<br>
								<div class="row">
									<div class="col-xs-3">
						                <div id="dstart" class="input-group date form_datetime col-md-12">
						                	<span class="input-group-addon">工资开始年月</span>
						                    <input id="startDate" name="startDate" class="form-control" size="16" type="text" value="" readonly>
											<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
											<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
						                </div>
						            </div>
						            <div class="col-xs-3">
						                <div id="dend" class="input-group date form_datetime col-md-12">
						                	<span class="input-group-addon">工资结束年月</span>
						                    <input id="endDate" name="endDate" class="form-control" size="16" type="text" value="" readonly>
											<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
											<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
						                </div>
						            </div>
						            <div class="col-xs-3">
						                <div id="dstartTime" class="input-group date form_datetime col-md-12">
						                	<span class="input-group-addon">导入开始时间</span>
						                    <input id="startTime" name="startTime" class="form-control" size="16" type="text" value="" readonly>
											<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
											<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
						                </div>
						            </div>
						            <div class="col-xs-3">
						                <div id="dendTime" class="input-group date form_datetime col-md-12">
						                	<span class="input-group-addon">导入结束时间</span>
						                    <input id="endTime" name="endTime" class="form-control" size="16" type="text" value="" readonly>
											<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
											<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
						                </div>
						            </div>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="panel-heading">
					<font size="4">&nbsp;&nbsp;实际工资总和：<font id="totalSalary">0</font></font>
				</div>
				<div class="panel-body">
					<div class="table-responsive">
						<table id="myTable"
							class="table table-striped table-bordered table-hover"
							data-url="<%=request.getContextPath()%>/admin/empSalary/queryFailEmpSalarys"
							data-pageSize="30,50,100" data-method="POST">
							<thead>
								<tr>
									<th width="5%" data-type="checkbox" data-field="id"></th>
									<th width="5%" data-field="type" data-call="true">类型</th>
									<th width="10%" data-field="empno">员工编号</th>
									<th width="10%" data-field="name">姓名</th>
									<th width="25%" data-field="compName">公司名称</th>
									<th width="5%" data-field="month">工资年月</th>
									<th width="7%" data-field="shouldSalary">应发工资</th>
									<th width="8%" data-field="actualSalary">实际工资</th>
									<th width="10%" data-field="status" data-call="true">发放状态</th>
									<th width="15%" data-field="operateTime">上传时间</th>
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
    <!-- bootstrap-datetimepicker -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.zh-CN.js"></script>
    
	<script type="text/javascript">
	$(function(){
		$('#dstart').datetimepicker({
			startView: 3, //这里就设置了默认视图为年视图
            minView: 3, //设置最小视图为年视图
    		format: "yyyy-mm", //选择日期后，文本框显示的日期格式 
    		language: 'zh-CN', //汉化 
    		autoclose:true //选择日期后自动关闭 
        });
    	$('#dend').datetimepicker({
    		startView: 3, //这里就设置了默认视图为年视图
            minView: 3, //设置最小视图为年视图
    		format: "yyyy-mm", //选择日期后，文本框显示的日期格式 
    		language: 'zh-CN', //汉化 
    		autoclose:true //选择日期后自动关闭 
        });
    	$('#dstartTime').datetimepicker({
    		minView: "month", //选择日期后，不会再跳转去选择时分秒 
    		format: "yyyy-mm-dd", //选择日期后，文本框显示的日期格式 
    		language: 'zh-CN', //汉化 
    		autoclose:true //选择日期后自动关闭 
        });
    	$('#dendTime').datetimepicker({
    		minView: "month", //选择日期后，不会再跳转去选择时分秒 
    		format: "yyyy-mm-dd", //选择日期后，文本框显示的日期格式 
    		language: 'zh-CN', //汉化 
    		autoclose:true //选择日期后自动关闭 
        });
	});
	
	function tableCallBack(data,id){
    	if(id == 'status'){
    		var salaryGrantStatusList = ${salaryGrantStatusList};
    		for (var i = 0; i < salaryGrantStatusList.length; i++) {
    			if(data[id] == salaryGrantStatusList[i].dicDataValue){
    				return salaryGrantStatusList[i].dicDataName;
    				break;
    			}
			}
    		return data[id];
    	}else if(id == 'type'){
    		var salaryTypeList = ${salaryTypeList};
    		for (var i = 0; i < salaryTypeList.length; i++) {
    			if(data[id] == salaryTypeList[i].dicDataValue){
    				return salaryTypeList[i].dicDataName;
    				break;
    			}
			}
    		return data[id];
    	}else if(id == 'verifyStatus'){
    		var verifyStatusList = ${verifyStatusList};
    		for (var i = 0; i < verifyStatusList.length; i++) {
    			if(data[id] == verifyStatusList[i].dicDataValue){
    				return verifyStatusList[i].dicDataName;
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
	
	function selectValue(){
		var totalSalary = 0;
        $("#tbodyId").find("input").each(function() {
            if($(this).attr('type') == 'checkbox' && $(this).is(':checked')){
            	totalSalary = (totalSalary*1000 + $.parseJSON($(this).attr('selectValue')).actualSalary*1000)/1000;
            }
        });
        $('#totalSalary').html(totalSalary);
	}
	</script>
</body>
</html>