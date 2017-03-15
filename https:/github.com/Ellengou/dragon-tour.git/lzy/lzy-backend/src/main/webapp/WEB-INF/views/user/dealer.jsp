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
	<shiro:hasPermission name="user:dealer:edit">
	    <input id="p_edit" style="display: none" value="1">
	</shiro:hasPermission>
	<shiro:hasPermission name="user:dealer:status">
	    <input id="p_status" style="display: none" value="1">
	</shiro:hasPermission>
	<shiro:hasPermission name="user:dealer:check">
	    <input id="p_check" style="display: none" value="1">
	</shiro:hasPermission>
	<shiro:hasPermission name="subCompany:relationDealerQuery">
	    <input id="p_relation" style="display: none" value="1">
	</shiro:hasPermission>
	<shiro:hasPermission name="user:dealer:relation">
	    <input id="r_relation" style="display: none" value="1">
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
											<input type="text" class="form-control" id="nickName">
										</div>
									</div>
									<div class="col-xs-2">
										<div class="input-group">
											<span class="input-group-addon">手机</span>
											<input type="text" class="form-control" id="phone">
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
					<a class="btn btn-primary" href="<%=request.getContextPath()%>/template/经销商.xls" target="_self">经销商模板下载</a> 
					<a class="btn btn-primary" href="<%=request.getContextPath()%>/template/经销商关联关系.xls" target="_self">关联关系模板下载</a> 
					<shiro:hasPermission name="	user:dealer:add">
						<button type="button" class="btn btn-primary" onclick="add();">新增</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="user:dealer:upload">
						<button type="button" class="btn btn-primary" onclick="uploadFile();">导入</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="user:dealer:export">
						<button type="button" class="btn btn-primary" onclick="exportAll();">导出</button>
					</shiro:hasPermission>
				</div>
				<div class="panel-body">
					<div class="table-responsive">
						<table id="myTable"
							class="table table-striped table-bordered table-hover"
							data-url="<%=request.getContextPath()%>/admin/userFront/queryDealers"
							data-pageSize="10,50,100" data-method="POST">
							<thead>
								<tr>
									<th width="20px" data-type="checkbox" data-field="id"></th>
									<%--<th  data-field="id">ID</th>--%>
									<th  data-field="suppName">名称</th>
									<th  data-field="phone">手机</th>
									<th  data-field="agentPerson">代理人姓名</th>
									<th  data-field="agentPhone">代理人手机</th>
									<th  data-field="merchantNumber">NC客商编号</th>
									<th  data-field="operateTime" data-call="true">注册时间</th>
									<th  data-field="verifyStatus" data-call="true">审核状态</th>
									<th  data-field="status" data-call="true">状态</th>
									<th  data-field="enabled" data-call="true">关联状态</th>
									<th  data-field="button" data-call="true">操作</th>
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
    	}else if(id == 'status'){
    		var userStatusList = ${userStatusList};
			for (var i = 0; i < userStatusList.length; i++) {
				if(data[id] == userStatusList[i].dicDataValue){
    				return userStatusList[i].dicDataName;
    				break;
    			}
			}
    		return data[id];
    	}else if(id == 'enabled'){
    		var name ='';
    		if(data.enabled == '0'){
				name = '已关联';
			}else{
				name = '未关联';
			}
    		return name;
    	}else if(id == 'button'){
        	var str = '';
        	if($('#p_edit').val() == 1){
        		str = str + '<button type="button" class="btn btn-primary btn-xs" onclick="edit(\'' + data.id + '\');">编辑</button> ';
        	}
        	
        	if($('#p_status').val() == 1){
        		str = str + '<button type="button" class="btn btn-warning btn-xs" onclick="editStatus(\'' + data.id + '\',\'' + data.status + '\',\'3\');">修改状态</button> ';
        	}
        	
        	if($('#p_check').val() == 1){
	    		if(data.verifyStatus != '1'){
	    			str = str + '<button type="button" class="btn btn-warning btn-xs" onclick="check(\'' + data.infoId + '\',\'' + data.id + '\');">审核</button> ';
	    		}
        	}
        	
        	if($('#p_relation').val() == 1){
        		if(data.verifyStatus == '1'){
        			str = str + '<button type="button" class="btn btn-warning btn-xs" onclick="relationCompany(\'' + data.id + '\');">关联公司</button>';
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
    	    title: '添加经销商',
    	    content: ['<%=request.getContextPath()%>/admin/userFront/addDealerPage','yes']
    	});
    	layer.full(index);
    }
    
	function edit(id){
		var index = layer.open({
    	    type: 2,
    	    area: ['900px', '500px'],
    	    offset: [100,(($(window).width()-900)/2)],
    	    title: '修改经销商信息',
    	    content: ['<%=request.getContextPath()%>/admin/userFront/editDealerPage?id=' + id,'yes']
    	});
    	layer.full(index);
    }
    
    function editStatus(id,status,type){
    	layer.open({
    	    type: 2,
    	    area: ['500px', '300px'],
    	    offset: [100,(($(window).width()-500)/2)],
    	    title: '修改经销商状态',
    	    content: ['<%=request.getContextPath()%>/admin/userFront/editUserFrontStatusPage?id=' + id + '&status=' + status + '&type=' + type,'no']
    	});
    }
    
    function check(id,frontUserId){
		var index = layer.open({
    	    type: 2,
    	    area: ['900px', '500px'],
    	    offset: [100,(($(window).width()-900)/2)],
    	    title: '审核经销商',
    	    content: ['<%=request.getContextPath()%>/admin/userFront/checkDealerPage?id=' + id + '&frontUserId=' + frontUserId,'yes']
    	});
    	layer.full(index);
    }
    
    function uploadFile(){
    	layer.open({
    	    type: 2,
    	    area: ['500px', '300px'],
    	    offset: [100,(($(window).width()-500)/2)],
    	    title: '导入经销商',
    	    content: ['<%=request.getContextPath()%>/admin/userFront/uploadFilePage?type=1','no']
    	});
    }
    
    <%-- function relationSubCompany(id){
    	var index = layer.open({
    	    type: 2,
    	    area: ['900px', '500px'],
    	    offset: [100,(($(window).width()-900)/2)],
    	    title: '关联子公司页面',
    	    content: ['<%=request.getContextPath()%>/admin/company/relationDealerToSubCompPage?id=' + id,'no']
    	});
    	layer.full(index);
    } --%>
    function relationCompany(id){
    	var index = layer.open({
    	    type: 2,
    	    area: ['900px', '500px'],
    	    offset: [100,(($(window).width()-900)/2)],
    	    title: '关联公司',
    	    content: ['<%=request.getContextPath()%>/admin/company/relationDealerToCompPage?id=' + id,'no']
    	});
    	layer.full(index);
    }
    function exportAll(){
		var chk_value =[];
		$("#tbodyId").find("input").each(function() {
			if($(this).attr('type') == 'checkbox' && $(this).is(':checked')){
				chk_value.push($(this).val());
			}
		});

		if(chk_value.join(",") == null || chk_value.join(",") == ''){
			window.open("<%=request.getContextPath()%>/admin/userFront/dealerExport");
			return;
		} else {
			window.open("<%=request.getContextPath()%>/admin/userFront/dealerExport?ids=" + chk_value.join(","));
			return;
		}
	}
    
    function relation(suppId,relationStatus){
    	//询问框
    	var ts = '';
    	if(relationStatus == '1'){
    		ts = '是否取消关联企业？'
    	}else{
    		ts = '是否关联企业？'
    	}
    	layer.confirm(ts, {
    	  btn: ['确定','取消'] //按钮
    	}, function(){
    		$.ajax({
  		      url: '<%=request.getContextPath()%>/admin/userFront/relationDealer',
  		      dataType: 'json',
  		      type: 'POST',
  		      data: {
  		    	suppId: suppId,
  		    	relationStatus: relationStatus
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