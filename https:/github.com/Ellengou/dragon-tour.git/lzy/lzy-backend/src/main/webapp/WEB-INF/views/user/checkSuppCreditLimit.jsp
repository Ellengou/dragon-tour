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
									<input type="hidden" id="id" value="${id}">
									<br>
									<div class="row">
									<div class="col-xs-6">
									   <label class="checkbox-inline">
									      <input type="radio" name="verifyStatus" id="verifyStatus1" value="1" checked="checked"> 通过
									   </label>
									</div>
									<div class="col-xs-6">
										<label class="checkbox-inline">
									      <input type="radio" name="verifyStatus" id="verifyStatus2" value="2" > 不通过
									   </label>
									</div>
								</div>
								<br>
								<div class="row">
									<div class="col-xs-12">
										<div class="input-group">
											<label class="input-group-addon">审核信息</label>
                                           	<textarea class="form-control" rows="3" id="verifyInfo" name="verifyInfo"></textarea>
                                           </div>
									</div>
								</div>
									<hr>
									<div class="row" align="center">
										<div class="col-xs-12">
											<input type="submit" class="btn btn-primary" value="确定" />
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
		$(document).ready(function() {
			
			$('#myForm').validate_popover({
	            onsubmit:true,
	            rules: {
	            	verifyInfo:{
	            		rangelength: [1, 100]
	            	}
	            },
	            messages: {
	                
	            },
	            submitHandler: function (form) {
	            	submit();
	            }
	        });
	    });
	
		var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
		//关闭窗口并刷新页面
		function closePage(){
			parent.layer.close(index);
		}
		
		function submit(){
			layer.load(2);
			$.ajax({
		      url: '<%=request.getContextPath()%>/admin/suppCredit/suppCreditStatus',
		      dataType: 'json',
		      type: 'POST',
		      data: {
		    	  id: $('#id').val(),
		    	  verifyStatus: $("input[name='verifyStatus']:checked").val(),
		    	  verifyInfo: $("#verifyInfo").val()
		      },
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