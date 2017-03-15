<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<title>后台管理系统</title>
<!-- Bootstrap Core CSS -->
<link
	href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
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
								<form id="myForm">
									<input type="text" name="id" value="${id }" hidden="true">
									<div class="form-group">
										<label class="col-xs-3 control-label">申请人</label>
										<div class="input-group col-xs-8">
											${frontUserName }
										</div>
									</div>
									<div class="form-group">
										<label class="col-xs-3 control-label">电子账户</label>
										<div class="input-group col-xs-8">
											${emprunt.serial_num }
										</div>
									</div>
									<div class="form-group">
										<label class="col-xs-3 control-label">期数</label>
										<div class="input-group col-xs-8">
											第${repay.period }期
										</div>
									</div>
									<div  class="form-group">
										<label class="col-xs-3 control-label">原还款时间</label>
										<div class="input-group col-xs-8">
											${repayDate }
										</div>
									</div>
									<div  class="form-group">
										<label class="col-xs-3 control-label">应还本金</label>
										<div class="input-group col-xs-8">
											${corpus }
										</div>
									</div>
									<div  class="form-group">
										<label class="col-xs-3 control-label">应还利息</label>
										<div class="input-group col-xs-8">
											${interest }
										</div>
									</div>
								</form>
								<hr>
								<div class="row" align="center">
									<div class="col-xs-12">
									<shiro:hasPermission name="	loan:hk:byhand:save">
										<button type="button" class="btn btn-primary" onclick="save();">还款</button>
									</shiro:hasPermission>
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

	<%@ include file="/WEB-INF/views/template/bootMainJs.jsp"%>
	<!-- layer JavaScript -->
	<script>
	function save(){
		layer.msg('数据开始保存....',{offset:50});
		var jsonData = $("form").serialize();
		$.ajax({
		      url: '<%=request.getContextPath()%>/admin/project/loan/saveRepay',
		      dataType: 'json',
		      type: 'POST',
		      data: jsonData,
		      success: function (data) {
	    	   if(data.status == 'ok'){
	    		 layer.alert('数据保存成功', {
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