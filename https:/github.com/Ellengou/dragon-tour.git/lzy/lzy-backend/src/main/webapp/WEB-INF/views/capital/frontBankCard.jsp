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
	<shiro:hasPermission name="bankCard:abcSign">
	    <input id="p_abcSign" style="display: none" value="1">
	</shiro:hasPermission>
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-body">
					<div class="row">
						<div class="col-lg-12">
							<form id="myForm" action="<%=request.getContextPath()%>/admin/recharge/rechargeExport" method="GET" target="_blank">
								<div class="row">
									<div class="col-xs-2">
										<div class="input-group">
											<span class="input-group-addon">银行卡号</span>
											<input type="text" class="form-control" id="bankNo" name="bankNo">
										</div>
									</div>
									<div class="col-xs-2">
										<div class="input-group">
											<span class="input-group-addon">姓名</span>
											<input type="text" class="form-control" id="name" name="name">
										</div>
									</div>
									<div class="col-xs-2">
										<div class="input-group">
											<span class="input-group-addon">签约状态</span>
											<select class="form-control" id="signStatus" name="signStatus">
												<option value="">全部</option>
                                            </select>
										</div>
									</div>
									<div class="col-xs-2">
										<div class="input-group">
											<span class="input-group-addon">激活状态</span>
											<select class="form-control" id="activateStatus" name="activateStatus">
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
					<shiro:hasPermission name="bankCard:applySurrenderExport">
						<button type="button" class="btn btn-primary" onclick="exportApplySurrender();">导出申请解约银行卡</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="bankCard:applySignExport">
						<button type="button" class="btn btn-primary" onclick="exportApplySign();">导出申请签约银行卡</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="bankCard:uploadSurrendered">
						<button type="button" class="btn btn-primary" onclick="uploadSurrendered();">上传已解约银行卡</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="bankCard:uploadSigned">
						<button type="button" class="btn btn-primary" onclick="uploadSigned();">上传已签约银行卡</button>
					</shiro:hasPermission>
				</div>
				<div class="panel-body">
					<div class="table-responsive">
						<table id="myTable"
							class="table table-striped table-bordered table-hover"
							data-url="<%=request.getContextPath()%>/admin/bankCard/queryFrontBankCards"
							data-pageSize="10,50,100" data-method="POST">
							<thead>
								<tr>
									<th width="5%" data-field="id">ID</th>
									<th width="10%" data-field="name">姓名</th>
									<th width="5%" data-field="userType" data-call="true">类型</th>
									<th width="10%" data-field="bankName">银行名称</th>
									<th width="15%" data-field="openName">开户行</th>
									<th width="20%" data-field="bankNo">银行卡号</th>
									<th width="5%" data-field="status" data-call="true">状态</th>
									<th width="7%" data-field="signStatus" data-call="true">签约状态</th>
									<th width="8%" data-field="activateStatus" data-call="true">激活状态</th>
									<th width="5%" data-field="isSalary" data-call="true">工资卡</th>
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
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/jqPaginator.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/jqPaginator/myPage.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/utils.js"></script>
    
	<script type="text/javascript">
	
	$(function(){
		var bankCardActivateStatusList = $.parseJSON('${bankCardActivateStatusList}');
		for (var i = 0; i < bankCardActivateStatusList.length; i++) {
			$(new Option(bankCardActivateStatusList[i].dicDataName,bankCardActivateStatusList[i].dicDataValue)).appendTo('#activateStatus');
		}
		
		var signStatusList = $.parseJSON('${signStatusList}');
		for (var i = 0; i < signStatusList.length; i++) {
			$(new Option(signStatusList[i].dicDataName,signStatusList[i].dicDataValue)).appendTo('#signStatus');
		}
	});
	
	function tableCallBack(data,id){
    	if(id == 'status'){
    		var bankCardStatusList = ${bankCardStatusList};
    		for (var i = 0; i < bankCardStatusList.length; i++) {
    			if(data[id] == bankCardStatusList[i].dicDataValue){
    				return bankCardStatusList[i].dicDataName;
    				break;
    			}
			}
    		return data[id];
    	}else if(id == 'isSalary'){
    		if(data[id] == '0'){
				return '否';
			}else if(data[id] == '1'){
				return '是';
			}else{
				return data[id];
			}
    	}else if(id == 'signStatus'){
    		if(data.payClass == 'AbcPay'){
    			if(data.signStatus == '0'){
    				return '';
    			}
    			var signStatusList = ${signStatusList};
        		for (var i = 0; i < signStatusList.length; i++) {
        			if(data[id] == signStatusList[i].dicDataValue){
        				return signStatusList[i].dicDataName;
        				break;
        			}
    			}
        		return '';
    		}else{
    			return '';
    		}	
    	}else if(id == 'activateStatus'){
    		if(data.activateStatus == '' || data.activateStatus == null){
    			return '';
    		}else{
    			var bankCardActivateStatusList = ${bankCardActivateStatusList};
        		for (var i = 0; i < bankCardActivateStatusList.length; i++) {
        			if(data[id] == bankCardActivateStatusList[i].dicDataValue){
        				return bankCardActivateStatusList[i].dicDataName;
        				break;
        			}
    			}
        		return '';
    		}
    	}else if(id == 'userType'){
    		if(data[id] == null || data[id] == ''){
    			return '';
    		}
    		var scfRoleTypeList = ${scfRoleTypeList};
    		for (var i = 0; i < scfRoleTypeList.length; i++) {
    			if(data[id] == scfRoleTypeList[i].dicDataValue){
    				return scfRoleTypeList[i].dicDataName;
    				break;
    			}
			}
    		return data[id];
    	}else if(id == 'button'){
    		if($('#p_abcSign').val() == 1){
    			if(data.payClass == 'AbcPay'){
    				if(data.compType != '1'){
    					if(data.status == '0'){
    						if(data.signStatus == '1' || data.signStatus == '3'){
    							return '<button type="button" class="btn btn-primary btn-xs" onclick="getSign(\'' + data.id + '\',\'' + data.userId + '\');">查询签约</button> ';
    						}
    					}
    				}
        		}
    		}
    		return '';
    	}else{
    		if(data[id] == null || data[id] == ''){
    			return '';
    		}else{
    			return data[id];
    		}
    	}
	}
	
	function getSign(id,frontUserId){
		$.ajax({
		      url: '<%=request.getContextPath()%>/admin/bankCard/getAbcSign',
		      dataType: 'json',
		      type: 'POST',
		      data: {
		    	  bankCardId: id,
		    	  frontUserId: frontUserId
		      },
		      success: function (data) {
		    	if(data.status == 'ok'){
		    		layer.alert('成功', {icon : 6});
		    		search(parseInt($('.active').attr('jp-data')));
		    	}else{
		    		layer.alert(data.msg, {
						icon : 5
					});
		    	}
		      },
		      error: function(){
		    	  layer.alert('系统错误', {
						icon : 5
					});
		      }
		  });
	}
	
	//导出申请解约
	function exportApplySurrender(){
		window.open("<%=request.getContextPath()%>/admin/bankCard/applySurrenderExport");
	}
	
	//导出申请签约
	function exportApplySign(){
		window.open("<%=request.getContextPath()%>/admin/bankCard/applySignExport");
	}
	
	//上传已解约
	function uploadSurrendered(){
		layer.open({
    	    type: 2,
    	    area: ['400px', '300px'],
    	    offset: [100,(($(window).width()-400)/2)],
    	    title: '上传已解约页面',
    	    content: ['<%=request.getContextPath()%>/admin/bankCard/uploadSurrenderedPage','no']
    	});
	}
	
	//上传已签约
	function uploadSigned(){
		layer.open({
    	    type: 2,
    	    area: ['400px', '300px'],
    	    offset: [100,(($(window).width()-400)/2)],
    	    title: '上传已签约页面',
    	    content: ['<%=request.getContextPath()%>/admin/bankCard/uploadSignedPage','no']
    	});
	}
	</script>
</body>
</html>