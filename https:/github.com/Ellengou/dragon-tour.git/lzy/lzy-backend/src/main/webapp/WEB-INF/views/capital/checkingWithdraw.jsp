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
								<div class="row">
									<div class="col-xs-12">
										用户名:${sysUserFront.nickName}
									</div>
								</div>
								<br>
								<div class="row">
									<div class="col-xs-12">
										真实姓名:${name}
									</div>
								</div>
								<br>
								<div class="row">
									<div class="col-xs-12">
										提现金额:${scfWithdraw.withdrawMoney}
									</div>
								</div>
								<br>
								<div class="row">
									<div class="col-xs-12">
										手续费:${scfWithdraw.fee}
									</div>
								</div>
								<br>
								<div class="row">
									<div class="col-xs-12">
										银行名称:${bankName}
									</div>
								</div>
								<br>
								<div class="row">
									<div class="col-xs-12">
										银行账号:${bankNo}
									</div>
								</div>
								<hr>
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
											<label class="input-group-addon">备注</label>
                                           	<textarea class="form-control" rows="3" id="remark"></textarea>
                                           </div>
									</div>
								</div>
								<hr>
								<div class="row" align="center">
									<div class="col-xs-12">
										<input type="hidden" name="id" id="id" value="${scfWithdraw.id}" >
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
		var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
		//关闭窗口并刷新页面
		function closePage() {
			parent.layer.close(index);
		}
		function submit() {
			var url = '';
			if('${scfWithdraw.account}' == '0'){
				url = '<%=request.getContextPath()%>/admin/withdraw/checkLcWithdraw';
			}else{
				url = '<%=request.getContextPath()%>/admin/withdraw/checkDkWithdraw';
			}
			
			$.ajax({
		      url: url,
		      dataType: 'json',
		      type: 'POST',
		      data: {
		    	  id:$("#id").val(),
		    	  verifyStatus:$("input[name='verifyStatus']:checked").val(),
		    	  remark:$("#remark").val()
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