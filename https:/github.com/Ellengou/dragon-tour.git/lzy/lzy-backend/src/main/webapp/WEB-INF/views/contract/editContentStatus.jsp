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
										<div class="col-xs-6">
										   <label class="checkbox-inline">
										      <input type="radio" name="status" id="status1" value="0" > 草稿
										   </label>
										</div>
										<div class="col-xs-6">
											<label class="checkbox-inline">
										      <input type="radio" name="status" id="status2" value="1" > 正式发布
										   </label>
										</div>
									</div>
									<br>
									<div class="row">
										<div class="col-xs-6">
										   <label class="checkbox-inline">
										      <input type="radio" name="shelf" id="shelf1" value="0" > 上架
										   </label>
										</div>
										<div class="col-xs-6">
											<label class="checkbox-inline">
										      <input type="radio" name="shelf" id="shelf2" value="1" > 下架
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
			}
			
			if('${shelf}' == '0'){
				$("#shelf1").attr("checked",'checked');
			}else if('${shelf}' == '1'){
				$("#shelf2").attr("checked",'checked');
			}
		});
	
		var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
		//关闭窗口并刷新页面
		function closePage(){
			parent.layer.close(index);
		}
		
		function submit(){
			$.ajax({
		      url: '<%=request.getContextPath()%>/admin/contractContent/editContentStatus',
		      dataType: 'json',
		      type: 'get',
		      data: {
		    	  id:$('#id').val(),
		    	  status:$("input[name='status']:checked").val(),
		    	  shelf:$("input[name='shelf']:checked").val()
		      },
		      success: function (data) {
		    	if(data.status == 'ok'){
		    		parent.search(parseInt(parent.$('.active').attr('jp-data')));
		    		closePage();
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
	</script>
</body>
</html>