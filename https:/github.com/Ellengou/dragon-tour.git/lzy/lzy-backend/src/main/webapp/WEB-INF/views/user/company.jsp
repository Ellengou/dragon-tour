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
	<shiro:hasPermission name="company:edit">
	    <input id="p_edit" style="display: none" value="1">
	</shiro:hasPermission>
	<shiro:hasPermission name="company:status">
	    <input id="p_status" style="display: none" value="1">
	</shiro:hasPermission>
	<shiro:hasPermission name="company:check">
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
											<span class="input-group-addon">企业名称</span>
											<input type="text" class="form-control" id="compName">
										</div>
									</div>
									<div class="col-xs-2">
										<div class="input-group">
                                        <span class="input-group-addon">审核状态</span>
                                        <select class="form-control" id="ischeck">
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
				<shiro:hasPermission name="company:add">
					<div class="panel-heading">
						<button type="button" class="btn btn-primary" onclick="add();">新增</button>
					</div>
				</shiro:hasPermission>
				<div class="panel-body">
					<div class="table-responsive">
						<table id="myTable"
							class="table table-striped table-bordered table-hover"
							data-url="<%=request.getContextPath()%>/admin/company/queryCompanys"
							data-pageSize="10,50,100" data-method="POST">
							<thead>
								<tr>
									<th data-field="id">ID</th>
									<th data-field="compName">企业名称</th>
									<th data-field="compEmail">公司邮箱</th>
									<th data-field="contPerson">联系人</th>
									<th data-field="contPhone">联系人手机</th>
									<th data-field="contTel">联系人座机</th>
									<th data-field="ischeck" data-call="true">审核状态</th>
									<th data-field="enabled" data-call="true">状态</th>
									<th data-field="moneySource" data-call="true">贷款资金来源</th>
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
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/jqPaginator.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/myPage.js"></script>
    
	<script type="text/javascript">
	
	$(document).ready(function() {
        var verifyStatusList = $.parseJSON('${verifyStatusList}');
		for (var i = 0; i < verifyStatusList.length; i++) {
			$(new Option(verifyStatusList[i].dicDataName,verifyStatusList[i].dicDataValue)).appendTo('#ischeck');
		}
	});
	
	function tableCallBack(data,id){
    	if(id == 'ischeck'){
    		var verifyStatusList = ${verifyStatusList};
    		for (var i = 0; i < verifyStatusList.length; i++) {
    			if(data[id] == verifyStatusList[i].dicDataValue){
    				return verifyStatusList[i].dicDataName;
    				break;
    			}
			}
    		return data[id];
    	}else if(id == 'enabled'){
    		var enabledStatusList = ${enabledStatusList};
    		for (var i = 0; i < enabledStatusList.length; i++) {
    			if(data[id] == enabledStatusList[i].dicDataValue){
    				return enabledStatusList[i].dicDataName;
    				break;
    			}
			}
    		return data[id];
    	}else if(id == 'button'){
    		if($('#p_edit').val() == 1){
    			var str = '<button type="button" class="btn btn-primary btn-xs" onclick="edit(\'' + data.id + '\');">编辑</button> ';
    		}
    		
    		if($('#p_check').val() == 1){
	    		if(data.ischeck != '1'){
	    			str = str + '<button type="button" class="btn btn-warning btn-xs" onclick="check(\'' + data.id + '\',\''+data.source+'\');">审核</button>';
	    		}
    		}
    		if($('#p_status').val() == 1){
	    		if(data.enabled == '0'){
	    			str = str + ' <button type="button" class="btn btn-warning btn-xs" onclick="editStatus(\'' + data.id + '\',\'1\');">禁用</button>';
	    		}else{
	    			str = str + ' <button type="button" class="btn btn-warning btn-xs" onclick="editStatus(\'' + data.id + '\',\'0\');">启用</button>';
	    		}
    		}
    		return str;
    	}else if(id == 'moneySource'){
    		if(data.ischeck == '1'){
	    		var str = '';
	    		str = str + ' <button type="button" class="btn btn-warning btn-xs" onclick="viewMoneySource(\'' + data.id + '\');">查看</button>';
	    		return str;
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
	function viewMoneySource(id){
		var index = layer.open({
    	    type: 2,
    	    title: false,
    	    content: '<%=request.getContextPath()%>/moneysource/viewMoneySourcePage?compCoreId='+id
    	});
		layer.full(index);
	}
	function add(){
    	layer.open({
    	    type: 2,
    	    area: ['900px', '600px'],
    	    offset: [100,(($(window).width()-900)/2)],
    	    title: '添加核心企业',
    	    content: ['<%=request.getContextPath()%>/admin/company/addCompanyPage','yes']
    	});
    }
    
    function edit(id){
    	layer.open({
    	    type: 2,
    	    area: ['900px', '600px'],
    	    offset: [100,(($(window).width()-900)/2)],
    	    title: '修改核心企业',
    	    content: ['<%=request.getContextPath()%>/admin/company/editCompanyPage?id=' + id,'yes']
    	});
    }
    
    function editStatus(id,enabled){
    	//询问框
    	layer.confirm('是否确定此操作？', {
    	  btn: ['确定','取消'] //按钮
    	}, function(){
    		$.ajax({
  		      url: '<%=request.getContextPath()%>/admin/company/editCompanyStatus',
  		      dataType: 'json',
  		      type: 'POST',
  		      data: {
  		    	  id:id,
  		    	enabled:enabled
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
    
    function check(id,source){
    	if('1' == source){
    		var index = layer.open({
	    	    type: 2,
	    	    area: ['900px', '600px'],
	    	    offset: [100,(($(window).width()-900)/2)],
	    	    title: false,
	    	    content: '<%=request.getContextPath()%>/admin/company/checkCompanyFrontPage?id=' + id
	    	});
    		layer.full(index);
    	}else{
	    	layer.open({
	    	    type: 2,
	    	    area: ['900px', '600px'],
	    	    offset: [100,(($(window).width()-900)/2)],
	    	    title: '审核核心企业',
	    	    content: ['<%=request.getContextPath()%>/admin/company/checkCompanyPage?id=' + id,'no']
	    	});
    	}
    }
	</script>
</body>
</html>