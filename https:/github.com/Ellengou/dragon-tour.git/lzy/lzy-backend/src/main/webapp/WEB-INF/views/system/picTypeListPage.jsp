<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>系统设置-图片类型-列表</title>
<%@ include file="/WEB-INF/views/template/bootMainCss.jsp"%>
</head>
<body>
	<shiro:hasPermission name="picType:update">
	    <input id="p_update" style="display: none" value="1">
	</shiro:hasPermission>
	<shiro:hasPermission name="picType:status">
	    <input id="p_status" style="display: none" value="1">
	</shiro:hasPermission>
<%-- 	<shiro:hasPermission name="picType:delete">
	    <input id="p_delete" style="display: none" value="1">
	</shiro:hasPermission> --%>
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
											<span class="input-group-addon">名称</span>
											<input type="text" class="form-control" id="name">
										</div>
									</div>
									<div class="col-xs-2">
										<div class="input-group">
											<span class="input-group-addon">状态</span>
											<select class="form-control" id="status">
												<option value="">全部</option>
                                            </select>
										</div>
									</div>
									<div class="col-xs-2">
										<div class="input-group">
											<span class="input-group-addon">平台</span>
											<select class="form-control" id="platform">
												<option value="">全部</option>
											</select>
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
				<shiro:hasPermission name="picType:add">
					<div class="panel-heading">
						<button type="button" class="btn btn-primary" onclick="add();">新增</button>
					</div>
				</shiro:hasPermission>
				<div class="panel-body">
					<div class="table-responsive">
						<table id="myTable"
							class="table table-striped table-bordered table-hover"
							data-url="<%=request.getContextPath()%>/admin/system/picType/queryPicTypes"
							data-pageSize="10,50,100" data-method="get">
							<thead>
								<tr>
									<th width="20px" data-field="id">ID</th>
									<th width="50px" data-field="name">名称</th>
									<th width="50px" data-field="val">值</th>
									<th width="50px" data-field="platform" data-call="true">平台</th>
									<th width="50px" data-field="status" data-call="true">状态</th>
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
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/commons.js"></script>
	<script type="text/javascript">
	
	$(function(){
		 var isUseData = $.parseJSON('${isUseList}');
		for (var i = 0; i < isUseData.length; i++) {
			$(new Option(isUseData[i].shortName,isUseData[i].val)).appendTo('#status');
		}
		var platformData = $.parseJSON('${platformList}');
		for (var i = 0; i < platformData.length; i++) {
			$(new Option(platformData[i].shortName,platformData[i].val)).appendTo('#platform');
		}
	});
	
	function tableCallBack(data,id){
    	if(id == 'status'){
    		 var isUseData = ${isUseList};
    		for (var i = 0; i < isUseData.length; i++) {
    			if(data[id] == isUseData[i].val){
    				if(data[id] ==0){
    					return isUseData[i].shortName;
    				}else{
    					return	'<font color="#FF0000">'+isUseData[i].shortName+'</font>';
    				}
    				
    				break;
    			}
			}
    		return data[id];
    	}else if(id == 'platform'){
    		var platformList = ${platformList};
    		for (var i = 0; i < platformList.length; i++) {
    			if(data[id] == platformList[i].val){
    				return platformList[i].shortName;
    				break;
    			}
			}
    		return data[id];
    	}else if(id == 'button'){
    		var str = '';
    		if($('#p_update').val() == 1){
        		str = str + '<button type="button" class="btn btn-primary btn-xs" onclick="edit(\'' + data.id + '\');">编辑</button> ';
    		}
    		if($('#p_status').val() == 1){
    			if(data.status == '1'){
        			str = str + ' <button type="button" class="btn btn-warning btn-xs" onclick="editStatus(\'' + data.id + '\',\'0\');">启用</button>';
        		}else{
        			str = str + ' <button type="button" class="btn btn-warning btn-xs" onclick="editStatus(\'' + data.id + '\',\'1\');">禁用</button>';
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
    	layer.open({
    	    type: 2,
    	    area: ['800px', '300px'],
    	    offset: [100,(($(window).width()-800)/2)],
    	    title: '增加图片类型',
    	    content: ['<%=request.getContextPath()%>/admin/system/picType/addPicTypePage','no']
    	});
    }
    
    function edit(id){
    	layer.open({
    	    type: 2,
    	    area: ['800px', '300px'],
    	    offset: [100,(($(window).width()-800)/2)],
    	    title: '修改图片类型',
    	    content: ['<%=request.getContextPath()%>/admin/system/picType/editPicTypePage?id=' + id,'no']
    	});
    }
    
    function deletePicType(id){
     	var object={'url':'<%=request.getContextPath()%>/admin/picType/deletePicType',
    			'data':{'id':id},
    			'type':'get'};
    	commonsRequest(object);
    	
    }
    
    function editStatus(id,status){
    	var object={'url':'<%=request.getContextPath()%>/admin/system/picType/editPicTypeStatus',
    			'data':{'id':id,'status':status},
    			'type':'get'};
    	commonsRequest(object);

    }
    
	</script>
</body>
</html>