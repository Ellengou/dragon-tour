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
	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">合同内容</h1>
		</div>
	</div>
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
											<span class="input-group-addon">作者</span>
											<input type="text" class="form-control" id="author">
										</div>
									</div>
									<div class="col-xs-2">
										<div class="input-group">
											<span class="input-group-addon">合同名</span>
											<input type="text" class="form-control" id="title">
										</div>
									</div>
									<div class="col-xs-2">
										<div class="input-group">
											<span class="input-group-addon">合同类型</span>
											<select class="form-control" id="programaId">
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

				<div class="panel-heading">
					<button type="button" class="btn btn-primary" onclick="add();">新增</button>
				</div>
				<div class="panel-body">
					<div class="table-responsive">
						<table id="myTable"
							class="table table-striped table-bordered table-hover"
							data-url="<%=request.getContextPath()%>/admin/contractContent/queryContents"
							data-pageSize="10,50,100" data-method="get">
							<thead>
								<tr>
									<th width="20px" data-field="id">ID</th>
									<th width="50px" data-field="serialNum">序号</th>
									<th width="50px" data-field="programaId" data-call="true">类型</th>
									<th width="50px" data-field="title">合同名</th>
									<th width="50px" data-field="author">作者</th>
									<th width="50px" data-field="status" data-call="true">状态</th>
									<th width="50px" data-field="shelf" data-call="true">是否使用</th>
									<th width="50px" data-field="createTime" data-call="true">创建时间</th>
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
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/utils.js"></script>
    
	<script type="text/javascript">
	
	$(function(){
		var programaData = $.parseJSON('${programaList}');
		for (var i = 0; i < programaData.length; i++) {
			$(new Option(programaData[i].name,programaData[i].id)).appendTo('#programaId');
		}
	});
	
	function tableCallBack(data,id){
    	if(id == 'status'){
    		var contentStatusList = ${contentStatusList};
    		for (var i = 0; i < contentStatusList.length; i++) {
    			if(data[id] == contentStatusList[i].dicDataValue){
    				return contentStatusList[i].dicDataName;
    				break;
    			}
			}
    		return data[id];
    	}else if(id == 'shelf'){
        	var shelfStatusList = ${shelfStatusList};
    		for (var i = 0; i < shelfStatusList.length; i++) {
    			if(data[id] == shelfStatusList[i].dicDataValue){
    				return shelfStatusList[i].dicDataName;
    				break;
    			}
			}
    		return data[id];
    	}else if(id == 'programaId'){
    		var programaData = $.parseJSON('${programaList}');
    		for (var i = 0; i < programaData.length; i++) {
    			if(programaData[i].id == data.programaId){
    				return programaData[i].name;
    				break;
    			}
    		}
    	}else if(id == 'button'){
    		return '<button type="button" class="btn btn-primary btn-xs" onclick="edit(\'' + data.id + '\');">编辑</button> <button type="button" class="btn btn-warning btn-xs" onclick="editStatus(\'' + data.id + '\',\'' + data.status + '\',\'' + data.shelf + '\');">修改状态</button> <button type="button" class="btn btn-danger btn-xs" onclick="deleteContent(\'' + data.id + '\');">删除</button>';
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
    	    area: ['900px', '700px'],
    	    offset: [100,(($(window).width()-900)/2)],
    	    title: '添加合同',
    	    content: '<%=request.getContextPath()%>/admin/contractContent/addContentPage'
    	});
    	layer.full(index);
    }
    
    function edit(id){
    	var index = layer.open({
    	    type: 2,
    	    area: ['900px', '300px'],
    	    offset: [100,(($(window).width()-900)/2)],
    	    title: '修改合同',
    	    content: '<%=request.getContextPath()%>/admin/contractContent/editContentPage?id=' + id
    	});
    	layer.full(index);
    }
    
    function editStatus(id,status,shelf){
    	layer.open({
    	    type: 2,
    	    area: ['500px', '300px'],
    	    offset: [100,(($(window).width()-500)/2)],
    	    title: '修改合同状态',
    	    content: ['<%=request.getContextPath()%>/admin/contractContent/editContentStatusPage?id=' + id + '&status=' + status + '&shelf=' + shelf,'no']
    	});
    }
    
    function deleteContent(id){
    	//询问框
    	layer.confirm('是否确定此操作？', {
    	  btn: ['确定','取消'] //按钮
    	}, function(){
    		$.ajax({
  		      url: '<%=request.getContextPath()%>/admin/contractContent/deleteContent',
  		      dataType: 'json',
  		      type: 'GET',
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
	</script>
</body>
</html>