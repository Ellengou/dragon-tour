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
	<shiro:hasPermission name="programa:update">
	    <input id="p_update" style="display: none" value="1">
	</shiro:hasPermission>
	<shiro:hasPermission name="programa:status">
	    <input id="p_status" style="display: none" value="1">
	</shiro:hasPermission>
	<shiro:hasPermission name="programa:delete">
	    <input id="p_delete" style="display: none" value="1">
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
									<div class="col-xs-3">
										<button type="button" class="btn btn-primary btn-sm" onclick="search(1)">查询</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
				<shiro:hasPermission name="programa:add">
					<div class="panel-heading">
						<button type="button" class="btn btn-primary" onclick="add();">新增</button>
					</div>
				</shiro:hasPermission>
				<div class="panel-body">
					<div class="table-responsive">
						<table id="myTable"
							class="table table-striped table-bordered table-hover"
							data-url="<%=request.getContextPath()%>/admin/programa/queryProgramas"
							data-pageSize="10,50,100" data-method="post">
							<thead>
								<tr>
									<th width="20px" data-field="id">ID</th>
									<th width="50px" data-field="name">名称</th>
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
    
	<script type="text/javascript">
	
	$(function(){
		var enabledStatusData = $.parseJSON('${enabledStatusList}');
		for (var i = 0; i < enabledStatusData.length; i++) {
			$(new Option(enabledStatusData[i].dicDataName,enabledStatusData[i].dicDataValue)).appendTo('#status');
		}
	});
	
	function tableCallBack(data,id){
    	if(id == 'status'){
    		var enabledStatusList = ${enabledStatusList};
    		for (var i = 0; i < enabledStatusList.length; i++) {
    			if(data[id] == enabledStatusList[i].dicDataValue){
    				return enabledStatusList[i].dicDataName;
    				break;
    			}
			}
    		return data[id];
    	}else if(id == 'button'){
    		var str = '';
    		if($('#p_update').val() == 1){
        		str = str + '<button type="button" class="btn btn-primary btn-xs" onclick="edit(\'' + data.id + '\');">编辑</button> ';
    		}
    		if($('#p_delete').val() == 1){
    			str = str + '<button type="button" class="btn btn-danger btn-xs" onclick="deletePrograma(\'' + data.id + '\');">删除</button>';
    		}
    		if($('#p_status').val() == 1){
	    		if(data.status == '0'){
	    			str = str + ' <button type="button" class="btn btn-warning btn-xs" onclick="editStatus(\'' + data.id + '\',\'1\');">禁用</button>';
	    		}else{
	    			str = str + ' <button type="button" class="btn btn-warning btn-xs" onclick="editStatus(\'' + data.id + '\',\'0\');">启用</button>';
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
    	    area: ['400px', '300px'],
    	    offset: [100,(($(window).width()-400)/2)],
    	    title: '增加内容类型',
    	    content: ['<%=request.getContextPath()%>/admin/programa/addProgramaPage','no']
    	});
    }
    
    function edit(id){
    	layer.open({
    	    type: 2,
    	    area: ['400px', '300px'],
    	    offset: [100,(($(window).width()-400)/2)],
    	    title: '修改内容类型',
    	    content: ['<%=request.getContextPath()%>/admin/programa/editProgramaPage?id=' + id,'no']
    	});
    }
    
    function deletePrograma(id){
    	//询问框
    	layer.confirm('是否确定此操作？', {
    	  btn: ['确定','取消'] //按钮
    	}, function(){
    		$.ajax({
  		      url: '<%=request.getContextPath()%>/admin/programa/deletePrograma',
  		      dataType: 'json',
  		      type: 'post',
  		      data: {
  		    	  id:id
  		      },
  		      success: function (data) {
  		    	if(data.status == 'ok'){
  		    		layer.alert('删除成功', {icon : 6});
  		    		search(parseInt($('.active').attr('jp-data')));
  		    	}else{
  		    		layer.alert(data.msg, {icon : 5});
  		    	}
  		      },
  		      error: function(){
  		    	  layer.alert('系统错误', {icon : 5});
  		      }
  		  });
    	}, function(){
    		
    	});
    }
    
    function editStatus(id,status){
    	//询问框
    	layer.confirm('是否确定此操作？', {
    	  btn: ['确定','取消'] //按钮
    	}, function(){
    		$.ajax({
  		      url: '<%=request.getContextPath()%>/admin/programa/editProgramaStatus',
  		      dataType: 'json',
  		      type: 'post',
  		      data: {
  		    	  id:id,
  		    	  status:status
  		      },
  		      success: function (data) {
  		    	if(data.status == 'ok'){
  		    		layer.closeAll('dialog');
  		    		search(parseInt($('.active').attr('jp-data')));
  		    	}else{
  		    		layer.alert(data.msg, {icon : 5});
  		    	}
  		      },
  		      error: function(){
  		    	  layer.alert('系统错误', {icon : 5});
  		      }
  		  });
    	}, function(){
    		
    	});
    }
	</script>
</body>
</html>