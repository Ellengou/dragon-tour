<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
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
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-12">
								<form id="myForm" class="form-horizontal">
									<div class="form-group">
										<label class="col-xs-2" for = "des">内容:</label>
										<div class="col-xs-10">
											<input type="text" class= "form-control" name="des" id="des" value="${des.des}">
										</div>
									</div>
									<hr>
									<div class="form-group">
										<label class="col-xs-2">状态:</label>
										<div class="col-xs-10">
											<div class="radio-inline">
												<label>
													<input type="radio" name="status" value="0" checked="checked">启用
												</label>
											</div>
											<div class="radio-inline">
												<label>
													<input type="radio" name="status" value="1">禁用
												</label>
											</div>
										</div>
									</div>
								</form>
								<hr>
								<div class="row" align="center">
									<div class="col-xs-12">
										<button type="button" class="btn btn-primary" onclick="save();">保存</button>
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
	$(document).ready(function(){
    })
    
    function save(){
		var jsonData = $("#myForm").serializeArray();
		$.ajax({
		      url: '<%=request.getContextPath()%>/admin/userloandes/save_add',
		      dataType: 'json',
		      type: 'POST',
		      data: jsonData,
		      success: function (data) {
		    	 if(data.status == 'ok'){
		    		 layer.alert('保存成功', {
	                        icon: 1,
	                        offset:50
	                  },function(index){
	                	  var parIndex = parent.layer.getFrameIndex(window.name);
	                	  layer.close(index);
	                	  parent.location.reload();
	                	  parent.layer.close(parIndex);
	                  });
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
    
    var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	//关闭窗口并刷新页面
	function closePage() {
		parent.layer.close(index);
	}
	</script>
</body>
</html>