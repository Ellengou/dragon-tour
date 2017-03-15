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
								<br>
								<input type="hidden" id="id" value="${compOrg.id}">
								<div class="row">
									<div class="col-xs-4">
										<div class="input-group">
											<span class="input-group-addon">组织名称</span>
											<input type="text" class="form-control" id="name" name="name" value="${compOrg.name}">
										</div>
									</div>
									<!--
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">负责人</span> 
												<input type="text" class="form-control" id="principal" name="principal" value="${compOrg.principal}">
											</div>
										</div>
										 -->
									<div class="col-xs-4">
										<div class="input-group" data-toggle="tooltip" title = "区号-电话号码">
											<span class="input-group-addon">部门电话</span>
											<input type="text" class="form-control" id="tel" name="tel" value="${compOrg.tel}">
										</div>
									</div>
								</div>
								<%--<br>--%>
								<%--<div class="row">--%>
								<%--<div class="col-xs-12">--%>
								<%--<div class="input-group">--%>
								<%--<span class="input-group-addon">地址</span> --%>
								<%--<input type="text" class="form-control" id="prinAddress" name="prinAddress" value="${compOrg.prinAddress}">--%>
								<%--</div>--%>
								<%--</div>--%>
								<%--</div>--%>
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
		$(function () { $("[data-toggle='tooltip']").tooltip(); });
		
		$.validator.addMethod("phone",function(value,element,params){
			if(!(/^0\d+-\d+$/.test(value))){
				return false;
			}else{
				return true;
			}
		},"请输入正确的手机号码");
		
		$.validator.addMethod("tel",function(value,element,params){
			if(!(/^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/.test(value))){
				return false;
			}else{
				return true;
			}
		},"请输入正确的座机号码");

		$('#myForm').validate_popover({
			onsubmit:true,
			rules: {
				name: {
					required: true
				},
				tel: {
					required: true,
					tel: true
//	                },
//	                prinAddress: {
//	                	required: true
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
	function closePage() {
		parent.layer.close(index);
	}

	function submit() {
		//将form表单参数组成json
		var jsonData = {};
		$("#myForm").find("input").each(function() {
			jsonData[$(this).attr('id')] = $(this).val();
		});

		$.ajax({
			url: '<%=request.getContextPath()%>/admin/compOrg/editCompOrg',
			dataType: 'json',
			type: 'POST',
			data: jsonData,
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