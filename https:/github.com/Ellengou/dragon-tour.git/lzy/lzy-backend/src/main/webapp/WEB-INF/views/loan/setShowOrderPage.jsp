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
				<div class="panel panel-default">
					<div class="panel-body">
								<form id="myForm">
									<input type="text" name="id" value="${id }" hidden="true">
									<div class="form-group">
										<label class="col-xs-3 control-label">序号</label>
										<div class="input-group col-xs-8">
											<input type="text" class="form-control" id="showOrder" name="showOrder" autocomplete="off" value="${showOrder }">
										</div>
									</div>
								</form>
								<hr>
								<div class="row" align="center">
									<div class="col-xs-12">
										<button type="button" class="btn btn-primary" onclick="save();">保存</button>
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
		      url: '<%=request.getContextPath()%>/admin/project/loan/setShowOrder',
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