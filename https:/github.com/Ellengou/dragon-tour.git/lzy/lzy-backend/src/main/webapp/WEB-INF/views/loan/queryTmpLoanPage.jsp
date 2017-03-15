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
											<span class="input-group-addon">创建时间</span>
											<input type="text" class="form-control" id="minCreateLoanTime" name="minCreateLoanTime" readonly="readonly">
											<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
											<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
										</div>
									</div>
									<div class="col-xs-3">
										<div class="input-group date form_time">
											<input type="text" class="form-control" id="maxCreateLoanTime" name="maxCreateLoanTime" readonly="readonly">
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
							data-url="<%=request.getContextPath()%>/admin/project/loan/queryTmpLoans"
							data-pageSize="10,50,100" data-method="get">
							<thead>
								<tr>
									<th data-field="serial_num">产品编号</th>
									<th data-field="apply_name">产品名称</th>
									<th data-field="create_loan_time">提交时间</th>
									<th data-field="user_front_name">借款人</th>
									<th data-field="pledge_company_name">质押单位</th>
									<th data-field="invest_rate">年利率(%)</th>
									<th data-field="loan_money">规模(元)</th>
									<th data-field="product_line">期限(天)</th>
									<th data-field="loan_type">还款方式</th>
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
	function setInvestType(checkBox,id){
		var ckArr =$("input[name='check_inver']");
		var inversType = "";
		for(var i=0;i<ckArr.length;i++){
			var obj = ckArr[i];
			if(obj.checked){
				inversType += obj.value+",";
			}
		}
		if(inversType.length>0){
			inversType =  inversType.substring(0,inversType.length-1);
		}
		$("#investType").val(inversType);
	}
	
	function tableCallBack(data,id){
        if(id == 'button'){
        	var template = '<button type="button" class="btn btn-primary btn-xs" onclick="editor(\'' + data.id + '\');">修改</button>';
        	template += '<button type="button" class="btn btn-danger btn-xs" onclick="deleteTmp(\'' + data.id + '\');">删除</button>';
            return template;
        }else{
            if(data[id] == null || data[id] == ''){
                return '';
            }else{
                return data[id];
            }
        }
    }
	function deleteTmp(id){
		layer.confirm('确认删除?', {icon: 3, title:'提示'}, function(index){
			layer.close(index);
			  $.ajax({
			      url: '<%=request.getContextPath()%>/admin/project/loan/deleteTmp?id='+id,
			      type: 'GET',
			      dataType: 'json',
			      success: function (data) {
					 if(data.status=='ok'){
						 location.reload();
					 }else{
						 layer.msg(data.msg);
					 }
			      },
			      error: function(){
			    	  layer.msg("删除失败");
			      }
		  	  });
			});
	}
	function editor(id){
		var index = layer.open({
            type: 2,
            area: ['900px', '600px'],
            offset: [100,(($(window).width()-900)/2)],
            title: false,
            content: '<%=request.getContextPath()%>/admin/project/loan/editLoanPage?id=' + id
        });
		layer.full(index);
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