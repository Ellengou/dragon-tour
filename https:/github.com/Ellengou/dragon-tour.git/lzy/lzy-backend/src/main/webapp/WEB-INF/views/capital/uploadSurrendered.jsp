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
										<div class="col-xs-12">
											<div class="input-group">
										   		<span class="input-group-addon">选择文件</span> 
												<input type="file" class="form-control" id="file_name" name="file_name">
											</div>
										</div>
									</div>
								</form>
								<hr>
								<div class="row" align="center">
									<div class="col-xs-12">
										<button type="button" class="btn btn-primary" onclick="submit();">确定</button>
										
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
	<script src="<%=request.getContextPath()%>/bootstrap/plugin/ajaxfileupload/ajaxfileupload.js" type="text/javascript"></script>
	<script>

		var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
		//关闭窗口并刷新页面
		function closePage(){
			parent.layer.close(index);
		}
		
		function submit(){
			$.ajaxFileUpload({
				url : '<%=request.getContextPath()%>/admin/bankCard/uploadSurrendered',
				secureuri:false,
		        method : 'POST',  
		        fileElementId:'file_name',
		        dataType: 'json',
				error: function (data, status, e) {
					layer.alert("远程读取数据失败", {icon: 6});
				},
				success: function (data, status) {
					if(data.status == 'ok'){
						parent.search(parseInt(parent.$('.active').attr('jp-data')));
			    		closePage();
			    	}else{
			    		layer.alert(data.msg, {icon : 5});
			    	}
		         }
			});
		}
	</script>
</body>
</html>