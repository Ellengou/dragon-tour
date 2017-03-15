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
										   <label class="checkbox-inline">
										      <input type="radio" name="status" id="status1" value="0" > 正常
										   </label>
										</div>
										<div class="col-xs-4">
											<label class="checkbox-inline">
										      <input type="radio" name="status" id="status2" value="1" > 登录锁定
										   </label>
										</div>
										<div class="col-xs-4">
											<label class="checkbox-inline">
										      <input type="radio" name="status" id="status3" value="2" > 系统锁定
										   </label>
										</div>
									</div>
								</form>
								<hr>
								<div class="row" align="center">
									<div class="col-xs-12">
										<input type="hidden" id="id" value="${id}">
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
	<script>
		$(function(){
			if('${status}' == '0'){
				$("#status1").attr("checked",'checked');
			}else if('${status}' == '1'){
				$("#status2").attr("checked",'checked');
			}else if('${status}' == '2'){
				$("#status3").attr("checked",'checked');
			}
		});
	
		var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
		//关闭窗口并刷新页面
		function closePage(){
			parent.layer.close(index);
		}
		
		function submit(){
			if('${type}' == '0'){
				var url = '<%=request.getContextPath()%>/admin/userFront/editEmployeeStatus';
			}else if('${type}' == '1'){
				var url = '<%=request.getContextPath()%>/admin/userFront/editTouristStatus';
			}else if('${type}' == '2'){
				var url = '<%=request.getContextPath()%>/admin/userFront/editSupplierStatus';
			}else if('${type}' == '3'){
				var url = '<%=request.getContextPath()%>/admin/userFront/editDealerStatus';
			}else{
				var url = '<%=request.getContextPath()%>/admin/userFront/editSupplierAndDealerStatus';
			}
			layer.load(2);
			$.ajax({
		      url: url,
		      dataType: 'json',
		      type: 'POST',
		      data: {
		    	  id:$('#id').val(),
		    	  status:$("input[type='radio']:checked").val()
		      },
		      success: function (data) {
		    	layer.closeAll('loading');
		    	if(data.status == 'ok'){
		    		parent.search(parseInt(parent.$('.active').attr('jp-data')));
		    		closePage();
		    	}else{
		    		layer.alert(data.msg, {icon : 5});
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