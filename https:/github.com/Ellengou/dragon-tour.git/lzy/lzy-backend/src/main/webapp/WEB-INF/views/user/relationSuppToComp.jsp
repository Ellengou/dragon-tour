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
		<shiro:hasPermission name="subCompany:relationSupplier">
			<input id="p_relation" style="display: none" value="1">
		</shiro:hasPermission>
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-body">
					<div class="row">
						<div class="col-lg-12">
							<form id="myForm">
								<div class="row">
									<div class="col-xs-4">
										<div class="input-group">
											<span class="input-group-addon">供应商</span>
											<input type="hidden" class="form-control" id="frontUserId" value="${frontUserId}">
											<input type="text" class="form-control" id="frontUserName" value="${frontUserName}" disabled="disabled">
										</div>
									</div>
									<div class="col-xs-4">
										<div class="input-group">
											<span class="input-group-addon">公司名称</span>
											<input type="text" class="form-control" id="compName">
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

				<div class="panel-body">
					<div class="table-responsive">
						<table id="myTable"
							class="table table-striped table-bordered table-hover"
							data-url="<%=request.getContextPath()%>/admin/company/queryRelationSupplierCompanys"
							data-pageSize="10,50,100" data-method="POST">
							<thead>
								<tr>
									<th width="10%" data-field="id">ID</th>
									<th width="15%" data-field="compName">公司名称</th>
									<th width="15%" data-field="suppEnabled" data-call="true">关联状态</th>
									<th width="15%" data-field="button" data-call="true">操作</th>
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
					
					<div class="row" align="center">
						<div class="col-xs-12">
							<button type="button" class="btn btn-primary" onclick="closePage();">关闭</button>
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
	function tableCallBack(data,id){
		if(id == 'suppEnabled'){
    		var relationStatusList = ${relationStatusList};
			for (var i = 0; i < relationStatusList.length; i++) {
				if(data[id] == relationStatusList[i].dicDataValue){
    				return relationStatusList[i].dicDataName;
    			}
			}
    		return '';
    	}else if(id == 'button'){
    		var str = '';
    		if($('#p_relation').val() == 1){
    			if(data.suppEnabled == '0'){
	       			str = str + ' <button type="button" class="btn btn-warning btn-xs" onclick="unRelation(\'' + data.suppId + '\',\'1\');">取消关联</button>';
    			}else{
	       			str = str + ' <button type="button" class="btn btn-warning btn-xs" onclick="relation(\'' + data.suppId + '\',\'1\');">关联</button>';
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
	
	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	//关闭窗口并刷新页面
	function closePage() {
		parent.layer.close(index);
	}
	
	function relation(suppId){
    	//询问框
    	layer.confirm('是否确定此操作？', {
    	  btn: ['确定','取消'] //按钮
    	}, function(){
    		$.ajax({
  		      url: '<%=request.getContextPath()%>/admin/company/saveRelation',
  		      dataType: 'json',
  		      type: 'POST',
  		      data: {
  		    	  suppId : suppId,
  		      },
  		      success: function (data) {
  		    	if(data.status == 'ok'){
  		    		layer.alert('关联成功', {icon : 1});
  		    		search(parseInt(parent.$('.active').attr('jp-data')));
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
	
    function unRelation(suppId){
    	//询问框
    	layer.confirm('是否确定此操作？', {
    	  btn: ['确定','取消'] //按钮
    	}, function(){
    		$.ajax({
  		      url: '<%=request.getContextPath()%>/admin/company/oplogUnRelationCompanyToSupplier',
  		      dataType: 'json',
  		      type: 'POST',
  		      data: {
  		    	  suppId : suppId,
  		      },
  		      success: function (data) {
  		    	if(data.status == 'ok'){
  		    		layer.alert('取消关联成功', {icon : 1});
  		    		search(parseInt(parent.$('.active').attr('jp-data')));
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