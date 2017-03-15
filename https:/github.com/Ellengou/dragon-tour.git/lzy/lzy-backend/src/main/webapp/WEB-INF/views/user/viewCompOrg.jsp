<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台管理系统</title>
<!-- Bootstrap Core CSS -->
<link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!-- validator -->
<link href="<%=request.getContextPath()%>/bootstrap/plugin/validator/popover.css" rel="stylesheet">
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
									<br>
									<input type="hidden" id="id" value="${compOrg.id}">
									<div class="row">
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">部门名称</span> 
												<input type="text" class="form-control" id="name" name="name" value="${compOrg.name}" disabled="disabled">
											</div>
										</div>
										<!--
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">负责人</span> 
												<input type="text" class="form-control" id="principal" name="principal" value="${compOrg.principal}" disabled="disabled">
											</div>
										</div>
										-->
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">部门电话</span> 
												<input type="text" class="form-control" id="tel" name="tel" value="${compOrg.tel}" disabled="disabled">
											</div>
										</div>
									</div>
									<hr>
									<div class="row" align="center">
										<div class="col-xs-12">
											<button type="button" class="btn btn-primary" onclick="closePage();">关闭</button>
										</div>
									</div>
								</form>
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
	<!-- validate -->
	<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/validator/ga.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/validator/jquery.validate.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/plugin/validator/jquery.validate.bootstrap.popover.js"></script>
	<script>
		
		var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
		//关闭窗口并刷新页面
		function closePage() {
			parent.layer.close(index);
		}
	</script>
</body>
</html>