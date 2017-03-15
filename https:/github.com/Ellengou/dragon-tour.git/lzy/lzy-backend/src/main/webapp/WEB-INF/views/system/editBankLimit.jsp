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
									<div class="row">
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">银行名称</span> 
												<input type="text" class="form-control" id="bankName" name="bankName" value="${bankLimit.bankName}">
												<input type="hidden" class="form-control" id="id" name="id" value="${bankLimit.id}">
											</div>
										</div>
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">类型</span> 
												<select class="form-control" id="type">
	                                            </select>
											</div>
										</div>
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">联系电话</span> 
												<input type="text" class="form-control" id="contactTel" name="contactTel" value="${bankLimit.contactTel}">
											</div>
										</div>
									</div>
									<br>
									<div class="row">
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">单笔限额</span> 
												<input type="text" class="form-control" id="penLimit" name="penLimit" value="${bankLimit.penLimit}">
											</div>
										</div>
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">每日限额</span> 
												<input type="text" class="form-control" id="dayLimit" name="dayLimit" value="${bankLimit.dayLimit}">
											</div>
										</div>
										<div class="col-xs-4">
											<div class="input-group">
												<span class="input-group-addon">每月限额</span> 
												<input type="text" class="form-control" id="monthLimit" name="monthLimit" value="${bankLimit.monthLimit}">
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
			var bankLimitTypeList = $.parseJSON('${bankLimitTypeList}');
			for (var i = 0; i < bankLimitTypeList.length; i++) {
				$(new Option(bankLimitTypeList[i].dicDataName,bankLimitTypeList[i].dicDataValue)).appendTo('#type');
			}
			
			$('#type').val('${bankLimit.type}');
			
			$('#myForm').validate_popover({
	            onsubmit:true,
	            rules: {
	            	bankName: {
	                    required: true
	                },
	                penLimit: {
	                    required: true
	                },
	                dayLimit: {
	                    required: true
	                },
	                monthLimit: {
	                    required: true
	                },
	                contactTel: {
	                    required: true
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
			
			$("#myForm").find("select").each(function() {
				jsonData[$(this).attr('id')] = $(this).val();
			});
			
			$.ajax({
		      url: '<%=request.getContextPath()%>/admin/bankLimit/editBankLimit',
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