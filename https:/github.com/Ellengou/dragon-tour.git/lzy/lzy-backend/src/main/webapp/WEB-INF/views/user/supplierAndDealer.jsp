<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台管理系统</title>
<%@ include file="/WEB-INF/views/template/bootMainCss.jsp"%>
</head>
<body>
	<shiro:hasPermission name="user:supplierAndDealer:edit">
	    <input id="p_edit" style="display: none" value="1">
	</shiro:hasPermission>
	<shiro:hasPermission name="user:supplierAndDealer:status">
	    <input id="p_status" style="display: none" value="1">
	</shiro:hasPermission>
	<shiro:hasPermission name="user:supplierAndDealer:check">
	    <input id="p_check" style="display: none" value="1">
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
										<div class="input-group">
											<span class="input-group-addon">昵称</span>
											<input type="text" class="form-control" id="nickName">
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
					<a class="btn btn-primary" href="<%=request.getContextPath()%>/template/供应商&经销商.xls" target="_self">供应商&经销商模板下载</a> 
					<shiro:hasPermission name="user:supplierAndDealer:add">
						<button type="button" class="btn btn-primary" onclick="add();">新增</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="user:supplierAndDealer:upload">
						<button type="button" class="btn btn-primary" onclick="uploadFile();">导入</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="user:supplierAndDealer:export">
						<button type="button" class="btn btn-primary" onclick="exportAll();">导出</button>
					</shiro:hasPermission>
				</div>
				<div class="panel-body">
					<div class="table-responsive">
						<table id="myTable"
							class="table table-striped table-bordered table-hover"
							data-url="<%=request.getContextPath()%>/admin/userFront/querySuppliersAndDealers"
							data-pageSize="10,50,100" data-method="POST">
							<thead>
								<tr>
									<th width="5%" data-type="checkbox" data-field="id"></th>
									<%--<th width="20px" data-field="id">ID</th>--%>
									<th width="10%" data-field="suppName">名称</th>
									<th width="15%" data-field="phone">手机</th>
									<th width="15%" data-field="suppType"  data-call="true">类型</th>
									<th width="15%" data-field="operateTime" data-call="true">注册时间</th>
									<th width="10%" data-field="verifyStatus" data-call="true">审核状态</th>
									<th width="10%" data-field="status" data-call="true">状态</th>
									<th width="20%" data-field="button" data-call="true">操作</th>
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
    
	<script type="text/javascript">
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
    	}else if(id == 'suppType'){
    		if(data.suppType == '0'){
    			return '尚未关联';
    		}else if(data.suppType == '1'){
    			return '供应商';
    		}else if(data.suppType == '2'){
    			return '经销商';
    		}else if(data.suppType == '3'){
    			return '供应商经销商';
    		}else{
    			return data[id];
    		}
    	}else if(id == 'status'){
    		var userStatusList = ${userStatusList};
			for (var i = 0; i < userStatusList.length; i++) {
				if(data[id] == userStatusList[i].dicDataValue){
    				return userStatusList[i].dicDataName;
    				break;
    			}
			}
    		return data[id];
    	}else if(id == 'button'){
        	var str = '';
        	if($('#p_edit').val() == 1){
        		str = str + '<button type="button" class="btn btn-primary btn-xs" onclick="edit(\'' + data.id + '\');">编辑</button> ';
        	}
        	if($('#p_status').val() == 1){
    			str = str + '<button type="button" class="btn btn-warning btn-xs" onclick="editStatus(\'' + data.id + '\',\'' + data.status + '\',\'4\');">修改状态</button>';
        	}
    		
        	if($('#p_check').val() == 1){
	    		if(data.verifyStatus != '1'){
	    			str = str + ' <button type="button" class="btn btn-warning btn-xs" onclick="check(\'' + data.infoId + '\',\'' + data.id + '\');">审核</button>';
	    		}
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
	
	function add(){
		var index = layer.open({
    	    type: 2,
    	    area: ['900px', '500px'],
    	    offset: [100,(($(window).width()-900)/2)],
    	    title: '添加供应商经销商',
    	    content: ['<%=request.getContextPath()%>/admin/userFront/addSupplierAndDealerPage','yes']
    	});
    	layer.full(index);
    }
    
    function edit(id){
    	var index = layer.open({
    	    type: 2,
    	    area: ['900px', '500px'],
    	    offset: [100,(($(window).width()-900)/2)],
    	    title: '修改供应商经销商信息',
    	    content: ['<%=request.getContextPath()%>/admin/userFront/editSupplierAndDealerPage?id=' + id,'yes']
    	});
    	layer.full(index);
    }
    
    function editStatus(id,status,type){
    	layer.open({
    	    type: 2,
    	    area: ['500px', '300px'],
    	    offset: [100,(($(window).width()-500)/2)],
    	    title: '修改供应商经销商状态',
    	    content: ['<%=request.getContextPath()%>/admin/userFront/editUserFrontStatusPage?id=' + id + '&status=' + status + '&type=' + type,'no']
    	});
    }
    
    function check(id,frontUserId){
		var index = layer.open({
    	    type: 2,
    	    area: ['900px', '500px'],
    	    offset: [100,(($(window).width()-900)/2)],
    	    title: '审核供应商经销商',
    	    content: ['<%=request.getContextPath()%>/admin/userFront/checkSupplierAndDealerPage?id=' + id + '&frontUserId=' + frontUserId,'yes']
    	});
    	layer.full(index);
    }
    
    function uploadFile(){
    	layer.open({
    	    type: 2,
    	    area: ['500px', '300px'],
    	    offset: [100,(($(window).width()-500)/2)],
    	    title: '导入供应商经销商',
    	    content: ['<%=request.getContextPath()%>/admin/userFront/uploadFilePage?type=2','no']
    	});
    }
    
    function exportAll(){
		var chk_value =[];
		$("#tbodyId").find("input").each(function() {
			if($(this).attr('type') == 'checkbox' && $(this).is(':checked')){
				chk_value.push($(this).val());
			}
		});

		if(chk_value.join(",") == null || chk_value.join(",") == ''){
			window.open("<%=request.getContextPath()%>/admin/userFront/supplierAndDealerExport");
			return;
		} else {
			window.open("<%=request.getContextPath()%>/admin/userFront/supplierAndDealerExport?ids=" + chk_value.join(","));
			return;
		}
	}
	</script>
</body>
</html>