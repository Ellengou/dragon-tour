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
		<shiro:hasPermission name="suppCredit:Status">
		    <input id="p_status" style="display: none" value="1">
		</shiro:hasPermission>
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-body">
					<div class="row">
						<div class="col-lg-12">
							<form id="myForm">
								<input type="hidden" class="form-control" id="suppId" value="${id}">
								<div class="row">
									<div class="col-xs-3">
						                <div id="dstart" class="input-group date form_datetime col-md-12">
						                	<span class="input-group-addon">开始日期</span>
						                    <input id="startDate" name="startDate" class="form-control" size="16" type="text" value="" readonly>
											<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
											<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
						                </div>
						            </div>
						            <div class="col-xs-3">
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
							</form>
						</div>
					</div>
				</div>
				<shiro:hasPermission name="suppCredit:limit">
					<div class="panel-heading">
						<button type="button" class="btn btn-primary" onclick="add();">新增额度</button>
					</div>
				</shiro:hasPermission>
				<div class="panel-body">
					<div class="table-responsive">
						<table id="myTable"
							class="table table-striped table-bordered table-hover"
							data-url="<%=request.getContextPath()%>/admin/suppCredit/querySysSuppCredits"
							data-pageSize="10,50,100" data-method="POST">
							<thead>
								<tr>
									<th width="5%" data-field="id">ID</th>
									<th width="15%" data-field="creditLimit">信用额度</th>
									<th width="15%" data-field="userId">添加人</th>
									<th width="15%" data-field="operateTime" data-call="true">添加时间</th>
									<th width="15%" data-field="verifyUserId">审核人</th>
									<th width="15%" data-field="verifyTime" data-call="true">审核时间</th>
									<th width="10%" data-field="verifyStatus" data-call="true">审核状态</th>
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
					<div class="row" align="center">
						<div class="col-xs-12">
							<button type="button" class="btn btn-primary" onclick="closePage();">关闭</button>
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
	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	//关闭窗口并刷新页面
	function closePage() {
		parent.search(parseInt(parent.$('.active').attr('jp-data')));
		parent.layer.close(index);
	}
	
	$(function () {
    	$('#dstart').datetimepicker({
    		minView: "month", //选择日期后，不会再跳转去选择时分秒 
    		format: "yyyy-mm-dd", //选择日期后，文本框显示的日期格式 
    		language: 'zh-CN', //汉化 
    		autoclose:true //选择日期后自动关闭 
        });
    	$('#dend').datetimepicker({
    		minView: "month", //选择日期后，不会再跳转去选择时分秒 
    		format: "yyyy-mm-dd", //选择日期后，文本框显示的日期格式 
    		language: 'zh-CN', //汉化 
    		autoclose:true //选择日期后自动关闭 
        });
	});
	
	function tableCallBack(data,id){
		if(id == 'button'){
    		if($('#p_status').val() == 1){
	    		if(data.verifyStatus == '0'){
	    			return '<button type="button" class="btn btn-warning btn-xs" onclick="checkCreditLimit(\'' + data.id + '\');">审核</button>';
	    		}else{
	    			return '';
	    		}
    		}else{
    			return '';
    		}
    		
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
	
	function add(){
		layer.open({
    	    type: 2,
    	    area: ['500px', '300px'],
    	    offset: [100,(($(window).width()-500)/2)],
    	    title: '新增供应商信用额度',
    	    content: ['<%=request.getContextPath()%>/admin/suppCredit/suppCreditLimitPage?id=${id}','no']
    	});
	}
    
    function checkCreditLimit(id){
    	layer.open({
    	    type: 2,
    	    area: ['500px', '400px'],
    	    offset: [100,(($(window).width()-500)/2)],
    	    title: '审核供应商信用额度',
    	    content: ['<%=request.getContextPath()%>/admin/suppCredit/checkSuppCreditLimitPage?id=' + id,'no']
    	});
    }
	</script>
</body>
</html>