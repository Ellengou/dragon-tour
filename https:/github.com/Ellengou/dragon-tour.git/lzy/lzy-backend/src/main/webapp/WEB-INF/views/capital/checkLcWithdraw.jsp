<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>理财提现待审核</title>
<%@ include file="/WEB-INF/views/template/bootMainCss.jsp"%>
<!-- bootstrap-datetimepicker -->
<link href="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css" rel="stylesheet">
</head>
<body>
	<shiro:hasPermission name="withdraw:lcStatus">
	    <input id="p_status" style="display: none" value="1">
	</shiro:hasPermission>
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-body">
					<div class="row">
						<div class="col-lg-12">
							<form id="myForm" action="<%=request.getContextPath()%>/admin/withdraw/lcWithdrawWaitExport" method="GET" target="_blank">
								<div class="row">
									<div class="col-xs-2">
										<div class="input-group">
											<span class="input-group-addon">提现类型</span>
											<select class="form-control" id="type" name="type">
												<option value="">全部</option>
                                            </select>
										</div>
									</div>
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

				<div class="panel-heading">
					<shiro:hasPermission name="withdraw:lcWait:export">
						<button type="button" class="btn btn-primary" onclick="exportNow();">导出当前</button> <button type="button" class="btn btn-primary" onclick="exportAll();">导出全部</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="withdraw:lcStatus">
						<button type="button" class="btn btn-primary" onclick="bathCheck('1');">审核通过</button> 
						<button type="button" class="btn btn-primary" onclick="bathCheck('2');">审核不通过</button>
					</shiro:hasPermission>
					<font size="4">&nbsp;&nbsp;昨日提现：${yesterdayMonery}&nbsp;&nbsp;总提现：${allMonery}</font>
					<font size="4" id = "selectdValues">&nbsp;&nbsp;选中提现：0</font>
				</div>
				<div class="panel-body">
					<div class="table-responsive">
						<table id="myTable"
							class="table table-striped table-bordered table-hover"
							data-url="<%=request.getContextPath()%>/admin/withdraw/queryCheckLcWithdraws"
							data-pageSize="10,50,100" data-method="POST">
							<thead>
								<tr>
									<th width="5%" data-type="checkbox" data-field="id"></th>
									<th width="50px" data-field="empno">员工编号</th>
									<th width="50px" data-field="name">名称</th>
									<th width="50px" data-field="bankNo">银行账号</th>
									<th width="50px" data-field="type" data-call="true">用户类型</th>
									<th width="50px" data-field="withdrawMoney">提现金额</th>
									<th width="50px" data-field="actualMoney">入账金额</th>
									<th width="50px" data-field="fee">手续费</th>
									<th width="50px" data-field="openBankName">开户支行</th>
										<th width="50px" data-field="typeMoney" data-call="true">提现类型</th>
									<th width="50px" data-field="withdrawTime" data-call="true">申请时间</th>
									<th width="50px" data-field="verifyStatus" data-call="true">状态</th>
									<th width="50px" data-field="button" data-call="true">操作</th>
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
		var moneyWithdrawList = $.parseJSON('${moneyWithdrawList}');
		for (var i = 0; i < moneyWithdrawList.length; i++) {
			$(new Option(moneyWithdrawList[i].dicDataName,moneyWithdrawList[i].dicDataValue)).appendTo('#type');
		}
		//var scfRoleTypeList = $.parseJSON('${scfRoleTypeList}');
		//for (var i = 0; i < scfRoleTypeList.length; i++) {
		//	$(new Option(scfRoleTypeList[i].dicDataName,scfRoleTypeList[i].dicDataValue)).appendTo('#type');
		//}
	});
	
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
    	if(id == 'verifyStatus'){
    		var verifyStatusList = ${verifyStatusList};
    		for (var i = 0; i < verifyStatusList.length; i++) {
    			if(data[id] == verifyStatusList[i].dicDataValue){
    				return verifyStatusList[i].dicDataName;
    				break;
    			}
			}
    		return data[id];
    	}else if(id == 'type'){
        	var scfRoleTypeList = ${scfRoleTypeList};
    		for (var i = 0; i < scfRoleTypeList.length; i++) {
    			if(data[id] == scfRoleTypeList[i].dicDataValue){
    				return scfRoleTypeList[i].dicDataName;
    				break;
    			}
			}
    		return data[id];
    	}else if(id == 'typeMoney'){
    	
    		var moneyWithdrawList = ${moneyWithdrawList};
    		for (var i = 0; i < moneyWithdrawList.length; i++) {
    			if(data[id] == moneyWithdrawList[i].dicDataValue){
    				return moneyWithdrawList[i].dicDataName;
    				break;
    			}
			}
    		return data[id];
    	}else if(id == 'button'){
    		if($('#p_status').val() == 1){
    			return '<button type="button" class="btn btn-primary btn-xs" onclick="check(\'' + data.id + '\');">审核</button> ';
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
    
    function check(id){
    	layer.open({
    	    type: 2,
    	    area: ['400px', '600px'],
    	    offset: [100,(($(window).width()-400)/2)],
    	    title: '审核提现',
    	    content: ['<%=request.getContextPath()%>/admin/withdraw/checkingWithdrawPage?id=' + id,'no']
    	});
    }
    
    //批量审核
    function bathCheck(verifyStatus){
    	var chk_value =[];
        $("#tbodyId").find("input").each(function() {
            if($(this).attr('type') == 'checkbox' && $(this).is(':checked')){
                chk_value.push($(this).val());
            }
        });

        if(chk_value.join(",") == null || chk_value.join(",") == ''){
            layer.alert('请选择需要审核的提现', {icon : 5});
            return;
        }
        
      //询问框
		layer.confirm('是否确定此操作？', {
			btn: ['确定','取消'] //按钮
		}, function(){
			$.ajax({
			      url: '<%=request.getContextPath()%>/admin/withdraw/bathCheckLcWithdraw',
			      dataType: 'json',
			      type: 'POST',
			      data: {
			    	  ids:chk_value.join(","),
			    	  verifyStatus:verifyStatus
			      },
			      success: function (data) {
			    	if(data.status == 'ok'){
			    		search(parseInt($('.active').attr('jp-data')));
			    	}else{
			    		layer.alert(data.msg, {
							icon : 5
						});
			    	}
			      },
			      error: function(){
			    	  layer.alert('系统错误', {
							icon : 5
						});
			      }
			  });
		}, function(){

		});
    }
    
    function exportNow(){
		$("#myForm").submit();
	}
	
	function exportAll(){
		window.open("<%=request.getContextPath()%>/admin/withdraw/lcWithdrawWaitExport");
	}
	function selectValue(){
		var totalIncome = 0;
		var totalFee = 0;
        $("#tbodyId").find("input").each(function() {
            if($(this).attr('type') == 'checkbox' && $(this).is(':checked')){
            	var json = $.parseJSON($(this).attr('selectValue'));
            	totalIncome += json.actualMoney;
            	totalFee += json.fee;
            }
        });
        var rs = totalIncome - totalFee;
        $('#selectdValues').html("&nbsp;&nbsp;选中提现:"+rs.toFixed(2));
	}
	</script>
</body>
</html>