<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>满标发送短信</title>
<%@ include file="/WEB-INF/views/template/bootMainCss.jsp"%>
</head>
<body>
	<shiro:hasPermission name="fullSms:update">
		<input id="p_update" style="display: none" value="1">
	</shiro:hasPermission>
	<shiro:hasPermission name="fullSms:delete">
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
											<span class="input-group-addon">姓名</span> <input type="text"
												class="form-control" id="name">
										</div>
									</div>
									<div class="col-xs-2">
										<div class="input-group">
											<span class="input-group-addon">手机号码</span> <input
												type="text" class="form-control" id="phone">
										</div>
									</div>
									<div class="col-xs-3">
										<button type="button" class="btn btn-primary btn-sm"
											onclick="search(1)">查询</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
				<shiro:hasPermission name="fullSms:add">
					<div class="panel-heading">
						<button type="button" class="btn btn-primary" onclick="add();">新增</button>
					</div>
				</shiro:hasPermission>
				<div class="panel-body">
					<div class="table-responsive">
						<table id="myTable"
							class="table table-striped table-bordered table-hover"
							data-url="<%=request.getContextPath()%>/admin/full/queryFullSms"
							data-pageSize="10,50,100" data-method="POST">
							<thead>
								<tr>
									<th width="5%" data-field="id" >ID</th>
									<th width="10%" data-field="name">姓名</th>
									<th width="40%" data-field="phone">手机号码</th>
									<th width="10%" data-field="button" data-call="true">操作</th>
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

	<script type="text/javascript"
		src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/jqPaginator.js"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/myPage.js"></script>

	<script type="text/javascript"
		src="<%=request.getContextPath()%>/bootstrap/plugin/layer/extend/layer.ext.js"></script>

	<script type="text/javascript">
	
	$(function(){
		
	});
	
	function tableCallBack(data,id){
		if(id == 'button'){
    		var str = '';
    		if($('#p_update').val() == 1){
        		str = str + '<button type="button" class="btn btn-primary btn-xs" onclick="edit(\'' + data.id + '\');">编辑</button> ';
    		}
    		 if($('#p_delete').val() == 1){
    			str = str + '<button type="button" class="btn btn-danger btn-xs" onclick="deletePicUrl(\'' + data.id + '\');">删除</button> ';
    		} 
    		
    		return str;
    	}else
    		if(data[id] == null || data[id] == ''){
    			return '';
    		}else{
    			return data[id];
    		}
    	

	}
	
	function add(){
    	layer.open({
    	    type: 2,
    	    area: ['800px', '300px'],
    	    offset: [100,(($(window).width()-800)/2)],
    	    title: '增加短信人员',
    	    content: ['<%=request.getContextPath()%>/admin/full/addFullSmsPage','no']
    	});
    }
    
    function edit(id){
    	layer.open({
    	    type: 2,
    	    area: ['800px', '400px'],
    	    offset: [100,(($(window).width()-800)/2)],
    	    title: '修改短信人员',
    	    content: ['<%=request.getContextPath()%>/admin/full/editFullSmsPage?id=' + id,'no']
    	});
    }
    
    function deletePicUrl(id){
    	//询问框
    	layer.confirm('是否确定此操作？', {
    	  btn: ['确定','取消'] //按钮
    	}, function(){
    		$.ajax({
  		      url: '<%=request.getContextPath()%>/admin/full/deleteFullSms',
		
											dataType : 'json',
											type : 'POST',
											data : {
												id : id
											},
											success : function(data) {
												if (data.status == 'ok') {
													layer.alert('删除成功', {
														icon : 6
													});
													search(parseInt($('.active')
															.attr('jp-data')));
												} else {
													layer.alert(data.msg, {
														icon : 5
													});
												}
											},
											error : function() {
												layer.alert('系统错误', {
													icon : 5
												});
											}
										});
							}, function() {

							});
		}

		function showPic(url) {
			layer.photos({
				photos : {
					"data" : [ {
						"src" : url
					} ]
				}
			});
		}
	</script>
</body>
</html>