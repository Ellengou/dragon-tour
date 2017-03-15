<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台管理系统</title>
<!-- Bootstrap Core CSS -->
<link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<div id="page-wrapper" style="padding: 0 15px;">
		<div class="row">
			<div class="col-lg-12">
				<br>
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-12">
								<form id="myForm">
									<div class="row">
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">机构名称</span> 
												<input type="text" class="form-control" id="compName" value="${company.compName}" disabled="disabled">
											</div>
										</div>
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">机构法人代表</span> 
												<input type="text" class="form-control" id="lealPerson" value="${company.lealPerson}" disabled="disabled">
											</div>
										</div>
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">机构邮箱</span> 
												<input type="text" class="form-control" id="compEmail" value="${company.compEmail}" disabled="disabled">
											</div>
										</div>
									</div>
									<br>
									<div class="row">
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">机构传真</span> 
												<input type="text" class="form-control" id="compFax" value="${company.compFax}" disabled="disabled">
											</div>
										</div>
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">机构座机</span> 
												<input type="text" class="form-control" id="compTel" value="${company.compTel}" disabled="disabled">
											</div>
										</div>
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">联系人</span> 
												<input type="text" class="form-control" id="contPerson" value="${company.contPerson}" disabled="disabled">
											</div>
										</div>
									</div>
									<br>
									<div class="row">
										
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">联系人手机</span> 
												<input type="text" class="form-control" id="contPhone" value="${company.contPhone}" disabled="disabled">
											</div>
										</div>
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">联系人座机</span> 
												<input type="text" class="form-control" id="contTel" value="${company.contTel}" disabled="disabled">
											</div>
										</div>
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">联系人职务</span> 
												<input type="text" class="form-control" id="contPosition" value="${company.contPosition}" disabled="disabled">
											</div>
										</div>
									</div>
									<br>
									<div class="row">
										<div class="col-xs-12">
											<div class="input-group">
												<span class="input-group-addon">机构地址</span> 
												<input type="text" class="form-control" id="compAddress" value="${company.compAddress}" disabled="disabled">
											</div>
										</div>
									</div>
								</form>
								<hr>
								<div class="row" align="center">
									<div class="col-xs-12">
										<button type="button" class="btn btn-primary" onclick="submit('1');">审核通过</button>
										<button type="button" class="btn btn-primary" onclick="submit('2');">审核不通过</button>
										<button type="button" class="btn btn-primary" onclick="closePage();">关闭</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="<%=request.getContextPath()%>/bootstrap/js/jquery.min.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<!-- layer JavaScript -->
	<script src="<%=request.getContextPath()%>/bootstrap/plugin/layer/layer.js" type="text/javascript"></script>
	<script>
		$(document).ready(function() {
	    });
		
		var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
		//关闭窗口并刷新页面
		function closePage() {
			parent.layer.close(index);
		}
		function submit(ischeck) {
			var jsonData = {};
			jsonData.id = '${company.id}';
			jsonData.ischeck = ischeck;
			layer.load(2);
			$.ajax({
			      url: '<%=request.getContextPath()%>/admin/company/checkOrg',
			      dataType: 'json',
			      type: 'POST',
			      data: jsonData,
			      success: function (data) {
			    	layer.closeAll('loading');
			    	if(data.status == 'ok'){
			    		//询问框
    			    	layer.confirm('成功', {
    			    	  btn: ['确定'] //按钮
    			    	}, function(){
    			    		parent.search(parseInt(parent.$('.active').attr('jp-data')));
    			    		closePage();
    			    	});
			    	}else{
			    		layer.alert(data.msg, {
							icon : 5
						});
			    	}
			      },
			      error: function(){
			    	  layer.closeAll('loading');
			    	  layer.alert('系统错误', {icon : 5});
			      }
			  });
		}
	</script>
</body>
</html>