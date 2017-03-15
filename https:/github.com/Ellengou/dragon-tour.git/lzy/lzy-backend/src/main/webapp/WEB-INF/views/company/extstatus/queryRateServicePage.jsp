<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<title>后台管理系统</title>
<%@ include file="/WEB-INF/views/template/bootMainCss.jsp"%>
<link href="<%=request.getContextPath()%>/bootstrap/plugin/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css" rel="stylesheet">
</head>
<body>
<shiro:hasPermission name="rate:service:company:set">
    <input id="p_set" style="display: none" value="1">
</shiro:hasPermission>
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-body">
					<div class="row">
						<div class="col-lg-12">
							<form id="myForm">
								<div class="row">
									<div class="col-xs-2">
										<!-- <button type="button" class="btn btn-primary btn-sm" onclick="search(1)">查询</button> -->
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
							data-url="<%=request.getContextPath()%>/company/ext/status/queryRateService"
							data-pageSize="10,50,100" data-method="get">
							<thead>
								<tr>
									<th data-field="comp_name">公司名称</th>
									<th data-field="rate_service_state" data-call="true">贴息利率状态</th>
									<th data-field="create_time">创建时间</th>
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
	
	function tableCallBack(data,id){
        if(id == 'button'){
        	var rate_service_state = data.rate_service_state;
        	var str = '';
        	if(('-1' == rate_service_state) || ('1' == rate_service_state)){
        		if($("#p_set").val() == 1){
		        	str += '<button type="button" class="btn btn-success btn-xs" onclick="setStatus(\'' + data.id + '\',\'0\');">启用</button>';;
        		}
        	}else if('0' == rate_service_state){
        		if($("#p_set").val() == 1){
		        	str += '<button type="button" class="btn btn-danger btn-xs" onclick="setStatus(\'' + data.id + '\',\'1\');">停用</button>';;
        		}
        	}
        	return str;
        }else if(id == 'rate_service_state'){
        	if(data[id] == '-1'){
        		return '未启用';
        	}else if(data[id] == '0'){
        		return '已启用';
        	}else if(data[id] == '1'){
        		return '停用';
        	}
        }else{
            if(data[id] == null || data[id] == ''){
                return '';
            }else{
                return data[id];
            }
        }
    }
	
	function setStatus(companyId,status){
		var sub;
		if('0' == status){
			sub = '启用';
		}else if('1' == status){
			sub = '停用';
		}
		layer.confirm('确定'+sub+'?', {icon: 3, title:'提示'}, function(index){
		  	$.ajax({
	            type:'POST',
	            url: '<%=request.getContextPath()%>/company/ext/status/setStatus',
	            dataType: 'json',
	            data:{companyId:companyId,status:status},
	            success: function (data) {
	                console.log(data.status);
	                if (data.status == 'ok'){
	                    console.log(data.status);
	                    layer.alert('修改成功', {
	                        icon : 6
	                    });
	                    search(1);
	                }else{
	                    layer.alert(data.msg, {
	                        icon : 5
	                    });
	                }
	            },
	            error: function(){
	
	            }
        	});
		  	layer.close(index);
		});
		
	}
	
	$(document).ready(function(){
		  
	});
	</script>
</body>
</html>