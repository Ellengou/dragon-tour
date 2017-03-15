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
				<input type="text" name="id" value="${id }" hidden="true">
				<table class="table">
				   <tbody>
				      <tr>
				         <td>借款人</td>
				         <td>${name }</td>
				      </tr>
				      <tr>
				         <td>借款额度</td>
				         <td>${loanMoney }元</td>
				      </tr>
				      <tr>
				         <td>电子账号</td>
				         <td>${serial_num }</td>
				      </tr>
				   </tbody>
				</table>
				<hr>
				<h3>确认放款?</h3>
				
				<shiro:hasPermission name="userloan:org:fk:save">
				<button type="button" class="btn btn-primary" onclick="save();">确定</button>
				</shiro:hasPermission>
				<button type="button" class="btn btn-primary" onclick="closePage();">取消</button>
			</div>
		</div>
</div>

	<%@ include file="/WEB-INF/views/template/bootMainJs.jsp"%>
	<!-- layer JavaScript -->
	<script>
	//满标审核保存
	function save(){
		layer.msg('数据开始保存....',{offset:50});
		var jsonData = {id:'${id }'};
		$.ajax({
		      url: '<%=request.getContextPath()%>/admin/userloan/saveOrgFk',
		      dataType: 'json',
		      type: 'POST',
		      data: jsonData,
		      success: function (data) {
		    	 if(data.status == 'ok'){
		    		 layer.alert('放款成功', {
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