<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<title>后台管理系统</title>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ include file="/WEB-INF/views/template/bootMainCss.jsp"%>
<link href="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css" rel="stylesheet">
</head>
<body>
<shiro:hasPermission name="	loan:shelf:save">
    <input id="p_shelf" style="display: none" value="1">
</shiro:hasPermission>
<shiro:hasPermission name="	loan:sell:save">
    <input id="p_sell" style="display: none" value="1">
</shiro:hasPermission>
<shiro:hasPermission name="loan:update:order">
    <input id="p_update_order" style="display: none" value="1">
</shiro:hasPermission>
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
											<span class="input-group-addon">发布时间</span>
											<input class="form-control " type="text" id="minUpInvestTime"  name="minUpInvestTime"  readonly>
							                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
							                <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
										</div>
									</div>
									
									
									<div class="col-xs-3">
										<div class="input-group date form_time">
											<input class="form-control" type="text" id="maxUpInvestTime" name="maxUpInvestTime"  readonly>
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
											<select  class="form-control" name="loanStatus" id="loanStatus">
											</select>
										</div>
									</div>
									<div class="col-xs-3">
										<div class="input-group">
											<span class="input-group-addon">名称</span>
											<input type="text" class="form-control" id="loanName" name ="loanName">
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
							data-url="<%=request.getContextPath()%>/admin/project/loan/${queryType}"
							data-pageSize="10,50,100" data-method="get">
							<thead>
								<tr>
									<th data-field="serial_num">产品编号</th>
									<th data-field="show_order" data-call="true">展示序号↓</th>
									<th data-field="up_invest_time">发布时间↓</th>
									<th data-field="apply_name">产品名称</th>
									<th data-field="user_front_name">借款人</th>
									<th data-field="pledge_company_name">质押单位</th>
									<th data-field="invest_rate">年利率(%)</th>
									<th data-field="loan_money">规模(元)</th>
									<th data-field="product_line">期限(天)</th>
									<th data-field="loan_type">还款方式</th>
									<th data-field="loan_status">状态</th>
									<th data-field="status" data-call="true">展示信息</th>
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
	//设置核心企业列表
	$("#compCoreId").showList('option',{infoList:'${companyList}'})
	$("#loanStatus").showList('option',{infoList:'${loanStatus}',column_name:'dicDataName',column_value:'dicDataValue'})
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
        	var str = '';
            str += '<button type="button" class="btn btn-primary btn-xs" onclick="queryLoan(\'' + data.id + '\',\'' + data.type + '\');">查看</button>';
            
            if($("#p_shelf").val()==1){
	        	var isShelf = data['is_shelf'];
	        	if('0' == isShelf){
		        	str += '<button type="button" class="btn btn-danger btn-xs" onclick="setShelf(\'' + data.id + '\');">下架</button>';
	        	}else if('1' == isShelf){
	        		str += '<button type="button" class="btn btn-primary btn-xs" onclick="setShelf(\'' + data.id + '\');">上架</button>';
	        	}
        	}
        	if($("#p_sell").val() == 1){
	        	var isSell = data['is_sell'];
	        	if('0' == isSell){
		        	str += '<button type="button" class="btn btn-danger btn-xs" onclick="setSell(\'' + data.id + '\');">停售</button>';
	        	}else if('1' == isSell){
		        	str += '<button type="button" class="btn btn-primary btn-xs" onclick="setSell(\'' + data.id + '\');">售卖</button>';
	        	}
        	}
        	return str;
        }else if(id == 'show_order'){
        	if($("#p_update_order").val() == 1){
        		var str = '';
        		if(typeof data[id] == 'undefined'){
        			str += '<span onclick="updateShowOrder(\'' + data.id + '\')" style="cursor: pointer;text-decoration:underline;">未设置</span>';
        		}else{
        			str += '<span onclick="updateShowOrder(\'' + data.id + '\')" style="cursor: pointer;text-decoration:underline;">'+data[id]+'</span>';
        		}
        		return str;
        	}else{
        		if(typeof data[id] == 'undefined'){
        			return '';
        		}else{
        			return data[id];
        		}
        	}
        }else if('status' == id){
        	var isShelf = data['is_shelf'];
        	var isSell = data['is_sell'];
        	var str = '';
        	if('0' == isShelf){
        		str += '<span style="color: green">上架</span>';
        	}else if('1' == isShelf){
        		str += '<span style="color: red">下架</span>';
        	}
        	str += ',';
        	if('0' == isSell){
        		str += '<span style="color: green">售卖中</span>';
        	}else if('1' == isSell){
        		str += '<span style="color: red">已停售</span>';
        	}
        	return str;
        }else{
            if(data[id] == null || data[id] == ''){
                return '';
            }else{
                return data[id];
            }
        }
    }
	
	function updateShowOrder(id){
		layer.open({
            type: 2,
            area:['300px','200px'],
            offset: [100,(($(window).width()-300)/2)],
            title: false,
            content: ['<%=request.getContextPath()%>/admin/project/loan/setShowOrderPage?id=' + id,'no']
        });
	}
	function setShelf(loanId){
		layer.confirm('确认操作？', {
		  btn: ['确认', '取消']
		}, function(index, layero){
		  $.ajax({
			 url : '<%=request.getContextPath()%>/admin/project/loan/setShelf',
			 type : 'POST',
			 dataType : 'json',
			 data : {loanId:loanId},
			 success : function(data){
			    if(data.status == 'ok'){
			      layer.close(index);
              	  location.reload();
              	  layer.close(parIndex);
		    	}else{
		    		layer.alert(data.msg, {
						icon : 5
					});
		    	}
			 },
			 error : function(){
				 alert('系统错误,请重试')
			 }
		  });
		}, function(index){
		});
	}
	function setSell(loanId){
		layer.confirm('确认操作？', {
		  btn: ['确认', '取消']
		}, function(index, layero){
		  $.ajax({
			 url : '<%=request.getContextPath()%>/admin/project/loan/setSell',
			 type : 'POST',
			 dataType : 'json',
			 data : {loanId:loanId},
			 success : function(data){
			    if(data.status == 'ok'){
			      layer.close(index);
              	  location.reload();
              	  layer.close(parIndex);
		    	}else{
		    		layer.alert(data.msg, {
						icon : 5
					});
		    	}
			 },
			 error : function(){
				 alert('系统错误,请重试')
			 }
		  });
		}, function(index){
		});
	}
	function queryLoan(id,type){
		var index = layer.open({
            type: 2,
            offset: [100,(($(window).width()-900)/2)],
            title: false,
            content: '<%=request.getContextPath()%>/admin/project/loan/viewLoan?id=' + id+'&type='+type
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
		  $('.form_time').datetimepicker({
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