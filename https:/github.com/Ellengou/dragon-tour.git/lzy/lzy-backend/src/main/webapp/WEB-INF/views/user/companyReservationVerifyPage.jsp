<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<title>后台管理系统</title>
<%@ include file="/WEB-INF/views/template/validator.jsp"%>
<!-- Bootstrap Core CSS -->
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
					<div class="panel-heading">
				      <h3 class="panel-title">审核</h3>
				   </div>
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-12">
								<form id="myForm">
									<input type="text" name="id" value="${company.id }" hidden="true">
									<div class="row">
										<div class="col-xs-3">
											<div class="input-group">
												<span class="input-group-addon">公司名称</span>
												<input type="text" class="form-control" value="${company.compName }" disabled="disabled">
											</div>
										</div>
										<div class="col-xs-3">
											<div class="input-group">
												<span class="input-group-addon">法人代表</span>
												<input type="text" class="form-control" value="${company.lealPerson }" disabled="disabled">
											</div>
										</div>
										<div class="col-xs-3">
											<div class="input-group">
												<span class="input-group-addon">公司邮箱</span>
												<input type="text" class="form-control" value="${company.compEmail }" disabled="disabled">
											</div>
										</div>
										<div class="col-xs-3">
											<div class="input-group">
												<span class="input-group-addon">社会信用代码</span>
												<input type="text" class="form-control" value="${company.creditCode }" disabled="disabled">
											</div>
										</div>
									</div>
									<br />
									<div class="row">
										<div class="col-xs-3">
											<div class="input-group">
												<span class="input-group-addon">公司座机</span>
												<input type="text" class="form-control" value="${company.compTel }" disabled="disabled">
											</div>
										</div>
										<div class="col-xs-3">
											<div class="input-group">
												<span class="input-group-addon">联系人姓名</span>
												<input type="text" class="form-control" value="${company.contPerson }" disabled="disabled">
											</div>
										</div>
										<div class="col-xs-3">
											<div class="input-group">
												<span class="input-group-addon">联系人手机</span>
												<input type="text" class="form-control" value="${company.contPhone }" disabled="disabled">
											</div>
										</div>
									</div>
									<br />
									<div class="panel panel-default">
										<div class="panel-body">
											<div class="row">
												<div class="col-xs-6">
													<div class="input-group">
														<span class="input-group-addon">状态</span>
														<div class="form-control" id = "div_verifyStatus">
														</div>
													</div>
												</div>
											</div>
											<%-- <br />
											<div class="row">
												<div class="col-xs-12">
													<div class="input-group">
														<span class="input-group-addon">原因</span>
														<textarea class="form-control" rows="2" id = "verifyReson" name="verifyReson">${company.verifyReson }</textarea>
													</div>
												</div>
											</div> --%>
										</div>
									</div>
									<div class="panel panel-default" id = "extInfo">
										<div class="panel-body">
											<div class="row">
												<div class="col-xs-3">
													<div class="input-group">
														<span class="input-group-addon">登录用户名</span>
														<input type="text" class="form-control rule" name="registerName" id = "registerName">
													</div>
												</div>
												<div class="col-xs-3">
													<div class="input-group">
														<span class="input-group-addon">登录密码</span>
														<input type="text" class="form-control rule" name="compPwd" id = "compPwd">
													</div>
												</div>
											</div>
											<br />
											<div class="row">
												<div class="col-xs-12">
													<div class="input-group" >
														<span class="input-group-addon" style="height: 60px">经营范围</span>
														<div class="form-control" style="height: 60px" id="compTradeData">
														</div>
													</div>
												</div>
											</div>
											<br />
											<div class="row">
												<div class="col-xs-12">
													<div class="input-group">
														<span class="input-group-addon">公司地址</span>
														<input type="text" class="form-control rule" name="compAddress" id = "compAddress">
													</div>
												</div>
											</div>
										</div>
									</div>
								<div class="row" align="center">
									<div class="col-xs-12">
									<shiro:hasPermission name="company:check">
										<button type="submit" class="btn btn-primary">保存</button>
									</shiro:hasPermission>
										<button type="button" class="btn btn-primary" onclick="closePage();">关闭</button>
									</div>
								</div>
								</form>
								<hr>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="<%=request.getContextPath()%>/bootstrap/js/util.js" type="text/javascript"></script>
	<!-- layer JavaScript -->
	<script>
	$("#div_verifyStatus").showList('radio',{infoList:'${veriryStatusList}',name:'verifyStatus'})
	$("#compTradeData").showList('checkbox',{infoList:'${businessList}',name:'compTrade',column_value:'id',lableClass:'checkbox-inline',blank:'&nbsp&nbsp&nbsp&nbsp&nbsp',selectFirst:false})
	function save(){
		layer.msg('数据开始保存....',{offset:50});
		var jsonData = $("form").serializeArray();
		$.ajax({
		      url: '<%=request.getContextPath()%>/admin/company/checkCompanyFront',
		      dataType: 'json',
		      type: 'POST',
		      data: jsonData,
		      success: function (data) {
		    	 if(data.status == 'ok'){
		    		 layer.alert('审核数据保存成功', {
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
	
	function setValidate(){
		$('#myForm').validate_popover({
            onsubmit:true,
            popoverPosition: 'right',
            rules: {
            	registerName:"required",
            	compPwd:"required"
            },
            submitHandler: function (form) {
                save();
            }
        });
	}
	$(document).ready(function(){
		setValidate();
		  $("#div_verifyStatus input[type='radio']").change(function(){
			  $this = $(this).val();
			  if('2' == $this){
				  $(".rule").rules("remove");
				  $(".error-popover").hide();
				  $("#extInfo").hide();
			  }else{
				  $(".rule").rules("add",{required:true});
				  $("#extInfo").show();
			  }
		  })
		});
	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	//关闭窗口并刷新页面
	function closePage() {
		parent.layer.close(index);
	}
	</script>
</body>
</html>