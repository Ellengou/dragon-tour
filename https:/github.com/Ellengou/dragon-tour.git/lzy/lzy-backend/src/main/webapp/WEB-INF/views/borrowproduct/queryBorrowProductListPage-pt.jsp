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
									<div class="col-xs-2">
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
							data-url="<%=request.getContextPath()%>/admin/borrowProduct/queryBorrowProductList"
							data-pageSize="10,50,100" data-method="get">
							<thead>
								<tr>
									<th data-field="name">产品名称</th>
									<th data-field="comp_core_name">核心企业</th>
									<th data-field="borrow_type_names">借款类型</th>
									<th data-field="use_type" data-call="true">用途类型</th>
									<th data-field="user_types" data-call="true">借款对象</th>
									<th data-field="status" data-call="true">状态</th>
									<th data-field="create_time">创建时间</th>
									<th data-field="update_time">更新时间</th>
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
	var jkrList = $.parseJSON('${jkrList}');
	//设置核心企业列表
	function tableCallBack(data,id){
        if(id == 'button'){
            return '<button type="button" class="btn btn-primary btn-xs" onclick="query(\'' + data.id + '\');">修改</button>';;
        }else if(id == 'user_types'){
        	if(data[id] == null || data[id] == ''){
                return '';
            }else{
            	var jkrArr = data[id].split(",");
            	var rs = '';
            	for(var i = 0;i<jkrArr.length;i++){
            		var jkr = jkrArr[i];
            		for(var j = 0;j<jkrList.length;j++){
            			var obj = jkrList[j];
            			if(obj.value == jkr){
            				rs += obj.name+',';
            			}
            		}
            	}
                return rs.substring(0,rs.length - 1);
            }
        }else if(id == 'status'){
        	if(data[id] == '0'){
        		return '启用';
        	}else if(data[id] == '1'){
        		return '停用';
        	}else{
        		return ''
        	}
        }else if(id == 'use_type'){
        	var rs = '';
        	if(null != data[id]){
	        	if(data[id].indexOf('0') >= 0){
	        		rs += '经营性,';
	        	}
	        	if(data[id].indexOf('1') >= 0){
	        		rs += '固定资产,';
	        	}
        	}
        	if(rs.length > 0){
        		return rs.substring(0,rs.length - 1);
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
	
	</script>
</body>
</html>