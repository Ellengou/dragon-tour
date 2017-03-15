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
											<select  class="form-control" id = "compCoreId" name = "compCoreId"></select>
										</div>
									</div>
									<div class="col-xs-3">
										<div class="input-group">
											<span class="input-group-addon">供应商</span>
											<input type="text" class="form-control" id="userFrontName" name="userFrontName">
										</div>
									</div>
									<div class="col-xs-6">
										<div class="input-group" id="div_gmdx">
											<input type="text" id = "investType" name = "investType" hidden="true">
										</div>
									</div>
								</div>
								<br />
								<div class="row">
									<div class="col-xs-3">
										<div class="input-group" id = "div_hxqy">
											<span class="input-group-addon">子公司</span>
											<input type="text" class="form-control" id="pledgeCompanyName" name ="pledgeCompanyName">
										</div>
									</div>
									
									<div class="col-xs-3">
										<div class="input-group date form_time">
											<span class="input-group-addon">满标时间</span>
											<input type="text" class="form-control" id="minGiveMoneyTime" name="minGiveMoneyTime" readonly="readonly">
											<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
											<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
										</div>
									</div>
									<div class="col-xs-3">
										<div class="input-group date form_time">
											<input type="text" class="form-control" id="maxGiveMoneyTime" name="maxGiveMoneyTime" readonly="readonly">
											<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
											<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
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
							data-url="<%=request.getContextPath()%>/admin/project/loan/queryFailRepayInfos"
							data-pageSize="10,50,100" data-method="get">
							<thead>
								<tr>
									<th data-field="show_name">名称</th>
									<th data-field="serial_num">还款编号</th>
									<th data-field="repay_date">还款日</th>
									<th data-field="corpus">本金</th>
									<th data-field="interest">利息</th>
									<th data-field="fee">手续费</th>
									<th data-field="period">还款期数</th>
									<th data-field="status">状态</th>
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
	$("#compCoreId").showList('option',{infoList:'${companyList}'})
	function tableCallBack(data,id){
        if(id == 'button'){
        	var str = '';
	          str += '<button type="button" class="btn btn-primary btn-xs" onclick="repay(\'' + data.id + '\');">还款</button>';;
        	return str;
        }else{
            if(data[id] == null || data[id] == ''){
                return '';
            }else{
                return data[id];
            }
        }
    }
	function repay(id){
		layer.open({
    	    type: 2,
    	    area: ['600px', '400px'],
    	    offset: [100,(($(window).width()-600)/2)],
    	    title: false,
    	    content: '<%=request.getContextPath()%>/admin/project/loan/repayPage?id=' + id
    	});
    }
	
	$(document).ready(function(){
		//产品适用对象
		  var cpsydx = ${scf_loan_cpsydx};
		  template = "";
		  for(var i=0;i<cpsydx.length;i++){
			  var obj = cpsydx[i];
			  template += "<input type=\"checkbox\" name=\"check_inver\"	 onclick=\"setInvestType(this,"+obj.dicDataValue+")\" value="+obj.dicDataValue+"><label>"+obj.dicDataName+"</label>"
		  }
		  $("#div_gmdx").append(template);
		  
		//绑定时间
		  $(".form_time").datetimepicker({
			  format : 'yyyy-mm-dd',
				language : 'zh-CN',
				minView: "month",
		        weekStart: 1,
		        todayHighlight:true,
		        autoclose:true,
		        pickerPosition: "bottom-left"
	      });
		  
	});
	</script>
</body>
</html>