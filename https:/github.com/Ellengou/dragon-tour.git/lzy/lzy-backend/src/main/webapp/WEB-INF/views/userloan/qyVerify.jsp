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
								<%@ include file="/WEB-INF/views/userloan/template/userLoanTemplate_0.jsp"%>
								<%@ include file="/WEB-INF/views/userloan/template/userSuppInfoTemplate.jsp"%>
								
									<ul id="myTab" class="nav nav-tabs">
										<li class="active"><a href="#verifySituation">审核情况</a></li>
										<li><a href="#dataProve">资料证明</a></li>
									</ul>
									<div id="myTabContent" class="tab-content">
										<div class="tab-pane fade in active" id="verifySituation">
											<%@ include file="/WEB-INF/views/userloan/template/verifyTemplate.jsp"%>
   										</div>
									   <div class="tab-pane fade" id="dataProve">
									   		<div class="panel panel-default">
											  <div class="panel-heading">
											    <h3 class="panel-title">企业审核上传资料</h3>
											  </div>
											  <div class="panel-body" id = "qyverify">
											  	审核时上传资料!
											  </div>
											</div>
									   </div>
									   <div class="tab-pane fade" id="loanRecord">
									   </div>
									   <div class="tab-pane fade" id="repayment">
									   </div>
									</div>
								<div class="row" align="center">
									<div class="col-xs-12">
									<shiro:hasPermission name="userloan:qy:verify:save">
										<button type="button" class="btn btn-primary" onclick="verify();">审核</button>
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
	<script src="<%=request.getContextPath()%>/bootstrap/js/jquery.min.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<!-- layer JavaScript -->
	<script src="<%=request.getContextPath()%>/bootstrap/plugin/layer/layer.js" type="text/javascript"></script>
	<script>
	
	$(document).ready(function(){
		
		//单独激活每个标签
		$('#myTab a').click(function (e) {
		  e.preventDefault()
		  var $this = $(this);
		  if($this.attr('href') == "#verifySituation"){
		  }else if($this.attr('href') == "#dataProve"){
			  
		  }else if($this.attr('href') == "#loanRecord"){
		  }
		  $this.tab('show')
		});
	
		
	});
	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	//关闭窗口并刷新页面
	function closePage() {
		parent.layer.close(index);
	}
	
	function verify(){
		layer.open({
    	    type: 2,
    	    area: ['600px', '450px'],
    	    offset: [100,(($(window).width()-600)/2)],
    	    title: '输入审核内容',
    	    content: '<%=request.getContextPath()%>/admin/userloan/qyVerifyPage?id=' + '${loan.id}'
    	});
    }
	</script>
</body>
</html>