<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台管理系统</title>
<!-- Bootstrap Core CSS -->
<link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<style>
    .placeholder {
        font-size: 11px;
        color: #aeaeae;
    }
</style>
</head>
<body>
	<div id="page-wrapper" style="padding: 0 15px;">
		<div class="row">
			<div class="col-lg-12">
				<br>
				<div class="panel panel-info">
					<div class="panel-heading">
						<h2 class="text-center">${content.title }</h2>
					</div>
					<div class="panel-body">
						<div>
							${content.content }
						</div>
					</div>
				</div>
				<div align="center">
					<button type="button" class="btn btn-primary" onclick="closePage();">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<script src="<%=request.getContextPath()%>/bootstrap/js/jquery.min.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<!-- layer JavaScript -->
	<script src="<%=request.getContextPath()%>/bootstrap/plugin/layer/layer.js" type="text/javascript"></script>
	<script>
	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	//关闭窗口并刷新页面
	function closePage() {
		parent.layer.close(index);
	}
	</script>
</body>